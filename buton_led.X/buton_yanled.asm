
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
	
	RETURN
PORTA_AYARLA
	BANKSEL	    TRISA
	MOVLW	    0X06    ;dijital input-output ypar alttaki komut ile
	MOVWF	    ADCON1  ;ADC pasif hale getirir(SAYISAL G?R?? HALINE GET?R?LD?)
	MOVLW	    b'00111111'
	MOVWF	    TRISA   ;TRISA ya 3F de?erini yükledik
	BCF	    STATUS,RP0 ; bank0(00) geç
	RETURN
	
PORTB_AYARLA
	BANKSEL	    TRISB
	CLRF	    TRISB
	BANKSEL	    PORTB
	CLRF	    PORTB
	RETURN
	
	
BASLA
     CALL	PORTA_AYARLA
     CALL	PORTB_AYARLA

KONTROL       ;PULL-UP ÇALI?IYOR
     BTFSS	PORTA,0	    ;PORTA'n?n 0.biti 1(pull-up oldu?u için) diye kontrol et
     GOTO	YAK_0
     BTFSS	PORTA,1	    ;PORTA'n?n 1.biti 1(pull-up oldu?u için) diye kontrol et
     GOTO	YAK_1
     BTFSS	PORTA,2	    ;PORTA'n?n 2.biti 1(pull-up oldu?u için) diye kontrol et
     GOTO	YAK_2
     BTFSS	PORTA,3	    ;PORTA'n?n 3.biti 1(pull-up oldu?u için) diye kontrol et
     GOTO	YAK_3
     BTFSS	PORTA,4	    ;PORTA'n?n 4.biti 1(pull-up oldu?u için) diye kontrol et
     GOTO	YAK_4
     BTFSS	PORTA,5	    ;PORTA'n?n 5.biti 1(pull-up oldu?u için) diye kontrol et
     GOTO	YAK_5
     GOTO	KONTROL
     
     
YAK_0
     MOVLW	b'00000001'
     MOVWF	PORTB
     GOTO	TEKRAR
     
YAK_1
     MOVLW	b'00000010'
     MOVWF	PORTB
     GOTO	TEKRAR
   
YAK_2
     MOVLW	b'00000100'
     MOVWF	PORTB
     GOTO	TEKRAR
 
YAK_3
     MOVLW	b'00001000'
     MOVWF	PORTB
     GOTO	TEKRAR
     
YAK_4
     MOVLW	b'00010000'
     MOVWF	PORTB
     GOTO	TEKRAR
     
YAK_5
     MOVLW	b'00100000'
     MOVWF	PORTB
     GOTO	TEKRAR
     
TEKRAR	;B?RDEN FAZLA GOTO KOMUTU KULLANIYORSANINZ YER?N?Z? KAYBETMEMEK ?Ç?N YAPILIR
    CALL	GECIKME
    CALL	SIFIRLA
    GOTO	KONTROL
    
SIFIRLA
    CLRF	PORTB
    ;MOVLW	0X00
    ;MOVFW	PORTB
    RETURN

	END                       ; Program sonu






