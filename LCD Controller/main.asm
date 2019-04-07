;
; LCD Controller.asm
;
; Created: 4/6/2019 8:35:43 PM
; Author : atomi
;


; Port A LCD, Port B Switches, Port C LEDs


;Initializing micro controller
ldi r16, low(RAMEND)
ldi r17, high(RAMEND)
out spl, r16
out sph, r17
ldi r16, 0xFF
out DDRC, r16
out DDRA, r16

;Initializing LCD
ldi r16, 0B11011101
out PortA, r16
ldi r16, 0B11111101
out PortA, r16
ldi r16, 0B11010000
out PortA, r16
ldi r16, 0B11110000
out PortA, r16

KeyPoll:
	in r17, PINB
	cpi r17, 0xFF
	breq KeyPoll
	rcall KeyPressed
	rjmp KeyPoll

KeyPressed:
	in r20, PortC ;Loading LED states
	cpi r17, 0x7F ;|Jump to data send if switch 7 is pressed
	breq DataSend ;|
	com r20 ;|
	com r17 ;|Inverting due to active low
	eor r20, r17
	com r20
	out PortC, r20
	rcall Delay ;Delay so key press is properly registered
 ret

 DataSend:
 	ldi r21, 0B00100000 
	mov r0, r20
	lsr r20 ;\
	lsr r20 ; | Moves MSB to lower nibble
	lsr r20 ; |
	lsr r20 ;/

	eor r20, r21   ;\
	out PortA, r20 ; | Sends nibble to LCD
	eor r20, r21   ; |
	out PortA, r20 ;/

	mov r20, r0				;| Isolates LSB
	andi r20, 0B00001111	;|
	sbr r20, 0B00100000

	eor r20, r21
	out PortA, r20
	eor r20, r21
	out PortA, r20
	rcall Delay
 ret

Delay:
    ldi  r18, 20
    ldi  r19, 150
    ldi  r20, 128
L1: dec  r20
    brne L1
    dec  r19
    brne L1
    dec  r18
    brne L1
 ret