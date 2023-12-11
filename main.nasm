; cripto.nasm
; João Pedro Holanda Neves
; holanda.neves07@aluno.ifce.edu.br
segment .data
	LF equ 0xA ; Line Feed
	NULL equ 0x0 ; Final da String
	SYS_EXIT equ 0x1 ; Codigo de chamada para finalizar
	RET_EXIT equ 0x0 ; Operacao com Sucesso
	STD_IN equ 0x0 ; Entrada padrao
	STD_OUT equ 0x1 ; Saida padrao
	SYS_READ equ 0x3 ; Operacao de Leitura
	SYS_WRITE equ 0x4 ; Operacao de Escrita
	SYS_CALL equ 0x80 ; Envia informacao ao SO

section .data
	promptA db 'Fator: ', NULL
	lPromptA equ $ - promptA
	promptB db 'Letra: ', NULL
	lPromptB equ $ - promptB

section .bss
	shift resb 1
	input resb 32
	lInput equ $ - input
	cripted resb 32

section .text
	global _start

_start:
	mov eax, 0x04
	mov ebx, 0x01
	mov ecx, promptA
	mov edx, lPromptA
	int 0x80

	mov eax, 0x03
	mov ebx, 0x00
	mov ecx, shift
	mov edx, 2
	int 0x80

	mov eax, 0x04
	mov ebx, 0x01
	mov ecx, promptB
	mov edx, lPromptB
	int 0x80

	mov eax, 0x03
	mov ebx, 0x00
	mov ecx, input
	mov edx, lInput
	int 0x80

	mov edi, cripted
	mov esi, input

cripto1:
	mov al, [esi]
	inc esi

	add al, [shift]
	sub al, 0x30

	cmp al, 0x7A
	jg fixGreater

cripto2:
	mov [edi], al
	inc edi

	cmp byte[esi], 0x0A
	jne cripto1

	mov byte[edi], 0x00
	
	mov eax, 0x04
	mov ebx, 0x01
	mov ecx, cripted
	mov edx, lInput
	int 0x80

	jmp _end

fixGreater:
	sub al, 0x1A
	
	jmp cripto2

_end:
	mov eax, 0x01
	mov ebx, 0x00
	int 0x80