.org 0x000 rjmp config
config:	ldi R20, 0b01111111
		out ddrb, R20
		out ddrd, R20
		ldi r21, 0b00000000
		ldi r23, 0b00111111
		ldi r24, 0b00000110
		ldi r25, 0b00100000
		ldi r26, 0b00000000
		out portd, r25
		out portb, r23
loop:	call disp0
		call disp1
		sbic pinb,7
		rjmp config
		sbic pind,7
		jmp parar
		out portd, r25
		out portb, r23
		inc r21
		call delay400
		rjmp loop
parar:	sbis pind,7
		rjmp loop
		rjmp parar
delay400:ldi  r18, 3 
		ldi  r19, 60
		ldi  r20, 204
s1:		dec  r20
		brne s1
		dec  r19
		brne s1
		dec  r18
		brne s1
		ret
disp0:
dis0:	ldi r22, 0b00000000
		cp r21, r22
		brne dis1
		ldi r23, 0b00111111
		ret
dis1:	ldi r22, 0b00000001
		cp r21, r22
		brne dis2
		ldi r23, 0b00000110
		ret
dis2:	ldi r22, 0b00000010
		cp r21, r22
		brne dis3
		ldi  r23, 0b01011011
		ret
dis3:	ldi r22, 0b00000011
		cp r21, r22
		brne dis4
		ldi  r23, 0b01001111
		ret
dis4:	ldi r22, 0b00000100
		cp r21, r22
		brne dis5
		ldi  r23, 0b01100110
		ret
dis5:	ldi r22, 0b00000101
		cp r21, r22
		brne dis6
		ldi  r23, 0b01101101
		ret
dis6:	ldi r22, 0b00000110
		cp r21, r22
		brne dis7
		ldi  r23, 0b01111101
		ret
dis7:	ldi r22, 0b00000111
		cp r21, r22
		brne dis8
		ldi  r23, 0b00000111
		ret
dis8:	ldi r22, 0b00001000
		cp r21, r22
		brne dis9
		ldi  r23, 0b01111111
		ret
dis9:	ldi r22, 0b00001001
		cp r21, r22
		brne reset
		ldi  r23, 0b01100111
		ret
disp1:
dis10:	ldi r22, 0b00000000
		cp r26, r22
		brne dis11
		ldi r25, 0b00100000
		ret
dis11:	ldi r22, 0b00000001
		cp r26, r22
		brne dis12
		ldi r25, 0b01111001
		ret
dis12:	ldi r22, 0b00000010
		cp r26, r22
		brne dis13
		ldi r25, 0b01000100
		ret
dis13:	ldi r22, 0b00000011
		cp r26, r22
		brne dis14
		ldi r25, 0b01010000
		ret
dis14:ldi r22, 0b00000100
		cp r26, r22
		brne dis15
		ldi r25, 0b00011001
		ret
dis15:ldi r22, 0b00000101
		cp r26, r22
		brne reset
		ldi r25, 0b00010010
		ret
reset:	ldi r23, 0b01100111
		ldi r21, 0b00000000
		inc r26
		cpse r26, r24
		rjmp loop
		rjmp config

