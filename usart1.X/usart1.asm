	list		p=16f877A	
	#include	<p16f877A.inc>	
	
	__CONFIG H'3F31'
G1	    EQU	0x20
TEMP	    EQU	0x22
VERI	    EQU	0x23
	
W_TEMP	    EQU	0x7D
STATUS_TEMP EQU	0x7E
PCLATH_TEMP EQU	0x7F
;*************************************
    ORG	0x000
    NOP	
    GOTO    BAS
;***************************************
    ORG	0x004
    MOVWF   W_TEMP
    MOVF    STATUS,W
    MOVWF   STATUS_TEMP
    MOVF    PCLATH,W
    MOVWF   PCLATH_TEMP

    BANKSEL PIR1
    BCF	    PIR1,RCIF
    MOVF    RCREG,W
    BANKSEL PORTB
    BSF	    PORTB,4
    CALL    LCD_GONDER
    
CIK
    MOVF    PCLATH_TEMP,W
    MOVWF   PCLATH
    MOVF    STATUS_TEMP,W
    MOVWF   STATUS
    SWAPF   W_TEMP,1
    SWAPF   W_TEMP,0
    RETFIE
 ;******************************************
GECIKME_200USN
    MOVLW   0xC8
    MOVWF   G1
LOOP	
    DECFSZ  G1,1
    GOTO    LOOP
    RETURN
;************************************
USART_AYAR
    BANKSEL TRISC
    MOVLW   B'10000000'
    MOVWF   TRISC
    
    MOVLW   0x19
    MOVWF   SPBRG
    
    BANKSEL TXSTA
    MOVLW   0x26
    MOVWF   TXSTA
    
    BANKSEL RCSTA
    MOVLW   0x90
    MOVWF   RCSTA
    RETURN
;************************************
 KESME_AYAR
    BANKSEL PIE1
    BCF	    PIE1,TXIE
    BSF	    PIE1,RCIE
    
    BANKSEL INTCON
    BSF	    INTCON,GIE
    BSF	    INTCON,PEIE
    RETURN
;*************************************** 
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
    CALL    LCD_GONDER
    MOVLW   0x28
    CALL    LCD_GONDER
    MOVLW   0x10
    CALL    LCD_GONDER
    MOVLW   0x0D
    CALL    LCD_GONDER
    MOVLW   0x01
    CALL    LCD_GONDER
    MOVLW   0x06
    RETURN
;*******************************************
TETIK
    BANKSEL PORTB
    BSF	    PORTB,5
    CALL    GECIKME_200USN
    BCF	    PORTB,5
    RETURN
;****************************
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
;****************************
SS
    BANKSEL PIR1
    BTFSS   PIR1,TXIF
    GOTO    SS
    RETURN
;*************************
BAS
    CALL    USART_AYAR
    CALL    KESME_AYAR
    CALL    LCD_AYAR
    
    BANKSEL TXREG
    MOVLW   0x31
    MOVWF   TXREG
    CALL    SS 
    
   BANKSEL TXREG
    MOVLW   0x32
    MOVWF   TXREG
    CALL    SS
    
    BANKSEL TXREG
    MOVLW   0x33
    MOVWF   TXREG
    CALL    SS
    
    BANKSEL TXREG
    MOVLW   0x34
    MOVWF   TXREG
    CALL    SS
