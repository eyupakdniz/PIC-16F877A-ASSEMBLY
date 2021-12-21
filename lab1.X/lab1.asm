	list		p=16f877A	; hangi pic
	#include	<p16f877A.inc>	; SFR register 'ların tanımlandı�?ı kutuphane
	
	__CONFIG    H'3F31'

;KULLANILACAK DEGISKENLER
S1	    EQU 0X20
G1	    EQU	0X21
G2	    EQU	0X22

;***** Kesme durumunda kaydedilmesi gereken SFR ler icin kullanilacak yardimci degiskenler
				
w_temp		EQU	0x7D		
status_temp	EQU	0x7E		
pclath_temp	EQU	0x7F
;********************************************************************************************
	ORG     0x00             	; Baslama vektoru

	nop			  	; ICD ozelliginin aktif edilmesi icin gereken bekleme 
  	goto    BASLA              	; baslama etiketine gir

	
;**********************************************************************************************
	ORG     0x04             	; kesme vektoru

	
;***********************************************************************************************
GEC
	
	MOVLW	    0XFF
	MOVWF	    G1
LOOP
	MOVLW	    0XFF
	MOVWF	    G2
LOOP1	
	DECFSZ	    G2,F
	GOTO	    LOOP1
		
	DECFSZ	    G1,F
	GOTO	    LOOP
	 
	RETURN
	
BASLA
	BANKSEL	    ADCON1
	MOVLW	    0X06
	MOVWF	    ADCON1
	
	BANKSEL	    PORTA
	MOVLW	    0X01
	MOVWF	    PORTA
	
	BANKSEL	    TRISB
	CLRF	    TRISB
	BANKSEL	    PORTB
	CLRF	    PORTB
	
	
	MOVLW	    0XFF
	MOVWF	    S1
	
DONGU	
	BTFSS	    PORTA,0
	GOTO	    DONGU
	GOTO	    ISLEM

ISLEM
	DECF	    S1,F
	MOVF	    S1,W
	MOVWF	    PORTB
	CALL	    GEC
	GOTO	    ISLEM
	
	END



