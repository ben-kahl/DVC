; Assignment #: Lab 12
; Program Description: Rewrite Factorial.asm to use parameter lists and account for overflow
; Author: Ben Kahl: 2051026
; Creation Date:
; Revisions: 
; Date:              Modified by:

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
INCLUDE Irvine32.inc
Factorial PROTO, val1: DWORD
Factorial_loop PROTO, val1: DWORD
.data
prompt1 byte "The output from the recursive call - 15!", 0
prompt2 byte "The output from the loop call - 15!", 0
overflowMsg BYTE "The factorial value is overflowed",0
nVal DWORD 15
.code
main PROC
	mov  edx, offset prompt1
	call WriteString
	call Crlf				
	INVOKE Factorial, nVal	; calculate factorial (eax)
	jo overflow
	call WriteDec			; display it
	call Crlf

	mov  edx, offset prompt2
	call WriteString
	call Crlf				
	INVOKE Factorial_loop, nVal	; calculate factorial (eax)
	jo overflow
	call WriteDec		; display it
	call Crlf
	jno endMain
overflow:
	mov edx, OFFSET overflowMsg
	call WriteString
	call Crlf
endMain:
	exit
main ENDP

Factorial PROC, 
	val1: DWORD
	
	mov  eax,val1			; get n
	cmp  eax, 1			; n < 1? for the base case 1 and 0
	ja   L1				; yes: continue
	mov  eax,1			; no: return 1
	jmp  L2

L1:	dec  eax			; Factorial(n-1)
	INVOKE Factorial, eax

; Instructions from this point on execute when each
; recursive call returns.

ReturnFact:
	mov  ebx,val1   	; get n
	mul  ebx          	; ax = ax * bx

L2:					
	ret 
Factorial ENDP

Factorial_loop PROC, val1: DWORD  ; use a loop to calculate the factorial value
	mov  ecx,val1	; get n
	mov  eax, 1
L1:	cmp  ecx, 0		; check if ecx == 0 then quit
	jz   L2
	mul  ecx			; otherwise multiple eax with ecx
	loop L1
L2:			
	ret
Factorial_loop ENDP
END main