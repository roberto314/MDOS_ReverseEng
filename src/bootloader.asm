dasmfw: Disassembler Framework V0.35
Loaded: binary file "bootloader.bin"
Loaded: Info file "bootloader.info"

;****************************************************
; Used Labels
;****************************************************

M0000   EQU     $0000
M0001   EQU     $0001
M0002   EQU     $0002
M0003   EQU     $0003
M0004   EQU     $0004
M0005   EQU     $0005
M0006   EQU     $0006
M0007   EQU     $0007
M0008   EQU     $0008
M000B   EQU     $000B
M000C   EQU     $000C
M00A0   EQU     $00A0
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

                LDAA    OSLOAD                   ; 0020: B6 E8 00       '...'
                CMPA    #$8E                     ; 0023: 81 8E          '..'
                LDAA    #$50                     ; 0025: 86 50          '.P'
                BCS     Z0098                    ; 0027: 25 6F          '%o'
                INC     M0000                    ; 0029: 7C 00 00       '|..'
                JSR     RESTOR                   ; 002C: BD E8 75       '..u'
                JSR     LPINIT                   ; 002F: BD EB C0       '...'
                LDX     #M00A0                   ; 0032: CE 00 A0       '...'
                LDAA    $75,X                    ; 0035: A6 75          '.u'
                STAA    M0005                    ; 0037: 97 05          '..'
                LDAB    ,X                       ; 0039: E6 00          '..'
                BMI     Z0096                    ; 003B: 2B 59          '+Y'
                ANDB    #$03                     ; 003D: C4 03          '..'
                LDAA    $01,X                    ; 003F: A6 01          '..'
                ASLA                             ; 0041: 48             'H'
                ROLB                             ; 0042: 59             'Y'
                ASLA                             ; 0043: 48             'H'
                ROLB                             ; 0044: 59             'Y'
                ADDA    #$01                     ; 0045: 8B 01          '..'
                ADCB    #$00                     ; 0047: C9 00          '..'
                STAB    M0001                    ; 0049: D7 01          '..'
                STAA    M0002                    ; 004B: 97 02          '..'
                LDAB    $7A,X                    ; 004D: E6 7A          '.z'
                LDAA    $7B,X                    ; 004F: A6 7B          '.{'
                PSHA                             ; 0051: 36             '6'
                PSHB                             ; 0052: 37             '7'
                LDAA    $77,X                    ; 0053: A6 77          '.w'
                LDAB    $76,X                    ; 0055: E6 76          '.v'
                STAA    M0004                    ; 0057: 97 04          '..'
                STAB    M0003                    ; 0059: D7 03          '..'
                LDX     $78,X                    ; 005B: EE 78          '.x'
                STX     M0006                    ; 005D: DF 06          '..'
                LDX     #M0007                   ; 005F: CE 00 07       '...'
Z0062           ASLA                             ; 0062: 48             'H'
                ROLB                             ; 0063: 59             'Y'
                DEX                              ; 0064: 09             '.'
                BNE     Z0062                    ; 0065: 26 FB          '&.'
                ADDA    M0007                    ; 0067: 9B 07          '..'
                ADCB    M0006                    ; 0069: D9 06          '..'
                STAA    M000C                    ; 006B: 97 0C          '..'
                STAB    M000B                    ; 006D: D7 0B          '..'
                LDX     #M007F                   ; 006F: CE 00 7F       '...'
Z0072           LDAA    #$AA                     ; 0072: 86 AA          '..'
                INX                              ; 0074: 08             '.'
                LDAB    ,X                       ; 0075: E6 00          '..'
                STAA    ,X                       ; 0077: A7 00          '..'
                CMPA    ,X                       ; 0079: A1 00          '..'
                TPA                              ; 007B: 07             '.'
                STAB    ,X                       ; 007C: E7 00          '..'
                TAP                              ; 007E: 06             '.'
M007F           BNE     Z0091                    ; 007F: 26 10          '&.'
                CPX     M000B                    ; 0081: 9C 0B          '..'
                BNE     Z0072                    ; 0083: 26 ED          '&.'
                CLR     M0000                    ; 0085: 7F 00 00       '...'
                LDAA    #$53                     ; 0088: 86 53          '.S'
                PSHA                             ; 008A: 36             '6'
                LDAA    #$E8                     ; 008B: 86 E8          '..'
                PSHA                             ; 008D: 36             '6'
                JMP     READPS                   ; 008E: 7E E8 6D       '~.m'
Z0091           STX     M0000                    ; 0091: DF 00          '..'
                LDAA    #$4D                     ; 0093: 86 4D          '.M'
                CPX     #M863F                   ; 0095: 8C 86 3F       '..?'
Z0098           STAA    M0008                    ; 0098: 97 08          '..'
                COMB                             ; 009A: 53             'S'
                JMP     CHKERR                   ; 009B: 7E E8 53       '~.S'
                FCB     $00                      ; 009E: 00             '.'
                FCB     $00                      ; 009F: 00             '.'


                END
