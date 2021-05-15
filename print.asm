
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

print_hex16:
    pusha

    mov cl, 0
    mov bx, 0x0009

    hex_loop:

        mov dx, 0xF000
        shr dx, cl
        and dx, si

        push cx
        mov ch, 12
        sub ch, cl
        mov cl, ch
        shr dx, cl
        pop cx

        cmp dx, bx
        jg letters
        numbers:
            add dx, 0x0030
            jmp back
        letters:
            add dx, 0x0037
            jmp back
        back:
            mov al, dl
            mov ah, 0x0E
            int 0x10
            add cl, 4
            cmp cl, 16
            je end_loop
            jmp hex_loop
    end_loop:
        mov al, '\'
        int 0x10
        popa
        jmp $
    