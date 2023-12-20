section .data
    num1 dd 1  ; первое число
    num2 dd 1 ; второе число
    result dd 0  ; переменная для хранения результата

section .text
    global _start

_start:
    mov eax, [num1]
    add eax, [num2]
    add eax, "0"
    mov [result], eax

    mov eax, 4                  ; вызов функции sys_write
    mov ebx, 1 
    mov ecx, result
    mov edx, 4                  ; количество байт для вывода (4 байта для int)
    int 0x80                    ; вызов системного вызова

    ; Выход из программы
    mov eax, 1                  ; вызов функции sys_exit
    xor ebx, ebx                ; код возврата 0
    int 0x80                    ; вызов системного вызова