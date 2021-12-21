	;;say?y? ekranan giren say?
	;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG H'3F31'
;
;BIRLER	    EQU	0x20
;ONLAR	    EQU	0x21
;YUZLER	    EQU	0x22
;BINLER	    EQU	0x23
;VERI	    EQU	0x24
;TEMP	    EQU	0x25
;SAYI_L	    EQU	0x26
;SAYI_H	    EQU	0x27
;G1	    EQU	0x28
;G2	    EQU	0x29
;TEMP_L	    EQU	0x30	    
;;***************************************
;	    ORG	0x000
;	    NOP	
;	    GOTO    BASLA
;;*********************************************
;	    ORG	0x004
;	    RETFIE
;;***********************************************
;ASCII_LOOKUP
;	    ADDWF   PCL,1
;	    RETLW   0x30
;	    RETLW   0x31
;	    RETLW   0x32
;	    RETLW   0x33
;	    RETLW   0x34
;	    RETLW   0x35
;	    RETLW   0x36
;	    RETLW   0x37
;	    RETLW   0x38
;	    RETLW   0x39
;;;**********************************************************
;GECIKME_200USN
;	   MOVLW    0xC8
;	   MOVWF    G1
;LOOP	
;	   DECFSZ   G1,1
;	   GOTO	    LOOP
;	   RETURN
;;*******************************************
;GECIKME_50MSN
;	   MOVLW    0x0F
;	   MOVWF    G1
;	   
;	   MOVLW    0x28
;	   MOVWF    G2
;LOOP1
;	   DECFSZ   G1,1
;	   GOTO	    LOOP1
;	   
;	   DECFSZ   G2,1
;	   GOTO	    LOOP1
;	   RETURN
;;********************************************
;TETIK
;	   BANKSEL  PORTB
;	   BSF	    PORTB,5
;	   CALL	    GECIKME_200USN
;	   BCF	    PORTB,5
;	   RETURN
;;*******************************************
;LCD_AYAR
;	   BANKSEL  TRISB
;	   CLRF	    TRISB
;	   BANKSEL  PORTB
;	   CLRF	    PORTB
;	   
;	   BCF	    PORTB,4
;	   CALL	    TETIK
;	   CALL	    GECIKME_200USN
;	   
;	   CALL	    TETIK
;	   CALL	    GECIKME_200USN
;	   
;	   MOVLW    0x10
;	   CALL	    GONDER
;	   
;	   MOVLW    0x28
;	   CALL	    GONDER
;	 
;	   MOVLW    0x02
;	   CALL	    GONDER
;	   
;	   MOVLW    0x0D
;	   CALL	    GONDER
;
;	   MOVLW    0x01	
;	   CALL	    GONDER 
;	   
;	   MOVLW    0x06
;	   CALL	    GONDER
;   	   RETURN
;;***********************************************
;GONDER
;	   MOVWF    VERI
;	   
;	   SWAPF    VERI,0
;	   ANDLW    0x0F
;	   MOVWF    TEMP
;	   MOVF	    PORTB,W
;	   ANDLW    0xF0
;	   IORWF    TEMP,0
;	   MOVWF    PORTB
;	   CALL	    TETIK
;	  	   
;	   MOVF	    VERI,W
;	   ANDLW    0x0F
;	   MOVWF    TEMP
;	   MOVF	    PORTB,W
;	   ANDLW    0xF0
;	   IORWF    TEMP,0
;	   MOVWF    PORTB
;	   CALL	    TETIK
;	  
;	   RETURN
;;***************************************************
;CEVIR
;	 MOVF	SAYI_H,1
;	 BTFSC	STATUS,Z
;	 GOTO	ATLA
;	 CALL	CEVIR_H
;	 
;ATLA
;	 CALL	CEVIR_L
;	 RETURN
;;*********************************************
;CEVIR_L
;	 MOVF	SAYI_L,1
;	 BTFSC	STATUS,Z
;	 RETURN
;	   
;	 DECF	SAYI_L,1
;	 INCF	BIRLER,1
;	 MOVLW	0x0A
;	 SUBWF	BIRLER,0
;	 BTFSS	STATUS,Z
;	 GOTO	CEVIR_L
;	 
;	 CLRF	BIRLER
;	 INCF	ONLAR,1
;	 MOVLW	0x0A
;	 SUBWF	ONLAR,0
;	 BTFSS	STATUS,Z
;	 GOTO	CEVIR_L
;	 
;	 CLRF	ONLAR
;	 INCF	YUZLER,1
;	 MOVLW	0x0A
;	 SUBWF	YUZLER,0
;	 BTFSS	STATUS,Z
;	 GOTO	CEVIR_L
;	 
;	 CLRF	YUZLER
;	 INCF	BINLER,1
;	 MOVLW	0x0A
;	 SUBWF	BINLER,0
;	 BTFSS	STATUS,Z
;	 GOTO	CEVIR_L
;	 
;;*********************************************
;CEVIR_H
;	 MOVF	SAYI_L,W
;	 MOVWF	TEMP_L
;	 
;HH
;	 INCF	BIRLER,1
;	 MOVLW	0xFF
;	 MOVWF	SAYI_L
;	 CALL	CEVIR_L
;	 DECFSZ	SAYI_H,1
;	 GOTO	HH
;	  
;	 MOVF	TEMP_L,W
;	 MOVWF	SAYI_L
;	 RETURN
;;*********************************************
;BASLA
;	   CALL	    LCD_AYAR
;	   MOVLW    0x03
;	   MOVWF    SAYI_H
;	   MOVLW    0xFF
;	   MOVWF    SAYI_L
;	   
;	   CALL	    CEVIR
;	   
;	   BSF	    PORTB,4
;	   MOVF	    BINLER,W
;	   CALL	    ASCII_LOOKUP
;	   CALL	    GONDER
;	   
;	   MOVF	    YUZLER,W
;	   CALL	    ASCII_LOOKUP
;	   CALL	    GONDER
;	   
;	   MOVF	    ONLAR,W
;	   CALL	    ASCII_LOOKUP
;	   CALL	    GONDER
;	   
;	   MOVF	    BIRLER,W
;	   CALL	    ASCII_LOOKUP
;	   CALL	    GONDER
;DD
;	   GOTO	    DD
;	   END
	    
    
	
	
	
	
    
    	;;1 BYTELIK 2 SAYININ  toplamI
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG H'3F31'
;SAYI_L	    EQU	0x20
;SAYI_H	    EQU	0x21
;VERI	    EQU	0x22
;TEMP	    EQU	0x23
;TEMP_L	    EQU	0x24
;BIRLER	    EQU	0x25
;ONLAR	    EQU	0x26
;YUZLER	    EQU	0x27
;BINLER	    EQU	0x28
;G1	    EQU	0x29
;G2	    EQU	0x30
;SAYI_1	    EQU	0x31
;SAYI_2	    EQU	0x32
;YEDEK	    EQU	0x33
;;*********************************************
;	    ORG	0x000
;	    NOP
;	    GOTO    BASLA
;;********************************************
;	    ORG	0x004
;	    RETFIE
;;*********************************************
;ASCII_LOOKUP
;	    ADDWF   PCL,1
;	    RETLW   0x30
;	    RETLW   0x31
;	    RETLW   0x32
;	    RETLW   0x33
;	    RETLW   0x34
;	    RETLW   0x35
;	    RETLW   0x36
;	    RETLW   0x37
;	    RETLW   0x38
;	    RETLW   0x39
;;**********************************************************
;GECIKME_200USN
;	    MOVLW   0xC8
;	    MOVWF   G1
;LOOP	
;	    DECFSZ  G1,1
;	    GOTO    LOOP
;	    RETURN
;;*********************************************
;GECIKME_50MSN
;	    MOVLW   0x0F
;	    MOVWF   G1
;	    
;	    MOVLW   0x28
;	    MOVWF   G2
;LOOP1	
;	    DECFSZ  G1,1
;	    GOTO    LOOP1
;	    
;	    DECFSZ  G2,1
;	    GOTO    LOOP1
;	    RETURN
;;*******************************************************
;TETIK
;	    BANKSEL PORTB
;	    BSF	    PORTB,5
;	    CALL    GECIKME_200USN
;	    BCF	    PORTB,5
;	    RETURN
;;*******************************************************
;LCD_AYAR
;	    BANKSEL TRISB
;	    CLRF    TRISB
;	    BANKSEL PORTB
;	    CLRF    PORTB
;	    
;	    CALL    TETIK
;	    CALL    GECIKME_200USN
;	    CALL    TETIK
;	    CALL    GECIKME_200USN
;	    BCF	    PORTB,4
;	    
;	    MOVLW   0x02
;	    CALL    GONDER
;	
;	    MOVLW   0x28
;	    CALL    GONDER
;	
;	    MOVLW   0x10	; imleci sola kayd?r
;	    CALL    GONDER
;    
;	    MOVLW   0x0D	;imlec yanip-sonen modda
;	    CALL    GONDER
;	    
;	    MOVLW   0x01	; ekrandaki her seyi siler 
;	    CALL    GONDER
;	    
;	    MOVLW   0x06	; veri yaz?l?r imlec saga konumlan?r
;	    CALL    GONDER
;	    
;	    RETURN
;;****************************************************
;GONDER
;	    MOVWF   VERI
;	    SWAPF   VERI,0
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    MOVF    PORTB,W
;	    ANDLW   0XF0
;	    IORWF   TEMP,0
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    
;	    MOVF    VERI,W
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    MOVF    PORTB,W
;	    ANDLW   0xF0
;	    IORWF   TEMP,0
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    
;	    RETURN
;;**********************************************
;CEVIR
;	    MOVF    SAYI_H,1
;	    BTFSC   STATUS,Z
;	    GOTO    ATLA
;	    CALL    CEVIR_H
;ATLA
;	    CALL    CEVIR_L
;	    RETURN
;;***************************************************
;CEVIR_L
;	    MOVF    SAYI_L,1
;	    BTFSC   STATUS,Z
;	    RETURN
;	    
;	    DECF    SAYI_L,1
;	    INCF    BIRLER,1
;	    MOVLW   0x0A
;	    SUBWF   BIRLER,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    
;	    CLRF    BIRLER
;	    INCF    ONLAR,1
;	    MOVLW   0x0A
;	    SUBWF   ONLAR,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    
;	    CLRF    ONLAR
;	    INCF    YUZLER,1
;	    MOVLW   0x0A
;	    SUBWF   YUZLER,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    
;	    CLRF    YUZLER
;	    INCF    BINLER,1
;	    MOVLW   0x0A
;	    SUBWF   BINLER,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    RETURN
;;***************************************************
;CEVIR_H
;	    MOVF    SAYI_L,W
;	    MOVWF   TEMP_L
;HH
;	    INCF    BIRLER,1
;	    MOVLW   0xFF
;	    MOVWF   SAYI_L
;	    CALL    CEVIR_L
;	    DECFSZ  SAYI_H,1
;	    GOTO    HH
;	    
;	    MOVF    TEMP_L,W
;	    MOVWF   SAYI_L
;	    RETURN
;
;;****************************
;TEMIZ
;	    BANKSEL YUZLER
;	    CLRF    YUZLER
;	    CLRF    ONLAR
;	    CLRF    BIRLER
;	    CLRF    BINLER
;	    RETURN
;;********************************************
;ISLEM_1
;	    CALL    GECIKME_50MSN
;	    CALL    GECIKME_50MSN
;	    DECF    SAYI_1,1
;	    MOVF    SAYI_1,W
;	    MOVWF   SAYI_L
;	    BSF	    PORTB,4
;	    CALL    ASCII_LOOKUP
;	    CALL    GONDER
;	    MOVF    SAYI_L,1
;	    BTFSS   STATUS,Z
;	    GOTO    ISLEM_1
;	    RETURN
;;**************************************** 
;ISLEM_2
;	    CALL    GECIKME_50MSN
;	    CALL    GECIKME_50MSN
;	    CALL    GECIKME_50MSN
;	    CALL    GECIKME_50MSN
;	    MOVLW   0x02
;	    ADDWF   SAYI_2,1
;	    MOVF    SAYI_2,W
;	    MOVWF   SAYI_L
;	    CALL    LCD_AYAR
;	    CALL    TEMIZ
;	    CALL    DD
;	    RETURN
;;******************************************
;BASLA
;	  CALL	LCD_AYAR
;	  
;	  MOVLW	0x0A
;	  MOVWF	SAYI_1
;	  MOVLW 0x00
;	  MOVWF	SAYI_2
;	  
;BUT
;	  CALL	GECIKME_50MSN
;	  BTFSC	PORTC,0
;	  CALL	ISLEM_1
;	  BTFSC	PORTC,1
;	  CALL	ISLEM_2
;	  GOTO	BUT
;DD	  
;	  CALL	GECIKME_50MSN
;	  CALL	GECIKME_50MSN
;	  CALL	GECIKME_50MSN
;
;	  CALL	CEVIR
;	  BSF	PORTB,4
;	  
;	  MOVF	BINLER,W
;	  CALL	ASCII_LOOKUP
;	  CALL	GONDER
;	  
;	  MOVF	YUZLER,W
;	  CALL	ASCII_LOOKUP
;	  CALL	GONDER
;	  
;	  MOVF	ONLAR,W
;	  CALL	ASCII_LOOKUP
;	  CALL	GONDER
;	  
;	  MOVF	BIRLER,W
;	  CALL	ASCII_LOOKUP
;	  CALL	GONDER
;
;	  RETURN
;	  END
    
    
    
    ;	;;1 BYTELIK 2 SAYININ  toplamI
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG H'3F31'
;SAYI_L	    EQU	0x20
;SAYI_H	    EQU	0x21
;VERI	    EQU	0x22
;TEMP	    EQU	0x23
;TEMP_L	    EQU	0x24
;BIRLER	    EQU	0x25
;ONLAR	    EQU	0x26
;YUZLER	    EQU	0x27
;BINLER	    EQU	0x28
;G1	    EQU	0x29
;G2	    EQU	0x30
;SAYI_1	    EQU	0x31
;SAYI_2	    EQU	0x32
;YEDEK	    EQU	0x33
;;*********************************************
;	    ORG	0x000
;	    NOP
;	    GOTO    BASLA
;;********************************************
;	    ORG	0x004
;	    RETFIE
;;*********************************************
;ASCII_LOOKUP
;	    ADDWF   PCL,1
;	    RETLW   0x30
;	    RETLW   0x31
;	    RETLW   0x32
;	    RETLW   0x33
;	    RETLW   0x34
;	    RETLW   0x35
;	    RETLW   0x36
;	    RETLW   0x37
;	    RETLW   0x38
;	    RETLW   0x39
;;**********************************************************
;GECIKME_200USN
;	    MOVLW   0xC8
;	    MOVWF   G1
;LOOP	
;	    DECFSZ  G1,1
;	    GOTO    LOOP
;	    RETURN
;;*********************************************
;GECIKME_50MSN
;	    MOVLW   0x0F
;	    MOVWF   G1
;	    
;	    MOVLW   0x28
;	    MOVWF   G2
;LOOP1	
;	    DECFSZ  G1,1
;	    GOTO    LOOP1
;	    
;	    DECFSZ  G2,1
;	    GOTO    LOOP1
;	    RETURN
;;*******************************************************
;TETIK
;	    BANKSEL PORTB
;	    BSF	    PORTB,5
;	    CALL    GECIKME_200USN
;	    BCF	    PORTB,5
;	    RETURN
;;*******************************************************
;LCD_AYAR
;	    BANKSEL TRISB
;	    CLRF    TRISB
;	    BANKSEL PORTB
;	    CLRF    PORTB
;	    
;	    CALL    TETIK
;	    CALL    GECIKME_200USN
;	    CALL    TETIK
;	    CALL    GECIKME_200USN
;	    BCF	    PORTB,4
;	    
;	    MOVLW   0x02
;	    CALL    GONDER
;	
;	    MOVLW   0x28
;	    CALL    GONDER
;	
;	    MOVLW   0x10	; imleci sola kayd?r
;	    CALL    GONDER
;    
;	    MOVLW   0x0D	;imlec yanip-sonen modda
;	    CALL    GONDER
;	    
;	    MOVLW   0x01	; ekrandaki her seyi siler 
;	    CALL    GONDER
;	    
;	    MOVLW   0x06	; veri yaz?l?r imlec saga konumlan?r
;	    CALL    GONDER
;	    
;	    RETURN
;;****************************************************
;GONDER
;	    MOVWF   VERI
;	    SWAPF   VERI,0
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    MOVF    PORTB,W
;	    ANDLW   0XF0
;	    IORWF   TEMP,0
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    
;	    MOVF    VERI,W
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    MOVF    PORTB,W
;	    ANDLW   0xF0
;	    IORWF   TEMP,0
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    
;	    RETURN
;;**********************************************
;CEVIR
;	    MOVF    SAYI_H,1
;	    BTFSC   STATUS,Z
;	    GOTO    ATLA
;	    CALL    CEVIR_H
;ATLA
;	    CALL    CEVIR_L
;	    RETURN
;;***************************************************
;CEVIR_L
;	    MOVF    SAYI_L,1
;	    BTFSC   STATUS,Z
;	    RETURN
;	    
;	    DECF    SAYI_L,1
;	    INCF    BIRLER,1
;	    MOVLW   0x0A
;	    SUBWF   BIRLER,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    
;	    CLRF    BIRLER
;	    INCF    ONLAR,1
;	    MOVLW   0x0A
;	    SUBWF   ONLAR,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    
;	    CLRF    ONLAR
;	    INCF    YUZLER,1
;	    MOVLW   0x0A
;	    SUBWF   YUZLER,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    
;	    CLRF    YUZLER
;	    INCF    BINLER,1
;	    MOVLW   0x0A
;	    SUBWF   BINLER,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    RETURN
;;***************************************************
;CEVIR_H
;	    MOVF    SAYI_L,W
;	    MOVWF   TEMP_L
;HH
;	    INCF    BIRLER,1
;	    MOVLW   0xFF
;	    MOVWF   SAYI_L
;	    CALL    CEVIR_L
;	    DECFSZ  SAYI_H,1
;	    GOTO    HH
;	    
;	    MOVF    TEMP_L,W
;	    MOVWF   SAYI_L
;	    RETURN
;;*************************************************
;ISLEM
;	    MOVF    SAYI_2,W
;	    ADDWF   SAYI_H,1
;QQ
;	    MOVF    SAYI_1,1
;	    BTFSC   STATUS,Z
;	    RETURN
;	    BCF	    STATUS,Z
;	    DECF    SAYI_1,1
;	    INCF    SAYI_L,1
;	    MOVLW   0x00
;	    SUBWF   SAYI_L,0
;	    BTFSS   STATUS,Z
;	    GOTO    QQ
;	    CLRF    SAYI_L
;	    INCF    SAYI_H,1
;	    GOTO    QQ
;	    
;	    RETURN
;;;**************************************************
;BASLA
;	  CALL	LCD_AYAR
;	  CLRF	SAYI_L
;	  CLRF	SAYI_H
;	  
;	  MOVLW	0x88
;	  MOVWF	SAYI_1
;	  MOVLW	0x00
;	  MOVWF	SAYI_2
;	  MOVLW	0x87
;	  MOVWF	SAYI_L
;	  MOVLW	0x00
;	  MOVWF	SAYI_H
;	  
;	  CALL	ISLEM
; 
;	  CALL	CEVIR
;	  BSF	PORTB,4
;	  
;	  MOVF	BINLER,W
;	  CALL	ASCII_LOOKUP
;	  CALL	GONDER
;	  
;	  MOVF	YUZLER,W
;	  CALL	ASCII_LOOKUP
;	  CALL	GONDER
;	  
;	  MOVF	ONLAR,W
;	  CALL	ASCII_LOOKUP
;	  CALL	GONDER
;	  
;	  MOVF	BIRLER,W
;	  CALL	ASCII_LOOKUP
;	  CALL	GONDER
;DD
;	  GOTO	DD
;	  END
    
    
    
    
    ;	;;1 BYTELIK 2 SAYININ  toplamI
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG H'3F31'
;SAYI_L	    EQU	0x20
;SAYI_H	    EQU	0x21
;VERI	    EQU	0x22
;TEMP	    EQU	0x23
;TEMP_L	    EQU	0x24
;BIRLER	    EQU	0x25
;ONLAR	    EQU	0x26
;YUZLER	    EQU	0x27
;BINLER	    EQU	0x28
;G1	    EQU	0x29
;G2	    EQU	0x30
;SAYI_1	    EQU	0x31
;SAYI_2	    EQU	0x32
;YEDEK	    EQU	0x33
;;*********************************************
;	    ORG	0x000
;	    NOP
;	    GOTO    BASLA
;;********************************************
;	    ORG	0x004
;	    RETFIE
;;*********************************************
;ASCII_LOOKUP
;	    ADDWF   PCL,1
;	    RETLW   0x30
;	    RETLW   0x31
;	    RETLW   0x32
;	    RETLW   0x33
;	    RETLW   0x34
;	    RETLW   0x35
;	    RETLW   0x36
;	    RETLW   0x37
;	    RETLW   0x38
;	    RETLW   0x39
;;**********************************************************
;GECIKME_200USN
;	    MOVLW   0xC8
;	    MOVWF   G1
;LOOP	
;	    DECFSZ  G1,1
;	    GOTO    LOOP
;	    RETURN
;;*********************************************
;GECIKME_50MSN
;	    MOVLW   0xC8
;	    MOVWF   G1
;	    
;	    MOVLW   0xC8
;	    MOVWF   G2
;LOOP1	
;	    DECFSZ  G1,1
;	    GOTO    LOOP1
;	    
;	    DECFSZ  G2,1
;	    GOTO    LOOP1
;	    RETURN
;;*******************************************************
;TETIK
;	    BANKSEL PORTB
;	    BSF	    PORTB,5
;	    CALL    GECIKME_200USN
;	    BCF	    PORTB,5
;	    RETURN
;;*******************************************************
;LCD_AYAR
;	    BANKSEL TRISB
;	    CLRF    TRISB
;	    BANKSEL PORTB
;	    CLRF    PORTB
;	    
;	    CALL    TETIK
;	    CALL    GECIKME_200USN
;	    CALL    TETIK
;	    CALL    GECIKME_200USN
;	    BCF	    PORTB,4
;	    
;	    MOVLW   0x02
;	    CALL    GONDER
;	
;	    MOVLW   0x28
;	    CALL    GONDER
;	
;	    MOVLW   0x10	; imleci sola kayd?r
;	    CALL    GONDER
;    
;	    MOVLW   0x0D	;imlec yanip-sonen modda
;	    CALL    GONDER
;	    
;	    MOVLW   0x01	; ekrandaki her seyi siler 
;	    CALL    GONDER
;	    
;	    MOVLW   0x06	; veri yaz?l?r imlec saga konumlan?r
;	    CALL    GONDER
;	    
;	    RETURN
;;****************************************************
;GONDER
;	    MOVWF   VERI
;	    SWAPF   VERI,0
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    MOVF    PORTB,W
;	    ANDLW   0XF0
;	    IORWF   TEMP,0
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    
;	    MOVF    VERI,W
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    MOVF    PORTB,W
;	    ANDLW   0xF0
;	    IORWF   TEMP,0
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    
;	    RETURN
;;**********************************************
;CEVIR
;	    MOVF    SAYI_H,1
;	    BTFSC   STATUS,Z
;	    GOTO    ATLA
;	    CALL    CEVIR_H
;ATLA
;	    CALL    CEVIR_L
;	    RETURN
;;***************************************************
;CEVIR_L
;	    MOVF    SAYI_L,1
;	    BTFSC   STATUS,Z
;	    RETURN
;	    
;	    DECF    SAYI_L,1
;	    INCF    BIRLER,1
;	    MOVLW   0x0A
;	    SUBWF   BIRLER,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    
;	    CLRF    BIRLER
;	    INCF    ONLAR,1
;	    MOVLW   0x0A
;	    SUBWF   ONLAR,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    
;	    CLRF    ONLAR
;	    INCF    YUZLER,1
;	    MOVLW   0x0A
;	    SUBWF   YUZLER,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    
;	    CLRF    YUZLER
;	    INCF    BINLER,1
;	    MOVLW   0x0A
;	    SUBWF   BINLER,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    RETURN
;;***************************************************
;CEVIR_H
;	    MOVF    SAYI_L,W
;	    MOVWF   TEMP_L
;HH
;	    INCF    BIRLER,1
;	    MOVLW   0xFF
;	    MOVWF   SAYI_L
;	    CALL    CEVIR_L
;	    DECFSZ  SAYI_H,1
;	    GOTO    HH
;	    
;	    MOVF    TEMP_L,W
;	    MOVWF   SAYI_L
;	    RETURN
;;*************************************************
;ISLEM
;	    MOVF    SAYI_1,W
;	    MOVWF   SAYI_L
;	   
;QQ
;	    BCF	    STATUS,Z
;	    MOVF    SAYI_2,1
;	    BTFSC   STATUS,Z
;	    RETURN
;	    BCF	    STATUS,Z
;	    DECF    SAYI_2,1
;	    INCF    SAYI_L,1
;	    MOVLW   0x00
;	    SUBWF   SAYI_L,0
;	    BTFSS   STATUS,Z
;	    GOTO    QQ
;	    CLRF    SAYI_L
;	    INCF    SAYI_H,1
;	    GOTO    QQ
;	    RETURN
;;**************************************************
;BASLA
;	  CALL	LCD_AYAR
;	  CLRF	SAYI_L
;	  CLRF	SAYI_H
;	  
;	  MOVLW	0xFF
;	  MOVWF	SAYI_1
;	  MOVLW	0xA0
;	  MOVWF	SAYI_2
;	  CALL	ISLEM
; 
;	  CALL	CEVIR
;	  BSF	PORTB,4
;	  
;	  MOVF	BINLER,W
;	  CALL	ASCII_LOOKUP
;	  CALL	GONDER
;	  
;	  MOVF	YUZLER,W
;	  CALL	ASCII_LOOKUP
;	  CALL	GONDER
;	  
;	  MOVF	ONLAR,W
;	  CALL	ASCII_LOOKUP
;	  CALL	GONDER
;	  
;	  MOVF	BIRLER,W
;	  CALL	ASCII_LOOKUP
;	  CALL	GONDER
;DD
;	  GOTO	DD
;	  END
	   
    
    
    ;	;;2 BYTELIK say? toplam?
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG H'3F31'
;SAYI_L	    EQU	0x20
;SAYI_H	    EQU	0x21
;VERI	    EQU	0x22
;TEMP	    EQU	0x23
;TEMP_L	    EQU	0x24
;BIRLER	    EQU	0x25
;ONLAR	    EQU	0x26
;YUZLER	    EQU	0x27
;BINLER	    EQU	0x28
;G1	    EQU	0x29
;G2	    EQU	0x30
;SAYI_1	    EQU	0x31
;SAYI_2	    EQU	0x32
;YEDEK	    EQU	0x33
;;*********************************************
;	    ORG	0x000
;	    NOP
;	    GOTO    BASLA
;;********************************************
;	    ORG	0x004
;	    RETFIE
;;*********************************************
;ASCII_LOOKUP
;	    ADDWF   PCL,1
;	    RETLW   0x30
;	    RETLW   0x31
;	    RETLW   0x32
;	    RETLW   0x33
;	    RETLW   0x34
;	    RETLW   0x35
;	    RETLW   0x36
;	    RETLW   0x37
;	    RETLW   0x38
;	    RETLW   0x39
;;**********************************************************
;GECIKME_200USN
;	    MOVLW   0xC8
;	    MOVWF   G1
;LOOP	
;	    DECFSZ  G1,1
;	    GOTO    LOOP
;	    RETURN
;;*********************************************
;GECIKME_50MSN
;	    MOVLW   0xC8
;	    MOVWF   G1
;	    
;	    MOVLW   0xC8
;	    MOVWF   G2
;LOOP1	
;	    DECFSZ  G1,1
;	    GOTO    LOOP1
;	    
;	    DECFSZ  G2,1
;	    GOTO    LOOP1
;	    RETURN
;;************************************
;TETIK
;	    BANKSEL PORTB
;	    BSF	    PORTB,5
;	    CALL    GECIKME_200USN
;	    BCF	    PORTB,5
;	    RETURN
;;**********************************************
;LCD_AYAR
;	    BANKSEL TRISB
;	    CLRF    TRISB
;	    BANKSEL PORTB
;	    CLRF    PORTB
;	    
;	    BCF	    PORTB,4
;	    CALL    TETIK
;	    CALL    GECIKME_200USN
;	    
;	    CALL    TETIK
;	    CALL    GECIKME_200USN
;	    
;	    MOVLW   0x02
;	    CALL    GONDER
;	    
;	    MOVLW   0x28
;	    CALL    GONDER
;	    
;	    MOVLW   0x10
;	    CALL    GONDER
;	    
;	    MOVLW   0x0D
;	    CALL    GONDER
;	    
;	    MOVLW   0x06
;	    CALL    GONDER
;
;	    MOVLW   0x01	; ekrandaki her seyi siler 
;	    CALL    GONDER
;	    
;
;	    RETURN
;;**********************************************
;GONDER
;	    MOVWF   VERI
;	    
;	    SWAPF   VERI,0
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    MOVF    PORTB,W
;	    ANDLW   0xF0
;	    IORWF   TEMP,0
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    
;	    MOVF    VERI,W
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    MOVF    PORTB,W
;	    ANDLW   0xF0
;	    IORWF   TEMP,0
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    RETURN
;;*******************************************
;CEVIR_L
;	    MOVF    SAYI_L,1
;	    BTFSC   STATUS,Z
;	    RETURN
;	    
;	    DECF    SAYI_L,1
;	    INCF    BIRLER,1
;	    MOVLW   0x0A
;	    SUBWF   BIRLER,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    
;	    CLRF    BIRLER
;	    INCF    ONLAR,1
;	    MOVLW   0x0A
;	    SUBWF   ONLAR,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    
;	    CLRF    ONLAR
;	    INCF    YUZLER,1
;	    MOVLW   0x0A
;	    SUBWF   YUZLER,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    
;	    CLRF    YUZLER
;	    INCF    BINLER,1
;	    MOVLW   0x0A
;	    SUBWF   BINLER,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    RETURN
;;******************************************************
;CEVIR
;	    MOVF    SAYI_H,1
;	    BTFSC   STATUS,Z
;	    GOTO    ATLA
;	    CALL    CEVIR_H
;ATLA
;	    CALL    CEVIR_L
;	    RETURN
;;***************************************************
;CEVIR_H
;	    MOVF    SAYI_L,W
;	    MOVWF   TEMP_L
;HH
;	    INCF    BIRLER,1
;    	    MOVLW   0xFF
;	    MOVWF   SAYI_L
;	    CALL    CEVIR_L
;	    DECFSZ  SAYI_H,1
;	    GOTO    HH
;	    
;	    MOVF    TEMP_L,W
;	    MOVWF   SAYI_L
;	    RETURN
;;**************************************************
;ISLEM_TOP
;	    MOVF    SAYI_1,W
;	    MOVWF   SAYI_L
;	    
;BAS	    
;	    INCFSZ  SAYI_L,1
;	    GOTO    BAS
;	    CLRF    SAYI_L
;	    INCF    SAYI_H,1
;	    DECFSZ  SAYI_2,1
;	    GOTO    BAS
;	    
;	    RETURN
;;*************************************
;BASLA
;	  CALL	LCD_AYAR
;	  CLRF	SAYI_L
;	  CLRF	SAYI_H
;	  
;	  MOVLW	0xAA
;	  MOVWF	SAYI_1
;	  
;	  MOVLW	0xAA
;	  MOVWF	SAYI_2
;	  CALL	ISLEM_TOP
;	  
;	  CALL	CEVIR
;	  BSF	PORTB,4
;	  
;	  MOVF	BINLER,W
;	  CALL	ASCII_LOOKUP
;	  CALL	GONDER
;	  
;	  MOVF	YUZLER,W
;	  CALL	ASCII_LOOKUP
;	  CALL	GONDER
;	  
;	  MOVF	ONLAR,W
;	  CALL	ASCII_LOOKUP
;	  CALL	GONDER
;	  
;	  MOVF	BIRLER,W
;	  CALL	ASCII_LOOKUP
;	  CALL	GONDER
;DD
;	  GOTO	DD
;	    END

    
    
    
    
    ;;;;SAYAC
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG H'3F31'
;	
;SAYI_L	    EQU	0x20
;SAYI_H	    EQU	0x21
;VERI	    EQU	0x22
;TEMP	    EQU	0X23
;TEMP_L	    EQU	0x24
;G1	    EQU	0x25
;G2	    EQU	0x26
;BIRLER	    EQU	0x27
;ONLAR	    EQU	0x28
;YUZLER	    EQU	0x29
;BINLER	    EQU	0x30
;SAYAC	    EQU	0x31
;    
;W_TEMP	    EQU	0x7D
;STATUS_TEMP EQU	0x7E
;PCLATH_TEMP EQU	0x7F
;;***************************************************
;	    ORG	0x000
;	    NOP	
;	    GOTO    BASLA
;;***********************************************
;	    ORG	0x004
;	    RETFIE
;;**************************************************
;TEMIZ
;	    BANKSEL BIRLER
;	    CLRF    BIRLER
;	    CLRF    ONLAR
;	    CLRF    BINLER
;	    CLRF    YUZLER
;	    RETURN
;;*****************************************
;GECIKME_200USN
;	    MOVLW   0xC8
;	    MOVWF   G1
;LOOP
;	    DECFSZ  G1,1
;	    GOTO    LOOP
;	    
;	    RETURN
;;***************************************************
;GECIKME_50MSN
;	    MOVLW   0x0F
;	    MOVWF   G1
;	    
;	    MOVLW   0x28
;	    MOVWF   G2
;LOOP1
;	    DECFSZ  G1,1
;	    GOTO    LOOP1
;	    
;	    DECFSZ  G2,1
;	    GOTO    LOOP1
;	    RETURN
;;*******************************************************
;TETIK
;	    BANKSEL PORTB
;	    BSF	    PORTB,5
;	    CALL    GECIKME_200USN
;	    BCF	    PORTB,5
;	    RETURN
;;*******************************************************
;LCD_AYAR
;	    BANKSEL TRISB
;	    CLRF    TRISB
;	    BANKSEL PORTB
;	    CLRF    PORTB
;	    
;	    CALL    TETIK
;	    CALL    GECIKME_200USN
;	    CALL    TETIK
;	    CALL    GECIKME_200USN
;	    BCF	    PORTB,4
;	    
;	    MOVLW   0x02
;	    CALL    GONDER
;	
;	    MOVLW   0x28
;	    CALL    GONDER
;	
;	    MOVLW   0x10	; imleci sola kayd?r
;	    CALL    GONDER
;    
;	    MOVLW   0x0D	;imlec yanip-sonen modda
;	    CALL    GONDER
;	    
;	    MOVLW   0x01	; ekrandaki her seyi siler 
;	    CALL    GONDER
;	    
;	    MOVLW   0x06	; veri yaz?l?r imlec saga konumlan?r
;	    CALL    GONDER
;	    
;	    RETURN
;;****************************************************
;GONDER
;	    MOVWF   VERI
;	    SWAPF   VERI,0
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    MOVF    PORTB,W
;	    ANDLW   0XF0
;	    IORWF   TEMP,0
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    
;	    MOVF    VERI,W
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    MOVF    PORTB,W
;	    ANDLW   0xF0
;	    IORWF   TEMP,0
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    
;	    RETURN
;;**********************************************
;CEVIR
;	    MOVF    SAYI_H,1
;	    BTFSC   STATUS,Z
;	    GOTO    ATLA
;	    CALL    CEVIR_H
;ATLA
;	    CALL    CEVIR_L
;	    RETURN
;;***************************************************
;CEVIR_L
;	    MOVF    SAYI_L,1
;	    BTFSC   STATUS,Z
;	    RETURN
;	    
;	    DECF    SAYI_L,1
;	    INCF    BIRLER,1
;	    MOVLW   0x0A
;	    SUBWF   BIRLER,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    
;	    CLRF    BIRLER
;	    INCF    ONLAR,1
;	    MOVLW   0x0A
;	    SUBWF   ONLAR,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    
;	    CLRF    ONLAR
;	    INCF    YUZLER,1
;	    MOVLW   0x0A
;	    SUBWF   YUZLER,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    
;	    CLRF    YUZLER
;	    INCF    BINLER,1
;	    MOVLW   0x0A
;	    SUBWF   BINLER,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    RETURN
;;***************************************************
;CEVIR_H
;	    MOVF    SAYI_L,W
;	    MOVWF   TEMP_L
;HH
;	    INCF    BIRLER,1
;	    MOVLW   0xFF
;	    MOVWF   SAYI_L
;	    CALL    CEVIR_L
;	    DECFSZ  SAYI_H,1
;	    GOTO    HH
;	    
;	    MOVF    TEMP_L,W
;	    MOVWF   SAYI_L
;	    RETURN
;;*************************************************
;ASCII_LOOKUP
;	    ADDWF   PCL,1
;	    RETLW   0x30
;	    RETLW   0x31
;	    RETLW   0x32
;	    RETLW   0x33
;	    RETLW   0x34
;	    RETLW   0x35
;	    RETLW   0x36
;	    RETLW   0x37
;	    RETLW   0x38
;	    RETLW   0x39
;;**********************************************************
;PORT_AYAR
;	    BANKSEL TRISD
;	    CLRF    TRISD
;	    BANKSEL PORTD
;	    CLRF    PORTD
;	    
;	    RETURN
;;***********************************************************
;ART
;	    CALL    GECIKME_50MSN
;	    CALL    GECIKME_50MSN
;	    CALL    GECIKME_50MSN
;	    CALL    GECIKME_50MSN
;	    CALL    GECIKME_50MSN
;	    CLRF    PORTD
;	    INCF    SAYI_L,1
;	    MOVLW   0xFF
;	    SUBWF   SAYI_L,0
;	    BTFSC   STATUS,Z
;	    CALL    ARTT
;	    CALL    DD
;	    RETURN
;ARTT
;	    CLRF    SAYI_L
;	    INCF    SAYI_H,1
;	    RETURN
;;***********************************************************
;AZALT
;	    BCF	    STATUS,Z
;	    CALL    GECIKME_50MSN
;	    CALL    GECIKME_50MSN
;	    CALL    GECIKME_50MSN
;	    CALL    GECIKME_50MSN
;	    CALL    GECIKME_50MSN
;	    CLRF    PORTD
;	    DECF    SAYI_L,1
;	    MOVLW   0xFF
;	    SUBWF   SAYI_L,0
;	    BTFSC   STATUS,Z
;	    CALL    DD
;	    GOTO    ALTT
;	    RETURN
;ALTT	    
;	    BCF	    STATUS,Z
;	    CLRF    SAYI_L
;	    MOVLW   0xFF
;	    MOVWF   SAYI_L
;	    MOVF    SAYI_H,1
;	    BTFSC   STATUS,Z
;	    GOTO    ALT
;	    DECF    SAYI_H,1
;	    CALL    DD
;	    RETURN
;ALT
;	    CALL    TEMIZ
;	    CLRF    SAYI_L
;	    MOVLW   0x03
;	    MOVWF   SAYI_H
;	    MOVLW   0xFF
;	    MOVWF   SAYI_L
;	    CALL    DD
;	    RETURN
;;****************************************************	    
;BASLA	
;	    CALL    LCD_AYAR
;	    CALL    PORT_AYAR	    
;	    MOVLW   B'00000000'
;	    MOVWF   SAYI_H
;	    MOVWF   B'00000001'
;	    MOVWF   SAYI_L
;	    
;DONGU
;	    CALL    GECIKME_50MSN
;	    CALL    GECIKME_50MSN
;;	    BTFSC   PORTD,0
;;	    CALL    ART
;	    BTFSC   PORTD,1
;	    CALL    AZALT
;	    GOTO    DONGU   
;
;DD
;	    CALL    LCD_AYAR
;	    CALL    CEVIR
;	    
;	    BSF	    PORTB,4
;	    
;	    MOVF    BINLER,W
;	    CALL    ASCII_LOOKUP
;	    CALL    GONDER
;	    
;	    MOVF    YUZLER,W
;	    CALL    ASCII_LOOKUP
;	    CALL    GONDER
;	    
;	    MOVF    ONLAR,W
;	    CALL    ASCII_LOOKUP
;	    CALL    GONDER
;	    
;	    MOVF    BIRLER,W
;	    CALL    ASCII_LOOKUP
;	    CALL    GONDER
;	    RETURN
;	    END
    
    
    
    
    ;	;;;;;;;;;;;;;;;TMR0 LI SAYAC
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG H'3F31'
;	
;SAYI_L	    EQU	0x20
;SAYI_H	    EQU	0x21
;VERI	    EQU	0x22
;TEMP	    EQU	0X23
;TEMP_L	    EQU	0x24
;G1	    EQU	0x25
;G2	    EQU	0x26
;BIRLER	    EQU	0x27
;ONLAR	    EQU	0x28
;YUZLER	    EQU	0x29
;BINLER	    EQU	0x30
;SAYAC	    EQU	0x31
;    
;W_TEMP	    EQU	0x7D
;STATUS_TEMP EQU	0x7E
;PCLATH_TEMP EQU	0x7F
;;***************************************************
;	    ORG	0x000
;	    NOP	
;	    GOTO    BASLA
;;***********************************************
;	    ORG	0x004
;	    MOVWF   W_TEMP
;	    MOVF    STATUS,W
;	    MOVWF   STATUS_TEMP
;	    MOVF    PCLATH,W
;	    MOVWF   PCLATH_TEMP
;	    
;	    MOVLW   0x06
;	    MOVWF   TMR0
;	    BCF	    INTCON,T0IF
;	    
;	    DECFSZ  SAYAC,1
;	    GOTO    CIK
;	    
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
;;**************************************************
;ISLEM
;	    MOVLW   0xFF
;	    MOVWF   SAYAC
;	    
;	    CALL    LCD_AYAR
;	    CALL    TEMIZ
;	    	    
;	    CALL    CEVIR
;	    
;	    BSF	    PORTB,4
;	    
;	    MOVF    BINLER,W
;	    CALL    ASCII_LOOKUP
;	    CALL    GONDER
;	    
;	    MOVF    YUZLER,W
;	    CALL    ASCII_LOOKUP
;	    CALL    GONDER
;	    
;	    MOVF    ONLAR,W
;	    CALL    ASCII_LOOKUP
;	    CALL    GONDER
;	    
;	    MOVF    BIRLER,W
;	    CALL    ASCII_LOOKUP
;	    CALL    GONDER
;	    
;	    RETURN
;;*******************************************
;ISLEM_H
;	    CLRF    SAYI_L
;	    INCF    SAYI_H,1
;	    RETURN
;;************************************************
;TEMIZ
;	    BANKSEL BIRLER
;	    CLRF    BIRLER
;	    CLRF    ONLAR
;	    CLRF    BINLER
;	    CLRF    YUZLER
;	    RETURN
;;*****************************************
;GECIKME_200USN
;	    MOVLW   0xC8
;	    MOVWF   G1
;LOOP
;	    DECFSZ  G1,1
;	    GOTO    LOOP
;	    
;	    RETURN
;;***************************************************
;GECIKME_50MSN
;	    MOVLW   0x0F
;	    MOVWF   G1
;	    
;	    MOVLW   0x28
;	    MOVWF   G2
;LOOP1
;	    DECFSZ  G1,1
;	    GOTO    LOOP1
;	    
;	    DECFSZ  G2,1
;	    GOTO    LOOP1
;	    RETURN
;;*******************************************************
;TETIK
;	    BANKSEL PORTB
;	    BSF	    PORTB,5
;	    CALL    GECIKME_200USN
;	    BCF	    PORTB,5
;	    RETURN
;;*******************************************************
;LCD_AYAR
;	    BANKSEL TRISB
;	    CLRF    TRISB
;	    BANKSEL PORTB
;	    CLRF    PORTB
;	    
;	    
;	    
;	    CALL    TETIK
;	    CALL    GECIKME_200USN
;	    CALL    TETIK
;	    CALL    GECIKME_200USN
;	    BCF	    PORTB,4
;	    
;	    MOVLW   0x02
;	    CALL    GONDER
;	
;	    MOVLW   0x28
;	    CALL    GONDER
;	
;	    MOVLW   0x10	; imleci sola kayd?r
;	    CALL    GONDER
;    
;	    MOVLW   0x0D	;imlec yanip-sonen modda
;	    CALL    GONDER
;	    
;	    MOVLW   0x01	; ekrandaki her seyi siler 
;	    CALL    GONDER
;	    
;	    MOVLW   0x06	; veri yaz?l?r imlec saga konumlan?r
;	    CALL    GONDER
;	    
;	    RETURN
;;****************************************************
;GONDER
;	    MOVWF   VERI
;	    SWAPF   VERI,0
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    MOVF    PORTB,W
;	    ANDLW   0XF0
;	    IORWF   TEMP,0
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    
;	    MOVF    VERI,W
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    MOVF    PORTB,W
;	    ANDLW   0xF0
;	    IORWF   TEMP,0
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    
;	    RETURN
;;**********************************************
;CEVIR
;	    MOVF    SAYI_H,1
;	    BTFSC   STATUS,Z
;	    GOTO    ATLA
;	    CALL    CEVIR_H
;ATLA
;	    CALL    CEVIR_L
;	    RETURN
;;***************************************************
;CEVIR_L
;	    MOVF    SAYI_L,1
;	    BTFSC   STATUS,Z
;	    RETURN
;	    
;	    DECF    SAYI_L,1
;	    INCF    BIRLER,1
;	    MOVLW   0x0A
;	    SUBWF   BIRLER,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    
;	    CLRF    BIRLER
;	    INCF    ONLAR,1
;	    MOVLW   0x0A
;	    SUBWF   ONLAR,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    
;	    CLRF    ONLAR
;	    INCF    YUZLER,1
;	    MOVLW   0x0A
;	    SUBWF   YUZLER,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    
;	    CLRF    YUZLER
;	    INCF    BINLER,1
;	    MOVLW   0x0A
;	    SUBWF   BINLER,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    RETURN
;;***************************************************
;CEVIR_H
;	    MOVF    SAYI_L,W
;	    MOVWF   TEMP_L
;HH
;	    INCF    BIRLER,1
;	    MOVLW   0xFF
;	    MOVWF   SAYI_L
;	    CALL    CEVIR_L
;	    DECFSZ  SAYI_H,1
;	    GOTO    HH
;	    
;	    MOVF    TEMP_L,W
;	    MOVWF   SAYI_L
;	    RETURN
;;*************************************************
;ASCII_LOOKUP
;	    ADDWF   PCL,1
;	    RETLW   0x30
;	    RETLW   0x31
;	    RETLW   0x32
;	    RETLW   0x33
;	    RETLW   0x34
;	    RETLW   0x35
;	    RETLW   0x36
;	    RETLW   0x37
;	    RETLW   0x38
;	    RETLW   0x39
;;**********************************************************
;KESME_AYAR
;	    BANKSEL INTCON
;	    BCF	    INTCON,T0IF
;	    BSF	    INTCON,GIE
;	    BSF	    INTCON,T0IE
;	    
;	    BANKSEL OPTION_REG
;	    MOVLW   B'00000101'
;	    MOVWF   OPTION_REG
;	    
;	    BANKSEL TMR0
;	    MOVLW   0x06
;	    MOVWF   TMR0
;	    RETURN
;;*************************************************
;BASLA	
;	    CALL    LCD_AYAR
;	    CALL    KESME_AYAR
;	    
;	    MOVLW   B'00000000'
;	    MOVWF   SAYI_H
;	    MOVWF   B'00000000'
;	    MOVWF   SAYI_L
;
;	    MOVLW   0x10
;	    MOVWF   SAYAC
;	    
;DD  
;	    GOTO    DD
;	    END
    

    ;    	;2 byte say? TEKRAR
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG H'3F31'
;	
;SAYI_L	    EQU	0x20
;SAYI_H	    EQU	0x21
;VERI	    EQU	0x22
;TEMP	    EQU	0X23
;TEMP_L	    EQU	0x24
;G1	    EQU	0x25
;G2	    EQU	0x26
;BIRLER	    EQU	0x27
;ONLAR	    EQU	0x28
;YUZLER	    EQU	0x29
;BINLER	    EQU	0x30
;    
;    
;;***************************************************
;	    ORG	0x000
;	    NOP	
;	    GOTO    BASLA
;;***********************************************
;	    ORG	0x004
;	    RETFIE
;;**************************************************
;GECIKME_200USN
;	    MOVLW   0xC8
;	    MOVWF   G1
;LOOP
;	    DECFSZ  G1,1
;	    GOTO    LOOP
;	    
;	    RETURN
;;***************************************************
;GECIKME_50MSN
;	    MOVLW   0x0F
;	    MOVWF   G1
;	    
;	    MOVLW   0x28
;	    MOVWF   G2
;LOOP1
;	    DECFSZ  G1,1
;	    GOTO    LOOP1
;	    
;	    DECFSZ  G2,1
;	    GOTO    LOOP1
;	    RETURN
;;*******************************************************
;TETIK
;	    BANKSEL PORTB
;	    BSF	    PORTB,5
;	    CALL    GECIKME_200USN
;	    BCF	    PORTB,5
;	    RETURN
;;*******************************************************
;LCD_AYAR
;	    BANKSEL TRISB
;	    CLRF    TRISB
;	    BANKSEL PORTB
;	    CLRF    PORTB
;	    
;	    
;	    
;	    CALL    TETIK
;	    CALL    GECIKME_200USN
;	    CALL    TETIK
;	    CALL    GECIKME_200USN
;	    BCF	    PORTB,4
;	    
;	    MOVLW   0x02
;	    CALL    GONDER
;	
;	    MOVLW   0x28
;	    CALL    GONDER
;	
;	    MOVLW   0x10	; imleci sola kayd?r
;	    CALL    GONDER
;    
;	    MOVLW   0x0D	;imlec yanip-sonen modda
;	    CALL    GONDER
;	    
;	    MOVLW   0x01	; ekrandaki her seyi siler 
;	    CALL    GONDER
;	    
;	    MOVLW   0x06	; veri yaz?l?r imlec saga konumlan?r
;	    CALL    GONDER
;	    
;	    RETURN
;;****************************************************
;GONDER
;	    MOVWF   VERI
;	    SWAPF   VERI,0
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    MOVF    PORTB,W
;	    ANDLW   0XF0
;	    IORWF   TEMP,0
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    
;	    MOVF    VERI,W
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    MOVF    PORTB,W
;	    ANDLW   0xF0
;	    IORWF   TEMP,0
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    
;	    RETURN
;;**********************************************
;CEVIR
;	    MOVF    SAYI_H,1
;	    BTFSC   STATUS,Z
;	    GOTO    ATLA
;	    CALL    CEVIR_H
;ATLA
;	    CALL    CEVIR_L
;	    RETURN
;;***************************************************
;CEVIR_L
;	    MOVF    SAYI_L,1
;	    BTFSC   STATUS,Z
;	    RETURN
;	    
;	    DECF    SAYI_L,1
;	    INCF    BIRLER,1
;	    MOVLW   0x0A
;	    SUBWF   BIRLER,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    
;	    CLRF    BIRLER
;	    INCF    ONLAR,1
;	    MOVLW   0x0A
;	    SUBWF   ONLAR,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    
;	    CLRF    ONLAR
;	    INCF    YUZLER,1
;	    MOVLW   0x0A
;	    SUBWF   YUZLER,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    
;	    CLRF    YUZLER
;	    INCF    BINLER,1
;	    MOVLW   0x0A
;	    SUBWF   BINLER,0
;	    BTFSS   STATUS,Z
;	    GOTO    CEVIR_L
;	    RETURN
;;***************************************************
;CEVIR_H
;	    MOVF    SAYI_L,W
;	    MOVWF   TEMP_L
;HH
;	    INCF    BIRLER,1
;	    MOVLW   0xFF
;	    MOVWF   SAYI_L
;	    CALL    CEVIR_L
;	    DECFSZ  SAYI_H,1
;	    GOTO    HH
;	    
;	    MOVF    TEMP_L,W
;	    MOVWF   SAYI_L
;	    RETURN
;;*************************************************
;ASCII_LOOKUP
;	    ADDWF   PCL,1
;	    RETLW   0x30
;	    RETLW   0x31
;	    RETLW   0x32
;	    RETLW   0x33
;	    RETLW   0x34
;	    RETLW   0x35
;	    RETLW   0x36
;	    RETLW   0x37
;	    RETLW   0x38
;	    RETLW   0x39
;;**********************************************************
;BASLA	
;	    CALL    LCD_AYAR
;	    
;	    MOVLW   B'00001011'
;	    MOVWF   SAYI_H
;	    MOVWF   B'00011111'
;	    MOVWF   SAYI_L
;	    CALL    CEVIR
;	    
;	    BSF	    PORTB,4
;	    
;	    MOVF    BINLER,W
;	    CALL    ASCII_LOOKUP
;	    CALL    GONDER
;	    
;	    MOVF    YUZLER,W
;	    CALL    ASCII_LOOKUP
;	    CALL    GONDER
;	    
;	    MOVF    ONLAR,W
;	    CALL    ASCII_LOOKUP
;	    CALL    GONDER
;	    
;	    MOVF    BIRLER,W
;	    CALL    ASCII_LOOKUP
;	    CALL    GONDER
;DD  
;	    GOTO    DD
;	    END
    
    
    
    
    
    
    
    
    
    
    
    
    
    ;        	;TMR0 LI adc orn
