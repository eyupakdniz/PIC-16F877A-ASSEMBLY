	list		p=16f877A	
	#include	<p16f877A.inc>	
	
	__CONFIG    H'3F31'

;KULLANILACAK DEGISKENLER
G1		EQU 0x20
G2		EQU 0x21
SAYI		EQU 0x22
G11		EQU 0x23
SAYII		EQU 0x20
G22		EQU 0x21

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
	movwf   w_temp		;W yedegi alIndI       	
	movf	STATUS,w        ;STATUS'un yedegini almak icin once W attIk  	
	movwf	status_temp     ;statusun yedegi alIndI
	movf	PCLATH,w	  	
	movwf	pclath_temp	;PCLATH	 yedegi alIndI	  		

	movf	pclath_temp,w	  ;geri donmeden once tum yedekleri geri yukle	
	movwf	PCLATH		  		
	movf    status_temp,w     	
	movwf	STATUS            	
	swapf   w_temp,f	   ;STATUSU etkilemesin diye
	swapf   w_temp,w           ;STATUSU etkilemesin diye	
	retfie			   ;kesmeden don  	

	
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
	
;GECIKME2
;	MOVLW	    0x10
;	MOVWF	    G11
;	
;	MOVLW	    0xFF
;	MOVWF	    G22
;LOOP1
;	DECFSZ	    G22,1
;	GOTO	    LOOP1
;	
;	DECFSZ	    G11,1
;	GOTO	    LOOP1
;	RETURN
	
LOOKUP
	ADDWF	    PCL,1
	RETLW	    B'10010110'
	RETLW	    B'10101001'
	RETLW	    B'11101001'
	RETLW	    B'10101001'
	RETLW	    B'10010010'
	
BASLA
	BANKSEL	    TRISB
	CLRF	    TRISB
	CLRF	    TRISC
	
	BANKSEL	    PORTB
	CLRF	    PORTB
	CLRF	    PORTC
	

	
ISLE
	CLRF	    SAYI
	MOVLW	    B'00000001'
	MOVWF	    PORTB
	CLRW

ISLEM
	MOVLW	    D'5'
	SUBWF	    SAYI,W
	BTFSC	    STATUS,Z
	CALL	    ISLE
	MOVF	    SAYI,W
	CALL	    LOOKUP
	MOVWF	    PORTC
	CALL	    GECIKME
	RLF	    PORTB,1
	INCF	    SAYI,1
	GOTO	    ISLEM

	END


