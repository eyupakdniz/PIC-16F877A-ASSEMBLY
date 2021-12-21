	list		p=16f877A	
	#include	<p16f877A.inc>	
	
	__CONFIG H'3F31'
SAYI_L	    EQU	0x20
SAYI_H	    EQU	0x21
G1	    EQU	0x22
G2	    EQU	0x23
;***************************************************
	    ORG	0x000
	    NOP
	    GOTO    BASLA
;********************************************************
	    ORG	0x004
	    RETFIE
;****************************************************
GECIKME
	    MOVLW   0xFF
	    MOVWF   G1
	    
	    MOVLW   0xFF
	    MOVWF   G2
LOOP
	    DECFSZ  G1,1
	    GOTO    LOOP
	    
	    DECFSZ  G2,1
	    GOTO    LOOP
	    
	    RETURN
;****************************************************
ISLEM
	    CALL    ADC_OKU
;	    BCF	    STATUS,C
;	    MOVLW   0x01
;	    SUBWF   SAYI_H,0
;	    BTFSS   STATUS,C	    
	    BTFSS   SAYI_H,0
	    GOTO    SOL
	    GOTO    SAG
	    RETURN
SOL
	    BCF	    STATUS,C
	    RLF	    PORTB,1
	    CALL    GECIKME
	    BTFSS   PORTB,7
	    RETURN
	    MOVLW   0x80
	    MOVWF   PORTB
	    RETURN
SAG
	    BCF	    STATUS,C
	    RRF	    PORTB,1
	    CALL    GECIKME
	    BTFSS   PORTB,0
	    RETURN
	    MOVLW   0x01
	    MOVWF   PORTB
	    RETURN
;*****************************************************
ADC_AYAR
	    BANKSEL ADCON0
	    MOVLW   0x89
	    MOVWF   ADCON0
	    
	    BANKSEL ADCON1
	    MOVLW   0x80
	    MOVWF   ADCON1
	    RETURN
;**********************************************
ADC_OKU
	    BANKSEL ADCON0
	    BSF	    ADCON0,2
TT  
	    BTFSC   ADCON0,2
	    GOTO    TT
	    
	    BANKSEL ADRESL
	    MOVF    ADRESL,W
	    MOVWF   SAYI_L
	    
	    BANKSEL ADRESH
	    MOVF    ADRESH,W
	    MOVWF   SAYI_H
	    RETURN
;***********************************************
PORT_AYAR
	    BANKSEL TRISA
	    MOVLW   0xFF
	    MOVWF   TRISA
	    CLRF    TRISB
	    
	    BANKSEL PORTA
	    CLRF    PORTA
	    MOVLW   0x01
	    MOVWF   PORTB
	    RETURN
;*********************************************
BASLA
	    CALL    PORT_AYAR
	    CALL    ADC_AYAR
DD
	    
	    CALL    ISLEM
	    GOTO    DD
	    END
    
    
    
    ;;;;0 1led yaK, 1-255 3 led, 255-512 5led, 512-1022 7led, 1023 ise 8 led	
;	list		p=16f877A	; hangi pic
;	#include	<p16f877A.inc>	; SFR register 'lar?n tan?mland??? kutuphane
;	
;	__CONFIG H'3F31'
;SAYI_L	    EQU	0x20
;SAYI_H	    EQU	0x21
;	
;W_TEMP	    EQU	0x7D
;STATUS_TEMP EQU	0x7E
;PCLATH_TEMP EQU	0x7F
;;**************************************************
;	ORG 0x000
;	NOP
;	GOTO	BASLA
;;-*****************************************************
;	ORG 0x004
;	MOVWF	W_TEMP
;	MOVF	STATUS,W
;	MOVWF	STATUS_TEMP
;	MOVF	PCLATH,W
;	MOVWF	PCLATH_TEMP
;	
;	BCF	INTCON,INTF
;	CALL	ISLEM
;CIK
;	BSF	INTCON,GIE
;	MOVF	PCLATH_TEMP,W
;	MOVWF	PCLATH
;	MOVF	STATUS_TEMP,W
;	MOVWF	STATUS
;	SWAPF	W_TEMP,1
;	SWAPF	W_TEMP,0
;	RETFIE
;;********************************************************
;ISLEM
;	CALL	ADC_OKU
;	
;	BTFSC	SAYI_H,1
;	GOTO	YAK_0
;	BTFSC	SAYI_H,0
;	GOTO	YAK_1
;	GOTO	YAK_2
;	RETURN
;YAK_0
;	BTFSS	SAYI_H,0
;	GOTO	YAK_00
;	BCF	STATUS,Z
;	MOVLW	0xFF
;	SUBWF	SAYI_L,0
;	BTFSS	STATUS,Z
;	CALL	YAK_00
;	MOVLW	0xFF
;	MOVWF	PORTC
;	RETURN
;	
;YAK_00
;	MOVLW	0x7F
;	MOVWF	PORTC
;	RETURN
;	
;YAK_1
;	MOVLW	0x1F
;	MOVWF	PORTC
;	RETURN
;YAK_2
;	BCF	STATUS,Z
;	MOVLW	0x00
;	SUBWF	SAYI_L,0
;	BTFSC	STATUS,Z
;	GOTO	YAK_22
;	MOVLW	0x07
;	MOVWF	PORTC
;	RETURN
;YAK_22
;	MOVLW	0x01
;	MOVWF	PORTC
;	RETURN
;;****************************************************
;KESME_AYAR
;	BANKSEL	INTCON
;	BSF	INTCON,GIE
;	BSF	INTCON,INTE
;	BCF	INTCON,INTF
;	
;	BANKSEL	OPTION_REG
;	BCF	OPTION_REG,6	;INTEDG
;	RETURN
;;************************************
;ADC_AYAR
;	BANKSEL	ADCON0
;	MOVLW	0x89
;	MOVWF	ADCON0
;	
;	BANKSEL	ADCON1
;	MOVLW	0x80
;	MOVWF	ADCON1
;	RETURN
;;**************************************************
;PORT_AYAR
;	BANKSEL	TRISA
;	MOVLW	0xFF
;	MOVWF	TRISA
;	MOVLW	0x01
;	MOVWF	TRISB
;	CLRF	TRISC
;	
;	BANKSEL	PORTA
;	CLRF	PORTA
;	CLRF	PORTB
;	CLRF	PORTC
;	RETURN
;;**************************************************
;ADC_OKU
;	BANKSEL	ADCON0
;	BSF	ADCON0,2
;TT
;	BTFSC	ADCON0,2
;	GOTO	TT
;	
;	BANKSEL	ADRESL
;	MOVF	ADRESL,W
;	MOVWF	SAYI_L
;	
;	BANKSEL	ADRESH
;	MOVF	ADRESH,W
;	MOVWF	SAYI_H
;	RETURN
;;*********************************************************
;BASLA
;	CALL	PORT_AYAR
;	CALL	ADC_AYAR
;	CALL	KESME_AYAR
;DD
;	GOTO	DD
;	END
	
	
	
	
    ;	;;STACK
