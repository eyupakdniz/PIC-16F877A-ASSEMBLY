;;512-1022 7 led, 1023 8 led
	;;4 sn(tmr0) aral?klarla al?nan ADC degerlerlini ledlerde yakan uygulama
	list		p=16f877A	
	#include	<p16f877A.inc>	
	
	__CONFIG    H'3F31'
YEDEK_H	    EQU	0x20
YEDEK_L	    EQU 0x21
KACKEZ	    EQU	0x22
	    
W_TEMP	    EQU	0x7D
STATUS_TEMP EQU	0x7E
PCLATH_TEMP EQU	0x7F

;***********************************************************************
    ORG	    0x000
    NOP	
    GOTO    BASLA
;*******************************************************************
    ORG	    0x004
    MOVWF   W_TEMP
    MOVF    STATUS,W
    MOVWF   STATUS_TEMP
    MOVF    PCLATH,W
    MOVWF   PCLATH_TEMP
    
    MOVLW   0x06
    MOVWF   TMR0
    BCF	    INTCON,T0IF
    
    DECFSZ  KACKEZ,1
    GOTO    CIK
    CALL    ISLEM
    
CIK
    BSF	    INTCON,GIE
    MOVF    PCLATH_TEMP,W
    MOVWF   PCLATH
    MOVF    STATUS_TEMP,W
    MOVWF   STATUS
    SWAPF   W_TEMP,1
    SWAPF   W_TEMP,0
    RETFIE
;*********************************************************
ISLEM
    MOVLW   0xFA
    MOVWF   KACKEZ
    CALL    ADC_OKU
    
    BTFSC   YEDEK_H,1
    GOTO    YAZ_1
    BTFSC   YEDEK_H,0
    GOTO    YAZ_2
    GOTO    YAZ_3
    RETURN
 ;***********************************************************
YAZ_1
    MOVLW   0xFF
    MOVWF   PORTC
    RETURN
    
YAZ_2
    MOVLW   0x0F
    MOVWF   PORTC
    RETURN
    
YAZ_3
    MOVLW   0x03
    MOVWF   PORTC
    RETURN
;****************************************************
KESME_AYAR
    BSF	    INTCON,T0IE
    BSF	    INTCON,GIE
    
    BANKSEL OPTION_REG
    MOVLW   B'00000100'
    MOVWF   OPTION_REG
    
    BANKSEL TMR0
    MOVLW   0x06
    MOVWF   TMR0
    RETURN
;**********************************************************
PORT_AYAR
    BANKSEL TRISA
    MOVLW   0xFF
    MOVWF   TRISA
    CLRF    TRISC
    
    BANKSEL PORTA
    CLRF    PORTA
    CLRF    PORTC
    
    RETURN
;***************************************************
ADC_AYAR
    BANKSEL ADCON0
    MOVLW   0x89
    MOVWF   ADCON0
    
    BANKSEL ADCON1
    MOVLW   0x80
    MOVWF   ADCON1
    
    RETURN
;********************************************************
ADC_OKU
    BANKSEL ADCON0
    BSF	    ADCON0,2
TT
    BTFSC   ADCON0,2
    GOTO    TT
    
    MOVF    ADRESL,W
    MOVWF   YEDEK_L
  
    MOVF    ADRESH,W
    MOVWF   YEDEK_H
    RETURN   
 ;*******************************************************
BASLA
    MOVLW   0x01
    MOVWF   KACKEZ
    CALL    KESME_AYAR
    CALL    PORT_AYAR
    CALL    ADC_AYAR
;    CALL    ADC_OKU
    
DD
    
    GOTO    DD
    END
    
    ;;;;RB0 KESMESI ILE YAP
