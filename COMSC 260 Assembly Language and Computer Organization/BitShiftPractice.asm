; Assignment #: Lab Exercise 9
; Program Description: Practice using bit shifting operations
; Author: Ben Kahl: 2051026
; Creation Date: 4/14/2023
; Revisions: 2
; Date: 4/14/2023         Modified by: Ben Kahl

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
INCLUDE Irvine32.inc

.data
array DWORD 4BC94530h, 2CBA9429h, 4FB54386h, 69FC0544h, 5F5BE7ACh
userIn BYTE ?
prompt BYTE "Enter the number of bits shift to the left using SHLD: "

.code
main PROC
	mov edx, OFFSET prompt
	call WriteString
	mov edx, OFFSET userIn
	call readInt
	mov  bl, al
	call ShiftDoublewords

; Display the results
	mov  esi,OFFSET array
	mov  ecx,LENGTHOF array
	mov  ebx,TYPE array
	call DumpMem

	exit
main ENDP

;---------------------------------------------------------------
ShiftDoublewords PROC
;
; Shifts an array of doublewords to the left.
; The array is a global variable.
; Receives: BL = number of bits to shift
; Returns: nothing
;---------------------------------------------------------------
	mov  esi,OFFSET array
	mov  ecx,(LENGTHOF array) - 1

L1:	push ecx				; save loop counter
	mov  eax,[esi + TYPE DWORD]
	mov  CL,BL				; shift count
	shld [esi],eax,cl		
	add  esi,TYPE DWORD		
	pop  ecx					; restore loop counter
	loop L1

; Left-shift the last doubleword
	mov CL, BL
  shl DWORD PTR [esi], CL

	ret
ShiftDoublewords ENDP

END main

