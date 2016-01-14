;****************************************************************************************************
; Conio 1.1 (28-01-2004) - Libería que contiene rutinas para el manejo de la consola.
; Copyright (C) 2004  Gorka Suárez García
;
; Conio.asm is part of "Conio".
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
Model small
Codeseg
P386N
;====================================================================================================
;void textmodec80 (void)
;
;	call textmodec80
;
		Public textmodec80
textmodec80 	Proc Near
	;====================
	mov	al, 03h
	mov	ah, 00h
	int	10h
	;====================
	ret
textmodec80	Endp

;====================================================================================================
;void textmodec40 (void)
;
;	call textmodec40
;
		Public textmodec40
textmodec40	Proc Near
	;====================
	mov	al, 01h
	mov	ah, 00h
	int	10h
	;====================
	ret
textmodec40	Endp

;====================================================================================================
;void clrscr (void)
;
;	call clrscr
;
		Public clrscr
clrscr		Proc Near
	;====================
	mov	dh, 0
	mov	dl, 0
	mov	ah, 02h
	int	10h

	mov	al, ' '
	mov	bh, 00h
	mov	bl, 07h
	mov	cx, 2000
	mov	ah, 09h
	int	10h
	;====================
	ret
clrscr		Endp

;
;	mov  al, color
;	push ax
;	call clrscr2
;
		Public clrscr2
clrscr2		Proc Near
	push	bp
	mov	bp, sp
	add	bp, 4		;apuntamos al color
	;====================
	mov	dh, 0
	mov	dl, 0
	mov	ah, 02h
	int	10h

	mov	al, ' '
	mov	bh, 00h
	mov	bl, [bp]	;= color
	mov	cx, 2000
	mov	ah, 09h
	int 10h
	;====================
	pop	bp
	ret	2
clrscr2		Endp

;
;	call clrscrc40
;
		Public clrscrc40
clrscrc40	Proc Near
	;====================
	mov	dh, 0
	mov	dl, 0
	mov	ah, 02h
	int	10h

	mov	al, ' '
	mov	bh, 00h
	mov	bl, 07h
	mov	cx, 1000
	mov	ah, 09h
	int	10h
	;====================
	ret
clrscrc40	Endp

;
;	mov  al, color
;	push ax
;	call clrscrc402
;
		Public clrscrc402
clrscrc402	Proc Near
	push	bp
	mov	bp, sp
	add	bp, 4		;apuntamos al color
	;====================
	mov	dh, 0
	mov	dl, 0
	mov	ah, 02h
	int	10h

	mov	al, ' '
	mov	bh, 00h
	mov	bl, [bp]	;=color
	mov	cx, 1000
	mov	ah, 09h
	int	10h
	;====================
	pop	bp
	ret	2
clrscrc402	Endp

;====================================================================================================
;void clreol (void)
;
;	call clreol
;
		Public clreol
clreol		Proc Near
	;====================
	mov	bh, 00h
	mov	ah, 03h
	int	10h
	mov	dh, 80
	sub	dh, dl
	shr	dx, 4
	
	mov	al, ' '
	mov	bh, 00h
	mov	bl, 07h
	mov	cx, dx
	mov	ah, 09h
	int	10h
	;====================
	ret
clreol		Endp

;
;	call clreolc40
;
		Public clreolc40
clreolc40	Proc Near
	;====================
	mov	bh, 00h
	mov	ah, 03h
	int	10h
	mov	dh, 40
	sub	dh, dl
	shr	dx, 4
	
	mov	al, ' '
	mov	bh, 00h
	mov	bl, 07h
	mov	cx, dx
	mov	ah, 09h
	int	10h
	;====================
	ret
clreolc40	Endp

;====================================================================================================
;void gotoxy (word x, word y)	//DL=X, DH=Y
;
;	mov  dh, x
;	mov  dl, y
;	push dx
;	call clreol
;
		Public gotoxy
gotoxy		Proc Near
	push	bp
	mov	bp, sp
	add	bp, 4
	;====================
	mov	dh, [bp]
	mov	dl, [bp+1]
	mov	ah, 02h
	int	10h
	;====================
	pop	bp
	ret	2
gotoxy		Endp

