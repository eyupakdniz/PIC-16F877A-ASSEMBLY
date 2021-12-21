;;RB0 KESMESINDE SOLA KAYAN LED UYGULAMADI
	list		p=16f877A	
	#include	<p16f877A.inc>	
	
	__CONFIG    H'3F31'

SAYI	    EQU	0x20
KACKEZ	    EQU	0x21
	    
W_TEMP	    EQU	0x7D
STATUS_TEMP EQU	0x7E
PCLATH_TEMP EQU	0x7F
 
    ORG	    0x000
    NOP
    GOTO    BASLA   
;******************************************************************
    ORG	0x004
    MOVWF	W_TEMP
    MOVF	STATUS,W
    MOVWF	STATUS_TEMP
    MOVF	PCLATH,W
    MOVWF	PCLATH_TEMP
    
    BCF		INTCON,T0IF
    MOVLW	0x06
    MOVWF	TMR0
    
        
    DECFSZ	KACKEZ,1
    RETFIE
    BTFSS	PORTC,7
    CALL	ISLEM_TMR0
    
    BTFSS	INTCON,INTF
    GOTO	CIK
    CALL	ISLEM_RB0

CIK
    BSF		INTCON,GIE
    MOVF	PCLATH_TEMP,W
    MOVWF	PCLATH
    MOVF	STATUS_TEMP,W
    MOVWF	STATUS
    SWAPF	W_TEMP,1
    SWAPF	W_TEMP,0
	RETFIE
;******************************************************
ISLEM_RB0
    BCF		INTCON,INTF
    MOVLW	0xBB
    MOVWF	KACKEZ
    
    MOVLW	0x01
    MOVWF	PORTC
    RETURN
;******************************************************
ISLEM_TMR0
    MOVLW	0xBB
    MOVWF	KACKEZ
    
    BCF		STATUS,C
    RLF		PORTC,1
    RETURN
;****************************************************
KESME_AYAR
    BSF		INTCON,GIE
    BSF		INTCON,T0IE
    BSF		INTCON,INTE
    
    BANKSEL	OPTION_REG
    MOVLW	B'00000011'
    MOVWF	OPTION_REG
    
    BANKSEL	TMR0
    MOVLW	0x06
    MOVWF	TMR0
    RETURN
;************************************************
PORT_AYAR
    BANKSEL	TRISB
    MOVLW	B'00000001'
    MOVWF	TRISB
    CLRF	TRISC
    
    BANKSEL	PORTB
    CLRF	PORTB
    CLRF	PORTC
    
    RETURN
;**********************************************
BASLA
    CALL	KESME_AYAR
    CALL	PORT_AYAR
    MOVLW	0x10
    MOVWF	KACKEZ
    CLRF	SAYI
