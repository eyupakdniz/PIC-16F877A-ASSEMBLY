	list		p=16f877A	
	#include	<p16f877A.inc>	
	
	__CONFIG    H'3F31'

;KULLANILACAK DEGISKENLER

G1	EQU 0x20
G2	EQU 0x21
G3	EQU 0X22
S1	EQU 0x23

;***** Kesme durumunda kaydedilmesi gereken SFR ler icin kullanilacak yardimci degiskenler
				
w_temp		EQU	0x7D		
status_temp	EQU	0x7E		
pclath_temp	EQU	0x7F
;********************************************************************************************
	ORG     0x00             	 

	nop			  	
  	goto    BASLA              	 

	
;**********************************************************************************************
	ORG     0x04             	

	
;***********************************************************************************************
GECIKME	    
	MOVLW	    0x03
	MOVWF	    G1
	
	MOVLW	    0xFF
	MOVWF	    G2
	
	MOVLW	    0xFF
	MOVWF	    G3
LOOP
	DECFSZ	    G3,1
	GOTO	    LOOP
	
	DECFSZ	    G2,1
	GOTO	    LOOP
	
	DECFSZ	    G1,1
	GOTO	    LOOP
	
	RETURN
	
ISLEM	
	MOVF	    S1,W
	MOVWF	    PORTB
	CALL	    GECIKME
	MOVLW	    0x02
	SUBWF	    S1,1
	GOTO	    ISLEM
	
	
BASLA
	BANKSEL	    ADCON1
	MOVLW	    0X06
	MOVWF	    ADCON1
	
	BANKSEL	    PORTA
	MOVLW	    0X01
	MOVWF	    PORTA
	
	BANKSEL	    TRISB
	CLRF	    TRISB
	BANKSEL	    PORTB
	CLRF	    PORTB
	
	MOVLW	    0xFF
	MOVWF	    S1
DONGU
	BTFSS	    PORTA,0
	GOTO	    DONGU
	GOTO	    ISLEM
	
	

	
	
	END


