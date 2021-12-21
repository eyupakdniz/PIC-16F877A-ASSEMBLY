; KODLAMA SABLONU

	list		p=16f877A	; hangi pic
	#include	<p16f877A.inc>	; SFR register 'ların tanımlandı�?ı kutuphane
	
	__CONFIG    H'3F31'

; WDT, ossilatör gibi register ayarları

	
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

	nop			  			  	; ICD ozelliginin aktif edilmesi icin gereken bekleme 
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
BASLA
	BANKSEL	    TRISA
	MOVLW	    0X06
	MOVWF	    ADCON1
	BANKSEL	    PORTA
	MOVLW	    0X01
	MOVWF	    PORTA
	
	BANKSEL	    TRISB
	CLRF	    TRISB
	BANKSEL	    PORTB
	CLRF	    PORTB
	
DONGU2	    ;PUL-UP
	BTFSS	    PORTA,0	    ;PORTA'n?n 0.biti 1(pull-up oldu?u i�in) diye kontrol et
	GOTO	    DONGU2
	GOTO	    DONGU
DONGU
	CALL	    YAK
	GOTO	    DONGU
	
	
YAK
	MOVLW	    b'01010101'
	MOVWF	    PORTB
	CALL	    GECIKME
	GOTO	    SONDUR
	
SONDUR
	MOVLW	    b'00000000'
	MOVWF	    PORTB
	CALL	    GECIKME
	GOTO	    DONGU
	

END                       ; Program sonu







