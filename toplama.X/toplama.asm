; KODLAMA SABLONU

	list		p=16f877A	; hangi pic
	#include	<p16f877A.inc>	; SFR register 'ların tanımlandı�?ı kutuphane
	
	__CONFIG    H'3F31'

;KULLANILACAK DEGISKENLER

SAYI	EQU 0x20   ;Buradaki ismi degistirebilir ve yenileri eklenebilir


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

BASLA
     MOVLW  0X10
     MOVWF  SAYI
     
    
	END                       ; Program sonu



