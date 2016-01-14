;****************************************************************************************************
; Conv 1.0 (26-01-2004) - Libería que contiene rutinas para convertir cadenas a números y al revés.
; Copyright (C) 2004  Gorka Suárez García
;
; Conv.asm is part of "Conv".
;
; "Conv" is free software; you can redistribute it and/or
; modify it under the terms of the GNU Lesser General Public
; License as published by the Free Software Foundation; either
; version 2.1 of the License, or (at your option) any later version.
;
; "Conv" is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
; Lesser General Public License for more details.
;
; You should have received a copy of the GNU Lesser General Public
; License along with "Conv"; if not, write to the Free Software
; Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
;****************************************************************************************************
Model small
Codeseg
P386N
;****************************************************************************************************
;Numeros a cadena
;====================================================================================================
;void CCadBin (char * Cad, int x)
;	lea	si, Cad		;Cad	db 33 dup(0)
;	push	si
;	push	dx
;	push	ax
;	call	CCadBin
;
		Public CCadBin
CCadBin		Proc Near
	push	bp
	mov	bp, sp
	;====================
	add	bp, 4
	mov	ax, [bp]
	mov	dx, [bp+2]
	mov	di, [bp+4]
	;====================
	;Bucle para DX
	;====================
	mov	cx, 10h
CCBBdx:	rcl	dx, 1
	jnc	CCBdx0
	mov	byte ptr [di], '1'
	jmp	CCBdx1
CCBdx0:	mov	byte ptr [di], '0'
CCBdx1:	inc	di
	dec	cx
	jnz	CCBBdx

	;====================
	;Bucle para AX
	;====================
	mov	cx, 10h
CCBBax:	rcl	ax, 1
	jnc	CCBax0
	mov	byte ptr [di], '1'
	jmp	CCBax1
CCBax0:	mov	byte ptr [di], '0'
CCBax1:	inc	di
	dec	cx
	jnz	CCBBax

	;====================
	mov	byte ptr [di], 0

	;====================
	pop	bp
	ret	6
CCadBin		Endp

;====================================================================================================
;void CCadNum (char * Cad, int x)
;	lea	si, Cad		;Cad	db 12 dup(0)
;	push	si
;	push	dx
;	push	ax
;	call	CCadNum
;
		Public CCadNum
CCadNum		Proc Near
	jmp	CCNBeg
Naux	dt 0
Naux2	dq 0
CCNBeg:	push	bp
	mov	bp, sp
	;====================
	add	bp, 4
	mov	ax, [bp]
	mov	dx, [bp+2]
	mov	di, [bp+4]
	mov	cl, 10
	;Numero a BCD mediante la FPU
	lea	si, Naux2
	mov	cs:[si], ax
	mov	cs:[si+2], dx
	fild	Naux2
	fbstp	Naux
	lea	si, Naux
	;====================
	mov	bx, 5
CCNBP:	mov	ch, cs:[si+bx-1]
	mov	cl, ch
	and	cl, 0Fh
	shr	ch, 4
	add	cl, '0'
	add	ch, '0'
	mov	[di], ch
	inc	di
	mov	[di], cl
	inc	di
	dec	bx
	jnz	CCNBP
	;Ponemos el 0 al final de la cadena
	mov	byte ptr [di], 0

	;====================
	pop	bp
	ret	6
CCadNum		Endp

;====================================================================================================
;void CCadHex (char * Cad, int x)
;	lea	si, Cad		;Cad	db 9 dup(0)
;	push	si
;	push	dx
;	push	ax
;	call	CCadHex
;
		Public CCadHex
CCadHex		Proc Near
	jmp	CCHBeg
Tab	db "0123456789ABCDEF"
CCHBeg:	push	bp
	mov	bp, sp
	;====================
	add	bp, 4
	mov	ax, [bp]
	mov	dx, [bp+2]
	mov	di, [bp+4]
	lea	si, Tab
	;====================
	;Bucle para DX
	;====================
	mov	cl, 04h
CCHBdx:	mov	bx, dx
	ror	dx, 4
	and	bx, 000Fh
	;Copia del caracter
	mov	ch, cs:[si+bx]
	mov	[di], ch
	;Actualizacion de indices
	inc	di
	dec	cl
	jnz	CCHBdx

	;====================
	;Bucle para AX
	;====================
	mov	cl, 04h
CCHBax:	mov	bx, ax
	ror	ax, 4
	and	bx, 000Fh
	;Copia del caracter
	mov	ch, cs:[si+bx]
	mov	[di], ch
	;Actualizacion de indices
	inc	di
	dec	cl
	jnz	CCHBax

	;====================
	mov	byte ptr [di], 0

	;====================
	pop	bp
	ret	6
CCadHex		Endp

;****************************************************************************************************
;Cadenas a numero
;====================================================================================================
;int CBinCad (char * Cad) //int = DX:AX
;	lea	si, Cad
;	push	si
;	call	CBinCad
;
		Public CBinCad
