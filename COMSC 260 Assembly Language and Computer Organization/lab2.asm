; lab2.asm - Chapter 3 example.
; Program Description: Add, set, and subtract values in the general purpose registers EAX, EBX, ECX, and EDX
; Author: Ben Kahl: 2051026
; Creation Date: 2/20/2023
; Revisions: 
; Date: 2/20/2023	Modified by: Ben Kahl

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
sum dword 0

.code
main proc
	mov EAX,5		 ; the instruction sets EAX to 5
	mov EBX,6		 ; the instruction sets EBX to 6
	mov ECX,7		 ; the instruction sets ECX to 7
	mov EDX,8		 ; the instruction sets EDX to 8
	add EAX, EBX     ; the instruction does, EAX = (EAX + EBX)
	add ECX, EDX     ; the instruction does, ECX = (ECX + EDX)
	sub EAX, ECX     ; now EAX = (EAX + EBX) - (ECX + EDX)

	invoke ExitProcess,0
main endp
end main