;	list		p=16f877A	; hangi pic
;	#include	<p16f877A.inc>	; SFR register 'lar?n tan?mland??? kutuphane
;	
;	__CONFIG H'3F31'
;;KULLANILACAK DEGISKENLER
;OFSET		EQU	0x51    ; BU REG. 0x20 'E EKLENEREK STACK IN TOP KISMINI BULMAK ICIN KULLANILACAK
;DEGER		EQU	0x52	; BU REG. STACK 'A ATILACAK OLAN DEGERI TUTACAK (BU BIR PORTTAN OKUNAN DEGERI TEMSIL ETSIN)
;DON		EQU	0x53	; STACK 'A ARKA ARKAYA DEGER ATAMA ORNEGI ICIN KULLANILACAK
;DONUS		EQU	0x54	; BU REGISTER STACK DEN ALINAN DEGERI TUTACAK (BU BIR PORTA GONDERILECEK DEGERI TEMSIL ETSIN)
;
;;********************************************************************************************
;	ORG     0x000             	
;	nop			  	 
;  	goto    BASLA              	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;EKLE
;	BCF	STATUS,Z
;	MOVLW	.30		; STACK SINIRA ULASTIYSA ARTTIRMA YAPMA (SINIR 30 IDI)
;	SUBWF	OFSET,0	
;	BTFSC	STATUS,Z
;	GOTO	BITIR
;	INCF	OFSET,1		; EGER SINIRA ULASMADI ISE STACK IN TOP GOSTERGESINI 1 ARTTIR
;	MOVF	OFSET,W		; STACK 'IN TOP ADRESI ICIN TABANA (0x20) EKLENECEK SAYI
;	ADDLW	0x20		; 0x20+OFSET(20. adresden sonra)
;	MOVWF	FSR		; FILE REGISTER 'DA FSR NIN GOSTERDI?I ADRESE GIT
;	MOVF	DEGER,0		; DEGER REGISTER 'INI AL VE BUNU INDF (FSR DEKI DEGER) REGISTERINA AT (BURADA DEGER HERHANGI BIR PORT DA OLABILIR)
;	MOVWF	INDF		
;BITIR	
;	RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;KAC_TANE
;	INCF	OFSET,0
;	MOVWF	DONUS	    ; OFSET E BAKARAK STACK BOYUTUNU OGRENEBILIRIZ (UNUTMAYIN 255 HIC ELEMAN YOK DEMEK IDI)
;	RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;TEMIZLE
;	BCF	STATUS,Z
;	MOVLW	.255
;	SUBWF	OFSET,0		; EGER OFSET DEGERI 255 ISE DAHA DA AZALTMA (BU AYNI ZAMANDA STACK BOS DEMEK)
;	BTFSC	STATUS,Z
;	GOTO	BIT2
;	MOVF	OFSET,0		; STACK 'IN TOP ADRESI ICIN TABANA (0x20) EKLENECEK SAYI
;	ADDLW	0x20		; 0x20+OFSET
;	MOVWF	FSR		; FSR ADRESI ARTIK STACK TOP ADRESINI GOSTERIYOR. ICERIK ISE INDF 'DE
;	CLRF	INDF		; ICERIGI TEMIZLE 
;	DECF	OFSET,1		;  OFSET DEGERINI AZALT
;	GOTO	TEMIZLE
;	
;BIT2
;	RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;BASLA
;	MOVLW	.30
;	MOVWF	DON
;	
;	MOVLW	.255	    ; EGER OSET DEGERI 255 ISE STACK BOS DEMEK OLSUN. BU DURUMDA CIKARMA(OKUMA) YAPMA
;	MOVWF	OFSET
;	
;	MOVLW	.12
;	MOVWF	DEGER
;	
;	BCF	STATUS,IRP  ; BANK 0 ICIN STATUS IRP=0 FSR 'NIN 7. BITI 0
;	
;
;DD	CALL	EKLE		; DENEME YAP 30 TANE EKLE (0x20 DEN BASLA 0x3D YE (30 ADET) 12 SAYISI YUKLE SONRA BUNLARI CIKAR)
;	DECFSZ	DON,1
;	GOTO	DD
;  	CALL	TEMIZLE
;BB  
;	GOTO BB
;	END     
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ;; SUBWF, SUBLW, DECFSZ, DECF OLMADAN ÇIKARMA YAPMA
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31' 
;SAYI1	    EQU	0x30
;SAYI2	    EQU	0x31
;ISARET	    EQU	0x32
;YEDEK	    EQU	0x33
;;**************************************
;	    ORG	0x000
;	    NOP
;	    GOTO    BASLA
;;;*******************************************
;	    ORG	0x004
;	    RETFIE
;;*******************************************
;SORU2
;	CLRF	ISARET
;	BCF	STATUS,C    ; VARSAYILAN 0. EGER ELDE BITI VAR ISE POZITIF SONUC, ELDE YOK ISE NEGATIF SONUC DEMEKTIR (ELLE BIR ORNEK COZUNUZ)
;	COMF	SAYI2,1	    ; 2 YE TUMLEYEN ALMA 1. ADIM
;	INCF	SAYI2,0	    ; 2 YE TUMLEME 2. ADIM (SONUCU W TUT KI SAYI1 ILE TOPLAYASIN)
;	ADDWF	SAYI1,0	    ; SIMDI TOPLAMA YAP VE ISARETE BAK
;	BTFSS	STATUS,C    
;	BSF	ISARET,7    ; SONUC NEGATIF
;	MOVWF	YEDEK	    ; SONUCU TMP YE AT (OPSIYONEL)
;	
;	BTFSS	ISARET,7    ; EGER SONUC NEGATIF ISE SONUC DEGERI TEKRARDAN 2 'E TUMLEYENINI AL POZITIF KARSILIGINI GOR
;	GOTO	BIT_0	    ; POZITIF ISE BIRSEY YAPMANA GEREK YOK
;	COMF	YEDEK,1
;	INCF	YEDEK,1
;BIT_0	
;	RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;BASLA
;	MOVLW	.15
;	MOVWF	SAYI1
;	MOVLW	.12
;	MOVWF	SAYI2
;	CALL	SORU2
;      end
    
    
    
    
    
    
    ;;;10-0//0-10 BUTON ?LE
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31' 
;ONLAR	    EQU	0x30
;BIRLER	    EQU	0x31
;D1	    EQU	0x20  
;D2	    EQU	0x21 
;D11	    EQU	0x22  
;D22	    EQU	0x23 
;	    
;W_TEMP	    EQU	0x7D
;STATUS_TEMP EQU	0x7E
;PCLATH_TEMP EQU	0x7F
;;**************************************
;	    ORG	0x000
;	    NOP
;	    GOTO    BASLA
;;;*******************************************
;	    ORG	0x004
;	    RETFIE
;;*******************************************
;PORT_AYAR
;	    BANKSEL ADCON1
;	    MOVLW   0x06
;	    MOVWF   ADCON1
;	    
;	    BANKSEL TRISA
;	    MOVLW   B'00111100'
;	    MOVWF   TRISA
;	    CLRF    TRISB
;	    CLRF    TRISC
;	    
;	    BANKSEL PORTA
;	    CLRF    PORTA
;	    CLRF    PORTB
;	    CLRF    PORTC
;	    RETURN
;;***************************************
;LOOKUP
;	ADDWF	    PCL,1
;	RETLW	    0x3F
;	RETLW	    0x06
;	RETLW	    0x5B
;	RETLW	    0x4F
;	RETLW	    0x66
;	RETLW	    0x6D
;	RETLW	    0x7D
;	RETLW	    0x07
;	RETLW	    0x7F
;	RETLW	    0x6F
;;***********************************************************************************************
;GECIKME
;
;	MOVLW	0XE7  
;	MOVWF	D2   
;
;	MOVLW	0X04	
;	MOVWF	D1	
;	
;LOOP1
;	DECFSZ	D2,F	
;	GOTO	LOOP1
;	
;	DECFSZ	D1,F	
;	GOTO	LOOP1
;	
;	RETURN
;;***********************************************************************************************
;GECIKME_2
;
;	MOVLW	0XFF
;	MOVWF	D22   
;
;	MOVLW	0XFF	
;	MOVWF	D11	
;	
;LOOP
;	DECFSZ	D22,F	
;	GOTO	LOOP
;	
;	DECFSZ	D11,F	
;	GOTO	LOOP
;	
;	RETURN
;;***********************************************************************************************
;ISLEM_1
;	    CALL    GECIKME_2
;	    BCF	    STATUS,Z
;	    CLRF    ONLAR
;	    CLRF    BIRLER
;	    
;YAZ_1
;	    BTFSC   PORTC,0
;	    CALL    ART
;	    
;	    MOVLW   B'00111110'
;	    MOVWF   PORTA
;	    MOVF    BIRLER,W
;	    CALL    LOOKUP
;	    MOVWF   PORTB
;	    CALL    GECIKME
;	    
;	    MOVLW   B'00111101'
;	    MOVWF   PORTA
;	    MOVF    ONLAR,W
;	    CALL    LOOKUP
;	    MOVWF   PORTB
;	    CALL    GECIKME
;	    GOTO    YAZ_1
;ART
;	    CALL    GECIKME_2
;	    MOVLW   0x01
;	    SUBWF   ONLAR,0
;	    BTFSC   STATUS,Z
;	    GOTO    BAS
;	    INCF    BIRLER,1
;	    MOVLW   0x09
;	    SUBWF   BIRLER,0
;	    BTFSS   STATUS,Z
;	    RETURN
;	    CLRF    BIRLER
;	    INCF    ONLAR,1
;	    RETURN
;;********************************************
;ISLEM_2
;	    CALL    GECIKME_2
;	    BCF	    STATUS,Z
;	    CLRF    BIRLER
;	    MOVLW   0x01
;	    MOVWF   ONLAR
;	    
;YAZ_2
;	    BTFSC   PORTC,1
;	    CALL    AZAL
;	    
;	    MOVLW   B'00111110'
;	    MOVWF   PORTA
;	    MOVF    BIRLER,W
;	    CALL    LOOKUP
;	    MOVWF   PORTB
;	    CALL    GECIKME
;	    
;	    MOVLW   B'00111101'
;	    MOVWF   PORTA
;	    MOVF    ONLAR,W
;	    CALL    LOOKUP
;	    MOVWF   PORTB
;	    CALL    GECIKME
;	    GOTO    YAZ_2  
;	    
;AZAL
;	    CALL    GECIKME_2
;	    DECF    BIRLER,1
;	    MOVLW   0xFF
;	    SUBWF   BIRLER,0
;	    BTFSS   STATUS,Z
;	    RETURN
;	    MOVLW   0X09
;	    MOVWF   BIRLER
;	    DECF    ONLAR,1
;	    MOVLW   0xFF
;	    SUBWF   ONLAR,0
;	    BTFSS   STATUS,Z
;	    RETURN
;	    GOTO    BAS
;;********************************************
;BAS
;	    CALL    GECIKME_2
;	    BCF	    STATUS,Z
;	    CLRF    ONLAR
;	    CLRF    BIRLER
;	    GOTO    DD
;;********************************************
;BASLA
;	   CALL	PORT_AYAR 
;	  
;DD
;	   BTFSC    PORTC,0
;	   CALL	    ISLEM_1
;	   BTFSC    PORTC,1
;	   CALL	    ISLEM_2
;	   GOTO	    DD
;	    
;	    END
	
	
	
	
	
	
;	;;KARE DALGA
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31' 
;SAYI_1	    EQU	0x30
;SAYI_2	    EQU	0x31
;TOP	    EQU	0x20  
;TOPP	    EQU	0x21 
;	    
;W_TEMP	    EQU	0x7D
;STATUS_TEMP EQU	0x7E
;PCLATH_TEMP EQU	0x7F
;;**************************************
;	    ORG	0x000
;	    NOP
;	    GOTO    BASLA
;;*******************************************
;	    ORG	0x004
;	    MOVWF   W_TEMP
;	    MOVF    STATUS,W
;	    MOVWF   STATUS_TEMP
;	    MOVF    PCLATH,W
;	    MOVWF   PCLATH_TEMP
;	    
;	    BCF	    INTCON,T0IF
;	    MOVLW   0x06
;	    MOVWF   TMR0
;	    
;	    CALL    ISLEM
;	    
;CIK
;	    BSF	    INTCON,GIE
;	    MOVF    PCLATH_TEMP,W
;	    MOVWF   PCLATH
;	    MOVF    STATUS_TEMP,W
;	    MOVWF   STATUS
;	    SWAPF   W_TEMP,1
;	    SWAPF   W_TEMP,0
;	    RETFIE
;;*******************************************
;ISLEM
;	    MOVLW   B'00000011'
;	    XORWF   PORTC,1
;	    RETURN
;;*****************************************************
;KESME_AYAR
;	    BANKSEL INTCON
;	    BSF	    INTCON,GIE
;	    BSF	    INTCON,T0IE
;	    BCF	    INTCON,T0IF
;	    
;	    BANKSEL OPTION_REG
;	    MOVLW   B'00000001'
;	    MOVWF   OPTION_REG
;	    
;	    BANKSEL TMR0
;	    MOVLW   0x06
;	    MOVWF   TMR0
;	    RETURN
;;*******************************************************
;PORT_AYAR
;	    BANKSEL TRISC
;	    CLRF    TRISC
;	    
;	    BANKSEL PORTC
;	    MOVLW   0x01
;	    MOVWF   PORTC
;	    RETURN
;;****************************************
;	    
;	    
;BASLA
;	   CALL	    KESME_AYAR
;	   CALL	    PORT_AYAR
;DD
;	   GOTO	    DD
;	    END
;	    
	    
    
    ;	;;PORTB DEKI BUTTON A BASINCA PORTA YANAN LED
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31' 
;SAYI_1	    EQU	0x30
;SAYI_2	    EQU	0x31
;TOP	    EQU	0x20  
;TOPP	    EQU	0x21  
;;**************************************
;	    ORG	0x000
;	    NOP
;	    GOTO    BASLA
;;*******************************************
;	    ORG	0x004
;	    RETFIE
;;*******************************************
;PORT_AYAR
;	    BANKSEL ADCON1
;	    MOVLW   0X06
;	    MOVWF   ADCON1
;	    
;	    BANKSEL TRISA
;	    MOVLW   B'00111100'
;	    MOVWF   TRISA
;	    CLRF    TRISC
;	    
;	    BANKSEL PORTA
;	    CLRF    PORTA
;	    CLRF    PORTC
;	    RETURN
;;*******************************************
;ISLEM_0
;	    CLRF    PORTA
;	    MOVLW   B'00111101'	    ;LED 1 VERINCE CALISIR
;	    MOVWF   PORTA
;	    RETURN
;ISLEM_1
;	    CLRF    PORTA
;	    MOVLW   B'00111110'	    ;LED
;	    MOVWF   PORTA
;	    RETURN
;;******************************************
;BASLA
;	    CALL    PORT_AYAR
;	    
;DD
;	    BTFSC   PORTB,0
;	    CALL    ISLEM_0
;	    BTFSC   PORTB,1
;	    CALL    ISLEM_1
;	    GOTO    DD
;	    END
	    
	    
    
    
    
    ;	;;0.LED BASINCA PORTB0. 1. AYNI
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31' 
;SAYI_1	    EQU	0x30
;SAYI_2	    EQU	0x31
;TOP	    EQU	0x20  
;TOPP	    EQU	0x21  
;;**************************************
;	    ORG	0x000
;	    NOP
;	    GOTO    BASLA
;;*******************************************
;	    ORG	0x004
;	    RETFIE
;;*******************************************
;PORT_AYAR
;	    BANKSEL ADCON1
;	    MOVLW   0x06
;	    MOVWF   ADCON1
;	    BANKSEL TRISA
;	    MOVLW   B'00111111'	    ;BUTTON
;	    MOVWF   TRISA
;	    CLRF    TRISC
;	    
;	    BANKSEL PORTA
;	    CLRF    PORTA
;	    CLRF    PORTC
;	    RETURN
;;******************************************
;ISLEM_1
;	CLRF	PORTC
;	BSF	PORTC,0
;	RETURN
;ISLEM_2
;	CLRF	PORTC
;	MOVLW	B'00000010'
;	MOVWF	PORTC
;	RETURN
;;***************************
;	    
;BASLA
;	CALL	PORT_AYAR
;	
;DD 
;	BTFSC	PORTA,0
;	CALL	ISLEM_1
;	BTFSC	PORTA,1
;	CALL	ISLEM_2
;	GOTO	DD
;	    END
    
    
    
    
    
    ;	;;;16 bitlik 2 say?n?n toplam? 130H YAZAN UYGULAMA
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31' 
;SAYI_1	    EQU	0x30
;SAYI_2	    EQU	0x31
;SAYI_3	    EQU	0X32
;SAYI_4	    EQU	0x33
;YEDEK	    EQU	0x20
;	    
;;*****************************************************
;	    ORG	0x000
;	    NOP
;	    GOTO    BASLA
;;*********************************************************
;	    ORG	0x004
;	    RETFIE
;;********************************************
;BASLA
;	    MOVLW   0x30
;	    MOVWF   SAYI_1
;	    MOVLW   0x31
;	    MOVWF   SAYI_2
;	    MOVLW   0x32
;	    MOVWF   SAYI_3
;	    MOVLW   0x33
;	    MOVWF   SAYI_4
;	    
;	    BCF	    STATUS,IRP
;	    MOVLW   0x30
;	    MOVWF   FSR
;	    MOVF    INDF,W
;	    MOVWF   YEDEK
;	    MOVLW   0x02
;	    ADDWF   FSR,1
;	    MOVF    INDF,W
;	    ADDWF   YEDEK,1
;	    BTFSC   STATUS,C
;	    INCF    SAYI_2,1
;	    
;	    BSF	    STATUS,IRP
;	    MOVLW   0x30
;	    MOVWF   FSR
;	    MOVF    YEDEK,W
;	    MOVWF   INDF
;	    
;	    BCF	    STATUS,IRP
;	    MOVLW   0x31
;	    MOVWF   FSR
;	    MOVF    INDF,W
;	    MOVWF   YEDEK
;	    MOVLW   0x02
;	    ADDWF   FSR,1
;	    MOVF    YEDEK,W
;	    ADDWF   INDF,0
;	    MOVWF   YEDEK
;	    
;	    BSF	    STATUS,IRP
;	    MOVLW   0x31
;	    MOVWF   FSR
;	    MOVF    YEDEK,W
;	    MOVWF   INDF
;GG
;	    GOTO    GG
;	  
;	    END
    
    
    
    
    
    ;	;;;8 bitlik 2 say?n?n toplam?
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31' 
;SAYI_1	    EQU	0x30
;SAYI_2	    EQU	0x31
;YEDEK	    EQU	0x20
;	    
;;*****************************************************
;	    ORG	0x000
;	    NOP
;	    GOTO    BASLA
;;*********************************************************
;	    ORG	0x004
;	    RETFIE
;;********************************************
;BASLA
;	    MOVLW   0x30
;	    MOVWF   SAYI_1
;	    MOVLW   0x31
;	    MOVWF   SAYI_2
;	    
;	    MOVLW   0x30
;	    MOVWF   FSR
;	    MOVF    INDF,W
;	    MOVWF   YEDEK
;	    INCF    FSR,1
;	    MOVF    INDF,W
;	    ADDWF   YEDEK,1
;	   
;	    BSF	    STATUS,IRP
;	    MOVLW   0x30
;	    MOVWF   FSR
;	    MOVF    YEDEK,W
;	    MOVWF   INDF
;GG
;	    GOTO    GG
;	  
;	    END
    
    
    
    
    
    
    ;	;;;RB0
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'   
;SAYI_L	    EQU	0x20
;SAYI_H	    EQU	0x21
;   
;W_TEMP	    EQU	0x7D
;STATUS_TEMP EQU	0x7E
;PCLATH_TEMP EQU	0x7F
;;;********************************************
;	ORG 0x000
;	NOP
;	GOTO	BASLA
;;;*********************************************
;	ORG 0x004
;	MOVWF	W_TEMP
;	MOVF	STATUS,W
;	MOVWF	STATUS_TEMP
;	MOVF	PCLATH,W
;	MOVWF	PCLATH_TEMP
;	
;	BCF	INTCON,INTF
;	CALL	ISLEM
;CIK
;	BSF	INTCON,GIE
;	MOVF	PCLATH_TEMP,W
;	MOVWF	PCLATH
;	MOVF	STATUS_TEMP,W
;	MOVWF	STATUS
;	SWAPF	W_TEMP,1
;	SWAPF	W_TEMP,0
;	RETFIE
;;**********************************************
;ISLEM
;	CALL	ADC_OKU
;	
;	RETURN
;;***********************************************
;ADC_AYAR
;	BANKSEL	ADCON0
;	MOVLW	0x89
;	MOVWF	ADCON0
;	
;	BANKSEL	ADCON1
;	MOVLW	0x80
;	MOVLW	ADCON1
;	RETURN
;;**********************************************
;ADC_OKU
;	BANKSEL	ADCON0
;	BSF	ADCON0,2
;TT
;	BTFSC	ADCON0,2
;	GOTO	TT
;	
;	BANKSEL	ADRESL
;	MOVF	ADRESL,W
;	MOVWF	SAYI_L
;	
;	BANKSEL	ADRESH
;	MOVF	ADRESH,W
;	MOVWF	SAYI_H
;	
;	RETURN
;;***********************************************
;KESME_AYAR
;	BANKSEL	INTCON
;	BSF	INTCON,GIE
;	BSF	INTCON,INTE
;	
;	BANKSEL	OPTION_REG
;	MOVLW	B'00000000'
;	MOVWF	OPTION_REG
;	
;	RETURN
;;**********************************************
;PORT_AYAR
;	BANKSEL	TRISA
;	MOVLW	0xFF
;	MOVWF	TRISA
;	MOVLW	0x01
;	MOVWF	TRISB
;	
;	BANKSEL	PORTA
;	CLRF	PORTA
;	CLRF	PORTB
;	RETURN
;;***********************************************
;BASLA
;	CALL	ADC_AYAR
;	CALL	PORT_AYAR
;	CALL	KESME_AYAR
;	
;	
;DD
;	GOTO	DD
;	
;	END
    
	
	
    ;;;,;INDF-FSR UYGULAMASINI 
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'    
;SAYI_1	    EQU	0x30
;SAYI_2	    EQU	0x31
;SAYI_3	    EQU	0x32
;SAYI_4	    EQU	0x33
;SAYI_5	    EQU	0x34
;SAYI_6	    EQU	0x35
;SAYI_7	    EQU	0x36
;SAYI_8	    EQU	0x37
;	   
;SAYAC	    EQU	0x20
;W_TEMP	    EQU	0x21
;	    
;;***********************************************
;	    ORG	0x000
;	    NOP
;	    GOTO    BASLA
;;******************************************
;	    ORG	0x004
;	    RETFIE
;;****************************************
;BASLA
;	    CLRF    SAYAC
;	    CLRF    W_TEMP
;	    MOVLW   0x0A
;	    MOVWF   SAYI_1
;	    MOVLW   0x0B
;	    MOVWF   SAYI_2
;	    MOVLW   0x0C
;	    MOVWF   SAYI_3
;	    MOVLW   0x0D
;	    MOVWF   SAYI_4
;	    MOVLW   0x0E
;	    MOVWF   SAYI_5
;	    MOVLW   0x0F
;	    MOVWF   SAYI_6
;	    MOVLW   0x10
;	    MOVWF   SAYI_7
;	    MOVLW   0x11
;	    MOVWF   SAYI_8
;DD  
;	    BCF	    STATUS,IRP
;	    MOVLW   0x30
;	    ADDWF   SAYAC,0
;	    MOVWF   FSR
;	    MOVF    INDF,W
;	    MOVWF   W_TEMP
;	    BSF	    STATUS,IRP
;	    MOVLW   0x30 
;	    ADDWF   SAYAC,0
;	    MOVWF   FSR
;	    MOVF    W_TEMP,W
;	    MOVWF   INDF
;	    BCF	    STATUS,Z
;	    INCF    SAYAC,1
;	    MOVLW   0x09
;	    SUBWF   SAYAC,0
;	    BTFSS   STATUS,Z
;	    GOTO    DD
;BITTI
;	    GOTO    BITTI
;	    END
	    
    
    
