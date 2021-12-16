.model small

.stack 100h
.data
    message db 'Enter password (max 10 chars)', 13, 10, '$'
    incorrect db 'Incorrect password', 13, 10, '$'
    correct db 'Correct!$'
    password db 'Password'
    input db 11, 0, 11 dup(0)
.code
    START:
	; Message
	mov ax, @data
	mov ds, ax
	mov ah, 09h
	lea dx, message
	int 21h

	INPT:
	    mov ax, @data
	    mov ds, ax
	    mov es, ax
	    mov ah, 0Ah
	    lea dx, input
	    int 21h

	    ; Exit if 'q'
	    mov al, input + 2
	    mov bl, 71h
	    cmp al, bl
	    je EXIT

	    ; Compare length
	    mov al, 8
	    mov bl, input + 1
	    cmp al, bl
	    jne NO

	    ; Compare values
	    mov cx, 8
	    lea si, password
	    lea di, input + 2
	    repe cmpsb
	    jne NO
	    jmp YES

	NO:
	    mov ax, @data
	    mov ds, ax
	    mov ah, 09h
	    lea dx, incorrect
	    int 21h
	    jmp INPT

	YES:
	    mov ax, @data
	    mov ds, ax
	    mov ah, 09h
	    lea dx, correct
	    int 21h

	EXIT:
	    mov ah, 4Ch
	    int 21h
end START