;====================================================================================================
;word wherexy (void)	//DL=X, DH=Y o AH=X, AL=Y
;
;	call wherexy
;
		Public wherexy
wherexy		Proc Near
	;====================
	mov	bh, 00h
	mov	ah, 03h
	int	10h
	mov	ah, dl
	mov	al, dh
	;====================
	ret
wherexy		Endp

;====================================================================================================
;word getch (void) //AH = Codigo busqueda, AL = Codigo ASCII
;
;	call getch
;
		Public getch
getch		Proc Near
	;====================
	mov ah, 10h
	int 16h
	;====================
	ret
getch		Endp

;====================================================================================================
;word getche (void) //AH = Codigo busqueda, AL = Codigo ASCII
;
;	call getche
;
		Public getche
getche		Proc Near
	;====================
	mov	ah, 10h
	int	16h

	mov	dx, ax

	mov	bh, 00h
	mov	bl, 07h
	mov	cx, 1
	mov	ah, 0Eh
	int	10h

	mov	ax, dx
	;====================
	ret
getche		Endp

;====================================================================================================
;bool kbhit (void) ;al = 0 (buff vacio), al = 255 (buff no vacio)
;
;	call kbhit
;
		Public kbhit
kbhit		Proc Near
	;====================
	mov	ah, 0Bh
	int	21h
	or	al, al
	;====================
	ret
kbhit		Endp

;====================================================================================================
;void kbflush (void)
;
;	call kbflush
;
		Public kbflush
kbflush		Proc Near
	;====================
	mov	al, 00h
	mov	ah, 0Ch
	int	21h
	;====================
	ret
kbflush		Endp

;====================================================================================================
;dword clock (void) //=CX:DX
;
;	call clock
;
		Public clock
clock		Proc Near
	;====================
	mov	ah, 00h
	int	1Ah
	;====================
	ret
clock		Endp

;====================================================================================================
;void delay (word ms)
;
;	push ms
;	call delay
;
		Public delay
delay		Proc Near
	push	bp
	mov	bp, sp
	add	bp, 4
	;========================================
	;Iniciamos el sistema de retardo
	;========================================
	in	al, 61h		;Leemos del puerto 61, que nos da la Gate del Timer 2 del 8253/8254
	and	al, 0FDh	;11111101 = Con esto desconectamos la conexion con el speaker
	or	al, 01h		;Activamos la Gate del Timer 2
	jmp	short $+2	;Ver la nota abajo
	out	61h, al		;Escribimos el puerto 61, para cargar las modificaciones
	mov	al, 0B4h	;10110100 = Timer 2, L/E LByte+HByte, modo 2, binario
	jmp	short $+2	;Ver la nota abajo
	out	43h, al		;Metemos en el 8253 el nuevo modo para el timer dos

	;========================================
	;Delay (ms)
	;========================================
	mov	cx, [bp]	;Cargamos los ms en CX

	;========================================
	;Retardo de un milisegundo
	;========================================
delaybuclecx:
	;Cargamos el numero de cliclos equivalente a un milisegundo (1193.18 ciclos)
	cli			;Desactivamos las interrupciones
	mov	ax, 1193
	out	42h, al		;Mandamos la parte baja del numero (A9h)
	mov	al, ah		;Pasamos a AL, la parte alta de AX
	jmp	short $+2	;Ver la nota abajo
	out	42h, al		;Mandamos la parte alta del numero (04h)
	jmp	short $+2	;Ver la nota abajo
	in	al, 61h		;Leemos el puerto 61h para leer el estado de la Gate
	xor	al, 01h		;Bajamos la GATE
	jmp	short $+2	;Ver la nota abajo
	out	61h, al		;Cargamos la nueva GATE bajada
	xor	al, 01h		;Subimos la GATE
	jmp	short $+2	;Ver la nota abajo
	out	61h, al		;Cargamos la nueva GATE subida
	sti			;Activamos las interrupciones
	jmp	short $+2	;Ver la nota abajo

	;Comprobamos con este bucle de aqui que el contador ha llegado a su fin
	mov	bx, 0FFFFh
