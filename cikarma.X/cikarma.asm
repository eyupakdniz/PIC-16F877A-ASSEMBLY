
; KODLAMA SABLONU

	list		p=16f877A	; hangi pic
	#include	<p16f877A.inc>	; SFR register 'larÄ±n tanÄ±mlandÄ±Ä?Ä± kutuphane
	
	__CONFIG    H'3F31'

;KULLANILACAK DEGISKENLER

SAYI1		EQU 0x20   ;Buradaki ismi degistirebilir ve yenileri eklenebilir
SAYI2		EQU 0x21
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
	GOTO	KESME
	ORG	0X05
;***********************************************************************************************

BASLA
	BANKSEL	    TRISB
	MOVLW	    0X00
	MOVWF	    TRISB
	BANKSEL	    PORTB
	CLRF	    PORTB
	
	MOVLW	    0X40
	MOVWF	    SAYI1
	
	MOVLW	    0X03
	MOVWF	    SAYI2
	CLRW		    ;W register?n? temizler(0 yapar)
	
ISLEM
	ADDWF	    SAYI1,W	;say?1'i w register'?n? ile topluyor
	DECFSZ	    SAYI2,F	;say?2'i 1 azalt?yor ve tekrar kendi üstüne yaz?yor ve e?er 0 olursa skip(s?çrar)  
	GOTO	    ISLEM   
	MOVWF	    PORTB	
	
KESME
	GOTO KESME
	
	END                       ; Program sonu






