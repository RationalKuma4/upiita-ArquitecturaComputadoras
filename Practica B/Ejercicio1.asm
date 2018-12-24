.org 0x000 rjmp config

config:	ldi r20, 0x0FF
		out ddrb, r20
		clr r20
		ldi r20, 0x000
		out ddrd, r20
off:clr r21
		out portb, r21
loop:	sbis pind, 1
		rjmp off
		jmp SecUno
		sbis pind, 1
		jmp off
		jmp loop 
SecUno:	ldi r21, 0b01010101
		out portb, r21
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		sbis pind, 1
		rjmp off
		ldi r21, 0b10101010
		out portb, r21
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		ldi r21, 0b01010101
		out portb, r21
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		sbis pind, 1
		rjmp off
		ldi r21, 0b10101010
		out portb, r21
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		ldi r21, 0b01010101
		out portb, r21
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		sbis pind, 1
		rjmp off
		rjmp SecDos

SecDos:	ldi r21, 0b11001100
		out portb, r21
		sbis pind, 1
		rjmp off
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		ldi r21, 0b01100110
		out portb, r21
		sbis pind, 1
		rjmp off
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		ldi r21, 0b00110011
		out portb, r21
		sbis pind, 1
		rjmp off
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		ldi r21, 0b10011001
		out portb, r21
		sbis pind, 1
		rjmp off
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		ldi r21, 0b11001100
		out portb, r21
		sbis pind, 1
		rjmp off
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		rjmp SecTres

SecTres:ldi r21, 0b10000000
		out portb, r21
		sbis pind, 1
		rjmp off
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		ldi r21, 0b01000000
		out portb, r21
		sbis pind, 1
		rjmp off
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		ldi r21, 0b00100000
		out portb, r21
		sbis pind, 1
		rjmp off
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		ldi r21, 0b00010000
		out portb, r21
		sbis pind, 1
		rjmp off
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		ldi r21, 0b00001000
		out portb, r21
		sbis pind, 1
		rjmp off
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		ldi r21, 0b00000100
		out portb, r21
		sbis pind, 1
		rjmp off
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		ldi r21, 0b00000010
		out portb, r21
		sbis pind, 1
		rjmp off
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		ldi r21, 0b00000001
		out portb, r21
		sbis pind, 1
		rjmp off
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		rjmp SecCuat

SecCuat:ldi r21, 0b10000001
		out portb, r21
		sbis pind, 1
		rjmp off
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		ldi r21, 0b01000010
		out portb, r21
		sbis pind, 1
		rjmp off
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		ldi r21, 0b00100100
		out portb, r21
		sbis pind, 1
		rjmp off
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		ldi r21, 0b00011000
		out portb, r21
		sbis pind, 1
		rjmp off
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		ldi r21, 0b00100100
		out portb, r21
		sbis pind, 1
		rjmp off
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		ldi r21, 0b01000010
		out portb, r21
		sbis pind, 1
		rjmp off
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		ldi r21, 0b10000001
		out portb, r21
		sbis pind, 1
		rjmp off
		sbis pind, 0
		call Delay10
		sbic pind, 0
		call Delay400
		rjmp loop

Delay10:ldi  r18, 104
		ldi  r19, 229
Delay100:sbis pind, 1
		rjmp off
		ldi  r18, 5
		ldi  r19, 15
		ldi  r20, 242
Delay400:sbis pind, 1
		rjmp off
		ldi r22, 4
s1: sbis pind, 1
	rjmp off
	dec  r20
    brne s1
    dec  r19
    brne s1
    dec  r18
    brne s1
	ret
s2:	sbis pind, 1
	rjmp off
	dec r22
	call Delay100
	brne s2
	ret
s3:	dec  r19
    brne s3
    dec  r18
    brne s3
	ret