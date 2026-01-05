dasmfw: Disassembler Framework V0.35
Loaded: binary file "bootloader.bin"
Loaded: Info file "bootloader.info"

;****************************************************
; Used Labels
;****************************************************

CURDRV  EQU     $0000
STRSCTH EQU     $0001
STRSCTL EQU     $0002
NUMSCTH EQU     $0003
NUMSCTL EQU     $0004
LSCTLN  EQU     $0005
CURADRH EQU     $0006
CURADRL EQU     $0007
FDSTAT  EQU     $0008
SECTCNT EQU     $000B
M000C   EQU     $000C
M00A0   EQU     $00A0
M03FF   EQU     $03FF
Z1FFD   EQU     $1FFD
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

                INC     CURDRV                   ; 0020: 7C 00 00       
                JSR     RESTOR                   ; 0023: BD E8 75       
                JSR     LPINIT                   ; 0026: BD EB C0       
                LDX     #M00A0                   ; 0029: CE 00 A0       
                LDAA    $75,X                    ; 002C: A6 75          
                STAA    LSCTLN                   ; 002E: 97 05          
                LDAB    ,X                       ; 0030: E6 00          
                BMI     Z008C                    ; 0032: 2B 58          
                ANDB    #$03                     ; 0034: C4 03          
                LDAA    $01,X                    ; 0036: A6 01          
                ASLA                             ; 0038: 48             
                ROLB                             ; 0039: 59             
                ASLA                             ; 003A: 48             
                ROLB                             ; 003B: 59             
                ADDA    #$01                     ; 003C: 8B 01          
                ADCB    #$00                     ; 003E: C9 00          
                STAB    STRSCTH                  ; 0040: D7 01          
                STAA    STRSCTL                  ; 0042: 97 02          
                LDAA    $77,X                    ; 0044: A6 77          
                LDAB    $76,X                    ; 0046: E6 76          
                STAA    NUMSCTL                  ; 0048: 97 04          
                STAB    NUMSCTH                  ; 004A: D7 03          
                LDAB    $7A,X                    ; 004C: E6 7A          
                LDAA    $7B,X                    ; 004E: A6 7B          
                PSHA                             ; 0050: 36             
                PSHB                             ; 0051: 37             
                LDX     $78,X                    ; 0052: EE 78          
                STX     CURADRH                  ; 0054: DF 06          
                LDAA    NUMSCTL                  ; 0056: 96 04          
                LDAB    NUMSCTH                  ; 0058: D6 03          
                LDX     #CURADRL                 ; 005A: CE 00 07       
Z005D           ASLA                             ; 005D: 48             
                ROLB                             ; 005E: 59             
                DEX                              ; 005F: 09             
                BNE     Z005D                    ; 0060: 26 FB          
                ADDA    CURADRL                  ; 0062: 9B 07          
                ADCB    CURADRH                  ; 0064: D9 06          
                STAA    M000C                    ; 0066: 97 0C          
                STAB    SECTCNT                  ; 0068: D7 0B          
                LDX     #M03FF                   ; 006A: CE 03 FF       
Z006D           LDAA    #$4D                     ; 006D: 86 4D          
                INX                              ; 006F: 08             
                LDAB    ,X                       ; 0070: E6 00          
                STAA    ,X                       ; 0072: A7 00          
                CMPA    ,X                       ; 0074: A1 00          
                TPA                              ; 0076: 07             
                STAB    ,X                       ; 0077: E7 00          
                TAP                              ; 0079: 06             
                BNE     Z0094                    ; 007A: 26 18          
                CPX     SECTCNT                  ; 007C: 9C 0B          
                BNE     Z006D                    ; 007E: 26 ED          
                CLR     CURDRV                   ; 0080: 7F 00 00       
                LDAA    #$53                     ; 0083: 86 53          
                PSHA                             ; 0085: 36             
                LDAA    #$E8                     ; 0086: 86 E8          
                PSHA                             ; 0088: 36             
                JMP     READPS                   ; 0089: 7E E8 6D       
Z008C           LDAA    #$3F                     ; 008C: 86 3F          
Z008E           STAA    FDSTAT                   ; 008E: 97 08          
                SEC                              ; 0090: 0D             
                JMP     CHKERR                   ; 0091: 7E E8 53       
Z0094           LDAA    #$4D                     ; 0094: 86 4D          
                BRA     Z008E                    ; 0096: 20 F6          
                FCB     $00                      ; 0098: 00             
                FCB     $00                      ; 0099: 00             
                FCB     $00                      ; 009A: 00             
                FCB     $00                      ; 009B: 00             
                FCB     $00                      ; 009C: 00             
                FCB     $00                      ; 009D: 00             
                FCB     $00                      ; 009E: 00             
                FCB     $00                      ; 009F: 00             


                END
