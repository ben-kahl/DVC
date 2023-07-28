; Assignment #: 11
; Program Description: A recursive implementation of Euclid's algorithm for finding the GCD of 2 integers
; Author: Ben Kahl: 2051026
; Creation Date: 4/30/2023
; Revisions: 3
; Date: 4/30/2023        Modified by: Ben Kahl

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
INCLUDE Irvine32.inc
.data
messageA BYTE "Greatest common divisor of 35 and 15 is: ",0
messageB BYTE "Greatest common divisor of 72 and 18 is: ",0
messageC BYTE "Greatest common divisor of 31 and 17 is: ",0
messageD BYTE "Greatest common divisor of 128 and 640 is: ",0
messageE BYTE "Greatest common divisor of 121 and 0 is: ",0
temp DWORD ?

.code
main PROC
	mov edx, OFFSET messageA
	call WriteString
	mov ebx, 35
	mov edx, 15
	call findGCD
	call WriteDec
	call CRLF
	
	mov edx, OFFSET messageB
	call WriteString
	mov ebx, 72
	mov edx, 18
	call findGCD
	call WriteDec
	call CRLF

	mov edx, OFFSET messageC
	call WriteString
	mov ebx, 31
	mov edx, 17
	call findGCD
	call WriteDec
	call CRLF

	mov edx, OFFSET messageD
	call WriteString
	mov ebx, 128
	mov edx, 640
	call findGCD
	call WriteDec
	call CRLF

	mov edx, OFFSET messageE
	call WriteString
	mov ebx, 121
	mov edx, 0
	call findGCD
	call WriteDec
	call CRLF

	call WaitMsg

	INVOKE ExitProcess,0
main ENDP

findGCD PROC
; Description: A recursive implementation of Euclid's algorithm for finding the greatest common divisor of 2 integers
; Recieves: ebx and edx, storing a and b respectively
; Returns: eax storing the result
	mov temp, edx		; save B value for division
	
	cmp ebx,0			; check for a==0
	je BGCD
	cmp edx,0			; check for b==0
	je AGCD
	mov eax, ebx
	push edx			; must save as the remainder from div will save to edx
	mov edx, 0		; prevent overflow
	div temp			; divide A(eax) by B(temp)
	
	xchg eax, edx		; store the remainder
	pop edx			; restore edx
	mov edx, eax		; update b(edx)
	mov ebx, temp		; update a(ebx)

	call findGCD
AGCD:
	mov eax, ebx	; return A if GCD
	jmp endFindGCD
BGCD:
	mov eax, edx	; return B if GCD
	jmp endFindGCD
endFindGCD:
	ret
findGCD ENDP

END main