retard:	mov	al, 80h
	out	43h, al		;Counter Latch Command <- Almacena en un buffer el valor del Timer 2
	jmp	short $+2	;Ver la nota abajo
	in	al, 42h		;Leemos la parte baja del contador
	mov	dl, al
	jmp	short $+2	;Ver la nota abajo
	in	al, 42h		;Leemos la parte alta del contador
	mov	dh, al		;DX = Valor del contador
	cmp	dx, bx
	mov	bx, dx
	jbe	retard
	;========================================
	dec	cx
	jnz	delaybuclecx

	;========================================
	pop	bp
	ret	2
delay		Endp
;====================================================================================================
;Nota: jmp short $+2, evita que las maquinas AT mas antiguas fallen en dos operaciones de E/S
;consecutivas demasiado rapidas.
;====================================================================================================
;Retardos de 55ms como minimo
;
;	push ms
;	call delay
;
		Public delay2
delay2		Proc Near
	jmp	delayi
delayst0	dd 54.9451
delayst1	dw 0
delayi:	push	bp
	mov	bp, sp
	add	bp, 4
	;====================
	mov	ax, [bp]
	mov	CS:delayst1, ax
	fild	delayst1
	fdiv	delayst0
	fistp	delayst1
	mov	ax, CS:[delayst1]
	mov	[bp], ax
	;--------------------
	call	clock
	mov	di, cx		;Tiempo inicial
	mov	si, dx
delayb:	call	clock
	mov	ax, di
	mov	bx, si
	sub	dx, bx
	sbb	cx, ax
	cmp	dx, [bp]
	jb	short delayb
	;====================
	pop	bp
	ret	2
delay2		Endp

;====================================================================================================
;int random (int num) = 0..Num-1
;
;	push num
;	call random
;
		Public random
random		Proc Near
	push	bp
	mov	bp, sp
	add	bp, 4
	;========================================
	;Leemos lo que marca el timer 2
	;========================================
	in	al, 42h		;Tiempo Mod 101 = 0..100 = Porcentaje
	mov	ah, al
	in	al, 42h
	mov	al, ah
	xor	ah, ah
	mov	bl, 101
	div	bl
	;Numero * Porcentaje / 100 -> AX
	mov	cx, 100
	mov	bl, ah
	xor	bh, bh
	xor	dx, dx
	mov	ax, [bp]
	mul	bx
	div	cx
	;========================================
	pop	bp
	ret	2
random		Endp

;====================================================================================================
;void putch (word car)
;
;	mov  al, car
;	push ax
;	call putch
;
		Public putch
putch		Proc Near
	push	bp
	mov	bp, sp
	add	bp, 4
	;====================
	mov	al, [bp]	;=car
	mov	bh, 00h
	mov	bl, 07h
	mov	cx, 1
	mov	ah, 0Eh
	int	10h
	;====================
	pop	bp
	ret	2
putch		Endp

;
;	mov  ah, color
;	mov  al, car
;	push ax
;	call putch2
;
		Public putch2
putch2		Proc Near
	push	bp
	mov	bp, sp
	add	bp, 4
	;====================
	mov	al, [bp]	;=car
	mov	bh, 00h
	mov	bl, [bp+1]	;=color
	mov	cx, 1
	mov	ah, 09h
	int	10h

	mov	al, [bp]	;=car
	mov	ah, 0Eh
	int	10h
	;====================
	pop	bp
	ret	2
putch2		Endp

;====================================================================================================
;void textbackground (byte newcolor)
;
;	mov  ah, atributo
;	mov  al, color
;	push ax
;	call textbackground
;
		Public textbackground
textbackground	Proc Near
	push	bp
	mov	bp, sp
	add	bp, 4
	;====================
	mov	al, [bp+1]	;=atributo
	and	al, 00Fh	;0000AAAA
	mov	ah, [bp]	;=color
	and	ah, 07h		;00000CCC
	shl	ah, 4		;0CCC0000
	or	al, ah		;0CCCAAAA -> AL
	xor	ah, ah
	;====================
	pop	bp
	ret	2
textbackground	Endp

;====================================================================================================
;void textcolor (byte newcolor)
;
;	mov  ah, atributo
;	mov  al, color
;	push ax
;	call textcolor
;
		Public textcolor