DD

    GOTO	DD
    END
	
	
	
	
	;;;RB0 KESMESINDE SOLA KAYAN LED UYGULAMADI
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'
;
;SAYI	    EQU	0x20
;KACKEZ	    EQU	0x21
;	    
;W_TEMP	    EQU	0x7D
;STATUS_TEMP EQU	0x7E
;PCLATH_TEMP EQU	0x7F
; 
; ORG	0x000
; NOP
; GOTO	    BASLA
;;******************************************************************
;    ORG	0x004
;	MOVWF   W_TEMP
;	MOVF    STATUS,W
;	MOVWF   STATUS_TEMP
;	MOVF    PCLATH,W
;	MOVWF   PCLATH_TEMP
;	
;	BCF	    INTCON,T0IF
;	MOVLW	    0x06
;	MOVWF	    TMR0
;;	
;;	BTFSS	INTCON,INTF
;;	GOTO	ISLEM
;;	CALL	ISLEM_RB0
;;	
;;ISLEM
;;	DECFSZ	    KACKEZ,F
;;	GOTO	    CIK
;;	CALL	    ISLEM_TMR0
;	
;	DECFSZ	    KACKEZ,1
;	RETFIE
;	CALL	    ISLEM_TMR0
;	
;	
;	BTFSS	    INTCON,INTF
;	GOTO	    CIK
;	CALL	    ISLEM_RB0
;	
; 
;CIK
;	BSF	INTCON,GIE
;	MOVF	PCLATH_TEMP,W
;	MOVWF   PCLATH
;	MOVF    STATUS_TEMP,W
;	MOVWF   STATUS
;	SWAPF   W_TEMP,1
;	SWAPF   W_TEMP,0
;	RETFIE
;;**********************************************
;ISLEM_RB0
;	BCF	INTCON,INTF
;	MOVLW	0xFA
;	MOVWF	KACKEZ
;	
;	MOVLW	    0x01
;	MOVWF	    PORTC
;	RETURN
;	
;ISLEM_TMR0
;	MOVLW	0xFA
;	MOVWF	KACKEZ
;	BCF	STATUS,C
;	RLF	PORTC
;	RETURN
;;*****************************************************
;KESME_AYAR
;	MOVLW   B'10110000'
;	MOVWF   INTCON
;    
;	BANKSEL OPTION_REG
;	MOVLW	B'00000011'
;	MOVWF	OPTION_REG
;	BANKSEL	TMR0
;	MOVLW	0x06
;	MOVWF	TMR0
;    
;	RETURN
; ;*****************************************************
;PORT_AYAR
;	BANKSEL TRISB
;	MOVLW	B'00000001'
;	MOVWF	TRISB
;	CLRF    TRISC
;    
;	BANKSEL PORTB
;	CLRF    PORTB
;	CLRF    PORTC
;	RETURN
; ;***************************************************
;BASLA
;	CALL    KESME_AYAR
;	CALL    PORT_AYAR
;;	MOVLW	B'00000000'
;;	MOVWF	SAYI
;	MOVLW	0x01
;	MOVWF	KACKEZ
;    
;DD  
;	
;	GOTO    DD
;    END
	
	
	
	
	
	;;;;0-10
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'
;	
;BIRLER	    EQU	0x20
;ONLAR	    EQU	0x21
;SIRA	    EQU	0x22
;	    
;W_TEMP	    EQU	0x7D
;STATUS_TEMP EQU	0x7E
;PCLATH_TEMP EQU	0x7F
; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    ORG	0x000
;    NOP
;    GOTO    BASLA
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    ORG	0x004
;    MOVWF	W_TEMP
;    MOVF	STATUS,W
;    MOVWF	STATUS_TEMP
;    MOVF	PCLATH,W
;    MOVWF	PCLATH_TEMP
;    
;    MOVLW	0x06
;    MOVWF	TMR0
;    BCF		INTCON,T0IF
;    CALL	ISLEM_TMR0
;    
;    BTFSS	INTCON,INTF
;    GOTO	CIK
;    BCF		INTCON,INTF
;    CALL	ISLEM_RB0
;    
;CIK
;    MOVF	PCLATH_TEMP,W
;    MOVWF	PCLATH
;    MOVF	STATUS_TEMP,W
;    MOVWF	STATUS
;    SWAPF	W_TEMP,1
;    SWAPF	W_TEMP,0
;	RETFIE
;;******************************************************************************
;ISLEM_RB0
;	BTFSC	    ONLAR,0
;	GOTO	    BASLA
;	INCF	    BIRLER,1
;	MOVLW	    0x0A
;	SUBWF	    BIRLER,0
;	BTFSS	    STATUS,Z
;	RETURN
;	
;	CLRF	    BIRLER
;	
;	INCF	    ONLAR,1
;	MOVLW	    0x0A
;	SUBWF	    ONLAR,0
;	BTFSS	    STATUS,Z
;	RETURN
;	CLRF	    ONLAR
;	RETURN
;;******************************************************************************
;ISLEM_TMR0
;	BTFSS	    SIRA,0
;	GOTO	    ON
;	
;	MOVLW	    B'00000010'
;	MOVWF	    PORTA
;	MOVF	    BIRLER,W
;	CALL	    LOOKUP
;	MOVWF	    PORTC
;	INCF	    SIRA,1
;	RETURN
;ON
;	MOVLW	    B'00000001'
;	MOVWF	    PORTA
;	MOVF	    ONLAR,W
;	CALL	    LOOKUP
;	MOVWF	    PORTC
;	DECF	    SIRA,1	
;	RETURN
;;****************************************************************************
; LOOKUP
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
;;  ;**********************************************************
;KESME_AYAR
;	MOVLW	    B'10110000'
;	MOVWF	    INTCON
;	
;	BANKSEL	    OPTION_REG
;	MOVLW	    B'00000011'
;	MOVWF	    OPTION_REG
;	
;	BANKSEL	    TMR0
;	MOVLW	    0x06
;	MOVWF	    TMR0
;	RETURN
;;******************************************************************************
;PORT_AYAR
;	BANKSEL	    ADCON1
;	MOVLW	    0x06
;	MOVWF	    ADCON1
;	
;	BANKSEL	    TRISA
;	MOVLW	    B'00111100'
;	MOVWF	    TRISA
;	MOVLW	    B'00000001'
;	MOVWF	    PORTB
;	CLRF	    PORTC
;	
;	BANKSEL	    PORTA
;	CLRF	    PORTA
;	CLRF	    PORTC
;	CLRF	    PORTB
;	RETURN
;;**********************************************************************************
;BASLA
;	CALL	    KESME_AYAR
;	CALL	    PORT_AYAR
;	CLRF	    ONLAR
;	CLRF	    BIRLER
;	MOVLW	    0x01
;	MOVWF	    SIRA
;DD
;	
;	GOTO	DD
;	END
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	;;10-0
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'
;	
;BIRLER	    EQU	0x20
;ONLAR	    EQU	0x21
;SIRA	    EQU	0x22
;	    
;W_TEMP	    EQU	0x7D
;STATUS_TEMP EQU	0x7E
;PCLATH_TEMP EQU	0x7F
; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    ORG	0x000
;    NOP
;    GOTO    BASLA
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    ORG	0x004
;    MOVWF	W_TEMP
;    MOVF	STATUS,W
;    MOVWF	STATUS_TEMP
;    MOVF	PCLATH,W
;    MOVWF	PCLATH_TEMP
;    
;    MOVLW	0x06
;    MOVWF	TMR0
;    BCF		INTCON,T0IF
;    CALL	ISLEM_TMR0
;    
;    BTFSS	INTCON,INTF
;    GOTO	CIK
;    BCF		INTCON,INTF
;    CALL	ISLEM_RB0
;    
;CIK
;    MOVF	PCLATH_TEMP,W
;    MOVWF	PCLATH
;    MOVF	STATUS_TEMP,W
;    MOVWF	STATUS
;    SWAPF	W_TEMP,1
;    SWAPF	W_TEMP,0
;	RETFIE
;;******************************************************************************
;ISLEM_RB0
;	DECF	    BIRLER,1
;	MOVLW	    0xFF
;	SUBWF	    BIRLER,0
;	BTFSS	    STATUS,Z
;	RETURN
;	
;	MOVLW	    0x09
;	MOVWF	    BIRLER
;	
;	DECF	    ONLAR,1
;	MOVLW	    0xFF
;	SUBWF	    ONLAR,0
;	BTFSS	    STATUS,Z
;	RETURN
;	CLRF	    BIRLER
;	MOVLW	    0x01
;	MOVWF	    ONLAR
;	RETURN
;;******************************************************************************
;ISLEM_TMR0
;	BTFSS	    SIRA,0
;	GOTO	    ON
;	
;	MOVLW	    B'00000010'
;	MOVWF	    PORTA
;	MOVF	    BIRLER,W
;	CALL	    LOOKUP
;	MOVWF	    PORTC
;	INCF	    SIRA,1
;	RETURN
;ON
;	MOVLW	    B'00000001'
;	MOVWF	    PORTA
;	MOVF	    ONLAR,W
;	CALL	    LOOKUP
;	MOVWF	    PORTC
;	DECF	    SIRA,1	
;	RETURN
;;****************************************************************************
; LOOKUP
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
;;  ;**********************************************************
;KESME_AYAR
;	MOVLW	    B'10110000'
;	MOVWF	    INTCON
;	
;	BANKSEL	    OPTION_REG
;	MOVLW	    B'00000011'
;	MOVWF	    OPTION_REG
;	
;	BANKSEL	    TMR0
;	MOVLW	    0x06
;	MOVWF	    TMR0
;	RETURN
;;******************************************************************************
;PORT_AYAR
;	BANKSEL	    ADCON1
;	MOVLW	    0x06
;	MOVWF	    ADCON1
;	
;	BANKSEL	    TRISA
;	MOVLW	    B'00111100'
;	MOVWF	    TRISA
;	MOVLW	    B'00000001'
;	MOVWF	    PORTB
;	CLRF	    PORTC
;	
;	BANKSEL	    PORTA
;	CLRF	    PORTA
;	CLRF	    PORTC
;	CLRF	    PORTB
;	RETURN
;;**********************************************************************************
;BASLA
;	CALL	    KESME_AYAR
;	CALL	    PORT_AYAR
;	MOVLW	    0x01
;	MOVWF	    ONLAR
;	CLRF	    BIRLER
;	MOVLW	    0x01
;	MOVWF	    SIRA
;DD
;	
;	GOTO	DD
;	END
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	;;;EMIN SORU
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'
;	
;BIRLER	    EQU	0x20
;ONLAR	    EQU	0x21
;SIRA	    EQU	0x22
;
;W_TEMP	    EQU	0x7D
;STATUS_TEMP EQU	0x7E
;PCLATH_TEMP EQU	0x7F
; 
;    ORG	0x000
;    NOP	
;    GOTO     BASLA
; ;**********************************************************************
;    ORG	0x004
;    MOVWF   W_TEMP
;    MOVF    STATUS,W
;    MOVWF   STATUS_TEMP
;    MOVF    PCLATH,W
;    MOVWF   PCLATH_TEMP
;    
;    MOVLW   0x06
;    MOVWF   TMR0
;    BCF	    INTCON,T0IF
;    CALL    ISLEM_TMR0
;    
; 
;    	
;    BTFSS   INTCON,INTF	    ;++
;    GOTO    CIK
;    CALL    ISLEM_RB0
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
;;*****************************************************************
;ISLEM_RB0
;    BCF	    INTCON,INTF
;    INCF    BIRLER,1
;    MOVLW   0x0A
;    SUBWF   BIRLER,0
;    BTFSS   STATUS,Z
;    RETURN
;    CLRF    BIRLER
;    INCF    ONLAR,1
;    MOVLW   0x0A
;    SUBWF   ONLAR,0
;    BTFSC   STATUS,Z
;    CLRF    ONLAR
;    
;    RETURN
; ;*****************************************************************
;ISLEM_RB00
;    BTFSS   PORTA,2
;    RETURN
;    DECF    BIRLER,1
;    MOVLW   0xFF
;    SUBWF   BIRLER,0
;    BTFSS   STATUS,Z
;    RETFIE
;    
;    MOVLW   0x09
;    MOVWF   BIRLER
;    
;    DECF    ONLAR,1
;    MOVLW   0xFF
;    SUBWF   ONLAR,0
;    BTFSS   STATUS,Z
;    RETFIE
;    
;    MOVLW   0x09
;    MOVWF   ONLAR
;    RETFIE
; ;******************************************************************
;ISLEM_TMR0
;    BTFSS	SIRA,0
;    GOTO	ON
; 
;    MOVLW	B'00000010'
;    MOVWF	PORTA
;    MOVF	BIRLER,W
;    CALL	LOOKUP
;    MOVWF	PORTC
;    INCF	SIRA,1
;    RETURN
;    
;ON
;    MOVLW	B'00000001'
;    MOVWF	PORTA
;    MOVF	ONLAR,W
;    CALL	LOOKUP
;    MOVWF	PORTC
;    DECF	SIRA,1
;    RETURN  
; ;****************************************************************
; LOOKUP
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
;  ;**********************************************************
;KESME_AYAR
;    MOVLW	B'10110000'
;    MOVWF	INTCON
;    
;    BANKSEL	OPTION_REG
;    MOVLW	B'00000011'
;    MOVWF	OPTION_REG
;    
;    BANKSEL	TMR0
;    MOVLW	0x06
;    MOVWF	TMR0
;    RETURN
;;***************************************************************
;PORT_AYAR
;    BANKSEL	ADCON1
;    MOVLW	0x06
;    MOVWF	ADCON1
;    
;    BANKSEL	TRISA
;    MOVLW	B'00111000'
;    MOVWF	TRISA
;    
;    MOVLW	B'00000001'
;    MOVWF	TRISB
;    CLRF	TRISC
;    
;    BANKSEL	PORTA
;    CLRF	PORTA
;    CLRF	PORTB
;    CLRF	PORTC   
;    
;    RETURN
;;******************************************************************
;BASLA	
;   CALL	    KESME_AYAR
;   CALL	    PORT_AYAR
;   CLRF	    BIRLER
;   CLRF	    ONLAR
;   MOVLW    0x01
;   MOVWF    SIRA
;   
; DD 
;    	    ;--
;    CALL    ISLEM_RB00
;    GOTO    DD
;   END
;	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
;	;99 GERI 2 SER 2SER AZALTAN UYGULAMA RBO ILE
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'
;SIRA	    EQU	0x20
;BIRLER	    EQU	0x21
;ONLAR	    EQU	0x22    
;
;W_TEMP	    EQU	0x7D
;STATUS_TEMP EQU	0x7E
;PCLATH_TEMP EQU	0x7F
; 
;    ORG	0x000
;    NOP
;    GOTO    BASLA
;;********************************************************
;    ORG	0x004
;	MOVWF	    W_TEMP
;	MOVF	    STATUS,W
;	MOVWF	    STATUS_TEMP
;	MOVF	    PCLATH,W
;	MOVWF	    PCLATH_TEMP
;	
;	MOVLW	    0x06
;	MOVWF	    TMR0
;	BCF	    INTCON,T0IF
;	CALL	    ISLEM_TMR0
;	
;	BTFSS	    INTCON,INTF
;	GOTO	    CIK
;	BCF	    INTCON,INTF
;	CALL	    ISLEM_RB0
;	
;	
;CIK
;	BSF	    INTCON,GIE
;	MOVF	    PCLATH_TEMP,W
;	MOVWF	    PCLATH
;	MOVF	    STATUS_TEMP,W
;	MOVWF	    STATUS
;	SWAPF	    W_TEMP,1
;	SWAPF	    W_TEMP,0
;	RETFIE
;;***********************************************************
;ISLEM_RB0
;	MOVLW	    0x02
;	SUBWF	    BIRLER,1
;	MOVLW	    0xFF
;;	MOVLW	    0xFE
;	SUBWF	    BIRLER,0
;	BTFSS	    STATUS,Z
;	RETURN
;	
;	MOVLW	    0x09
;;	MOVLW	    0x08
;	MOVWF	    BIRLER
;	DECF	    ONLAR,1
;	MOVLW	    0xFF
;	SUBWF	    ONLAR,0
;	BTFSS	    STATUS,Z
;	RETURN
;	MOVLW	    0x09
;	MOVWF	    ONLAR
;	RETURN
;;************************************************************
;ISLEM_TMR0
;	BTFSS	    SIRA,0
;	GOTO	    ON
;	
;	MOVLW	    B'00000010'
;	MOVWF	    PORTA
;	MOVF	    BIRLER,W
;	CALL	    LOOKUP
;	MOVWF	    PORTC
;	INCF	    SIRA,1
;	RETURN
;ON
;	MOVLW	    B'00000001'
;	MOVWF	    PORTA
;	MOVF	    ONLAR,W
;	CALL	    LOOKUP
;	MOVWF	    PORTC
;	DECF	    SIRA,1
;	RETURN
;;******************************************************
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
;;**********************************************************
;KESME_AYAR
;	MOVLW	    B'10110000'
;	MOVWF	    INTCON
;	BANKSEL	    OPTION_REG
;	MOVLW	    B'00000011'
;	MOVWF	    OPTION_REG
;	
;	BANKSEL	    TMR0
;	MOVLW	    0x06
;	MOVWF	    TMR0
;	RETURN
;;*******************************************************
;PORT_AYAR
;	BANKSEL	    ADCON1
;	MOVLW	    0x06
;	MOVWF	    ADCON1
;	
;	BANKSEL	    TRISA
;	MOVLW	    B'00111100'  ;;;;;;;0 VE 1 i KARISTIRMA
;	MOVWF	    TRISA
;	
;	MOVLW	    B'00000001'
;	MOVWF	    TRISB
;	CLRF	    TRISC
;	
;	BANKSEL	    PORTA
;	CLRF	    PORTA
;	CLRF	    PORTB
;	CLRF	    PORTC
;	
;	RETURN
;;************************************************************
;BASLA
;	CALL	    KESME_AYAR
;	CALL	    PORT_AYAR
;	MOVLW	    0x09
;	MOVWF	    ONLAR
;	MOVLW	    0x09
;;	MOVLW	    0x08
;	MOVWF	    BIRLER
;	MOVLW	    0x01
;	MOVWF	    SIRA
;DD  
;	GOTO	    DD
;	END
	
	
	
	
	
	
	
	
	
	
;	;RB0 BUTTONUNA HER BASILDIGINDA E HARFINI 1sn YANIP SONAN UYGULAMA
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'
;SAYI	    EQU	0x20
;
;W_TEMP	    EQU	0x7D
;STATUS_TEMP EQU	0x7E
;PCLATH_TEMP EQU	0x7F
; 
;    ORG	0x000
;    NOP
;    GOTO    BASLA
;;********************************************************
;    ORG	0x004
;	MOVWF	    W_TEMP
;	MOVF	    STATUS,W
;	MOVWF	    STATUS_TEMP
;	MOVF	    PCLATH,W
;	MOVWF	    PCLATH_TEMP
;	
;	MOVLW	    0x06
;	MOVWF	    TMR0
;	BCF	    INTCON,T0IF
;	
;	DECFSZ	    SAYI,1
;	RETFIE
;;	INCF	    SAYI,1
;	CALL	    ISLEM_TMR0
;	
;	BTFSS	    INTCON,INTF
;	GOTO	    CIK
;	BCF	    INTCON,INTF
;	CALL	    ISLEM_RB0
;	
;	
;CIK
;	BSF	    INTCON,GIE
;	MOVF	    PCLATH_TEMP,W
;	MOVWF	    PCLATH
;	MOVF	    STATUS_TEMP,W
;	MOVWF	    STATUS
;	SWAPF	    W_TEMP,1
;	SWAPF	    W_TEMP,0
;	RETFIE
;;***********************************************************
;ISLEM_RB0
;	MOVLW	    0xFA
;	MOVWF	    SAYI
;		
;	MOVLW	    B'00000010'
;	MOVWF	    PORTA
;	MOVLW	    B'01111001'
;	MOVWF	    PORTC
;	RETURN
;;************************************************************
;ISLEM_TMR0
;	CLRF	    PORTC
;	RETURN
;;******************************************************
;KESME_AYAR
;	MOVLW	    B'10110000'
;	MOVWF	    INTCON
;	BANKSEL	    OPTION_REG
;	MOVLW	    B'00000011'
;	MOVWF	    OPTION_REG
;	
;	BANKSEL	    TMR0
;	MOVLW	    0x06
;	MOVWF	    TMR0
;	RETURN
;;*******************************************************
;PORT_AYAR
;	BANKSEL	    ADCON1
;	MOVLW	    0x06
;	MOVWF	    ADCON1
;	
;	BANKSEL	    TRISA
;	MOVLW	    B'00111100'  ;;;;;;;0 VE 1 i KARISTIRMA
;	MOVWF	    TRISA
;	
;	MOVLW	    B'00000001'
;	MOVWF	    TRISB
;	CLRF	    TRISC
;	
;	BANKSEL	    PORTA
;	CLRF	    PORTA
;	CLRF	    PORTB
;	CLRF	    PORTC
;	
;	RETURN
;;************************************************************
;BASLA
;	CALL	    KESME_AYAR
;	CALL	    PORT_AYAR
;	MOVLW	    0xFA
;	MOVWF	    SAYI
;	
;DD  
;	GOTO	    DD
;	END
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
;	  ;RB0 KESMESINDE SIRASIYLA 0. VE 1. LEDLERI YAKAN VE DIGERINI SONDUREN UYGULAMA	
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'
;SAYI	    EQU	0x20
;SIRA	    EQU	0x21
;
;
;W_TEMP	    EQU	0x7D
;STATUS_TEMP EQU	0x7E
;PCLATH_TEMP EQU	0x7F
; 
;    ORG	0x000
;    NOP
;    GOTO    BASLA
;;********************************************************
;    ORG	0x004
;	MOVWF	    W_TEMP
;	MOVF	    STATUS,W
;	MOVWF	    STATUS_TEMP
;	MOVF	    PCLATH,W
;	MOVWF	    PCLATH_TEMP
;
;	
;	BTFSS	    INTCON,INTF
;	GOTO	    CIK
;	BCF	    INTCON,INTF
;	CALL	    ISLEM_RB0
;CIK
;	BSF	    INTCON,GIE
;	MOVF	    PCLATH_TEMP,W
;	MOVWF	    PCLATH
;	MOVF	    STATUS_TEMP,W
;	MOVWF	    STATUS
;	SWAPF	    W_TEMP,1
;	SWAPF	    W_TEMP,0
;	RETFIE
;;***********************************************************
;ISLEM_RB0
;	MOVLW	    B'00000011'	;;;;;;;;;;;;;;;;;;;;xor lamak istedigin yere farkl? rakam ver
;	XORWF	    SAYI	;XORWF YANLIS YAZMA
;	RETURN
;;************************************************************
;YAK
;	MOVF	    SAYI,W
;	MOVWF	    PORTC
;	RETURN
;;******************************************************
;KESME_AYAR
;	MOVLW	    B'10010000'
;	MOVWF	    INTCON
;	BANKSEL	    OPTION_REG
;	MOVLW	    B'00000000'
;	MOVWF	    OPTION_REG
;	
;
;	RETURN
;;*******************************************************
;PORT_AYAR
;	BANKSEL	    TRISA
;	MOVLW	    B'00000001'
;	MOVWF	    TRISB
;	CLRF	    TRISC
;	
;	BANKSEL	    PORTA
;	CLRF	    PORTB
;	CLRF	    PORTC
;	
;	RETURN
;;************************************************************
;BASLA
;	CALL	    KESME_AYAR
;	CALL	    PORT_AYAR
;	MOVLW	    B'00000001'
;	MOVWF	    SAYI
;DD  
;	CALL	    YAK
;	GOTO	    DD
;	END
	
	
	
	
	
	;;RB1 BASINCA PORTC BUTUN LEDLERI YAKAN RB0 KESMESINDE SONDUREN UYGULAMA
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'
;SAYI	    EQU	0x20
;SIRA	    EQU	0x21
;
;
;W_TEMP	    EQU	0x7D
;STATUS_TEMP EQU	0x7E
;PCLATH_TEMP EQU	0x7F
; 
;    ORG	0x000
;    NOP
;    GOTO    BASLA
;;********************************************************
;    ORG	0x004
;	MOVWF	    W_TEMP
;	MOVF	    STATUS,W
;	MOVWF	    STATUS_TEMP
;	MOVF	    PCLATH,W
;	MOVWF	    PCLATH_TEMP
;	
;	MOVLW	    0x06
;	MOVWF	    TMR0
;	BCF	    INTCON,T0IF
;	BTFSC	    PORTB,1
;	CALL	    ISLEM_TMR0
;	
;	BTFSS	    INTCON,INTF
;	GOTO	    CIK
;	BCF	    INTCON,INTF
;	CALL	    ISLEM_RB0
;CIK
;	BSF	    INTCON,GIE
;	MOVF	    PCLATH_TEMP,W
;	MOVWF	    PCLATH
;	MOVF	    STATUS_TEMP,W
;	MOVWF	    STATUS
;	SWAPF	    W_TEMP,1
;	SWAPF	    W_TEMP,0
;	RETFIE
;;***********************************************************
;ISLEM_RB0
;	CLRF	    SAYI
;	RETURN
;;***********************************************************
;ISLEM_TMR0
;	MOVLW	    0xFF
;	MOVWF	    SAYI
;	RETURN
;;************************************************************
;YAK
;	MOVF	    SAYI,W
;	MOVWF	    PORTC
;	RETURN
;;******************************************************
;KESME_AYAR
;	MOVLW	    B'10110000'
;	MOVWF	    INTCON
;	BANKSEL	    OPTION_REG
;	MOVLW	    B'00000011'
;	MOVWF	    OPTION_REG
;	
;	BANKSEL	    TMR0
;	MOVLW	    0x06
;	MOVWF	    TMR0
;	RETURN
;;*******************************************************
;PORT_AYAR
;	BANKSEL	    TRISA
;	MOVLW	    B'00000001'
;	MOVWF	    TRISB
;	CLRF	    TRISC
;	
;	BANKSEL	    PORTA
;	CLRF	    PORTB
;	CLRF	    PORTC
;	
;	RETURN
;;************************************************************
;BASLA
;	CALL	    KESME_AYAR
;	CALL	    PORT_AYAR
;	CLRF	    SAYI
;DD  
;	CALL	    YAK
;	GOTO	    DD
;	END
	
	
	