;    	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG H'3F31'
;BIRLER	    EQU	0x20
;YUZLER	    EQU	0x21
;ONLAR	    EQU	0x22
;BINLER	    EQU	0x23
;	    
;G1	    EQU	0x24
;G2	    EQU	0x25
;	    
;VERI	    EQU	0x26
;TEMP	    EQU	0x27
;	    
;SAYI_H	    EQU	0x29
;SAYI_L	    EQU	0x28
;TEMP_L	    EQU	0x30
;	    
;;*************************************************
;	ORG 0x000
;	NOP
;	GOTO	BASLA
;;************************************************
;	ORG 0x004
;	RETFIE	
;;****************************************************
;ASCII_LOOKUP
;	    ADDWF   PCL,1
;	    RETLW   0x30
;	    RETLW   0x31
;	    RETLW   0x32
;	    RETLW   0x33
;	    RETLW   0x34
;	    RETLW   0x35
;	    RETLW   0x36
;	    RETLW   0x37
;	    RETLW   0x38
;	    RETLW   0x39
;;**********************************************************
;GECIKME_200USN
;	    MOVLW   0xC8
;	    MOVWF   G1
;LOOP
;	    DECFSZ  G1,1
;	    GOTO    LOOP
;	    RETURN
;;**********************************************
;GECIKME_50MSN
;	    MOVLW   0x0F
;	    MOVWF   G1
;	    
;	    MOVLW   0x28
;	    MOVWF   G2
;LOOP1
;	    DECFSZ  G1,1
;	    GOTO    LOOP1
;	    
;	    DECFSZ  G2,1
;	    GOTO    LOOP1
;	    RETURN
;;*********************************************
;TETIK
;	    BANKSEL PORTB
;	    BSF	    PORTB,5
;	    CALL    GECIKME_200USN
;	    BCF	    PORTB,5
;	    RETURN
;;********************************************
;GONDER
;	    MOVWF   VERI
;	    
;	    SWAPF   VERI,0
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    
;	    MOVF    PORTB,W
;	    ANDLW   0xF0
;	    IORWF   TEMP,0
;	    
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    
;	    MOVF    VERI,W
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    
;	    MOVF    PORTB,W
;	    ANDLW   0xF0
;	    IORWF   TEMP,0
;	    
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    
;	    RETURN
;;***********************************************
;LCD_AYAR	    
;	BANKSEL	TRISB
;	CLRF	TRISB
;	BANKSEL	PORTB
;	CLRF	PORTB
;	
;	CALL	TETIK
;	CALL	GECIKME_50MSN
;	
;	CALL	TETIK
;	CALL	GECIKME_50MSN
;	
;	BCF	PORTB,4
;	
;	MOVLW	0x02
;	CALL	GONDER
;	
;	MOVLW	0x28
;	CALL	GONDER
;	
;        MOVLW   0x10	; imleci sola kayd?r
;        CALL    GONDER
;    
;        MOVLW   0x0D	;imlec yanip-sonen modda
;        CALL    GONDER
;	    
;        MOVLW   0x01	; ekrandaki her seyi siler 
;        CALL    GONDER
;	    
;        MOVLW   0x06	; veri yaz?l?r imlec saga konumlan?r
;	CALL    GONDER
;	RETURN
;;*******************************************
;ADC_AYAR
;	BANKSEL	ADCON0
;	MOVLW	0x89
;	MOVWF	ADCON0
;	
;	BANKSEL	ADCON1
;	MOVLW	0x80
;	MOVWF	ADCON1
;	
;	BANKSEL	TRISA
;	MOVLW	0xFF
;	MOVWF	TRISA
;	BANKSEL	PORTA
;	CLRF	PORTA
;	RETURN
;;******************************************
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
;;*****************************************
;CEVIR_L
;	MOVF	SAYI_L,1
;	BTFSC	STATUS,Z
;	RETURN
;	
;	DECF	SAYI_L,1
;	INCF	BIRLER,1
;	MOVLW	0x0A
;	SUBWF	BIRLER,0
;	BTFSS	STATUS,Z
;	GOTO	CEVIR_L
;	
;	CLRF	BIRLER
;	INCF	ONLAR,1
;	MOVLW	0x0A
;	SUBWF	ONLAR,0
;	BTFSS	STATUS,Z
;	GOTO	CEVIR_L
;	
;	CLRF	ONLAR
;	INCF	YUZLER,1
;	MOVLW	0x0A
;	SUBWF	YUZLER,0
;	BTFSS	STATUS,Z
;	GOTO	CEVIR_L
;	
;	CLRF	YUZLER
;	INCF	BINLER,1
;	MOVLW	0x0A
;	SUBWF	BINLER,0
;	BTFSS	STATUS,Z
;	GOTO	CEVIR_L
;	RETURN
;;************************************************
;CEVIR
;	MOVF	SAYI_H,1
;	BTFSC	STATUS,Z
;	GOTO	ATLA
;	CALL	CEVIR_H
;	
;ATLA
;	CALL	CEVIR_L
;	RETURN
;;*****************************************
;CEVIR_H
;	MOVF	SAYI_L,W
;	MOVWF	TEMP_L
;	
;HH
;	INCF	BIRLER,1
;	MOVLW	0xFF
;	MOVWF	SAYI_L
;	CALL	CEVIR_L
;	DECFSZ	SAYI_H,1
;	GOTO	HH
;	
;	MOVF	TEMP_L,W
;	MOVWF	SAYI_L
;	RETURN
;;******************************************** 
;TEMIZ
;	BANKSEL	    BIRLER
;	CLRF	    BIRLER
;	CLRF	    ONLAR
;	CLRF	    BINLER
;	CLRF	    YUZLER
;	RETURN
;;****************************************
;BASLA
;	   MOVLW    0x10
;	   MOVWF    SAYAC
;	   CALL	    LCD_AYAR
;	   CALL	    ADC_AYAR
;	   CALL	    KESME_AYAR
;	   
;;	   MOVLW    B'00000001'
;;	   MOVWF    SAYI_H
;;	   MOVLW    B'00000000'
;;	   MOVWF    SAYI_L
;	   
;	   CALL	    GECIKME_50MSN
;	   CALL	    GECIKME_50MSN
;	   CALL	    LCD_AYAR
;	   CALL	    TEMIZ
;	   CALL	    ADC_OKU
;	   CALL	    CEVIR
;	   
;	   BSF	    PORTB,4
;	   
;	   MOVF	    BINLER,W
;	   CALL	    ASCII_LOOKUP
;	   CALL	    GONDER
;	   
;	   MOVF	    YUZLER,W
;	   CALL	    ASCII_LOOKUP
;	   CALL	    GONDER
;	   
;	   MOVF	    ONLAR,W
;	   CALL	    ASCII_LOOKUP
;	   CALL	    GONDER
;	   
;	   MOVF	    BIRLER,W
;	   CALL	    ASCII_LOOKUP
;	   CALL	    GONDER
;DD	   
;	   GOTO	    DD
;	    END
    
    
    
    
    
    
    
    
    
    
    
    
    ;        	;TMR0 LI adc orn
