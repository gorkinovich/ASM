;====================================================================================================
; Lex's Pong - Juego del Pong bajo ms-dos.
; Copyright (C) 2004  Gorka Suárez García
;
; Pong.asm is part of "Lex's Pong".
;
; "Lex's Pong" is free software; you can redistribute it and/or
; modify it under the terms of the GNU General Public License
; as published by the Free Software Foundation; either version 2
; of the License, or (at your option) any later version.
;
; "Lex's Pong" is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with "Lex's Pong"; if not, write to the Free Software
; Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
;====================================================================================================
Include conio.inc
Include conv.inc
Model small
;====================================================================================================
FlechaArriba	EQU 72
FlechaAbajo	EQU 80
Escape		EQU 01
TEnter		EQU 28
TeclaA		EQU 30
TeclaZ		EQU 44
;====================================================================================================
Dataseg
	;========================================
	;Variables globales
	;========================================
	StandarCol	db 02h
	Pos		db 0
	Col		db 0

	;========================================
	;Variables de la rutina del menu
	;========================================
	MnuOpc		db 0
	MnuCab01F	db 1
	MnuCab02F	db 2
	MnuCab03F	db 3
	MnuCabXXC	db 12
	MnuStrCab01	db "*================*", 0
	MnuStrCab02	db "*      Pong      *", 0
	MnuStrCab03	db "*================*", 0
	MnuOpc01F	db 5
	MnuOpc02F	db 7
	MnuOpc03F	db 9
	MnuOpc04F	db 11
	MnuOpc05F	db 13
	MnuOpcXXC	db 14
	MnuStrOpc01	db "  1 Jugador   ", 0
	MnuStrOpc02	db " 2 Jugadores  ", 0
	MnuStrOpc03	db "    Ayuda     ", 0
	MnuStrOpc04	db "   Creditos   ", 0
	MnuStrOpc05	db "    Salir     ", 0
	MnuColOpc	db 2Fh
	MnuColOpcSel	db 1Fh

	;========================================
	;Variables de la rutina de la ayuda
	;========================================
	AyuCab01F	db 1
	AyuCab02F	db 2
	AyuCab03F	db 3
	AyuCabXXC	db 12
	AyuStrCab01	db "*================*", 0
	AyuStrCab02	db "*      Ayuda     *", 0
	AyuStrCab03	db "*================*", 0
	AyuTxtF		db 5
	AyuTxtC		db 0
	AyuTxt01	db "  Las reglas del juego son sencillas.   "
	AyuTxt02	db "Hay dos jugadores y una bola, con ellos "
	AyuTxt03	db "se juegan una serie de puntos. Estos se "
	AyuTxt04	db "ganan cuando el contrincante no logra   "
	AyuTxt05	db "devolver la bola. Basicamente esto se   "
	AyuTxt06	db "parece al pin-pon. Las teclas de cada   "
	AyuTxt07	db "jugador son:", 13, 10, 13, 10
	AyuTxt08	db "Jugador 1:", 13, 10
	AyuTxt09	db "   A -> Moverse hacia arriba", 13, 10
	AyuTxt10	db "   Z -> Moverse hacia abajo", 13, 10, 13, 10
	AyuTxt11	db "Jugador 2:", 13, 10
	AyuTxt12	db "   F. Arriba -> Moverse hacia arriba", 13, 10
	AyuTxt13	db "   F. Abajo  -> Moverse hacia abajo", 13, 10, 13, 10
	AyuTxt14	db "Y eso es todo.", 13, 10
	AyuTxt15	db "Pulsa una tecla para volver al menu...", 0

	;========================================
	;Variables de la rutina de los creditos
	;========================================
	CreCab01F	db 1
	CreCab02F	db 2
	CreCab03F	db 3
	CreCabXXC	db 12
	CreStrCab01	db "*================*", 0
	CreStrCab02	db "*    Creditos    *", 0
	CreStrCab03	db "*================*", 0
	CreTxtF		db 5
	CreTxtC		db 0
	CreTxt01	db "  Todo todo todo y todo, pero que abso- "
	CreTxt02	db "lutamente todo, esta creado, programado,"
	CreTxt03	db "dise¤ado, maquinado, realizado, e imple-"
	CreTxt04	db "mentado, por Gorka Suarez Garcia, el    "
	CreTxt05	db "unico e inigualable, el tio mas grande  "
	CreTxt06	db "del mundo mundial, si se¤or, wa wa wa,  "
	CreTxt07	db "que grande que soy, que he programado   "
	CreTxt08	db "todo este juego en ensamblador. Asi que "
	CreTxt09	db "si quereis agradecermelo, no estaria mal"
	CreTxt10	db "que me presentarais a alguna tia que es-"
	CreTxt11	db "tuviera toda buena, si... je je je...", 13, 10, 13, 10
	CreTxt12	db "Pues eso que todo me lo he currado yo.  "
	CreTxt13	db "Que os sea leve las partidas que le     "
	CreTxt14	db "echeis. Un saludo.", 13, 10
	CreTxt15	db "Pulsa una tecla para volver al menu...", 0

	;========================================
	;Variables del juego
	;========================================
	JugStdCol	db 0Fh
	JugCabF		db 1
	JugCabC		db 0
	JugCab		db "                  Pong                  "
			db "ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ", 0
	JugMarF		db 21
	JugMarC		db 0
	JugMar		db "ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß"
			db "               Marcadores               "
			db "Jugador1 00                  Jugador2 00", 0
	JugGraf		db "Û"
	JugBola		db "o"
	JugBolaF	db 11
	JugBolaC	db 19
	JugBolaDF	db 81h
	JugBolaDC	db 81h
	JugMaxPnt	db 0
	JugDificultad	db 0
	Jug1Pos		db 10
	Jug1Col		db 1
	Jug1Nombre	db "        ", 0
	Jug1Pnt		db 0
	Jug2Pos		db 10
	Jug2Col		db 38
	Jug2Nombre	db "        ", 0
	Jug2Pnt		db 0
	JugXNombreF	db 23
	Jug1NombreC	db 0
	Jug2NombreC	db 29
	JugMinPos	db 3
	JugMaxPos	db 17
	JugMinC		db 0
	JugMaxC		db 39
	JugMNombre	db "MaquinaX", 0
	JugMsj01F	db 11
	JugMsj01C	db 16
	JugMsj02F	db 12
	JugMsj02C	db 17
	JugMsj02	db "­Gana!", 0
	JugBlanco	db "        ", 0
	;========================================
	;Seccion de pedir datos
	;========================================
	JugDat00F	db 5
	JugDat01F	db 7
	JugDat02F	db 9
	JugDat03F	db 11
	JugDatXXC	db 10
	JugDat00a	db "Jugador 1", 0
	JugDat00b	db "Jugador 2", 0
	JugDat01	db "Nombre: ", 0
	JugDat02	db "Puntos: ", 0
	JugDat03	db "Dificultad (0-9): ", 0
	JugCNBuf	db 9 		;Tmax
			db 0 		;Tact
	JugNCad		db 9 dup(0)	;Cadena nombre
	JugCPBuf	db 3 		;Tmax
			db 0 		;Tact
	JugPCad		db 3 dup(0)	;Cadena puntos
	JugCDBuf	db 2 		;Tmax
			db 0 		;Tact
	JugDCad		db 2 dup(0)	;Cadena dificultad
	JugCadAux	db 11 dup(0)	;Cadena auxiliar
	JugNaux		dd 0

	Vencedor	db 0