CBinCad		Proc Near
	push	bp
	mov	bp, sp
	;====================
	add	bp, 4
	mov	bp, si		;si = &Cad;
	xor	ax, ax		;Parte baja
	xor	dx, dx		;Parte alta
	;====================
	;Bucle de conversion
CBCB1P:	mov	bl, [si]
	or	bl, bl		;Es bl = 0?
	jz	CBCB1F		;Cad[si] = 0 -> Fin de cadena

	;Caso BL = '0'
	cmp	bl, '0'
	jnz	CBCS1E
	;Metemos por el carry un 0
	clc
	rcl	ax, 1
	rcl	dx, 1
	jmp	CBCS1F

	;Caso BL = '1'
	;Metemos por el carry un 1
CBCS1E:	stc
	rcl	ax, 1
	rcl	dx, 1

CBCS1F:	inc	si
	jmp	CBCB1P
CBCB1F:	
	;====================
	pop	bp
	ret	2
CBinCad		Endp

;====================================================================================================
;int CNumCad (char * Cad) //int = DX:AX
;	lea	si, Cad
;	push	si
;	call	CNumCad
;
		Public CNumCad
CNumCad		Proc Near
	jmp	CNCBeg
CNCNum	dq 0
CNCMul	dd 10
CNCSum	dd 0
CNCBeg:	push	bp
	mov	bp, sp
	;====================
	add	bp, 4
	mov	bp, si		;si = &Cad;
	xor	ax, ax		;Parte baja
	xor	dx, dx		;Parte alta
	lea	bp, CNCSum
	fldz			;Metemos un cero en el coprocesador
	;====================
	;Bucle de conversion
CNCB1P:	mov	bl, [si]
	or	bl, bl		;Es bl = 0?
	jz	CNCB1F		;Cad[si] = 0 -> Fin de cadena

	;Metemos el numero
	sub	bl, '0'
	mov	cs:[bp], bl
	fimul	CNCMul
	fiadd	CNCSum

	inc	si
	jmp	CNCB1P
CNCB1F:	fistp	CNCNum
	lea	bp, CNCNum
	mov	ax, cs:[bp]
	mov	dx, cs:[bp+2]
	;====================
	pop	bp
	ret	2
CNumCad		Endp

;====================================================================================================
;int CHexCad (char * Cad) //int = DX:AX
;	lea	si, Cad
;	push	si
;	call	CHexCad
;
		Public CHexCad
CHexCad		Proc Near
	push	bp
	mov	bp, sp
	;====================
	add	bp, 4
	mov	bp, si		;si = &Cad;
	xor	ax, ax		;Parte baja
	xor	dx, dx		;Parte alta
	;====================
	;Bucle de conversion
CHCB1P:	mov	bl, [si]
	or	bl, bl		;Es bl = 0?
	jz	CHCB1F		;Cad[si] = 0 -> Fin de cadena

	;====================
	;Caso BL == '0'..'9'
	;====================
	;Si bl < '0' -> error
	cmp	bl, '0'
	jb	CHCLet
	;Si bl > '9' -> error
	cmp	bl, '9'
	ja	CHCLet
	;Si no hay error
	sub	bl, '0'
	jmp	CHCNum

	;====================
	;Caso BL == 'A'..'F'
	;====================
	;Si bl < 'A' -> error
CHCLet:	cmp	bl, 'A'
	jb	CHCLeM
	;Si bl > 'F' -> error
	cmp	bl, 'F'
	ja	CHCLeM
	;Si no hay error
	sub	bl, 'A'
	add	bl, 0Ah
	jmp	CHCNum

	;====================
	;Caso BL == 'a'..'f'
	;====================
	;Si bl < 'a' -> error
CHCLeM:	cmp	bl, 'a'
	jb	CHCErr
	;Si bl > 'f' -> error
	cmp	bl, 'f'
	ja	CHCErr
	;Si no hay error
	sub	bl, 'a'
	add	bl, 0Ah
	jmp	CHCNum

	;====================
	;Caso BL == Vete tu a saber...
	;====================
CHCErr:	xor	bl, bl		;BL = 0

	;====================
	;Metemos el numero
	;====================
	;Movemos 4 posiciones de a la izquierda del numero
CHCNum:	clc		;Rotacion 01
	rcl	ax, 1
	rcl	dx, 1
	clc		;Rotacion 02
	rcl	ax, 1
	rcl	dx, 1
	clc		;Rotacion 03
	rcl	ax, 1
	rcl	dx, 1
	clc		;Rotacion 04
	rcl	ax, 1
	rcl	dx, 1

	or	al, bl	;AL += BL

	inc	si
	jmp	CHCB1P
CHCB1F:	
	;====================
	pop	bp
	ret	2
CHexCad		Endp

;****************************************************************************************************
End
;****************************************************************************************************