textcolor	Proc Near
	push	bp
	mov	bp, sp
	add	bp, 4
	;====================
	mov	al, [bp+1]	;=atributo
	and	al, 0F0h	;AAAA0000
	mov	ah, [bp]	;=color
	and	ah, 0Fh		;0000CCCC
	or	al, ah		;AAAACCCC -> AL
	xor	ah, ah
	;====================
	pop	bp
	ret	2
textcolor	Endp

;====================================================================================================
;void setnocursor     (void)
;void setsolidcursor  (void)
;void setnormalcursor (void)
;
;	call setnocursor
;
		Public setnocursor
setnocursor	Proc Near
	;====================
	mov ch, 01h
	mov cl, 00h
	mov ah, 01h
	int 10h
	;====================
	ret
setnocursor	Endp

;
;	call setsolidcursor
;
		Public setsolidcursor
setsolidcursor	Proc Near
	;====================
	mov	ch, 01h
	mov	cl, 07h
	mov	ah, 01h
	int	10h
	;====================
	ret
setsolidcursor	Endp

;
;	call setnormalcursor
;
		Public setnormalcursor
setnormalcursor	Proc Near
	;====================
	mov	ch, 06h
	mov	cl, 07h
	mov	ah, 01h
	int	10h
	;====================
	ret
setnormalcursor	Endp

;====================================================================================================
;char * cgets (char * str)
;CadBuf	db 0 		;Tmax
;	db 0 		;Tact
;Cadena	db 0 dup(0)	;Cadena
;
;	push offset cad
;	call cgets
;
		Public cgets
cgets		Proc Near
	push	bp
	mov	bp, sp
	add	bp, 4
	;====================
	mov	dx, [bp]
	mov	ah, 0Ah
	int	21h
	;Poner cero al final
	mov	di, [bp]
	xor	bh, bh
	mov	bl, [di+1]
	mov	byte ptr [di+bx+2], 0
	;====================
	pop	bp
	ret	2
cgets		Endp

;====================================================================================================
;int cputs (const char * str)
;
;	push offset cad
;	call cputs
;
		Public cputs
cputs		Proc Near
	push	bp
	mov	bp, sp
	add	bp, 4
	;====================
	mov	si, [bp]
cputsa:	mov	al, [si]
	mov	bh, 00h
	mov	bl, 07h
	mov	cx, 1
	mov	ah, 0Eh
	int	10h

	inc	si
	mov	dl, [si]
	or	dl, dl
	jnz	short cputsa
	;====================
	pop	bp
	ret	2
cputs		Endp

;
;	push offset cad
;	mov  al, color
;	push ax
;	call cputs2
;
		Public cputs2
cputs2		Proc Near
	push	bp
	mov	bp, sp
	add	bp, 4
	;====================
	mov	si, [bp+2]	;= cad
	xor	cx, cx
cputsc:	inc	cx
	inc	si
	mov	dl, [si]
	or	dl, dl
	jnz	short cputsc

	mov	al, ' '
	mov	bh, 00h
	mov	bl, [bp]	;= color
	mov	ah, 09h
	int	10h
	;--------------------
	mov	si, [bp+2]	;= cad
cputsb:	mov	al, [si]
	mov	bh, 00h
	mov	bl, 07h
	mov	cx, 1
	mov	ah, 0Eh
	int	10h

	inc	si
	mov	dl, [si]
	or	dl, dl
	jnz	short cputsb
	;====================
	pop	bp
	ret	4
cputs2		Endp

;====================================================================================================
;void strsubcpy (destino, destini, origen, origini, tam)
;
;	mov  ax, offset destino	;[bp+6]
;	push ax
;	mov  ax, offset origen	;[bp+4]
;	push ax
;	mov  al, destini	;[bp+2]
;	mov  ah, origini	;[bp+3]
;	push ax
;	mov  al, tam		;[bp]
;	push ax
;	call strsubcpy
;
		Public strsubcpy
strsubcpy	Proc Near
	push	bp
	mov	bp, sp
	add	bp, 4
	;====================
	mov	di, [bp+6]	;=destino
	mov	si, [bp+4]	;=origen
	xor	ah, ah
	mov	al, [bp+2]	;=destini
	add	di, ax
	xor	ah, ah
	mov	al, [bp+3]	;=origini
	add	si, ax
	xor	cx, cx
