TITLE Module 5 Exercise					

INCLUDE Irvine32.inc

.data

.code
main PROC

;;;;;;;;;;;;;;;;;;;; part 1 ;;;;;;;;;;;;;;;;;
; unconditional JMP
; which instructions below will run?

L2: 
    mov eax, 5		; yes
	jmp L1			; yes
	mov ebx, 6		; no
	mov ecx, 7		; no
	jmp L2			; no
L1:   
	mov edx, 8		; yes
	  
; LOOP 
; what is the value of eax after the loop finishes? 
	mov ecx,4
	mov eax,0
L3:
	inc eax		; eax = 1	  eax = 2	eax = 3		eax = 4
	loop L3		; ecx = 3	  ecx = 2	ecx = 1		ecx = 0
				; 3 != 0      2 != 0    1 != 0		no jump
				; jump L3    jump  L3   jump L3
			
	
; what if, in the loop above, we use: mov ecx, 0 instead of: mov ecx, 4
; will the loop run? yes
; how many times? about 4G times

; number of times if ecx starts at 0
; ecx = 0000 0000       start
; ecx = FFFF FFFF (-1)  1st
; ecx = FFFF FFFE (-2)  2nd
; ...
; ecx = 0000 0000       about 4G times

; write a nested loop using LOOP instructions: the outer loop runs 5 times
; the inner loop runs 3 times

mov eax, 0
mov ecx, 5
outer:
		mov ebx, ecx
		mov ecx, 3
		inner:
				inc eax
		loop inner
		mov ecx, ebx
loop outer

call writeDec
call crlf

; implement the same nested loop without LOOP instruction

mov eax, 0
mov ebx, 5
outer2:
		mov ecx, 3
		inner2:
				inc eax
		dec ecx
		jnz inner2
dec ebx
cmp ebx, 0
jne outer2

call writeDec
call crlf

;;;;;;;;;;;;;;;;; part 2 ;;;;;;;;;;;;;;;;;;;;;;

; write code to jump to L10 if the carry flag is set after adding ax and bx
; assume ax and bx have values
add ax, bx
jc L10

; write code to jump to L20 if ax > bx (signed data)
cmp ax, bx
jg L20

; write code to jump to L30 if ax > bx (unsigned data)
cmp ax, bx
ja L30

L10:
L20:
L30:

; implement the following pseudocode to work with signed data
; if (ax <= 10 AND bx > 0)    ;ax = 5, bx = 5
;   dx = 0
; else
;   dx = 5

cmp ax, 10
jg falseBlock
cmp bx, 0
jle falseBlock
mov dx, 0

falseBlock:
			mov dx, 5



; implement the following pseudocode to work with unsigned data
; while (ax > bx OR cx != 0)
; {
;    bx = bx * 2
;    cx = cx - 1
; }

top:
cmp ax, bx
ja loopBody
cmp cx, 0
je endLoop
loopBody:
			mov si, ax
			mov ax, 2
			mul bx
			mov bx, ax
			dec cx
			mov ax, si
			jmp top

endLoop:


;;; if (ax > bx AND bx > cx OR dx == 0)  ;; unsigned
;;;   si = 0
;;; else
;;;   si = 1

cmp ax, bx
jbe thirdCondition
cmp bx, cx
ja trueBlock1
thirdCondition:
				cmp dx, 0
				jne falseBlock1
trueBlock1:
			mov si, 0
			jmp theEnd

falseBlock1:
			mov si, 1

theEnd:


	exit
main ENDP

END main