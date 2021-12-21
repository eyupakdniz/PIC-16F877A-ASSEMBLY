; KODLAMA SABLONU

	list		p=16f877A	; hangi pic
	#include	<p16f877A.inc>	; SFR register 'ların tanımlandı�?ı kutuphane
	
	__CONFIG    H'3F31'

;KULLANILACAK DEGISKENLER

G1	    EQU 0x20   ;Buradaki ismi degistirebilir ve yenileri eklenebilir
G2	    EQU 0x21



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
	MOVWF	G2   
LOOP2
	MOVLW	0XFF	
	MOVWF	G1	
	
LOOP1
	DECFSZ	G1,F	
	GOTO	LOOP1
	
	DECFSZ	G2,F	
	GOTO	LOOP2

	RETURN		    ;return ile alt programdan ana pograma yani DONGU'ye gider

;***********************************************************************************************
BASLA
	CLRF	    PORTB
	BANKSEL	    TRISB   ;PORTB cikis(input) yapmak i�in TIRSB'yi 0(sifir/output) yapmam?z laz?m
	CLRF	    TRISB   ;herhangi bir TIRS 0(output) yapmak PORT'u ?nput yapmak anlam?na geliyor 
	BCF	    STATUS,RP0
	MOVLW	    b'00000000'
	MOVWF	    PORTB
SAG
	CALL	    GECIKME
	RRF	    PORTB,F
	BTFSS	    PORTB,0
	GOTO	    SAG
	GOTO	    SOL	
	
SOL
	CALL	    GECIKME
	RLF	    PORTB,F
	BTFSS	    PORTB,7
	GOTO	    SOL
	GOTO	    SAG
		

	
  
	END                       ; Program sonu