;    	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG H'3F31'
;BIRLER	    EQU	0x20
;YUZLER	    EQU	0x21
;ONLAR	    EQU	0x22
;BINLER	    EQU	0x23
;	    
;G1	    EQU	0x24
;G2	    EQU	0x25
;	    
;VERI	    EQU	0x26
;TEMP	    EQU	0x27
;	    
;SAYI_H	    EQU	0x29
;SAYI_L	    EQU	0x28
;TEMP_L	    EQU	0x30
;	    
;SAYAC	    EQU	0x31
;	    
;W_TEMP	    EQU	0x7D
;STATUS_TEMP EQU	0x7E
;PCLATH_TEMP EQU	0x7F
;;*************************************************
;	ORG 0x000
;	NOP
;	GOTO	BASLA
;;************************************************
;	ORG 0x004
;	MOVWF	W_TEMP
;	MOVF	STATUS,W
;	MOVWF	STATUS_TEMP
;	MOVF	PCLATH,W
;	MOVWF	PCLATH_TEMP
;	
;	MOVLW	0x06
;	MOVWF	TMR0
;	BCF	INTCON,T0IF
;	
;	DECFSZ	SAYAC,1
;	GOTO	CIK
;	CALL	ISLEM
;CIK	
;	BSF	INTCON,GIE
;	MOVF	PCLATH_TEMP,W
;	MOVWF	PCLATH
;	MOVF	STATUS_TEMP
;	MOVWF	STATUS
;	SWAPF	W_TEMP,1
;	SWAPF	W_TEMP,0
;	RETFIE	
;;****************************************************
;ISLEM
;	   MOVLW    0xFF
;	   MOVWF    SAYAC
;	   
;	   CALL	    GECIKME_50MSN
;	   CALL	    GECIKME_50MSN
;	   CALL	    LCD_AYAR
;	   CALL	    TEMIZ
;	   CALL	    ADC_OKU
;	   CALL	    CEVIR
;	   
;	   BSF	    PORTB,4
;	   
;	   MOVF	    BINLER,W
;	   CALL	    ASCII_LOOKUP
;	   CALL	    GONDER
;	   
;	   MOVF	    YUZLER,W
;	   CALL	    ASCII_LOOKUP
;	   CALL	    GONDER
;	   
;	   MOVF	    ONLAR,W
;	   CALL	    ASCII_LOOKUP
;	   CALL	    GONDER
;	   
;	   MOVF	    BIRLER,W
;	   CALL	    ASCII_LOOKUP
;	   CALL	    GONDER
;	   RETURN
;;****************************************************
;ASCII_LOOKUP
;	    ADDWF   PCL,1
;	    RETLW   0x30
;	    RETLW   0x31
;	    RETLW   0x32
;	    RETLW   0x33
;	    RETLW   0x34
;	    RETLW   0x35
;	    RETLW   0x36
;	    RETLW   0x37
;	    RETLW   0x38
;	    RETLW   0x39
;;**********************************************************
;GECIKME_200USN
;	    MOVLW   0xC8
;	    MOVWF   G1
;LOOP
;	    DECFSZ  G1,1
;	    GOTO    LOOP
;	    RETURN
;;**********************************************
;GECIKME_50MSN
;	    MOVLW   0x0F
;	    MOVWF   G1
;	    
;	    MOVLW   0x28
;	    MOVWF   G2
;LOOP1
;	    DECFSZ  G1,1
;	    GOTO    LOOP1
;	    
;	    DECFSZ  G2,1
;	    GOTO    LOOP1
;	    RETURN
;;*********************************************
;TETIK
;	    BANKSEL PORTB
;	    BSF	    PORTB,5
;	    CALL    GECIKME_200USN
;	    BCF	    PORTB,5
;	    RETURN
;;********************************************
;GONDER
;	    MOVWF   VERI
;	    
;	    SWAPF   VERI,0
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    
;	    MOVF    PORTB,W
;	    ANDLW   0xF0
;	    IORWF   TEMP,0
;	    
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    
;	    MOVF    VERI,W
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    
;	    MOVF    PORTB,W
;	    ANDLW   0xF0
;	    IORWF   TEMP,0
;	    
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    
;	    RETURN
;;***********************************************
;LCD_AYAR	    
;	BANKSEL	TRISB
;	CLRF	TRISB
;	BANKSEL	PORTB
;	CLRF	PORTB
;	
;	CALL	TETIK
;	CALL	GECIKME_50MSN
;	
;	CALL	TETIK
;	CALL	GECIKME_50MSN
;	
;	BCF	PORTB,4
;	
;	MOVLW	0x02
;	CALL	GONDER
;	
;	MOVLW	0x28
;	CALL	GONDER
;	
;        MOVLW   0x10	; imleci sola kayd?r
;        CALL    GONDER
;    
;        MOVLW   0x0D	;imlec yanip-sonen modda
;        CALL    GONDER
;	    
;        MOVLW   0x01	; ekrandaki her seyi siler 
;        CALL    GONDER
;	    
;        MOVLW   0x06	; veri yaz?l?r imlec saga konumlan?r
;	CALL    GONDER
;	RETURN
;;*******************************************
;ADC_AYAR
;	BANKSEL	ADCON0
;	MOVLW	0x89
;	MOVWF	ADCON0
;	
;	BANKSEL	ADCON1
;	MOVLW	0x80
;	MOVWF	ADCON1
;	
;	BANKSEL	TRISA
;	MOVLW	0xFF
;	MOVWF	TRISA
;	BANKSEL	PORTA
;	CLRF	PORTA
;	RETURN
;;******************************************
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
;;*****************************************
;CEVIR_L
;	MOVF	SAYI_L,1
;	BTFSC	STATUS,Z
;	RETURN
;	
;	DECF	SAYI_L,1
;	INCF	BIRLER,1
;	MOVLW	0x0A
;	SUBWF	BIRLER,0
;	BTFSS	STATUS,Z
;	GOTO	CEVIR_L
;	
;	CLRF	BIRLER
;	INCF	ONLAR,1
;	MOVLW	0x0A
;	SUBWF	ONLAR,0
;	BTFSS	STATUS,Z
;	GOTO	CEVIR_L
;	
;	CLRF	ONLAR
;	INCF	YUZLER,1
;	MOVLW	0x0A
;	SUBWF	YUZLER,0
;	BTFSS	STATUS,Z
;	GOTO	CEVIR_L
;	
;	CLRF	YUZLER
;	INCF	BINLER,1
;	MOVLW	0x0A
;	SUBWF	BINLER,0
;	BTFSS	STATUS,Z
;	GOTO	CEVIR_L
;	RETURN
;;************************************************
;CEVIR
;	MOVF	SAYI_H,1
;	BTFSC	STATUS,Z
;	GOTO	ATLA
;	CALL	CEVIR_H
;	
;ATLA
;	CALL	CEVIR_L
;	RETURN
;;*****************************************
;CEVIR_H
;	MOVF	SAYI_L,W
;	MOVWF	TEMP_L
;	
;HH
;	INCF	BIRLER,1
;	MOVLW	0xFF
;	MOVWF	SAYI_L
;	CALL	CEVIR_L
;	DECFSZ	SAYI_H,1
;	GOTO	HH
;	
;	MOVF	TEMP_L,W
;	MOVWF	SAYI_L
;	RETURN
;;******************************************** 
;TEMIZ
;	BANKSEL	    BIRLER
;	CLRF	    BIRLER
;	CLRF	    ONLAR
;	CLRF	    BINLER
;	CLRF	    YUZLER
;	RETURN
;;******************************************
;KESME_AYAR
;	BANKSEL	    INTCON
;	BSF	    INTCON,GIE
;	BSF	    INTCON,T0IE
;	BCF	    INTCON,T0IF
;	
;	BANKSEL	    OPTION_REG
;	MOVLW	    B'00000100'
;	MOVWF	    OPTION_REG
;	
;	BANKSEL	    TMR0
;	MOVLW	    0x06
;	MOVWF	    TMR0
;	RETURN
;;****************************************
;BASLA
;	   MOVLW    0x10
;	   MOVWF    SAYAC
;	   CALL	    LCD_AYAR
;	   CALL	    ADC_AYAR
;	   CALL	    KESME_AYAR
;	   
;;	   MOVLW    B'00000001'
;;	   MOVWF    SAYI_H
;;	   MOVLW    B'00000000'
;;	   MOVWF    SAYI_L
;DD	   
;	   GOTO	    DD
;	    END
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ;        	;adc orn
;    	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG H'3F31'
;BIRLER	    EQU	0x20
;YUZLER	    EQU	0x21
;ONLAR	    EQU	0x22
;BINLER	    EQU	0x23
;	    
;G1	    EQU	0x24
;G2	    EQU	0x25
;	    
;VERI	    EQU	0x26
;TEMP	    EQU	0x27
;	    
;SAYI_H	    EQU	0x29
;SAYI_L	    EQU	0x28
;TEMP_L	    EQU	0x30
;;*************************************************
;	ORG 0x000
;	NOP
;	GOTO	BASLA
;;************************************************
;	ORG 0x004
;	RETFIE	
;;****************************************************
;ASCII_LOOKUP
;	    ADDWF   PCL,1
;	    RETLW   0x30
;	    RETLW   0x31
;	    RETLW   0x32
;	    RETLW   0x33
;	    RETLW   0x34
;	    RETLW   0x35
;	    RETLW   0x36
;	    RETLW   0x37
;	    RETLW   0x38
;	    RETLW   0x39
;;**********************************************************
;GECIKME_200USN
;	    MOVLW   0xC8
;	    MOVWF   G1
;LOOP
;	    DECFSZ  G1,1
;	    GOTO    LOOP
;	    RETURN
;;**********************************************
;GECIKME_50MSN
;	    MOVLW   0x0F
;	    MOVWF   G1
;	    
;	    MOVLW   0x28
;	    MOVWF   G2
;LOOP1
;	    DECFSZ  G1,1
;	    GOTO    LOOP1
;	    
;	    DECFSZ  G2,1
;	    GOTO    LOOP1
;	    RETURN
;;*********************************************
;TETIK
;	    BANKSEL PORTB
;	    BSF	    PORTB,5
;	    CALL    GECIKME_200USN
;	    BCF	    PORTB,5
;	    RETURN
;;********************************************
;GONDER
;	    MOVWF   VERI
;	    
;	    SWAPF   VERI,0
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    
;	    MOVF    PORTB,W
;	    ANDLW   0xF0
;	    IORWF   TEMP,0
;	    
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    
;	    MOVF    VERI,W
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    
;	    MOVF    PORTB,W
;	    ANDLW   0xF0
;	    IORWF   TEMP,0
;	    
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    
;	    RETURN
;;***********************************************
;LCD_AYAR	    
;	BANKSEL	TRISB
;	CLRF	TRISB
;	BANKSEL	PORTB
;	CLRF	PORTB
;	
;	CALL	TETIK
;	CALL	GECIKME_50MSN
;	
;	CALL	TETIK
;	CALL	GECIKME_50MSN
;	
;	BCF	PORTB,4
;	
;	MOVLW	0x02
;	CALL	GONDER
;	
;	MOVLW	0x28
;	CALL	GONDER
;	
;        MOVLW   0x10	; imleci sola kayd?r
;        CALL    GONDER
;    
;        MOVLW   0x0D	;imlec yanip-sonen modda
;        CALL    GONDER
;	    
;        MOVLW   0x01	; ekrandaki her seyi siler 
;        CALL    GONDER
;	    
;        MOVLW   0x06	; veri yaz?l?r imlec saga konumlan?r
;	CALL    GONDER
;	RETURN
;;*******************************************
;ADC_AYAR
;	BANKSEL	ADCON0
;	MOVLW	0x89
;	MOVWF	ADCON0
;	
;	BANKSEL	ADCON1
;	MOVLW	0x80
;	MOVWF	ADCON1
;	
;	BANKSEL	TRISA
;	MOVLW	0xFF
;	MOVWF	TRISA
;	BANKSEL	PORTA
;	CLRF	PORTA
;	RETURN
;;******************************************
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
;;*****************************************
;CEVIR_L
;	MOVF	SAYI_L,1
;	BTFSC	STATUS,Z
;	RETURN
;	
;	DECF	SAYI_L,1
;	INCF	BIRLER,1
;	MOVLW	0x0A
;	SUBWF	BIRLER,0
;	BTFSS	STATUS,Z
;	GOTO	CEVIR_L
;	
;	CLRF	BIRLER
;	INCF	ONLAR,1
;	MOVLW	0x0A
;	SUBWF	ONLAR,0
;	BTFSS	STATUS,Z
;	GOTO	CEVIR_L
;	
;	CLRF	ONLAR
;	INCF	YUZLER,1
;	MOVLW	0x0A
;	SUBWF	YUZLER,0
;	BTFSS	STATUS,Z
;	GOTO	CEVIR_L
;	
;	CLRF	YUZLER
;	INCF	BINLER,1
;	MOVLW	0x0A
;	SUBWF	BINLER,0
;	BTFSS	STATUS,Z
;	GOTO	CEVIR_L
;	RETURN
;;************************************************
;CEVIR
;	MOVF	SAYI_H,1
;	BTFSC	STATUS,Z
;	GOTO	ATLA
;	CALL	CEVIR_H
;	
;ATLA
;	CALL	CEVIR_L
;	RETURN
;;*****************************************
;CEVIR_H
;	MOVF	SAYI_L,W
;	MOVWF	TEMP_L
;	
;HH
;	INCF	BIRLER,1
;	MOVLW	0xFF
;	MOVWF	SAYI_L
;	CALL	CEVIR_L
;	DECFSZ	SAYI_H,1
;	GOTO	HH
;	
;	MOVF	TEMP_L,W
;	MOVWF	SAYI_L
;	RETURN
;;******************************************** 
;TEMIZ
;	BANKSEL	    BIRLER
;	CLRF	    BIRLER
;	CLRF	    ONLAR
;	CLRF	    BINLER
;	CLRF	    YUZLER
;	RETURN
;;******************************************
;BASLA
;	   CALL	    LCD_AYAR
;	   CALL	    ADC_AYAR
;	   
;	   
;;	   MOVLW    B'00000001'
;;	   MOVWF    SAYI_H
;;	   MOVLW    B'00000000'
;;	   MOVWF    SAYI_L
;DD	   
;	   CALL	    GECIKME_50MSN
;	   CALL	    GECIKME_50MSN
;	   CALL	    LCD_AYAR
;	   CALL	    TEMIZ
;	   CALL	    ADC_OKU
;	   CALL	    CEVIR
;	   
;	   BSF	    PORTB,4
;	   
;	   MOVF	    BINLER,W
;	   CALL	    ASCII_LOOKUP
;	   CALL	    GONDER
;	   
;	   MOVF	    YUZLER,W
;	   CALL	    ASCII_LOOKUP
;	   CALL	    GONDER
;	   
;	   MOVF	    ONLAR,W
;	   CALL	    ASCII_LOOKUP
;	   CALL	    GONDER
;	   
;	   MOVF	    BIRLER,W
;	   CALL	    ASCII_LOOKUP
;	   CALL	    GONDER
;	   
;
;	   GOTO	    DD
;	    END
    
    
    
    
    ;    	;;;255 SONRAKI SAYILAR ICIN
