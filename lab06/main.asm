section .data
    n: DB '', 10
    s: DB ' '
section .bss
    sym: resb 80
    symCode: resb 80
section .text
    global _start
_start:

    mov eax, 3
    mov ebx, 0
    mov ecx, sym
    mov edx, 1
    int 80h


    mov eax, 4
    mov ebx, 1
    mov ecx, sym
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, s
    mov edx, 1
    int 80h

    mov eax, [sym]
    call ConvertNum

    mov eax, 4
    mov ebx, 1
    mov ecx, symCode
    mov edx, 80
    int 80h
    
    mov eax, 4
    mov ebx, 1
    mov ecx, n
    mov edx, 1
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80h

ConvertNum:
    convert:
        xor ecx,ecx
        xor ebx,ebx
        mov bl,10
    .divide:
        xor edx,edx 
        div ebx 
        add dl, `0`
        push dx
        inc ecx 
        cmp eax,0 
        jnz .divide 

    mov edi, 0
    .reverse:
        pop ax 
        mov BYTE [symCode+edi], al
        inc edi
        cmp edi, ecx
        jne .reverse
    ret