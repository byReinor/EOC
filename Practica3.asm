.model small
.stack 100h 

print macro text        ;print a text
    xor dx, dx
    lea dx, text
    mov ah, 9h
    int 21h
endm 

readStrings macro str1, str2
    
    lea si, str1
    mov cl, 2h
    for1: 
        print text
        while1:
            mov ah, 1h      ;read a character
            int 21h       
        
            cmp al, 13      ;compare the readed character with 13 (carriage return), if true the zero flag will be setted to 1 (ZF=1)
            je endwhile1    ;(je = jump equals)jump to endwhile if the zero flag equals to 1 (ZF=1)
            
            mov [si], al    ;move the readed character to the pointed character in the string by the si register
            inc si          ;point to the next character in the string
            jmp while1       ;jump to while, repeat the loop
        
        endwhile1:
        xor si, si
        lea si, str2
        dec cl
        jnz for1
endm

lengthStr1 macro str        ;stores in ah the length of a string
    xor cx, cx
    lea si, str
    
    while2:
        cmp [si], '$'
        je endwhile2
        inc si
        inc cl
        jmp while2    
    endwhile2: 
    mov ah, cl
    
endm    

lengthStr2 macro str        ;stores in al the length of a string
    xor cx, cx
    lea si, str
    
    while3:
        cmp [si], '$'
        je endwhile3
        inc si
        inc cl
        jmp while3    
    endwhile3: 
    mov al, cl
    
endm

compareStrings macro str1, str2 
    xor ax, ax
    lea si, str1
    lea di, str2
    
    for2:
        if2: 
            mov bl, [si]
            cmp bl, [di]
            je equal
            
            ;not equal
            inc ah
            jmp endIf2
            
            equal:
            inc al   
        
        endIf2:
        
        inc si
        inc di
        dec cl
        jnz for2
        

endm

exit macro              ;exit the program
    mov ah, 4ch
    int 21h
endm 
        
.data
    text DB 13, 10, "Input a string (max length 150): ", '$' 
    text2 DB 13,10, "Equal characters: ", '$'
    text3 DB 13, 10, "Different characters: ",'$'
    
    string1 DB 151 dup('$') ;create an array with the '$' character duplicated 151 times
    string2 DB 151 dup('$') ;create an array with the '$' character duplicated 151 times 

.code
main:  
    mov ax, @data
    mov ds, ax
    xor ax, ax 
    
    
    readStrings string1, string2  
    
    lengthStr1 string1      ;store the length of string1 in ah              
    
    lengthStr2 string2      ;store the length of string2 in al             
    
    
    if1:
        cmp ah, al
        jg  string1IsLonger
    
        ;String2 is longer
        mov cl, al
        jmp endif1
        
        string1IsLonger:
        mov cl, ah
    endif1:
        
    compareStrings string1 string2
    
    print text2
    
    mov dl, al
    add dl, '0'
    push ax
    mov ah, 2h
    int 21h
    
    pop ax
    print text3
    mov dl, ah 
    add dl, '0'
    mov ah, 2h
    int 21h
    
    exit
END main