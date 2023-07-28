; Assignment #: 10
; Program Description: Demonstration of adding packed integers.
; Author: Ben Kahl: 2051026
; Creation Date: 4/22/23
; Revisions: 4
; Date: 4/22/23         Modified by: Ben Kahl

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
INCLUDE Irvine32.inc

.data
packed_1a WORD 4536h
packed_1b WORD 7297h
sum_1 DWORD 0

packed_2a DWORD 67345620h
packed_2b DWORD 54496342h
sum_2 DWORD 2 DUP(0)

packed_3a QWORD 6734562000346521h
packed_3b QWORD 5449634205738261h
sum_3 DWORD 3 DUP(0)

.code
main PROC
; Initialize sum and index.
	mov esi, OFFSET packed_1a
	mov edi, OFFSET packed_1b
	mov edx, OFFSET sum_1
	mov ecx, (SIZEOF packed_1a / TYPE WORD)
	call AddPacked
; Display the sum in hexadecimal.	
	mov	eax,sum_1
	call	WriteHex
	call	Crlf

; Initialize sum and index.
	mov esi, OFFSET packed_2a
	mov edi, OFFSET packed_2b
	mov edx, OFFSET sum_2
	mov ecx, 2
	call AddPacked
; Display the sum in hexadecimal.	
	mov esi, OFFSET sum_2
	add esi, ((SIZEOF sum_2 / TYPE DWORD)*4)
	mov ecx, (SIZEOF sum_2 / TYPE DWORD)
L1:
	sub	esi, TYPE DWORD
	mov eax, [esi]
	call	WriteHex
	loop L1
	call	Crlf

; Initialize sum and index.
	mov esi, OFFSET packed_3a
	mov edi, OFFSET packed_3b
	mov edx, OFFSET sum_3
	mov ecx, 4
	call AddPacked
; Display the sum in hexadecimal.	
	mov esi, OFFSET sum_3
	add esi, ((SIZEOF sum_3 / TYPE DWORD)*4)
	mov ecx, (SIZEOF sum_3 / TYPE DWORD)
L2:
	sub	esi, TYPE DWORD
	mov eax, [esi]
	call	WriteHex
	loop L2
	call	Crlf
	call WaitMsg
	exit
main ENDP

AddPacked PROC 	
L1:
; Add low bytes.
	clc
	mov	al, BYTE PTR [esi]
	add	al, BYTE PTR [edi]
	daa
	mov	BYTE PTR [edx],al
	
; Add high bytes, include carry.
	inc	esi
	inc	edi
	inc	edx
	mov	al, BYTE PTR [esi]
	adc	al, BYTE PTR [edi]
	daa
	mov	BYTE PTR [edx],al

; Add final carry, if any.
	mov	al,0
	adc	al,0
	inc	edx
	mov	BYTE PTR [edx],al
	inc esi
	inc edi
loop L1
	ret
AddPacked ENDP

END main