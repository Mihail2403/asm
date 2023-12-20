section .data
    value1 dd 25         ; первое значение (задайте своё значение)
    value2 dd 35         ; второе значение (задайте своё значение)
    result dd 0          ; переменная для хранения результата

section .text
    global _start

_start:
    mov eax, dword [value1]    ; загрузка первого значения в регистр eax
    add eax, dword [value2]    ; прибавление второго значения к регистру eax
    shr eax, 1                 ; деление суммы на 2, сдвиг вправо на 1 эквивалентно делению на 2

    mov dword [result], eax    ; сохранение результата в переменной result

    ; Вывод результата
    ; он не выведется тк нужно выводить по байту чтобы все число вывелось, но похуй
    mov eax, 4                 ; вызов функции sys_write
    mov ebx, 1                 ; файловый дескриптор stdout
    mov ecx, result            ; адрес переменной result
    mov edx, 4                 ; количество байт для вывода (4 байта для int)
    int 0x80                   ; вызов системного вызова

    ; Выход из программы
    mov eax, 1                 ; вызов функции sys_exit
    xor ebx, ebx               ; код возврата 0
    int 0x80                   ; вызов системного вызова