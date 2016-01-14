;****************************************************************************************************
; Conio 1.1 (28-01-2004) - Libería que contiene rutinas para el manejo de la consola.
; Copyright (C) 2004  Gorka Suárez García
;
; Conio.inc is part of "Conio".
;
; "Conio" is free software; you can redistribute it and/or
; modify it under the terms of the GNU Lesser General Public
; License as published by the Free Software Foundation; either
; version 2.1 of the License, or (at your option) any later version.
;
; "Conio" is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
; Lesser General Public License for more details.
;
; You should have received a copy of the GNU Lesser General Public
; License along with "Conio"; if not, write to the Free Software
; Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
;****************************************************************************************************
; Versiones:
;    1.0 (18-01-2004) -> 27-01-2004
;    1.1 (28-01-2004) -> 29-01-2004
;****************************************************************************************************
;include conio.inc
;
;ftextmodec80
;ftextmodec40
;fclrscr
;fclrscr2 color
;fclrscrc40
;fclrscrc402 color
;fclreol
;fclreolc40
;fgotoxy x, y
;fwherexy
;fgetch
;fgetche
;fkbhit
;fkbflush
;fclock
;fdelay ms
;frandom num
;fputch car
;fputch2 car, color
;ftextbgcolor atributo, color
;ftextcolor atributo, color
;fsetnocursor
;fsetsolidcursor
;fsetnormalcursor
;fcgets
;fcputs cad
;fcputs2 cad, color
;fstrsubcpy destino, destini, origen, origini, tam
;fexit
;fendprog
;****************************************************************************************************
ConioLib macro
	Extrn textmodec80:near
	Extrn textmodec40:near
	Extrn clrscr:near
	Extrn clrscr2:near
	Extrn clrscrc40:near
	Extrn clrscrc402:near
	Extrn clreol:near
	Extrn clreolc40:near
	Extrn gotoxy:near
	Extrn wherexy:near
	Extrn getch:near
	Extrn getche:near
	Extrn kbhit:near
	Extrn kbflush:near
	Extrn clock:near
	Extrn delay:near
	Extrn delay2:near
	Extrn random:near
	Extrn putch:near
	Extrn putch2:near
	Extrn textbackground:near
	Extrn textcolor:near
	Extrn setnocursor:near
	Extrn setsolidcursor:near
	Extrn setnormalcursor:near
	Extrn cgets:near
	Extrn cgets:near
	Extrn cputs:near
	Extrn cputs2:near
	Extrn strsubcpy:near
	Extrn exit:near
	Extrn endprog:near
	Extrn PutChar:near
	Extrn PutCharC40:near
	Extrn PutAttr:near
	Extrn PutAttrC40:near
	Extrn PutStrC40:near
	Extrn PutStr2C40:near
	Extrn PutStr:near
	Extrn PutStr2:near
endm
;****************************************************************************************************
DefColores macro
		;colores oscuros
CNegro		db 00h
CAzul		db 01h
CVerde		db 02h
CCyan		db 03h
CRojo		db 04h
CMagenta	db 05h
CMarron		db 06h
CGrisClaro	db 07h
		;colores brillantes
CGris		db 08h
CAzulClaro	db 09h
CVerdeClaro	db 0Ah
CCyanClaro	db 0Bh
CRojoClaro	db 0Ch
CMagentaClaro	db 0Dh
CAmarillo	db 0Eh
CBlanco		db 0Fh
endm
;****************************************************************************************************
ftextmodec80		EQU	call textmodec80
ftextmodec40		EQU	call textmodec40
fclrscr			EQU	call clrscr
fclrscrc40		EQU	call clrscrc40
fclreol			EQU	call clreol
fclreolc40		EQU	call clreolc40
fwherexy		EQU	call wherexy
fgetch			EQU	call getch
fgetche			EQU	call getche
fkbhit			EQU	call kbhit
fkbflush		EQU	call kbflush
fclock			EQU	call clock
fsetnocursor		EQU	call setnocursor
fsetsolidcursor		EQU	call setsolidcursor
fsetnormalcursor	EQU	call setnormalcursor
fendprog		EQU	call endprog
;====================================================================================================
fclrscr2 macro color
	mov  al, color
	push ax
	call clrscr2
