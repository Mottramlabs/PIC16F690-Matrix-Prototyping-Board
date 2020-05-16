;                   *************************************** Title block ***********************************************
;		Customer:		Mottramlabs
;		Product:		Hello World
;		Last update:        8th April 2020
;		Author:		David Mottram
;		Device:		PIC16F690
;		Clock:		16MHz Crystal
;		---------------------------------------------------------------------------------------------------
; Revision notes:

                    #define		F_CPU               8000000            ;Xtal frequency

		;Device Selection
		include		PIC16F690_Config_Bits.asm               ;Configuration Bits
		include		PIC16F690_Registers.asm		;Regsiters and bits

                    ;************************************* General purpose registers 20h - 7Fh ************************
                    CBLOCK		020h                                    ;Start of Variable space address
                    Time_1                                                      ;Used by timers
                    Time_2						;Used by timers
                    Time_3						;Used by timers
                    Temp_1						;Temp Reg.
                    Temp_2						;Temp Reg.
                    Temp_3						;Temp Reg.
                    Temp_4						;Temp Reg.
                    Temp_5						;Temp Reg.
                    Temp_6						;Temp Reg.
                    Temp_7						;Temp Reg.													;Temp Reg.
                    ENDC														;End if C Block

                    #define             LED                 4                   ;LED connection
                    
		org		00h                                     ;Reset vector

                    ;Set all analog inputs as digital
                    bcf                 ADON                                    ;A/D off
                    bsf                 Status,RP1                 		;Reg bank select
                    movlw               b'00000000'			;Load w, Enable AN5 and AN6. Page 61 of data sheet
                    movwf               ANSEL				;Set ports as digital I/O
                    movlw               b'00000000'			;Load w
                    movwf               ANSELH				;Set ports as digital I/O
                    bcf		Status,RP1			;Reg bank select

                    ;Define and enable I/O
                    ;#Define		PCB_LED             Port_A,LED            ;LED
                    bsf		Status,RP0			;Reg bank select
                    ;bcf		TRISA,LED				;Output
                    
                    clrf               TRISA
                    clrf               TRISB
                    clrf               TRISC
                    bcf		Status,RP0			;Reg bank select
                    
        		;bcf		PCB_LED                                 ;LED Control

                    goto                Start				;Jump
                    
                    ;--------------------------------------------------------------------------------------------------------------
                    ;*********************************  Start of Sub routines *****************************************************
                    ;--------------------------------------------------------------------------------------------------------------

		include		Timer_SUBS.asm			;Timer sub routines

		;-------------------------------------------------------------------------------------------------
		;********************************* End of Sub routines *******************************************
		;-------------------------------------------------------------------------------------------------

Start		;Program start

                    
        
                    
                    movlw               .004                                    ;Load w, number of flash loops
                    movwf               Temp_1                                  ;Load reg
Loop                ;Flash loop
;            	bsf		PCB_LED                                 ;LED Control
                    movlw               0xFF
                    movwf               Port_A
                    movwf               Port_B
                    movwf               Port_C
              
		call                Del_10mS                                ;Delay
;		bcf		PCB_LED                                 ;LED Control
                    movlw               0x00
                    movwf               Port_A
                    movwf               Port_B
                    movwf               Port_C

                    
                    call                Del_100mS                               ;Delay
                    call                Del_100mS                               ;Delay
                    decfsz              Temp_1,1                                ;Dec counter and skip next if zero
                    goto                Loop                                    ;Next flash
                    
                    call                Del_1S                                  ;Delay

                    goto                Start                                   ;Loop
		    
end
	    