strscb:	mov	dl, [si]
	mov	[di], dl
	inc	di
	inc	si
	inc	cx
	cmp	cl, [bp]	;=tam
	jnz	short strscb
	;====================
	pop	bp
	ret	8
strsubcpy	Endp

;====================================================================================================
;void exit (byte code)
;
;	mov  al, code
;	push ax
;	call exit
;
		Public exit
exit		Proc Near
	push	bp
	mov	bp, sp
	add	bp, 4		;apuntamos al color
	;====================
	mov	al, [bp]	;=codigo
	mov	ah, 4Ch
	int	21h
	;====================
	pop	bp
	ret	2
exit		Endp

;====================================================================================================
;void endprog (void)
;
;	call endprog
;
		Public endprog
endprog		Proc Near
	;====================
	xor al, al
	mov ah, 4Ch
	int 21h
	;====================
	ret
endprog		Endp
;****************************************************************************************************
;
;	lea	si, cad		;[bp+2]
;	push	si
;	mov	ah, x		;[bp+1]
;	mov	al, y		;[bp]
;	push	ax
;	call	PutStrC40
;
		Public PutStrC40
PutStrC40	Proc Near
	push	bp
	mov	bp, sp
	add	bp, 4
	;====================
	mov	si, [bp+2]
PSC4a:	mov	al, [si]
	push	ax
	mov	ah, [bp+1]
	mov	al, [bp]
	push	ax
	call	PutCharC40
	;====================
	inc	si
	mov	ah, [bp+1]
	inc	ah
	;Si x < 80 -> No hacer nada
	cmp	ah, 80
	jb	PSNC4
	mov	ah, 0
	mov	al, [bp]
	inc	al
	mov	[bp], al
PSNC4:	mov	[bp+1], ah
	mov	dl, [si]
	or	dl, dl
	jnz	short PSC4a
	;====================
	pop	bp
	ret	4
PutStrC40	Endp
;----------------------------------------------------------------------------------------------------
;
;	mov	al, att		;[bp+4]
;	push	ax
;	lea	si, cad		;[bp+2]
;	push	si
;	mov	ah, x		;[bp+1]
;	mov	al, y		;[bp]
;	push	ax
;	call	PutStr2C40
;
		Public PutStr2C40
PutStr2C40	Proc Near
	push	bp
	mov	bp, sp
	add	bp, 4
	;====================
	mov	si, [bp+2]
PS2C4a:	mov	al, [si]
	push	ax
	mov	ah, [bp+1]
	mov	al, [bp]
	push	ax
	call	PutCharC40
	mov	al, [bp+4]
	push	ax
	mov	ah, [bp+1]
	mov	al, [bp]
	push	ax
	call	PutAttrC40
	;====================
	inc	si
	mov	ah, [bp+1]
	inc	ah
	;Si x < 80 -> No hacer nada
	cmp	ah, 80
	jb	PSNC4
	mov	ah, 0
	mov	al, [bp]
	inc	al
	mov	[bp], al
PS2NC4:	mov	[bp+1], ah
	mov	dl, [si]
	or	dl, dl
	jnz	short PS2C4a
	;====================
	pop	bp
	ret	6
PutStr2C40	Endp
;====================================================================================================
;
;	mov  al, char
;	push ax
;	mov  ah, x
;	mov  al, y
;	push ax
;	call PutChar
;		o
;	call PutCharC40
;
;	??	-> [bp+3]
;	char	-> [bp+2]
;	x	-> [bp+1]
;	y	-> [bp]
;
		Public PutChar
PutChar		Proc Near
	push	bp
	mov	bp, sp
	add	bp, 4
	;====================
	mov	ax, 0B800h
	mov	es, ax
	xor	ah, ah
	mov	al, [bp]
	mov	bx, 160
	mul	bx
	mov	di, ax
	xor	ah, ah
	mov	al, [bp+1]
	shl	ax, 1
	add	di, ax
	mov	al, [bp+2]
	mov	byte ptr es:[di], al
	;====================
	pop	bp
	ret	4
PutChar		Endp
;----------------------------------------------------------------------------------------------------
		Public PutCharC40
