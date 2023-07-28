; Assignment #: 12
; Program Description: Print an 8x8 chessboard switching color every half second split into multiple modules.
; Author: Ben Kahl: 2051026
; Creation Date: 5/6/2023
; Revisions: 5
; Date: 5/8/2023        Modified by: Ben Kahl

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
INCLUDE Board.inc
.data
.code
main PROC
	; write your code here
	mov ecx, 16
L1:
	mov al,16		; I did the math for the current color here because things got messy when I did it in WriteColorBlock
	sub al, cl
	mov bl, al
	shl al, 4
	add al, bl	; Color is now properly set
	INVOKE Print_Board, al	; Print the board
	mov eax, 500	; Set the delay
	call Delay	; Wait 500ms
	loop L1

	mov eax, lightGray + (black*16)	; Reset for final message
	call SetTextColor
 	INVOKE ExitProcess,0
main ENDP

END main
