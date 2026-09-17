/**************************************************************************
 *     File: Lab04.asm
 * Lab Name: 
 *   Author: 
 *  Created: 
 *
 * This program...
 *************************************************************************/ 
 .def n = R16
.def result = R17
.org 0x0000 ; next instruction will be written to address 0x0000
            ; (the location of the reset vector)
rjmp main	; set reset vector to point to the main code entry point

main:       ; jump here on reset

		; initialize the stack (RAMEND = 0x10FF by default for the ATmega128A)
		ldi R16, HIGH(RAMEND)
		out SPH, R16
		ldi R16, low(RAMEND)
		out SPL, R16

		LDI  n, 5	; load a value into n
		PUSH n	; push it on the stack
		CALL factN	; calculate the factorial of n
		POP  result	; pop result off stack
here:
		RJMP here	; loop forever

factN:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; factN recusivly computes n!
	; 1. caller pushes n onto the stack
	; 2. caller runs CALL factN
	; 3. factN writes over the same stack byte with (n!)
	; 4. caller retrieves answer with pop
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; recursive factorial code begins here
	IN YL, SPL ; low byte loading y
	IN YH, SPH ; high byte loading y
	LDD R18, Y+3 ; R18 will be n

	CPI R18, 1 ; base case where n = 1
	BRNE recursiveCase

	LDI R18, 1 ; where base case goes to
	STD Y+3, R18 ; overwriting our n with result
	ret


recursiveCase:
	DEC R18 ; now R18 = n - 1
	PUSH R18 ; pushing n - 1 (but not my n)

	CALL factN

	POP R19 ; which is (n-1)! and brings back SP
	IN YL, SPL ; reloading y
	IN YH, SPH ; reloading y
	LDD R18, Y+3 ; reloading my n
	MUL R18, R19 ; multiplying for factorial
	STD Y+3, R0 ; low byte back into n
	

	ret 
	; return from the factN subroutine
