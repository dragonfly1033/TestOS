[org 0x7C00]

mov bp, 0x8000
mov sp, bp


start:
    mov si, WELCOME_MESSAGE
    call print_string16

    mov si, _16BIT_MESSAGE
    call print_string16

    mov si, DISK_MESSAGE
    call print_string16


    jmp $   

%include "print.asm"
%include "disk.asm"  


DISK_MESSAGE: db 'Loading Disk\',0
WELCOME_MESSAGE: db '\Booting Test OS\',0
_16BIT_MESSAGE: db '16 bit real mode\',0


times 510-($-$$) db 0
dw 0xaa55

