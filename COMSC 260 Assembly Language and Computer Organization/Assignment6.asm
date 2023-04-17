; Assignment #: 6
; Program Description: Generate random length (1-100) strings with uppercase letters looped 20 times
; Author: Ben Kahl: 2051026
; Creation Date: 3/20/2023
; Revisions: 2
; Date: 3/20/2023      Modified by: Ben Kahl

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
INCLUDE Irvine32.inc
.data
buffer BYTE 101 DUP(?),0
.code
main PROC
	call Randomize			; seed the random number generator
	mov ecx, 20
	L1:
	push ecx
	mov esi, OFFSET buffer	; point to the start of the buffer array
	mov eax, 100
	call RandomRange
	inc eax				; eax is now between 1-100
	call CreateRandomString	; generate random string
	mov edx, OFFSET buffer
	call WriteString
	call Crlf
	call ClearArray		; clear array for next loop
	pop ecx
	loop L1
	INVOKE ExitProcess,0
main ENDP
CreateRandomString PROC
; Takes the range in EAX and generates a string of random uppercase characters equal to EAX
; Receives: EAX, esi
; Returns: ESI as a pointer to the byte array
; Requires: nothing
	mov ecx, eax
	; generate character A(65)-Z, storing in esi
	L2:
	mov eax, 26
	call RandomRange
	add eax, 65
	mov [esi], AL
	inc esi
	loop L2
	ret
CreateRandomString ENDP

ClearArray PROC
; Resets the array being pointed to by esi and resets all values to 0
; Receives: esi, buffer
; Returns: esi as a pointer to the cleared array
; Requires: nothing
	mov esi, OFFSET buffer
	mov ecx, 100
	mov eax, 0
	L3:
	mov [esi], eax
	inc esi
	loop L3
	ret
ClearArray ENDP
END main