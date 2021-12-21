	list		p=16f877A	
	#include	<p16f877A.inc>	
	
	__CONFIG    H'3F31'

;KULLANILACAK DEGISKENLER
S1	EQU 0X20
SAYAC	EQU 0X21
G1	EQU 0X22
G2	EQU 0X23


;***** Kesme durumunda kaydedilmesi gereken SFR ler icin kullanilacak yardimci degiskenler
				
w_temp		EQU	0x7D		
status_temp	EQU	0x7E		
pclath_temp	EQU	0x7F
;********************************************************************************************
	ORG     0x000             	 

	nop			  	
  	goto    BASLA              	 

	
;**********************************************************************************************
	ORG     0x004             	

	
;***********************************************************************************************
GECIKME
	MOVLW	    0XFF
	MOVWF	    G1
LOOP	
	MOVLW	    0XFF
	MOVWF	    G2
LOOP1
	DECFSZ	    G2,F
	GOTO	    LOOP1
	
	DECFSZ	    G1,F
	GOTO	    LOOP
	
	RETURN
	
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
	
	MOVLW	    0XFF
	MOVWF	    S1

DONGU	
	BTFSS	    PORTA,0
	GOTO	    DONGU
	GOTO	    SAY
	
SAY
	DECF	    S1,F
	MOVF	    S1,W
	MOVWF	    PORTB
	CALL	    GECIKME
	GOTO	    SAY
	END



