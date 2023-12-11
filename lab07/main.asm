section .data
    n: db 10
section .bss
    buf1: resb 80
    buf2: resb 3
section .text
    global _start
_start:

    mov eax, 3
    mov ebx, 0
    mov ecx, buf1
    mov edx, 80
    int 80h


bit:
    mov ecx, 0
    mov esi, buf1 ; в esi записываем адрес входного буфера
    dec esi
lp1:
    inc esi
    mov al, [esi] ; в al первый символ из buf1
    cmp al, 10 ; конец строки?
    je end
    sub al, 48
    cmp al,0 ; является ли
    jb lp1 ; символ цифрой,
    cmp al,9 ; иначе переход
    ja lp1 ; на метку end
    mov cl,al
    mov edx, 1
    shl edx, cl ; сдвиг единичного бита на значение
    or eax, edx ; регистра cl, и запись в buf2
    
    call convert_and_print

    jmp lp1 ; переход к следующему символу
convert_and_print:
    xor ebp,ebp
.divide:
	xor ebx,ebx
	mov bl,2d

	xor edx,edx
	div ebx

	add dl,"0"
	push dx
	inc ebp
	cmp eax,0
	jnz .divide

	mov edi, 0
.reverse:
	pop ax
	mov BYTE [buf1], al
	inc edi

	mov eax,4
	mov ebx,1
	mov ecx,buf1
	mov edx, 1
	int 80h

	cmp edi,ebp
	jne .reverse

.end_convert:
	mov eax,4
	mov ebx,1
	mov ecx, n
	mov edx,1
	int 80h
    ret
end:
    mov eax, 1
    mov ebx, 0
    int 80h
    