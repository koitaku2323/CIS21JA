TITLE  Lab 7: Calculate time difference with procedures
		
; Name: Ryan Yee

COMMENT @
As you can see, the code doesn't run...
I spent more than 8 hours on this. 
Unfortunately, it seems that I just can't get it right.
I surrender.
I'll be attending Friday's special lecture to figure out what I did wrong.
@


INCLUDE Irvine32.inc

printStr macro address
	mov edx, address
	push edx
	call writeString
	pop edx
endm

MIN_PER_HOUR = 60

.data
hrStr BYTE "Enter hour (0-23): ", 0
mnStr BYTE "Enter minute (0-59): ", 0
timeErrStr BYTE "Invalid input", 0ah, 0dh, 0

diffErrStr BYTE "Invalid time difference, check your times", 0ah, 0dh, 0

hrOutStr BYTE " hours, ", 0
mnOutStr BYTE " minutes", 0ah, 0dh, 0

timeArr BYTE ?, ?		; array of: start total minutes, end total minutes
diffHr BYTE ?			; time difference, hours portion
diffMin BYTE ?			; time difference, minutes portion

.code
main PROC
	
top :
	; 1. read time: pass arguments through *registers*
	;; call readTime proc and pass first 3 strings and timeArr

	mov esi, OFFSET hrStr
	mov edi, OFFSET mnStr
	mov ebp, OFFSET timeErrStr
	mov ebx, OFFSET timeArr
	call readTime
	mov DWORD PTR [timeArr], edi
	call readTime
	mov DWORD PTR [timeArr+4], edi



	; 2. find difference: pass arguments through *the stack*
	;; call findDiff proc and pass timeArr, diffHr, diffMin

	sub esp, 8 ; ebp+20
	push OFFSET [timeArr] ; ebp+16
	push OFFSET [timeArr+4] ; ebp+12
	push OFFSET diffHr ; ebp+8
	push OFFSET diffMin ; ebp+4
	call findDiff
	pop diffMin
	pop diffHr


	; 3. based on return value, either:

	; a) print result
	movzx eax, diffHr
	call writeDec
	;; write code to use macro to print hrOutStr
	mov ebx, OFFSET hrOutStr
	printStr ebx

	movzx eax, diffMin
	call writeDec
	;; write code to use macro to print mnOutStr

	printStr OFFSET mnOutStr

	jmp theEnd

	; or b) print error message
	invalidDiff :
	;; write code to use macro to print diffErrStr
	printStr OFFSET diffErrStr

	theEnd:
	jmp top      ; create infinite loop for testing



	exit	
main ENDP

readTime PROC
	
	getInput:
		mov edx, esi ;hrStr
		call writeString
		call readInt
		mov ebx, eax
		cmp eax, 23
		jg errorcase1
		cmp eax, 0
		jl errorcase1
		mov edx, edi ; minStr
		call writeString
		call readInt
		mov ecx, eax
		cmp eax, 59
		jg errorcase1
		cmp eax, 0
		jl errorcase1
		
	errorcase1:
					mov edx, ebp 
					call writeString
					call crlf
					jmp getInput

		mov edi, ebx
		mov eax, MIN_PER_HOUR
		imul edi, eax
		add edi, ecx

	ret

readTime ENDP

findDiff PROC
push ebp
mov ebp, esp
sub esp, 8
push eax
mov eax, [ebp+12]
sub eax, [ebp+16]
mov esi, MIN_PER_HOUR
idiv esi
mov [ebp+4], edx
mov [ebp+8], eax
pop eax
pop ebp
ret 8

findDiff ENDP


END main