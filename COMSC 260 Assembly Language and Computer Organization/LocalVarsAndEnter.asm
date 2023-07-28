; Assignment #: Lab Exercise 11
; Program Description: Filling arrays, practicing using local variables
; Author: Ben Kahl: 2051026
; Creation Date:
; Revisions: 
; Date:              Modified by:

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
INCLUDE Irvine32.inc
.data
count = 25
array DWORD count DUP(?)
fill1 BYTE "===The output from ArrayFill1===",0
fill2 BYTE "===The output from ArrayFill2===",0
fill3 BYTE "===The output from ArrayFill3===",0
.code
main PROC
	call Randomize
	mov edx, OFFSET fill1
	call WriteString
	call CRLF
	push OFFSET array
	push count
	call ArrayFill1
	call PrintArr
	
	mov edx, OFFSET fill2
	call WriteString
	call CRLF
	push OFFSET array
	push count
	call ArrayFill2
	call PrintArr

	mov edx, OFFSET fill3
	call WriteString
	call CRLF
	call ArrayFill3
	call printArr
	INVOKE ExitProcess,0
main ENDP

UPPER EQU DWORD PTR [ebp-4]
LOWER EQU DWORD PTR [ebp-8]
ArrayFill1 PROC
	push	ebp
	mov	ebp,esp
	sub esp, 8
	pushad			; save registers
	mov UPPER, 200
	mov LOWER, -100
	mov	esi,[ebp+12]	; offset of array
	mov	ecx,[ebp+8]	; array size
	cmp	ecx,0		; ECX == 0?
	je	L2			; yes: skip over loop
    
L1:
	mov	eax,UPPER		; get random from range
	sub	eax,LOWER
	call	RandomRange	; from the link library
	add	eax, LOWER
	mov	[esi], EAX
	add	esi,TYPE DWORD
	loop	L1
L2:	popad			; restore registers
	mov esp, ebp
	pop	ebp
	ret				; clean up the stack
ArrayFill1 ENDP

ArrayFill2 PROC
	enter 8,0
	pushad			; save registers
	mov UPPER, 200
	mov LOWER, -100
	mov	esi,[ebp+12]	; offset of array
	mov	ecx,[ebp+8]	; array size
	cmp	ecx,0		; ECX == 0?
	je	L2			; yes: skip over loop
    
L1:
	mov	eax,UPPER		; get random from range
	sub	eax,LOWER
	call	RandomRange	; from the link library
	add	eax, LOWER
	mov	[esi], EAX
	add	esi,TYPE DWORD
	loop	L1
L2:	popad			; restore registers
	leave
	ret				; clean up the stack
ArrayFill2 ENDP

ArrayFill3 PROC
	LOCAL val1:DWORD, val2:DWORD	;using val1 and val2 as locals since upper and lower are taken
	pushad			; save registers
	mov val1, 200
	mov val2, -100
	mov	esi,[ebp+12]	; offset of array
	mov	ecx,[ebp+8]	; array size
	cmp	ecx,0		; ECX == 0?
	je	L2			; yes: skip over loop
    
L1:
	mov	eax,val1		; get random from range
	sub	eax,val2
	call	RandomRange	; from the link library
	add	eax, LOWER
	mov	[esi], EAX
	add	esi,TYPE DWORD
	loop	L1
L2:	popad			; restore registers
	ret				; clean up the stack
ArrayFill3 ENDP

PrintArr PROC
	mov ECX, count
	mov ESI, 0
L1:
	mov eax, array[ESI]
	CALL WriteInt
	CALL CRLF
	add ESI, type array
	loop L1
	ret
PrintArr ENDP
END main
