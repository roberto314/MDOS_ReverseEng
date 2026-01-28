dasmfw: Disassembler Framework V0.35
Loaded: binary file "bootloader_09.bin"
Loaded: Info file "bootloader_09.info"

;****************************************************
; Used Labels
;****************************************************

CURDRV  EQU     $0000
STRSCTH EQU     $0001
STRSCTL EQU     $0002
NUMSCTH EQU     $0003
LSCTLN  EQU     $0005
CURADRH EQU     $0006
CURADRL EQU     $0007
FDSTAT  EQU     $0008
SECTCNT EQU     $000B
M00A0   EQU     $00A0
Z1FFD   EQU     $1FFD
M863F   EQU     $863F
OSLOAD  EQU     $E800
CHKERR  EQU     $E853
READPS  EQU     $E86D
RESTOR  EQU     $E875
LPINIT  EQU     $EBC0
PWRUP   EQU     $F000
XBEGEN  EQU     $F003
XCBCDH  EQU     $F006
XCHEXL  EQU     $F009
XCHEXR  EQU     $F00C
XINADD  EQU     $F00F
XINCH   EQU     $F012
XINCHN  EQU     $F015
XOUTCH  EQU     $F018
XOUT2H  EQU     $F01B
XOUT4H  EQU     $F01E
XPCRLF  EQU     $F021
XPDATA  EQU     $F024
XPDAT   EQU     $F027
XPSPAC  EQU     $F02A

;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $0020

                LDA     #$10                     ; 0020: 86 10          
                CMPA    OSLOAD                   ; 0022: B1 E8 00       
                LDA     #$50                     ; 0025: 86 50          
                BCS     Z0096                    ; 0027: 25 6D          
                INC     CURDRV                   ; 0029: 0C 00          
                JSR     RESTOR                   ; 002B: BD E8 75       
                JSR     LPINIT                   ; 002E: BD EB C0       
                LDX     #M00A0                   ; 0031: 8E 00 A0       
                LDA     $75,X                    ; 0034: A6 88 75       
                STA     LSCTLN                   ; 0037: 97 05          
                LDB     ,X                       ; 0039: E6 84          
                BMI     Z0094                    ; 003B: 2B 57          
                ANDB    #$03                     ; 003D: C4 03          
                LDA     $01,X                    ; 003F: A6 01          
                ASLA                             ; 0041: 48             
                ROLB                             ; 0042: 59             
                ASLA                             ; 0043: 48             
                ROLB                             ; 0044: 59             
                ADDA    #$01                     ; 0045: 8B 01          
                ADCB    #$00                     ; 0047: C9 00          
                STB     STRSCTH                  ; 0049: D7 01          
                STA     STRSCTL                  ; 004B: 97 02          
                LDD     $7A,X                    ; 004D: EC 88 7A       
                PSHD                             ; 0050: 34 06          
                LDD     $76,X                    ; 0052: EC 88 76       
                STD     NUMSCTH                  ; 0055: DD 03          
                LDX     $78,X                    ; 0057: AE 88 78       
                STX     CURADRH                  ; 005A: 9F 06          
                LDX     #CURADRL                 ; 005C: 8E 00 07       
Z005F           ASLD                             ; 005F: 58 49          
                DEX                              ; 0061: 30 1F          
                BNE     Z005F                    ; 0063: 26 FA          
                ADDD    CURADRH                  ; 0065: D3 06          
                STD     SECTCNT                  ; 0067: DD 0B          
                LDX     #M007F                   ; 0069: 8E 00 7F       
Z006C           LDA     #$AA                     ; 006C: 86 AA          
                INX                              ; 006E: 30 01          
                LDB     ,X                       ; 0070: E6 84          
                STA     ,X                       ; 0072: A7 84          
                CMPA    ,X                       ; 0074: A1 84          
                TPA                              ; 0076: 1F A8          
                STB     ,X                       ; 0078: E7 84          
                TAP                              ; 007A: 1F 8A          
                BNE     Z008F                    ; 007C: 26 11          
                CMPX    SECTCNT                  ; 007E: 9C 0B          
                BNE     Z006C                    ; 0080: 26 EA          
                CLR     CURDRV                   ; 0082: 0F 00          
                LDA     #$53                     ; 0084: 86 53          
                PSHA                             ; 0086: 34 02          
                LDA     #$E8                     ; 0088: 86 E8          
                PSHA                             ; 008A: 34 02          
                JMP     READPS                   ; 008C: 7E E8 6D       
Z008F           STX     CURDRV                   ; 008F: 9F 00          
                LDA     #$4D                     ; 0091: 86 4D          
                CMPX    #M863F                   ; 0093: 8C 86 3F       
Z0096           STA     FDSTAT                   ; 0096: 97 08          
                COMB                             ; 0098: 53             
                JMP     CHKERR                   ; 0099: 7E E8 53       
                NEG     CURDRV                   ; 009C: 00 00          
                NEG     CURDRV                   ; 009E: 00 00          


                END
