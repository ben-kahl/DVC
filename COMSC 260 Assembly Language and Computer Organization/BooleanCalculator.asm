; Assignment #: 8
; Program Description: Boolean calculator demonstrating AND, OR, NOT, and XOR operations
; Author: Ben Kahl: 2051026
; Creation Date: 4/8/2023
; Revisions: 
; Date: 4/8/2023     Modified by: Ben Kahl

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
INCLUDE Irvine32.inc

.data
CaseTable  BYTE   '1'			; lookup value
           DWORD   AND_op		; address of procedure
		   EntrySize = ( $ - CaseTable)
           BYTE   '2'
           DWORD   OR_op
           BYTE   '3'
           DWORD   NOT_op
           BYTE   '4'
           DWORD   XOR_op
		 BYTE   '5'
		 DWORD   Process_Exit
NumberOfEntries = ( $ - caseTable) / EntrySize

header BYTE "---- Boolean Calculator ----------",0
prompt BYTE "Enter integer>",0
msgA BYTE "1. x AND y",0
msgB BYTE "2. x OR y",0
msgC BYTE "3. NOT x",0
msgD BYTE "4. x XOR y",0
msgE BYTE "5. Exit Program",0
msgInvalid BYTE "Invalid input! Enter 1 ~ 5 only",0
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
	L1:
	call Menu
	inc ecx
	loop L1
main ENDP

Menu PROC USES ecx
	mov  edx,OFFSET header		
	call WriteString
	call Crlf
	call Crlf
	mov edx, OFFSET msgA
	call WriteString
	call Crlf
	mov edx, OFFSET msgB
	call WriteString
	call Crlf
	mov edx, OFFSET msgC
	call WriteString
	call Crlf
	mov edx, OFFSET msgD
	call WriteString
	call Crlf
	mov edx, OFFSET msgE
	call WriteString
	call Crlf
	call Crlf
	mov edx, OFFSET prompt
	call WriteString
	call ReadChar				; read one character
	call WriteChar
	call Crlf
	mov  ebx,OFFSET CaseTable	; point EBX to the table
	mov  ecx,NumberOfEntries 	; loop counter
L1:
	cmp  al,[ebx]				; match found?
	jne  iterate				; no: continue
	je	valid
	jmp	invalid
iterate:
	add  ebx, EntrySize			; point to the next entry
	loop L1					; repeat until ECX = 0

invalid:
	mov edx, OFFSET msgInvalid
	call WriteString
	call Crlf
	ret
valid:
	call NEAR PTR [ebx + 1]		; yes: call the procedure
	ret
Menu ENDP

AND_op PROC USES eax ebx
	mov edx, OFFSET andIns
	call WriteString
	call Crlf
	call Crlf
	call Take_Inputs
	AND eax, ebx
	mov edx, OFFSET result
	call WriteString
	call WriteHex
	call Crlf
	call Crlf
	ret
AND_op ENDP

OR_op PROC USES eax ebx
	mov edx, OFFSET orIns
	call WriteString
	call Crlf
	call Crlf
	call Take_Inputs
	OR eax, ebx
	mov edx, OFFSET result
	call WriteString
	call WriteHex
	call Crlf
	call Crlf
	ret
OR_op ENDP

NOT_op PROC USES eax ebx
	mov edx, OFFSET notIns
	call WriteString
	call Crlf
	call Crlf
	call Take_NOT_Inputs
	NOT eax
	mov edx, OFFSET result
	call WriteString
	call WriteHex
	call Crlf
	call Crlf
	ret
NOT_op ENDP

XOR_op PROC USES eax ebx
	mov edx, OFFSET xorIns
	call WriteString
	call Crlf
	call Crlf
	call Take_Inputs
	XOR eax, ebx
	mov edx, OFFSET result
	call WriteString
	call WriteHex
	call Crlf
	call Crlf
	ret
XOR_op ENDP

Process_Exit PROC
	exit
	ret
Process_Exit ENDP

Take_NOT_Inputs PROC
	mov edx, OFFSET first
	call WriteString
	mov edx, OFFSET userIn
	call ReadHex
	call Crlf
	ret
Take_NOT_Inputs ENDP

Take_Inputs PROC 
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
	ret
Take_Inputs ENDP
END main
