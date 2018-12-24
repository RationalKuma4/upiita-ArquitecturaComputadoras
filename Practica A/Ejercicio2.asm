;
; Test.asm
;
; Created: 29/09/2017 12:22:36 p. m.
; Author : Anselmo-LT
;


; Replace with your application code
.org 0x000 rjmp config
config: ldi r20, 0xf0
		out ddrb, r20
		out ddrd, r20
		ser r20
		out ddrc, r20

loop:	in r16, pinb
		mov r17, r16
		swap r16
		out portb, r16
		in r16, pind
		mov r18, r16
		swap r16
		out portd, r16
		add r17, r18
		out portc, r17
		rjmp loop