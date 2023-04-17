; Assignment #: 7
; Program Description: Encrypt and decrypt a user-inputted string using a user-inputted key.
; Author: Ben Kahl: 2051026
; Creation Date: 4/2/2023
; Revisions: 2
; Date: 4/3/2023       Modified by: Ben Kahl

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
INCLUDE Irvine32.inc
BUFMAX = 128     	; maximum buffer size

.data
sPrompt  BYTE  "Enter the plain text: ",0
sKeyPrompt BYTE "Enter the encryption key: ",0
sEncrypt BYTE  "Cipher text:          ",0
sDecrypt BYTE  "Decrypted:            ",0
buffer   BYTE   BUFMAX+1 DUP(0)
keyBuf   BYTE	 BUFMAX+1 DUP(0)
bufSize  DWORD  ?
keySize  DWORD	 ?

.code
main PROC
	call	InputTheString		; input the plain text
	call	TranslateBuffer	; encrypt the buffer
	mov	edx,OFFSET sEncrypt	; display encrypted message
	call	DisplayMessage
	call	TranslateBuffer  	; decrypt the buffer
	mov	edx,OFFSET sDecrypt	; display decrypted message
	call	DisplayMessage
	call WaitMSG

	exit
main ENDP

;-----------------------------------------------------
InputTheString PROC
;
; Prompts user for a plaintext string. Saves the string 
; and its length.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
	pushad
	mov	edx,OFFSET sPrompt	; display a prompt
	call	WriteString
	mov	ecx,BUFMAX		; maximum character count
	mov	edx,OFFSET buffer   ; point to the buffer
	call	ReadString         	; input the string
	mov	bufSize,eax        	; save the length
	call	Crlf
	mov edx,OFFSET sKeyPrompt ; display encryption key prompt
	call WriteString
	mov ecx, BUFMAX
	mov edx,OFFSET keyBuf
	call ReadString
	mov keySize,eax
	call Crlf
	popad
	ret
InputTheString ENDP

;-----------------------------------------------------
DisplayMessage PROC
;
; Displays the encrypted or decrypted message.
; Receives: EDX points to the message
; Returns:  nothing
;-----------------------------------------------------
	pushad
	call	WriteString
	mov	edx,OFFSET buffer	; display the buffer
	call	WriteString
	call	Crlf
	call	Crlf
	popad
	ret
DisplayMessage ENDP

;-----------------------------------------------------
TranslateBuffer PROC
;
; Translates the string by exclusive-ORing each
; byte with the encryption key byte.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
	pushad
	mov	ecx,bufSize		; loop counter
	mov	edx,keySize		; size of key
	mov	esi,-1			
	mov	edi,-1			
L1:
	inc	esi
	inc  edi				; point to next byte
	mov al, keyBuf[edi]		; store the key char at edi
	xor buffer[esi], al		; translate a byte
	cmp edi, keySize		; check to see if the end of the key has been reached
	je L2				; jump to L2 if edi is at the end of keyBuf
	loop	L1
L2:
	sub edi, keySize		; reset edi
	cmp ecx, 0			; prevent infinite loops
	jne L1				; do not jump back if 0
	popad
	ret
TranslateBuffer ENDP
END main