;;RB0 BUTTONUNA BASINCA YANAN BASINCA SONEN UYGULAMA
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'
;SAYI	    EQU	0x20
;SIRA	    EQU	0x21
;
;
;W_TEMP	    EQU	0x7D
;STATUS_TEMP EQU	0x7E
;PCLATH_TEMP EQU	0x7F
; 
;    ORG	0x000
;    NOP
;    GOTO    BASLA
;;********************************************************
;    ORG	0x004
;	MOVWF	    W_TEMP
;	MOVF	    STATUS,W
;	MOVWF	    STATUS_TEMP
;	MOVF	    PCLATH,W
;	MOVWF	    PCLATH_TEMP
;	
;	BCF	    INTCON,INTF
;	CALL	    ISLEM_RB0
;CIK
;	BSF	    INTCON,GIE
;	MOVF	    PCLATH_TEMP,W
;	MOVWF	    PCLATH
;	MOVF	    STATUS_TEMP,W
;	MOVWF	    STATUS
;	SWAPF	    W_TEMP,1
;	SWAPF	    W_TEMP,0
;	RETFIE
;;***********************************************************
;ISLEM_RB0
;	MOVLW	    B'00000001'	    ;X0R'LAMAK ISTEDIGIN YERE 1 VERMEK LAZIM
;	XORWF	    SAYI,1
;	RETURN
;;************************************************************
;YAK
;	MOVF	    SAYI,W
;	MOVWF	    PORTC
;	RETURN
;;******************************************************
;KESME_AYAR
;	MOVLW	    B'10010000'
;	MOVWF	    INTCON
;	BCF	    OPTION_REG,INTEDG
;	
;	BANKSEL	    TMR0
;	MOVLW	    0x06
;	MOVWF	    TMR0
;	RETURN
;;*******************************************************
;PORT_AYAR
;;	BANKSEL	    ADCON1
;;	MOVLW	    0x06
;;	MOVWF	    ADCON1
;	
;	BANKSEL	    TRISA
;	MOVLW	    B'00000001'
;	MOVWF	    TRISB
;	CLRF	    TRISC
;	
;	BANKSEL	    PORTA
;	CLRF	    PORTB
;	CLRF	    PORTC
;	
;	RETURN
;;************************************************************
;BASLA
;	CALL	    KESME_AYAR
;	CALL	    PORT_AYAR
;	MOVLW	    0x01
;	MOVWF	    SAYI
;
;DD  
;	CALL	    YAK
;	GOTO	    DD
;	END
		
	
	;;KARASIMSEK UYGULAMASI RB0 ILE
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'
;SAYI	    EQU	0x20
;SIRA	    EQU	0x21
;
;
;W_TEMP	    EQU	0x7D
;STATUS_TEMP EQU	0x7E
;PCLATH_TEMP EQU	0x7F
; 
;    ORG	0x000
;    NOP
;    GOTO    BASLA
;;********************************************************
;    ORG	0x004
;	MOVWF	    W_TEMP
;	MOVF	    STATUS,W
;	MOVWF	    STATUS_TEMP
;	MOVF	    PCLATH,W
;	MOVWF	    PCLATH_TEMP
;	
;	BCF	    INTCON,INTF
;	CALL	    ISLEM_RB0
;CIK
;	BSF	    INTCON,GIE
;	MOVF	    PCLATH_TEMP,W
;	MOVWF	    PCLATH
;	MOVF	    STATUS_TEMP,W
;	MOVWF	    STATUS
;	SWAPF	    W_TEMP,1
;	SWAPF	    W_TEMP,0
;	RETFIE
;;***********************************************************
;ISLEM_RB0
;	BTFSS	    SIRA,1
;	GOTO	    SOL
;	GOTO	    SAG
;SOL
;	BCF	    STATUS,C
;	RLF	    SAYI,1
;	BTFSC	    PORTC,6	;;;;;;;;;;
;	INCF	    SIRA,1
;	RETURN
;SAG
;	BCF	    STATUS,C
;	RRF	    SAYI,1
;	BTFSC	    PORTC,1	;;;;;;;;;;;;;;;;;;
;	DECF	    SIRA,1
;	RETURN
;;************************************************************
;YAK
;	MOVF	    SAYI,W
;	MOVWF	    PORTC
;	RETURN
;;******************************************************
;KESME_AYAR
;	MOVLW	    B'10010000'
;	MOVWF	    INTCON
;	BCF	    OPTION_REG,INTEDG
;	
;	BANKSEL	    TMR0
;	MOVLW	    0x06
;	MOVWF	    TMR0
;	RETURN
;;*******************************************************
;PORT_AYAR
;	BANKSEL	    ADCON1
;	MOVLW	    0x06
;	MOVWF	    ADCON1
;	
;	BANKSEL	    TRISA
;	MOVLW	    B'00000001'
;	MOVWF	    TRISB
;	CLRF	    TRISC
;	
;	BANKSEL	    PORTA
;	CLRF	    PORTB
;	CLRF	    PORTC
;	
;	RETURN
;;************************************************************
;BASLA
;	CALL	    KESME_AYAR
;	CALL	    PORT_AYAR
;	MOVLW	    0x03
;	MOVWF	    SAYI
;	MOVLW	    0x01
;	MOVWF	    SIRA
;DD  
;	CALL	    YAK
;	GOTO	    DD
;	END
	
	
	
	
	
	
;;10-0 KADAR SAYAN KOD 
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'
;BIRLER	    EQU	0x20
;ONLAR	    EQU	0x21
;SIRA	    EQU	0x22
;
;W_TEMP	    EQU	0x7D
;STATUS_TEMP EQU	0x7E
;PCLATH_TEMP EQU	0x7F
; 
;    ORG	0x000
;    NOP
;    GOTO    BASLA
;;********************************************************
;    ORG	0x004
;	MOVWF	    W_TEMP
;	MOVF	    STATUS,W
;	MOVWF	    STATUS_TEMP
;	MOVF	    PCLATH,W
;	MOVWF	    PCLATH_TEMP
;	
;	CALL	    ISLEM_TMR0
;	BCF	    INTCON,T0IF
;	MOVLW	    0x06
;	MOVWF	    TMR0
;	
;	
;	BTFSS	    INTCON,INTF
;	GOTO	    CIK
;	BCF	    INTCON,INTF
;	CALL	    ISLEM_RB0
;	
;
;CIK
;	BSF	    INTCON,GIE
;	MOVF	    PCLATH_TEMP,W
;	MOVWF	    PCLATH
;	MOVF	    STATUS_TEMP,W
;	MOVWF	    STATUS
;	SWAPF	    W_TEMP,1
;	SWAPF	    W_TEMP,0
;	RETFIE
;;***********************************************************
;ISLEM_RB0
;	DECF	    BIRLER,1
;	MOVLW	    0xFF
;	SUBWF	    BIRLER,0
;	BTFSS	    STATUS,Z
;	RETURN
;	
;	CLRF	    BIRLER
;	MOVLW	    0x09
;	MOVWF	    BIRLER
;	
;	DECF	    ONLAR,1
;	MOVLW	    0xFF
;	SUBWF	    ONLAR,0
;	BTFSS	    STATUS,Z	    ;;;;;;;;;
;	RETURN
;	GOTO	    BASLA
;	
;;************************************************************
;ISLEM_TMR0
;	BTFSS	    SIRA,0
;	GOTO	    ON		   
;	
;	MOVLW	    B'00000010'
;	MOVWF	    PORTA
;	MOVF	    BIRLER,W
;	CALL	    LOOKUP
;	MOVWF	    PORTC
;	INCF	    SIRA,1
;	RETURN
;ON
;	MOVLW	    B'00000001'
;	MOVWF	    PORTA
;	MOVF	    ONLAR,W
;	CALL	    LOOKUP
;	MOVWF	    PORTC
;	DECF	    SIRA,1
;	RETURN
;;**********************************************************
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
;;******************************************************
;KESME_AYAR
;	MOVLW	    B'10110000'
;	MOVWF	    INTCON
;	
;	BANKSEL	    OPTION_REG
;	MOVLW	    B'00000100'
;	MOVWF	    OPTION_REG
;	
;	BANKSEL	    TMR0
;	MOVLW	    0x06
;	MOVWF	    TMR0
;	RETURN
;;*******************************************************
;PORT_AYAR
;	BANKSEL	    ADCON1
;	MOVLW	    0x06
;	MOVWF	    ADCON1
;	
;	BANKSEL	    TRISA
;	MOVLW	    B'00111100'
;	MOVWF	    TRISA
;	MOVLW	    B'00000001'
;	MOVWF	    TRISB
;	CLRF	    TRISC
;	
;	BANKSEL	    PORTA
;	CLRF	    PORTB
;	CLRF	    PORTC
;	CLRF	    PORTA
;	
;	RETURN
;;************************************************************
;BASLA
;	CALL	    KESME_AYAR
;	CALL	    PORT_AYAR
;	MOVLW	    0x01
;	MOVWF	    SIRA
;	MOVLW	    0x01
;	MOVWF	    ONLAR
;	CLRF	    BIRLER
;	
;DD  
;	GOTO	    DD
;
;	END
	
	
	
	
	
	
	
	
	
	
	
	
;;;0-10 KADAR SAYAN KOD (DEVAM)
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'
;BIRLER	    EQU	0x20
;ONLAR	    EQU	0x21
;SIRA	    EQU	0x22
;
;W_TEMP	    EQU	0x7D
;STATUS_TEMP EQU	0x7E
;PCLATH_TEMP EQU	0x7F
; 
;    ORG	0x000
;    NOP
;    GOTO    BASLA
;;********************************************************
;    ORG	0x004
;	MOVWF	    W_TEMP
;	MOVF	    STATUS,W
;	MOVWF	    STATUS_TEMP
;	MOVF	    PCLATH,W
;	MOVWF	    PCLATH_TEMP
;	
;	CALL	    ISLEM_TMR0
;	BCF	    INTCON,T0IF
;	MOVLW	    0x06
;	MOVWF	    TMR0
;	
;	
;	BTFSS	    INTCON,INTF
;	GOTO	    CIK
;	BCF	    INTCON,INTF
;	CALL	    ISLEM_RB0
;	
;
;CIK
;	BSF	    INTCON,GIE
;	MOVF	    PCLATH_TEMP,W
;	MOVWF	    PCLATH
;	MOVF	    STATUS_TEMP,W
;	MOVWF	    STATUS
;	SWAPF	    W_TEMP,1
;	SWAPF	    W_TEMP,0
;	RETFIE
;;***********************************************************
;ISLEM_RB0
;	BTFSC	    ONLAR,0
;	GOTO	    SIFIR	;;;;;;;;;;KESMEDEN CIKMAK ICIN KULLANDIM
;	INCF	    BIRLER,1
;	MOVLW	    0x0A
;	SUBWF	    BIRLER,0
;	BTFSS	    STATUS,Z
;	RETURN
;	
;
;	CLRF	    BIRLER
;	INCF	    ONLAR,1
;	MOVLW	    0x0A
;	SUBWF	    ONLAR,0
;	BTFSC	    STATUS,Z	    ;;;;;;;;;
;	CLRF	    ONLAR
;	RETURN
;	
;SIFIR
;	CLRF	    ONLAR
;	CLRF	    BIRLER
;	RETURN
;;************************************************************
;ISLEM_TMR0
;	BTFSS	    SIRA,0
;	GOTO	    ON
;	
;	MOVLW	    B'00000010'
;	MOVWF	    PORTA
;	MOVF	    BIRLER,W
;	CALL	    LOOKUP
;	MOVWF	    PORTC
;	INCF	    SIRA,1
;	RETURN
;ON
;	MOVLW	    B'00000001'
;	MOVWF	    PORTA
;	MOVF	    ONLAR,W
;	CALL	    LOOKUP
;	MOVWF	    PORTC
;	DECF	    SIRA,1
;	RETURN
;;**********************************************************
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
;;******************************************************
;KESME_AYAR
;	MOVLW	    B'10110000'
;	MOVWF	    INTCON
;	
;	BANKSEL	    OPTION_REG
;	MOVLW	    B'00000100'
;	MOVWF	    OPTION_REG
;	
;	BANKSEL	    TMR0
;	MOVLW	    0x06
;	MOVWF	    TMR0
;	RETURN
;;*******************************************************
;PORT_AYAR
;	BANKSEL	    ADCON1
;	MOVLW	    0x06
;	MOVWF	    ADCON1
;	
;	BANKSEL	    TRISA
;	MOVLW	    B'00111100'
;	MOVWF	    TRISA
;	MOVLW	    B'00000001'
;	MOVWF	    TRISB
;	CLRF	    TRISC
;	
;	BANKSEL	    PORTA
;	CLRF	    PORTB
;	CLRF	    PORTC
;	CLRF	    PORTA
;	
;	RETURN
;;************************************************************
;BASLA
;	CALL	    KESME_AYAR
;	CALL	    PORT_AYAR
;	MOVLW	    0x01
;	MOVWF	    SIRA
;	CLRF	    ONLAR
;	CLRF	    BIRLER
;	
;DD  
;	GOTO	    DD
;	END
	
	
	
	
	
    
;;RB0 KESMESINDE SOLA KAYAN LED UYGULAMADI
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'
;
;SAYI	    EQU	0x20
;	
;W_TEMP	    EQU	0x7D
;STATUS_TEMP EQU	0x7E
;PCLATH_TEMP EQU	0x7F
; 
; ORG	0x000
; NOP
; GOTO	    BASLA
;;******************************************************************
;    ORG	0x004
;	MOVWF   W_TEMP
;	MOVF    STATUS,W
;	MOVWF   STATUS_TEMP
;	MOVF    PCLATH,W
;	MOVWF   PCLATH_TEMP
;	 
;	BCF	INTCON,INTF
;	CALL    ISLEM_RB0
;    
;CIK
;	BSF	INTCON,GIE
;	MOVF    PCLATH_TEMP,W
;	MOVWF   PCLATH
;	MOVF    STATUS_TEMP,W
;	MOVWF   STATUS
;	SWAPF   W_TEMP,1
;	SWAPF   W_TEMP,0
;	RETFIE
;;**********************************************
;ISLEM_RB0
;	BCF	    STATUS,C
;	RLF	    SAYI,1
;	BTFSS	    PORTC,7
;	RETURN
;	MOVLW	    0x01
;	MOVWF	    SAYI
;	RETURN
;YAK
;	MOVF	    SAYI,W
;	MOVWF	    PORTC
;	RETURN
;;******************************
;KESME_AYAR
;	MOVLW   B'10010000'
;	MOVWF   INTCON
;    
;	BANKSEL OPTION_REG
;	BCF	OPTION_REG,INTEDG
;    
;	RETURN
; ;*****************************************************
;PORT_AYAR
;	BANKSEL TRISB
;	MOVLW	B'00000001'
;	MOVWF	TRISB
;	CLRF    TRISC
;    
;	BANKSEL PORTB
;	CLRF    PORTB
;	CLRF    PORTC
;	RETURN
; ;***************************************************
;BASLA
;	CALL    KESME_AYAR
;	CALL    PORT_AYAR
;	MOVLW	B'00000001'
;	MOVWF	SAYI
;    
;DD  
;	CALL	YAK
;	GOTO    DD
;    END
 
	
	
	
	
	
  
       
;;;RB0 BUTTONUNA HER BASILDIGINDA E HARFINI 750 ms YANIP SONAN UYGULAMA
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'
;	
;TMR0_SN		EQU	0x20
;SAYI		EQU	0x21
;
;W_TEMP		EQU	0x7D
;STATUS_TEMP	EQU	0x7E
;PCLATH_TEMP	EQU	0x7F
;;*************************************************************
;	ORG	0x000
;	NOP
;	GOTO	    BASLA
;;************************************************************
;	ORG	0x004
;	MOVWF	    W_TEMP
;	MOVF	    STATUS,W
;	MOVWF	    STATUS_TEMP
;	MOVF	    PCLATH,W
;	MOVWF	    PCLATH_TEMP
;	
;	BCF	    INTCON,T0IF
;	MOVLW	    0x06
;	MOVWF	    TMR0
;	
;	DECFSZ	    TMR0_SN,1
;	RETFIE
;	CALL	    ISLEM_TMR0
;	
;	BTFSS	    INTCON,INTF
;	GOTO	    CIK
;	BCF	    INTCON,INTF
;	CALL	    ISLEM_RB0
;	
;	
;CIK
;	BSF	    INTCON,GIE
;	MOVF	    PCLATH_TEMP,W
;	MOVWF	    PCLATH
;	MOVF	    STATUS_TEMP,W
;	MOVWF	    STATUS
;	SWAPF	    W_TEMP,1
;	SWAPF	    W_TEMP,W
;	   retfie
;;*************************************************************
;ISLEM_RB0
;	MOVLW	    0xBB
;	MOVWF	    TMR0_SN
;	MOVLW	    B'00000010'
;	MOVWF	    PORTA
;	MOVLW	    B'01111001'
;	MOVWF	    PORTC
;	RETURN
;;************************************************************
;ISLEM_TMR0
;	
;	CLRF	    PORTC
;	RETURN
;;*************************************************************
;KESME_AYAR
;	MOVLW	    B'10110000'
;	MOVWF	    INTCON
;	
;	BANKSEL	    OPTION_REG
;	MOVLW	    B'00000011'
;	MOVWF	    OPTION_REG
;	BCF	    OPTION_REG,INTEDG
;	
;	BANKSEL	    TMR0
;	MOVLW	    0x06
;	MOVWF	    TMR0
;	RETURN	    
;;**************************************************************
;PORT_AYAR
;	BANKSEL	    ADCON1
;	MOVLW	    0x06
;	MOVWF	    ADCON1
;	
;	BANKSEL	    TRISA
;	MOVLW	    B'00111100'
;	MOVWF	    TRISA
;	
;	MOVLW	    B'00000001'
;	MOVWF	    TRISB
;	
;	CLRF	    TRISC
;	
;	BANKSEL	    PORTA
;	CLRF	    PORTA
;	CLRF	    PORTB
;	CLRF	    PORTC	
;	RETURN
;;***********************************************************
;BASLA
;	CALL	    KESME_AYAR
;	CALL	    PORT_AYAR
;	
;;	CLRF	    SAYI
;	MOVLW	    0x01
;	MOVWF	    TMR0_SN
;	
;DD
;	GOTO	    DD
;	END
   
    
    
    
;   ;; RB0 KESMESINDE SIRASIYLA 0. VE 1. LEDLERI YAKAN VE DIGERINI SONDUREN UYGULAMA	
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'
;	
;TMR0_SN		EQU	0x20
;SAYI		EQU	0x21
;
;W_TEMP		EQU	0x7D
;STATUS_TEMP	EQU	0x7E
;PCLATH_TEMP	EQU	0x7F
;;*************************************************************
;	ORG	0x000
;	NOP
;	GOTO	    BASLA
;;************************************************************
;	ORG	0x004
;	MOVWF	    W_TEMP
;	MOVF	    STATUS,W
;	MOVWF	    STATUS_TEMP
;	MOVF	    PCLATH,W
;	MOVWF	    PCLATH_TEMP
;	
;	BTFSS	    INTCON,INTF
;	GOTO	    CIK
;	BCF	    INTCON,INTF
;	CALL	    ISLEM_RB0
;		
;CIK
;	BSF	    INTCON,GIE
;	MOVF	    PCLATH_TEMP,W
;	MOVWF	    PCLATH
;	MOVF	    STATUS_TEMP,W
;	MOVWF	    STATUS
;	SWAPF	    W_TEMP,1
;	SWAPF	    W_TEMP,W
;	RETFIE
;;*************************************************************
;ISLEM_RB0
;	BTFSC	    PORTC,0
;	GOTO	    DIGER
;	
;	MOVLW	    B'00000001'
;	MOVWF	    PORTC
;	RETURN
;DIGER
;	MOVLW	    B'00000010'
;	MOVWF	    PORTC
;	RETURN
;;************************************************************
;KESME_AYAR
;	MOVLW	    B'10010000'
;	MOVWF	    INTCON
;	
;	BANKSEL	    OPTION_REG
;	BCF	    OPTION_REG,INTEDG
;	
;	RETURN	    
;;**************************************************************
;PORT_AYAR
;	BANKSEL	    TRISB
;	MOVLW	    B'00000001'
;	MOVWF	    TRISB
;	
;	CLRF	    TRISC
;	
;	BANKSEL	    PORTB
;	CLRF	    PORTB
;	CLRF	    PORTC	
;	RETURN
;;***********************************************************
;BASLA
;	CALL	    KESME_AYAR
;	CALL	    PORT_AYAR
;	BSF	    PORTC,0
;DD
;	GOTO	    DD
;	END
    
    
    
    
    
    
    
    
    
    
    
    ;;ODEV GRUP
