PROGRAM_SPACE equ 0x7E00


load_disk:
    pusha

    push dx

    mov [SECTORS], dh       ; save sectors to read in variable

    mov dl, [BOOT_DISK]    ; dl <- drive no. assigned by BIOS
    mov cl, 0x02            ; start read at this sector no.
    mov ch, 0x00            ; cylinder no. 
    mov dh, 0x00            ; head no.

    set_counter:
        mov di, 5               ; try counter

    try:                    ; try disk read 5 times
        mov al, [SECTORS]      ; no. of sectors to read after start sector cl
        mov ah, 0x02    ; disk read mode
        int 0x13        ; disk interrupt
        jc reset        ; fail reset and retry

        sub [SECTORS], al   ; check remaining sectors
        jz ready            ; exit loop
        mov cl, 0x01        ; start read at sector 1
        xor dh, 1           ; toggle head no. between 1 and 0
        jnz set_counter     
        inc ch              ; next cylinder
        jmp set_counter

    reset:
        mov ah, 0x00    ; reset disk
        int 0x13
        dec di          ; di -= 1
        jnz try
        jmp disk_error
    
    ready:
        pop dx 
        cmp al, dh
        jne sector_error    ; dh must equal al (sector numbers)

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
SECTORS equ 0

