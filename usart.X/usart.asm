    ;dolayl? adresleme ile karsiya veri gonderme
	list		p=16f877A	
	#include	<p16f877A.inc>	
	
	__CONFIG H'3F31'
VERI	EQU 0x20
TEMP	EQU 0x21
G1	EQU 0x22
KACKEZ	EQU 0x23	

W_TEMP	    EQU	0x7D
STATUS_TEMP EQU	0x7E
PCLATH_TEMP EQU	0x7F
;********************
    ORG	0x000
    NOP
    GOTO    BAS
 ;****************************
    ORG	0x004
    MOVWF   W_TEMP  
    MOVF    STATUS,W
    MOVWF   STATUS_TEMP	
    MOVF    PCLATH,W
    MOVWF   PCLATH_TEMP
    
    BCF	    INTCON,T0IF
    DECFSZ  KACKEZ,1
    GOTO    CIK
    MOVLW   0x50
    MOVWF   KACKEZ
    
    BANKSEL PIR1
    BTFSS   PIR1,RCIF
    GOTO    CIK
    BCF	    PIR1,RCIF
    MOVF    RCREG,W
    CALL    LCD_GONDER   
    
    
CIK
    MOVF    PCLATH_TEMP,W
    MOVWF   PCLATH
    MOVF    STATUS_TEMP,W
    MOVWF   STATUS
    SWAPF   W_TEMP,1
    SWAPF   W_TEMP,0
    RETFIE
;*********************************,
GECIKME_200USN
    MOVLW   0xC8
    MOVWF   G1
LOOP
    DECFSZ  G1,1
    GOTO    LOOP
    RETURN
;****************************
USART_AYAR
    BANKSEL TRISC
    MOVLW   B'10000000'
    MOVWF   TRISC
    CLRF    TRISB
   
    MOVLW   0x19
    MOVWF   SPBRG
    
    MOVLW   0x26
    MOVWF   TXSTA
    
    BANKSEL RCSTA
    MOVLW   0x90
    MOVWF   RCSTA
    RETURN
;*****************************
KESME_AYAR
    BANKSEL PIE1
    BCF	    PIE1,TXIE
    BSF	    PIE1,RCIE
    
    BANKSEL INTCON
    BSF	    INTCON,PEIE
    BSF	    INTCON,GIE
    BSF	    INTCON,T0IE
    
    BANKSEL OPTION_REG
    MOVLW   B'00000011'
    MOVWF   OPTION_REG
    RETURN
 ;******************************
LCD_AYAR
    BANKSEL PORTB
    CLRF    PORTB
    
    CALL    TETIK
    CALL    GECIKME_200USN
    CALL    TETIK
    CALL    GECIKME_200USN
    
    BCF	    PORTB,4
    MOVLW   0x02
    CALL    LCD_GONDER
    MOVLW   0x28
    CALL    LCD_GONDER
    MOVLW   0x0D
    CALL    LCD_GONDER
    MOVLW   0x10
    CALL    LCD_GONDER
    MOVLW   0x01
    CALL    LCD_GONDER
    MOVLW   0x06
    CALL    LCD_GONDER
    RETURN
;*****************************
TETIK
    BANKSEL PORTB
    BSF	    PORTB,5
    CALL    GECIKME_200USN
    BCF	    PORTB,5
    RETURN
;*************************
LCD_GONDER
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
;*****************************
BAS
    MOVLW   0x50
    MOVWF   KACKEZ
    CALL    USART_AYAR
    CALL    KESME_AYAR
    CALL    LCD_AYAR
    BSF	    PORTB,4

DD 
    GOTO    DD
    END