;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;BIRLER	    EQU	0x20
;YUZLER	    EQU	0x21
;ONLAR	    EQU	0x22
;BINLER	    EQU	0x23
;	    
;G1	    EQU	0x24
;G2	    EQU	0x25
;	    
;VERI	    EQU	0x26
;TEMP	    EQU	0x27
;	    
;SAYI_H	    EQU	0x29
;SAYI_L	    EQU	0x28
;TEMP_L	    EQU	0x30
;;*************************************************
;	ORG 0x000
;	NOP
;	GOTO	BASLA
;;************************************************
;	ORG 0x004
;	RETFIE	
;;****************************************************
;ASCII_LOOKUP
;	    ADDWF   PCL,1
;	    RETLW   0x30
;	    RETLW   0x31
;	    RETLW   0x32
;	    RETLW   0x33
;	    RETLW   0x34
;	    RETLW   0x35
;	    RETLW   0x36
;	    RETLW   0x37
;	    RETLW   0x38
;	    RETLW   0x39
;;**********************************************************
;GECIKME_200USN
;	    MOVLW   0xC8
;	    MOVWF   G1
;LOOP
;	    DECFSZ  G1,1
;	    GOTO    LOOP
;	    RETURN
;;**********************************************
;GECIKME_50MSN
;	    MOVLW   0x0F
;	    MOVWF   G1
;	    
;	    MOVLW   0x28
;	    MOVWF   G2
;LOOP1
;	    DECFSZ  G1,1
;	    GOTO    LOOP1
;	    
;	    DECFSZ  G2,1
;	    GOTO    LOOP1
;	    RETURN
;;*********************************************
;TETIK
;	    BANKSEL PORTB
;	    BSF	    PORTB,5
;	    CALL    GECIKME_200USN
;	    BCF	    PORTB,5
;	    RETURN
;;********************************************
;GONDER
;	    MOVWF   VERI
;	    
;	    SWAPF   VERI,0
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    
;	    MOVF    PORTB,W
;	    ANDLW   0xF0
;	    IORWF   TEMP,0
;	    
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    
;	    MOVF    VERI,W
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    
;	    MOVF    PORTB,W
;	    ANDLW   0xF0
;	    IORWF   TEMP,0
;	    
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    
;	    RETURN
;;***********************************************
;LCD_AYAR	    
;	BANKSEL	TRISB
;	CLRF	TRISB
;	BANKSEL	PORTB
;	CLRF	PORTB
;	
;	CALL	TETIK
;	CALL	GECIKME_50MSN
;	
;	CALL	TETIK
;	CALL	GECIKME_50MSN
;	
;	BCF	PORTB,4
;	
;	MOVLW	0x02
;	CALL	GONDER
;	
;	MOVLW	0x28
;	CALL	GONDER
;	
;        MOVLW   0x10	; imleci sola kayd?r
;        CALL    GONDER
;    
;        MOVLW   0x0D	;imlec yanip-sonen modda
;        CALL    GONDER
;	    
;        MOVLW   0x01	; ekrandaki her seyi siler 
;        CALL    GONDER
;	    
;        MOVLW   0x06	; veri yaz?l?r imlec saga konumlan?r
;	CALL    GONDER
;	RETURN
;;*******************************************
;CEVIR_L
;	MOVF	SAYI_L,1
;	BTFSC	STATUS,Z
;	RETURN
;	
;	DECF	SAYI_L,1
;	INCF	BIRLER,1
;	MOVLW	0x0A
;	SUBWF	BIRLER,0
;	BTFSS	STATUS,Z
;	GOTO	CEVIR_L
;	
;	CLRF	BIRLER
;	INCF	ONLAR,1
;	MOVLW	0x0A
;	SUBWF	ONLAR,0
;	BTFSS	STATUS,Z
;	GOTO	CEVIR_L
;	
;	CLRF	ONLAR
;	INCF	YUZLER,1
;	MOVLW	0x0A
;	SUBWF	YUZLER,0
;	BTFSS	STATUS,Z
;	GOTO	CEVIR_L
;	
;	CLRF	YUZLER
;	INCF	BINLER,1
;	MOVLW	0x0A
;	SUBWF	BINLER,0
;	BTFSS	STATUS,Z
;	GOTO	CEVIR_L
;	RETURN
;;************************************************
;CEVIR
;	MOVF	SAYI_H,1
;	BTFSC	STATUS,Z
;	GOTO	ATLA
;	CALL	CEVIR_H
;	
;ATLA
;	CALL	CEVIR_L
;	RETURN
;;*****************************************
;CEVIR_H
;	MOVF	SAYI_L,1
;	MOVWF	TEMP_L
;HH
;	INCF	BIRLER,1
;	MOVLW	0xFF
;	MOVWF	SAYI_L
;	CALL	CEVIR_L
;	DECFSZ	SAYI_H,1
;	GOTO	HH
;	
;	MOVF	TEMP_L,0
;	MOVWF	SAYI_L
;	RETURN
;;******************************************** 
;BASLA
;	   CALL	    LCD_AYAR
;	   BSF	    PORTB,4
;	   MOVLW    B'00000011'
;	   MOVWF    SAYI_H
;	   MOVLW    B'11111111'
;	   MOVWF    SAYI_L
;
;	   CALL	    CEVIR
;	   
;	   MOVF	    BINLER,W
;	   CALL	    ASCII_LOOKUP
;	   CALL	    GONDER
;	   
;	   MOVF	    YUZLER,W
;	   CALL	    ASCII_LOOKUP
;	   CALL	    GONDER
;	   
;	   MOVF	    ONLAR,W
;	   CALL	    ASCII_LOOKUP
;	   CALL	    GONDER
;	   
;	   MOVF	    BIRLER,W
;	   CALL	    ASCII_LOOKUP
;	   CALL	    GONDER
;	   CALL	    GECIKME_50MSN
;DD
;	   GOTO	    DD
;	   END
    
    
    

	    
	    
	    
;    ;ekrananin ust tarafina ad ve soyad yazan uygulama
;    	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG H'3F31'
;	
;G1	EQU 0x20
;G2	EQU 0x21
;VERI	EQU 0x22
;TEMP	EQU 0x24
;SAYAC	EQU 0x25
;	
;SATIR_KONUM	EQU	0x26	; LCD EKRANIN GIDILECEK SATIR BILGISI
;SUTUN_KONUM	EQU	0x27	; LCD EKRANIN GIDILECEK SUTUN BILGISI
;;***************************************************
;	    ORG	0x000
;	    NOP
;	    GOTO    BASLA
;;********************************************************
;	    ORG	0x004
;	    RETFIE
;;****************************************************
;GECIKME_200USN
;	    MOVLW   0xC8
;	    MOVWF   G1
;LOOP1
;	    DECFSZ  G1,1
;	    GOTO    LOOP1
;	    RETURN
;;*****************************************************
;GECIKME_5MSN
;	    MOVLW   0xE7
;	    MOVWF   G1
;	    
;	    MOVLW   0x04
;	    MOVWF   G2
;LOOP2
;	    DECFSZ  G1,1
;	    GOTO    LOOP2
;	    
;	    DECFSZ  G2,1
;	    GOTO    LOOP2
;	    RETURN
;;******************************************************************
;GECIKME_50MSN
;	    MOVLW   0x0F
;	    MOVWF   G1
;	    
;	    MOVLW   0x28
;	    MOVWF   G2
;LOOP3
;	    DECFSZ  G1,1
;	    GOTO    LOOP3
;	    
;	    DECFSZ  G2,1
;	    GOTO    LOOP3
;	    RETURN
;;***************************************************************************
;TETIK
;	    BANKSEL PORTB
;	    BSF	    PORTB,5
;	    CALL    GECIKME_200USN
;	    BCF	    PORTB,5
;	    RETURN
;;******************************************
;LCD_AYAR
;	    BANKSEL TRISB
;	    CLRF    TRISB
;	    BANKSEL PORTB
;	    CLRF    PORTB
;	    
;	    BCF	    PORTB,4
;	    
;	    CALL    TETIK
;	    CALL    GECIKME_200USN
;
;	    CALL    TETIK
;	    CALL    GECIKME_200USN
;	    
;	    MOVLW   0x02
;	    CALL    GONDER
;	    
;	    MOVLW   0x28	;verinin 4. bitlik sekilde gelecegini belirtir
;	    CALL    GONDER
;	    
;	    MOVLW   0x10	; imleci sola kayd?r
;	    CALL    GONDER
;	    
;	    MOVLW   0x0D	;imlec yanip-sonen modda
;	    CALL    GONDER
;	    
;	    MOVLW   0x01	; ekrandaki her seyi siler 
;	    CALL    GONDER
;	    
;	    MOVLW   0x06	; veri yaz?l?r imlec saga konumlan?r
;	    CALL    GONDER
;	    
;;	    MOVLW   0xC0	;ikinci satirda ekrana yazar
;;	    CALL    GONDER
;	    
;;	    MOVLW   0x88	;ilk satirin nin ortasindan yazmaya baslar
;;	    CALL    GONDER
;	    
;;	    MOVLW   0xC8	;ikinci satirin nin ortasindan yazmaya baslar(c0 olmas?na gerek yok)
;;	    CALL    GONDER
;	    RETURN
;;*************************************
;GONDER
;	    MOVWF   VERI
;
;	    SWAPF   VERI,W
;	    ANDLW   0x0F
;	    
;	    MOVWF   TEMP
;	    
;	    MOVF    PORTB,W
;	    ANDLW   0xF0
;	    
;	    IORWF   TEMP,0
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    
;	    MOVF    VERI,W
;	    
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    
;	    MOVF    PORTB,W
;	    ANDLW   0xF0
;	    
;	    IORWF   TEMP,0
;	    MOVWF   PORTB
;	    CALL    TETIK	    
;	    RETURN
;;******************************************************
;BASLA
;	CALL	LCD_AYAR
;	
;	BSF	PORTB,4
;
;	MOVLW	0x45
;	CALL	GONDER
;	MOVLW	0x59
;	CALL	GONDER
;	MOVLW	0x55
;	CALL	GONDER
;	MOVLW	0x50
;	CALL	GONDER
;	MOVLW	0x20
;	CALL	GONDER
;		
;	MOVLW	0x41
;	CALL	GONDER
;	MOVLW	0x4B
;	CALL	GONDER
;	MOVLW	0x44
;	CALL	GONDER
;	MOVLW	0x45
;	CALL	GONDER
;	MOVLW	0x4E
;	CALL	GONDER
;	MOVLW	0x49
;	CALL	GONDER
;	MOVLW	0x5A
;	CALL	GONDER
;	
;DD  
;	    GOTO    DD
;	    END

    
    
     
	    
    ;;ekrana A harfini yazan uygulama
    ;	list		p=16f877A	
