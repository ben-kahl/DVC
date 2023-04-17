; Assignment #: Lab Exercise 5
; Program Description: Take a user inputted string of 1 to 50 characters, then write the original and revervesed string to the console.
; Author: Ben Kahl: 2051026
; Creation Date: 3/10/2023
; Revisions: 1
; Date: 3/10/2023         Modified by: Ben Kahl

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
INCLUDE Irvine32.inc
.data
; declare variables here
instructions BYTE "Please enter a string within 50-character:"
buffer BYTE 51 DUP(0)
byteCount DWORD ?

.code
main PROC
; print the instructions
mov edx, OFFSET instructions
mov ecx, SIZEOF instructions
call WriteString
call Crlf
; print the original string in the console
mov  edx, OFFSET buffer
mov	ecx, SIZEOF buffer
call ReadString
mov byteCount, eax
mov ecx, byteCount
call WriteString
call Crlf

; Push the name on the stack.
mov	 esi, 0

L1:	movzx eax, buffer[esi]	; get character
	push eax				; push on stack
	inc	esi
	loop L1

; Pop the name from the stack in reverse
; and store it in the buffer array.

mov	 ecx, byteCount
mov	 esi, 0

L2:	pop  eax				; get character
	mov	 buffer[esi],al	; store in string
	inc	 esi
	loop L2
; print out the reversed string in the console
mov  edx, OFFSET buffer
call WriteString
call Crlf
Invoke ExitProcess,0
main endp
end main