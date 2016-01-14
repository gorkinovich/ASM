;LISTADO CON ERRORES
	ORG	200H
	; 1º Se inicializan los dos nº de 3 bytes
	MOV	A, 98H
	MOV	(1000H), A
	MOV	A, 76H
	MOV	(1001H), A
	MOV	A, 54H
	MOV	(1002H), A
	MOV	A, 72H
	MOV	(1003H), A
	MOV	A, 10H
	MOV	(1004H), A
	MOV	A, 0FEH
	MOV	(1005H), A
	CLC
	MOV	B, 3
	MOV	X, 1000H
Bucle:	MOV 	A, (X+0)	;Se lee un byte
	ADC	A, (X+3)	; Se suma
	MOV	(X+6), A	; Se almacena el resultado
	INC	X	; Dec. puntero para coger sgte. byte
	DEC	B	; Incrementamos contador de bytes
	JNZ	Bucle	; y si no es 0 se repite el bucle
	RCL	A	; Ponemos en A el último acarreo
	AND	A, 01H
	MOV	(100AH), A	; y se almacena.
	HLT
