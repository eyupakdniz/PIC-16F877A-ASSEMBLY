	list		p=16f877A	
	#include	<p16f877A.inc>	
	
	__CONFIG    H'3F31'

;KULLANILACAK DEGISKENLER
S1	EQU 0X20
S2	EQU 0X21
G1	EQU 0X22
G2	EQU 0X23
G3	EQU 0X24
US	EQU 0X25
	
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
	MOVLW	    0XFF
	MOVWF	    G1
LOOP	
	MOVLW	    0XFF
	MOVWF	    G2
LOOP1	
	MOVLW	    0XFF
	MOVWF	    G3
LOOP2
	DECFSZ	    G3,F
	GOTO	    LOOP2
	
	DECFSZ	    G2,F
	GOTO	    LOOP1
	
	DECFSZ	    G1,F
	GOTO	    LOOP
	
	RETURN
	
BASLA
	BANKSEL	    TRISA
	MOVLW	    0X06
	MOVWF	    ADCON1
	
	BANKSEL	    PORTA
	MOVLW	    b'00000010'
	MOVWF	    PORTA
	
	BANKSEL	    TRISB
	MOVLW	    0X00
	MOVWF	    TRISB
	
	BANKSEL	    PORTB
	CLRF	    PORTB
	
BUTTON
	BTFSS	    PORTA,1
	GOTO	    BUTTON
	CALL	    USLU
		
USLU
	MOVLW	    0X03
	MOVWF	    S1
	MOVLW	    0X03
	MOVWF	    S2
	MOVLW	    0X00
	MOVWF	    US

ISLEM
	MOVF	    US,W
	ADDWF	    S1,W
	MOVWF	    US
		
DONGU1
	DECFSZ	    S2,F
	CALL	    ISLEM
	MOVF	    US,W
	MOVWF	    PORTB
	CALL	    GECIKME
	GOTO	    BUTTON

	
	END