;====================================================================================================
Stack 512
Codeseg
P386N
ConioLib
ConvLib
StartUpCode
	ftextmodec40
	call setnocursor
Mainlp: call Menu
        mov  al, MnuOpc
        cmp  al, 1
	jz   Main01
        cmp  al, 2
	jz   Main02
        cmp  al, 3
	jz   Main03
        cmp  al, 4
	jz   Main04
        cmp  al, 5
	jz   Main05
	jmp  Mainlp
Main01:	call UnJugador
	jmp  Mainlp
Main02:	call DosJugadores
	jmp  Mainlp
Main03:	call Ayuda
	jmp  Mainlp
Main04:	call Creditos
	jmp  Mainlp
Main05:	call textmodec80
	call setnormalcursor
	call clrscr
	call endprog
;====================================================================================================
Menu	Proc Near
	;========================================
	;Inicializar funcion
	mov	byte ptr MnuOpc, 0
	mov	al, StandarCol
	push	ax
	call	clrscrc402

        ;========================================
	;Dibujado de pantalla
	;========================================
	fgotoxy MnuCabXXC, MnuCab01F	;La cabecera
	fcputs2 MnuStrCab01, StandarCol
	fgotoxy MnuCabXXC, MnuCab02F
	fcputs2 MnuStrCab02, StandarCol
	fgotoxy MnuCabXXC, MnuCab03F
	fcputs2 MnuStrCab03, StandarCol

Menulp:	fgotoxy MnuOpcXXC, MnuOpc01F	;Las opciones
	cmp	byte ptr MnuOpc, 1
	jz	Opc01S
	fcputs2 MnuStrOpc01, MnuColOpc
	jmp	Opc01
Opc01S:	fcputs2 MnuStrOpc01, MnuColOpcSel

Opc01:	fgotoxy MnuOpcXXC, MnuOpc02F
	cmp	byte ptr MnuOpc, 2
	jz	Opc02S
	fcputs2 MnuStrOpc02, MnuColOpc
	jmp	Opc02
Opc02S:	fcputs2 MnuStrOpc02, MnuColOpcSel

Opc02:	fgotoxy MnuOpcXXC, MnuOpc03F
	cmp	byte ptr MnuOpc, 3
	jz	Opc03S
	fcputs2 MnuStrOpc03, MnuColOpc
	jmp	Opc03