;;;500 MIKRO SN BIR KARE DALGA URETEN UYGULAMA
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'
;
;W_TEMP	    EQU	0x7D
;STATUS_TEMP EQU	0x7E
;PCLATH_TEMP EQU	0x7F
;;**********************************
;	ORG 0x000
;	NOP
;	GOTO	BASLA
;;*************************************
;	ORG 0x004
;	MOVWF	W_TEMP
;	MOVF	STATUS,W
;	MOVWF	STATUS_TEMP
;	MOVF	PCLATH,W
;	MOVWF	PCLATH_TEMP
;	
;	MOVLW	0x83
;	MOVWF	TMR0
;	BCF	INTCON,T0IF
;	
;	CALL	ISLEM
;	
;CIK
;	BSF	INTCON,GIE
;	MOVF	PCLATH_TEMP,W
;	MOVWF	PCLATH
;	MOVF	STATUS_TEMP,W
;	MOVWF	STATUS
;	SWAPF	W_TEMP,1
;	SWAPF	W_TEMP,0
;	RETFIE
;;*************************************
;ISLEM
;	
;	MOVLW	B'00000011'
;	XORWF	PORTB,1
;	
;	RETURN
;;*************************************
;KESME_AYAR
;	BSF	INTCON,GIE
;	BSF	INTCON,T0IE
;	
;	BANKSEL	OPTION_REG
;	MOVLW	B'00000001'
;	MOVWF	OPTION_REG
;	
;	BANKSEL	TMR0
;	MOVLW	0x83
;	MOVWF	TMR0
;	RETURN
;;***************************************	
;PORT_AYAR
;	BANKSEL	TRISB
;	CLRF	TRISB
;	
;	BANKSEL	PORTB
;	MOVLW	0x01
;	MOVWF	PORTB
;	
;	RETURN
;;-*****************************************
;BASLA
;	CALL	KESME_AYAR
;	CALL	PORT_AYAR
;
;DD
;	GOTO	DD
;	
;	END
    
    
    
    
    
    
    
    
    
