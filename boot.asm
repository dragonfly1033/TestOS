[bits 16]
[org 0x7C00]

xor  ax, ax         ; clear ax to 0
mov  ds, ax         ; set data segment register to 0
mov  es, ax         ; set extra segment register to 0x0000

mov [BOOT_DISK], dl
mov ax, 0x06C0
cli                 ; disable interrupts
mov  ss, ax         ; set stack segment register to 0
mov  sp, 0x1000     ; set stack pointer register to 0x7e00
sti                 ; enable interrupts


jmp 0x0000:start



start:

    mov si, WELCOME_MESSAGE
    call print_string16

    mov si, _16BIT_MESSAGE
    call print_string16

    mov si, DISK_MESSAGE
    call print_string16

    mov bx, KERNEL_OFFSET
    mov dl, [BOOT_DISK]
    mov dh, 1
    call load_disk  

    mov si, [KERNEL_OFFSET]
    call print_hex16

    jmp $

%include "print.asm"
%include "disk.asm"  


DISK_MESSAGE: db 'Loading Disk\',0
WELCOME_MESSAGE: db '\Booting Test OS\',0
_16BIT_MESSAGE: db '16 bit real mode\',0
KERNEL_OFFSET equ 0x1000
BOOT_DISK: db 0

times 510-($-$$) db 0
dw 0xaa55

times 256 dw 0xdada
