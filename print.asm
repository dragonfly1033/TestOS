
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

    mov cl, 0           ; character number
    mov bx, 0x0009      ; boundary value

    hex_loop:

        mov dx, 0xF000  ; selection value
        shr dx, cl      ; shift selection value to correct character number
        and dx, si      ; select character

        push cx
        mov ch, 12      ;
        sub ch, cl      ; shift selected character to end of hex word   
        mov cl, ch      ; by shifting by (12 - character number)
        shr dx, cl      ;
        pop cx

        cmp dx, bx      ; if character is greater than 9 then it is a letter
        jg letters
        numbers:
            add dx, 0x0030  ; convert hex value to ascii code (numbers)
            jmp back
        letters:
            add dx, 0x0037  ; convert hex value to ascii code (letters)
            jmp back
        back:
            mov al, dl      
            mov ah, 0x0E
            int 0x10        ; print ascii code
            add cl, 4       ; next character
            cmp cl, 16      ; if end of word (4 characters * 4 bits)
            je end_loop     ; end loop
            jmp hex_loop
    end_loop:    
        popa
        jmp $
    