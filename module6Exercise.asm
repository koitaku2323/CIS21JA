TITLE Module 6 Exercise						

INCLUDE Irvine32.inc

.data
bigData QWORD 123456781234567h

.code
main PROC

;;;;;;;;;;;;  part 1: bit-wise instructions ;;;;;;;;;;;;;
; predict what the code will do by answering
; the questions, then step through the code
; to check your answers

	mov al, 1010b
	and al, 1      ; al: 0000 1010 and 0000 0001 -> 0000 0000
	or al, 1       ; al: 0000 0000  or 0000 0001 -> 0000 0001
	xor al, 0fh    ; al: 0000 0001 xor 0000 1111 -> 0000 1110
	not al         ; al: 0000 1110  -> 1111 0001

	mov al, 1010b  ; al: 0000 1010
	test al, 1000b   ; what are we testing for? We are testing if bit number 3 is set
	jz L1			 ; will it jump? Since ZF = 0, there will be no jump
	mov bl, 1        ; bl: 0000 0001
L1:
	xor al, al		 ; al: 0000 0000

nextTest:
	mov al,1000b    ; al: 0000 1000
	test al, 80h	; what are we testing for? We are testing with the pattern: 1000 0000 (test the MSB for 1)
	jnz L2			; will it jump? There will be no jump because ZF = 1
	not al			; al: 1111 0111
L2:



	mov al,2		; al: 0000 0010
	shl al,1		; al: 0000 0100
	sal al,2		; al: 0001 0000

	shr al,1		; al: 0000 1000


	mov al,0feh		; al: 1111 1110
	shr al,1		; al: 0111 1111
	mov al,0feh     ; al: 1111 1110
	sar al,1		; al: 1111 1111


	mov al, 0fh     ; al: 0000 1111
	ror al,4		; al: 1111 0000
	rol al,4		; al: 0000 1111

	mov al, 0f0h    ; 1111 0000
	stc				; set cf = 1
	rcr al, 4		; al: 1111 0000
	mov al, 0f0h     
	clc				; clear cf: CF = 0
	rcl al, 4;		; al: 1111 0000

	mov ax,1234h	; ax: 1234
	mov bx,5678h    ; bx: 5678
	shld ax,bx,4	; ax: 2345   bx: 5678
	shrd bx,ax,4	; ax: 2345   bx: 5567

	;;;;;;;;;;;;;;; part 2: solve these problems ;;;;;;;;;;;;

;Problem 1:
mov ax, 1234h       ; ax: 1234
mov bx, 100h        ; bx: 100
mul bx				; result: 123400 in dx:ax

; call writeDec to print the result

shl eax, 16
shrd eax, edx, 16

call writeDec
call crlf
call writeHex
call crlf




;Problem 2:
; multiply bigData by 2, then store the result back in bigData

mov eax, DWORD PTR bigData
shl eax, 1
mov DWORD PTR bigData, eax
mov eax, DWORD PTR bigData + 4
rcl eax, 1
mov DWORD PTR bigData + 4, eax



;Problem 3 - indirect addressing:
; multiply bigData by 2, then store the result back in bigData,
; but we only have the address of bigData in ebx

mov ebx, OFFSET bigData
mov eax, DWORD PTR [ebx]
shl eax, 1
mov DWORD PTR [ebx], eax
mov eax, DWORD PTR [ebx + 4]
rcl eax, 1
mov DWORD PTR [ebx + 4], eax




	exit
main ENDP

END main