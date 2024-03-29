;KODLAMA SABLONU

	list		p=16f877A	; hangi pic
	#include	<p16f877A.inc>	; SFR register 'lar?n tan?mland??? kutuphane
	
	__CONFIG H'3F31'    ; WDT, ossilat?r gibi register ayarlar?

	
;KULLANILACAK DEGISKENLER

DEC1	EQU	0x20    ;Degisken kullanmak icin GPR alan?nda istediginiz adresi yazabilirsiniz
VERI EQU 0X21
TEMP EQU 0X22


W_TEMP EQU 0X7D
STATUS_TEMP EQU 0X7E
 PCLATH_TEMP EQU 0X7F				


;********************************
	ORG     0x000             	; Baslama vektoru

	nop			  			  	; ICD ozelliginin aktif edilmesi icin gereken bekleme 
  	goto    BASLA              	; As?l kodlar?n yazili oldugu baslama etiketine git

	
ORG 0X004

    MOVWF W_TEMP 
	MOVFW PCLATH
	MOVWF PCLATH_TEMP
	MOVFW STATUS
	MOVWF STATUS_TEMP

	  BANKSEL PIR1
  	  BCF PIR1, RCIF
         MOVFW RCREG
	 
         BANKSEL PORTB
	 
         BSF PORTB,4
        CALL GONDER


	MOVFW PCLATH_TEMP
	MOVWF PCLATH
	MOVFW STATUS_TEMP
	MOVWF STATUS
	SWAPF W_TEMP,F
	SWAPF W_TEMP,W
       
	RETFIE
;*********************************
TETIKLEME
    BANKSEL PORTB
    BSF PORTB,5
    CALL DELAY
    BCF PORTB,5
RETURN

DELAY
    MOVLW 0XC8
    MOVWF DEC1
    LOOP
    DECFSZ DEC1,F
    GOTO LOOP
RETURN


GONDER
    BANKSEL PORTB
    MOVWF VERI
    SWAPF VERI,W
    ANDLW 0X0F
    MOVWF TEMP

    MOVFW PORTB
    ANDLW 0XF0

    IORWF TEMP,W
    MOVWF PORTB
    CALL TETIKLEME

    MOVF VERI,W

    ANDLW 0X0F
    MOVWF TEMP

    MOVFW PORTB
    ANDLW 0XF0

    IORWF TEMP,W
    MOVWF PORTB
    CALL TETIKLEME
RETURN


LCDAYARLA
    BANKSEL TRISB
    CLRF TRISB
    BANKSEL PORTB
    CLRF TRISB

    MOVLW 0X03

    CALL GONDER
  
    CALL TETIKLEME
    CALL DELAY

    CALL TETIKLEME
    CALL DELAY
    MOVLW 0X02
    CALL GONDER

    MOVLW 0X10
    CALL GONDER

    MOVLW 0X01
    CALL GONDER

    MOVLW 0X28
    CALL GONDER

    MOVLW 0X06
    CALL GONDER

    MOVLW 0X0D
    CALL GONDER
RETURN

HABER
    BANKSEL TRISC
    MOVLW B'10000000'
    MOVWF TRISC
    CLRF TRISB

    MOVLW .25
    MOVWF SPBRG

    BANKSEL TXSTA
    MOVLW B'00100110'
    MOVWF TXSTA

    BANKSEL RCSTA
    MOVLW B'10010000'
    MOVWF RCSTA
RETURN
KESME

    BANKSEL PIE1
    BCF PIE1,TXIE
    BSF PIE1,RCIE

    BANKSEL INTCON
    MOVLW B'11000000'
    MOVWF INTCON


RETURN

SSS
    BANKSEL PIR1
    LOOP2
    BTFSS PIR1,TXIF
    GOTO LOOP2
RETURN
	
BASLA
    CALL HABER
    CALL LCDAYARLA
    CALL KESME

    CALL SSS

    BANKSEL TXREG
    MOVLW 0X30
    MOVWF TXREG

    CALL SSS

    BANKSEL TXREG
    MOVLW 0X39
    MOVWF TXREG


    CALL SSS

    BANKSEL TXREG
    MOVLW 0X39
    MOVWF TXREG

    CALL SSS

    BANKSEL TXREG
    MOVLW 0X37
    MOVWF TXREG
	
	
DD
GOTO DD


	END          