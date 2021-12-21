       ;ODEV-ALMA
	list		p=16f877A	
	#include	<p16f877A.inc>	
	
	__CONFIG H'3F31'
VERI	    EQU	0x20
TEMP	    EQU	0x21
TMP	    EQU	0x22
G1	    EQU	0x23
G2	    EQU	0x24
	    
W_TEMP	    EQU	0x7E
STATUS_TEMP EQU	0x7D
PCLATH_TEMP EQU	0x7F
;****************************************
    ORG	0x000
    NOP
    GOTO    BASLA
;***************************************
    ORG	0x004
    RETFIE
;************************************
USART_AYAR
    BANKSEL TRISC
    MOVLW   B'10000000'
    MOVWF   TRISC
    CLRF    TRISB
    
    MOVLW   0x19
    MOVWF   SPBRG
    
    BANKSEL TXSTA
    MOVLW   0x26
    MOVWF   TXSTA
    
    BANKSEL RCSTA
    MOVLW   0x90
    MOVWF   RCSTA
    
    RETURN
;*********************************
GECIKME_200USN
    MOVLW   0xC8
    MOVWF   G1
LOOP
    DECFSZ  G1,1
    GOTO    LOOP
    RETURN
;**********************************
KESME_AYAR
    BANKSEL PIE1
    BSF	    PIE1,RCIE
    BCF	    PIE1,TXIE
    
    BANKSEL INTCON
    BSF	    INTCON,GIE
    BSF	    INTCON,PEIE
    RETURN
;****************************************
LCD_AYAR
    BANKSEL TRISB
    CLRF    TRISB
    BANKSEL PORTB
    CLRF    PORTB
    
    CALL    TETIK
    CALL    GECIKME_200USN
    CALL    TETIK
    CALL    GECIKME_200USN
    BCF	    PORTB,4
    
    MOVLW   0x02
    CALL    GONDER
    MOVLW   0x28
    CALL    GONDER
    MOVLW   0x0D
    CALL    GONDER
    MOVLW   0x10
    CALL    GONDER
    MOVLW   0x01
    CALL    GONDER
    MOVLW   0x06
    CALL    GONDER
    RETURN
 ;********************************
TETIK
    BANKSEL PORTB
    BSF	    PORTB,5
    CALL    GECIKME_200USN
    BCF	    PORTB,5
    RETURN
 ;*********************************
GONDER
    MOVWF   VERI
    SWAPF   VERI,0
    ANDLW   0x0F
    MOVWF   TEMP
    MOVF    PORTB,W
    ANDLW   0xF0
    IORWF   TEMP,0
    MOVWF   PORTB
    CALL    TETIK
    
    MOVF    VERI,W
    ANDLW   0x0F
    MOVWF   TEMP
    MOVF    PORTB,W
    ANDLW   0xF0
    IORWF   TEMP,0
    MOVWF   PORTB
    CALL    TETIK
    RETURN
;**********************************
BASLA
    CALL    USART_AYAR
    CALL    LCD_AYAR
    BSF	    PORTB,4   
EE
    GOTO    EE    
    END


