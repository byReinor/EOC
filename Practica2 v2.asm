.model small
.stack 100h
.data 
    text1 DB 13, 10,"Insert a 16 bit number: ", '$' 
    text2 DB 13, 10,"The C1 value is: ", '$'
    text3 DB 13, 10,"The value in sign-magnitude is: ", '$'  
    input DB 17, ?, 17 dup('?') 
    varc1 DB 16 dup(?), '$'
    varsm DB 16 dup(?), '$'
.code
inicio:   
    mov ax, @data
    mov ds, ax
    xor ax, ax
                
    lea dx, text1
    mov ah, 9h
    int 21h
    
    ;read the 16 bit number
    xor dx, dx
    lea dx, input
    mov ah, 0Ah
    int 21h
    
    ;store the c1 number in varc1
    mov cx, 16
    
    
    lea si, input ;load effective address of input in source index register
    add si, 2     ;point to the 3rd position of the input array (where the binary number starts)
    
    lea bx, varc1
    loop1:       
       
       if: 
        cmp [si], '1' 
        jne else      ;jump to else if [si] is not equal to '1'
        mov [bx], '0' ;if [si] is equal to '1', store '0' in the correspondent position of varc1
        jmp endif
       else:
        mov [bx], '1' ;if [si] is equal to '0', store '1' in the correspondent position of varc1
       endif:
       
       inc si
       inc bx
    loop loop1            
    
    ;display text2
    xor dx, dx
    lea dx, text2
    mov ah, 9h
    int 21h
    
    ;display varc1
    xor dx, dx
    lea dx, varc1
    int 21h
    
    ;Store the sign magnitude number in varsm
    lea si, input
    add si, 2
    
    xor bx, bx
    lea bx, varsm
    
    ;change the value of the first bit to change the sign
    if2:
        cmp [si], '1'
        jne else2
        mov [bx], '0'
        jmp endif2
    else2:
        mov [bx], '0'
    endif2:    
    
    ;copy the rest of the bits of input into varsm
    mov cx, 15
    loop2:
        inc si
        inc bx 
        mov al, [si]
        mov [bx], al
    loop loop2
    
    ;display text3
    xor dx, dx
    lea dx, text3
    mov ah, 9h
    int 21h
    
    ;display varsm
    xor dx, dx
    lea dx, varsm
    int 21h
    
    mov ah, 4ch
    int 21h

END inicio