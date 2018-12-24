.org 0x000 jmp config
.org 0x002 jmp interrupcion_int0	/*Al generarse la interrupción de INT0 salta aquí*/
.org 0x004 jmp interrupcion_int1	/*Al generarse la interrupción de INT1 salta aquí*/

config:
		ldi R16,  0b11111111	/*Pone puros unos en R16*/
		OUT DDRB, R16			/*Establezco como salidas al puerto B 1-0 (salidas-entradas)*/
		OUT DDRC, R16			/*Establezco como salidas al puerto C 1-0 (salidas-entradas)*/
		ldi R16,  0b00000011
		out DDRD, R16
		LDI R16,  0b00001111	
		STS EICRA, R16			/* Los dos primeros bits menos significativos activan la interrupcion en ascendente a INT0 (0bxxxxxx11) y los dos bits siguientes activan la interupción en ascendente a INT1 (0bxxxx11xx)*/
		LDI R16 , 0b00000011	
		OUT EIMSK, R16			/*El bit menos significativo activa a la interrupción INT0 y el siguiente bit a INT1 1-0 (Habilitar-Deshabilita)*/
		SEI						/*Activa las interrupciones globalmente*/
		LDI R21,0b00000000
		LDI R22,0b00000000
		LDI R23,0b00000000
		OUT PORTB, R21
		OUT PORTC, R22
		OUT PORTD, R23

PROGRAMA:
		ldi  r18, 6
		ldi  r19, 19
		ldi  r20, 174

L1:		dec  r20
		
		brne L1
		dec  r19
		brne L1
		dec  r18
		brne L1
		rjmp PC+1
		LDI R16 , 0b00000000	
		OUT EIMSK, R16
		OUT PORTB, R21
		OUT PORTC, R22
		OUT PORTD, R23
		RCALL TIEMPO
		CLR R21
		CLR R22
		CLR R23

/*			RCALL TIEMPO
OUT PORTB, R21
OUT PORTC, R22
OUT PORTD, R23
INC R21
BRVS SALTA_1
JMP PROGRAMA
SALTA_1:
CLV
INC R22
LDI R24, 0b00111111
CPSE R22, R24
JMP PROGRAMA
CLR R22
INC R23
LDI R24, 0b00000100
CPSE R23, R24
JMP PROGRAMA
CLR R21
CLR R22
CLR R23*/
		JMP PROGRAMA

interrupcion_int0:
		CLR R21
		CLR R22
		CLR R23
		/*OUT PORTB, R21
		OUT PORTC, R22
		OUT PORTD, R23*/
		RETI

interrupcion_int1:
		INC R21
		BRVS SALTA
		RETI
		SALTA:
		CLV
		INC R22
		LDI R24, 0b00111111
		CPSE R22, R24
		RETI
		CLR R22
		INC R23
		LDI R24, 0b00000100
		CPSE R23, R24
		RETI
		CLR R21
		CLR R22
		CLR R23
		RETI

TIEMPO:
		ldi  r18, 11
		ldi  r19, 38
		ldi  r20, 94
		L2: dec  r20
		brne L2
		dec  r19
		brne L2
		dec  r18
		brne L2
		rjmp PC+1
		LDI R16 , 0b00000011	
		OUT EIMSK, R16
		ret