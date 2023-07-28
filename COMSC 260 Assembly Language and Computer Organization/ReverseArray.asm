; Assignment 4
; Program Description: Reverse and reverse back an array of integers in play with loops using indexed and indirect addressing.
; Author: Ben Kahl: 2051026
; Creation Date: 3/5/2023
; Revisions: 3
; Date: 3/5/2023             Modified by: Ben Kahl

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
arrayD DWORD 100,200,250,300,500,600,700,900,1000,1200,2000,3000	; Reverse: 3000,2000,1200,1000,900,700,600,500,300,250,200,100
.code
main PROC
	mov esi,0				; Set to 0 to use index addressing
	mov edi, SIZEOF arrayD
	add edi, OFFSET arrayD	
	sub edi, TYPE arrayD	; EDI is now pointing to the end of the array
	mov ecx, LENGTHOF arrayD	; Set the loop counter
	L1:
	mov eax, arrayD[esi]	; Store the front
	mov ebx, [edi]			; Store the back
	mov [edi], eax			; move the front to the back
	mov arrayD[esi],ebx			; move the back to the front
	add esi, TYPE arrayD	; move to the next element in the array
	sub edi, TYPE arrayD	; move to the previous element in the array
	loop L1				; Because ECX is set to the full size of the array, 
						; it is properly sized to reverse and reverse again in the same loop
						; ECX/2 times reverses the array, ECX reverses twice
	INVOKE ExitProcess,0
main ENDP

END main