Opc03S:	fcputs2 MnuStrOpc03, MnuColOpcSel

Opc03:	fgotoxy MnuOpcXXC, MnuOpc04F
	cmp	byte ptr MnuOpc, 4
	jz	Opc04S
	fcputs2 MnuStrOpc04, MnuColOpc
	jmp	Opc04
Opc04S:	fcputs2 MnuStrOpc04, MnuColOpcSel

Opc04:	fgotoxy MnuOpcXXC, MnuOpc05F
	cmp	byte ptr MnuOpc, 5
	jz	Opc05S
	fcputs2 MnuStrOpc05, MnuColOpc
	jmp	Opc05
Opc05S:	fcputs2 MnuStrOpc05, MnuColOpcSel

	;========================================
	;Pulsaciones de teclas
	;========================================
Opc05:	fgetch				;Pulsamos una tecla
	cmp	ah, FlechaArriba	;Flecha arriba
	jz	Menu01
	cmp	ah, FlechaAbajo		;Flecha abajo
	jz	Menu02
	cmp	ah, TEnter		;Enter
	jz	Menu03
	;Si ah >= 02 y ah <= 06 -> Opcion = ah - 1
	;Si ah < 01 o ah > 06 -> Error
	cmp	ah, 02			;Tecla 1
	jb	Menulp
	cmp	ah, 06			;Tecla 5
	ja	Menulp
	;========================================
	;Se ha pulsado una tecla del 1 al 5
	;========================================
	dec	ah
	mov	byte ptr MnuOpc, ah
	jmp	Menu03
	;========================================
	;Se ha pulsado la flecha arriba
	;========================================
Menu01:	cmp	byte ptr MnuOpc, 2	;Si Opcion < 2 -> Opcion = 5, sino Opcion--
	jb	Mnu01a
	dec	byte ptr MnuOpc
	jmp	Menulp
Mnu01a:	mov	byte ptr MnuOpc, 5
	jmp	Menulp
	;========================================
	;Se ha pulsado la flecha abajo
	;========================================
Menu02:	cmp	byte ptr MnuOpc, 4	;Si Opcion > 4 -> Opcion = 1, sino Opcion++
	ja	Mnu02a
	inc	byte ptr MnuOpc
	jmp	Menulp
Mnu02a:	mov	byte ptr MnuOpc, 1
	jmp	Menulp
	;========================================
	;Se ha pulsado el enter o un numero
	;========================================
Menu03:	ret
Menu	Endp
;====================================================================================================
PedirNombreJ1 Proc Near
	;========================================
	fgotoxy JugDatXXC, JugDat00F
	fcputs JugDat00a
	fgotoxy JugDatXXC, JugDat01F
	fcputs JugDat01
	fcgets JugCNBuf
	fstrsubcpy Jug1Nombre, 0, JugNCad, 0, 8
	;========================================
	ret
PedirNombreJ1 Endp
;----------------------------------------------------------------------------------------------------
PedirNombreJ2 Proc Near
	;========================================
	fgotoxy JugDatXXC, JugDat00F
	fcputs JugDat00b
	fgotoxy JugDatXXC, JugDat01F
	fcputs JugDat01
	fcputs JugBlanco
	fgotoxy JugDatXXC, JugDat01F
	fcputs JugDat01
	fcgets JugCNBuf
	fstrsubcpy Jug2Nombre, 0, JugNCad, 0, 8
	;========================================
	ret
PedirNombreJ2 Endp
;----------------------------------------------------------------------------------------------------
PedirPuntos Proc Near
	;========================================
	fgotoxy JugDatXXC, JugDat02F
	fcputs JugDat02
	fcgets JugCPBuf
	fCNumCad JugPCad
	mov JugMaxPnt, al
	;========================================
	ret
PedirPuntos Endp
;----------------------------------------------------------------------------------------------------
PedirDificultad Proc Near
	;========================================
	fgotoxy JugDatXXC, JugDat03F
	fcputs JugDat03
UnJD:	fgotoxy 28, JugDat03F
	fcputs JugBlanco
	fgotoxy 28, JugDat03F
	fcgets JugCDBuf
	;Si D < '0' o D > '9' -> volver a pedir datos
	cmp JugDCad, "0"
	jb  UnJD
	cmp JugDCad, "9"
	ja  UnJD
	fCNumCad JugDCad
	mov bl, 4
	mul bl
	mov bl, 36
	sub bl, al
	mov JugDificultad, bl	;Dificultad = 36 - al * 4

	;Nombre de la maquina
	fstrsubcpy JugMNombre, 7, JugDCad, 0, 1
	fstrsubcpy Jug2Nombre, 0, JugMNombre, 0, 8
	;========================================
	ret
