
; KODLAMA SABLONU

	list		p=16f877A	; hangi pic
	#include	<p16f877A.inc>	; SFR register 'ların tanımlandı�?ı kutuphane
	
	__CONFIG    H'3F31'

;KULLANILACAK DEGISKENLER

SAYI1		EQU 0x20   ;Buradaki ismi degistirebilir ve yenileri eklenebilir
SAYI2		EQU 0x21
BOLUM		EQU 0X22
;***** Kesme durumunda kaydedilmesi gereken SFR ler icin kullanilacak yardimci degiskenler
				
w_temp		EQU	0x7D		
status_temp	EQU	0x7E		
pclath_temp	EQU	0x7F
;********************************************************************************************
	ORG     0x000             	; Baslama vektoru

	NOP			  	; ICD ozelliginin aktif edilmesi icin gereken bekleme 
  	GOTO    BASLA              	; baslama etiketine gir

	
;**********************************************************************************************
	ORG     0x04             	; kesme vektoru
	
;***********************************************************************************************

BASLA
	BANKSEL	    TRISD
	CLRF	    TRISD
	BANKSEL	    PORTD
	CLRF	    PORTD
	
	MOVLW	    D'100'
	MOVWF	    SAYI1
	
	MOVLW	    D'4'
	MOVWF	    SAYI2
	CLRF	    BOLUM		    
        
BOLME
	INCF	    BOLUM
	MOVF	    SAYI2,W
	SUBWF	    SAYI1,F
	BTFSC	    STATUS,C
	GOTO	    BOLME
	DECF	    BOLUM
	MOVF	    BOLUM,W
	MOVWF	    PORTD
	
	END      


