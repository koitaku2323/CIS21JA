TITLE Module 7 Exercise

INCLUDE Irvine32.inc

.stack		;;;;; is this needed?
			;;;;; It is not needed because include Irvine32.inc already
			;;;;; does the same thing. (sets stack to 4k bytes)

printStr MACRO strAddress, val
	push edx
	push eax
	mov edx, strAddress
	call writeString
	movzx eax, val
	call writeDec
	call crlf
	pop eax
	pop edx
ENDM

.data
n1 BYTE 3
n2 BYTE 4
prod WORD ?

productStr BYTE "product is ", 0
n2Str BYTE "n2 is ", 0


.code
main PROC

;;;;; part 1   parameter passing through registers

; a. write the mul1 procedure that accepts 2 input through registers
;    and returns the product through a register
; b. call the mul1 procedure, passing in the values in al and bl
; c. print the product and text explanation (use the productStr above for the text)

mov al, 5
mov bl, 3
call mul1

movzx eax, ax
mov edx, OFFSET productStr
call writeString
call writeDec
call crlf

;;;;; part 2   parameter passing through the stack: pass by value

; a. write the mul2 procedure that accepts 2 input through the stack
;    and returns the product through the stack
; b. call mul2 to do:  prod = n1 * n2
; c. define a macro that accepts a string and an unsigned value
; d. invoke the macro with the productStr (defined above) to print on a separate line: product is ---

sub esp, 4
movzx eax, n1
push eax
movzx eax, n2
push eax
call mul2
pop eax
mov prod, ax

printStr OFFSET productStr, prod


;;;;; part 3   parameter passing through the stack: pass by address or by reference
; a. write the calc procedure to do the following 2 tasks 
;      prod = prod * n1 + n2  
;      n2 = n2 - 1
;   both prod and n2 will be updated
;   calculation should call mul2 to do the multiplication
; b. call calc 
; c. invoke the same macro twice and use the strings defined above to print:
;       product is ---
;       n2 is ---

push OFFSET prod
push OFFSET n2
movzx eax, n1
push eax
call calc

printStr OFFSET productStr, prod
printStr OFFSET n2Str, n2

exit
main ENDP


; mul1 multiplies 2 bytes 
; input: al, bl
; output: ax
mul1 PROC
	mul bl
	ret
mul1 ENDP


; mul2 multiplies 2 bytes
; input: n1, n2
; output: on stack
mul2 PROC	
	push ebp
	mov ebp, esp
	push eax
	push edx
	mov eax, [ebp + 12]
	mul DWORD PTR [ebp + 8]
	mov [ebp + 16], eax

	pop edx
	pop eax
	pop ebp
	ret 8
mul2 ENDP


; calc runs:
;      prod = prod * n1 + n2  
;      n2 = n2 - 1
; input: n1, n2, prod
; output: none
calc PROC
	push ebp
	mov ebp, esp
	pushad
	mov edx, [ebp + 16]
	mov ebx, [ebp + 12]
	sub esp, 4
	movzx eax, WORD PTR [edx]
	push eax
	push DWORD PTR [ebp + 8]
	call mul2
	pop eax
	movzx ecx, BYTE PTR [ebx]
	add eax, ecx
	mov [edx], ax
	dec BYTE PTR [ebx]
	popad
	pop ebp
	ret 12
calc ENDP


END main