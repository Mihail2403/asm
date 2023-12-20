section .data
    radius: dd 5.0          ; заданный радиус круга (замените на свое значение)
    pi: dd 3.14
section .bss
    area resd 1            ; переменная для хранения площади круга

section .text
    global _start

_start:
    
    mov eax, 1              ; вызов функции sys_exit
    xor ebx, ebx            ; код возврата 0
    int 0x80                ; вызов системного вызова