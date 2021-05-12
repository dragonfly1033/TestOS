[bits 16]
[org 0x7C00]

xor  ax, ax         ; clear ax to 0
mov  ds, ax         ; set data segment register to 0
mov  es, ax         ; set extra segment register to 0
cli                 ; disable interrupts
mov  ss, ax         ; set stack segment register to 0
mov  sp, 0x8000     ; set stack pointer register to 0x8000
sti                 ; enable interrupts


start:
    mov si, WELCOME_MESSAGE
    call print_string16

    mov si, _16BIT_MESSAGE
    call print_string16

    mov si, DISK_MESSAGE
    call print_string16

    call load_disk

    mov si, PROGRAM_SPACE
    call print_string16

    jmp $   

%include "print.asm"
%include "disk.asm"  


DISK_MESSAGE: db 'Loading Disk\',0
WELCOME_MESSAGE: db '\Booting Test OS\',0
_16BIT_MESSAGE: db '16 bit real mode\',0
KERNEL_OFFSET equ 0x1000
PROGRAM_SPACE equ 0x7E00


times 510-($-$$) db 0
dw 0xaa55

dw 0x4241
times 510 db 0
