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
KATOT_LOOKUP
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
	MOVLW	    0x0D    ;50 M?L?SAN?YE
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
	CLRF	    PORTA
	
	BANKSEL	    ADCON1
	MOVLW	    0x06
	MOVWF	    ADCON1
	MOVLW	    b'00111100'   
	MOVWF	    TRISA
	
	BANKSEL	    TRISB
	CLRF	    TRISB
	BANKSEL	    PORTB
	CLRF	    PORTB
	
DON
	MOVLW	    0x01
	MOVWF	    PORTA
	MOVLW	    D'3'
	CALL	    KATOT_LOOKUP
	MOVWF	    PORTB
	CALL	    GECIKME
	
	MOVLW	    0x02
	MOVWF	    PORTA
	MOVLW	    D'2'
	CALL	    KATOT_LOOKUP
	MOVWF	    PORTB
	CALL	    GECIKME
	GOTO	    DON
	END


