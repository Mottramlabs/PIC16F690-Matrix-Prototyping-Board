;=======================================
;  Configuration (FUSE) BIT Definitions 
;=======================================
_FCMEN_ON            EQU        3FFFh       
_FCMEN_OFF           EQU        37FFh       
_IESO_ON             EQU        3FFFh       
_IESO_OFF            EQU        3BFFh       
_BOR_ON              EQU        3FFFh       
_BOR_NSLEEP          EQU        3EFFh       
_BOR_SBODEN          EQU        3DFFh       
_BOR_OFF             EQU        3CFFh       
_CPD_ON              EQU        3F7Fh       
_CPD_OFF             EQU        3FFFh       
_CP_ON               EQU        3FBFh       
_CP_OFF              EQU        3FFFh       
_MCLRE_ON            EQU        3FFFh       
_MCLRE_OFF           EQU        3FDFh       
_PWRTE_OFF           EQU        3FFFh       
_PWRTE_ON            EQU        3FEFh       
_WDT_ON              EQU        3FFFh       
_WDT_OFF             EQU        3FF7h       
_LP_OSC              EQU        3FF8h       
_XT_OSC              EQU        3FF9h       
_HS_OSC              EQU        3FFAh       
_EC_OSC              EQU        3FFBh       
_INTRC_OSC_NOCLKOUT  EQU        3FFCh       
_INTRC_OSC_CLKOUT    EQU        3FFDh       
_EXTRC_OSC_NOCLKOUT  EQU        3FFEh       
_EXTRC_OSC_CLKOUT    EQU        3FFFh       
_INTOSCIO            EQU        3FFCh       
_INTOSC              EQU        3FFDh       
_EXTRCIO             EQU        3FFEh       
_EXTRC               EQU        3FFFh       

__CONFIG _FCMEN_OFF & _IESO_OFF & _BOR_OFF & _CPD_OFF & _CP_OFF & _MCLRE_OFF & _WDT_ON & _HS_OSC  & _EXTRC_OSC_NOCLKOUT
;Note enabling brown out detect uses 0.3mA in sleep! 
