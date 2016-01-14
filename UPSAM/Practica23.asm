;----------------------------------------
; 3- Escribe una subrutina que convierta una cadena ASCIIZ 
; (cadena que use como terminador el caracter NULL) a mayusculas 
; sabiendo que la zona de memoria que contiene el string está 
; etiquetada como str1 y que los caracteres ASCII en minusculas 
; van del 61H al 7AH y en mayusculas del 41H al 5AH.
;----------------------------------------
	ORG	200H
	JMP	main
cad:	DB	"Hola hola!!!", 0
	;48 6F 6C 61 20 68 6F 6C 61 21 21 21 00 <- Inicial
	;48 4F 4C 41 20 48 4F 4C 41 21 21 21 00 <- Final
;----------------------------------------
strup:	MOV	A, (X+0)
	CMP	A, 00H
	JZ	strend
	;--------------------
	;if ((A > 60h) || (7Bh < A))
	;--------------------
	CMP	A, 61H
	JC	strsig ; A < 61H = No minuscula
	CMP	A, 7BH
	JC	strmin ; A < 7BH = Minuscula
	JMP	strsig
strmin: SUB	A, 20H
	MOV	(X+0), A
strsig:	INC	X
	JMP	strup
strend:	RET
;----------------------------------------
main:	MOV	X, cad
	CALL	strup
	HLT
;----------------------------------------