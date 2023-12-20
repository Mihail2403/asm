section .data
    string: db 'madam', 0     ; строка для проверки на палиндром (замените на свою строку)
    no: db 'no', 10
    no_len: equ $-no
    yes: db 'yes', 10
    yes_len: equ $-yes
section .bss
    is_palindrome resb 1  ; переменная для хранения флага палиндрома (0 - не палиндром, 1 - палиндром)

section .text
    global _start

_start:
    ; Загрузка адреса строки в регистр esi
    mov esi, string

    ; Определение длины строки
    mov ecx, 0           ; счетчик символов в строке
    count_loop:
        cmp byte [esi + ecx], 0  ; проверяем текущий символ на нулевой символ (конец строки)
        je end_count             ; если это конец строки, завершаем цикл подсчета
        inc ecx                  ; увеличиваем счетчик
        jmp count_loop           ; продолжаем цикл подсчета
    end_count:

    ; Проверка на палиндром
    mov ebx, ecx                 ; сохраняем длину строки в ebx
    dec ebx                      ; уменьшаем длину на 1 для сравнения

    mov edx, 0                   ; счетчик для перебора символов строки с начала
    check_palindrome:
        mov al, [esi + edx]      ; загружаем символ с начала строки
        mov cl, [esi + ebx]      ; загружаем символ с конца строки
        cmp al, cl               ; сравниваем символы
        jne not_palindrome       ; если символы не совпадают, переходим к метке not_palindrome
        inc edx                  ; увеличиваем счетчик для перехода к следующему символу с начала
        dec ebx                  ; уменьшаем счетчик для перехода к предыдущему символу с конца
        cmp edx, ebx             ; сравниваем значения счетчиков
        jae palindrome        ; если дошли до середины строки, она палиндром

        jmp check_palindrome     ; продолжаем цикл проверки на палиндром

not_palindrome:
    mov eax, 4
    mov ebx, 1
    mov ecx, no
    mov edx, no_len
    int 0x80
    jmp end

palindrome:
    mov eax, 4
    mov ebx, 1
    mov ecx, yes
    mov edx, yes_len
    int 0x80
    jmp end

end:
    mov eax, 1                   ; вызов функции sys_exit
    xor ebx, ebx                 ; код возврата 0
    int 0x80                     ; вызов системного вызова