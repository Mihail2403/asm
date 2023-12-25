SECTION .data
	magic1 equ 0xfee1dead
	magic2 equ 672274793
	cmd equ 0x01234567
SECTION .text
	global _start
_start:
	mov eax, 88
	mov ebx, magic1
	mov ecx, magic2
	mov edx, cmd
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h
