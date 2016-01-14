;====================================================================================================
Include conio.inc
Model small
;====================================================================================================
Dataseg
CadBuf	db 80 		;Tmax
CadTam	db 0 		;Tact
Cadena	db 81 dup(0)	;Cadena
Msg01	db "Hola jodido mundo!!!", 13, 10, 0			;d 0D82:0053 . d 0D72:00FA
Msg02	db "Esto es una mierda desde luego!!!", 13, 10, 0
Msg03	db "Modo 40x25", 13, 10, 0
Msg04	db "Modo 80x25", 13, 10, 0
Msg05	db "Pon alguna mierda: ", 0
Color	db 07h
Coordx	db 0h
Coordy	db 0h
DefColores
;====================================================================================================
Stack 256
Codeseg
P386N
ConioLib
StartUpCode
	;====================
	;Modo 40x25
	;====================
	;fclock
	ftextmodec40
	fclrscrc40	
	fdelay 2000
	fputch 'X'
	fdelay 1000
	fputch 'A'
	fdelay 1000
	fputch 'R'
	fdelay 1000
	fwherexy
	add ah, '0'
	add al, '0'
	mov Coordx, ah
	mov Coordy, al
	fputch ' '
	fputch '-'
	fputch '>'
	fputch ' '
	fputch Coordx
	fputch ':'
	fputch Coordy
	;Salto de linea
	fputch 13
	fputch 10


	ftextbgcolor Color, CVerde
	ftextcolor   Color, CBlanco
	fputch2      'A', Color

	fgotoxy 0, 4
	fcputs  Msg03
	fcputs2 Msg01, Color
	fgetch

	fgotoxy 4, 5
	fclreolc40
	fgetch

	ftextbgcolor Color, CAzul
	ftextcolor   Color, CGrisClaro
	fclrscrc402  Color
	fgetche
	fsetnocursor
	fgetche
	fsetsolidcursor
	fgetche
	fsetnormalcursor
bucle:
	fkbhit
	jz bucle	;= tecla no pulsada
	fkbflush

	ftextmodec80
	fclrscr
	fcputs  Msg04
	fcputs2 Msg02, Color
	fgetch

	cmp al, 'S'
	jne siguiente
	fexit 1
siguiente:

	fgotoxy 0, 1
	fclreol
	fgetch

	fclrscr2 Color
	fcputs2  Msg05, Color
	fcgets   CadBuf
	fputch   13
	fputch   10

	fstrsubcpy Msg03, 5, Cadena, 0, 5
	fcputs2    Msg03, Color

	fendprog
;====================================================================================================
End
;====================================================================================================