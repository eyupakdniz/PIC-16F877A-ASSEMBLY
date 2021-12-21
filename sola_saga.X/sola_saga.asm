; KODLAMA SABLONU

	list		p=16f877A	; hangi pic
	#include	<p16f877A.inc>	; SFR register 'larÄ±n tanÄ±mlandÄ±Ä?Ä± kutuphane
	
	__CONFIG    H'3F31'

;KULLANILACAK DEGISKENLER

G1	    EQU 0x20   ;Buradaki ismi degistirebilir ve yenileri eklenebilir
G2	    EQU 0x21
G3	    EQU 0x22
SOLSAG	    EQU 0X23

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
	MOVLW	0X05
	MOVWF	G3
LOOP3
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
	
	DECFSZ	G3,F	
	GOTO	LOOP3
	
	RETURN		    ;return ile alt programdan ana pograma yani DONGU'ye gider
;***********************************************************************************************
SSDON   
	BTFSC	    SOLSAG,0
	GOTO	    SAGAGIT  ;led 7. bit'de olursa içinde 0x01 de?eri olaca?? için 8 kere RRF komutu i?lenir
	GOTO	    SOLAGIT  ;led 0. bit'de olursa içinde 0x00 de?eri olaca?? için 8 kere RLF komutu çal???r 2olursa 
SAGAGIT	RRF	    PORTB
	RETURN		    ;return ile alt programdan ana pograma yani DONGU'ye gider
SOLAGIT	RLF	    PORTB
	RETURN		    ;return ile alt programdan ana pograma yani DONGU'ye gider
;***********************************************************************************************
SOLKONTROL
	BTFSS	    PORTB,7 ;PortB'nin 7. biti set(1)'mi diye kontrol eder
	RETURN		    ;return ile alt programdan ana pograma yani DONGU'ye gider
	MOVLW	    0X01
	MOVWF	    SOLSAG
	RETURN		    ;return ile alt programdan ana pograma yani DONGU'ye gider
;***********************************************************************************************
SAGKONTROL
	BTFSS	    PORTB,0
	RETURN		    ;return ile alt programdan ana pograma yani DONGU'ye gider
	MOVLW	    0X00
	MOVWF	    SOLSAG
	RETURN		    ;return ile alt programdan ana pograma yani DONGU'ye gider
;***********************************************************************************************
BASLA
	CLRF	    PORTB
	BANKSEL	    TRISB   ;PORTB cikis(input) yapmak için TIRSB'yi 0(sifir/output) yapmam?z laz?m
	CLRF	    TRISB   ;herhangi bir TIRS 0(output) yapmak PORT'u ?nput yapmak anlam?na geliyor 
	
	BCF	    STATUS,RP0	;Bank1(01) e geçti?imiz için saddece "1" temizlersek Bank0(00) geçmi? oluruz
	MOVLW	    0X00
	MOVWF	    SOLSAG  ;PORTB bo? oldugu için sola gitmemiz gerekiyor   
	
	MOVLW	    0X00
	MOVWF	    PORTB   ;PORTB'nin içinde b'0000 0001' olmal?
		
DONGU				;asagidaki döngü kitlenmi?tir d??ar?dan durdurulmassa hep çal??? 
	CALL	    GECIKME
	CALL	    SSDON        ;0 ve 1 durumu burada islenir
	CALL	    SOLKONTROL
	CALL	    SAGKONTROL
	GOTO	    DONGU
  
	END                       ; Program sonu







