section .data
    format: db 'Current Unix Timestamp: '
    n: db 10
    point: db '.'
    double_point: db ':'
    spase: db ' '
section .bss
    temp: resb 4
    cursor: resb 4
    curtime: resb 4   ; переменная для хранения текущего времени
    years: resb 4
    months: resb 4
    days: resb 4
    hours: resb 4
    mins: resb 4
    secs: resb 4

section .text
    global _start

_start:
    ; Получение текущего времени
    mov eax, 4 
    mov ebx, 1             
    mov ecx, format      
    mov edx, 27            
    int 0x80  

        
    mov eax, 0xc9      ; номер системной функци
    mov edi, curtime     ; адрес переменной для получения времени
    syscall

    xor ecx, ecx
    mov eax, dword [curtime]
    .pushDate:
        mov ebx, 60
        
        xor edx, edx
        div ebx
        mov dword [secs], edx; sec
        mov ecx, secs
        
        xor edx, edx
        div ebx
        mov dword [mins], edx ; min

        mov ebx, 24
        xor edx, edx
        div ebx
        mov dword [hours], edx ; hours

        mov ebx, 30
        xor edx, edx
        div ebx
        mov dword [days], edx; days

        mov ebx, 12
        xor edx, edx
        div ebx
        mov dword [months], edx ; months

        mov dword [years], eax ; years

        ; не работает это надо было вывести, но время уже 22.00, а я уже 12 часов решаю эту мразь
        ; надо будет сами выбедете мне похуй
        xor edx, edx
        mov eax, years
        add eax, 1970d
    .convertAndPrint:
        xor edx, edx
        mov ebx, 10d
        div ebx
        mov dword [temp], eax
        
        add edx, "0"
        mov eax, 4
        mov ebx, 1
        mov dword [cursor], edx
        mov ecx, cursor
        mov edx, 4
        int 0x80

        mov eax, dword [temp]
        cmp eax, 0
        jne .convertAndPrint

        mov eax, 4
        mov ebx, 1
        mov ecx, point
        mov edx, 1
        int 0x80
 
exit:
    mov eax, 4
    mov ebx, 1
    mov ecx, n
    mov edx, 1
    int 0x80
    
    mov eax, 1             ; вызов функции sys_exit
    xor ebx, ebx           ; код возврата 0
    int 0x80