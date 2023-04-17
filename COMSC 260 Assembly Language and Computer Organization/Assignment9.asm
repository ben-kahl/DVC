; Assignment #: 9
; Program Description: Encrypt and decrypt a user inputted string using ROR and ROL
; Author: Ben Kahl: 2051026
; Creation Date: 4/15/2023
; Revisions: 3
; Date: 4/15/2023         Modified by: Ben Kahl

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
INCLUDE Irvine32.inc
MAX = 128
.data
; declare variables here
prompt BYTE "Please enter one plain text:",0
encrypted BYTE "The plain text after encoded:",0
decrypted BYTE "The plain text after decoded:",0
buffer BYTE MAX+1 DUP(?),0
byteCount DWORD ?
key BYTE -5, 3, 2, -3, 0, 5, 2, -4, 7, 9
.code
main PROC
	; write your code here
	mov edx, OFFSET prompt
	call WriteString
	call Crlf
	mov edx, OFFSET buffer
	mov ecx, SIZEOF buffer
	call ReadString
	mov byteCount, eax
	call Crlf

	mov edx, OFFSET encrypted
	call WriteString
	call Crlf
	mov esi, 0
	mov ecx, SIZEOF key
	mov edi, 0
	call Encrypt
	mov edx, OFFSET buffer
	call WriteString
	call Crlf
	call Crlf

	mov edx, OFFSET decrypted
	call WriteString
	call Crlf
	mov esi, 0
	mov ecx, SIZEOF key
	mov edi, 0
	call Decrypt
	mov edx, OFFSET buffer
	call WriteString
	call Crlf
	call Crlf

	call WaitMsg
	INVOKE ExitProcess,0
main ENDP

Encrypt PROC
	L1:
	push ecx						;save counter
	mov cl, key[edi]				;put the key at the current index in cl
	ror BYTE PTR buffer[esi],cl		;rotate right by the key
	inc esi						;increment
	inc edi
	pop ecx
	cmp esi, byteCount				;check if the user plain text has fully been iterated through
	je end_encrypt					;if so encryption is finished
	cmp ecx, 0					;if not check to see if the end of the key array has been reached
	je reset_key					;resets edi and ecx
	loop L1
	
	reset_key:
	mov edi, 0
	mov ecx, SIZEOF key
	jmp L1

	end_encrypt:
	ret							;exit out
Encrypt ENDP

Decrypt PROC
	L1:
	push ecx						;save counter
	mov cl, key[edi]				;put the key at the current index in cl
	rol BYTE PTR buffer[esi],cl		;rotate left by the key
	inc esi						;increment
	inc edi
	pop ecx
	cmp esi, byteCount				;check if the user plain text has fully been iterated through
	je end_decrypt					;if so decryption is finished
	cmp ecx, 0					;if not check to see if the end of the key array has been reached
	je reset_key					;resets edi and ecx
	loop L1
	
	reset_key:
	mov edi, 0
	mov ecx, SIZEOF key
	jmp L1

	end_decrypt:
	ret
Decrypt ENDP
END main