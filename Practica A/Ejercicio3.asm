.org 0x000 jmp config
config:	;ddrb = 0x000
		ldi r16, 0b00001111
		out ddrb, r16
		ldi r16, 0b11111111
		out ddrd, r16
		ldi r18, 0b00000001
		ldi r19, 0b00000010
		ldi r20, 0b00000100
		ldi r21, 0b00001000
		ldi r22, 0b00000000

loop:	in r16, pinb
		cp r16, r22
		breq cero
		cp r16, r18
		breq uno
		cp r16, r19
		breq dos
		cp r16, r20
		breq tres
		cp r16, r21
		breq cuatro

cero:	ldi r17, 0b00000000
		out portd, r17
		jmp loop

uno:	ldi r17, 0b11001100
		out portd, r17
		jmp loop

dos:	ldi r17, 0b00110011
		out portd, r17
		jmp loop

tres:	ldi r17, 0b11110000
		out portd, r17
		jmp loop

cuatro:	ldi r17, 0b00001111
		out portd, r17
		jmp loop