;    ;;PORTA 2. BUTTONA BASINCA ARTAN, PORTA 3. BUTONA BASINCA AZALAN KOD  10 A KADAR  
;        	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'
;BIRLER	    EQU	0x20
;ONLAR	    EQU	0x21
;G1	    EQU	0x22
;G2	    EQU	0x23
;G11	    EQU	0x24
;G22	    EQU	0x25
;;**************************************
;	    ORG	0x000
;	    NOP	
;	    GOTO    BASLA
;;******************************************
;	    ORG	0x004
;	    RETFIE
;;*******************************************
;LOOKUP
;	ADDWF	    PCL,1
;	RETLW	    0x3F
;	RETLW	    0x06
;	RETLW	    0x5B
;	RETLW	    0x4F
;	RETLW	    0x66
;	RETLW	    0x6D
;	RETLW	    0x7D
;	RETLW	    0x07
;	RETLW	    0x7F
;	RETLW	    0x6F
;;*******************************************
;PORT_AYAR
;	    BANKSEL ADCON1
;	    MOVLW   0x06
;	    MOVWF   ADCON1
;	    
;	    BANKSEL TRISA
;	    MOVLW   B'01111100'  
;	    MOVWF   TRISA
;	    CLRF    TRISB
;	    CLRF    TRISC
;	    
;	    BANKSEL PORTA
;	    CLRF    PORTA
;	    CLRF    PORTB
;	    CLRF    PORTC
;	    
;	    RETURN
;;***********************************
;GECIKME
;	    MOVLW   0xDA	;0xE7
;	    MOVWF   G1
;	    
;	    MOVLW   0X04
;	    MOVWF   G2
;LOOP
;	    DECFSZ  G1,1
;	    GOTO    LOOP
;	    
;	    DECFSZ  G2,1
;    	    GOTO    LOOP
;	    
;	    RETURN
;;*********************************************************	    
;GECIKMEE
;	    MOVLW   0xFF	
;	    MOVWF   G11
;	    
;	    MOVLW   0XFF
;	    MOVWF   G22
;LOOPP
;	    DECFSZ  G11,1
;	    GOTO    LOOPP
;	    
;	    DECFSZ  G22,1
;    	    GOTO    LOOPP
;	    
;	    RETURN
;;******************************************************
;ART
;	    BCF	    STATUS,Z
;	    CLRF    BIRLER
;	    CLRF    ONLAR
;	    
;ARTTIR
;	    BTFSC   PORTC,0
;	    CALL    ARTTIRR
;	    
;	    MOVLW   B'00000010'
;	    MOVWF   PORTA
;	    MOVF    BIRLER,W
;	    CALL    LOOKUP
;	    MOVWF   PORTB
;	    CALL    GECIKME
;	    
;	    MOVLW   B'00000001'
;	    MOVWF   PORTA
;	    MOVF    ONLAR,W    
;	    CALL    LOOKUP
;	    MOVWF   PORTB
;	    CALL    GECIKME
;	    GOTO    ARTTIR
;ARTTIRR
;	    CALL    GECIKMEE
;	    BCF	    STATUS,Z
;	    MOVLW   0x01
;	    SUBWF   ONLAR,0
;	    BTFSC   STATUS,Z
;	    GOTO    AYAR
;	    
;	    INCF    BIRLER,1
;	    MOVLW   0x0A
;	    SUBWF   BIRLER,0
;	    BTFSS   STATUS,Z
;	    RETURN
;	    
;	    CLRF    BIRLER
;	    INCF    ONLAR,1
;	    RETURN
;;***************************************************
;AZAL
;	    BCF	    STATUS,Z   
;	    CLRF    BIRLER
;	    MOVLW   0x01
;	    MOVWF   ONLAR
;	    CALL    GECIKMEE
;	    CALL    GECIKMEE
;AZALT
;	    
;	    BTFSC   PORTC,1
;	    CALL    AZALTT
;	    
;	    MOVLW   B'00000010'
;	    MOVWF   PORTA
;	    MOVF    BIRLER,W
;	    CALL    LOOKUP
;	    MOVWF   PORTB
;	    CALL    GECIKME
;	    
;	    MOVLW   B'00000001'
;	    MOVWF   PORTA
;	    MOVF    ONLAR,W
;	    CALL    LOOKUP
;	    MOVWF   PORTB
;	    CALL    GECIKME
;	    GOTO    AZALT
;AZALTT	    
;	    CALL    GECIKMEE
;	    DECF    BIRLER,1
;	    MOVLW   0xFF
;	    SUBWF   BIRLER,0
;	    BTFSS   STATUS,Z
;	    RETURN
;	    
;	    BCF	    STATUS,Z
;	    MOVLW   0x09
;	    MOVWF   BIRLER
;	    DECF    ONLAR,1
;	    MOVLW   0xFF
;	    SUBWF   ONLAR,0
;	    BTFSS   STATUS,Z
;	    RETURN
;;	    GOTO    AZAL  
;	    GOTO    AYAR
;;***************************************************
;AYAR
;	    CALL    GECIKMEE
;	    BCF	    STATUS,Z
;	    CLRF    ONLAR
;	    CLRF    BIRLER
;	    GOTO    DD 
;	    
;;**************************************************
;BASLA
;	    CALL    PORT_AYAR
;	    CLRF    ONLAR
;	    CLRF    BIRLER
;	    
;DD
;	    BTFSC   PORTC,0
;	    CALL    ART
;	    BTFSC   PORTC,1
;	    CALL    AZAL
;	    GOTO    DD
;    END    
    
    
    
    
    
    
    
    
    
    ;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'