;	list		p=16f877A	
;	#include	<p16f877A.inc>
;DEGISKEN1  EQU 0X20
;DEGISKEN2 EQU 0X21
;SAYAC EQU 0X22
;TEMP  EQU 0X23
;
;	ORG  0x000
;	goto  BASLA
;	ORG 0X04
; 
;    BTFSC INTCON,1
;    GOTO ARTIR
;
;    BCF INTCON, 2
;    MOVLW 0X06
;    MOVWF TMR0
;    BTFSC TEMP,0
;    GOTO YAKONLAR
;    GOTO YAKBIRLER
;    RETFIE
;
;;---------------------------------------
;ARTIR
;    BCF INTCON,1
;    BTFSS DEGISKEN1,3
;    GOTO BIRLERARTIR
;    BTFSS DEGISKEN1,0
;    GOTO BIRLERARTIR
;    GOTO ONLARARTIR
;    RETFIE
;;---------------------------------------
;BIRLERARTIR
;    INCF DEGISKEN1,1
;    RETFIE
;;---------------------------------------
;ONLARARTIR
;    INCF DEGISKEN2,1
;    CLRF DEGISKEN1
;    RETFIE
;;---------------------------------------
;YAKONLAR
;    MOVLW 0X2
;    MOVWF PORTA
;    MOVF DEGISKEN2,W
;    CALL LOOKUP
;    MOVWF PORTC
;    CLRF TEMP
;    RETFIE
;;---------------------------------------
;YAKBIRLER
;    MOVLW 0X1
;    MOVWF PORTA
;    MOVF DEGISKEN1,W
;    CALL LOOKUP
;    MOVWF PORTC
;    BSF TEMP,0
;    RETFIE
;;---------------------------------------
;LOOKUP
;    ADDWF PCL,F
;    retlw 0x3f
;    retlw 0x06
;    retlw 0x5b
;    retlw 0x4f
;    retlw 0x66
;    retlw 0x6d
;    retlw 0x7d
;    retlw 0x07
;    retlw 0x7f
;    retlw 0x6f
;;---------------------------------------
;BASLA
;    BANKSEL TRISB
;    MOVLW   0X01
;    MOVWF   TRISB
;    CLRF    TRISA
;    CLRF    TRISC
;    MOVLW   0X03
;    MOVWF   OPTION_REG
;;---------------------------------------
;    BANKSEL PORTA
;    CLRF    PORTB
;    CLRF    PORTA
;    CLRF    PORTC
;    MOVLW   0X06
;    MOVWF   TMR0
;    MOVLW   B'10110000'
;    MOVWF   INTCON
;    CLRF    DEGISKEN1
;    CLRF    DEGISKEN2
;    BSF	    TEMP,0
;Loop 
;   goto  Loop
;      END

    

	
	

