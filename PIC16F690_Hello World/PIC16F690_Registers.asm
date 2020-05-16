;-------------------------------------------------------------------------------------------------------
;REG_16F690.asm
;Date:              27th April 2020
;-------------------------------------------------------------------------------------------------------
;label(1)           item1(21)           item2(41)           item3(61)           REM(81)
;-------------------------------------------------------------------------------------------------------
                                                  
                    ;********** Function Registers ********************************************************************************************
                    INDF		equ		00h                 ;Indirect address
                    PC      		equ     		02h             	;Program counter
                    PCL      		equ     		02h             	;Program counter
                    FSR		equ		04h		;File select register 
                    PCLATH              equ		0Ah		;Page select

                    OPTION_REG	equ		81h		;Option register
		#Define		RBPU	    	OPTION_REG,7	;PORTB Pull-up Enable bit
		#Define		INTEDG      	OPTION_REG,6	;Interrupt Edge Select bit
		#Define		T0CS        	OPTION_REG,5	;Clock Source Select bit
		#Define		T0SE        	OPTION_REG,4	;Source Edge Select bit
		#Define		PSA         	OPTION_REG,3	;Prescaler Assignment bit
		#Define		PS2         	OPTION_REG,2	;Prescaler Rate Select bit 2
		#Define		PS1         	OPTION_REG,1	;Prescaler Rate Select bit 1
		#Define		PS0         	OPTION_REG,0	;Prescaler Rate Select bit 0

		Status  		equ                 03h             	;Status Reg.
		;Below are for older programs, kept so as to support these older programs
		Carry   		equ     		00h             	;Carry bit
		Zflag   		equ     		02h             	;Zero bit of status
		RP0		equ		05h		;Reg bank control
		RP1		equ		06h		;Reg bank control
		IRP		equ		07h		;IRP bit
		;Below are the new prefered versions
		#Define		Register_Bank_1 	Status,6		;Register Bank Select bits (used for direct addressing)
		#Define		Register_Bank_0 	Status,5		;Register Bank Select bits (used for direct addressing)
		#Define		Time_Out		Status,4		;Time-out bit
		#Define		Power_Down	Status,3		;Power-down bit
		#Define		Zero_Flag 	Status,2		;Zero bit
		#Define		Digit_Carry	Status,1		;Digit carry/borrow bit (ADDWF, ADDLW,SUBLW,SUBWF instructions)
		#Define		Carry_Flag	Status,0		;Carry/borrow bit (ADDWF, ADDLW,SUBLW,SUBWF instructions)

		;********** I/O Port Registers ********************************************************************************************
		Port_A		equ		05h		;Port Register
		#Define		RA0		Port_A,0		;I/O Pin
		#Define		RA1		Port_A,1		;I/O Pin
		#Define		RA2		Port_A,2		;I/O Pin
		#Define		RA3		Port_A,3		;I/O Pin
		#Define		RA4		Port_A,4		;I/O Pin
		#Define		RA5		Port_A,5		;I/O Pin
		#Define		RA6		Port_A,6		;I/O Pin
		#Define		RA7		Port_A,7		;I/O Pin
		Port_B		equ		06h		;Port Register
		#Define		RB0		Port_B,0		;I/O Pin
		#Define		RB1		Port_B,1		;I/O Pin
		#Define		RB2		Port_B,2		;I/O Pin
		#Define		RB3		Port_B,3		;I/O Pin
		#Define		RB4		Port_B,4		;I/O Pin
		#Define		RB5		Port_B,5		;I/O Pin
		#Define		RB6		Port_B,6		;I/O Pin
		#Define		RB7		Port_B,7		;I/O Pin
                    Port_C		equ		07h		;Port Register
		#Define		RC0		Port_C,0		;I/O Pin
		#Define		RC1		Port_C,1		;I/O Pin
		#Define		RC2		Port_C,2		;I/O Pin
		#Define		RC3		Port_C,3		;I/O Pin
		#Define		RC4		Port_C,4		;I/O Pin
		#Define		RC5		Port_C,5		;I/O Pin
		#Define		RC6		Port_C,6		;I/O Pin
		#Define		RC7		Port_C,7		;I/O Pin
		TRISA		equ		85h		;Trisate port
		#Define		TRISA0		TRISA,0		;I/O Pin
		#Define		TRISA1		TRISA,1		;I/O Pin
		#Define		TRISA2		TRISA,2		;I/O Pin
		#Define		TRISA3		TRISA,3		;I/O Pin
		#Define		TRISA4		TRISA,4		;I/O Pin
		#Define		TRISA5		TRISA,5		;I/O Pin
                    #Define		TRISA6		TRISA,6		;I/O Pin
		#Define		TRISA7		TRISA,7		;I/O Pin
		TRISB		equ		86h		;Trisate port
		#Define		TRISB0		TRISB,0		;I/O Pin
		#Define		TRISB1		TRISB,1		;I/O Pin
		#Define		TRISB2		TRISB,2		;I/O Pin
		#Define		TRISB3		TRISB,3		;I/O Pin
		#Define		TRISB4		TRISB,4		;I/O Pin
		#Define		TRISB5		TRISB,5		;I/O Pin
		#Define		TRISB6		TRISB,6		;I/O Pin
		#Define		TRISB7		TRISB,7		;I/O Pin
		TRISC		equ		87h		;Trisate port
		#Define		TRISC0		TRISC,0		;I/O Pin
		#Define		TRISC1		TRISC,1		;I/O Pin
		#Define		TRISC2		TRISC,2		;I/O Pin
		#Define		TRISC3		TRISC,3		;I/O Pin
		#Define		TRISC4		TRISC,4		;I/O Pin
		#Define		TRISC5		TRISC,5		;I/O Pin
		#Define		TRISC6		TRISC,6		;I/O Pin
		#Define		TRISC7		TRISC,7		;I/O Pin
		WPUA		equ		95h		;Weak pull select for Port A
		#Define		WPUA5		WPUA,5		;Weak pullup
		#Define		WPUA4		WPUA,4		;Weak pullup
		#Define		WPUA2		WPUA,2		;Weak pullup
		#Define		WPUA1		WPUA,1		;Weak pullup
		#Define		WPUA0		WPUA,0		;Weak pullup
		WPUB		equ		115h		;Weak pull select for Port B
		#Define		WPUB7		WPUB,7		;Weak pullup
		#Define		WPUB6		WPUB,6		;Weak pullup
		#Define		WPUB5		WPUB,5		;Weak pullup
		#Define		WPUB4		WPUB,4		;Weak pullup

		;********** Interrupt Control Registers ***********************************************************************************
		INTCON		equ		0Bh		;Interupt control register
		#Define		GIE		INTCON,7		;Global Interrupt Enable bit
		#Define		PEIE		INTCON,6		;Peripheral Interrupt Enable bit
		#Define		T0IE		INTCON,5		;TMR0 Overflow Interrupt Enable bit
		#Define		INTE		INTCON,4		;RB0/INT External Interrupt Enable bit
		#Define		RBIE		INTCON,3		;RB Port Change Interrupt Enable bit
		#Define		T0IF		INTCON,2		;TMR0 Overflow Interrupt Flag bit
		#Define		INTF		INTCON,1		;RB0/INT External Interrupt Flag bit
		#Define		RBIF		INTCON,0		;RB Port Change Interrupt Flag bit

		PIE1		equ		8Ch		;Peripheral Interrupt Enable Register 1
		#Define		PSPIE   		PIE1,7		;Parallel Slave Port Read/Write Interrupt Enable
		#Define		ADIE     		PIE1,6		;A/D Converter Interrupt Enable bit
		#Define		RCIE     		PIE1,5		;USART Receive Interrupt Enable bit
		#Define		TXIE      	PIE1,4		;USART Transmit Interrupt Enable bit
		#Define		SSPIE      	PIE1,3		;Synchronous Serial Port Interrupt Enable bit
		#Define		CCP1IE      	PIE1,2		;CCP1 Interrupt Enable bit
		#Define		TMR2IE        	PIE1,1		;TMR2 to PR2 Match Interrupt Enable bit
		#Define		TMR1IE       	PIE1,0		;TMR1 Overflow Interrupt Enable bit

                    PIE2		equ		8Dh		;Peripheral Interrupt Enable Register 2
		#Define		EEIE 		PIE2,4		;EEPROM Write Operation Inte
		#Define		BCLIE 		PIE2,3		;Bus Collision Interrupt Enabl
		#Define		CCP2IE 		PIE2,0		;CCP2 Interrupt Enable bit
			
                    PIR1		equ		0Ch		;Peripheral Interrupt Register 1
		#Define		PSPIF 		PIR1,7		;Parallel Slave Port Read/Write Interrupt Flag bit
		#Define		ADIF            	PIR1,6		;A/D Converter Interrupt Flag bit
		#Define		RCIF            	PIR1,5		;USART Receive Interrupt Flag bit
		#Define		TXIF            	PIR1,4		;USART Transmit Interrupt Flag bit
		#Define		SSPIF           	PIR1,3		;Synchronous Serial Port (SSP) Interrupt Flag
		#Define		CCP1IF          	PIR1,2		;CCP1 Interrupt Flag bit
		#Define		TMR2IF          	PIR1,1		;TMR2 to PR2 Match Interrupt Flag bit
		#Define		TMR1IF          	PIR1,0		;TMR1 Overflow Interrupt Flag bit

                    PIR2		equ		0Dh		;Peripheral Interrupt Register 2
		#Define		EEIF     		PIR2,4		;EEPROM Write Operation Interrupt Flag bit
		#Define		BCLIF    		PIR2,3		;BCLIF: Bus Collision Interrupt Flag bit
		#Define		CCP2IF   		PIR2,0		;CCP2 Interrupt Flag bit

		IOCA		equ		095h		;Interupt On Change Port A
		#Define		IOCA5		IOCA,5		;Interupt on Change Port A, 1=Enabled
		#Define		IOCA4		IOCA,4		;Interupt on Change Port A, 1=Enabled
		#Define		IOCA3		IOCA,3		;Interupt on Change Port A, 1=Enabled
		#Define		IOCA2		IOCA,2		;Interupt on Change Port A, 1=Enabled
		#Define		IOCA1		IOCA,1		;Interupt on Change Port A, 1=Enabled
		#Define		IOCA0		IOCA,0		;Interupt on Change Port A, 1=Enabled

		IOCB		equ		116h		;Interupt On Change Port B
		#Define		IOCB7		IOCB,7		;Interupt on Change Port B, 1=Enabled
		#Define		IOCB6		IOCB,6		;Interupt on Change Port B, 1=Enabled
		#Define		IOCB5		IOCB,5		;Interupt on Change Port B, 1=Enabled
		#Define		IOCB4		IOCB,4		;Interupt on Change Port B, 1=Enabled


		;********** A/D Registers *************************************************************************************************
		ADRESH		equ		1Eh		;A/D register results

		ADRESL		equ		9Eh		;A/D register results

		ADCON0		equ		1Fh		;A/D control reg.
		#Define		ADON		ADCON0,0		;A/D on/off (1=on)
		#Define		GO_DONE		ADCON0,2		;Start A/D convertion, read 0 when finished
		#Define		CHS0		ADCON0,3		;Channel select, Bit 0
		#Define		CHS1		ADCON0,4		;Channel select, Bit 1
		#Define		CHS2		ADCON0,5		;Channel select, Bit 2
		#Define		ADCS0		ADCON0,6		;Osc clock speed, Bit 0
		#Define		ADCS1		ADCON0,7		;Osc clock speed, Bit 1

		ADCON1		equ		9Fh		;A/D control reg.
		#Define		PCFG0		ADCON1,0		;Port control bits (Digital/Analog), Bit0
		#Define		PCFG1		ADCON1,1		;Port control bits (Digital/Analog), Bit1
		#Define		PCFG2		ADCON1,2		;Port control bits (Digital/Analog), Bit2
		#Define		PCFG3		ADCON1,3		;Port control bits (Digital/Analog), Bit3
		#Define		ADFM		ADCON1,7		;A/D Results format

                    ANSEL		equ		11Eh		;Analog select
		ANSELH		equ		11Fh		;Analog select

		;********** Timer 1 control ***********************************************************************************************
		T1CON		equ		10h		;T1CON register
		#Define		T1CKPS1		T1CON,5		;Prescaler selection bit 1
		#Define		T1CKPS0		T1CON,4		;Prescaler selection bit 0
		#Define		T1PSCEN		T1CON,3		;Oscillator enable 1=enable
		#Define		T1SYNC		T1CON,2		;External clock input sync. 0=Synchronize 1=Do not syncronize
		#Define		TMR1CS		T1CON,1		;Clock source select. 1=External 0=Internal
		#Define		TMR1ON		T1CON,0		;Timer 1 on. 0=Stop 1=Start

		TMR1L		equ		0Eh		;Timer 1 Register Low
		TMR1H		equ		0Fh		;Timer 1 Register High

		;********** Timer 2 control ***********************************************************************************************
		TMR2 		equ		11h		;Timer2 Moduleís Register

		T2CON		equ		12h		;T2CON register
		#Define		TOUTPS3 		T2CON,6		;TOUTPS3 Timer2 Output Postscale Select bits
		#Define		TOUTPS2 		T2CON,5		;TOUTPS2 Timer2 Output Postscale Select bits
		#Define		TOUTPS1 		T2CON,4		;TOUTPS1 Timer2 Output Postscale Select bits
		#Define		TOUTPS0 		T2CON,3		;TOUTPS0 Timer2 Output Postscale Select bits
		#Define		TMR2ON	 	T2CON,2		;TMR2ON: Timer2 On bit
		#Define		T2CKPS1 		T2CON,1		;T2CKPS1 Timer2 Clock Prescale Select bits
		#Define		T2CKPS0 		T2CON,0		;T2CKPS0 Timer2 Clock Prescale Select bits

		PR2 		equ		92h		;Timer2 Period Register

		;********** PCON - Power Control Register *********************************************************************************
		PCON		equ		8Eh		;PCON reg
		#Define		ULPWUE		PCON,5		;Ultra low power wake-up enable, 1=enabled
		#Define		SBOREN		PCON,4		;Software brown out enable, 1=enabled
		#Define		Power_On_Reset	PCON,1		;Power-on Reset Status bit
		#Define		Brown_Out		PCON,0		;Brown-out Reset Status bit

                    ;********** EEPROM Registers **********************************************************************************************
		EEDATA		equ		10Ch		;EEPROM Data Register, Low Byte

		EEADR		equ		10Dh 		;EEPROM Address Register, Low Byte

		EEDATH		equ		10Eh		;EEPROM Data Register, High Byte

		EEADRH		equ		10Fh 		;EEPROM Address, High Byte

		EECON1		equ		018Ch		;EEPROM Control Register 1
		#Define		EEPROM_EEPGD 	EECON1,7		;EEPGD: Program/Data 
		#Define		EEPROM_WRERR 	EECON1,3		;EEPROM Error Flag bit
		#Define		EEPROM_WREN  	EECON1,2		;EEPROM Write Enable bit
		#Define		EEPROM_WR    	EECON1,1		;Write Control bit
		#Define		EEPROM_RD    	EECON1,0		;Read Control bit

		EECON2		equ		18Dh		;EEPROM Control Register2 (not a physical register)


		;********** Serial Port Control Registers *********************************************************************************
		SSPBUF		equ		13h		;Synchronous Serial Port Receive Buffer/Transmit Register

		SSPCON		equ		14h		;Synchronous Serial Port Control Register 1
		#Define		WCOL    		SSPCON,7		;Write Collision Detect bit
		#Define		SSPOV   		SSPCON,6		;Receive Overflow Indicator bit
		#Define		SSPEN   		SSPCON,5		;Synchronous Serial Port Enable bit
		#Define		CKP     		SSPCON,4		;Clock Polarity Select bit
		#Define		SSPM3   		SSPCON,3		;SSPM3 Synchronous Serial Port Mode Select bits
		#Define		SSPM2   		SSPCON,2		;SSPM2 Synchronous Serial Port Mode Select bits
		#Define		SSPM1   		SSPCON,1		;SSPM1 Synchronous Serial Port Mode Select bits
		#Define		SSPM0   		SSPCON,0		;SSPM0 Synchronous Serial Port Mode Select bits

		SSPCON2		equ		91h		;Synchronous Serial Port Control Register 2
		#Define		GCEN     		SSPCON2,7   	;General Call Enable bit
		#Define		ACKSTAT  		SSPCON2,6   	;Acknowledge Status bit
		#Define		ACKDT    		SSPCON2,5   	;Acknowledge Data bit
		#Define		ACKEN    		SSPCON2,4   	;Acknowledge Sequence Enable bit
		#Define		RCEN     		SSPCON2,3   	;Receive Enable bit
		#Define		PEN      		SSPCON2,2   	;STOP Condition Enable bit
		#Define		RSEN     		SSPCON2,1   	;Repeated START Condition Enable
		#Define		SEN      		SSPCON2,0   	;START Condition Enable bit

		SSPADD 		equ		93h		;Synchronous Serial Port (I2C mode) Address Register

		SSPSTAT		equ		94h		;Serial Port Status Register
		#Define		SMP       	SSPSTAT,7   	;Sample bit
		#Define		CKE       	SSPSTAT,6   	;SPI Clock Edge Select
		#Define		RX_Data_Add	SSPSTAT,5		;Received Data or Address
		#Define		Stop_Detected	SSPSTAT,4		;Start bit
		#Define		Start_Detected	SSPSTAT,3		;Start bit
		#Define		RW_Bit		SSPSTAT,2		;Read/Write bit
		#Define		Up_Add		SSPSTAT,1		;Update Address
		#Define		Buff_Full		SSPSTAT,0		;Buffer Full Status bit

		RCSTA 		equ		18h		;Receive Status and Control Register
		#Define		SPEN              	RCSTA,7     	;Serial Port Enable bit
		#Define		RX9                 RCSTA,6     	;9-bit Receive Enable bit
		#Define		SREN                RCSTA,5     	;Single Receive Enable bit
		#Define		CREN                RCSTA,4    	;Continuous Receive Enable bit
		#Define		ADDEN               RCSTA,3     	;Address Detect Enable bit
		#Define		FERR                RCSTA,2     	;Framing Error bit
		#Define		OERR                RCSTA,1     	;Overrun Error bit
		#Define		RX9D                RCSTA,0 		;9th bit of Received Data (can be parity bit, but must be calculated by user firmware)

		TXSTA		equ		98h		;Transmit Status and Control Register
		#Define		CSRC                TXSTA.7     	;Clock Source Select bit
		#Define		TX9                 TXSTA.6     	;9-bit Transmit Enable bit
		#Define		TXEN                TXSTA.5     	;Transmit Enable bit
		#Define		SYNC                TXSTA.4     	;USART Mode Select bit
		#Define		BRGH                TXSTA.2     	;High Baud Rate Select bit
		#Define		TRMT                TXSTA.1     	;Transmit Shift Register Status bit
		#Define		TX9D                TXSTA.0     	;9th bit of Transmit Data, can be parity bit
		SPBRG 		equ                 99h		;Baud Rate Generator Register

		;********** Capture, Compare and PWM Module *******************************************************************************
		CCPR1L 		equ		15h 		;Capture/Compare/PWM Register1 (LSB)
		CCPR1H		equ		16h  		;Capture/Compare/PWM Register1 (MSB)
		CCP1CON		equ		17h		;Capture/Compare/PWM control Register 1
		#Define		CCP1X               CCP1CON,5   	;PWM Least Significant bits
		#Define		CCP1Y               CCP1CON,4   	;PWM Least Significant bits
		#Define		CCP1M3              CCP1CON,3   	;Mode Select bits
		#Define		CCP1M2              CCP1CON,2   	;Mode Select bits
		#Define		CCP1M1              CCP1CON,1   	;Mode Select bits
		#Define		CCP1M0              CCP1CON,0   	;Mode Select bits

                    CCPR2L		equ		1Bh  		;Capture/Compare/PWM Register2 (LSB)
		CCPR2H		equ		1Ch  		;Capture/Compare/PWM Register2 (MSB)
		CCP2CON		equ		1Dh		;Capture/Compare/PWM control Register 2
		#Define		CCP2X              	CCP2CON,5   	;PWM Least Significant bits
		#Define		CCP2Y              	CCP2CON,4   	;PWM Least Significant bits
		#Define		CCP2M3             	CCP2CON,3   	;Mode Select bits
		#Define		CCP2M2             	CCP2CON,2   	;Mode Select bits
		#Define		CCP2M1             	CCP2CON,1   	;Mode Select bits
		#Define		CCP2M0             	CCP2CON,0   	;Mode Select bits

                    ;********** Internal Oscillator Control ***********************************************************************************
		OSCCON		equ		8Fh		;Oscillator Control Register
		#Define		IRCF_2		OSCCOM,6		;Internal Oscillator Frequency Select bits 2
		#Define		IRCF_1		OSCCOM,5		;Internal Oscillator Frequency Select bits 1
		#Define		IRCF_0		OSCCOM,4		;Internal Oscillator Frequency Select bits 0
								;111 = 8MHz
								;110 = 4MHz (default)
								;101 = 2MHz
								;100 = 1MHz
								;011 = 500kHz
								;010 = 250kHz
								;001 = 125kHz
                    						;000 = 31kHz (LFINTOSC)
		#Define		OSTS		OSCCON,3		;Oscillator Start-up Time-out Status bit
		#Define		HTS		OSCCON,2		;HFINTOSC Status bit (High Frequency ñ 8MHz to 125kHz)
		#Define		LTS		OSCCON,1		;LFINTOSC Stable bit (Low Frequency ñ 31kHz)
		#Define		SCS		OSCCON,0		;System Clock Select bit

                    OSCTUNE		equ		90h		;Oscillator Tuning Register
