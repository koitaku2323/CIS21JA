TITLE Module8Exercise						

INCLUDE Irvine32.inc


space macro ; macro to print a single space
push eax
mov eax,' '
call writeChar
pop eax
endm

numrow = 3
numcol = 5

.data
arr WORD 1,2,3,3,4,4,5,6,2,2,2,7,5,5,5
uniq WORD 15 dup(0)

twoD WORD 0,1,2,3,4
     WORD 10,11,12,13,14
     WORD 20,21,22,23,24
;or	 
;twoD WORD 0,1,2,3,4,10,11,12,13,14,20,21,22,23,24

.code

main PROC
; part 1: copy arr into uniq, print uniq to check

mov ecx, LENGTHOF arr
mov esi, OFFSET arr
mov edi, OFFSET uniq
copyLoop:
    mov ax, [esi]
    mov [edi], ax
    add esi, TYPE arr
    add edi, TYPE arr
    loop copyLoop

mov ecx, LENGTHOF arr
mov esi, OFFSET arr
mov edi, OFFSET uniq
cld
rep movsw

mov esi, OFFSET uniq
mov ecx, LENGTHOF uniq
call printStr

; part 2: zero out uniq
xor eax, eax
mov ecx, LENGTHOF uniq
mov edi, OFFSET uniq
rep stosw

mov esi, OFFSET uniq
mov ecx, LENGTHOF uniq
call printStr

; part 3: copy arr into uniq, but don't copy consecutive 
; duplicate numbers
mov esi, OFFSET arr
mov edi, OFFSET uniq
mov ecx, LENGTHOF arr
movsw

dec ecx

topOfLoop:
sub edi, 2
cmpsw
je pass

sub esi, 2
movsw

pass:
loop topOfLoop

mov esi, OFFSET uniq
mov ecx, LENGTHOF uniq
call printStr


; part 4: implement: ax = twoD[2][3] 
mov ebx, 2
mov edi, 3

mov eax, numcol
mul ebx
shl eax, 1

shl edi, 1

mov ax, twoD[eax + edi]


; part 5: implement: ax = twoD[1][2] 
;          by using ebx
mov ebx, OFFSET twoD
mov edx, 1
mov edi, 2

mov eax, numcol
mul edx
shl eax, 1

shl edi, 1

add eax, edi
mov ax, [ebx + eax]

exit
main ENDP

printStr PROC
xor eax, eax
cld
printLoop:
    lodsw
    call writeDec
    space
    loop printLoop
    call crlf
ret
printStr ENDP

END main