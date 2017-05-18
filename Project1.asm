TITLE Project1     (Project1.asm)

; Author:					Christa 
; 
; Course / Project ID		CS 271-400, Project 1    
; Assignment Number			1
; Date:						4/16/2017
; Description: 
;	1. Display your name and program title on the output screen.
;	2. Display instructions for the user.
;	3. Prompt the user to enter two numbers.
;	4. Calculate the sum, difference, product, (integer) quotient and remainder of the numbers. 

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data

; (insert variable definitions here)

	intro_1		BYTE	"Elementary Arithmetic by Christa Wright", 0
	intro_2		BYTE	"Enter 2 numbers, and I'll show you the sum, difference, product, quotient, and remainder.", 0
	prompt_1	BYTE	"First number: ", 0
	num_1		DWORD	?
	prompt_2	BYTE	"Second number: ", 0
	num_2		DWORD	?
	sum			DWORD	0
	difference	DWORD	0
	product		DWORD	0
	quotient	DWORD	0
	remainder	DWORD	0
	remain		BYTE	" remainder ", 0
	plus		BYTE	" + ", 0
	equals		BYTE	" = ", 0
	subtract	BYTE	" - ", 0
	times		BYTE	" x ", 0
	divide		BYTE	0f6h, 0
	space		BYTE	" ", 0
	goodBye		BYTE	"Impressed? Bye! ", 0

;EXTRA CREDIT 1	Have the program loop until the user decides to quit

	ex_1		BYTE	"**Extra Credit 1: Program continues until user wants to quit.", 0
	ex1_prompt	BYTE	"EX 1: Enter 1 to play again, enter 2 to exit the program "
	ex1_input	DWORD	?

;EXTRA CREDIT 2	Ensure that the user has entered a num_1 as greater than num_2
	
	ex_2		BYTE	"**Extra Credit 2: Program ensures that the first number is greater than the second number!", 0
	ex2_prompt	BYTE	"EX 2: The first number must be larger than the second number!", 0

.code
main PROC

; (insert executable instructions here)

;Introduce Programmer
	mov		edx, OFFSET intro_1
	call	WriteString
	call	CrLf
	mov		edx, OFFSET ex_1
	call	WriteString
	call	CrLf
	mov		edx, OFFSET ex_2
	call	WriteString
	call	CrLf

top:
	;Display instructions for the user
		mov		edx, OFFSET intro_2 
		call	WriteString
		call	CrLf

	;Get first number
		mov		edx, OFFSET prompt_1
		call	WriteString
		call	ReadInt
		mov		num_1, eax		;assign number 1

	;Get second number
		mov		edx, OFFSET prompt_2
		call	WriteString
		call	ReadInt
		mov		num_2, eax		;assign number 2

	COMMENT !
		===============================================================
		~*~*~*~*~*~*~*~*~*~*~*~*| EXTRA CREDIT 2 |~*~*~*~*~*~*~*~*~*~*~
		===============================================================
	!

	;EXTRA CREDIT: Ensures that num_1 is greater than num_2
		mov		edx, num_2		;move num_1 to register
		cmp		edx, num_1		;num_2 > num_1?
		jg		failed			;yes, jump to Fail
		jle		doMathStuff		;no, jump to doTheMathStuff

failed:

	;EXTRA CREDIT: Display fail to user	
		mov		edx, OFFSET ex2_prompt
		call	WriteString
		call	CrLf
		jg		top		;Take the user to the begining of the program
		



doMathStuff:

	COMMENT !
		===============================================================
		~*~*~*~*~*~*~*~*~*~*~*~*| ADDITION |~*~*~*~*~*~*~*~*~*~*~*~*
		===============================================================
	!

	;Display the sum of num_1 + num_2
		mov		eax, num_1
		call	WriteDec			;Display first number
		mov		edx, OFFSET plus
		call	WriteString			;Display + sign
		mov		eax, num_2
		call	WriteDec			;Display second number

	;Calculate sum of first and second number
		mov		eax, num_1
		add		eax, num_2		
		mov		sum, eax

	;Display the sum
		mov		edx, OFFSET equals	;Display = sign
		call	WriteString
		mov		edx, OFFSET sum
		call	WriteDec			;Display sum
		call	CrLf

	COMMENT !
		===============================================================
		~*~*~*~*~*~*~*~*~*~*~*~*| SUBTRACTION |~*~*~*~*~*~*~*~*~*~*~*~*
		===============================================================
	!

	;Display the difference of num_1 - num_2
		mov		eax, num_1
		call	WriteDec			;Display first number
		mov		edx, OFFSET subtract
		call	WriteString			;Display - sign
		mov		eax, num_2
		call	WriteDec			;Display second number

	;Calculate the difference of the first and second number
		mov		eax, num_1
		sub		eax, num_2
		mov		difference, eax

	;Display difference
		mov		edx, OFFSET equals
		call	WriteString			;Display = sign
		mov		edx, OFFSET difference
		call	WriteDec			;Display difference
		call	CrLf

	COMMENT !
		===============================================================
		~*~*~*~*~*~*~*~*~*~*~*~*| PRODUCT |~*~*~*~*~*~*~*~*~*~*~*~*
		===============================================================
	!

	;Display the product of num_1 x num_2
		mov		eax, num_1
		call	WriteDec			;Display first number
		mov		edx, OFFSET times
		call	WriteString			;Display x sign
		mov		eax, num_2
		call	WriteDec			;Display second number	

	;Calculate the product of the first and second number
		mov		eax, num_1
		mov		ebx, num_2
		mul		ebx
		mov		product, eax

	;Display product
		mov		edx, OFFSET equals
		call	WriteString			;Display = sign
		mov		edx, OFFSET product
		call	WriteDec			;Display product
		call	CrLf

	COMMENT !
		==========================================================================
		~*~*~*~*~*~*~*~*~*~*~*~*| QUOTIENT AND REMAINDER |~*~*~*~*~*~*~*~*~*~*~*~*
		==========================================================================
	!

	;Display the quotient of num_1 / num_2
		mov		eax, num_1
		call	WriteDec			;Display first number
		mov		edx, OFFSET divide
		call	WriteString			;Display divide sign
		mov		eax, num_2
		call	WriteDec			;Display second number	

	;Calculate the quotient and remainder of the first and second number
		mov		eax, 0
		mov		ebx, 0
		mov		edx, 0
		mov		eax, num_1
		mov		ebx, num_2
		div		ebx
		mov		quotient, eax
		mov		remainder, edx

	;Display the quotient and remainder
		mov		edx, OFFSET equals
		call	WriteString			;Display = sign
		mov		eax, quotient
		call	WriteDec			;Display quotient
		mov		edx, OFFSET remain
		call	WriteString			;Display remainder
		mov		eax, remainder
		call	WriteDec			;Display remainder number
		call	CrLf

LoopPlease:

	COMMENT !
		===============================================================
		~*~*~*~*~*~*~*~*~*~*~*~*| EXTRA CREDIT 1 |~*~*~*~*~*~*~*~*~*~*~
		===============================================================
	!

	;EXTRA CREDIT: Display extra credit 1 statement
		mov		edx, OFFSET ex1_prompt
		call	WriteString
		call	ReadInt
		mov		ex1_input, eax
		cmp		eax, 1
		je		top

	;Say GoodBye, ends program
		mov		edx, OFFSET goodbye
		call	WriteString
		call	CrLf

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
