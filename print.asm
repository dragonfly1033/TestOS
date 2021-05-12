
print_string16:
    pusha

    mov ah, 0x0E

    jmp loop

    nl:
        mov al, 0x0a
        int 0x10
        mov al, 0x0d
        jmp loop_print


    loop:
        mov al, [si]
        inc si
        cmp al, 0
        je end
        cmp al, '\'
        je nl
    loop_print:
        int 0x10
        jmp loop
end:
    popa
    ret

