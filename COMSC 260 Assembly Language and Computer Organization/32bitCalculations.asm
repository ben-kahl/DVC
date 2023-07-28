; Assignment #: Assignment 3
; Program Description: Calculate the sum of 4 32 bit unsigned integers and 4 32 bit signed integers
; Author: Ben Kahl: 2051026
; Creation Date: 2/26/2023
; Revisions: 1
; Date:              Modified by: Ben Kahl

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
; declare variables here
sum DWORD 0
valueA DWORD 1000
valueB DWORD 300
valueC DWORD 2000
valueD DWORD 500
ssum SDWORD 0
svalueA SDWORD 1000
svalueB SDWORD 300
svalueC SDWORD 2000
svalueD SDWORD 500
.code
main PROC
					; ---EAX---
	MOV EAX, valueC	; 2000
	ADD EAX, valueD	; 500
	XCHG sum, EAX		; 0
	MOV EAX, valueA	; 1000
	ADD EAX, valueB	; 1300
	SUB EAX, sum		; -1200
	XCHG sum, EAX		; 2500
	MOV EAX, sum		; -1200
	XCHG ssum, EAX		; 0
	INVOKE ExitProcess,0
main ENDP
END main
