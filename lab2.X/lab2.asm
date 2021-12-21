	list		p=16f877A	
	#include	<p16f877A.inc>	
	
	__CONFIG    H'3F31'

;KULLANILACAK DEGISKENLER
G1	EQU 0x20
G2	EQU 0x21


;***** Kesme durumunda kaydedilmesi gereken SFR ler icin kullanilacak yardimci degiskenler
				
w_temp		EQU	0x7D		
status_temp	EQU	0x7E		
pclath_temp	EQU	0x7F
;********************************************************************************************
	ORG     0x00             	 

	NOP			  	
  	GOTO    BASLA              	 

	
;**********************************************************************************************
	ORG     0x04             	

;***********************************************************************************************
LOOK_UP
	ADDWF	    PCL,1
	RETLW	    0x3F
	RETLW	    0x06
	RETLW	    0x5B
	RETLW	    0x4F
	RETLW	    0x66
	RETLW	    0x6D
	RETLW	    0x7D
	RETLW	    0x07
	RETLW	    0x7F
	RETLW	    0x6F
;***********************************************************************************************
GECIKME
	MOVLW	    0x0D
	MOVWF	    G1
	
	MOVLW	    0xFF
	MOVWF	    G2
LOOP
	DECFSZ	    G2,1
	GOTO	    LOOP
	
	DECFSZ	    G1,1
	GOTO	    LOOP
	RETURN
	
BASLA
	BANKSEL	    ADCON1
	MOVLW	    0x06
	MOVWF	    ADCON1
	  
	BANKSEL	    TRISA
	MOVLW	    B'00011011'
	MOVWF	    TRISA   
	
	BANKSEL	    PORTA
	CLRF	    PORTA
	
	BANKSEL	    TRISB
	CLRF	    TRISB
	
	BANKSEL	    PORTB
	CLRF	    PORTB
	
	BTFSS	    PORTA,3	;ARTIRMA
	GOTO	    ART_BUTTON
	
	GOTO	    ART
	
	
	
	
	BTFSS	    PORTA,4	;AZALTMA
	GOTO	    AZAL
	END




