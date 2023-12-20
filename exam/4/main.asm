section .data
    num1: dd 5  ; первое число
    num2: dd 7  ; второе число
    result: dd 0  ; переменная для хранения результата

section .text
    global _start

_start:
    ; загрузка первого числа в регистр eax
    mov eax, [num1]
    ; умножение на второе число
    imul eax, [num2]
    ; сохранение результата
    add eax,"0"
    mov [result], eax

    mov eax, 1                    ; вызов функции sys_exit
    xor ebx, ebx                  ; код возврата 0
    int 0x80                      ; вызов системного вызова 