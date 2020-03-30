.model small 
.stack 100h 
.data  

Texto  DB "Please, enter a 16 bit numberin binary: $" 
varc1  DW ?  
var    DW ?
varneg DW ?
varsm  DW ?  
Maximo DB 17,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?  ;16 numeros posibles
count  DB 2h        ;inicio numeros                    
mask   DW 1000000000000000b

.code 
Inicio:    
    mov ax, @data    
    mov ds, ax   
    xor ax, ax
    
    mov ah, 09h     
    lea dx, Texto 
    int 21h         ;mostrar texto por pantalla
    
        
    mov ah, 0Ah     
    lea dx, Maximo    
    int 21h  
             
    xor cx,cx 
    xor bx,bx   
    xor ax,ax  
    xor dx,dx
    mov cl, Maximo[1] ;numero de caracteres insertados


    mov bl, count 
    
    bucle:
        shl ax, 1    
        mov dl, Maximo[bx]
        sub dl, 30h
        add al, dl
        inc bl
    loop bucle              
    
    mov var, ax
    not ax
    mov varc1, ax  
    
    
    mov ax, var
    xor ax, mask
    mov varsm, ax 
                                 

    mov ah,4Ch
    int 21h 
END Inicio 