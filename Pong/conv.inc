;****************************************************************************************************
; Conv 1.0 (26-01-2004) - Libería que contiene rutinas para convertir cadenas a números y al revés.
; Copyright (C) 2004  Gorka Suárez García
;
; Conv.inc is part of "Conv".
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
;include conv.inc
;
;fCCadBin Cad, Num32
;fCCadNum Cad, Num32
;fCCadHex Cad, Num32
;fCBinCad Cad
;fCNumCad Cad
;fCHexCad Cad
;====================================================================================================
ConvLib macro
	Extrn CCadBin:near
	Extrn CCadNum:near
	Extrn CCadHex:near
	Extrn CBinCad:near
	Extrn CNumCad:near
	Extrn CHexCad:near
endm
;====================================================================================================
;void CCadBin (char Cad[33], int x)
fCCadBin macro Cad, Num32
	lea	si, Cad
	push	si
	lea	si, Num32
	mov	dx, [si+2]
	mov	ax, [si]
	push	dx
	push	ax
	call	CCadBin
endm

;====================================================================================================
;void CCadNum (char Cad[12], int x)
fCCadNum macro Cad, Num32
	lea	si, Cad
	push	si
	lea	si, Num32
	mov	dx, [si+2]
	mov	ax, [si]
	push	dx
	push	ax
	call	CCadNum
endm

;====================================================================================================
;void CCadHex (char Cad[9], int x)
fCCadHex macro Cad, Num32
	lea	si, Cad
	push	si
	lea	si, Num32
	mov	dx, [si+2]
	mov	ax, [si]
	push	dx
	push	ax
	call	CCadHex
endm

;====================================================================================================
;int CBinCad (char * Cad) //int = DX:AX
fCBinCad macro Cad
	lea	si, Cad
	push	si
	call	CBinCad
endm

;====================================================================================================
;int CNumCad (char * Cad) //int = DX:AX
fCNumCad macro Cad
	lea	si, Cad
	push	si
	call	CNumCad
endm

;====================================================================================================
;int CHexCad (char * Cad) //int = DX:AX
fCHexCad macro Cad
	lea	si, Cad
	push	si
	call	CHexCad
endm

;====================================================================================================