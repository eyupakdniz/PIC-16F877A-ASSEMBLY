; KODLAMA SABLONU

	list		p=16f877A	; hangi pic
	#include	<p16f877A.inc>	; SFR register 'ların tanımlandı�?ı kutuphane
	
	__CONFIG    H'3F31'

; WDT, ossilatör gibi register ayarları

	
;KULLANILACAK DEGISKENLER

D1	EQU 0x20   ;Buradaki ismi degistirebilir ve yenileri eklenebilir
D2	EQU 0X21

;***** Kesme durumunda kaydedilmesi gereken SFR ler icin kullanilacak yardimci degiskenler
w_temp		EQU	0x7D		
status_temp	EQU	0x7E		
pclath_temp	EQU	0x7F					

;********************************************************************************************
	ORG     0x000             	; Baslama vektoru

	nop			  			  	; ICD ozelliginin aktif edilmesi icin gereken bekleme 
  	goto    BASLA              	; baslama etiketine gir
	
;**********************************************************************************************
	ORG     0x004             	; kesme vektoru
;***********************************************************************************************

BASLA
	BANKSEL	    TRISB
	MOVLW	    b'00001111'
	MOVWF	    TRISB
	BANKSEL	    PORTB
	CLRF	    PORTB
	
KONTROL
	BTFSC	    PORTB,0	;PORTB'nin 0.biti clear yani 0 ise skip yani atlar
	GOTO	    YAK
	GOTO	    SONDUR
	GOTO	    KONTROL
	
YAK
	BSF	    PORTB,4	;PORTB'nin 4.bitini set yani 1 yapar
	GOTO	    KONTROL
	
SONDUR
	BCF	    PORTB,4	 ;PORTB'nin 4.bitini clear yani 0 yapar
	GOTO	    KONTROL
	

END                       ; Program sonu