;;RB1 BASINCA PORTC'DEKI TEK NOLU OLAN LEDLERI YAKAN RB0 KESMESINDE XOR'UNU ALAN UYGULAMA UYGULAMA	
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'
;	
;TMR0_SN		EQU	0x20
;SAYI		EQU	0x21
;
;W_TEMP		EQU	0x7D
;STATUS_TEMP	EQU	0x7E
;PCLATH_TEMP	EQU	0x7F
;;*************************************************************
;	ORG	0x000
;	NOP
;	GOTO	    BASLA
;;************************************************************
;	ORG	0x004
;	MOVWF	    W_TEMP
;	MOVF	    STATUS,W
;	MOVWF	    STATUS_TEMP
;	MOVF	    PCLATH,W
;	MOVWF	    PCLATH_TEMP
;	
;	MOVLW	    0x06
;	MOVWF	    TMR0
;	BCF	    INTCON,T0IF
;	
;	BTFSS	    INTCON,INTF
;	GOTO	    CIK
;	BCF	    INTCON,INTF
;	CALL	    ISLEM_RB0
;		
;CIK
;	BSF	    INTCON,GIE
;	MOVF	    PCLATH_TEMP,W
;	MOVWF	    PCLATH
;	MOVF	    STATUS_TEMP,W
;	MOVWF	    STATUS
;	SWAPF	    W_TEMP,1
;	SWAPF	    W_TEMP,W
;	RETFIE
;;*************************************************************
;ISLEM_RB0
;	MOVLW	    B'11111111'
;	XORWF	    PORTC
;	RETFIE
;;************************************************************
;YAK	   
;	BTFSS	    PORTB,1
;	RETURN
;	MOVLW	    B'01010101'
;	MOVWF	    PORTC
;	RETURN
;;*************************************************************
;KESME_AYAR
;	MOVLW	    B'10110000'
;	MOVWF	    INTCON
;	
;	BANKSEL	    OPTION_REG
;	MOVLW	    B'00000011'
;	MOVWF	    OPTION_REG
;	
;	BANKSEL	    TMR0
;	MOVLW	    0x06
;	MOVWF	    TMR0
;	RETURN	    
;;**************************************************************
;PORT_AYAR
;	BANKSEL	    TRISB
;	MOVLW	    B'00000001'
;	MOVWF	    TRISB
;	
;	CLRF	    TRISC
;	
;	BANKSEL	    PORTB
;	CLRF	    PORTB
;	CLRF	    PORTC	
;	RETURN
;;***********************************************************
;BASLA
;	CALL	    KESME_AYAR
;	CALL	    PORT_AYAR
;	CLRF	    SAYI
;
;DD
;	CALL	    YAK
;	GOTO	    DD
;	END
; 
	
