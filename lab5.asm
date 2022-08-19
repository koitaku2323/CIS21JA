TITLE  Lab 5: Calculate time difference
		
; Name: Ryan Yee


INCLUDE Irvine32.inc

MIN_PER_HOUR = 60

.data
promptMin BYTE "Enter minute: ", 0
promptHour BYTE "Enter hour: ", 0
promptInvalid BYTE "Invalid input!!!", 0
promptInvalidDiff BYTE "Invalid time difference, check your times "
PromptDecision BYTE "Do you want to calculate again? ( Only y(Y) or n(N) ): ", 0
promptStart BYTE "Enter starting time below", 0
promptEnd BYTE "Enter ending time below", 0
hr BYTE " hours, ", 0
min BYTE " minutes ", 0

.code
main PROC
	
getInput1:

			mov edx, OFFSET promptStart
			call writeString
			call crlf
			mov edx, OFFSET promptHour
			call writeString
			call readInt
			mov ebx, eax
			cmp eax, 23
			jg errorcase1
			cmp eax, 0
			jl errorcase1
			mov edx, OFFSET promptMin
			call writeString
			call readInt
			mov ecx, eax
			cmp eax, 59
			jg errorcase1
			cmp eax, 0
			jl errorcase1
			jmp calculate1

		errorcase1:
					mov edx, OFFSET promptInvalid
					call writeString
					call crlf
					jmp getInput1

getInput2:
			
			mov edx, OFFSET promptEnd
			call writeString
			call crlf
			mov edx, OFFSET promptHour
			call writeString
			call readDec
			mov ebp, eax
			cmp eax, 23
			jg errorcase2
			cmp eax, 0
			jl errorcase2
			mov edx, OFFSET promptMin
			call writeString
			call readDec
			mov esi, eax
			cmp eax, 59
			jg errorcase2
			cmp eax, 0
			jl errorcase2
			cmp eax, 0
			jg calculate2
			mov edx, OFFSET promptInvalid
			call writeString
			call crlf
			jmp getInput1
			

		errorcase2:
					mov edx, OFFSET promptInvalid
					call writeString
					call crlf
					jmp getInput2
			

calculate1:
			mov edi, ebx
			mov eax, MIN_PER_HOUR
			imul edi, eax
			add edi, ecx
			jmp getInput2


calculate2:
			mov ebx, ebp
			imul ebx, MIN_PER_HOUR
			add ebx, esi
			sub ebx, edi
			mov eax, ebx
			;call writeDec
			jmp calculate3

calculate3:
			mov edx, 0
			mov eax, ebx
			cdq
			mov esi, MIN_PER_HOUR
			idiv esi
			mov ebx, edx
			cmp edx, 0
			jl errorcase3
			jmp result

		errorcase3:
					mov edx, OFFSET promptInvalidDiff
					call writeString
					call crlf
					jmp getInput1
					

result: 
			call crlf
			call writeDec
			mov edx, OFFSET hr
			call writeString
			mov eax, ebx
			call writeDec
			mov edx, OFFSET min
			call writeString
			call crlf
			jmp decision

decision:
		call crlf
		mov edx, OFFSET promptDecision
		call writeString
		call readChar
		call writeChar
		call crlf
		cmp al, 'y'
		je getInput1
		cmp al, 'Y'
		je getInput1
		cmp al, 'n'
		je done
		cmp al, 'N'
		je done
		mov edx, OFFSET promptInvalid
		call writeString
		call crlf
		jmp decision

done:

	exit	
main ENDP

END main