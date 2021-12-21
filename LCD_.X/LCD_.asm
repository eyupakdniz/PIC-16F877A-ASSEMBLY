	list		p=16f877A	
	#include	<p16f877A.inc>	
	
	__CONFIG H'3F31'
	
G1	EQU 0x20
G2	EQU 0x21
VERI	EQU 0x22
TEMP	EQU 0x24
	
;***************************************************
	    ORG	0x000
	    NOP
	    GOTO    BASLA
;********************************************************
	    ORG	0x004
	    RETFIE
;****************************************************
GECIKME_20USN
	    MOVLW   0xC8
	    MOVWF   G1
LOOP1
	    DECFSZ  G1,1
	    GOTO    LOOP1
	    RETURN
;*****************************************************
GECIKME_5MSN
	    MOVLW   0xE7
	    MOVWF   G1
	    
	    MOVLW   0x04
	    MOVWF   G2
LOOP2
	    DECFSZ  G1,1
	    GOTO    LOOP2
	    
	    DECFSZ  G2,1
	    GOTO    LOOP2
	    RETURN
;******************************************************************
GECIKME_50MSN
	    MOVLW   0x0F
	    MOVWF   G1
	    
	    MOVLW   0x28
	    MOVWF   G2
LOOP3
	    DECFSZ  G1,1
	    GOTO    LOOP3
	    
	    DECFSZ  G2,1
	    GOTO    LOOP3
	    RETURN
;***************************************************************************
TETIK
	    BANKSEL PORTB
	    BSF	    PORTB,5
	    CALL    GECIKME_20USN
	    BCF	    PORTB,5
	    
	    RETURN
;********************************************************
GONDER
	    MOVWF   VERI
	    SWAPF   VERI,W
	    
	    ANDLW   0x0F
	    MOVWF   TEMP
	    
	    MOVF    PORTB,W
	    ANDLW   0xF0
	    
	    IORWF   TEMP,W
	    MOVWF   PORTB
	    CALL    TETIK
	    
	    MOVF    VERI,W
	    
	    ANDLW   0x0F
	    MOVWF   TEMP
	    
	    MOVF    PORTB,W
	    ANDLW   0xF0
	    
	    IORWF   TEMP,W
	    MOVWF   PORTB
	    CALL    TETIK
	    RETURN
;*********************************************
LCD_AYAR
	    BANKSEL TRISB
	    CLRF    TRISB
	    BANKSEL PORTB
	    CLRF    PORTB
	    
	    BCF	    PORTB,4
	    CALL    TETIK
	    CALL    GECIKME_20USN
	    
	    CALL    TETIK
	    CALL    GECIKME_20USN
	    
	    MOVLW   0x02
	    CALL    GONDER
	    
	    MOVLW   0x28
	    CALL    GONDER
	    
	    MOVLW   0x10
	    CALL    GONDER
	    
	    MOVLW   0x0D
	    CALL    GONDER
	    
	    MOVLW   0x01
	    CALL    GONDER
	    
	    MOVLW   0x06
	    CALL    GONDER
	    RETURN
;********************************************************
BASLA
	    CALL    LCD_AYAR
	    
	    BSF	    PORTB,4
	    MOVLW   0x41
	    CALL    GONDER
DON
	    GOTO    DON
	    END
	    
