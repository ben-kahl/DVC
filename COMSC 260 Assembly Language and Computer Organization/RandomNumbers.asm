; Assignment #: 5
; Program Description: Take user inputted ranges and return 30 random integers within the specified ranges 3 times
; Author: Ben Kahl: 2051026
; Creation Date: 3/12/2023
; Revisions: 2
; Date: 3/12/2023          Modified by:	Ben Kahl

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
INCLUDE Irvine32.inc
.data
; declare variables here
lower BYTE "Please enter the lower bound: ",0
upper BYTE "Please enter the upper bound: ",0
userIn DWORD ?
temp DWORD ?
.code
main PROC
	mov ecx, 3
	L1:
	push ecx
	call TakeBounds
	mov ecx, 30
	L2:
	push eax
	push ebx 
	call BetterRandomRange
	call WriteInt
	call Crlf
	pop ebx
	pop eax
	loop L2
	pop ecx
	loop L1
	INVOKE ExitProcess,0
main ENDP

TakeBounds PROC
; Takes the user inputted range
; Receives: userIn
; Returns: EAX and EBX as the upper and lower bounds
; Requires: nothing
	mov edx, OFFSET lower
	mov ecx, SIZEOF lower
	call WriteString
	mov edx, OFFSET userIn
	mov ecx, SIZEOF userIn
	call ReadInt
	xchg eax, ebx
	mov edx, OFFSET upper
	mov ecx, SIZEOF upper
	call WriteString
	mov edx, OFFSET userIn
	mov ecx, SIZEOF userIn
	call ReadInt
	ret
TakeBounds ENDP

BetterRandomRange PROC
; Takes the user inputted range and returns a random number in range
; Receives: temp, EAX, EBX
; Returns: EAX as the random number in range
; Requires: nothing
	mov temp, eax
	sub eax, ebx
	call RandomRange
	add eax, ebx
	ret
BetterRandomRange ENDP
END main
