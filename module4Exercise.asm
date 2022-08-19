TITLE Module 4 Class Exercise			


COMMENT !
There are 4 main concepts in module 4:
- data transfer or the mov* instructions
- add / subtract
- multiply / divide
- flags
!

INCLUDE Irvine32.inc

.data
num word 4
negNum word -4


.code
main PROC
;;;;; part 1: data transfer
; write code to move num into bx
mov bx, num

; write code to move num into ecx
movzx ecx, num


; write code to move negNum into ebx
movsx ebx, negNum


;;;;; part 2: arithmetic
;;;;; warm up with basic arithmetic

; write code to add num to ax
add ax, num

; write code to add ax to num
add num, ax

; write code to subtract num from ax
sub ax, num

; write code to subtract ax from num        
sub num, ax

; write code to subtract 1 from ax
dec ax        ; or sub ax, 1

; can we write 1 line of code to subtract num1 from num2, if both are defined?
;sub num2, num1		;  No we cannot, because we can't have two memory operands

; write code to multiply num by 5
mov ax, num
mov bx, 5
mul bx

; write code to multiply ax by num
mov ax, num
mul num

; write code to divide num by 5
mov ax, num
mov bl, 5
div bl

; write code to divide num by -5
mov ax, num
mov bl, -5
div bl

;;;;;; now for some real, rolling up your sleeves work
; implement this expression
; 5 - 2 + (8 / 3)

mov bx, 8
mov cx, 3
div cx

mov ax, 5
sub ax, 2
add ax, cx


;;;;;; part 3: flags
; FLAGS for add
; predict what the CF, OF, SF, ZF values are
; optionally you can run the program with the debugger and see if your predictions are correct


; next to each instruction that's an add or sub instruction,
; list the value of  CF, OF, SF, ZF
; the first step has been done for you

mov al,0f0h            
call DumpRegs
add al,0fh			; 1111 0000 + 0000 1111 = (0) 1111 1111
					; CF = 0, SF = 1, ZF = 0, OF = 0
call DumpRegs		
add al,0ffh			; CF = 1, SF = 1, ZF = 0, OF = 0
call DumpRegs


mov al,0ffh
call DumpRegs
add al, 80h			; CF = 1, SF = 0, ZF = 0, OF = 1
call DumpRegs
mov al,07fh
call DumpRegs
add al,1			; CF = 0, SF = 1, ZF = 0, OF = 1
call DumpRegs 


; CF flags for subtract
mov al,5
sub al,-1			; CF = 1, SF = 0, ZF = 0, OF = 0
call DumpRegs    

mov al,5
sub al,3            ; CF = 0, SF = 0, ZF = 0, OF = 0
call DumpRegs      


exit
main ENDP

END main