endm
;====================================================================================================
fclrscrc402 macro color
	mov  al, color
	push ax
	call clrscrc402
endm
;====================================================================================================
fgotoxy macro x, y
	mov  ah, x
	mov  al, y
	push ax
	call gotoxy
endm
;====================================================================================================
fdelay macro ms
	push ms
	call delay
endm
;====================================================================================================
frandom macro num
	push num
	call random
endm
;====================================================================================================
fputch macro car
	mov  al, car
	push ax
	call putch
endm
;====================================================================================================
fputch2 macro car, color
	mov  ah, color
	mov  al, car
	push ax
	call putch2
endm
;====================================================================================================
ftextbgcolor macro atributo, color
	mov  ah, atributo
	mov  al, color
	push ax
	call textbackground
	mov  atributo, al
endm
;====================================================================================================
ftextcolor macro atributo, color
	mov  ah, atributo
	mov  al, color
	push ax
	call textcolor
	mov  atributo, al
endm
;====================================================================================================
fcgets macro str
	lea  di, str
	push di
	call cgets
endm
;====================================================================================================
fcstringz macro str, pos
	lea di, str
	xor bh, bh
	mov bl, pos
	mov byte ptr [di+bx], 0
endm
;====================================================================================================
fcputs macro cad
	lea  si, cad
	push si
	call cputs
endm
;====================================================================================================
fcputs2 macro cad, color
	lea  si, cad
	push si
	mov  al, color
	push ax
	call cputs2
endm
;====================================================================================================
fstrsubcpy macro destino, destini, origen, origini, tam
	lea  ax, destino
	push ax
	lea  ax, origen
	push ax
	mov  al, destini
	mov  ah, origini
	push ax
	mov  al, tam
	push ax
	call strsubcpy
endm
;====================================================================================================
fexit macro code
	mov  al, code
	push ax
	call exit
endm
;====================================================================================================
fPutChar macro x, y, c
	mov  al, c
	push ax
	mov  ah, x
	mov  al, y
	push ax
	call PutChar
endm
;====================================================================================================
fPutCharC40 macro x, y, c
	mov  al, c
	push ax
	mov  ah, x
	mov  al, y
	push ax
	call PutCharC40
endm
;====================================================================================================
fPutAttr macro x, y, a
	mov  al, a
	push ax
	mov  ah, x
	mov  al, y
	push ax
	call PutAttr
endm
;====================================================================================================
fPutAttrC40 macro x, y, a
	mov  al, a
	push ax
	mov  ah, x
	mov  al, y
	push ax
	call PutAttrC40
endm
;====================================================================================================
fPutStrC40 macro x, y, cad
	lea	si, cad		;[bp+2]
	push	si
	mov	ah, x		;[bp+1]
	mov	al, y		;[bp]
	push	ax
	call	PutStrC40
endm
;====================================================================================================
fPutStr2C40 macro x, y, cad, att
	mov	al, att		;[bp+4]
	push	ax
	lea	si, cad		;[bp+2]
	push	si
	mov	ah, x		;[bp+1]
	mov	al, y		;[bp]
	push	ax
	call	PutStr2C40
endm
;====================================================================================================
fPutStr macro x, y, cad
	lea	si, cad		;[bp+2]
	push	si
	mov	ah, x		;[bp+1]
	mov	al, y		;[bp]
	push	ax
	call	PutStr
endm
;====================================================================================================
fPutStr2 macro x, y, cad, att
	mov	al, att		;[bp+4]
	push	ax
	lea	si, cad		;[bp+2]
	push	si
	mov	ah, x		;[bp+1]
	mov	al, y		;[bp]
	push	ax
	call	PutStr2
endm
;====================================================================================================