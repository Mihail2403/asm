section .data
    ; Задаем значения для регистров
    value1 dd 10         ; значение первого регистра (задайте свои значения)
    value2 dd 20         ; значение второго регистра (задайте свои значения)

section .text
    global _start

_start:
    ; Обмен значениями между регистрами eax и ebx
    mov eax, dword [value1]    ; загружаем значение первого регистра в eax
    mov ebx, dword [value2]    ; загружаем значение второго регистра в ebx

    push eax
    mov eax, ebx
    pop ebx

    mov eax, 1                  ; вызов функции sys_exit
    xor ebx, ebx                ; код возврата 0
    int 0x80                    ; вызов системного вызова