TITLE  Lab 8: Find letters in 2D array of strings
		
; Name: Ryan Yee


INCLUDE Irvine32.inc

ROWS = 3
COLS = 11

printStr MACRO addr
	push edx
	mov edx, addr
	call writeString
	pop edx
ENDM

printIndex MACRO index
	push eax
	mov al, '['
	call writeChar
	mov eax, index
	call writeDec
	mov al, ']'
	call writeChar
	pop eax
ENDM


.data
strPrompt BYTE "Please enter a string: ", 0
letterPrompt BYTE "Please enter your target letter: ", 0
numStr1 BYTE "Total count: ", 0
arr BYTE ROWS DUP (COLS DUP(0))

.code
main PROC
	
; 1. call fill array, pass arguments through *registers*
mov esi, OFFSET arr
mov ebx, OFFSET strPrompt
call fillArr				
call crlf

; 2. check return value and end the program if return value is 0
cmp ecx, 0
je done

; 3. loop to call findCount, pass arguments through *the stack*
letter:
	sub esp, 4
	push OFFSET letterPrompt
	push ecx
	push OFFSET arr
	call findCount
	pop eax
	printStr OFFSET numStr1
	call writeDec
	call crlf
	jmp letter

done:
	exit	
main ENDP

; esi = addr of arr
; ebx = addr of promptStr
; return value
; ecx = num strings

fillArr PROC
	mov edx, esi
	mov ecx, COLS
	xor ebp, ebp
	readLoop:
		printStr ebx
		call readString
		cmp BYTE PTR [edx], 0
		je printing
		inc ebp
		add edx, COLS
		cmp ebp, ROWS
		jb readLoop

		printing:
		mov ecx, ebp
		cmp ecx, 0
		je returning
		push ecx
		push esi
		call printArr

		returning:
		ret
fillArr ENDP

; num of strings   ebp+12
; addr of arr      ebp+8
; return address   ebp+4
; ebp

printArr PROC
	push ebp
	mov ebp, esp
	push ebx
	push ecx
	mov ecx, [ebp+12]
	mov ebx, [ebp+8]
	call crlf
	printLoop:
		printStr ebx
		call crlf
		add ebx, COLS
		loop printLoop
	pop ecx
	pop ebx
	pop ebp
	ret 8
printArr ENDP

; ret val		ebp+20
; addr prompt   ebp+16
; string count  ebp+12
; addr arr      ebp+8
; return addr   ebp+4
; saved regs    ebp

findCount PROC
	push ebp
	mov ebp, esp
	pushad

	mov ecx, [ebp+12]
	mov eax, COLS
	mul ecx
	mov ecx, eax

	mov edi, [ebp+8]
	add esi, edi
	mov edx, [ebp+16]
	xor ebx, ebx

	printStr edx
	call readChar
	call writeChar
	call crlf
	searchLoop:
		repne scasb
		jnz doneSearch
		inc ebx
		;push [ebp+8]  ;EC
		;push edi
		;call printLoc
		;call crlf

		jmp searchLoop

	doneSearch:
	mov [ebp+20], ebx
	popad
	pop ebp
	ret 12
findCount ENDP

printLoc PROC

;;; Stack frame ;;;
;   addr of arr     ebp+12
;	addr of found letter  ebp+8
;   return adress         ebp+4
;   saved regs            ebp

	push ebp
	mov ebp, esp
	push eax
	push ebx
	push ecx

	xor eax, eax
	mov eax, [ebp+8]
	mov ebx, [ebp+12]
	sub eax, ebx
	mov ebx, COLS
	div ebx

	xor ebx, ebx
	movzx ebx, al
	movzx ebx, ah
	mov ecx, ebx
	printIndex ecx

	pop ecx
	pop ebx
	pop eax
	pop ebp
	ret 8

printLoc ENDP

END main
