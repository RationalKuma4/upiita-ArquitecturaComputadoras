.INCLUDE "m328Pdef.inc"
.org 0x000 jmp config
.org 0x002 jmp int10
.org 0x004 jmp int20
config:
	LDI		R16,LOW(RAMEND)
	OUT		SPL,R16
	LDI		R16,HIGH(RAMEND)
	OUT		SPH,R16
	//SALIDAS
	SER     r16
	out     ddrb,r16
	SER     r16
	out     ddrC,r16
	//ENTRADAS
	ldi		R16,0xf0		
	OUT		DDRD,R16
	//////////////////////////////////////
	LDI		R16,0X0B
	sts		EICRA,R16
	LDI		R16,0X03
	OUT		EIMSK,R16
	//////////////////////////////////////
	ldi r21,0xf9 //1
	ldi r22,0x24 //2
	ldi r23,0x30 //3
	ldi r24,0x19 //4
	ldi r25,0x12 //5
	ldi r26,0x02 //6
	//////////////////////////////////////
	LDI		R20,0X06
	LDI		R27,0XF9
	LDI		R28,0X00
	LDI		R29,0X00
	SEI
INICIO:
	CALL	TIEMPO
	SBRC	R29,0
	JMP		INICIO
	CPSE	R27,R21
	JMP		DISPLAY12
	OUT		PORTB,R21
	MOV		R27,R22
	JMP		INICIO
DISPLAY12:
	CPSE	R27,R22
	JMP		DISPLAY13
	OUT		PORTB,R22
	MOV		R27,R23
	JMP		INICIO
DISPLAY13:
	CPSE	R27,R23
	JMP		DISPLAY14
	OUT		PORTB,R23
	MOV		R27,R24
	JMP		INICIO
DISPLAY14:
	CPSE	R27,R24
	JMP		DISPLAY15
	OUT		PORTB,R24
	MOV		R27,R25
	JMP		INICIO
DISPLAY15:
	CPSE	R27,R25
	JMP		DISPLAY16
	OUT		PORTB,R25
	MOV		R27,R26
	JMP		INICIO
DISPLAY16:
	OUT		PORTB,R26
	MOV		R27,R21
	INC		R28
	OUT		PORTC,R28
	CPSE	R28,R20
	JMP		INICIO
	LDI		R28,0X00
	JMP		INICIO
int20:
	LDI		R29,0X01
	reti
INT10:
	LDI		R29,0X00
	RETI
tiempo:	//aprox 10.26 ms
			ldi r17,15
	salto2:	ldi r18,200
	salto1: dec r18
			brne salto1
			dec r17
			brne salto2
			ret