;	#include	<p16f877A.inc>	
;	
;	__CONFIG H'3F31'
;	
;G1	EQU 0x20
;G2	EQU 0x21
;VERI	EQU 0x22
;TEMP	EQU 0x24
;	
;;***************************************************
;	    ORG	0x000
;	    NOP
;	    GOTO    BASLA
;;********************************************************
;	    ORG	0x004
;	    RETFIE
;;****************************************************
;GECIKME_200USN
;	    MOVLW   0xC8
;	    MOVWF   G1
;LOOP1
;	    DECFSZ  G1,1
;	    GOTO    LOOP1
;	    RETURN
;;*****************************************************
;GECIKME_5MSN
;	    MOVLW   0xE7
;	    MOVWF   G1
;	    
;	    MOVLW   0x04
;	    MOVWF   G2
;LOOP2
;	    DECFSZ  G1,1
;	    GOTO    LOOP2
;	    
;	    DECFSZ  G2,1
;	    GOTO    LOOP2
;	    RETURN
;;******************************************************************
;GECIKME_50MSN
;	    MOVLW   0x0F
;	    MOVWF   G1
;	    
;	    MOVLW   0x28
;	    MOVWF   G2
;LOOP3
;	    DECFSZ  G1,1
;	    GOTO    LOOP3
;	    
;	    DECFSZ  G2,1
;	    GOTO    LOOP3
;	    RETURN
;;***************************************************************************
;TETIK	    ; her cal?st?g?nda LCD PORTB'deki gelen veriyi okur
;	    BANKSEL PORTB
;	    BSF	    PORTB,5		;E pinine dusen kenar olusturmak icin 1 verd?k
;	    CALL    GECIKME_200USN
;	    BCF	    PORTB,5
;	    
;	    RETURN
;;********************************************************
;GONDER
;	    MOVWF   VERI
;	    SWAPF   VERI,W
;	    
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    
;	    MOVF    PORTB,W
;	    ANDLW   0xF0
;	    
;	    IORWF   TEMP,W
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    
;	    
;	    
;	    MOVF    VERI,W
;	    
;	    ANDLW   0x0F
;	    MOVWF   TEMP
;	    
;	    MOVF    PORTB,W
;	    ANDLW   0xF0
;	    
;	    IORWF   TEMP,W
;	    MOVWF   PORTB
;	    CALL    TETIK
;	    RETURN
;;*********************************************
;LCD_AYAR
;	    BANKSEL TRISB
;	    CLRF    TRISB
;	    BANKSEL PORTB
;	    CLRF    PORTB
;	    
;	    BCF	    PORTB,4	    ;RS BITI 0 OLDUGU ICIN KOMUT ALIR
;	    CALL    TETIK
;	    CALL    GECIKME_20USN
;	    
;	    CALL    TETIK
;	    CALL    GECIKME_20USN
;	    
;	    MOVLW   0x02
;	    CALL    GONDER
;	    
;	    MOVLW   0x28
;	    CALL    GONDER
;	    
;	    MOVLW   0x10
;	    CALL    GONDER
;	    
;	    MOVLW   0x0D
;	    CALL    GONDER
;	    
;	    MOVLW   0x01
;	    CALL    GONDER
;	    
;	    MOVLW   0x06
;	    CALL    GONDER
;	    RETURN
;;********************************************************
;BASLA
;	    CALL    LCD_AYAR
;	    
;	    BSF	    PORTB,4	    ;RS BITI 1 OLDUGU ICIN VERI ALMAYA HAZIR
;	    MOVLW   0x41
;	    CALL    GONDER
;DON
;	    GOTO    DON
;	    END
	    


