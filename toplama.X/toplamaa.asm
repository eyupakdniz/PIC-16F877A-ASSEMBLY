
; KODLAMA SABLONU

	list		p=16f877A	; hangi pic
	#include	<p16f877A.inc>	; SFR register 'ların tanımlandı�?ı kutuphane
	
	__CONFIG    H'3F31'

;KULLANILACAK DEGISKENLER

SAYI1		EQU 0x20   ;Buradaki ismi degistirebilir ve yenileri eklenebilir
SAYI2		EQU 0x21
TOPLAM		EQU 0X22
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
	BANKSEL	    TRISB
	MOVLW	    0X00
	MOVWF	    TRISB
	BANKSEL	    PORTB
	CLRF	    PORTB
	
	MOVLW	    0X52
	MOVWF	    SAYI1
	
	MOVLW	    0X56
	MOVWF	    SAYI2
	CLRW		    ;W register?n? temizler(0 yapar)
        
	MOVF	    SAYI1,W
	ADDWF	    SAYI2,W
	MOVWF	    TOPLAM
	MOVF	    TOPLAM,W
	MOVWF	    PORTB
	
	END                       ; Program sonu









