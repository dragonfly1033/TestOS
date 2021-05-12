
load_disk:
    pusha

    push dx

    mov dh, 1

    mov dl, 0x80;[BOOT_DRIVE]    ; dl <- drive no. assigned by BIOS
    mov al, dh              ; no. of sectors to read after start sector cl
    mov cl, 0x02            ; start read at this sector no.
    mov ch, 0x00            ; cylinder no. 
    mov dh, 0x00            ; head no.

    mov di, 5

    try:
        mov si, TRY_MESSAGE
        call print_string16
        
        mov ah, 0x02    ; disk read mode
        int 0x13
        jc reset

    reset:
        mov ah, 0x00
        int 0x13
        dec di
        jnz try
        jmp disk_error

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
TRY_MESSAGE: db 'Disk Read Attempt\',0

