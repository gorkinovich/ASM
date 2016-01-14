;----------------------------------------
; 2- Escribir una subrutina que multiplique 2 numeros que se 
; envian en los registros A y B, y que devuelva el resultado en A.
;----------------------------------------
	ORG	200H
	JMP	main
;----------------------------------------
mul:	CMP	A, 00H
	JZ	mulend
	MOV	C, A
	MOV	A, B
	CMP	A, 00H
	JZ	mulend
	MOV	A, C
	;--------------------
	DEC	B
	JZ	mulend
	ADD	A, A
	JMP	mul
mulend:	RET
;----------------------------------------
main:	MOV	A, 04H
	MOV	B, 08H
	CALL	mul
	HLT
;----------------------------------------