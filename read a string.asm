.model small
.stack 100h 

print macro text        ;print a text
    xor dx, dx
    lea dx, text
    mov ah, 9h
    int 21h
endm

exit macro              ;exit the program
    mov ah, 4ch
    int 21h
endm 
        
.data
    text DB 13, 10, "Input a string (max length 150): ", '$'
    text2 DB 13, 10, 13, 10, "The input text is: ", '$'
    string1 DB 151 dup('$') ;create a, array with the '$' character duplicated 151 times 
.code
main:  
    mov ax, @data
    mov ds, ax
    xor ax, ax 
    
    lea si, string1     ;load the string1 in the source index register (the si points to the first character of the string)
    
    print text
    
    while:
        mov ah, 1h      ;read a character
        int 21h       
        
        cmp al, 13      ;compare the readed character with 13 (carriage return), if true the zero flag will be setted to 1 (ZF=1)
        je endwhile     ;(je = jump equals)jump to endwhile if the zero flag equals to 1 (ZF=1)
            
        mov [si], al    ;move the readed character to the pointed character in the string by the si register
        inc si          ;point to the next character in the string
        jmp while       ;jump to while, repeat the loop
        
    endwhile: 
    
    
    print text2
    print string1   
    
    exit
END main