PedirDificultad Endp
;----------------------------------------------------------------------------------------------------
PintarPantalla Proc Near
	;========================================
	;Pintamos la pantalla
	;========================================
	fgotoxy JugCabC, JugCabF
	fcputs JugCab
	fgotoxy JugMarC, JugMarF
	fcputs JugMar
	fgotoxy Jug1NombreC, JugXNombreF
	fcputs JugBlanco
	fgotoxy Jug1NombreC, JugXNombreF
	fcputs Jug1Nombre
	fgotoxy Jug2NombreC, JugXNombreF
	fcputs JugBlanco
	fgotoxy Jug2NombreC, JugXNombreF
	fcputs Jug2Nombre
	;========================================
	ret
PintarPantalla Endp
;----------------------------------------------------------------------------------------------------
InitObjetos Proc Near
	;========================================
	;La bola
	mov JugBolaF, 11
	mov JugBolaC, 19
	mov JugBolaDF, 81h
	mov JugBolaDC, 81h
	;Las paletas
	mov Jug1Pos, 10
	mov Jug2Pos, 10
	mov Jug1Pnt, 0
	mov Jug2Pnt, 0
	;Pintar
	call PintarBola
	mov  al, Jug1Pos
	mov  Pos, al
	mov  al, Jug1Col
	mov  Col, al
	call PintarPaleta
	mov  al, Jug2Pos
	mov  Pos, al
	mov  al, Jug2Col
	mov  Col, al
	call PintarPaleta
	;========================================
	ret
InitObjetos Endp
;----------------------------------------------------------------------------------------------------
PintarBola Proc Near
	;========================================
	fPutCharC40 JugBolaC, JugBolaF, JugBola
	;========================================
	ret
PintarBola Endp
;----------------------------------------------------------------------------------------------------
BorrarBola Proc Near
	;========================================
	fPutCharC40 JugBolaC, JugBolaF, " "
	;========================================
	ret
BorrarBola Endp
;----------------------------------------------------------------------------------------------------
PintarPaleta Proc Near
	;========================================
	mov cl, 4
PPallp:	fPutCharC40 Col, Pos, JugGraf
	inc Pos
	dec cl
	jnz PPallp
	;========================================
	ret
PintarPaleta Endp
;----------------------------------------------------------------------------------------------------
BorrarPaleta Proc Near
	;========================================
	mov cl, 4
BPallp:	fPutCharC40 Col, Pos, " "
	inc Pos
	dec cl
	jnz BPallp
	;========================================
	ret
BorrarPaleta Endp
;====================================================================================================7
Jug1Arriba Proc Near
	;========================================
	mov ah, Jug1Pos
	mov al, JugMinPos
	cmp ah, al
	jz  J1AFin
	dec Jug1Pos
	;Borramos la paleta
	mov  al, ah
	mov  Pos, al
	mov  al, Jug1Col
	mov  Col, al
	call BorrarPaleta
	;Pintamos la paleta en su nueva posicion
	mov  al, Jug1Pos
	mov  Pos, al
	mov  al, Jug1Col
	mov  Col, al
	call PintarPaleta
	;========================================
J1AFin:	ret
Jug1Arriba Endp
;----------------------------------------------------------------------------------------------------
Jug1Abajo Proc Near
	;========================================
	mov ah, Jug1Pos
	mov al, JugMaxPos
	cmp ah, al
	jz  J1BFin
	inc Jug1Pos
	;Borramos la paleta
	mov  al, ah
	mov  Pos, al
	mov  al, Jug1Col
	mov  Col, al
	call BorrarPaleta
	;Pintamos la paleta en su nueva posicion
	mov  al, Jug1Pos
	mov  Pos, al
	mov  al, Jug1Col
	mov  Col, al
	call PintarPaleta
	;========================================
J1BFin:	ret
Jug1Abajo Endp
;====================================================================================================
Jug2Arriba Proc Near
	;========================================
	mov ah, Jug2Pos
	mov al, JugMinPos
	cmp ah, al
	jz  J2AFin
	dec Jug2Pos
	;Borramos la paleta
	mov  al, ah
	mov  Pos, al
	mov  al, Jug2Col
	mov  Col, al
	call BorrarPaleta
	;Pintamos la paleta en su nueva posicion
	mov  al, Jug2Pos
	mov  Pos, al
	mov  al, Jug2Col
	mov  Col, al
	call PintarPaleta
	;========================================
J2AFin:	ret
Jug2Arriba Endp
;----------------------------------------------------------------------------------------------------
Jug2Abajo Proc Near
	;========================================
	mov ah, Jug2Pos
	mov al, JugMaxPos
	cmp ah, al
	jz  J2BFin
	inc Jug2Pos
	;Borramos la paleta
	mov  al, ah
	mov  Pos, al
	mov  al, Jug2Col
	mov  Col, al
	call BorrarPaleta
	;Pintamos la paleta en su nueva posicion
	mov  al, Jug2Pos
	mov  Pos, al
	mov  al, Jug2Col
	mov  Col, al
	call PintarPaleta
	;========================================
