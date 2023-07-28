; Assignment #: Lab Exercise 7
; Program Description: Take 2 hexadecimal integers and perform and display boolean operations
; Author: Ben Kahl: 2051026
; Creation Date: 3/23/2023
; Revisions: 1
; Date: 3/23/2023       Modified by: Ben Kahl

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
Include Irvine32.inc
.data
; declare variables here
first BYTE "Input the first 32-bit hexadecimal operand: ",0
second BYTE "Input the second 32-bit hexadecimal operand: ",0
result BYTE "The 32-bit hexadecimal result is: ",0
andIns BYTE "Boolean AND",0
orIns  BYTE "Boolean OR",0
notIns BYTE "Boolean NOT",0
xorIns BYTE "Boolean XOR",0
userIn DWORD ?
.code
main PROC
	; write your code here
	mov edx, OFFSET first
	call WriteString
	mov edx, OFFSET userIn
	call ReadHex
	mov ebx, eax
	mov edx, OFFSET second
	call WriteString
	mov edx, OFFSET userIn
	call ReadHex
	call Crlf
	call AND_op
	call OR_op
	call NOT_op
	call XOR_op
	INVOKE ExitProcess,0
main ENDP
; (insert additional procedures here)
AND_op PROC USES eax ebx
	mov edx, OFFSET andIns
	call WriteString
	call Crlf
	AND eax, ebx
	mov edx, OFFSET result
	call WriteString
	call WriteHex
	call Crlf
	ret
AND_op ENDP

OR_op PROC USES eax ebx
	mov edx, OFFSET orIns
	call WriteString
	call Crlf
	OR eax, ebx
	mov edx, OFFSET result
	call WriteString
	call WriteHex
	call Crlf
	ret
OR_op ENDP

NOT_op PROC USES eax ebx
	mov edx, OFFSET notIns
	call WriteString
	call Crlf
	NOT ebx
	mov edx, OFFSET result
	call WriteString
	mov eax, ebx
	call WriteHex
	call Crlf
	ret
NOT_op ENDP

XOR_op PROC USES eax ebx
	mov edx, OFFSET xorIns
	call WriteString
	call Crlf
	XOR eax, ebx
	mov edx, OFFSET result
	call WriteString
	call WriteHex
	call Crlf
	ret
XOR_op ENDP
END main
