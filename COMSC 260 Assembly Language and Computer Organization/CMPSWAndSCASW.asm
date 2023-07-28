; Assignment #: Lab Exercise 13
; Program Description: Practice using CMPSW and SCASW instructions
; Author: Ben Kahl: 2051026
; Creation Date: 5/11/2023
; Revisions: 2
; Date: 5/11/2023       Modified by: Ben Kahl

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
INCLUDE Irvine32.inc
.data
neq BYTE "Source Array and Target Array are NOT the same.",0
equal BYTE "Source Array and Target Array ARE the same.",0
before BYTE "Before searching, EDI is located at: ",0
searching BYTE "Searching for the matched word: ",0
after BYTE "After searching, the matched word is located at: ", 0
notFound BYTE "No matched word is found.",0

Sourcew WORD 10, 20, 30
Targetw WORD 10, 20, 35
WordArray WORD 10h, 20h, 30h, 40h
search WORD 0030h
.code
main PROC
	mov esi, OFFSET Sourcew
	mov edi, OFFSET Targetw
	mov ecx, 3
	cld
	REPE CMPSW
	je L1
	jmp L2
L1:
	mov edx, OFFSET equal
	call WriteString
	call CRLF
	jmp L3
L2:
	mov edx, OFFSET neq
	call WriteString
	call CRLF
L3:
	mov edi, OFFSET WordArray
	mov edx, OFFSET before
	call WriteString
	mov eax, edi
	call WriteHex
	call CRLF
	mov edx, OFFSET searching
	call WriteString
	movzx eax, search
	call WriteHex
	call CRLF
	mov ecx, 4
	cld
	repne scasw
	jnz L4
	dec edi
	mov edx, OFFSET after
	call WriteString
	mov eax, edi
	call WriteHex
	jmp L5
L4:
	mov edx, OFFSET notFound
	call WriteString
L5:
	INVOKE ExitProcess,0
main ENDP
END main
