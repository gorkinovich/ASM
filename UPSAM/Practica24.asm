;----------------------------------------
; 4- Escribe una subrutina que recibe un puntero a un dato de 
; cuatro bytes que está almacenado en la memoria, y que devuelva 
; en el registro A el numero de unos que contiene ese dato.
;----------------------------------------
	ORG	200H
	JMP	main
dato:	DB	0FFH, 00FH, 0F0H, 081H
dato2:	DB	0FFH, 000H, 0F0H, 00FH
;----------------------------------------
cont:	MOV	C, 4
	MOV	B, 00H
sig1:	MOV	A, (X+0)
	;--------------------
sig2:	CLC
	RCL	A
	JNC	nouno
	INC	B
nouno:	CMP	A, 00H
	JNZ	sig2
	;--------------------
	INC	X
	DEC	C
	JNZ	sig1
	MOV	A, B
	RET
;----------------------------------------
main:	MOV	X, dato
	CALL	cont
	HLT
;----------------------------------------