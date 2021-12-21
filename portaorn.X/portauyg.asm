; KODLAMA SABLONU

	list		p=16f877A	; hangi pic
	#include	<p16f877A.inc>	; SFR register 'ların tanımlandı�?ı kutuphane
	
	__CONFIG    H'3F31'

; WDT, ossilatör gibi register ayarları

	
;KULLANILACAK DEGISKENLER



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
	BANKSEL	    ADCON1
	MOVLW	    0X06
	MOVWF	    ADCON1
	
	BANKSEL	    TRISA
	MOVLW	    b'00000100'
	MOVLW	    TRISA
	
	BANKSEL	    TRISB
	CLRF	    TRISB
	BANKSEL	    PORTB
	CLRF	    PORTB
	
KONTROL
	BTFSC	    PORTA,2	;PORTB'nin 0.biti clear yani 0 ise skip yani atlar
	GOTO	    YAK
	GOTO	    SONDUR
	GOTO	    KONTROL
	
YAK
	MOVLW	    b'11111111'
	MOVWF	    PORTB
	GOTO	    KONTROL
	
SONDUR
	MOVLW	    b'00000000'
	MOVWF	    PORTB
	GOTO	    KONTROL
	

END                       ; Program sonu


