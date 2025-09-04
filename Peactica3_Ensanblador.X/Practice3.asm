#include <xc.inc>

    
   ;OSCILLATOR SOURCE AND DIGITAL I/O CONFIGURATION BITS
   ;====================================================
   CONFIG       FOSC = INTOSCIO_EC  ; Internal oscillator, RA6/RA7 as I/O
   CONFIG	MCLRE = ON          ; CONFIG3H.7 = 1: Pin de RESET habilitado y Entrada RE3 desactivado.
   CONFIG	PBADEN = OFF        ; CONFIG3H.1 = 0: PORTB.0 -- PORTB.4 as Digital I/O.
   CONFIG	LVP = OFF           ; CONFIG3H.2 = 0: Single-Supply ICSP disabled  so that PORTB.5 works as Digital I/O.

   org 0x0000
   
   main:                           ; Label must end with colon
    movlw   0b01100000          ; 4 MHz internal oscillator
    movwf   OSCCON              ; Oscillator configuration

    ; Disable analog features
    setf    CMCON               ; Comparators OFF
    movlw   0x0F
    movwf   ADCON1              ; All ports digital

    ; Configure PORTA
    clrf    PORTA
    clrf    LATA
    setf    TRISA               ; PORTA as input

    ; Configure PORTB
    clrf    PORTB
    clrf    LATB
    clrf    TRISB               ; PORTB as output

loop:                           ; Infinite loop
    movff   PORTA, PORTB        ; Mirror PORTA to PORTB
    bra     loop

    end