PutCharC40	Proc Near
	push	bp
	mov	bp, sp
	add	bp, 4
	;====================
	mov	ax, 0B800h
	mov	es, ax
	xor	ah, ah
	mov	al, [bp]
	mov	bx, 80
	mul	bx
	mov	di, ax
	xor	ah, ah
	mov	al, [bp+1]
	shl	ax, 1
	add	di, ax
	mov	al, [bp+2]
	mov	byte ptr es:[di], al
	;====================
	pop	bp
	ret	4
PutCharC40	Endp
;====================================================================================================
;
;	lea	si, cad		;[bp+2]
;	push	si
;	mov	ah, x		;[bp+1]
;	mov	al, y		;[bp]
;	push	ax
;	call	PutStr
;
		Public PutStr
PutStr		Proc Near
	push	bp
	mov	bp, sp
	add	bp, 4
	;====================
	mov	si, [bp+2]
PSa:	mov	al, [si]
	push	ax
	mov	ah, [bp+1]
	mov	al, [bp]
	push	ax
	call	PutChar
	;====================
	inc	si
	mov	ah, [bp+1]
	inc	ah
	;Si x < 80 -> No hacer nada
	cmp	ah, 80
	jb	PSNC4
	mov	ah, 0
	mov	al, [bp]
	inc	al
	mov	[bp], al
PSNada:	mov	[bp+1], ah
	mov	dl, [si]
	or	dl, dl
	jnz	short PSa
	;====================
	pop	bp
	ret	4
PutStr		Endp
;----------------------------------------------------------------------------------------------------
;
;	mov	al, att		;[bp+4]
;	push	ax
;	lea	si, cad		;[bp+2]
;	push	si
;	mov	ah, x		;[bp+1]
;	mov	al, y		;[bp]
;	push	ax
;	call	PutStr2
;
		Public PutStr2
PutStr2		Proc Near
	push	bp
	mov	bp, sp
	add	bp, 4
	;====================
	mov	si, [bp+2]
PS2a:	mov	al, [si]
	push	ax
	mov	ah, [bp+1]
	mov	al, [bp]
	push	ax
	call	PutChar
	mov	al, [bp+4]
	push	ax
	mov	ah, [bp+1]
	mov	al, [bp]
	push	ax
	call	PutAttr
	;====================
	inc	si
	mov	ah, [bp+1]
	inc	ah
	;Si x < 80 -> No hacer nada
	cmp	ah, 80
	jb	PSNC4
	mov	ah, 0
	mov	al, [bp]
	inc	al
	mov	[bp], al
PS2Nad:	mov	[bp+1], ah
	mov	dl, [si]
	or	dl, dl
	jnz	short PS2a
	;====================
	pop	bp
	ret	6
PutStr2		Endp
;====================================================================================================
;
;	mov  al, attr
;	push ax
;	mov  ah, x
;	mov  al, y
;	push ax
;	call PutAttr
;		o
;	call PutAttrC40
;
;	??	-> [bp+3]
;	attr	-> [bp+2]
;	x	-> [bp+1]
;	y	-> [bp]
;
		Public PutAttr
PutAttr		Proc Near
	push	bp
	mov	bp, sp
	add	bp, 4
	;====================
	mov	ax, 0B800h
	mov	es, ax
	xor	ah, ah
	mov	al, [bp]
	mov	bx, 160
	mul	bx
	mov	di, ax
	xor	ah, ah
	mov	al, [bp+1]
	shl	ax, 1
	inc	ax
	add	di, ax
	mov	al, [bp+2]
	mov	byte ptr es:[di], al
	;====================
	pop	bp
	ret	4
PutAttr		Endp
;----------------------------------------------------------------------------------------------------
		Public PutAttrC40
PutAttrC40	Proc Near
	push	bp
	mov	bp, sp
	add	bp, 4
	;====================
	mov	ax, 0B800h
	mov	es, ax
	xor	ah, ah
	mov	al, [bp]
	mov	bx, 80
	mul	bx
	mov	di, ax
	xor	ah, ah
	mov	al, [bp+1]
	shl	ax, 1
	inc	ax
	add	di, ax
	mov	al, [bp+2]
	mov	byte ptr es:[di], al
	;====================
	pop	bp
	ret	4
PutAttrC40	Endp
;****************************************************************************************************
End
;****************************************************************************************************