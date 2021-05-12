PROGRAM_SPACE equ 0x7E00


load_disk:
    pusha

    push dx
    
    mov ah, 0x02
    mov al, dh
    mov cl, 0x02
    mov ch, 0x00
    mov dh, 0x00

    int 0x13
    jc disk_error

    pop dx
    cmp al, dh
    jne sector_error

    popa
    ret

disk_error:
    mov si, DISK_ERROR
    call print_string16
    jmp $

sector_error:
    mov si, SECTOR_ERROR
    call print_string16
    jmp $

DISK_ERROR: db "Disk Error", 0
SECTOR_ERROR: db "Sector Error", 0

