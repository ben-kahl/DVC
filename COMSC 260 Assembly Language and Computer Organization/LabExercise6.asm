; Assignment #: Lab Exercise 6
; Program Description: Locate cursor near the middle of the screen, add 2 user inputted integers 3 times, change color and clear the screen on each iteration
; Author: Ben Kahl: 2051026
; Creation Date: 3/17/2023
; Revisions: 1
; Date: 3/17/2023         Modified by: Ben Kahl

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
INCLUDE Irvine32.inc
.data
; declare variables here
first BYTE "Enter the first integer: ",0
second BYTE "Enter the second integer: ",0
result BYTE "The sum is: ",0
userInFirst DWORD ?
userInSecond DWORD ?
.code
main PROC
	; write your code here
	mov ecx,3
	mov eax, yellow + (blue * 16)
	call SetTextColor
	call Clrscr
	L1:
	call InOut
	add eax,17
	call setTextColor
	call Clrscr
	loop L1
	INVOKE ExitProcess,0
main ENDP

InOut PROC
	push eax
	; take the first input
	mov dh,10
	mov dl,20
	call Gotoxy
	mov edx, OFFSET first
	call WriteString
	mov edx, OFFSET userInFirst
	call ReadInt
	mov ebx,eax
	; take the second input
	mov dh,12
	mov dl,20
	call Gotoxy
	mov edx, OFFSET second
	call WriteString
	mov edx, OFFSET userInFirst
	call ReadInt
	add eax, ebx
	; displays the result
	mov dh,14
	mov dl,20
	call Gotoxy
	mov edx, OFFSET result
	call WriteString
	call WriteInt
	call Crlf
	call Crlf
	call WaitMsg
	pop eax
	ret
InOut ENDP

END main
