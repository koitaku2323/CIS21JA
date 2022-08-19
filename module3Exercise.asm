TITLE Module 3 Exercise					
COMMENT @
 The following class exercise is for module 2
 Topics: Assembly Fundamentals and Library Calls

 1. Use the comment directive instead of ; for 
 the first 4 lines of comments
 @

; 2. Name the directives that you see in the code:
;TITLE
;INCLUDE
;data
;code
;ENDP
;END

INCLUDE Irvine32.inc

; 3. define a constant for the number of seconds in an hour
; by using an integer expression constant
;sec1 BYTE 60

.data
; 4. define a prompt: enter your name
myPrompt BYTE "ENTER YOUR NAME", 0

; 5. define memory space to store someone's name (20 characters for name)
myName BYTE 20 DUP(?)

hi BYTE "Hi, ",0	; Hi string to print out

; 6. define a byte and initialize with binary 100
value1 BYTE 100,0

; 7. define a word and initialize with hexadecimal A0 
word1 WORD 0A0h

; 8. define a doubleword and initialize with -10
word2 DWORD -10,0
									
; 9. define an array of 5 doublewords and initialize with the values 1,2,3
; and leaving the last 2 elements uninitialized
myArr DWORD 1,2,3,?,?

.code
main PROC

; 10. write code to print the prompt
mov edx,OFFSET myPrompt
call WriteString
call Crlf

; 11. write code to read in the user's name
mov edx,OFFSET myName
mov ecx,81
call ReadString


; 12. write code to print "Hi, <user's name>" where user's name is what you read in
mov edx,OFFSET hi
call WriteString
mov edx,OFFSET myName
call WriteString
call Crlf

; 13. write code to store the immediate value -1 in eax


; 14. write code to print the word defined in step 7


; 15. write code to print the doubleword defined in step 8


; 16. use the debugger's memory window and identify what your data
; definitions look like in mememory



; 17. show what the array of 5 doublewords look like. 
; Why does it look like that?



	exit	
main ENDP

END main
