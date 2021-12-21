list		p=16f877A	
	#include	<p16f877A.inc>	
	
	__CONFIG    H'3F31'

;KULLANILACAK DEGISKENLER
G1	EQU 0x20
G2	EQU 0x21
G3	EQU 0x22
BIRLER	EQU 0x23
ONLAR	EQU 0x25
SAYAC	EQU 0x24
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
;***********************************************************************************************
GECIKME	
;	MOVLW	    0x02
;	MOVWF	    G1
	
	MOVLW	    0x70
	MOVWF	    G2
	
	MOVLW	    0xFF
	MOVWF	    G3
LOOP
	DECFSZ	    G3,1
	GOTO	    LOOP
	
	DECFSZ	    G2,1
	GOTO	    LOOP
	
;	DECFSZ	    G1,1
;	GOTO	    LOOP
	RETURN

BASLA
	
	BANKSEL	    ADCON1
	MOVLW	    0x06
	MOVWF	    ADCON1
	
	BANKSEL	    TRISA  
	MOVLW	    b'00111100'
	MOVWF	    TRISA
	
	BANKSEL	    PORTA
	CLRF	    PORTA
	
	BANKSEL	    TRISB
	CLRF	    TRISB
	BANKSEL	    PORTB
	CLRF	    PORTB
	
	MOVLW	    0X00
	MOVFW	    ONLAR
	MOVLW	    0X00
	MOVFW	    BIRLER
		
DONGU
	MOVLW	    D'10'
	MOVWF	    SAYAC
	BCF	    STATUS,Z
	
	MOVF	    SAYAC,W
	SUBWF	    BIRLER,W
	BTFSS	    STATUS,Z	    ;Z 0 OLMALI CALISMASI ?�?N
	GOTO	    ISLEM
	GOTO	    TEMIZ
	
ISLEM
	MOVLW	    b'00000010'
	MOVWF	    PORTA
	MOVF	    BIRLER,W
	CALL	    LOOK_UP
	MOVWF	    PORTB
	CALL	    GECIKME
	

	MOVLW	    b'00000001'
	MOVWF	    PORTA
	MOVF	    ONLAR,W
	CALL	    LOOK_UP
	MOVWF	    PORTB
	CALL	    GECIKME
	INCF	    BIRLER,1
	GOTO	    DONGU	

TEMIZ
	MOVLW	    0x00
	MOVWF	    BIRLER
	MOVLW	    D'1'
	ADDWF	    ONLAR,1
	GOTO	    DONGU
	

	
	
		END
	