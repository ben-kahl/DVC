; Assignment #: Lab Exercise 4
; Program Description: This program indirectly copies a string reversely.
; Author: Ben Kahl: 2051026
; Creation Date: 3/1/2023
; Revisions: 2
; Date: 3/3/2023        Modified by: Ben Kahl

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:dword

.data
source  byte  "This is the source string",0
target  byte  SIZEOF source DUP(0),0

.code
main proc
	mov  esi,0				
	mov  edi,LENGTHOF source - 1
	mov  ecx, SIZEOF source		
L1:
	mov  al,source[esi]			
	mov  target[edi],al	
	inc  esi					
	dec  edi					
	loop L1					

	invoke ExitProcess,0
main endp
end main
