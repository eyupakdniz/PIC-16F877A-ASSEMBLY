	list		p=16f877A	
	#include	<p16f877A.inc>	
	
	__CONFIG    H'3F31'

w_temp			EQU	0x7D
status_temp		EQU	0x7E
pclath_temp		EQU	0x7F
;******************************************************************
ORG	0x000
NOP
GOTO	BASLA

;******************************************************************
ORG	0x004
	MOVF	    w_temp,W
	MOVF	    STATUS,W
	MOVWF	    status_temp
	MOVF	    PCLATH,W
	MOVWF	    pclath_temp

	BCF	    INTCON,INTF
	CALL	    ISLEM

CIK
	BSF	    INTCON,GIE
	MOVF	    pclath_temp,W
	MOVWF	    PCLATH
	MOVF	    status_temp,W
	MOVWF	    STATUS
	SWAPF	    w_temp,1
	SWAPF	    w_temp,w
		    retfie
;******************************************************************
ISLEM
	MOVF	    PORTB,W
	XORLW	    B'0000100'
	MOVWF	    PORTB	    
	RETURN
	

;******************************************************************
KESME_AYAR
	BSF	    INTCON,INTE
	BSF	    INTCON,GIE
	BCF	    OPTION_REG,6
	RETURN
;******************************************************************
PORT_AYAR
	BANKSEL	    TRISB
	BSF	    TRISB,0
	BANKSEL	    PORTB
	CLRF	    PORTB
	RETURN
;******************************************************************
BASLA
	CALL	KESME_AYAR
	CALL	PORT_AYAR
DD
	
	GOTO	    DD
END