;   	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31' 
;	
;YEDEK_L	    EQU	0x20
;YEDEK_H	    EQU	0x21
;
;W_TEMP	    EQU	0x7D
;STATUS_TEMP EQU	0x7E
;PCLATH_TEMP EQU	0x7F
; 
;;******************************************************************
;    ORG	    0x000
;    NOP
;    GOTO    BASLA
; ;*********************************************************
;    ORG	    0x004
;    MOVWF   W_TEMP
;    MOVF    STATUS,W
;    MOVWF   STATUS_TEMP
;    MOVF    PCLATH,W
;    MOVWF   PCLATH_TEMP
;    
;    BCF	    INTCON,INTF
;    CALL    ISLEM
;    
;CIK
;    BSF	    INTCON,GIE
;    MOVF    PCLATH_TEMP,W
;    MOVWF   PCLATH
;    MOVF    STATUS_TEMP,W
;    MOVWF   STATUS
;    SWAPF   W_TEMP,1
;    SWAPF   W_TEMP,0
;    RETFIE
;;**********************************************************
;ISLEM
;    CALL    ADC_OKU
;    
;    BTFSC   YEDEK_H,1
;    GOTO    YAZ_1
;    BTFSC   YEDEK_H,0
;    GOTO    YAZ_2
;    GOTO    YAZ_3
;    RETURN
; ;***********************************************************
;YAZ_1
;    MOVLW   0xFF
;    MOVWF   PORTC
;    RETURN
;    
;YAZ_2
;    MOVLW   0x0F
;    MOVWF   PORTC
;    RETURN
;    
;YAZ_3
;    MOVLW   0x03
;    MOVWF   PORTC
;    RETURN
;;**************************************************
; ADC_AYAR
;    BANKSEL	ADCON0
;    MOVLW	0x89
;    MOVWF	ADCON0
;    
;    BANKSEL	ADCON1
;    MOVLW	0x80
;    MOVWF	ADCON1
;    RETURN
; ;***************************************************
;ADC_OKU
;    BANKSEL ADCON0
;    BSF	    ADCON0,2
;TT
;    BTFSC   ADCON0,2
;    GOTO    TT
;    
;    BANKSEL ADRESL
;    MOVF    ADRESL,W
;    MOVWF   YEDEK_L
;    
;    BANKSEL ADRESH
;    MOVF    ADRESH,W
;    MOVWF   YEDEK_H
;    RETURN
; ;********************************************************
;KESME_AYAR
;    BANKSEL INTCON
;    BSF	    INTCON,GIE
;    BSF	    INTCON,INTE
;    
;    BANKSEL OPTION_REG
;    MOVLW   B'00000000'
;    MOVWF   OPTION_REG
;    RETURN
;;*************************************************************
;PORT_AYAR
;    BANKSEL TRISA
;    MOVLW   0xFF
;    MOVWF   TRISA
;    MOVLW   0x01
;    MOVWF   TRISB
;;    CLRF    TRISB
;    CLRF    TRISC
;    
;    BANKSEL PORTA
;    CLRF    PORTA
;    CLRF    PORTB   
;    CLRF    PORTC
;    RETURN
; ;**********************************************************
;BASLA
;    CALL    KESME_AYAR
;    CALL    ADC_AYAR
;    CALL    PORT_AYAR
;GG
;    GOTO    GG
;     END
    
    

 
;;;;Al?nan ADC degerinin ledlerde yakan uygulama
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'
;
;SH	EQU 0x20
;SL	EQU 0x21
;	
;	ORG	0x000
;	NOP
;	GOTO	BASLA
;;*********************************************************************
;	ORG	0x004
;	
;	RETFIE
;;*************************************************************************
;ADC_AYAR
;	BANKSEL	    ADCON0
;	MOVLW	    0x89	;0.bite bir vererek ADC'lerin hepsini aktif ettik
;	MOVWF	    ADCON0	;ornekleme frekans icin aral?g? FOSC/32 sectik bunun icin 010(ADCS2-ADCON1'de)(ADCS1)(ADCS0) degeri verdik
;	
;	BANKSEL	    ADCON1
;	MOVLW	    0x80	;adreslemeyi sagdan yapmak icin ADFM'ye bir verdik
;	MOVWF	    ADCON1
;	RETURN
;;*************************************************************
;PORT_AYAR
;	BANKSEL	    TRISA
;;	BSF	    TRISA,1
;	MOVLW	    0xFF   ;TRISA GIRIS SECMEK ICIN FF VERDIK
;	MOVWF	    TRISA
;	
;	CLRF	    TRISB
;	CLRF	    TRISC
;	
;	BANKSEL	    PORTA
;	CLRF	    PORTA
;	CLRF	    PORTB
;	CLRF	    PORTC
;	
;	RETURN
;;*************************************************************
;ADC_OKU
;	BANKSEL	    ADCON0
;	BSF	    ADCON0,2	    ;ornekleme frekans? almak icin go/done aktfi ettik
;	
;TT
;	BTFSC	    ADCON0,2	    ;
;	GOTO	    TT
;	
;	BANKSEL	    ADRESL
;	MOVF	    ADRESL,W
;	MOVWF	    SL
;	
;	BANKSEL	    ADRESH
;	MOVF	    ADRESH,W
;	MOVWF	    SH
;	RETURN
;;*****************************************************************
;YAZ
;	BTFSC	    SH,1
;	GOTO	    YAK_3
;	BTFSC	    SH,0	    
;	GOTO	    YAK_2
;	GOTO	    YAK_1
;YAK_1
;	MOVLW	    0x03
;	MOVWF	    PORTB
;	RETURN
;YAK_2
;	MOVLW	    0x0F
;	MOVWF	    PORTB
;	RETURN
;YAK_3
;	MOVLW	    0xFF
;	MOVWF	    PORTB
;	RETURN
;;**********************************************************************
;	
;BASLA
;	CALL	    ADC_AYAR
;	CALL	    PORT_AYAR
;	
;	CALL	    ADC_OKU
;	CALL	    YAZ
;	
;	END


