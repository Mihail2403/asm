section .data
    str1: db 'Hello', 0     ; первая строка (замените на свою строку)
    str2: db 'Hello', 0     ; вторая строка (замените на свою строку)
    
    eq: db 'Equal', 10
    eq_len: equ $-eq

    n_eq: db 'Non Equal', 10
    n_eq_len: equ $-n_eq

section .text
    global _start

_start:
    ; Загрузка адресов строк в регистры esi и edi
    mov esi, str1          
    mov edi, str2          

; Сравнение строк
compare_loop:
    mov al, [esi]      
    cmp al, [edi]     

    jne strings_not_equal  ; если символы не равны, переходим к метке strings_not_equal

    cmp al, 0           
    je strings_equal    

    inc esi             
    inc edi             
    jmp compare_loop    

; Обработка, если строки не равны
strings_not_equal:
    mov eax, 4
    mov ebx, 1
    mov ecx, n_eq
    mov edx, n_eq_len
    int 0x80
    jmp end
strings_equal:
    mov eax, 4
    mov ebx, 1
    mov ecx, eq
    mov edx, eq_len
    int 0x80
; Выход из программы
end:
    mov eax, 1             ; вызов функции sys_exit
    xor ebx, ebx           ; код возврата 0
    int 0x80               ; вызов системного вызова 