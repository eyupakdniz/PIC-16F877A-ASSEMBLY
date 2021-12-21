; KODLAMA SABLONU

	list		p=16f877A	; hangi pic
	#include	<p16f877A.inc>	; SFR register 'larÄ±n tanÄ±mlandÄ±Ä?Ä± kutuphane
	
	__CONFIG    H'3F31'

;KULLANILACAK DEGISKENLER

D1	EQU 0x20   ;Buradaki ismi degistirebilir ve yenileri eklenebilir
D2	EQU 0x21
D3	EQU 0x22

;***** Kesme durumunda kaydedilmesi gereken SFR ler icin kullanilacak yardimci degiskenler
				
w_temp		EQU	0x7D		
status_temp	EQU	0x7E		
pclath_temp	EQU	0x7F
;********************************************************************************************
	ORG     0x000             	; Baslama vektoru

	nop			  	; ICD ozelliginin aktif edilmesi icin gereken bekleme 
  	goto    BASLA              	; baslama etiketine gir

	
;**********************************************************************************************
	ORG     0x004             	; kesme vektoru

	
;***********************************************************************************************

GECIKME
	MOVLW	0X34
	MOVWF	D3
LOOP3
	MOVLW	0XFF  
	MOVWF	D2   
LOOP2
	MOVLW	0XFF	
	MOVWF	D1	
	
LOOP1
	DECFSZ	D1,F	
	GOTO	LOOP1
	
	DECFSZ	D2,F	
	GOTO	LOOP2
	
	DECFSZ	D3,F	
	GOTO	LOOP3
	
	RETURN

BASLA
     CLRF	PORTB	;bank0'de olan portb temizledik
     
     BANKSEL	TRISB   ;bank1'e geçtik 
     CLRF	TRISB	;tr?s1 temizler
     
     BCF	STATUS,5 ;statustaki 5.pini Clear'lar yani bank0'a geçer
     
DONGU  ;bu döngüde 0 ve 1 durumu inceleniyor
     MOVLW	0X01	    ;w ya sabit say? atar
     BTFSC	PORTB,0	    ;0.bit Clear ise skip(s?çrar
     MOVLW	0X00	    ;w ya sabit say? atar
     MOVWF	PORTB	    ;w içeri?ini f yükler
     CALL	GECIKME
     GOTO	DONGU
     
	END                       ; Program sonu




