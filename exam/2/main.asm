section .data
    number: dd 8    ; число для проверки (задайте своё значение)
    even_msg: db "Число четное", 10  ; сообщение о четности числа
    even_msg_len: equ $-even_msg    ; длина сообщения

    odd_msg: db "Число нечетное", 10 ; сообщение о нечетности числа
    odd_msg_len: equ $-odd_msg     ; длина сообщения
section .text
    global _start

_start:
    mov eax, dword [number]   ; загрузка числа из памяти в регистр eax
    mov ebx, 2
    div ebx
    cmp edx, 0
    je even                   ;если остаток от деления на 2 == 0, то число четное
    
    mov eax, 4                ; вызов функции sys_write
    mov ebx, 1                ; файловый дескриптор stdout
    mov ecx, odd_msg         ; адрес сообщения о четности
    mov edx, odd_msg_len     ; длина сообщения
    int 0x80                  ; вызов системного вызова

    jmp end_program           ; завершение программы

even:
    ; Вывод сообщения о четности числа
    mov eax, 4                ; вызов функции sys_write
    mov ebx, 1                ; файловый дескриптор stdout
    mov ecx, even_msg          ; адрес сообщения о нечетности
    mov edx, even_msg_len      ; длина сообщения
    int 0x80                  ; вызов системного вызова

end_program:
    ; Выход из программы
    mov eax, 1                ; вызов функции sys_exit
    xor ebx, ebx              ; код возврата 0
    int 0x80                  ; вызов системного вызова
