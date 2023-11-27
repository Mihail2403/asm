section .data
    req: DB 'Input string: '
    reqLen: EQU $-req
    retstr: DB '', 10
    retlen: EQU $-retstr
section .bss
    string: resb 80
    invString: resb 80
section .text
    global _start
_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, req
    mov edx, reqLen
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, string
    mov edx, 80
    int 80h

    mov ecx, edx
    mov esi, string
PushStrToStack:
    mov al, byte [esi]
    cmp al, 10
    je endOfPushStr
    push ax

    inc esi
    loop PushStrToStack

endOfPushStr:
    mov ecx, edx
    mov esi, invString

GetStrOfStack:
    pop ax
    cmp al, 0
    je endOfPop
    mov byte[esi], al
    inc esi
    loop GetStrOfStack

endOfPop:
    mov eax, 4
    mov ebx, 1
    mov ecx, invString
    mov edx, 80
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, retstr
    mov edx, retlen
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80h