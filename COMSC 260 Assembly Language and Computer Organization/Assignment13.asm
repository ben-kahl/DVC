; Assignment #: 13
; Program Description:  Finds a desired source string within target and returns its position
; Author: Ben Kahl: 2051026
; Creation Date: 5/13/2023
; Revisions: 10
; Date: 5/15/2023       Modified by: Ben Kahl

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
INCLUDE Irvine32.inc
Str_find PROTO,  pTarget: PTR BYTE,  pSource:PTR BYTE


.data
;target BYTE "123ABC342ABC432",0
;source BYTE "ABCD",0

target BYTE "01ABAAAAAABABCC45ABC9012AAABX",0
source BYTE "AAABX",0

pos DWORD 0FFFFFFFFh     ; initialize it with a very large number to indicate not found
targetMsg BYTE "The target string is: ",0
sourceMsg BYTE "The source string is: ",0
foundStartMsg BYTE "Source string found in position ",0
foundEndMsg BYTE " in target string (counting from 0).",0
notFoundMsg BYTE "The source string is not found in the target string.",0
.code
main PROC
	mov edx, OFFSET targetMsg
	call WriteString
	mov edx, OFFSET target
	call WriteString
	call CRLF

	mov edx, OFFSET sourceMsg
	call WriteString
	mov edx, OFFSET source
	call WriteString
	call CRLF
	
	mov eax, pos
	INVOKE str_find, ADDR target, ADDR source
	cmp eax, pos
	je L1
	
	mov edx, OFFSET foundStartMsg
	call WriteString
	call WriteDec
	mov edx, OFFSET foundEndMsg
	call WriteString
	call CRLF
	jmp L2
L1:
	mov edx, OFFSET notFoundMsg
	call WriteString
	call CRLF
L2:
	INVOKE ExitProcess,0
main ENDP

;----------------------------------------------------------------
Str_find PROC, 
	pTarget: PTR BYTE,
	pSource: PTR BYTE,
	
local maxDepth:DWORD, lenSource: DWORD, lenTarget: DWORD 
; Description: Finds a desired source string within target and
; returns its position
; Returns: Position in EAX 
;----------------------------------------------------------------	
	push eax
	invoke str_length, pTarget
	mov lenTarget, eax

	invoke str_length, pSource
	mov lenSource, eax
	
	cmp lenTarget, eax
	jl notFound

	mov edi, OFFSET target
	mov esi, OFFSET source
	
	mov eax, edi
	add eax, lenTarget
	sub eax, lenSource
	add eax, 1
	mov maxDepth, eax

	cld
	mov ecx, lenSource
L1:
	pushad
	repe cmpsb
	popad
	je found

	inc edi
	cmp edi, maxDepth
	jae notFound
	jmp L1

notFound:
	mov ebx, 0	; set zero flag
	cmp ebx, 1
	pop eax		; restore original pos value
	jmp ext
found:
	mov eax, edi
	sub eax, pTarget
	cmp eax,eax	; set zero flag
	
ext:
	ret
Str_find ENDP
END main