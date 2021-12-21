	list		p=16f877A	
	#include	<p16f877A.inc>	
	
	__CONFIG    H'3F31'

;KULLANILACAK DEGISKENLER
G1	EQU 0x20
G2	EQU 0x21
G3	EQU 0x22
SAYI1	EQU 0x23
SAYI2	EQU 0x23

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
	movwf   w_temp            	; W nın yedegini al
	movf	STATUS,w          	; Status un yedegini almak icin onu once W ya al
	movwf	status_temp       	; Status u yedek register 'ına al
	movf	PCLATH,w	  		; PCLATH 'ı yedeklemek icin onu once W 'ya al
	movwf	pclath_temp	  		; PCLATH 'ı yedek register a al

	; gerekli kodlar

	movf	pclath_temp,w	  	; Geri donmeden once tum yedekleri geri yukle
	movwf	PCLATH		  		
	movf    status_temp,w     	
	movwf	STATUS            	
	swapf   w_temp,f
	swapf   w_temp,w          	
	retfie                    	; Kesme 'den don

	
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
	RETLW	    0xF7
	RETLW	    0xFF
	RETLW	    0xB9
	RETLW	    0xBF
	RETLW	    0xF9
	RETLW	    0xF1
	
;***********************************************************************************************
GECIKME	
	MOVLW	    0x02
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

BASLA
	CLRF	    PORTA
	BANKSEL	    ADCON1
	MOVLW	    0x06
	MOVWF	    ADCON1
	
	BANKSEL	    TRISA 
	MOVLW	    b'00111110'
	MOVWF	    TRISA
	
	BANKSEL	    TRISB
	CLRF	    TRISB
	BANKSEL	    PORTB
	CLRF	    PORTB
	
	MOVLW	    D'16'
	MOVWF	    SAYI1

DONGU		;9Dan geri sayan kod
	MOVLW	    B'00000000'
	MOVWF	    PORTA
	DECF	    SAYI1,1
	MOVF	    SAYI1,W
	CALL	    LOOK_UP
	MOVWF	    PORTB
	CALL	    GECIKME
	GOTO	    DONGU
	END




