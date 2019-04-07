# AVR LCD Controller

Designed with an STK600, the LCD controller uses 
the push buttons to toggle bits for controlling a character LCD.

The LCD should be connected to Port A with the corresponding bits:

PA0 = DB4
PA1 = DB5
PA2 = DB6
PA3 = DB7
PA4 = RS
PA5 = E
Ground = RW

Switches 0 - 6 are the bits to be output to the LCD
and are indicated by their corresponding LEDs.
Switch 7 signals to the program to output to the LCD.