;G1	EQU 0x20
;G2	EQU 0x21
;G3	EQU 0x22
;SAYIB	EQU 0x23
;SAYIC	EQU 0x24
;	
;;********************************************************************
;	ORG	0x000
;	NOP
;	GOTO	BASLA
;;*********************************************************************
;	ORG	0x004
;	RETFIE
;;*******************************************************************
;GECIKME
;;	MOVLW	0xFF
;;	MOVWF	G1
;	
;	MOVLW	0xE7
;	MOVWF	G2
;;	
;	MOVLW	0xFF
;	MOVWF	G3
;LOOP
;;	DECFSZ	G1,1
;;	GOTO	LOOP
;	
;	DECFSZ	G2,1
;	GOTO	LOOP
;	
;	DECFSZ	G3,1
;	GOTO	LOOP
;	
;	RETURN
;;*******************************************************************
;LOOK_UP
;	ADDWF	PCL,1
;	RETLW	B'00000000'
;	RETLW	B'00110110'
;	RETLW	B'00110110'
;	RETLW	B'00110110'
;	RETLW	B'00111110'
;	
;;********************************************************************
;PORT_AYAR
;	BANKSEL	TRISB
;	CLRF	TRISB
;	CLRF	TRISC
;	
;	BANKSEL	PORTB
;	CLRF	PORTB
;	CLRF	PORTC
;	RETURN
;;***************************************************
;ISLEM
;	BCF	STATUS,C
;	MOVF	SAYIB,W		;1 verince sondu, 0 verince yandi
;	CALL	LOOK_UP
;	MOVWF	PORTB
;	
;	MOVF	SAYIC,W
;	MOVWF	PORTC	    ;0 verince sondu,   1 verince yand?
;	CALL	GECIKME
;	
;	RLF	SAYIC,1	
;	INCF	SAYIB,1
;	MOVLW	0x05
;	SUBWF	SAYIB,0
;	BTFSS	STATUS,Z
;	GOTO	ISLEM
;	CLRF	SAYIB
;	MOVLW	0x01
;	MOVWF	SAYIC
;	
;
;	GOTO	ISLEM
;
;
;;**************************************************
;BASLA
;	CLRF	SAYIB
;	BSF	SAYIC,0
;	CALL	PORT_AYAR
;	CALL	ISLEM
;	
;	
;	END