J2BFin:	ret
Jug2Abajo Endp
;====================================================================================================
MoverBola Proc Near
	;========================================
	;Posibles casos que alteran el rumbo
	;========================================
	;Casos que alteran el incremento de la columna
	;----------------------------------------
	;Casos en los que se marca punto -> C=0 o C=39
	cmp	JugBolaC, 0	;Si la fila actual > 0 -> No alterar rumbo
	ja	MBNPJ1
	xor	JugBolaDC, 80h	;xor s000iiii, 10000000
	inc	Jug2Pnt		;Actualizamos el contador
	mov	al, Jug2Pnt
	lea	di, JugNaux	;Pasamos el numero a cadena
	mov	[di], al
	fCCadNum JugCadAux, JugNaux
	lea	si, JugCadAux	;Actualizamos el marcador
	mov	dl, [si+8]
	fPutCharC40 38, 23, dl
	mov	dl, [si+9]
	fPutCharC40 39, 23, dl
	call	BorrarBola	;Borramos la bola
	mov	JugBolaF, 11	;Reiniciamos la posicion
	mov	JugBolaC, 19
	jmp	MBIMaC		;Saltamos al final de la funcion

MBNPJ1:	cmp	JugBolaC, 39	;Si la fila actual < 39 -> No alterar rumbo
	jb	MBNPJ2
	xor	JugBolaDC, 80h	;xor s000iiii, 10000000
	inc	Jug1Pnt		;Actualizamos el contador
	mov	al, Jug1Pnt
	lea	di, JugNaux	;Pasamos el numero a cadena
	mov	[di], al
	fCCadNum JugCadAux, JugNaux
	lea	si, JugCadAux	;Actualizamos el marcador
	mov	dl, [si+8]
	fPutCharC40 09, 23, dl
	mov	dl, [si+9]
	fPutCharC40 10, 23, dl
	call	BorrarBola	;Borramos la bola
	mov	JugBolaF, 11	;Reiniciamos la posicion
	mov	JugBolaC, 19
	jmp	MBIMaC		;Saltamos al final de la funcion

	;----------------------------------------
	;Casos en los que se choca con la paleta -> C=2 o C=37
MBNPJ2: cmp	JugBolaC, 2	;Si la fila actual > 2 -> No alterar rumbo
	ja	MBNPa1
	test	JugBolaDC, 80h	;Si Bdc && 80h == 0 -> No alterar rumbo
	jz	MBNPa2
	mov	al, Jug1Pos	;Posicion del jugador 1
	dec	al		;AL = Py-1
	cmp	JugBolaF, al	;Si By < Py-1 -> No alterar rumbo
	jb	MBNPa1
	mov	al, Jug1Pos	;Posicion del jugador 1
	add	al, 4		;AL = Py+4
	cmp	JugBolaF, al	;Si By > Py+4 -> No alterar rumbo
	ja	MBNPa1
	;----------------------------------------
	mov	al, Jug1Pos	;Posicion del jugador 1
	inc	al		;AL = Py+1 //=Centro(-)
	cmp	JugBolaF, al	;Si By > P+1 -> Parte baja
	ja	MBP1B
	;----------------------------------------
	;Casos que se contemplan en la posibilidad de que la bola este en la mitad alta
	;de la paleta.
	test	JugBolaDF, 80h	;Parte alta, si Bdf && 80h == 1 -> Se dirige hacia arriba
	jz	MBP1An		;Si se dirige hacia abajo, caso normal
	mov	al, Jug1Pos	;Posicion del jugador 1
	dec	al		;AL = Py-1
	cmp	JugBolaF, al	;Si By > Py-1 -> Caso normal
	ja	MBP1An
	;Caso anormal, que la bola dirigiendose hacia arriba, se encuentre uno por encima
	;de la paleta, en ese caso no toca la raqueta. En este caso no se altera el rumbo.
	jmp	MBNPa2
	;Caso normal, que la bola dirigiendose hacia arriba, se encuentre sobre la paleta,
	;o que la bola se dirija simplemente hacia abajo, este donde este. En estos casos
	;cambiaremos la direccion de las Columnas, y haremos que direccion de las Filas
	;apunte hacia arriba.
MBP1An:	and	JugBolaDC, 7Fh	;and s000iiii, 01111111 -> C = Derecha
	or	JugBolaDF, 80h	;or  s000iiii, 10000000 -> F = Arriba
	jmp	MBNPa1
	;----------------------------------------
	;Casos que se contemplan en la posibilidad de que la bola este en la mitad baja
	;de la paleta.