;;RB1 BASINCA PORTC BUTUN LEDLERI YAKAN RB0 KESMESINDE SONDUREN UYGULAMA	
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'
;	
;TMR0_SN		EQU	0x20
;SAYI		EQU	0x21
;
;W_TEMP		EQU	0x7D
;STATUS_TEMP	EQU	0x7E
;PCLATH_TEMP	EQU	0x7F
;;*************************************************************
;	ORG	0x000
;	NOP
;	GOTO	    BASLA
;;************************************************************
;	ORG	0x004
;	MOVWF	    W_TEMP
;	MOVF	    STATUS,W
;	MOVWF	    STATUS_TEMP
;	MOVF	    PCLATH,W
;	MOVWF	    PCLATH_TEMP
;	
;	MOVLW	    0x06
;	MOVWF	    TMR0
;	BCF	    INTCON,T0IF
;	
;	
;	
;	BTFSS	    INTCON,INTF
;	GOTO	    CIK
;	BCF	    INTCON,INTF
;	CALL	    ISLEM_RB0
;		
;CIK
;	BSF	    INTCON,GIE
;	MOVF	    PCLATH_TEMP,W
;	MOVWF	    PCLATH
;	MOVF	    STATUS_TEMP,W
;	MOVWF	    STATUS
;	SWAPF	    W_TEMP,1
;	SWAPF	    W_TEMP,W
;	RETFIE
;;*************************************************************
;ISLEM_RB0
;	CLRF	    PORTC
;	RETFIE
;;************************************************************
;YAK	   
;	BTFSS	    PORTB,1
;	RETURN
;	MOVLW	    B'11111111'
;	MOVWF	    PORTC
;	RETURN
;;*************************************************************
;KESME_AYAR
;	MOVLW	    B'10110000'
;	MOVWF	    INTCON
;	
;	BANKSEL	    OPTION_REG
;	MOVLW	    B'00000011'
;	MOVWF	    OPTION_REG
;	
;	BANKSEL	    TMR0
;	MOVLW	    0x06
;	MOVWF	    TMR0
;	RETURN	    
;;**************************************************************
;PORT_AYAR
;	BANKSEL	    TRISB
;	MOVLW	    B'00000001'
;	MOVWF	    TRISB
;	
;	CLRF	    TRISC
;	
;	BANKSEL	    PORTB
;	CLRF	    PORTB
;	CLRF	    PORTC	
;	RETURN
;;***********************************************************
;BASLA
;	CALL	    KESME_AYAR
;	CALL	    PORT_AYAR
;	CLRF	    SAYI
;
;DD
;	CALL	    YAK
;	GOTO	    DD
;	END  
    
    
    
    
    
