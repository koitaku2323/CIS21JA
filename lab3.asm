TITLE Lab3 3				

;;;;; Q1: Don't forget to document your program 			
; Name: Ryan Yee
; Date: 1/21/2022

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Answer each question below by writing code at the APPROPRIATE places in the file
;;;;; Putting your answer immediately after the question is not necessarily the correct place

;;;;; Q2: Write the directive to bring in the IO library			

;;;;; Q3: Create a constant called SECS_PER_MIN and initialize it to 60

;;;;; Q4: Create a constant called SECS_PER_DAY by using SECS_PER_MIN (of Q3) in an integer expression constant

;;;;; Q5: Define an array of 25 signed doublewords, use any array name you like. Initialize:
;;;;;	- the 1st element to 10 
;;;;;	- the 2nd element to the hexadecimal value C2
;;;;;	- the 3rd element to the binary value 10101 
;;;;;	- the 4th element to the SECS_PER_MIN constant defined in Q3
;;;;; and leave the rest of the array uninitialized.  

;;;;; Q6. Define the string "Output is ", use any variable name you like.

;;;;; Q7. Define a prompt that asks the user for a negative number

;;;;; Q8. Write code to print to screen the value of eax after SECS_PER_DAY is stored in eax (first line of code below)
;;;;;     Use the string you defined in Q6 as the text explanation for your output

;;;;; Q9. Write code to prompt the user for a negative number, using the prompt string that you defined in Q7

;;;;; Q10. Write code to read in the user input, which is guaranteed to be a negative number

;;;;; Q11. Write code to print "Output is " and then echo to screen the user input number

;;;;; Q12. Write code to print "Output is " and then print the first element of the array defined in Q5
;;;;;      The output should not contain a + or - sign

;;;;; Q13. Build, run, and debug your code
;;;;; Your output should be similar to this (without the commented explanation)

;;;;; Output is 86400						    ; printing SECS_PER_DAY
;;;;; Enter a negative number: -2
;;;;; Output is -2								; echo user input number
;;;;; Output is 10 								; print first element of array
;;;;; Press any key to continue . . .

;;;;; Q14. At the end of the source file, without using semicolons (;), add a comment block
;;;;;      to show how bigData appears in memory (should be the same 8 hexadecimal values as in lab 2), 
;;;;;      and explain why the data in memory looks different than the initialized value 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

INCLUDE Irvine32.inc

.data
bigData QWORD 1234567890abcdefh					; same bigData value as lab 2
SECS_PER_MIN DWORD 60
SECS_PER_DAY DWORD ?
MIN_PER_DAY DWORD 1440
list1 DWORD 10, 0C2h, 10101b, SECS_PER_DAY, 21 DUP(?)
str1 BYTE "Output is ",0
str2 BYTE "Enter a negative number: ",0
num1 SDWORD ?

.code
main PROC
	mov eax, SECS_PER_MIN						; eax = HRS_PER_YEAR value
	mov eax, 60*1440
	mov SECS_PER_DAY, eax
	mov edx,OFFSET str1
	call WriteString
	mov edx,OFFSET SECS_PER_DAY
	call WriteDec
	call Crlf


	mov edx,OFFSET str2
	call WriteString
	mov edx,OFFSET num1
	mov ecx,81
	call ReadInt
	mov num1,edx
	mov edx,OFFSET str1
	call WriteString
	mov edx,OFFSET num1
	call WriteInt
	call Crlf
	mov edx,OFFSET str1
	call WriteString
	mov eax,list1[0]
	call WriteDec
	call Crlf


	exit	
main ENDP

END main

COMMENT @
 bigdata:  ef cd ab 90 78 56 34 12
 The data in memory looks different than the initialized value because of Endian Order.
 @