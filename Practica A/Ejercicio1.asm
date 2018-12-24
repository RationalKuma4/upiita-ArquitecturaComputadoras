;0087654321
;0b00100000
; Replace with your application code
.org 0x000 jmp config
config:	;ddrb = 0x000
		ldi r16, 0b11110000
		out ddrb, r16
		ldi r16, 0b00001111
		out ddrd, r16

loop:	in	r17, pinb
		out portd, r17
		in	r17, pind
		out portb, r17
		jmp loop

/*
loop:	in	r17, pinb
		out portd, r17
		in	r17, pind
		out portb, r17
		jmp loop
*/
/*.include "./m328Pdef.inc"
	ldi r16,0b00110000
	out DDRB,r16
	out PortB,r16
Start:
	rjmp Start*/

/*.include "./m328Pdef.inc"
.org 0x000 jmp config
config:	ldi r16, 0b11110000
		out ddrb, r16
		ldi r16, 0b00001111
		out ddrd, r16
loop:	in	r17, pinb
		out portb, r17	

		in	r17, pind
		out portd, r17
		jmp loop*/