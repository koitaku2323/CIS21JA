TITLE midterm 2 review solution

; Covers modules 5 (branching), 6 (bit-wise instruction / indirect addressing), 7 (procedures / macros)
; The following questions are in the same 2 types of questions you'll see in midterm 2:
; - questions to write code
; - questions to explain code or show results


INCLUDE Irvine32.inc

.stack

printError MACRO  aString     
	push edx				; store all register values that we use
	push eax
	mov al, '*'				; prepare to print *
	call writeChar			; print *
	mov edx, OFFSET aString	; prepare to print string
	call writeString		; print string
	call writeChar          ; print * again
	call crlf				; print newline
	pop eax					; restore register values
	pop edx
ENDM


.data
errorStr BYTE "invalid result",0

var1 SBYTE 90
var2 SBYTE 10
var3 SBYTE -100
arr DWORD 1,2,3,4,5,6,7,8
var4 DWORD -1, -1

.code
main PROC
; The first 3 sample questions are to write code

; 1. write a macro that prints the errorStr (defined above)
; on a separate line of text, with a * character at the beginning and end of the string

;;;; answer up above .data


; 2. write code that implements:
;   var3 = var1 * var2 - var3
; where the variables are defined in .data
;
; if any operation ends up with an invalid result, invoke the
; macro of question 1 
; var1, var2, var3 can contain any data value. You shouldn't rely 
; on the given data values when writing code to catch invalid result

;;; First we observe that: var1, var2, var3 are signed data


mov al, var1
imul var2			; var1 * var2 first, result is in ax 
jo invalidResult	; check for result larger than 1 byte (which means there is data in ah)
					; go to invalidResult if it's larger than 1 byte or OF is set 
					; (see module 4 class notes on how CF or OF is set for unsigned / signed multiplication
					
sub al, var3		; product - var3, final result is in al
jno okay			; check for invalid result in al

invalidResult:      ;  fall through to invalid result
	printError errorStr
	jmp nextQ		; jump over the okay branch, to the next question

okay:
	mov var3, al

nextQ:
; 3. write a procedure that accepts 2 input arguments: an array 
; of DWORDs and the number of elements. The procedure zeroes out all 
; the elements at an even index (index 0, 2, 4...)
;
; the procedure call is given here:
push OFFSET arr     ; address of arr
push LENGTHOF arr   ; num of elems of arr
call proc1

exit
main ENDP

COMMENT !
; This forms the answer to question 4:
addr of arr					ebp+12
num of elems of arr			ebp+8
return addr					ebp+4
ebp							ebp
regs						ebp-4     <-- esp
!

proc1 PROC
	push ebp
	mov ebp, esp
	push eax
	push ecx

	mov eax, [ebp+12]		; eax = address of arr[0]
	mov ecx, [ebp+8]		; ecx = 8 or count of elems
	loopTop :
		mov DWORD PTR [eax], 0	; zero out arr[i]
		add eax, 8				; i = i + 2 to skip the odd index
		sub ecx, 2				; decrement by 2 since we skip 1 element
		cmp ecx, 0				; if ecx > 0 
		jg loopTop				; then loop back
		
	done:
		pop ecx
		pop eax
		pop ebp
		ret 8		; pop return addr, clear out 8 bytes of input args
proc1 ENDP

END main

COMMENT !

These sample questions are to read code

4. With the procedure call to proc1 of question 3, show a diagram
of the stack frame of proc1 at the point right after all the even indexed
elements have been zeroed out. 
For each value in the stack frame, you can either put the register 
name that holds the value (such as: eax), or describe what the value 
is (such as: return addr in main)
Make sure to list the values in the order that they appear in the stack,
and show where the stack top is

Answer:
address of arr					
8	
return addr					
ebp							
eax
ecx                 <-- stack top


5. Show the value of all registers that are changed after each
instruction. 
If and instruction doesn't run, put X next to it.

xor al, al			; al: 0000 0000
or al, 82h			; al: 1000 0010
shl al, 1			; al: 0000 0100   CF: 1
jc L1				; CF is 1 so we jump to L1
and bl, 0			; X
jz L2				; X
L1: not al			; al: 1111 1011
L2:


6. Using the same arr defined in main above, show the values in the array
after this code segment:

                            ; showing work:
mov edx, OFFSET arr			; edx = addr of arr[0]
add edx, LENGTHOF arr		; edx = edx + 8 = addr of arr[2]
add DWORD PTR [edx], 2		; [edx] = arr[2], arr[2] + 2 = 3 + 2 = 5 => arr[2]
sub edx, 4					; edx = edx - 4 = addr of arr[1]
add DWORD PTR [edx], 4		; [edx] = arr[1], arr[1] + 4 = 2 + 4 = 6 => arr[1]

; original array:   arr DWORD 1,2,3,4,5,6,7,8

Answer:
; after code runs,  arr: 1 6 5 4 5 6 7 8


7. Explain why you need to run:  mov ebp, esp     in a procedure that
accepts arguments through the stack

Answer: ebp gets the current esp value at the start of the procedure.
This means ebp has the address which is 1 slot away from the input arguments on the stack
and allows us to use ebp+8, ebp+12, ebp+16, ...  to access the input arguments

Explain why you generally don't need to run:  mov ebp, esp   in a procedure that
acccepts arguments through registers

Answer: there is no need to set ebp because it will not be used to access input
arguments on the stack. All input arguments are in registers
!