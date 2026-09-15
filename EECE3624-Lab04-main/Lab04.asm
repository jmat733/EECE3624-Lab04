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

		LDI  n, 4	; load a value into n
		PUSH n	; push it on the stack
		CALL factN	; calculate the factorial of n
		POP  result	; pop result off stack
here:
		RJMP here	; loop forever

factN:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Comments regarding the factN subroutine go here
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; recursive factorial code begins here



recursiveCase:


	ret 
	; return from the factN subroutine
