;LISTADO CON ERRORES
;Recibe en BC un valor de dos bytes y lo convierte a una cadena ascii,
;terminada en un null = '\0', de 4 digitos en hexadecimal, la direccion
;esta indicada en x.

	MOV	BC, 12ABH
	MOV	X, 1000H
	CALL	Convierte
	HLT
Convierte:	MOV	A, B
	CALL	ASCIID
	MOV	A, B
	CALL	ASCII
	MOV	A, C
	CALL	ASCIID
	MOV	A, C
	CALL	ASCII
	XOR	A, A
	MOV	(X+0), A
	RET
ASCIID:	SHR	A
	SHR	A
	SHR	A
	SHR	A
ASCII:	AND	A, 0FH
	ADD	A, 30H	;30H = '0'
	CMP	A, 3AH
	JC	Sigue
	ADD	A, 7
Sigue:	MOV	(X+0), A
	INC	X
	RET

