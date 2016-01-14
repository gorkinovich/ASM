;----------------------------------------
; 1- Suponiendo que se ha reservado una zona de memoria de 256 bytes
; string DB ?, ?, ?, .... (256 interrogantes)
; Escribe una subrutina que calcule la longitud de un string 
; almacenado en esa zona sabiendo que se usa como terminador el 
; carácter NULL es decir un 0 'patatero', y que el string podrá 
; tener cualquier tamaño comprendido entre 0 y 255.
;----------------------------------------
	ORG	200H
	JMP	main
cad:	DB	"hola juan jose del cristo", 0
;----------------------------------------
strlen:	MOV	B, 00H
slbeg:	MOV	A, (X+0)
	CMP	A, 00H
	JZ	slend
	INC	B
	INC	X
	JMP	slbeg
slend:	MOV	A, B
	RET
;----------------------------------------
main:	MOV	X, cad
	CALL	strlen
	HLT
;----------------------------------------