; Assignment #: Lab Exercise 10
; Program Description:  Create and test a procedure named Extended_Sub that
; subtracts two binary integers of arbitrary size. Restrictions: The
; storage size of the two integers must be the same, and their size
; must be a multiple of 32 bits.
; Author: Ben Kahl: 2051026
; Creation Date: 4/20/23
; Revisions: 1
; Date: 4/20/23       Modified by: Ben Kahl

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
INCLUDE Irvine32.inc

.data
op1 QWORD 0A2B2A40674981234h
op2 QWORD 08010870000234502h
result QWORD 1 DUP(0)			; = 22A21D067474CD32h

msg BYTE "The difference equals ",0

; Count the number of doublewords in each operand.
DoubleWords = SIZEOF op1 / TYPE DWORD

.code
main PROC

	mov  esi, OFFSET op1		; first operand
	mov  edi, OFFSET op2		; second operand
	mov  ebx, OFFSET result		; result
	mov  ecx, DoubleWords		; number of doublewords
	call Extended_Sub

	mov	edx, OFFSET msg		; message to display
	call WriteString

	mov	esi, OFFSET result		; starting address of result
	add	esi, DoubleWords * 4	; move to end of last dword in result
	mov	ecx, DoubleWords		; number of doublewords

L1:	sub	esi, TYPE DWORD		; previous dword (little endian order)
	mov	eax, [esi]			; get 32 bits of result
	call WriteHex				; display on the screen
	loop L1

	call Crlf
	exit
main ENDP

;--------------------------------------------------------
Extended_Sub PROC
;
; Subtracts two binary integers whose size is a multiple
; of 32-bits.
; Receives: ESI and EDI point to the two integers,
; 	EBX points to a variable that will hold the result, and
; 	ECX indicates the size of operands (multiple of 32 bits).
; Returns: nothing
;--------------------------------------------------------
;fill out the procedure implementation
	L1:
	mov eax, [esi]		; prepare eax and edx for subtration
	mov edx, [edi]
	sub eax, edx		; perform lower half subtraction
	sbb eax, 0		; perform upper half subtraction
	mov [ebx], eax		; store the result
	add esi, TYPE DWORD	; iterate registers
	add edi, TYPE DWORD
	add ebx, TYPE DWORD
	loop L1
	ret
Extended_Sub ENDP

END main