;  ;  RB0 BUTTONUNA HER BASILDIGINDA YANIP SONAN UYGULAMA
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'
;	
;TMR0_SN		EQU	0x20
;SAYI		EQU	0x21
;
;W_TEMP		EQU	0x7D
;STATUS_TEMP	EQU	0x7E
;PCLATH_TEMP	EQU	0x7F
;;*************************************************************
;	ORG	0x000
;	NOP
;	GOTO	    BASLA
;;************************************************************
;	ORG	0x004
;	MOVWF	    W_TEMP
;	MOVF	    STATUS,W
;	MOVWF	    STATUS_TEMP
;	MOVF	    PCLATH,W
;	MOVWF	    PCLATH_TEMP
;	
;	MOVLW	    0x06
;	MOVWF	    TMR0
;	BCF	    INTCON,T0IF
;	
;	BTFSS	    INTCON,INTF
;	GOTO	    CIK
;	BCF	    INTCON,INTF
;	CALL	    ISLEM_RB0
;	
;
;	
;CIK
;	BSF	    INTCON,GIE
;	MOVF	    PCLATH_TEMP,W
;	MOVWF	    PCLATH
;	MOVF	    STATUS_TEMP,W
;	MOVWF	    STATUS
;	SWAPF	    W_TEMP,1
;	SWAPF	    W_TEMP,W
;	RETFIE
;;*************************************************************
;ISLEM_RB0
;	MOVLW	    B'00000010'	;;;;;;;;;;
;	MOVWF	    PORTA	;;;;;;;;;
;	MOVF	    PORTC,W	;;;;;;
;	XORLW	    B'01001111'	;;;;;;;;;
;	MOVWF	    PORTC	;;;;;,,,,;,,,
;
;	RETURN
;;************************************************************
;ISLEM_TMR0
;	
;	RETURN
;;*************************************************************
;KESME_AYAR
;	MOVLW	    B'10110000'
;	MOVWF	    INTCON
;	
;	BANKSEL	    OPTION_REG
;	MOVLW	    B'00000011'
;	MOVWF	    OPTION_REG
;	
;	BANKSEL	    TMR0
;	MOVLW	    0x06
;	MOVWF	    TMR0
;	RETURN	    
;;**************************************************************
;PORT_AYAR
;	BANKSEL	    ADCON1
;	MOVLW	    0x06
;	MOVWF	    ADCON1
;	
;	BANKSEL	    TRISA
;	MOVLW	    B'00111100'
;	MOVWF	    TRISA
;	
;	MOVLW	    B'00000001'
;	MOVWF	    TRISB
;	
;	CLRF	    TRISC
;	
;	BANKSEL	    PORTA
;	CLRF	    PORTA
;	CLRF	    PORTB
;	CLRF	    PORTC	
;	RETURN
;;***********************************************************
;BASLA
;	CALL	    KESME_AYAR
;	CALL	    PORT_AYAR
;	
;	CLRF	    SAYI
;	MOVLW	    0xFA
;	MOVWF	    TMR0_SN
;DD
;	GOTO	DD
;	END
;	

	
	
	

	

	
	
	
	
	
	
