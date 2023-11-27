section .bss
    sym: resb 80

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

    mov eax, 1
    mov edx, 0
    int 80h