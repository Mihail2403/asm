section .data
    question: DB 'It is noon? (y/n) '
    questionLen: EQU $-question
    
    answerYes: DB 'y', 10
    answerYesLen: EQU $answerYes

    morning: DB 'Good Morning', 10
    morningLen: EQU $-morning

    day: DB 'good day', 10
    dayLen: EQU $-day

section .bss
    cin: RESB 1

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, question
    mov edx, questionLen
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, cin
    mov edx, 1
    int 80h

    mov cl, [answerYes]
    cmp cl, [cin]
    je yes
    jne no

yes:
    mov eax, 4
    mov ebx, 1
    mov ecx, day
    mov edx, dayLen
    int 80h
    
    mov eax, 1
    mov ebx, 0
    int 80h

no:
    mov eax, 4
    mov ebx, 1
    mov ecx, morning
    mov edx, morningLen
    int 80h
    
    mov eax, 1
    mov ebx, 0
    int 80h