MBP1B:	test	JugBolaDF, 80h	;Parte baja, si Bdf && 80h == 1 -> Se dirige hacia arriba
	jnz	MBP1Bn		;Si se dirige hacia arriba, caso normal
	mov	al, Jug1Pos	;Posicion del jugador 1
	add	al, 4		;AL = Py+4
	cmp	JugBolaF, al	;Si By < Py+4 -> Caso normal
	jb	MBP1Bn
	;Caso anormal, que la bola dirigiendose hacia abajo, se encuentre uno por debajo
	;de la paleta, en ese caso no toca la raqueta. En este caso no se altera el rumbo.
	jmp	MBNPa2
	;Caso normal, que la bola dirigiendose hacia abajo, se encuentre sobre la paleta,
	;o que la bola se dirija simplemente hacia arriba, este donde este. En estos casos
	;cambiaremos la direccion de las Columnas, y haremos que direccion de las Filas
	;apunte hacia abajo.
MBP1Bn:	and	JugBolaDC, 7Fh	;and s000iiii, 01111111 -> C = Derecha
	and	JugBolaDF, 7Fh	;and s000iiii, 01111111 -> F = Abajo


	;----------------------------------------
MBNPa1:	cmp	JugBolaC, 37	;Si la fila actual < 37 -> No alterar rumbo
	jb	MBNPa2
	test	JugBolaDC, 80h	;Si Bdc && 80h == 1 <- No alterar rumbo
	jnz	MBNPa2
	mov	al, Jug2Pos	;Posicion del jugador 2
	dec	al		;AL = Py-1
	cmp	JugBolaF, al	;Si By < Py-1 -> No alterar rumbo
	jb	MBNPa2
	mov	al, Jug2Pos	;Posicion del jugador 2
	add	al, 4		;AL = Py+4
	cmp	JugBolaF, al	;Si By > Py+4 -> No alterar rumbo
	ja	MBNPa2
	;----------------------------------------
	mov	al, Jug2Pos	;Posicion del jugador 2
	inc	al		;AL = Py+1 //=Centro(-)
	cmp	JugBolaF, al	;Si By > P+1 -> Parte baja
	ja	MBP2B
	;----------------------------------------
	;Casos que se contemplan en la posibilidad de que la bola este en la mitad alta
	;de la paleta.
	test	JugBolaDF, 80h	;Parte alta, si Bdf && 80h == 1 -> Se dirige hacia arriba
	jz	MBP2An		;Si se dirige hacia abajo, caso normal
	mov	al, Jug2Pos	;Posicion del jugador 2
	dec	al		;AL = Py-1
	cmp	JugBolaF, al	;Si By > Py-1 -> Caso normal
	ja	MBP2An
	;Caso anormal, que la bola dirigiendose hacia arriba, se encuentre uno por encima
	;de la paleta, en ese caso no toca la raqueta. En este caso no se altera el rumbo.
	jmp	MBNPa2
	;Caso normal, que la bola dirigiendose hacia arriba, se encuentre sobre la paleta,
	;o que la bola se dirija simplemente hacia abajo, este donde este. En estos casos
	;cambiaremos la direccion de las Columnas, y haremos que direccion de las Filas
	;apunte hacia arriba.
MBP2An:	or	JugBolaDC, 80h	;or  s000iiii, 10000000 -> C = Izquierda
	or	JugBolaDF, 80h	;or  s000iiii, 10000000 -> F = Arriba
	jmp	MBNPa2
	;----------------------------------------
	;Casos que se contemplan en la posibilidad de que la bola este en la mitad baja
	;de la paleta.
MBP2B:	test	JugBolaDF, 80h	;Parte baja, si Bdf && 80h == 1 -> Se dirige hacia arriba
	jnz	MBP2Bn		;Si se dirige hacia arriba, caso normal
	mov	al, Jug2Pos	;Posicion del jugador 2
	add	al, 4		;AL = Py+4
	cmp	JugBolaF, al	;Si By < Py+4 -> Caso normal
	jb	MBP2Bn
	;Caso anormal, que la bola dirigiendose hacia abajo, se encuentre uno por debajo
	;de la paleta, en ese caso no toca la raqueta. En este caso no se altera el rumbo.
	jmp	MBNPa2
	;Caso normal, que la bola dirigiendose hacia abajo, se encuentre sobre la paleta,
	;o que la bola se dirija simplemente hacia arriba, este donde este. En estos casos
	;cambiaremos la direccion de las Columnas, y haremos que direccion de las Filas
	;apunte hacia abajo.
MBP2Bn:	or	JugBolaDC, 80h	;or  s000iiii, 10000000 -> C = Izquierda
	and	JugBolaDF, 7Fh	;and s000iiii, 01111111 -> F = Abajo

	;----------------------------------------
	;Casos que alteran el incremento de la fila
	;----------------------------------------
MBNPa2:	cmp	JugBolaF, 3	;Si la fila actual > 3 -> No alterar rumbo
	ja	MBArr
	and	JugBolaDF, 7Fh	;and s000iiii, 01111111 -> F = Abajo

MBArr:	cmp	JugBolaF, 20	;Si la fila actual < 20 -> No alterar rumbo
	jb	MBAbj
	or	JugBolaDF, 80h	;or  s000iiii, 10000000 -> F = Arriba

	;========================================