; LAB ODEV= HER BUTTONA BASILDIGINDA 1 ARTAN SAYAC
	
;		list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG    H'3F31'
;	
;BIRLER			EQU	0x20
;ONLAR			EQU	0x21
;YAK			EQU	0x22
;
;w_temp			EQU	0x7D
;status_temp		EQU	0x7E
;pclath_temp		EQU	0x7F
;;******************************************************************
;	ORG	0x000
;	NOP
;	GOTO	BASLA
;
;;******************************************************************
;	ORG	0x004
;	MOVWF	    w_temp
;	MOVF	    STATUS,W
;	MOVWF	    status_temp
;	MOVF	    PCLATH,W
;	MOVWF	    pclath_temp
;	
;	CALL	    YAK_BIRLER	
;	BCF	    INTCON,T0IF
;
;	BTFSS	    INTCON,INTF
;	GOTO	    CIK
;	BCF	    INTCON,INTF
;	CALL	    ISLEM_RB0
;	
;CIK
;	BSF	    INTCON,GIE
;	MOVF	    pclath_temp,W
;	MOVWF	    PCLATH
;	MOVF	    status_temp,W
;	MOVWF	    STATUS
;	SWAPF	    w_temp,1
;	SWAPF	    w_temp,w
;	RETFIE
;;******************************************************************
;ISLEM_RB0
;	 MOVLW	    0x01
;	 MOVWF	    YAK
;	 
;	 BCF	    STATUS,Z
;	 INCF	    BIRLER,1
;	 MOVLW	    D'10'
;	 SUBWF	    BIRLER,0
;	 BTFSS	    STATUS,Z
;	 RETURN
;	
;	 BCF	    STATUS,Z
;	 CLRF	    BIRLER
;	 INCF	    ONLAR,1
;	 MOVLW	    0x0A
;	 SUBWF	    ONLAR,0
;	 BTFSS	    STATUS,Z
;	 RETURN
;	 CLRF	    ONLAR	
;	 RETURN
;	
;;******************************************************************
;YAK_BIRLER
;	BTFSS	    YAK,0
;	GOTO	    YAK_ONLAR
;	
;	MOVLW	    B'00000010'
;	MOVWF	    PORTA
;	MOVF	    BIRLER,W
;	CALL	    LOOKUP
;	MOVWF	    PORTC
;	INCF	    YAK,1	
;	RETURN
;	
;YAK_ONLAR
;	MOVLW	    B'00000001'
;	MOVWF	    PORTA
;	MOVF	    ONLAR,W
;	CALL	    LOOKUP
;	MOVWF	    PORTC
;	DECF	    YAK,1
;	RETURN
;	
;;******************************************************************
;KESME_AYAR
;	BSF	    INTCON,GIE
;	BSF	    INTCON,T0IE
;	BSF	    INTCON,INTE
;
;	BANKSEL	    OPTION_REG
;	MOVLW	    B'00000011'
;	MOVWF	    OPTION_REG
;	RETURN
;;******************************************************************
;PORT_AYAR
;	BANKSEL	    ADCON1
;	MOVLW	    0x06
;	MOVWF	    ADCON1
;
;	BANKSEL	    TRISB
;	MOVLW	    B'00111100'
;	MOVWF	    TRISA
;	
;	MOVLW	    B'00000001'
;	MOVWF	    TRISB
;	
;	CLRF	    TRISC
;	
;	
;	BANKSEL	    PORTB
;	CLRF	    PORTA
;	CLRF	    PORTB
;	CLRF	    PORTC
;		
;	RETURN
;	
;;******************************************************************************
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
;;******************************************************************
;BASLA
;	CALL	    KESME_AYAR
;	CALL	    PORT_AYAR
;	
;	CLRF	    BIRLER
;	CLRF	    ONLAR
;	MOVLW	    0x01
;	MOVWF	    YAK
;	
;DD
;	
;	GOTO	    DD
;	END



