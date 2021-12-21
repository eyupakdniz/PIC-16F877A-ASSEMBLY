	list		p=16f877A	
	#include	<p16f877A.inc>	
	
	__CONFIG    H'3F31'

;KULLANILACAK DEGISKENLER
G1	EQU 0x20
G2	EQU 0x21
BIRLER	EQU 0x22
ONLAR	EQU 0x23
SAYAC	EQU 0x24
DELAY	EQU 0x25
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
	ADDWF	PCL,1
	RETLW	B'00111111'
	RETLW	B'00000110'
	RETLW	B'01011011'
	RETLW	B'01001111'
	RETLW	B'01100110'
	RETLW	B'01101101'
	RETLW	B'01111100'
	RETLW	B'00000111'
	RETLW	B'01111111'
	RETLW	B'01100111'
	
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
	BANKSEL	    TRISB
	CLRF	    TRISB
	BANKSEL	    PORTB
	CLRF	    PORTB
	
	BANKSEL	    TRISD
	CLRF	    TRISD
	BANKSEL	    PORTD
	CLRF	    PORTD

	MOVLW	    D'9'
	MOVWF	    ONLAR
	MOVLW	    D'9'
	MOVWF	    BIRLER

	
DONGU
	MOVLW	    D'255'
	MOVWF	    SAYAC
	BCF	    STATUS,Z
	MOVLW	    D'5'
	MOVWF	    DELAY
	
	MOVF	    BIRLER,W
	SUBWF	    SAYAC,W
	BTFSS	    STATUS,Z
	GOTO	    ISLEM1
	GOTO	    ISLEM2
	
ISLEM1
	MOVLW	    B'00000001'
	MOVWF	    PORTD
	MOVF	    BIRLER,W
	CALL	    LOOK_UP
	MOVWF	    PORTB
	CALL	    GECIKME
	
	MOVLW	    B'00000010'
	MOVWF	    PORTD
	MOVF	    ONLAR,W
	CALL	    LOOK_UP
	MOVWF	    PORTB
	CALL	    GECIKME
	DECFSZ	    DELAY,1
	GOTO	    ISLEM1
	DECF	    BIRLER,1
	GOTO	    DONGU
	
ISLEM2
	MOVLW	    D'9'
	MOVWF	    BIRLER
	DECF	    ONLAR,1
	
	BCF	    STATUS,Z
	MOVF	    ONLAR,W
	SUBWF	    SAYAC,W
	BTFSS	    STATUS,Z
	GOTO	    DONGU
	MOVLW	    D'9'
	MOVWF	    ONLAR
	GOTO	    DONGU
	
;****************************************************************
;	MOVLW	    D'0'
;	MOVWF	    BIRLER
;	MOVLW	    D'0'
;	MOVWF	    ONLAR
;	
;DONGU
;	MOVLW	    D'10'
;	MOVWF	    SAYAC
;	MOVLW	    D'10'
;	MOVWF	    DELAY
;	BCF	    STATUS,Z
;	
;	MOVF	    BIRLER,W
;	SUBWF	    SAYAC,W
;	BTFSS	    STATUS,Z
;	GOTO	    ISLEM1
;	GOTO	    ISLEM2
;	
;ISLEM1
;	MOVLW	    B'00000001'
;	MOVWF	    PORTD
;	MOVF	    BIRLER,W
;	CALL	    LOOK_UP
;	MOVWF	    PORTB
;	CALL	    GECIKME
;	
;	MOVLW	    B'00000010'
;	MOVWF	    PORTD
;	MOVF	    ONLAR,W
;	CALL	    LOOK_UP
;	MOVWF	    PORTB
;	CALL	    GECIKME
;	
;	DECFSZ	    DELAY,1
;	GOTO	    ISLEM1
;	
;	INCF	    BIRLER,1
;	GOTO	    DONGU
;	
;ISLEM2	    
;	MOVLW	    D'6'
;	MOVWF	    SAYAC
;	INCF	    ONLAR,1
;	MOVLW	    D'0'
;	MOVWF	    BIRLER
;	MOVF	    ONLAR,W
;	SUBWF	    SAYAC,W
;	BTFSS	    STATUS,Z
;	GOTO	    DONGU
;	MOVLW	    D'0'
;	MOVWF	    ONLAR
;	GOTO	    DONGU
;	
;	
;************************************************************************	
;	BANKSEL	    TRISB
;	CLRF	    TRISB
;	BANKSEL	    PORTB
;	CLRF	    PORTB
;	
;	BANKSEL	    TRISC
;	CLRF	    TRISC
;	BANKSEL	    PORTC
;	CLRF	    PORTC
;DONGU
;	MOVLW	    B'00000111'
;	MOVWF	    PORTC
;	MOVLW	    B'01101111'
;	MOVWF	    PORTB
;	CALL	    GECIKME
;	
;	MOVLW	    B'00001011'
;	MOVWF	    PORTC
;	MOVLW	    B'01101111'
;	MOVWF	    PORTB
;	CALL	    GECIKME
;	
;	MOVLW	    B'00001101'
;	MOVWF	    PORTC
;	MOVLW	    B'01101111'
;	MOVWF	    PORTB
;	CALL	    GECIKME
;	
;	MOVLW	    B'00001110'
;	MOVWF	    PORTC
;	MOVLW	    B'00000110'
;	MOVWF	    PORTB
;	CALL	    GECIKME
;	GOTO	    DONGU
;	GOTO	    DONGU

	END