MBAbj:	call	BorrarBola
	;========================================
	;Incremento de las coordenadas
	;========================================
MBInc:	mov	ah, JugBolaDF
	mov	bh, ah
	and	ah, 0Fh
	;Si bit de signo -> JugBolaF -= JugBolaDF
	and	bh, 80h
	jnz	MBIMeF		;Signo (-)
	add	JugBolaF, ah	;Signo (+)
	jmp	MBIMaF
MBIMeF:	sub	JugBolaF, ah

MBIMaF:	mov	ah, JugBolaDC
	mov	bh, ah
	and	ah, 0Fh
	;Si bit de signo -> JugBolaC -= JugBolaDC
	and	bh, 80h
	jnz	MBIMeC		;Signo (-)
	add	JugBolaC, ah	;Signo (+)
	jmp	MBIMaC
MBIMeC:	sub	JugBolaC, ah
	;========================================
MBIMaC:	call	PintarBola
	fdelay	200
	;========================================
	ret
MoverBola Endp
;----------------------------------------------------------------------------------------------------
MoverMalo Proc Near
	;========================================
	;Si la bola se mueve a la izquierda no se movera
	test	JugBolaDC, 80h	;Si Fdc && 80h == 1 -> No mover
	jnz	MMFin
	;----------------------------------------
	mov	al, JugDificultad	;Comprobamos que esta en el rango de accion
	cmp	JugBolaC, al		;Si Bc < Dificultad -> No mover
	jb	MMFin
	;----------------------------------------
	call	clock
	rcr	dl, 1
	jnc	MMFin
	;----------------------------------------
	mov	al, Jug2Pos
	cmp	JugBolaF, al
	jb	MMAr			;Si Bf < J2Pos -> Jug2Arriba
	add	al, 3
	cmp	JugBolaF, al
	ja	MMAb			;Si Bf > J2Pos -> Jug2Abajo
	jmp	MMFin
MMAr:	call	Jug2Arriba
	jmp	MMFin
MMAb:	call	Jug2Abajo
	;========================================
MMFin:	ret
MoverMalo Endp
;====================================================================================================
HayVencedor Proc Near
	;========================================
	mov	Vencedor, 0		;No hay vencedor
	mov	dh, JugMaxPnt		;DH = Numero de puntos a jugar
	mov	dl, Jug1Pnt		;DL = Puntos del jugador 1
	cmp	dh, dl			;Si DH > DL -> Mirar jugador 2
	ja	HVJ2
	mov	Vencedor, 1		;Gana el jugador uno
	jmp	HVFin
HVJ2:	mov	dl, Jug2Pnt		;DL = Puntos del jugador 2
	cmp	dh, dl			;Si DH > DL -> Ir al final
	ja	HVFin
	mov	Vencedor, 2		;Gana el jugador dos
	;========================================
HVFin:	ret
HayVencedor Endp
;----------------------------------------------------------------------------------------------------
UJPulsarTecla Proc Near
	;========================================
	xor  ax, ax
	push ax
	call kbhit
	pop  ax
	jz   DJPTF
	fgetch
	;========================================
	cmp ah, TeclaA
	jz  UJTA
	cmp ah, TeclaZ
	jz  UJTZ
	cmp ah, Escape
	jz  UJPTF
	;No se ha pulsado ninguna otra tecla del juego
	jmp UJNT
	;========================================
UJTA:	call Jug1Arriba
	jmp UJPTF
UJTZ:	call Jug1Abajo
	jmp UJPTF
UJNT:	xor ax, ax
	;========================================
UJPTF:	ret
UJPulsarTecla Endp
;----------------------------------------------------------------------------------------------------
DJPulsarTecla Proc Near
	;========================================
	xor  ax, ax
	push ax
	call kbhit
	pop  ax
	jz   DJPTF
	fgetch
	;========================================
	cmp ah, FlechaArriba
	jz  DJFA
	cmp ah, FlechaAbajo
	jz  DJFB
	cmp ah, TeclaA
	jz  DJTA
	cmp ah, TeclaZ
	jz  DJTZ
	cmp ah, Escape
	jz  DJPTF
	;No se ha pulsado ninguna otra tecla del juego
	jmp DJNT
	;========================================
DJTA:	call Jug1Arriba
	jmp DJPTF
DJTZ:	call Jug1Abajo
	jmp DJPTF
DJFA:	call Jug2Arriba
	jmp DJPTF
DJFB:	call Jug2Abajo
	jmp DJPTF
DJNT:	xor ax, ax
	;========================================
DJPTF:	ret
DJPulsarTecla Endp
;====================================================================================================
UnJugador Proc Near
	;========================================
	;Inicializar funcion
	mov  al, JugStdCol
	push ax
	call clrscrc402
	;========================================
	;Pedimos el nombre, la dificultad y el numero de puntos
	;========================================
	call PedirNombreJ1
	call PedirPuntos
	call PedirDificultad	

	mov  al, JugStdCol
	push ax
	call clrscrc402
	;========================================
	;Pintamos la pantalla
	;========================================
	call PintarPantalla
	call InitObjetos

	;========================================
	;Bucle principal
	;========================================
	call kbflush
