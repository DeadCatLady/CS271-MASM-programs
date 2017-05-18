TITLE Project 3   (proj3.asm)

; Author:					Christa
; 
; Course / Project ID		CS 271-400, Project 3   
; Assignment Number			3
; Date:						5/7/2017
; Description:
;	Write and test a MASM program to perform the following tasks:
;	1. Display the program title and programmer’s name.
;	2. Get the user’s name, and greet the user.
;	3. Display instructions for the user.
;	4. Repeatedly prompt the user to enter a number. Validate the user input to be in [-100, -1] (inclusive). Count and accumulate the valid user numbers until a non-negative number is entered. (The non-negative number is discarded.)
;	5. Calculate the (rounded integer) average of the negative numbers.
;	6. Display:
;	i. the number of negative numbers entered (Note: if no negative numbers were entered, display a special message and skip to iv.)
;	ii. the sum of negative numbers entered
;	iii. the average, rounded to the nearest integer (e.g. -20.5 rounds to -20)
;	iv. a parting message (with the user’s name)
; Extra-credit options (original definition must be fulfilled):
;	1. Number the lines during user input.
;	2. Calculate and display the average as a floating-point number, rounded to the nearest .001.
;	3. Do something astoundingly creative.

INCLUDE Irvine32.inc

; (insert constant definitions here)
	UPPERLIMIT = -1
	LOWERLIMIT = -100

.data

; (insert variable definitions here)


	;Intro, directions, bye
		progIntro	BYTE	"Welcome to the Integer Accumulator", 0
		progIntro2	BYTE	"Programmed by Christa Wright", 0
		line		BYTE	"~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~", 0
		hello		BYTE	"Hello, ", 0
		dir1		BYTE	"Please enter numbers in [-100, -1].", 0
		dir2		BYTE	"Enter a non-negative number when you are finished to see results.", 0
		bye			BYTE	"Thank you for playing Integer Accumulator! It's been a pleasure to meet you, ", 0
		dot			BYTE	".", 0
	;Get User Name
		getUserName	BYTE	"What is your name? ", 0
		userName	BYTE	21 DUP(0)				;input buffer
		byteCount	DWORD	?						;holds counter
	;Actual prog
		dir3		BYTE	" Enter number: ", 0
		warn1		BYTE	"The number you entered is ", 0
		num			DWORD	?
		count		DWORD	1
		calcNums	DWORD	0
		totNums		BYTE	"The total is:	", 0
		accNums		BYTE	"Amount of numbers accumulated:	", 0
		roundedAvg_prompt	BYTE	"The Rounded Average is: ", 0
		rndedAvg	DWORD	0
		remainder	DWORD	0
		floating_point	BYTE	"Floating number: ", 0
		neg1k		DWORD	-1000
		onek		DWORD	1000
		subtract    DWORD	?
		floatingPoint	DWORD	?

	
	;EX: 
		ex1		BYTE	"EX1: Number the lines during user input.", 0
		ex2		BYTE	"EX2: Calculate and display the average as a floating-point number, rounded to the nearest .001.",0
		ex3		BYTE	"EX3: I made the text color different!", 0
		lime	DWORD	10
		val2	DWORD	16



.code
main PROC

	; Set text color to lime green
		mov		eax, val2
		imul	 eax, 16
		add		eax, lime
		call	 setTextColor

COMMENT !
	===================================================================
	~*~*~*~*~*~| INTRODUCE PROGRAM \ GET USER NAME	| ~*~*~*~*~*~*~*~*~
	===================================================================
!
		mov		edx, OFFSET progIntro
		call	WriteString
		call	CrLf
		mov		edx, OFFSET progIntro2
		call	WriteString
		call	CrLf
		call	CrLf
		mov		edx, OFFSET ex1
		call	WriteString
		call	CrLf
		mov		edx, OFFSET ex2
		call	WriteString
		call	CrLf
		mov		edx, OFFSET ex3
		call	WriteString
		call	CrLf
		call	CrLf
		mov		edx, OFFSET line
		call	WriteString
		call	CrLf
		call	CrLf
		mov		edx, OFFSET getUserName
		call	WriteString
	;Gets user Name
		mov		edx, OFFSET userName		; point to the buffer
		mov		ecx, SIZEOF userName		; specify max characters
		call	ReadString					; input the string
		mov		byteCount, eax				; number of characters
	;Greets User
		mov		edx, OFFSET hello			
		call	WriteString
		mov		edx, OFFSET userName
		call	WriteString
		mov		edx, OFFSET dot
		call	WriteString
		call	CrLf
		call	CrLf

COMMENT !
	===================================================================
	~*~*~*~*~*~| DISPLAY DIRECTIONS FOR THE USER	| ~*~*~*~*~*~*~*~*~
	===================================================================
!
	;Directions
		mov		edx, OFFSET dir1
		call	WriteString
		call	CrLf
		mov		edx, OFFSET dir2
		call	WriteString
		call	CrLf


COMMENT !
	===================================================================
	~*~*~*~*~*~|			 ENTER NUMBERS		   	| ~*~*~*~*~*~*~*~*~
	===================================================================
!
	usersNumbers:
			mov		eax, count
			call	WriteDec
			add		eax, 1
			mov		count, eax
			mov		edx, OFFSET dir3
			call	WriteString
			call	ReadInt
			mov		num, eax
			cmp		eax, LOWERLIMIT
			jb		mathStuff
			cmp		eax, UPPERLIMIT
			jg		mathStuff
			add		eax, calcNums
			mov		calcNums, eax
			call	CrLf
			loop	usersNumbers

		

COMMENT !
	===================================================================
	~*~*~*~*~*~|		CALCULATIONS				| ~*~*~*~*~*~*~*~*~
	===================================================================
!
	mathStuff:
			;Did the user follow directions?

			mov		eax, count
			sub		eax, 2
			jz		goodbye
			mov		eax, calcNums
			call	CrLf

			;	Total
			mov		edx, OFFSET totNums
			call	WriteString
			mov		eax, calcNums
			call	WriteInt
			call	CrLf

			;	total of the numbers entered
			mov		edx, OFFSET accNums
			call	WriteString
			mov		eax, count
			sub		eax, 2
			call	WriteDec
			call	CrLf

			;Rounded Average
			mov		edx, OFFSET roundedAvg_prompt
			call	WriteString
			mov		eax, 0
			mov		eax, calcNums
			cdq
			mov		ebx, count
			sub		ebx, 2
			idiv	ebx
			mov		rndedAvg, eax
			call	WriteInt
			call	CrLf

			; average for count
			mov		remainder, edx
			mov		edx, OFFSET	floating_point
			call	WriteString
			call	WriteInt
			mov		edx, OFFSET	dot
			call	WriteString

			;floating point
			mov		eax, remainder
			mul		neg1k
			mov		remainder, eax
			mov		eax, count
			sub		eax, 2
			mul		onek
			mov		subtract, eax

			fld		remainder
			fdiv	subtract
			fimul	onek
			frndint
			fist	floatingPoint
			mov		eax, floatingPoint
			call	WriteDec
			call	CrLf


			

COMMENT !
	===================================================================
	~*~*~*~*~*~|	RESULTS \ GOODBYE USER			| ~*~*~*~*~*~*~*~*~
	===================================================================
!

	goodbye:
			call	CrLf
			call	CrLf
			mov		edx, OFFSET bye
			call	WriteString
			mov		edx, OFFSET userName
			call	WriteString
			mov		edx, OFFSET dot
			call	WriteString
			call	CrLf

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
