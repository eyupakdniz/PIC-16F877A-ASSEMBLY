	list		p=16f877A	
	#include	<p16f877A.inc>	
	
	__CONFIG    H'3F31'

;KULLANILACAK DEGISKENLER
G1	EQU 0X20
G2	EQU 0X21
G3	EQU 0X22
S1	EQU 0X23

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
	  MOVLW		0x02
	  ADDWF		PORTB,1
	  RETURN	
BASLA
	    BANKSEL	TRISB
	    CLRF	TRISB
	    BANKSEL	PORTB
	    CLRF	PORTB
	    BSF		PORTB,0
	   

	  	  
DONGU
	    CALL	GECIKME
	    CALL	ISLEM
	    GOTO	DONGU
	
	END