Ujlp:	call HayVencedor		;Comprueba si hay un vencedor
	cmp  Vencedor, 0
	jz   Ujlpm			;0 != No hay vencedor
	jmp  Ujlpf

	;Mueve Jugador 1
Ujlpm:	call UJPulsarTecla
	cmp  ah, Escape
	jz   UJFin

	;Mueve la maquina
	call MoverMalo

	;Muve la bola
	call MoverBola

	;Vuelta a empezar el bucle
	jmp  Ujlp
	;========================================
Ujlpf:	cmp  Vencedor, 1
	jnz  Ujgj2
	call GanaJugador1
	jmp  UJFin
Ujgj2:	cmp  Vencedor, 2
	jnz  UJFin
	call GanaJugador2
	;========================================
UJFin:	mov	al, StandarCol
	push	ax
	call	clrscrc402
	ret
UnJugador Endp
;====================================================================================================
GanaJugador1 Proc Near
	;========================================
	fPutStrC40 JugMsj01C, JugMsj01F, JugBlanco
	fPutStrC40 JugMsj01C, JugMsj01F, Jug1Nombre
	fPutStrC40 JugMsj02C, JugMsj02F, JugMsj02
	;========================================
	call kbflush
	fgetch
	ret
GanaJugador1 Endp
;----------------------------------------------------------------------------------------------------
GanaJugador2 Proc Near
	;========================================
	fPutStrC40 JugMsj01C, JugMsj01F, JugBlanco
	fPutStrC40 JugMsj01C, JugMsj01F, Jug2Nombre
	fPutStrC40 JugMsj02C, JugMsj02F, JugMsj02
	;========================================
	call kbflush
	fgetch
	ret
GanaJugador2 Endp
;====================================================================================================
DosJugadores Proc Near
	;========================================
	;Inicializar funcion
	mov  al, JugStdCol
	push ax
	call clrscrc402
	;========================================
	;Pedimos el nombre, la dificultad y el numero de puntos
	;========================================
	call PedirNombreJ1
	call PedirNombreJ2
	call PedirPuntos

	mov  al, JugStdCol
	push ax
	call clrscrc402
	;========================================
	;Pintamos la pantalla
	;========================================
	call PintarPantalla
	call InitObjetos

	;========================================
	call kbflush
Djlp:	call HayVencedor		;Comprueba si hay un vencedor
	mov  al, Vencedor
	or   al, al
	jz   Djlpm			;0 != No hay vencedor
	jmp  Djlpf

	;Mueve Jugador 1 y Jugador 2
Djlpm:	call DJPulsarTecla	;J1
	cmp  ah, Escape
	jz   DJFin

	call DJPulsarTecla	;J2
	cmp  ah, Escape
	jz   DJFin

	;Muve la bola
	call MoverBola

	;Vuelta a empezar el bucle
	jmp  Djlp
	;========================================
Djlpf:	cmp  Vencedor, 1
	jnz  Djgj2
	call GanaJugador1
	jmp  DJFin
Djgj2:	cmp  Vencedor, 2
	jnz  DJFin
	call GanaJugador2
	;========================================
DJFin:	mov	al, StandarCol
	push	ax
	call	clrscrc402
	ret
DosJugadores Endp
;====================================================================================================
Creditos Proc Near
	;========================================
	;Inicializar funcion
	mov  al, StandarCol
	push ax
	call clrscrc402

        ;========================================
	;Cabecera
	;========================================
	fgotoxy CreCabXXC, CreCab01F
	fcputs CreStrCab01
	fgotoxy CreCabXXC, CreCab02F
	fcputs CreStrCab02
	fgotoxy CreCabXXC, CreCab03F
	fcputs CreStrCab03
	;========================================
	;Texto de la ayuda
	;========================================
	fgotoxy CreTxtC, CreTxtF
	fcputs CreTxt01
	;========================================
	fgetch
	ret
Creditos Endp
;====================================================================================================
Ayuda	Proc Near
	;========================================
	;Inicializar funcion
	mov  al, StandarCol
	push ax
	call clrscrc402

        ;========================================
	;Cabecera
	;========================================
	fgotoxy AyuCabXXC, AyuCab01F
	fcputs AyuStrCab01
	fgotoxy AyuCabXXC, AyuCab02F
	fcputs AyuStrCab02
	fgotoxy AyuCabXXC, AyuCab03F
	fcputs AyuStrCab03
	;========================================
	;Texto de la ayuda
	;========================================
	fgotoxy AyuTxtC, AyuTxtF
	fcputs AyuTxt01
	;========================================
	fgetch
	ret
Ayuda	Endp
;====================================================================================================
End
;====================================================================================================