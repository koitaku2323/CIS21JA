TITLE  Assignment 6: Use bit wise instructions
		
; Name: 

INCLUDE Irvine32.inc

.data
zeroStr BYTE "EAX is 0", 0ah, 0dh, 0
divStr BYTE "Divisible by 4", 0ah, 0dh, 0
arr WORD 1, 0f02h, -2

.code
main PROC
; Question 1 (3pts)
; In the space below, write code in 3 different ways (use 3 different instructions)
; to check whether EAX is 0, and jump to label Zero if it is, otherwise jump to Q2.
; To solve this problem you:
; - cannot use the CMP instruction or arithmetic instruction (ADD, SUB, DIV, etc.)
; - cannot change the EAX value or copy the EAX value to another register

	mov eax, 0		; change this value to test your code
	; make sure you have 3 different ways using 3 different instructions,
	; only one will run at a time

	;and eax, eax
	;jz Zero
	;jnz Q2
	
	;test eax, eax
	;jz Zero
	;jnz Q2

	xor eax, 0
	jz Zero
	jnz Q2


	Zero :
		mov edx, OFFSET zeroStr
		call writeString
		call crlf

	Q2:
; Question 2
; You can use the following code to impress your friends, 
; but first you need to figure out how it works.

	mov al, 'A'	    ; al can contain any letter of the alphabet
	xor al, ' '	    ; the second operand is a space character

COMMENT !
a. (1pt) What does the code do to the letter in AL?     
   (Print the letter in AL to see, then change the letter to 'B', 'd', 'R', etc.)
   The code changes the letter from uppercase to lowercase and vice-versa.
b. (2pts) Explain how the code works. Your answer should not be a description
   of what the instruction does, such as "the code takes the value in AL
   and does an XOR with the space character.
   'A' in binary is 01000001, ' ' in binary is 00100000.
       01000001
   xor 00100000
       01100001 = 61 = 'a'
   If we take bitwise XOR of an uppercase or lower case characters with ''
   only its third significant bit will be toggled, in that case, lowercase
   becomes uppercase and vice versa.

!

; Question 3 (4 pts)
; Write code to check whether the number in AL is divisible by 4,
; jump to label DivBy4 if it is, or go to label Q4 if it's not.
; You should not have to use the DIV or IDIV instruction.
; Hint: write out the first few integers that are divisible by 4,
; and see if you can find a pattern with them.
; Numbers divisible by 4, the 2 LSBs will be 00.

    mov al, 16     ; change this value to test your code
	and al, 00000011b
	jz DivBy4
	jmp Q4

	DivBy4:
		mov edx, OFFSET divStr
		call writeString
		call crlf

	Q4:
; Question 4 (5 pts)
; Given an array arr of 3 WORD size data, as defined in .data above, 
; and ebx is initialized as shown below.
; Using ebx (not the array name), write ONE instruction (one line of code)
; to reverse the bits in the most significant byte (high byte) of 
; the last 2 elements of arr.  
; Reverse means turn 0 to 1 or 1 to 0.  
; Your code should work with all values in arr, not just the sample data in arr

	mov ebx, OFFSET arr
	xor DWORD PTR [ebx+2], 10000000000000001000000000000000b

	exit	
main ENDP

END main
