TITLE  Lab 4: Calculate the number of coins, and predict flag values
		
; Don't forget this beginning documentation with your name
; Name: Ryan Yee


INCLUDE Irvine32.inc

; Part 1 (10pts)


.data

MAX = 99
chng BYTE "Change is ",0
cents BYTE " cents",0
qtr BYTE " quarters, ",0
dms BYTE " dimes, ",0
nic BYTE " nickels, ",0
pen BYTE " pennies.",0

.code
main PROC
	call randomize			; create a seed for the random number generator
	mov eax, MAX    			; set upper limit for random number to 9
	call randomRange		; random number is returned in eax, and is 0-9 inclusive
	;call writeDec			; print to check random number

	mov edx, OFFSET chng
	call writeString
	call writeDec
	mov edx, OFFSET cents
	call writeString
	call CrLF

	mov bl, 25
	div bl
	mov cl, ah
	movzx eax, al
	call writeDec

	mov al, cl
	mov edx, OFFSET qtr
	call writeString

	mov bl, 10
	div bl
	mov cl, ah
	movzx eax, al
	call writeDec

	mov al, cl
	mov edx, OFFSET dms
	call writeString

	mov bl, 5
	div bl
	mov cl, ah
	movzx eax, al
	call writeDec

	mov al, cl
	mov edx, OFFSET nic
	call writeString

	call writeDec
	mov edx, OFFSET pen
	call writeString
	call CrLF

	exit	
main ENDP

END main


COMMENT !
Part 2 (5pts)
Assume ZF, SF, CF, OF are all 0 at the start, and the 3 instructions below run one after another. 
a. fill in the value of all 4 flags after each instruction runs 
b. show your work to explain why CF and OF flags have those values
   Your explanation should not refer to signed or unsigned data values, 
   such as "the result will be out of range" or "204 is larger than a byte"
   or "adding 2 negatives can't result in a positive"
   Instead, show your work in the same way as in the exercise 4 solution.


mov al, 70h 

add al, 30h 

; a. ZF = 0   SF = 1  CF = 0  OF = 1
; b. explanation for CF: CF is 0, meaning it is clear, means that nothing was carried out of the MSB.
;    explanation for OF: OF is 1, meaning that it is set, means that a 1 is carried into the MSB.
						 ummm or OF is 1 because there was an overflow.
sub al, 070h     

; a. ZF = 0  SF = 1  CF = 0   OF = 0 
; b. explanation for CF: CF is 0, meaning it is clear, means that nothing was carried out of the MSB.
;    explanation for OF: OF is 0, meaning that it is clear, means that nothing was carried into the MSB.
						 OF is 0 because there was no overflow.
!