DD
    GOTO    DD
    END
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG H'3F31'
;KAC	    EQU	0x20
;VERI	    EQU	0x21
;TEMP	    EQU	0x22
;TMP	    EQU	0x23
;G1	    EQU	0x24
;	
;W_TEMP	    EQU	0x7D
;STATUS_TEMP EQU	0x7E
;PCLATH_TEMP EQU	0x7F
;;**********************************
;    ORG	0x000
;    NOP	
;    GOTO    BAS
;;********************************
;    ORG	0x004
;    MOVWF   W_TEMP
;    MOVF    STATUS,W
;    MOVWF   STATUS_TEMP
;    MOVF    PCLATH,W
;    MOVWF   PCLATH_TEMP
;    
;    
;    
;    BANKSEL PIR1
;   
;   
;    BCF	    PIR1,RCIF
;    MOVF    RCREG,W
;    BANKSEL PORTB
;    BSF	    PORTB,4
;    CALL    LCD_GONDER
;    
;CIK
;    MOVF    PCLATH_TEMP,W
;    MOVWF   PCLATH
;    MOVF    STATUS_TEMP,W
;    MOVWF   STATUS
;    SWAPF   W_TEMP,1
;    SWAPF   W_TEMP,0
;    RETFIE
;;******************************
;GECIKME_200USN
;    MOVLW   0xC8
;    MOVWF   G1
;LOOP
;    DECFSZ  G1,1
;    GOTO    LOOP
;    RETURN
;;*******************************
;USART_AYAR
;    BANKSEL TRISC
;    MOVLW   B'10000000'
;    MOVWF   TRISC
;    CLRF    TRISB
;    
;    MOVLW   0x19
;    MOVWF   SPBRG
;    
;    BANKSEL TXSTA
;    MOVLW   0x26
;    MOVWF   TXSTA
;    
;    BANKSEL RCSTA
;    MOVLW   0x90
;    MOVWF   RCSTA
;    RETURN
;;******************************
;KESME_AYAR
;    BANKSEL PIE1
;    BCF	    PIE1,TXIE
;    BSF	    PIE1,RCIE
;    
;    BANKSEL INTCON
;    BSF	    INTCON,GIE
;    BSF	    INTCON,PEIE
;    BSF	    INTCON,T0IE
;    
;    BANKSEL OPTION_REG
;    MOVLW   B'00000011'
;    MOVWF   OPTION_REG
;    RETURN
;;*******************************
;LCD_AYAR
;    BANKSEL PORTB
;    CLRF    PORTB
;    
;    CALL    TETIK
;    CALL    GECIKME_200USN
;    CALL    TETIK
;    CALL    GECIKME_200USN
;    
;    BCF	    PORTB,4
;    MOVLW   0x02
;    CALL    LCD_GONDER
;    MOVLW   0x28
;    CALL    LCD_GONDER
;    MOVLW   0x0D
;    CALL    LCD_GONDER
;    MOVLW   0x10
;    CALL    LCD_GONDER
;    MOVLW   0x01
;    CALL    LCD_GONDER
;    MOVLW   0x06
;    CALL    LCD_GONDER
;    RETURN
;;******************************
;TETIK
;    BANKSEL PORTB
;    BSF	    PORTB,5
;    CALL    GECIKME_200USN
;    BCF	    PORTB,5
;    RETURN
; ;*************************
;LCD_GONDER
;    MOVWF   VERI
;    
;    SWAPF   VERI,0
;    ANDLW   0x0F
;    MOVWF   TEMP
;    MOVF    PORTB,W
;    ANDLW   0xF0
;    IORWF   TEMP,0
;    MOVWF   PORTB
;    CALL    TETIK
;    
;    MOVF    VERI,W
;    ANDLW   0x0F
;    MOVWF   TEMP
;    MOVF    PORTB,W
;    ANDLW   0xF0
;    IORWF   TEMP,0
;    MOVWF   PORTB
;    CALL    TETIK
;    RETURN
;   
;  SSS 
;    BANKSEL PIR1
;    LOOP1
;    BTFSS PIR1,TXIF
;    GOTO LOOP1
;    RETURN
;;********************************
;BAS
;    MOVLW   0x19
;    MOVWF   KAC
;    CALL    USART_AYAR
;    CALL    KESME_AYAR
;    CALL    LCD_AYAR
;    CALL SSS
;    BANKSEL TXREG
;    MOVLW .65
;    MOVWF TXREG
;    
;DD
;    GOTO    DD
;    END