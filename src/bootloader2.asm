dasmfw: Disassembler Framework V0.35
Loaded: binary file "bootloader2.bin"
Loaded: Info file "bootloader2.info"

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

                LDAA    OSLOAD                   ; 0020: B6 E8 00       
                CMPA    #$8E                     ; 0023: 81 8E          
                LDAA    #$50                     ; 0025: 86 50          
                BCS     Z0098                    ; 0027: 25 6F          
                INC     CURDRV                   ; 0029: 7C 00 00       
                JSR     RESTOR                   ; 002C: BD E8 75       
                JSR     LPINIT                   ; 002F: BD EB C0       
                LDX     #M00A0                   ; 0032: CE 00 A0       
                LDAA    $75,X                    ; 0035: A6 75          
                STAA    LSCTLN                   ; 0037: 97 05          
                LDAB    ,X                       ; 0039: E6 00          
                BMI     Z0096                    ; 003B: 2B 59          
                ANDB    #$03                     ; 003D: C4 03          
                LDAA    $01,X                    ; 003F: A6 01          
                ASLA                             ; 0041: 48             
                ROLB                             ; 0042: 59             
                ASLA                             ; 0043: 48             
                ROLB                             ; 0044: 59             
                ADDA    #$01                     ; 0045: 8B 01          
                ADCB    #$00                     ; 0047: C9 00          
                STAB    STRSCTH                  ; 0049: D7 01          
                STAA    STRSCTL                  ; 004B: 97 02          
                LDAB    $7A,X                    ; 004D: E6 7A          
                LDAA    $7B,X                    ; 004F: A6 7B          
                PSHA                             ; 0051: 36             
                PSHB                             ; 0052: 37             
                LDAA    $77,X                    ; 0053: A6 77          
                LDAB    $76,X                    ; 0055: E6 76          
                STAA    NUMSCTL                  ; 0057: 97 04          
                STAB    NUMSCTH                  ; 0059: D7 03          
                LDX     $78,X                    ; 005B: EE 78          
                STX     CURADRH                  ; 005D: DF 06          
                LDX     #CURADRL                 ; 005F: CE 00 07       
Z0062           ASLA                             ; 0062: 48             
                ROLB                             ; 0063: 59             
                DEX                              ; 0064: 09             
                BNE     Z0062                    ; 0065: 26 FB          
                ADDA    CURADRL                  ; 0067: 9B 07          
                ADCB    CURADRH                  ; 0069: D9 06          
                STAA    M000C                    ; 006B: 97 0C          
                STAB    SECTCNT                  ; 006D: D7 0B          
                LDX     #M007F                   ; 006F: CE 00 7F       
Z0072           LDAA    #$AA                     ; 0072: 86 AA          
                INX                              ; 0074: 08             
                LDAB    ,X                       ; 0075: E6 00          
                STAA    ,X                       ; 0077: A7 00          
                CMPA    ,X                       ; 0079: A1 00          
                TPA                              ; 007B: 07             
                STAB    ,X                       ; 007C: E7 00          
                TAP                              ; 007E: 06             
M007F           BNE     Z0091                    ; 007F: 26 10          
                CPX     SECTCNT                  ; 0081: 9C 0B          
                BNE     Z0072                    ; 0083: 26 ED          
                CLR     CURDRV                   ; 0085: 7F 00 00       
                LDAA    #$53                     ; 0088: 86 53          
                PSHA                             ; 008A: 36             
                LDAA    #$E8                     ; 008B: 86 E8          
                PSHA                             ; 008D: 36             
                JMP     READPS                   ; 008E: 7E E8 6D       
Z0091           STX     CURDRV                   ; 0091: DF 00          
                LDAA    #$4D                     ; 0093: 86 4D          
                FCB     $8C                      ; 0095: 8C             
Z0096           LDAA    #$3F                     ; 0096: 86 3F          
Z0098           STAA    FDSTAT                   ; 0098: 97 08          
                COMB                             ; 009A: 53             
                JMP     CHKERR                   ; 009B: 7E E8 53       
                FCB     $00                      ; 009E: 00             
                FCB     $00                      ; 009F: 00             


                END
