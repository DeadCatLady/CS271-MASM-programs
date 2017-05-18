TITLE Fibonacci Numbers    (fibonacci.asm)

; Author:					Christa
; 
; Course / Project ID		CS 271-400, Project 2    
; Assignment Number			2
; Date:						4/16/2017
; Description:
; Write a program to calculate Fibonacci numbers
;Prompt user to enter the number of terms to be displayed
;Advice user to enter an integer between 1-46
;Calculate and display all of the Fibonacci numbers up to and including the nth term.
;Results should be displayed 5 terms per line with at least 5 spaces between them
;Display a parting message that includes the user's name, and terminates the program

INCLUDE Irvine32.inc

; (insert constant definitions here)
	UPPERLIMIT=46
	LOWERLIMIT=1
.data

; (insert variable definitions here)
	
	progIntro	BYTE	"Fibonacci Numbers", 0
	progIntro2	BYTE	"Programmed by Christa Wright", 0
	extra		BYTE	"EC: Do something amazing! I drew a cat." , 0
	hello		BYTE	"Hello, ", 0
	instruc1	BYTE	"Enter the number of Fibonacci terms to be displayed", 0
	instruc2	BYTE	"Give the number as an integer in the range [1 .. 46]. ", 0
	fibNumber	DWORD	?
	prenum1		DWORD	?
	prenum2		DWORD	?
	temp		DWORD	?
	mod5		DWORD	5
	spaces		BYTE	"     ", 0
	tooHigh		BYTE	"The number you entered is too high. It needs to be below 46", 0
	tooLow		BYTE	"The number you entered is too low. It needs to be above 1", 0
	firstOne	BYTE	"1", 0
	first2		BYTE	"1     1     ", 0
	first3		BYTE	"1     1     2", 0
	bye			BYTE	"Goodbye, ", 0
	cat1		BYTE	" \    /\", 0
	cat2		BYTE	"  )  ( ')  ~ 'Meow! <3' ~ ", 0
	cat3		BYTE	"  (  /  )", 0
	cat4		BYTE	"   \(__)|", 0


;Get User Name
	getUserName	BYTE	"What is your name? ", 0
	userName	BYTE	21 DUP(0)				;input buffer
	byteCount	DWORD	?						;holds counter
	

.code
main PROC

; (insert executable instructions here)

COMMENT !
	===================================================================
	~*~*~*~*~*~| INTRODUCE PROGRAM \ GET USER NAME	| ~*~*~*~*~*~*~*~*~
	===================================================================
!
;Introduction

	;Intro
		mov		edx, OFFSET progIntro
		call	WriteString
		call	CrLf
		mov		edx, OFFSET progIntro2
		call	WriteString
		call	CrLf
		mov		edx, OFFSET extra
		call	WriteString
		call	CrLf
		call	CrLf
		mov		edx, OFFSET getUserName
		call	WriteString
	;Gets user Name
		mov		edx, OFFSET userName		; point to the buffer
		mov		ecx, SIZEOF userName		;specify max characters
		call	ReadString					;input the string
		mov		byteCount, eax				;number of characters
	;Greets User
		mov		edx, OFFSET hello			
		call	WriteString
		mov		edx, OFFSET userName
		call	WriteString
		call	CrLf

top:
	;userInstructions
			mov		edx, OFFSET instruc1
			call	WriteString
			call	CrLf
			mov		edx, OFFSET instruc2
			call	WriteString
			call	CrLf

	;getUserData
			call	ReadInt
			mov		fibNumber, eax

	;Make sure fibNum is in the correct range.
			cmp		eax, UPPERLIMIT
			jg		numberTooHigh
			cmp		eax, LOWERLIMIT
			jl		numberTooLow
			je		SingleOne
			cmp		eax, 2
			je		firstTwo
			cmp		eax, 3
			je		firstThree

;displayFibs
			mov		ecx, fibNumber
			sub		ecx, 3
			mov		eax, 1
			call	WriteDec
			mov		edx, OFFSET spaces
			call	WriteString
			call	WriteDec
			mov		edx, OFFSET spaces
			call	WriteString
			mov		prenum2, eax
			mov		eax, 2
			call	WriteDec
			mov		edx, OFFSET spaces
			call	WriteString
			mov		prenum1, eax

	fibonacci:
			add		eax, prenum2
			call	WriteDec
			mov		edx, OFFSET spaces
			call	WriteString
			mov		temp, eax
			mov		eax, prenum1
			mov		prenum2, eax
			mov		eax, temp
			mov		prenum1, eax
			mov		edx, ecx
			cdq
			div		mod5
			cmp		edx, 0
			jne		skip
			call	CrLf
	skip:	
			mov		eax, temp
			loop	fibonacci
			jmp		farewell


			jmp		farewell




numberTooHigh:
			mov		edx, OFFSET tooHigh
			call	WriteString
			call	CrLf
			jmp		top
numberTooLow:
			mov		edx, OFFSET tooLow
			call	WriteString
			call	CrLf
			jmp		top
SingleOne:
			mov		edx, OFFSET firstOne
			call	WriteString
			call	CrLf
			jmp		farewell
FirstTwo:
			mov		edx, OFFSET first2
			call	WriteString
			call	CrLf
			jmp		farewell
FirstThree:
			mov		edx, OFFSET first3
			call	WriteString
			call	CrLf
			jmp		farewell
farewell:

		;Goodbye User
			call	CrLf
			mov		edx, OFFSET bye
			call	WriteString
			mov		edx, OFFSET userName
			call	WriteString
			call	CrLf
			mov		edx, OFFSET cat1
			call	WriteString
			call	CrLf
			mov		edx, OFFSET cat2
			call	WriteString
			call	CrLf
			mov		edx, OFFSET cat3
			call	WriteString
			call	CrLf
			mov		edx, OFFSET cat4
			call	WriteString
			call	CrLf

	

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
