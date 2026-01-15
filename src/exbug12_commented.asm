
; For the first two cycles after Reset the ROM is activated 
; and the Reset Vector points to F000.
; After that FF00-FFFF is RAM.
; Memory Map:

; START                                    END   SIZE
;       ---------------------------------         
; FF00 |               RAM               | FFFF   100
;       ---------------------------------         
; FE00 |          (extra RAM)            | FEFF   100
;       ---------------------------------         
; FD00 |              free               | FDFF   100
;       ---------------------------------         
; FCFC |              PROM               | FCFF     4
;       ---------------------------------         
; FCF8 |               PIA               | FCFB     4
;       ---------------------------------         
; FCF6 |              free               | FCF7     2
;       ---------------------------------         
; FCF4 |              ACIA               | FCF5     2
;       ---------------------------------         
; FC00 |              free               | FCF3     4
;       ---------------------------------         
; F000 |        EXbug MONITOR            | FBFF   C00
;       ---------------------------------         
; ED00 |       (extra Disk-ROM)          | EFFF   300
;       ---------------------------------         
; EC06 |              free               | ECFF    F9
;       ---------------------------------         
; EC04 |           Disk-SSDA             | EC05     2
;       ---------------------------------         
; EC00 |           Disk-PIA              | EC03     4
;       ---------------------------------  
; E800 |           Disk-ROM              | EBFF   3FF
;       ---------------------------------  
;      |                                 | 
; 0000 |              RAM                | E7FF  E800
;      |                                 | 
;       ---------------------------------  
;
; the 'extra' Portions of RAM and ROM are for my own
; remake with the kees1948 CPUXXCMI Board. They are otherwise free.
;
;****************************************************
; Used Labels
;****************************************************

M0000   EQU     $0000
M0004   EQU     $0004
M0317   EQU     $0317
M072F   EQU     $072F
Z1FFD   EQU     $1FFD
M30D4   EQU     $30D4
M83FF   EQU     $83FF
OSLOAD  EQU     $E800
ACIA_0  EQU     $FCF4
ACIA_1  EQU     $FCF5
PIADRA  EQU     $FCF8
PIACRA  EQU     $FCF9
PIADRB  EQU     $FCFA
PIACRB  EQU     $FCFB
PROM_1  EQU     $FCFD
RAMBGN  EQU     $FF00
MFF02   EQU     $FF02
MFF03   EQU     $FF03 ; string Buffer
MFF04   EQU     $FF04 ; string Buffer
MFF05   EQU     $FF05 ; string Buffer
MFF06   EQU     $FF06 ; string Buffer
MFF07   EQU     $FF07 ; string Buffer
MFF08   EQU     $FF08
MFF09   EQU     $FF09
MFF0A   EQU     $FF0A
MFF0B   EQU     $FF0B
MFF0C   EQU     $FF0C
MFF0D   EQU     $FF0D
MFF0E   EQU     $FF0E
MFF10   EQU     $FF10
MFF12   EQU     $FF12
MFF13   EQU     $FF13
MFF14   EQU     $FF14
XREGsP  EQU     $FF16
MFF17   EQU     $FF17
XREGsC  EQU     $FF1C
XREGsS  EQU     $FF1D
BRKPTs  EQU     $FF1F
MFF2F   EQU     $FF2F
BKPINs  EQU     $FF4F
MFF50   EQU     $FF50
MFF51   EQU     $FF51
AECHO   EQU     $FF53
MFF54   EQU     $FF54
MFF56   EQU     $FF56
MFF58   EQU     $FF58
MFF5A   EQU     $FF5A
MFF5B   EQU     $FF5B
MFF5C   EQU     $FF5C
MFF5D   EQU     $FF5D
MFF5E   EQU     $FF5E
MFF5F   EQU     $FF5F
MFF60   EQU     $FF60
MFF61   EQU     $FF61
MFF62   EQU     $FF62
MFF63   EQU     $FF63
XSTAKs  EQU     $FF8A
MFF8B   EQU     $FF8B
MFF8C   EQU     $FF8C
MFF8D   EQU     $FF8D
MFF8E   EQU     $FF8E
MFF90   EQU     $FF90
MFF93   EQU     $FF93
MFFD5   EQU     $FFD5
MFFF6   EQU     $FFF6
MFFF7   EQU     $FFF7
IRQsVC  EQU     $FFF8 ; Interrupt Vectors
MFFF9   EQU     $FFF9 ; Interrupt Vectors (IRQ low)
SWIsVC  EQU     $FFFA ; Interrupt Vectors
NMIsVC  EQU     $FFFC ; Interrupt Vectors

;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $F000

PWRUP           JMP     PWRUP1                   ; F000: 7E F5 47  ; 
XBEGEN          JMP     XBEGEN1                  ; F003: 7E F7 87  ; 
XCBCDH          JMP     XCBCDH1                  ; F006: 7E FA 86  ; Input HEX ?
XCHEXL          JMP     XCHEXL1                  ; F009: 7E F9 B8  ; Convert HEX High Nibble
XCHEXR          JMP     XCHEXR1                  ; F00C: 7E F9 BC  ; Convert HEX Low Nibble
XINADD          JMP     XINADD1                  ; F00F: 7E FA 43  ; 
XINCH           JMP     XINCH1                   ; F012: 7E FA 6B  ; Get any Character from Serial Port
XINCHN          JMP     XINCHN1                  ; F015: 7E FA 7F  ; Get only the first 127 ASCII Char. from Port
XOUTCH          JMP     XOUTCH1                  ; F018: 7E F9 E2  ; 
XOUT2H          JMP     XOUT2H1                  ; F01B: 7E F9 C9  ; 
XOUT4H          JMP     XOUT4H1                  ; F01E: 7E F9 C7  ; 
XPCRLF          JMP     XPCRLF1                  ; F021: 7E FA 21  ; Starts w. LF, CR, NULL
XPDATA          JMP     XPDATA1                  ; F024: 7E FA 14  ; Starts with CRLF, otherwise same as below
XPDAT           JMP     XPDAT1                   ; F027: 7E FA 16  ; Print String from X
XPSPAC          JMP     XPSPAC1                  ; F02A: 7E F9 CB  ; 
MF02D           FCB     $27                      ; F02D: 27        ; 
                FCB     $10,$03                  ; F02E: 10 03     ; 
                FDB     OSLOAD                   ; F030: E8 00     ; 
                FCB     $64                      ; F032: 64        ; 
                FCB     $00,$0A,$00,$01          ; F033: 00 0A 00 0; 
ZF037           JSR     XCBCDH1                  ; F037: BD FA 86  ; 
                BMI     ZF0A6                    ; F03A: 2B 6A     ; 
                ASL     $01,X                    ; F03C: 68 01     ; 
                ROL     ,X                       ; F03E: 69 00     ; 
                BSR     ZF07C                    ; F040: 8D 3A     ; 
                ADDA    $01,X                    ; F042: AB 01     ; 
                STAA    $01,X                    ; F044: A7 01     ; 
ZF046           JSR     XINCHN1                  ; F046: BD FA 7F  ; Get ASCII from Port
                CMPA    #'='                     ; F049: 81 3D     ; 
                BNE     ZF037                    ; F04B: 26 EA     ; 
                JSR     XPSPAC1                  ; F04D: BD F9 CB  ; 
                LDX     #MF02D                   ; F050: CE F0 2D  ; 
                LDAA    MFF08                    ; F053: B6 FF 08  ; 
                LDAB    MFF09                    ; F056: F6 FF 09  ; 
ZF059           CLR     MFF5A                    ; F059: 7F FF 5A  ; 
ZF05C           INC     MFF5A                    ; F05C: 7C FF 5A  ; 
                SUBB    $01,X                    ; F05F: E0 01     ; 
                SBCA    ,X                       ; F061: A2 00     ; 
                BCC     ZF05C                    ; F063: 24 F7     ; 
                ADDB    $01,X                    ; F065: EB 01     ; 
                ADCA    ,X                       ; F067: A9 00     ; 
                PSHA                             ; F069: 36        ; 
                LDAA    MFF5A                    ; F06A: B6 FF 5A  ; 
                ADDA    #$2F                     ; F06D: 8B 2F     ; 
                JSR     XOUTCH1                  ; F06F: BD F9 E2  ; 
                PULA                             ; F072: 32        ; 
                INX                              ; F073: 08        ; 
                INX                              ; F074: 08        ; 
                CPX     #ZF037                   ; F075: 8C F0 37  ; 
                BNE     ZF059                    ; F078: 26 DF     ; 
                BRA     MAIDs                    ; F07A: 20 77     ; 
;------------------------------------------------
ZF07C           ASL     $01,X                    ; F07C: 68 01     ; 
                ROL     ,X                       ; F07E: 69 00     ; 
                ASL     $01,X                    ; F080: 68 01     ; 
                ROL     ,X                       ; F082: 69 00     ; 
                ASL     $01,X                    ; F084: 68 01     ; 
                ROL     ,X                       ; F086: 69 00     ; 
                RTS                              ; F088: 39        ; 
;------------------------------------------------
ZF089           LDX     #MFF08                   ; F089: CE FF 08  ; 
                CLR     MFF07                    ; F08C: 7F FF 07  ; 
                CLR     ,X                       ; F08F: 6F 00     ; 
                CLR     $01,X                    ; F091: 6F 01     ; 
                JSR     XINCHN1                  ; F093: BD FA 7F  ; Get ASCII from Port
                CMPA    #'$'                     ; F096: 81 24     ; 
                BEQ     ZF046                    ; F098: 27 AC     ; 
                CMPA    #'@'                     ; F09A: 81 40     ; 
                BEQ     ZF0E4                    ; F09C: 27 46     ; 
ZF09E           CMPA    #'0'                     ; F09E: 81 30     ; 
                BMI     ZF0A6                    ; F0A0: 2B 04     ; 
                CMPA    #'9'                     ; F0A2: 81 39     ; 
                BLE     ZF0A8                    ; F0A4: 2F 02     ; 
ZF0A6           BRA     OUTQM                    ; F0A6: 20 76     ; no match, output '?'
;------------------------------------------------
ZF0A8           ANDA    #$0F                     ; F0A8: 84 0F     ; 
                STAA    MFF5A                    ; F0AA: B7 FF 5A  ; 
                LDAA    ,X                       ; F0AD: A6 00     ; 
                LDAB    $01,X                    ; F0AF: E6 01     ; 
                ASLB                             ; F0B1: 58 49     ; There is no ASLD in 6800
                ROLA                                               ; it was an error of the disassembler
                BSR     ZF07C                                      ; 
                ADDB    $01,X                    ; F0B5: EB 01     ; 
                ADCA    ,X                       ; F0B7: A9 00     ; 
                ADDB    MFF5A                    ; F0B9: FB FF 5A  ; 
                ADCA    #$00                     ; F0BC: 89 00     ; 
                STAA    ,X                       ; F0BE: A7 00     ; 
                STAB    $01,X                    ; F0C0: E7 01     ; 
                JSR     XINCHN1                  ; F0C2: BD FA 7F  ; Get ASCII from Port
                CMPA    #'='                      ; F0C5: 81 3D    ; 
                BNE     ZF09E                    ; F0C7: 26 D5     ; 
ZF0C9           JSR     XPSPAC1                  ; F0C9: BD F9 CB  ; 
                LDX     #MFF08                   ; F0CC: CE FF 08  ; 
                JSR     XOUT4H1                  ; F0CF: BD F9 C7  ; 
                BRA     MAIDs                    ; F0D2: 20 1F     ; 
;------------------------------------------------
ZF0D4           CMPA    #'0'                      ; F0D4: 81 30    ; 
                BMI     ZF0A6                    ; F0D6: 2B CE     ; 
                CMPA    #'8'                      ; F0D8: 81 38    ; 
                BPL     ZF0A6                    ; F0DA: 2A CA     ; 
                BSR     ZF07C                    ; F0DC: 8D 9E     ; 
                ANDA    #$07                     ; F0DE: 84 07     ; 
                ADDA    $01,X                    ; F0E0: AB 01     ; 
                STAA    $01,X                    ; F0E2: A7 01     ; 
ZF0E4           JSR     XINCHN1                  ; F0E4: BD FA 7F  ; Get ASCII from Port
                CMPA    #'='                      ; F0E7: 81 3D    ; 
                BNE     ZF0D4                    ; F0E9: 26 E9     ; 
                BRA     ZF0C9                    ; F0EB: 20 DC     ; 
;------------------------------------------------
MAID            CLR     MFF60                    ; F0ED: 7F FF 60  ; MAID Entry point
                CLR     MFF54                    ; F0F0: 7F FF 54  ; 
MAIDs           LDS     #XSTAKs                  ; F0F3: 8E FF 8A  ; 
                LDX     #STAR1                   ; F0F6: CE FB C6  ; Load Prompt '*'
                JSR     XPDATA1                  ; F0F9: BD FA 14  ; Output
                JSR     ZFA40                    ; F0FC: BD FA 40  ; 
                TSTB                             ; F0FF: 5D        ; 
                BNE     ZF126                    ; F100: 26 24     ; 
                JSR     ZFA2E                    ; F102: BD FA 2E  ; 
                CMPA    #'$'                     ; F105: 81 24     ; 
                BNE     ZF10C                    ; F107: 26 03     ; 
                JMP     ZF316                    ; F109: 7E F3 16  ; 

ZF10C           CMPA    #';'                     ; F10C: 81 3B     ; 
                BNE     ZF113                    ; F10E: 26 03     ; 
                JMP     ZF274                    ; F110: 7E F2 74  ; 

ZF113           CMPA    #'N'                     ; F113: 81 4E     ; 
                BEQ     GOT_N1                   ; F115: 27 34     ; 
                CMPA    #'#'                     ; F117: 81 23     ; 
                BNE     OUTQM                    ; F119: 26 03     ; no match, output '?'
                JMP     ZF089                    ; F11B: 7E F0 89  ; 
;------------------------------------------------
OUTQM           LDX     #MFBC2                   ; F11E: CE FB C2  ; 
                JSR     XPDAT1                   ; F121: BD FA 16  ; 
ZF124           BRA     MAIDs                    ; F124: 20 CD     ; 
;------------------------------------------------
ZF126           CMPA    #';'                      ; F126: 81 3B    ; 
                BEQ     ZF198                    ; F128: 27 6E     ; 
                LDX     MFF08                    ; F12A: FE FF 08  ; 
                CMPA    #'/'                      ; F12D: 81 2F    ; 
                BNE     OUTQM                    ; F12F: 26 ED     ; no match, output '?'
                JMP     ZF1CB                    ; F131: 7E F1 CB  ; 
;------------------------------------------------
GOT_N2          LDX     MFF08                    ; F134: FE FF 08  ; 
                BEQ     ZF13A                    ; F137: 27 01     ; 
                DEX                              ; F139: 09        ; 
ZF13A           STX     MFF51                    ; F13A: FF FF 51  ; 
                LDAA    #$FF                     ; F13D: 86 FF     ; 
                STAA    MFF60                    ; F13F: B7 FF 60  ; 
                STAA    MFF50                    ; F142: B7 FF 50  ; 
                STAA    MFF54                    ; F145: B7 FF 54  ; 
                JMP     ZF406                    ; F148: 7E F4 06  ; 
;------------------------------------------------
GOT_N1          LDX     #M0000                   ; F14B: CE 00 00  ; 
                BRA     ZF13A                    ; F14E: 20 EA     ; 
;------------------------------------------------
ZF150           LDAA    MFF08                    ; F150: B6 FF 08  ; 
                LDAB    MFF09                    ; F153: F6 FF 09  ; 
                JSR     ZF2AF                    ; F156: BD F2 AF  ; 
                BEQ     MAIDs                    ; F159: 27 98     ; 
                LDX     #BRKPTs                  ; F15B: CE FF 1F  ; 
ZF15E           LDAA    ,X                       ; F15E: A6 00     ; 
                ORAA    $01,X                    ; F160: AA 01     ; 
                BNE     ZF16F                    ; F162: 26 0B     ; 
                LDS     MFF08                    ; F164: BE FF 08  ; 
                STS     ,X                       ; F167: AF 00     ; 
                CLR     $20,X                    ; F169: 6F 20     ; 
                CLR     $21,X                    ; F16B: 6F 21     ; 
                BRA     ZF124                    ; F16D: 20 B5     ; 
;------------------------------------------------
ZF16F           INX                              ; F16F: 08        ; 
                INX                              ; F170: 08        ; 
                CPX     #MFF2F                   ; F171: 8C FF 2F  ; 
                BNE     ZF15E                    ; F174: 26 E8     ; 
ZF176           BRA     OUTQM                    ; F176: 20 A6     ; no match, output '?'
;------------------------------------------------
ZF178           LDX     #BRKPTs                  ; F178: CE FF 1F  ; 
ZF17B           LDAA    ,X                       ; F17B: A6 00     ; 
                CMPA    MFF08                    ; F17D: B1 FF 08  ; 
                BNE     ZF18F                    ; F180: 26 0D     ; 
                LDAA    $01,X                    ; F182: A6 01     ; 
                CMPA    MFF09                    ; F184: B1 FF 09  ; 
                BNE     ZF18F                    ; F187: 26 06     ; 
                CLR     ,X                       ; F189: 6F 00     ; 
                CLR     $01,X                    ; F18B: 6F 01     ; 
ZF18D           BRA     ZF124                    ; F18D: 20 95     ; 
;------------------------------------------------
ZF18F           INX                              ; F18F: 08        ; 
                INX                              ; F190: 08        ; 
                CPX     #MFF2F                   ; F191: 8C FF 2F  ; 
                BNE     ZF17B                    ; F194: 26 E5     ; 
                BRA     ZF176                    ; F196: 20 DE     ; 
;------------------------------------------------
ZF198           JSR     XINCHN1                  ; F198: BD FA 7F  ; Get ASCII from Port
                CMPA    #'G'                      ; F19B: 81 47    ; 
                BNE     ZF1A2                    ; F19D: 26 03     ; 
                JMP     GOT_G2                   ; F19F: 7E F3 F1  ; 

ZF1A2           CMPA    #'N'                      ; F1A2: 81 4E    ; 
                BEQ     GOT_N2                   ; F1A4: 27 8E     ; 
                CMPA    #'P'                      ; F1A6: 81 50    ; 
                BNE     ZF1AD                    ; F1A8: 26 03     ; 
                JMP     ZF3D1                    ; F1AA: 7E F3 D1  ; 
;------------------------------------------------
ZF1AD           CMPA    #'U'                      ; F1AD: 81 55    ; 
                BEQ     ZF178                    ; F1AF: 27 C7     ; 
                CMPA    #'V'                      ; F1B1: 81 56    ; 
                BEQ     ZF150                    ; F1B3: 27 9B     ; 
                CMPA    #'W'                      ; F1B5: 81 57    ; 
                BNE     ZF176                    ; F1B7: 26 BD     ; 
                BRA     ZF232                    ; F1B9: 20 77     ; 
;------------------------------------------------
ZF1BB           INX                              ; F1BB: 08        ; 
                JSR     OUTCR                    ; F1BC: BD FA 25  ; 
ZF1BF           STX     MFF56                    ; F1BF: FF FF 56  ; 
ZF1C2           LDX     #MFF56                   ; F1C2: CE FF 56  ; 
                JSR     ZF9DC                    ; F1C5: BD F9 DC  ; 
                LDX     MFF56                    ; F1C8: FE FF 56  ; 
ZF1CB           JSR     ZF96A                    ; F1CB: BD F9 6A  ; 
                BMI     ZF1DE                    ; F1CE: 2B 0E     ; 
                CMPA    #$0D                     ; F1D0: 81 0D     ; 
                BEQ     ZF18D                    ; F1D2: 27 B9     ; 
                CMPA    #$0A                     ; F1D4: 81 0A     ; 
                BEQ     ZF1BB                    ; F1D6: 27 E3     ; 
                DEX                              ; F1D8: 09        ; 
                JSR     XPCRLF1                  ; F1D9: BD FA 21  ; 
                BRA     ZF1BF                    ; F1DC: 20 E1     ; 
;------------------------------------------------
ZF1DE           CMPA    #';'                      ; F1DE: 81 3B    ; 
                BNE     ZF176                    ; F1E0: 26 94     ; 
                JSR     XINCHN1                  ; F1E2: BD FA 7F  ; Get ASCII from Port
                CMPA    #'O'                      ; F1E5: 81 4F    ; 
                BNE     ZF176                    ; F1E7: 26 8D     ; 
                LDX     MFF56                    ; F1E9: FE FF 56  ; 
                INX                              ; F1EC: 08        ; 
                STX     MFF5A                    ; F1ED: FF FF 5A  ; 
                LDAA    MFF5A                    ; F1F0: B6 FF 5A  ; 
                LDAB    MFF5B                    ; F1F3: F6 FF 5B  ; 
                SUBB    MFF09                    ; F1F6: F0 FF 09  ; 
                SBCA    MFF08                    ; F1F9: B2 FF 08  ; 
                BCS     ZF21E                    ; F1FC: 25 20     ; 
                BNE     ZF216                    ; F1FE: 26 16     ; 
                CMPB    #$81                     ; F200: C1 81     ; 
                BCC     ZF216                    ; F202: 24 12     ; 
                NEGB                             ; F204: 50        ; 
ZF205           STAB    MFF07                    ; F205: F7 FF 07  ; 
                JSR     XPSPAC1                  ; F208: BD F9 CB  ; 
                LDX     #MFF07                   ; F20B: CE FF 07  ; 
                JSR     XOUT2H1                  ; F20E: BD F9 C9  ; 
ZF211           JSR     XPCRLF1                  ; F211: BD FA 21  ; 
                BRA     ZF1C2                    ; F214: 20 AC     ; 
;------------------------------------------------
ZF216           LDX     #INVALID                 ; F216: CE FB 7D  ; 
                JSR     XPDAT1                   ; F219: BD FA 16  ; 
                BRA     ZF211                    ; F21C: 20 F3     ; 
;------------------------------------------------
ZF21E           LDAA    MFF08                    ; F21E: B6 FF 08  ; 
                LDAB    MFF09                    ; F221: F6 FF 09  ; 
                SUBB    MFF5B                    ; F224: F0 FF 5B  ; 
                SBCA    MFF5A                    ; F227: B2 FF 5A  ; 
                BNE     ZF216                    ; F22A: 26 EA     ; 
                ASLB                             ; F22C: 58        ; 
                BCS     ZF216                    ; F22D: 25 E7     ; 
                LSRB                             ; F22F: 54        ; 
                BRA     ZF205                    ; F230: 20 D3     ; 
;------------------------------------------------
ZF232           LDAA    MFF08                    ; F232: B6 FF 08  ; 
                BNE     ZF298                    ; F235: 26 61     ; 
                LDAA    MFF09                    ; F237: B6 FF 09  ; 
                STAA    MFF13                    ; F23A: B7 FF 13  ; 
                LDX     MFF0A                    ; F23D: FE FF 0A  ; 
ZF240           STX     MFF56                    ; F240: FF FF 56  ; 
                LDAA    ,X                       ; F243: A6 00     ; 
                EORA    MFF13                    ; F245: B8 FF 13  ; 
                ANDA    MFF12                    ; F248: B4 FF 12  ; 
                BNE     ZF25C                    ; F24B: 26 0F     ; 
                JSR     XPCRLF1                  ; F24D: BD FA 21  ; 
                LDX     #MFF56                   ; F250: CE FF 56  ; 
                JSR     XOUT4H1                  ; F253: BD F9 C7  ; 
                LDX     MFF56                    ; F256: FE FF 56  ; 
                JSR     XOUT2H1                  ; F259: BD F9 C9  ; 
ZF25C           LDX     MFF56                    ; F25C: FE FF 56  ; 
                CPX     MFF0C                    ; F25F: BC FF 0C  ; 
                BEQ     JMP2MAID                 ; F262: 27 42     ; 
                INX                              ; F264: 08        ; 
                BRA     ZF240                    ; F265: 20 D9     ; 
;------------------------------------------------
GOT_T1          CLR     MFF60                    ; F267: 7F FF 60  ; 
                CLR     MFF54                    ; F26A: 7F FF 54  ; 
                BRA     JMP2MAID                 ; F26D: 20 37     ; 
;------------------------------------------------
GOT_S1          CLR     MFF5D                    ; F26F: 7F FF 5D  ; 
                BRA     JMP2MAID                 ; F272: 20 32     ; 
;------------------------------------------------
ZF274           JSR     XINCHN1                  ; F274: BD FA 7F  ; Get ASCII from Port
                CMPA    #'G'                      ; F277: 81 47    ; 
                BNE     ZF27E                    ; F279: 26 03     ; 
                JMP     GOT_G1                   ; F27B: 7E F3 E9  ; 

ZF27E           CMPA    #'N'                      ; F27E: 81 4E    ; 
                BNE     ZF285                    ; F280: 26 03     ; 
                JMP     GOT_N1                   ; F282: 7E F1 4B  ; 

ZF285           CMPA    #'P'                      ; F285: 81 50    ; 
                BNE     ZF28C                    ; F287: 26 03     ; 
                JMP     GOT_P1                   ; F289: 7E F3 C5  ; 

ZF28C           CMPA    #'S'                      ; F28C: 81 53    ; 
                BEQ     GOT_S1                   ; F28E: 27 DF     ; 
                CMPA    #'T'                      ; F290: 81 54    ; 
                BEQ     GOT_T1                   ; F292: 27 D3     ; 
                CMPA    #'U'                      ; F294: 81 55    ; 
                BEQ     GOT_U1                   ; F296: 27 03     ; 
ZF298           JMP     OUTQM                    ; F298: 7E F1 1E  ; no match, output '?'
;------------------------------------------------
GOT_U1          LDX     #BRKPTs                  ; F29B: CE FF 1F  ; 
ZF29E           CLR     ,X                       ; F29E: 6F 00     ; 
                INX                              ; F2A0: 08        ; 
                CPX     #BKPINs                  ; F2A1: 8C FF 4F  ; 
                BNE     ZF29E                    ; F2A4: 26 F8     ; 
JMP2MAID        JMP     MAIDs                    ; F2A6: 7E F0 F3  ; 
;------------------------------------------------
ZF2A9           LDAA    XREGsP                   ; F2A9: B6 FF 16  ; 
                LDAB    MFF17                    ; F2AC: F6 FF 17  ; 
ZF2AF           LDX     #BRKPTs                  ; F2AF: CE FF 1F  ; 
ZF2B2           CMPA    ,X                       ; F2B2: A1 00     ; 
                BNE     ZF2BB                    ; F2B4: 26 05     ; 
                CMPB    $01,X                    ; F2B6: E1 01     ; 
                BNE     ZF2BB                    ; F2B8: 26 01     ; 
                RTS                              ; F2BA: 39        ; 
;------------------------------------------------
ZF2BB           INX                              ; F2BB: 08        ; 
                INX                              ; F2BC: 08        ; 
                CPX     #MFF2F                   ; F2BD: 8C FF 2F  ; 
                BNE     ZF2B2                    ; F2C0: 26 F0     ; 
                LDAA    #$FF                     ; F2C2: 86 FF     ; 
                RTS                              ; F2C4: 39        ; 
;------------------------------------------------
GOTPXS          JSR     ZFA9F                    ; F2C5: BD FA 9F  ; 
                JSR     ZF961                    ; F2C8: BD F9 61  ; 
                INX                              ; F2CB: 08        ; 
                BRA     ZF2D4                    ; F2CC: 20 06     ; 
;------------------------------------------------
GOTABC          JSR     ZFA9F                    ; F2CE: BD FA 9F  ; 
                JSR     ZF96A                    ; F2D1: BD F9 6A  ; 
ZF2D4           CMPA    #$0D                     ; F2D4: 81 0D     ; 
                BEQ     JMP2MAID                 ; F2D6: 27 CE     ; 
                INX                              ; F2D8: 08        ; 
                CMPA    #$0A                     ; F2D9: 81 0A     ; 
                BEQ     ZF2E0                    ; F2DB: 27 03     ; 
                JMP     XPCRLF1                  ; F2DD: 7E FA 21  ; 
;------------------------------------------------
ZF2E0           JMP     OUTCR                    ; F2E0: 7E FA 25  ; 
;------------------------------------------------
GOT_R           JSR     ZFAA5                    ; F2E3: BD FA A5  ; 
                JSR     XPCRLF1                  ; F2E6: BD FA 21  ; 
                LDX     #XREGsP                  ; F2E9: CE FF 16  ; 
                LDAA    #'P'                      ; F2EC: 86 50    ; 
                BSR     GOTPXS                   ; F2EE: 8D D5     ; 
                LDAA    #'X'                      ; F2F0: 86 58    ; 
                BSR     GOTPXS                   ; F2F2: 8D D1     ; 
                LDAA    #'A'                      ; F2F4: 86 41    ; 
                BSR     GOTABC                   ; F2F6: 8D D6     ; 
                LDAA    #'B'                      ; F2F8: 86 42    ; 
                BSR     GOTABC                   ; F2FA: 8D D2     ; 
                LDAA    #'C'                      ; F2FC: 86 43    ; 
                BSR     GOTABC                   ; F2FE: 8D CE     ; 
                LDAA    #'S'                      ; F300: 86 53    ; 
                BSR     GOTPXS                   ; F302: 8D C1     ; 
                BRA     JMP2MAID                 ; F304: 20 A0     ; 
;------------------------------------------------
GOT_M           JSR     XPSPAC1                  ; F306: BD F9 CB  ; 
                LDX     #MFF12                   ; F309: CE FF 12  ; 
                JSR     ZF96A                    ; F30C: BD F9 6A  ; 
                BMI     ZF32E                    ; F30F: 2B 1D     ; 
                JSR     XBEGEN1                  ; F311: BD F7 87  ; 
ZF314           BRA     JMP2MAID                 ; F314: 20 90     ; 
;------------------------------------------------
ZF316           JSR     XINCHN1                  ; F316: BD FA 7F  ; Get ASCII from Port
                TAB                              ; F319: 16        ; 
                CMPB    #'R'                      ; F31A: C1 52    ; 
                BEQ     GOT_R                    ; F31C: 27 C5     ; 
                CMPB    #'V'                      ; F31E: C1 56    ; 
                BEQ     GOT_V                    ; F320: 27 0F     ; 
                CMPB    #'M'                      ; F322: C1 4D    ; 
                BEQ     GOT_M                    ; F324: 27 E0     ; 
                CMPB    #'T'                      ; F326: C1 54    ; 
                BEQ     GOT_T                    ; F328: 27 2C     ; 
                CMPB    #'S'                      ; F32A: C1 53    ; 
                BEQ     GOT_S                    ; F32C: 27 13     ; 
ZF32E           JMP     OUTQM                    ; F32E: 7E F1 1E  ; no match, output '?'
;------------------------------------------------
GOT_V           JSR     XPCRLF1                  ; F331: BD FA 21  ; 
                LDX     #BRKPTs                  ; F334: CE FF 1F  ; 
                LDAB    #$08                     ; F337: C6 08     ; 
ZF339           JSR     XOUT4H1                  ; F339: BD F9 C7  ; 
                DECB                             ; F33C: 5A        ; 
                BNE     ZF339                    ; F33D: 26 FA     ; 
                BRA     ZF314                    ; F33F: 20 D3     ; 
;------------------------------------------------
GOT_S           LDX     #STOPADDR                ; F341: CE FB A4  ; Load Text
                JSR     XPDATA1                  ; F344: BD FA 14  ; Output it
                LDX     #MFF5E                   ; F347: CE FF 5E  ; 
                JSR     ZF961                    ; F34A: BD F9 61  ; 
                BMI     ZF32E                    ; F34D: 2B DF     ; 
                LDAA    #$FF                     ; F34F: 86 FF     ; 
                STAA    MFF5D                    ; F351: B7 FF 5D  ; 
                BRA     ZF314                    ; F354: 20 BE     ; 
;------------------------------------------------
GOT_T           LDX     #ENDADDR                 ; F356: CE FB 44  ; Load Text
                JSR     XPDATA1                  ; F359: BD FA 14  ; Output it
                LDX     #MFF14                   ; F35C: CE FF 14  ; 
                JSR     ZF961                    ; F35F: BD F9 61  ; 
                BMI     ZF32E                    ; F362: 2B CA     ; 
                LDAA    #$FF                     ; F364: 86 FF     ; 
                STAA    MFF60                    ; F366: B7 FF 60  ; 
                CLR     MFF50                    ; F369: 7F FF 50  ; 
                BRA     ZF314                    ; F36C: 20 A6     ; 
;------------------------------------------------
ZF36E           TST     BKPINs                   ; F36E: 7D FF 4F  ; 
                BNE     ZF39F                    ; F371: 26 2C     ; 
                LDX     #BRKPTs                  ; F373: CE FF 1F  ; 
ZF376           STX     MFF56                    ; F376: FF FF 56  ; 
                LDAA    ,X                       ; F379: A6 00     ; 
                ORAA    $01,X                    ; F37B: AA 01     ; 
                BEQ     ZF393                    ; F37D: 27 14     ; 
                LDX     ,X                       ; F37F: EE 00     ; 
                LDAA    ,X                       ; F381: A6 00     ; 
                LDAB    #$3F                     ; F383: C6 3F     ; 
                STAB    ,X                       ; F385: E7 00     ; 
                CMPB    ,X                       ; F387: E1 00     ; 
                BEQ     ZF38E                    ; F389: 27 03     ; 
                JMP     ZF99C                    ; F38B: 7E F9 9C  ; 
;------------------------------------------------
ZF38E           LDX     MFF56                    ; F38E: FE FF 56  ; 
                STAA    $10,X                    ; F391: A7 10     ; 
ZF393           INX                              ; F393: 08        ; 
                INX                              ; F394: 08        ; 
                CPX     #MFF2F                   ; F395: 8C FF 2F  ; 
                BNE     ZF376                    ; F398: 26 DC     ; 
                LDAA    #$FF                     ; F39A: 86 FF     ; 
                STAA    BKPINs                   ; F39C: B7 FF 4F  ; 
ZF39F           RTS                              ; F39F: 39        ; 
;------------------------------------------------
ZF3A0           TST     BKPINs                   ; F3A0: 7D FF 4F  ; 
                BEQ     ZF3C1                    ; F3A3: 27 1C     ; 
                LDX     #BRKPTs                  ; F3A5: CE FF 1F  ; 
ZF3A8           STX     MFF56                    ; F3A8: FF FF 56  ; 
                LDAA    ,X                       ; F3AB: A6 00     ; 
                ORAA    $01,X                    ; F3AD: AA 01     ; 
                BEQ     ZF3B7                    ; F3AF: 27 06     ; 
                LDAA    $10,X                    ; F3B1: A6 10     ; 
                LDX     ,X                       ; F3B3: EE 00     ; 
                STAA    ,X                       ; F3B5: A7 00     ; 
ZF3B7           LDX     MFF56                    ; F3B7: FE FF 56  ; 
                INX                              ; F3BA: 08        ; 
                INX                              ; F3BB: 08        ; 
                CPX     #MFF2F                   ; F3BC: 8C FF 2F  ; 
                BNE     ZF3A8                    ; F3BF: 26 E7     ; 
ZF3C1           CLR     BKPINs                   ; F3C1: 7F FF 4F  ; 
                RTS                              ; F3C4: 39        ; 
;------------------------------------------------
GOT_P1          TST     MFF60                    ; F3C5: 7D FF 60  ; 
                BNE     ZF401                    ; F3C8: 26 37     ; 
                JSR     ZF2A9                    ; F3CA: BD F2 A9  ; 
                BEQ     ZF401                    ; F3CD: 27 32     ; 
                BRA     ZF3FC                    ; F3CF: 20 2B     ; 
;------------------------------------------------
ZF3D1           TST     MFF60                    ; F3D1: 7D FF 60  ; 
                BNE     ZF3DB                    ; F3D4: 26 05     ; 
                JSR     ZF2A9                    ; F3D6: BD F2 A9  ; 
                BEQ     ZF3DE                    ; F3D9: 27 03     ; 
ZF3DB           JMP     OUTQM                    ; F3DB: 7E F1 1E  ; no match, output '?'
;------------------------------------------------
ZF3DE           LDS     MFF08                    ; F3DE: BE FF 08  ; 
                DES                              ; F3E1: 34        ; 
                STS     $20,X                    ; F3E2: AF 20     ; 
                LDS     #XSTAKs                  ; F3E4: 8E FF 8A  ; 
                BRA     ZF401                    ; F3E7: 20 18     ; 
;------------------------------------------------
GOT_G1          LDX     RAMBGN                   ; F3E9: FE FF 00  ; 
                DEX                              ; F3EC: 09        ; 
                LDX     ,X                       ; F3ED: EE 00     ; 
                BRA     ZF3F4                    ; F3EF: 20 03     ; 
;------------------------------------------------
GOT_G2          LDX     MFF08                    ; F3F1: FE FF 08  ; 
ZF3F4           STX     XREGsP                   ; F3F4: FF FF 16  ; 
                TST     MFF60                    ; F3F7: 7D FF 60  ; 
                BMI     ZF401                    ; F3FA: 2B 05     ; 
ZF3FC           JSR     ZF36E                    ; F3FC: BD F3 6E  ; 
                BRA     ZF406                    ; F3FF: 20 05     ; 
;------------------------------------------------
ZF401           LDAA    #$FF                     ; F401: 86 FF     ; 
                STAA    MFF54                    ; F403: B7 FF 54  ; 
ZF406           LDAB    #$05                     ; F406: C6 05     ; 
                LDS     XREGsS                   ; F408: BE FF 1D  ; 
                LDX     #XREGsP                  ; F40B: CE FF 16  ; 
ZF40E           LDAA    $01,X                    ; F40E: A6 01     ; 
                PSHA                             ; F410: 36        ; 
                LDAA    ,X                       ; F411: A6 00     ; 
                PSHA                             ; F413: 36        ; 
                INX                              ; F414: 08        ; 
                INX                              ; F415: 08        ; 
                DECB                             ; F416: 5A        ; 
                CMPB    #$03                     ; F417: C1 03     ; 
                BNE     ZF40E                    ; F419: 26 F3     ; 
ZF41B           LDAA    ,X                       ; F41B: A6 00     ; 
                PSHA                             ; F41D: 36        ; 
                INX                              ; F41E: 08        ; 
                DECB                             ; F41F: 5A        ; 
                BNE     ZF41B                    ; F420: 26 F9     ; 
                TST     MFF5D                    ; F422: 7D FF 5D  ; 
                BEQ     ZF438                    ; F425: 27 11     ; 
                LDAA    MFF5F                    ; F427: B6 FF 5F  ; 
                STAA    PIADRA                   ; F42A: B7 FC F8  ; 
                LDAA    MFF5E                    ; F42D: B6 FF 5E  ; 
                STAA    PIADRB                   ; F430: B7 FC FA  ; 
                LDAA    #$34                     ; F433: 86 34     ; 
                STAA    PIACRA                   ; F435: B7 FC F9  ; 
ZF438           TST     MFF54                    ; F438: 7D FF 54  ; 
                BEQ     ZF447                    ; F43B: 27 0A     ; 
                LDAA    #$34                     ; F43D: 86 34     ; 
                STAA    PIACRB                   ; F43F: B7 FC FB  ; 
                LDAA    #$3C                     ; F442: 86 3C     ; 
                STAA    PIACRB                   ; F444: B7 FC FB  ; 
ZF447           RTI                              ; F447: 3B        ; 
;------------------------------------------------
;               SWI Interrupt Service Routine
;------------------------------------------------
MF448           LDAA    #$3C                     ; F448: 86 3C     ; SWI ISR
                STAA    PIACRA                   ; F44A: B7 FC F9  ; sel output reg., CA2 high
                LDAB    #$07                     ; F44D: C6 07     ; 
                LDX     #XREGsC                  ; F44F: CE FF 1C  ; 
ZF452           PULA                             ; F452: 32        ; 
                STAA    ,X                       ; F453: A7 00     ; 
                DEX                              ; F455: 09        ; 
                DECB                             ; F456: 5A        ; 
                BNE     ZF452                    ; F457: 26 F9     ; 
                STS     XREGsS                   ; F459: BF FF 1D  ; 
                LDS     #XSTAKs                  ; F45C: 8E FF 8A  ; 
                BSR     ZF496                    ; F45F: 8D 35     ; 
                LDX     XREGsP                   ; F461: FE FF 16  ; 
                DEX                              ; F464: 09        ; 
                STX     XREGsP                   ; F465: FF FF 16  ; 
                TST     BKPINs                   ; F468: 7D FF 4F  ; 
                BEQ     ZF481                    ; F46B: 27 14     ; 
                JSR     ZF3A0                    ; F46D: BD F3 A0  ; 
                JSR     ZF2A9                    ; F470: BD F2 A9  ; 
                BNE     ZF481                    ; F473: 26 0C     ; 
                LDS     $20,X                    ; F475: AE 20     ; 
                BEQ     ZF48D                    ; F477: 27 14     ; 
                DES                              ; F479: 34        ; 
                STS     $20,X                    ; F47A: AF 20     ; 
                LDS     #XSTAKs                  ; F47C: 8E FF 8A  ; 
                BRA     ZF401                    ; F47F: 20 80     ; 

ZF481           LDX     #BKPTERR                 ; F481: CE FB C8  ; Load Text
                JSR     XPDATA1                  ; F484: BD FA 14  ; Output it
                CLR     MFF60                    ; F487: 7F FF 60  ; 
                CLR     MFF54                    ; F48A: 7F FF 54  ; 
ZF48D           LDS     #XSTAKs                  ; F48D: 8E FF 8A  ; 
                JSR     ZFAA5                    ; F490: BD FA A5  ; 
                JMP     MAIDs                    ; F493: 7E F0 F3  ; 
;------------------------------------------------
ZF496           LDX     #XREGsP                  ; F496: CE FF 16  ; 
                LDAA    ,X                       ; F499: A6 00     ; 
                LDAB    $01,X                    ; F49B: E6 01     ; 
                STAA    $01,X                    ; F49D: A7 01     ; 
                STAB    ,X                       ; F49F: E7 00     ; 
                LDAA    $02,X                    ; F4A1: A6 02     ; 
                LDAB    $03,X                    ; F4A3: E6 03     ; 
                STAA    $03,X                    ; F4A5: A7 03     ; 
                STAB    $02,X                    ; F4A7: E7 02     ; 
                RTS                              ; F4A9: 39        ; 
;------------------------------------------------
;               NMI Interrupt Service Routine
;------------------------------------------------
MF4AA           LDAA    #$3C                     ; F4AA: 86 3C     ; NMI ISR
                STAA    PIACRA                   ; F4AC: B7 FC F9  ; sel output reg., CA2 high
                LDAA    #$34                     ; F4AF: 86 34     ; 
                STAA    PIACRB                   ; F4B1: B7 FC FB  ; sel output reg., CB2 low
                TSX                              ; F4B4: 30        ; 
                LDAA    ,X                       ; F4B5: A6 00     ; 
                BITA    #$10                     ; F4B7: 85 10     ; 
                BNE     ZF4D7                    ; F4B9: 26 1C     ; 
                TST     PROM_1                   ; F4BB: 7D FC FD  ; 
                BPL     ZF4D7                    ; F4BE: 2A 17     ; ACIA IRQ ?
                LDAB    #$07                     ; F4C0: C6 07     ; ACIA IRQ enabled
ZF4C2           LDAA    $06,X                    ; F4C2: A6 06     ; 
                PSHA                             ; F4C4: 36        ; 
                DEX                              ; F4C5: 09        ; 
                DECB                             ; F4C6: 5A        ; 
                BNE     ZF4C2                    ; F4C7: 26 F9     ; 
                ORAA    #$10                     ; F4C9: 8A 10     ; 
                INS                              ; F4CB: 31        ; 
                PSHA                             ; F4CC: 36        ; 
                LDAA    IRQsVC                   ; F4CD: B6 FF F8  ; 
                STAA    $05,X                    ; F4D0: A7 05     ; 
                LDAA    MFFF9                    ; F4D2: B6 FF F9  ; 
                STAA    $06,X                    ; F4D5: A7 06     ; 
ZF4D7           LDAB    #$07                     ; F4D7: C6 07     ; ACIA IRQ disabled
                LDX     #XREGsC                  ; F4D9: CE FF 1C  ; 
ZF4DC           PULA                             ; F4DC: 32        ; 
                STAA    ,X                       ; F4DD: A7 00     ; 
                DEX                              ; F4DF: 09        ; 
                DECB                             ; F4E0: 5A        ; 
                BNE     ZF4DC                    ; F4E1: 26 F9     ; 
                STS     XREGsS                   ; F4E3: BF FF 1D  ; 
                LDS     #XSTAKs                  ; F4E6: 8E FF 8A  ; 
                BSR     ZF496                    ; F4E9: 8D AB     ; 
                JSR     ZF3A0                    ; F4EB: BD F3 A0  ; 
                JSR     WAIT1                    ; F4EE: BD F6 1B  ; 
                LDAA    PIACRA                   ; F4F1: B6 FC F9  ; 
                LDAB    PIADRA                   ; F4F4: F6 FC F8  ; 
                TSTA                             ; F4F7: 4D        ; 
                BMI     ZF53C                    ; F4F8: 2B 42     ; 
                LDAA    PIACRB                   ; F4FA: B6 FC FB  ; 
                LDAB    PIADRB                   ; F4FD: F6 FC FA  ; 
                TSTA                             ; F500: 4D        ; 
                BMI     ZF52A                    ; F501: 2B 27     ; 
                TST     MFF60                    ; F503: 7D FF 60  ; 
                BEQ     ZF536                    ; F506: 27 2E     ; 
                JSR     ZFAA5                    ; F508: BD FA A5  ; 
                TST     MFF50                    ; F50B: 7D FF 50  ; 
                BEQ     ZF51C                    ; F50E: 27 0C     ; 
                LDX     MFF51                    ; F510: FE FF 51  ; 
                BEQ     ZF524                    ; F513: 27 0F     ; 
                DEX                              ; F515: 09        ; 
                STX     MFF51                    ; F516: FF FF 51  ; 
ZF519           JMP     ZF406                    ; F519: 7E F4 06  ; 

ZF51C           LDX     XREGsP                   ; F51C: FE FF 16  ; 
                CPX     MFF14                    ; F51F: BC FF 14  ; 
                BNE     ZF519                    ; F522: 26 F5     ; 
ZF524           CLR     MFF50                    ; F524: 7F FF 50  ; 
                JMP     GOT_T1                   ; F527: 7E F2 67  ; 

ZF52A           LDX     #STOPONADDR              ; F52A: CE FB 93  ; Load Text
                JSR     XPDATA1                  ; F52D: BD FA 14  ; Output it
                JSR     ZFAA8                    ; F530: BD FA A8  ; 
                JMP     MAIDs                    ; F533: 7E F0 F3  ; 

ZF536           CLR     MFF54                    ; F536: 7F FF 54  ; 
                JMP     ZF3FC                    ; F539: 7E F3 FC  ; 

ZF53C           LDX     #ABORTED                 ; F53C: CE FB AF  ; Load Text
                JSR     XPDATA1                  ; F53F: BD FA 14  ; Output it
                JSR     ZFAA8                    ; F542: BD FA A8  ; 
                BRA     ZF56A                    ; F545: 20 23     ; 
;------------------------------------------------
PWRUP1          NOP                              ; F547: 01        ; We start here after Reset
                SEI                              ; F548: 0F        ; 
                CLRA                             ; F549: 4F        ; 
                LDX     #M0000                   ; F54A: CE 00 00  ; 
                STX     MFF0E                    ; F54D: FF FF 0E  ; 
                STX     MFF10                    ; F550: FF FF 10  ; 
                STX     MFFF6                    ; F553: FF FF F6  ; 
                STAA    MFF02                    ; F556: B7 FF 02  ; 
                LDAA    #$03                     ; F559: 86 03     ; 
                STAA    ACIA_0                   ; F55B: B7 FC F4  ; 
                LDX     #M83FF                   ; F55E: CE 83 FF  ; 
                STX     RAMBGN                   ; F561: FF FF 00  ; 
                LDS     #XSTAKs                  ; F564: 8E FF 8A  ; 
                STS     XREGsS                   ; F567: BF FF 1D  ; 
ZF56A           LDX     #MF4AA                   ; F56A: CE F4 AA  ; 
                STX     NMIsVC                   ; F56D: FF FF FC  ; 
                LDX     #MF448                   ; F570: CE F4 48  ; 
                STX     SWIsVC                   ; F573: FF FF FA  ; 
                LDX     RAMBGN                   ; F576: FE FF 00  ; 
                LDAA    #$07                     ; F579: 86 07     ; 
ZF57B           DEX                              ; F57B: 09        ; 
                DECA                             ; F57C: 4A        ; 
                BNE     ZF57B                    ; F57D: 26 FC     ; 
                LDX     ,X                       ; F57F: EE 00     ; 
                STX     IRQsVC                   ; F581: FF FF F8  ; 
                LDX     #BRKPTs                  ; F584: CE FF 1F  ; 
ZF587           CLR     ,X                       ; F587: 6F 00     ; 
                INX                              ; F589: 08        ; 
                CPX     #MFF63                   ; F58A: 8C FF 63  ; 
                BNE     ZF587                    ; F58D: 26 F8     ; 
                LDX     #PIADRA                  ; F58F: CE FC F8  ; 
                LDAA    #$38                     ; F592: 86 38     ; 
                STAA    $01,X                    ; F594: A7 01     ; 
                LDAA    #$30                     ; F596: 86 30     ; 
                STAA    $03,X                    ; F598: A7 03     ; 
                LDAA    #$FF                     ; F59A: 86 FF     ; 
                STAA    ,X                       ; F59C: A7 00     ; 
                STAA    $02,X                    ; F59E: A7 02     ; 
                LDAA    #$34                     ; F5A0: 86 34     ; 
                STAA    $03,X                    ; F5A2: A7 03     ; 
                LDAA    #$3C                     ; F5A4: 86 3C     ; 
                STAA    $01,X                    ; F5A6: A7 01     ; 
                LDAA    PROM_1                   ; F5A8: B6 FC FD  ; for this we actually need the PROM
                ANDA    #$3F                     ; F5AB: 84 3F     ; it stores the configuration for the ACIA
                STAA    ACIA_0                   ; F5AD: B7 FC F4  ; |
                BSR     PRNTDLE                  ; F5B0: 8D 70     ; Print a DLE char
                LDAA    #':'                     ; F5B2: 86 3A     ; Print ':'
                BSR     OUTCNS2                  ; F5B4: 8D 6E     ; |
                BSR     PRNTDLE                  ; F5B6: 8D 6A     ; Print a DLE char
                LDAA    #'9'                     ; F5B8: 86 39     ; Print '9'
                BSR     OUTCNS2                  ; F5BA: 8D 68     ; |
                LDX     #MFBBB                   ; F5BC: CE FB BB  ; 
                JSR     XPDAT1                   ; F5BF: BD FA 16  ; Print String from FBBB
REENT3          LDS     #XSTAKs                  ; F5C2: 8E FF 8A  ; 
                BSR     WAIT1                    ; F5C5: 8D 54     ; 
                LDX     #GREETING                ; F5C7: CE FB 2F  ; Load Text
                JSR     XPDATA1                  ; F5CA: BD FA 14  ; Output it
                LDAA    ACIA_1                   ; F5CD: B6 FC F5  ; Get character
                LDX     #MFF03                   ; F5D0: CE FF 03  ; Buffer start
ZF5D3           JSR     ZFA2C                    ; F5D3: BD FA 2C  ; Check for 'X' or '^'
                STAA    ,X                       ; F5D6: A7 00     ; store it into buffer
                INX                              ; F5D8: 08        ; |
                CPX     #MFF07                   ; F5D9: 8C FF 07  ; |
                BNE     ZF5D3                    ; F5DC: 26 F5     ; |
                LDX     #XBUGCMD                 ; F5DE: CE FA ED  ; Load command strings start
ZF5E1           BSR     STRCMP                   ; F5E1: 8D 11     ; 
                CPX     #GREETING                ; F5E3: 8C FB 2F  ; 
                BNE     ZF5E1                    ; F5E6: 26 F9     ; 
                LDX     MFF0E                    ; F5E8: FE FF 0E  ; 
ZF5EB           CPX     MFF10                    ; F5EB: BC FF 10  ; 
                BEQ     REENT3                   ; F5EE: 27 D2     ; 
                BSR     STRCMP                   ; F5F0: 8D 02     ; 
                BRA     ZF5EB                    ; F5F2: 20 F7     ; 

STRCMP          LDAA    MFF03                    ; F5F4: B6 FF 03  ; Compare strings, load buffer start
                CMPA    ,X                       ; F5F7: A1 00     ; 
                BNE     INCR6                    ; F5F9: 26 19     ; no, go to end and exit
                LDAA    MFF04                    ; F5FB: B6 FF 04  ; 1st char found
                CMPA    $01,X                    ; F5FE: A1 01     ; 
                BNE     INCR6                    ; F600: 26 12     ; no, go to end and exit
                LDAA    MFF05                    ; F602: B6 FF 05  ; 2nd char found
                CMPA    $02,X                    ; F605: A1 02     ; 
                BNE     INCR6                    ; F607: 26 0B     ; no, go to end and exit
                LDAA    MFF06                    ; F609: B6 FF 06  ; 3rd char found
                CMPA    $03,X                    ; F60C: A1 03     ; 
                BNE     INCR6                    ; F60E: 26 04     ; no, go to end and exit
                LDX     $04,X                    ; F610: EE 04     ; 4th char found
                JMP     ,X                       ; F612: 6E 00     ; execute!

INCR6           INX                              ; F614: 08        ; 
                INX                              ; F615: 08        ; 
                INX                              ; F616: 08        ; 
                INX                              ; F617: 08        ; 
                INX                              ; F618: 08        ; 
                INX                              ; F619: 08        ; 
                RTS                              ; F61A: 39        ; 
;------------------------------------------------
WAIT1           LDX     #M30D4                   ; F61B: CE 30 D4  ; 
ZF61E           DEX                              ; F61E: 09        ; 
                BNE     ZF61E                    ; F61F: 26 FD     ; 
                RTS                              ; F621: 39        ; 
;------------------------------------------------
PRNTDLE         LDAA    #$10                     ; F622: 86 10     ; Data Link Escape
OUTCNS2         JMP     OUTCNSF                  ; F624: 7E F9 CF  ; output A to serial
;------------------------------------------------
TERM            JSR     XPSPAC1                  ; F627: BD F9 CB  ; 
                LDX     #MFFF6                   ; F62A: CE FF F6  ; 
                JSR     ZF961                    ; F62D: BD F9 61  ; 
                BMI     TERM                     ; F630: 2B F5     ; 
                BRA     REENT3                   ; F632: 20 8E     ; 
;------------------------------------------------
ZF634           LDX     #HD_TXT                  ; F634: CE FB F9  ; 
                JSR     XPDATA1                  ; F637: BD FA 14  ; 
                LDX     #MFF8D                   ; F63A: CE FF 8D  ; 
ZF63D           JSR     XINCHN1                  ; F63D: BD FA 7F  ; Get ASCII from Port
                CMPA    #$20                     ; F640: 81 20     ; 
                BLT     ZF648                    ; F642: 2D 04     ; 
                CMPA    #$61                     ; F644: 81 61     ; 
                BLT     ZF64A                    ; F646: 2D 02     ; 
ZF648           LDAA    #$20                     ; F648: 86 20     ; 
ZF64A           STAA    ,X                       ; F64A: A7 00     ; 
                INX                              ; F64C: 08        ; 
                CPX     #MFF93                   ; F64D: 8C FF 93  ; 
                BNE     ZF63D                    ; F650: 26 EB     ; 
                JSR     ZF70C                    ; F652: BD F7 0C  ; 
                SEC                              ; F655: 0D        ; 
                ROL     MFF62                    ; F656: 79 FF 62  ; 
                TST     MFF02                    ; F659: 7D FF 02  ; 
                BPL     ZF665                    ; F65C: 2A 07     ; 
                BSR     PRNTDLE                  ; F65E: 8D C2     ; 
                LDAA    #$30                     ; F660: 86 30     ; 
                JSR     XOUTCH1                  ; F662: BD F9 E2  ; 
ZF665           LDAA    #$12                     ; F665: 86 12     ; 
                JSR     XOUTCH1                  ; F667: BD F9 E2  ; 
                JSR     ZF702                    ; F66A: BD F7 02  ; 
                LDAB    #$83                     ; F66D: C6 83     ; 
                LDX     #S0_TXT                  ; F66F: CE FB E9  ; 
                JSR     XPDAT1                   ; F672: BD FA 16  ; 
                BSR     WAIT1                    ; F675: 8D A4     ; 
                LDX     #MFF8D                   ; F677: CE FF 8D  ; 
ZF67A           JSR     ZF6FD                    ; F67A: BD F6 FD  ; 
                CPX     #MFF93                   ; F67D: 8C FF 93  ; 
                BNE     ZF67A                    ; F680: 26 F8     ; 
                COMB                             ; F682: 53        ; 
                PSHB                             ; F683: 37        ; 
                TSX                              ; F684: 30        ; 
                BSR     ZF6FD                    ; F685: 8D 76     ; 
                PULB                             ; F687: 33        ; 
                LDX     MFF0A                    ; F688: FE FF 0A  ; 
                STX     MFF5A                    ; F68B: FF FF 5A  ; 
ZF68E           LDAA    MFF0D                    ; F68E: B6 FF 0D  ; 
                SUBA    MFF5B                    ; F691: B0 FF 5B  ; 
                LDAB    MFF0C                    ; F694: F6 FF 0C  ; 
                SBCB    MFF5A                    ; F697: F2 FF 5A  ; 
                BNE     ZF6A0                    ; F69A: 26 04     ; 
                CMPA    #$18                     ; F69C: 81 18     ; 
                BCS     ZF6A2                    ; F69E: 25 02     ; 
ZF6A0           LDAA    #$17                     ; F6A0: 86 17     ; 
ZF6A2           ADDA    #$04                     ; F6A2: 8B 04     ; 
                STAA    MFF58                    ; F6A4: B7 FF 58  ; 
                SUBA    #$03                     ; F6A7: 80 03     ; 
                STAA    MFF07                    ; F6A9: B7 FF 07  ; 
                LDX     #S1_TXT                  ; F6AC: CE FB D4  ; 
                JSR     XPDAT1                   ; F6AF: BD FA 16  ; 
                CLRB                             ; F6B2: 5F        ; 
                LDX     #MFF58                   ; F6B3: CE FF 58  ; 
                BSR     ZF6FD                    ; F6B6: 8D 45     ; 
                LDX     #MFF5A                   ; F6B8: CE FF 5A  ; 
                BSR     ZF6FD                    ; F6BB: 8D 40     ; 
                BSR     ZF6FD                    ; F6BD: 8D 3E     ; 
                LDX     MFF5A                    ; F6BF: FE FF 5A  ; 
ZF6C2           BSR     ZF6FD                    ; F6C2: 8D 39     ; 
                DEC     MFF07                    ; F6C4: 7A FF 07  ; 
                BNE     ZF6C2                    ; F6C7: 26 F9     ; 
                STX     MFF5A                    ; F6C9: FF FF 5A  ; 
                COMB                             ; F6CC: 53        ; 
                PSHB                             ; F6CD: 37        ; 
                TSX                              ; F6CE: 30        ; 
                BSR     ZF6FD                    ; F6CF: 8D 2C     ; 
                PULB                             ; F6D1: 33        ; 
                LDX     MFF5A                    ; F6D2: FE FF 5A  ; 
                DEX                              ; F6D5: 09        ; 
                CPX     MFF0C                    ; F6D6: BC FF 0C  ; 
                BNE     ZF68E                    ; F6D9: 26 B3     ; 
                LDX     #S9_TXT                  ; F6DB: CE FB DA  ; 
                JSR     XPDAT1                   ; F6DE: BD FA 16  ; 
                BSR     ZF702                    ; F6E1: 8D 1F     ; 
                JSR     XPCRLF1                  ; F6E3: BD FA 21  ; 
                LDAA    #$14                     ; F6E6: 86 14     ; 
                JSR     XOUTCH1                  ; F6E8: BD F9 E2  ; 
                TST     MFF02                    ; F6EB: 7D FF 02  ; 
                BPL     ZF6F8                    ; F6EE: 2A 08     ; 
                JSR     PRNTDLE                  ; F6F0: BD F6 22  ; 
                LDAA    #$39                     ; F6F3: 86 39     ; 
                JSR     XOUTCH1                  ; F6F5: BD F9 E2  ; 
ZF6F8           CLR     MFF62                    ; F6F8: 7F FF 62  ; 
                BRA     PUNCH                    ; F6FB: 20 1D     ; 
;------------------------------------------------
ZF6FD           ADDB    ,X                       ; F6FD: EB 00     ; 
                JMP     OUTHX2                   ; F6FF: 7E FA 07  ; 
;------------------------------------------------
ZF702           LDAB    #$37                     ; F702: C6 37     ; 
ZF704           CLRA                             ; F704: 4F        ; 
                JSR     XOUTCH1                  ; F705: BD F9 E2  ; 
                DECB                             ; F708: 5A        ; 
                BNE     ZF704                    ; F709: 26 F9     ; 
                RTS                              ; F70B: 39        ; 
;------------------------------------------------
ZF70C           LDX     #EXEC                    ; F70C: CE FB 83  ; 
                JSR     XPDATA1                  ; F70F: BD FA 14  ; 
                JSR     ZFA2C                    ; F712: BD FA 2C  ; 
                CMPA    #'Y'                      ; F715: 81 59    ; 
                BNE     ZF70C                    ; F717: 26 F3     ; 
                RTS                              ; F719: 39        ; 
;------------------------------------------------
PUNCH           BSR     XBEGEN1                  ; F71A: 8D 6B     ; 
                LDAA    MFF04                    ; F71C: B6 FF 04  ; 
                CMPA    #'R'                      ; F71F: 81 52    ; 
                BEQ     ZF726                    ; F721: 27 03     ; 
                JMP     ZF634                    ; F723: 7E F6 34  ; 
;------------------------------------------------
ZF726           BSR     ZF70C                    ; F726: 8D E4     ; 
                LDX     MFF0A                    ; F728: FE FF 0A  ; 
                STX     MFF08                    ; F72B: FF FF 08  ; 
                LDAA    MFF09                    ; F72E: B6 FF 09  ; 
                ANDA    #$F0                     ; F731: 84 F0     ; 
                STAA    MFF09                    ; F733: B7 FF 09  ; 
ZF736           JSR     XPCRLF1                  ; F736: BD FA 21  ; 
ZF739           JSR     XPCRLF1                  ; F739: BD FA 21  ; 
                LDX     #MFF08                   ; F73C: CE FF 08  ; 
                JSR     XOUT4H1                  ; F73F: BD F9 C7  ; 
                LDX     MFF08                    ; F742: FE FF 08  ; 
                LDAB    #$10                     ; F745: C6 10     ; 
ZF747           JSR     XOUT2H1                  ; F747: BD F9 C9  ; 
                DECB                             ; F74A: 5A        ; 
                BNE     ZF747                    ; F74B: 26 FA     ; 
                JSR     XPSPAC1                  ; F74D: BD F9 CB  ; 
                LDAB    #$10                     ; F750: C6 10     ; 
                LDX     MFF08                    ; F752: FE FF 08  ; 
ZF755           LDAA    ,X                       ; F755: A6 00     ; 
                ANDA    #$7F                     ; F757: 84 7F     ; 
                CMPA    #$20                     ; F759: 81 20     ; 
                BLT     ZF761                    ; F75B: 2D 04     ; 
                CMPA    #$61                     ; F75D: 81 61     ; 
                BLT     ZF763                    ; F75F: 2D 02     ; 
ZF761           LDAA    #$2E                     ; F761: 86 2E     ; 
ZF763           JSR     XOUTCH1                  ; F763: BD F9 E2  ; 
                INX                              ; F766: 08        ; 
                DECB                             ; F767: 5A        ; 
                BNE     ZF755                    ; F768: 26 EB     ; 
                STX     MFF08                    ; F76A: FF FF 08  ; 
                CPX     #M0000                   ; F76D: 8C 00 00  ; 
                BEQ     PUNCH                    ; F770: 27 A8     ; 
                LDAA    MFF0C                    ; F772: B6 FF 0C  ; 
                LDAB    MFF0D                    ; F775: F6 FF 0D  ; 
                SUBB    MFF09                    ; F778: F0 FF 09  ; 
                SBCA    MFF08                    ; F77B: B2 FF 08  ; 
                BCS     PUNCH                    ; F77E: 25 9A     ; 
                TST     MFF09                    ; F780: 7D FF 09  ; 
                BNE     ZF739                    ; F783: 26 B4     ; 
                BRA     ZF736                    ; F785: 20 AF     ; 
;------------------------------------------------
XBEGEN1         LDX     #BEGINADDR               ; F787: CE FB 3A  ; 
                JSR     XPDATA1                  ; F78A: BD FA 14  ; 
                LDX     #MFF0A                   ; F78D: CE FF 0A  ; 
                JSR     ZF961                    ; F790: BD F9 61  ; 
                BMI     XBEGEN1                  ; F793: 2B F2     ; 
ZF795           LDX     #ENDADDR                 ; F795: CE FB 44  ; 
                JSR     XPDATA1                  ; F798: BD FA 14  ; 
                LDX     #MFF0C                   ; F79B: CE FF 0C  ; 
                JSR     ZF961                    ; F79E: BD F9 61  ; 
                BMI     ZF795                    ; F7A1: 2B F2     ; 
                LDAA    MFF0C                    ; F7A3: B6 FF 0C  ; 
                LDAB    MFF0D                    ; F7A6: F6 FF 0D  ; 
                SUBB    MFF0B                    ; F7A9: F0 FF 0B  ; 
                SBCA    MFF0A                    ; F7AC: B2 FF 0A  ; 
                BCS     XBEGEN1                  ; F7AF: 25 D6     ; 
                RTS                              ; F7B1: 39        ; 
;------------------------------------------------
SEARCH          LDAA    #$FF                     ; F7B2: 86 FF     ; 
                STAA    MFF5A                    ; F7B4: B7 FF 5A  ; 
                BRA     ZF7DD                    ; F7B7: 20 24     ; 
;------------------------------------------------
LOAD            CLR     MFF5A                    ; F7B9: 7F FF 5A  ; 
                BRA     ZF7C6                    ; F7BC: 20 08     ; 
;------------------------------------------------
VERIFY          LDAA    #$01                     ; F7BE: 86 01     ; 
                STAA    MFF5A                    ; F7C0: B7 FF 5A  ; 
                CLR     MFF61                    ; F7C3: 7F FF 61  ; 
ZF7C6           LDX     #SGLCONT                 ; F7C6: CE FB 89  ; 
                JSR     XPDATA1                  ; F7C9: BD FA 14  ; 
                JSR     ZFA2C                    ; F7CC: BD FA 2C  ; 
                STAA    MFF58                    ; F7CF: B7 FF 58  ; 
                CMPA    #'S'                      ; F7D2: 81 53    ; 
                BEQ     ZF7DD                    ; F7D4: 27 07     ; 
                CMPA    #'C'                      ; F7D6: 81 43    ; 
                BNE     ZF7C6                    ; F7D8: 26 EC     ; 
                JSR     XPCRLF1                  ; F7DA: BD FA 21  ; 
ZF7DD           JSR     ZF8A1                    ; F7DD: BD F8 A1  ; 
                LDAA    MFF8C                    ; F7E0: B6 FF 8C  ; 
                CMPA    #'0'                      ; F7E3: 81 30    ; 
                BNE     ZF81A                    ; F7E5: 26 33     ; 
                LDAA    MFF8D                    ; F7E7: B6 FF 8D  ; 
                LDX     #MFF8D                   ; F7EA: CE FF 8D  ; 
ZF7ED           INX                              ; F7ED: 08        ; 
                DECA                             ; F7EE: 4A        ; 
                BNE     ZF7ED                    ; F7EF: 26 FC     ; 
                LDAA    #$04                     ; F7F1: 86 04     ; 
                STAA    ,X                       ; F7F3: A7 00     ; 
                LDX     #MFF90                   ; F7F5: CE FF 90  ; 
                JSR     XPDATA1                  ; F7F8: BD FA 14  ; 
                JSR     ZF918                    ; F7FB: BD F9 18  ; 
                TST     MFF5A                    ; F7FE: 7D FF 5A  ; 
                BPL     ZF7DD                    ; F801: 2A DA     ; 
ZF803           LDX     #CONTLDVERF              ; F803: CE FB 4E  ; 
                JSR     XPDATA1                  ; F806: BD FA 14  ; 
                JSR     ZFA2C                    ; F809: BD FA 2C  ; 
                CMPA    #'C'                      ; F80C: 81 43    ; 
                BEQ     ZF7DD                    ; F80E: 27 CD     ; 
                CMPA    #'L'                      ; F810: 81 4C    ; 
                BEQ     LOAD                     ; F812: 27 A5     ; 
                CMPA    #'V'                      ; F814: 81 56    ; 
                BEQ     VERIFY                   ; F816: 27 A6     ; 
                BRA     ZF803                    ; F818: 20 E9     ; 
;------------------------------------------------
ZF81A           TST     MFF5A                    ; F81A: 7D FF 5A  ; 
                BMI     ZF7DD                    ; F81D: 2B BE     ; 
                JSR     ZF918                    ; F81F: BD F9 18  ; 
                LDAA    MFF8C                    ; F822: B6 FF 8C  ; 
                CMPA    #'1'                      ; F825: 81 31    ; 
                BEQ     ZF836                    ; F827: 27 0D     ; 
                CMPA    #'9'                      ; F829: 81 39    ; 
                BNE     ZF7DD                    ; F82B: 26 B0     ; 
                LDAA    MFF58                    ; F82D: B6 FF 58  ; 
                CMPA    #'C'                      ; F830: 81 43    ; 
                BEQ     ZF7DD                    ; F832: 27 A9     ; 
                BRA     ZF89E                    ; F834: 20 68     ; 
;------------------------------------------------
ZF836           LDAA    MFF8D                    ; F836: B6 FF 8D  ; 
                SUBA    #$03                     ; F839: 80 03     ; 
                STAA    MFF8D                    ; F83B: B7 FF 8D  ; 
                LDX     #MFF90                   ; F83E: CE FF 90  ; 
                STX     MFF08                    ; F841: FF FF 08  ; 
                LDX     MFF8E                    ; F844: FE FF 8E  ; 
ZF847           STX     MFF56                    ; F847: FF FF 56  ; 
                LDX     MFF08                    ; F84A: FE FF 08  ; 
                LDAA    ,X                       ; F84D: A6 00     ; 
                INX                              ; F84F: 08        ; 
                STX     MFF08                    ; F850: FF FF 08  ; 
                LDX     MFF56                    ; F853: FE FF 56  ; 
                TST     MFF5A                    ; F856: 7D FF 5A  ; 
                BEQ     ZF892                    ; F859: 27 37     ; 
                CMPA    ,X                       ; F85B: A1 00     ; 
                BEQ     ZF889                    ; F85D: 27 2A     ; 
                PSHA                             ; F85F: 36        ; 
                STX     MFF56                    ; F860: FF FF 56  ; 
                TST     MFF61                    ; F863: 7D FF 61  ; 
                BNE     ZF872                    ; F866: 26 0A     ; 
                SEC                              ; F868: 0D        ; 
                ROL     MFF61                    ; F869: 79 FF 61  ; 
                LDX     #ADRMEMTAP               ; F86C: CE FB 6F  ; 
                JSR     XPDATA1                  ; F86F: BD FA 14  ; 
ZF872           LDX     #MFF56                   ; F872: CE FF 56  ; 
                JSR     XPCRLF1                  ; F875: BD FA 21  ; 
                JSR     XOUT4H1                  ; F878: BD F9 C7  ; 
                LDX     MFF56                    ; F87B: FE FF 56  ; 
                JSR     XOUT2H1                  ; F87E: BD F9 C9  ; 
                TSX                              ; F881: 30        ; 
                JSR     XOUT2H1                  ; F882: BD F9 C9  ; 
                PULA                             ; F885: 32        ; 
                LDX     MFF56                    ; F886: FE FF 56  ; 
ZF889           INX                              ; F889: 08        ; 
                DEC     MFF8D                    ; F88A: 7A FF 8D  ; 
                BNE     ZF847                    ; F88D: 26 B8     ; 
                JMP     ZF7DD                    ; F88F: 7E F7 DD  ; 
;------------------------------------------------
ZF892           STAA    ,X                       ; F892: A7 00     ; 
                CMPA    ,X                       ; F894: A1 00     ; 
                BEQ     ZF889                    ; F896: 27 F1     ; 
                LDX     #NOCHNGE                 ; F898: CE FB 5E  ; 
                JSR     XPDATA1                  ; F89B: BD FA 14  ; 
ZF89E           JMP     REENT3                   ; F89E: 7E F5 C2  ; 
;------------------------------------------------
ZF8A1           CLR     MFF8C                    ; F8A1: 7F FF 8C  ; 
                TST     MFF02                    ; F8A4: 7D FF 02  ; 
                BPL     ZF8B3                    ; F8A7: 2A 0A     ; 
ZF8A9           JSR     PRNTDLE                  ; F8A9: BD F6 22  ; 
                LDAA    #$37                     ; F8AC: 86 37     ; 
                JSR     OUTCNSF                  ; F8AE: BD F9 CF  ; output A to serial
                BRA     ZF8C0                    ; F8B1: 20 0D     ; 
;------------------------------------------------
ZF8B3           LDAA    PROM_1                   ; F8B3: B6 FC FD  ; 
                ANDA    #$5F                     ; F8B6: 84 5F     ; 
                STAA    ACIA_0                   ; F8B8: B7 FC F4  ; 
                LDAA    #$11                     ; F8BB: 86 11     ; 
                JSR     XOUTCH1                  ; F8BD: BD F9 E2  ; 
ZF8C0           SEC                              ; F8C0: 0D        ; 
                ROL     AECHO                    ; F8C1: 79 FF 53  ; 
                JSR     XINCHN1                  ; F8C4: BD FA 7F  ; Get ASCII from Port
                CMPA    #$0D                     ; F8C7: 81 0D     ; 
                BNE     ZF8D0                    ; F8C9: 26 05     ; 
                TST     MFF02                    ; F8CB: 7D FF 02  ; 
                BMI     ZF8A9                    ; F8CE: 2B D9     ; 
ZF8D0           CMPA    #'S'                      ; F8D0: 81 53    ; 
                BNE     ZF8C0                    ; F8D2: 26 EC     ; 
                LDX     #MFF8D                   ; F8D4: CE FF 8D  ; 
ZF8D7           SEC                              ; F8D7: 0D        ; 
                ROL     AECHO                    ; F8D8: 79 FF 53  ; 
                JSR     XINCHN1                  ; F8DB: BD FA 7F  ; Get ASCII from Port
                CMPA    #$7F                     ; F8DE: 81 7F     ; 
                BEQ     ZF8D7                    ; F8E0: 27 F5     ; 
                CMPA    #'0'                      ; F8E2: 81 30    ; 
                BEQ     ZF8EE                    ; F8E4: 27 08     ; 
                CMPA    #'1'                      ; F8E6: 81 31    ; 
                BEQ     ZF8EE                    ; F8E8: 27 04     ; 
                CMPA    #'9'                      ; F8EA: 81 39    ; 
                BNE     ZF8C0                    ; F8EC: 26 D2     ; 
ZF8EE           STAA    MFF8C                    ; F8EE: B7 FF 8C  ; 
                CLR     MFF8B                    ; F8F1: 7F FF 8B  ; 
                BSR     ZF948                    ; F8F4: 8D 52     ; 
                STAA    MFF07                    ; F8F6: B7 FF 07  ; 
ZF8F9           BSR     ZF948                    ; F8F9: 8D 4D     ; 
                DEC     MFF07                    ; F8FB: 7A FF 07  ; 
                BNE     ZF8F9                    ; F8FE: 26 F9     ; 
                INC     MFF8B                    ; F900: 7C FF 8B  ; 
                LDAA    PROM_1                   ; F903: B6 FC FD  ; 
                ANDA    #$3F                     ; F906: 84 3F     ; 
                STAA    ACIA_0                   ; F908: B7 FC F4  ; 
                LDX     #MFBBC                   ; F90B: CE FB BC  ; 
                JSR     XPDAT1                   ; F90E: BD FA 16  ; 
                LDAA    ACIA_1                   ; F911: B6 FC F5  ; 
                LDAA    ACIA_1                   ; F914: B6 FC F5  ; 
                RTS                              ; F917: 39        ; 
;------------------------------------------------
ZF918           TST     MFF8B                    ; F918: 7D FF 8B  ; 
                BEQ     ZF93B                    ; F91B: 27 1E     ; 
ZF91D           LDX     #CHECKSM                 ; F91D: CE FB 69  ; 
                JSR     XPDATA1                  ; F920: BD FA 14  ; 
                LDX     #MFF8E                   ; F923: CE FF 8E  ; 
                JSR     XOUT4H1                  ; F926: BD F9 C7  ; 
                JSR     ZFA2C                    ; F929: BD FA 2C  ; 
                CMPA    #$52                     ; F92C: 81 52     ; 
                BNE     ZF935                    ; F92E: 26 05     ; 
                INS                              ; F930: 31        ; 
                INS                              ; F931: 31        ; 
                JMP     ZF7DD                    ; F932: 7E F7 DD  ; 
;------------------------------------------------
ZF935           CMPA    #$43                     ; F935: 81 43     ; 
                BNE     ZF91D                    ; F937: 26 E4     ; 
                LDAA    #$FF                     ; F939: 86 FF     ; 
ZF93B           RTS                              ; F93B: 39        ; 
;------------------------------------------------
ZF93C           SEC                              ; F93C: 0D        ; 
                ROL     AECHO                    ; F93D: 79 FF 53  ; 
                JSR     ZFA84                    ; F940: BD FA 84  ; 
                CMPA    #$7F                     ; F943: 81 7F     ; 
                BEQ     ZF93C                    ; F945: 27 F5     ; 
                RTS                              ; F947: 39        ; 
;------------------------------------------------
ZF948           BSR     ZF93C                    ; F948: 8D F2     ; 
                ASLA                             ; F94A: 48        ; 
                ASLA                             ; F94B: 48        ; 
                ASLA                             ; F94C: 48        ; 
                ASLA                             ; F94D: 48        ; 
                TAB                              ; F94E: 16        ; 
                BSR     ZF93C                    ; F94F: 8D EB     ; 
                ABA                              ; F951: 1B        ; 
                STAA    ,X                       ; F952: A7 00     ; 
                ADDA    MFF8B                    ; F954: BB FF 8B  ; 
                STAA    MFF8B                    ; F957: B7 FF 8B  ; 
                CPX     #MFFD5                   ; F95A: 8C FF D5  ; 
                BEQ     ZF960                    ; F95D: 27 01     ; 
                INX                              ; F95F: 08        ; 
ZF960           RTS                              ; F960: 39        ; 
;------------------------------------------------
ZF961           STX     MFF56                    ; F961: FF FF 56  ; 
                BSR     XOUT4H1                  ; F964: 8D 61     ; 
                LDAA    #$04                     ; F966: 86 04     ; 
                BRA     ZF971                    ; F968: 20 07     ; 
;------------------------------------------------
ZF96A           STX     MFF56                    ; F96A: FF FF 56  ; 
                BSR     XOUT2H1                  ; F96D: 8D 5A     ; 
                LDAA    #$02                     ; F96F: 86 02     ; 
ZF971           STAA    MFF5C                    ; F971: B7 FF 5C  ; 
                JSR     ZFA40                    ; F974: BD FA 40  ; 
                LDX     MFF56                    ; F977: FE FF 56  ; 
                JSR     ZFA2E                    ; F97A: BD FA 2E  ; 
                BNE     ZF9B5                    ; F97D: 26 36     ; 
                TSTB                             ; F97F: 5D        ; 
                BEQ     ZF9AF                    ; F980: 27 2D     ; 
                CMPB    MFF5C                    ; F982: F1 FF 5C  ; 
                BHI     ZF9B5                    ; F985: 22 2E     ; 
                CMPB    MFF07                    ; F987: F1 FF 07  ; 
                BHI     ZF9B5                    ; F98A: 22 29     ; 
                LDAB    MFF5C                    ; F98C: F6 FF 5C  ; 
                CMPB    #$02                     ; F98F: C1 02     ; 
                BEQ     ZF9A6                    ; F991: 27 13     ; 
                LDAB    MFF08                    ; F993: F6 FF 08  ; 
                STAB    ,X                       ; F996: E7 00     ; 
                CMPB    ,X                       ; F998: E1 00     ; 
                BEQ     ZF9A5                    ; F99A: 27 09     ; 
ZF99C           LDX     #NOCHNGE                 ; F99C: CE FB 5E  ; 
                JSR     XPDATA1                  ; F99F: BD FA 14  ; 
                JMP     MAIDs                    ; F9A2: 7E F0 F3  ; 
;------------------------------------------------
ZF9A5           INX                              ; F9A5: 08        ; 
ZF9A6           LDAB    MFF09                    ; F9A6: F6 FF 09  ; 
                STAB    ,X                       ; F9A9: E7 00     ; 
                CMPB    ,X                       ; F9AB: E1 00     ; 
                BNE     ZF99C                    ; F9AD: 26 ED     ; 
ZF9AF           CLRB                             ; F9AF: 5F        ; 
                LDX     MFF56                    ; F9B0: FE FF 56  ; 
                TSTB                             ; F9B3: 5D        ; 
                RTS                              ; F9B4: 39        ; 
;------------------------------------------------
ZF9B5           LDAB    #$FF                     ; F9B5: C6 FF     ; 
                RTS                              ; F9B7: 39        ; 
;------------------------------------------------
XCHEXL1         LSRA                             ; F9B8: 44        ; convert high nibble
                LSRA                             ; F9B9: 44        ; 
                LSRA                             ; F9BA: 44        ; 
                LSRA                             ; F9BB: 44        ; 
XCHEXR1         ANDA    #$0F                     ; F9BC: 84 0F     ; mask lower nibble and convert
                ADDA    #'0'                     ; F9BE: 8B 30     ; convert to ASCII
                CMPA    #'9'                     ; F9C0: 81 39     ; is it above '9'
                BLS     ZF9C6                    ; F9C2: 23 02     ; no - exit
                ADDA    #$07                     ; F9C4: 8B 07     ; yes, add 7 to get to 'A'
ZF9C6           RTS                              ; F9C6: 39        ; 
;------------------------------------------------
XOUT4H1         BSR     OUTHX2                   ; F9C7: 8D 3E     ; Output high byte (INX)
XOUT2H1         BSR     OUTHX2                   ; F9C9: 8D 3C     ; Output low byte
XPSPAC1         LDAA    #$20                     ; F9CB: 86 20     ; |
                BRA     XOUTCH1                  ; F9CD: 20 13     ; Output Space
;------------------------------------------------
OUTCNSF         PSHB                             ; F9CF: 37        ; 
ZF9D0           LDAB    ACIA_0                   ; F9D0: F6 FC F4  ; Load Status
                BITB    #$02                     ; F9D3: C5 02     ; Check Transmit Ready
                BEQ     ZF9D0                    ; F9D5: 27 F9     ; if not, wait
                STAA    ACIA_1                   ; F9D7: B7 FC F5  ; Output Character
                PULB                             ; F9DA: 33        ; 
                RTS                              ; F9DB: 39        ; 
;------------------------------------------------
ZF9DC           BSR     OUTHX2                   ; F9DC: 8D 29     ; Output high byte (INX)
                BSR     OUTHX2                   ; F9DE: 8D 27     ; Output low byte 
                LDAA    #'/'                     ; F9E0: 86 2F     ; Load '/'
XOUTCH1         BSR     OUTCNSF                  ; F9E2: 8D EB     ; output A to serial
                PSHB                             ; F9E4: 37        ; 
                CMPA    #$0D                     ; F9E5: 81 0D     ; check for CR
                BNE     ZF9FD                    ; F9E7: 26 14     ; 
                LDAB    #$04                     ; F9E9: C6 04     ; 
                TST     MFF62                    ; F9EB: 7D FF 62  ; 
                BNE     ZF9F3                    ; F9EE: 26 03     ; 
                LDAB    MFFF7                    ; F9F0: F6 FF F7  ; 
ZF9F3           DECB                             ; F9F3: 5A        ; 
                BMI     ZFA05                    ; F9F4: 2B 0F     ; 
                PSHA                             ; F9F6: 36        ; 
                CLRA                             ; F9F7: 4F        ; write NULL
                BSR     OUTCNSF                  ; F9F8: 8D D5     ; output A to serial
                PULA                             ; F9FA: 32        ; 
                BRA     ZF9F3                    ; F9FB: 20 F6     ; 
;------------------------------------------------
ZF9FD           LDAB    MFFF6                    ; F9FD: F6 FF F6  ; 
                TST     MFF62                    ; FA00: 7D FF 62  ; 
                BEQ     ZF9F3                    ; FA03: 27 EE     ; 
ZFA05           PULB                             ; FA05: 33        ; 
                RTS                              ; FA06: 39        ; 
;------------------------------------------------
OUTHX2          LDAA    ,X                       ; FA07: A6 00     ; Load from X
                BSR     XCHEXL1                  ; FA09: 8D AD     ; convert high nibble
                BSR     XOUTCH1                  ; FA0B: 8D D5     ; output
                LDAA    ,X                       ; FA0D: A6 00     ; Load again
                BSR     XCHEXR1                  ; FA0F: 8D AB     ; convert low nibble
                INX                              ; FA11: 08        ; increment X for next call!
                BRA     XOUTCH1                  ; FA12: 20 CE     ; output
;------------------------------------------------
XPDATA1         BSR     XPCRLF1                  ; FA14: 8D 0B     ; output LF and CR
XPDAT1          LDAA    ,X                       ; FA16: A6 00     ; load char
                CMPA    #$04                     ; FA18: 81 04     ; String terminator
                BEQ     ZFA3F                    ; FA1A: 27 23     ; RTS
                BSR     XOUTCH1                  ; FA1C: 8D C4     ; else, output characters
                INX                              ; FA1E: 08        ; next char
                BRA     XPDAT1                   ; FA1F: 20 F5     ; continue
;------------------------------------------------
XPCRLF1         LDAA    #$0A                     ; FA21: 86 0A     ; LF
                BSR     XOUTCH1                  ; FA23: 8D BD     ; Output
OUTCR           LDAA    #$0D                     ; FA25: 86 0D     ; CR
                BSR     XOUTCH1                  ; FA27: 8D B9     ; Output
                CLRA                             ; FA29: 4F        ; NULL
XOUTCH2         BRA     XOUTCH1                  ; FA2A: 20 B6     ; Output
;------------------------------------------------
ZFA2C           BSR     XINCHN1                  ; FA2C: 8D 51     ; Get ASCII from Port
ZFA2E           CMPA    #'X'                     ; FA2E: 81 58     ; is it 'X'
                BNE     ZFA35                    ; FA30: 26 03     ; no
                JMP     REENT3                   ; FA32: 7E F5 C2  ; Got 'X' - restart

ZFA35           CMPA    #'^'                     ; FA35: 81 5E     ; not 'X', is it '^'?
                BEQ     ZFA3F                    ; FA37: 27 06     ; yes, done
                CMPA    #$0D                     ; FA39: 81 0D     ; ignore CR and LF
                BEQ     ZFA3F                    ; FA3B: 27 02     ; |
                CMPA    #$0A                     ; FA3D: 81 0A     ; |
ZFA3F           RTS                              ; FA3F: 39        ; |
;------------------------------------------------
ZFA40           LDX     #MFF08                   ; FA40: CE FF 08  ; 
XINADD1         CLR     MFF07                    ; FA43: 7F FF 07  ; 
                CLR     ,X                       ; FA46: 6F 00     ; 
                CLR     $01,X                    ; FA48: 6F 01     ; 
ZFA4A           BSR     ZFA84                    ; FA4A: 8D 38     ; 
                BMI     ZFA67                    ; FA4C: 2B 19     ; 
                LDAB    #$04                     ; FA4E: C6 04     ; 
ZFA50           ASL     $01,X                    ; FA50: 68 01     ; 
                ROL     ,X                       ; FA52: 69 00     ; 
                DECB                             ; FA54: 5A        ; 
                BNE     ZFA50                    ; FA55: 26 F9     ; 
                PSHA                             ; FA57: 36        ; 
                ORAA    $01,X                    ; FA58: AA 01     ; 
                STAA    $01,X                    ; FA5A: A7 01     ; 
                PULA                             ; FA5C: 32        ; 
                INC     MFF07                    ; FA5D: 7C FF 07  ; 
                LDAB    MFF07                    ; FA60: F6 FF 07  ; 
                CMPB    #$05                     ; FA63: C1 05     ; 
                BNE     ZFA4A                    ; FA65: 26 E3     ; 
ZFA67           LDAB    MFF07                    ; FA67: F6 FF 07  ; 
                RTS                              ; FA6A: 39        ; 
;------------------------------------------------
XINCH1          LDAA    ACIA_0                   ; FA6B: B6 FC F4  ; Load Status
                ASRA                             ; FA6E: 47        ; 
                BCC     XINCH1                   ; FA6F: 24 FA     ; Wait
                LDAA    ACIA_1                   ; FA71: B6 FC F5  ; Load Data
                TST     AECHO                    ; FA74: 7D FF 53  ; Echo it?
                BNE     ZFA7B                    ; FA77: 26 02     ; No
                BRA     XOUTCH2                  ; FA79: 20 AF     ; Output if ECHO is on

ZFA7B           CLR     AECHO                    ; FA7B: 7F FF 53  ; 
                RTS                              ; FA7E: 39        ; 
;------------------------------------------------
XINCHN1         BSR     XINCH1                   ; FA7F: 8D EA     ; Get actual character from serial port
                ANDA    #$7F                     ; FA81: 84 7F     ; only first 127 ASCII characters
                RTS                              ; FA83: 39        ; 
;------------------------------------------------
ZFA84           BSR     XINCHN1                  ; FA84: 8D F9     ; Get ASCII from port
XCBCDH1         CMPA    #'0'                     ; FA86: 81 30     ; 
                BMI     BCDERR                   ; FA88: 2B 11     ; below '0'
                CMPA    #'9'                     ; FA8A: 81 39     ; 
                BLE     ZFA98                    ; FA8C: 2F 0A     ; 
                CMPA    #'A'                     ; FA8E: 81 41     ; 
                BMI     BCDERR                   ; FA90: 2B 09     ; below 'A'
                CMPA    #'F'                     ; FA92: 81 46     ; 
                BGT     BCDERR                   ; FA94: 2E 05     ; above 'F'
                SUBA    #$07                     ; FA96: 80 07     ; 
ZFA98           ANDA    #$0F                     ; FA98: 84 0F     ; 
                RTS                              ; FA9A: 39        ; 
;------------------------------------------------
BCDERR          TST     $FAE5                    ; FA9B: 7D FA E5  ; WHY?
                RTS                              ; FA9E: 39        ; 
;------------------------------------------------
ZFA9F           BSR     XOUTCH2                  ; FA9F: 8D 89     ; 
                LDAA    #$2D                     ; FAA1: 86 2D     ; 
                BRA     XOUTCH2                  ; FAA3: 20 85     ; 
;------------------------------------------------
ZFAA5           JSR     XPCRLF1                  ; FAA5: BD FA 21  ; 
ZFAA8           LDX     #XREGsP                  ; FAA8: CE FF 16  ; 
                LDAA    #'P'                      ; FAAB: 86 50    ; 
                BSR     ZFAC8                    ; FAAD: 8D 19     ; 
                LDAA    #'X'                      ; FAAF: 86 58    ; 
                BSR     ZFAC8                    ; FAB1: 8D 15     ; 
                LDAA    #'A'                      ; FAB3: 86 41    ; 
                BSR     ZFAC3                    ; FAB5: 8D 0C     ; 
                LDAA    #'B'                      ; FAB7: 86 42    ; 
                BSR     ZFAC3                    ; FAB9: 8D 08     ; 
                LDAA    #'C'                      ; FABB: 86 43    ; 
                BSR     ZFAC3                    ; FABD: 8D 04     ; 
                LDAA    #'S'                      ; FABF: 86 53    ; 
                BRA     ZFAC8                    ; FAC1: 20 05     ; 
;------------------------------------------------
ZFAC3           BSR     ZFA9F                    ; FAC3: 8D DA     ; 
                JMP     XOUT2H1                  ; FAC5: 7E F9 C9  ; 
;------------------------------------------------
ZFAC8           BSR     ZFA9F                    ; FAC8: 8D D5     ; 
                JMP     XOUT4H1                  ; FACA: 7E F9 C7  ; 
;------------------------------------------------
S10             CLRA                             ; FACD: 4F        ; 
                LDX     #M0000                   ; FACE: CE 00 00  ; 
ZFAD1           STAA    MFF02                    ; FAD1: B7 FF 02  ; 
                STX     MFFF6                    ; FAD4: FF FF F6  ; 
                JMP     REENT3                   ; FAD7: 7E F5 C2  ; 
;------------------------------------------------
S30             LDAA    #$01                     ; FADA: 86 01     ; 
                LDX     #M0004                   ; FADC: CE 00 04  ; 
                BRA     ZFAD1                    ; FADF: 20 F0     ; 
;------------------------------------------------
S120            LDX     #M0317                   ; FAE1: CE 03 17  ; 
ZFAE4           LDAA    #$FF                     ; FAE4: 86 FF     ; 
                BRA     ZFAD1                    ; FAE6: 20 E9     ; 
;------------------------------------------------
S240            LDX     #M072F                   ; FAE8: CE 07 2F  ; 
                BRA     ZFAE4                    ; FAEB: 20 F7     ; 
;------------------------------------------------
XBUGCMD         FCC     'LOAD'                   ; FAED: 4C 4F 41 44    
                FDB     LOAD                     ; FAF1: F7 B9          
                FCC     'VERF'                   ; FAF3: 56 45 52 46    
                FDB     VERIFY                   ; FAF7: F7 BE          
                FCC     'SRCH'                   ; FAF9: 53 52 43 48    
                FDB     SEARCH                   ; FAFD: F7 B2          
                FCC     'PRNT'                   ; FAFF: 50 52 4E 54    
                FDB     PUNCH                    ; FB03: F7 1A          
                FCC     'PNCH'                   ; FB05: 50 4E 43 48    
                FDB     PUNCH                    ; FB09: F7 1A          
                FCC     'MAID'                   ; FB0B: 4D 41 49 44    
                FDB     MAID                     ; FB0F: F0 ED          
                FCC     'S10.'                   ; FB11: 53 31 30 2E    
                FDB     S10                      ; FB15: FA CD          
                FCC     'S30.'                   ; FB17: 53 33 30 2E    
                FDB     S30                      ; FB1B: FA DA          
                FCC     'S120'                   ; FB1D: 53 31 32 30    
                FDB     S120                     ; FB21: FA E1          
                FCC     'S240'                   ; FB23: 53 32 34 30    
                FDB     S240                     ; FB27: FA E8          
                FCC     'TERM'                   ; FB29: 54 45 52 4D    
                FDB     TERM                     ; FB2D: F6 27          
GREETING        FCC     'EXBUG 1.2 '             ; FB2F: 45 58 42 55 47 20 31 2E 32 20
                FCB     $04                      ; FB39: 04             
BEGINADDR       FCC     'BEG ADDR '              ; FB3A: 42 45 47 20 41 44 44 52 20
                FCB     $04                      ; FB43: 04             
ENDADDR         FCC     'END ADDR '              ; FB44: 45 4E 44 20 41 44 44 52 20
                FCB     $04                      ; FB4D: 04             
CONTLDVERF      FCC     'CONT/LOAD/VERF '        ; FB4E: 43 4F 4E 54 2F 4C 4F 41 44 2F 56 45 52 46 20
                FCB     $04                      ; FB5D: 04             
NOCHNGE         FCC     'NO CHANGE'              ; FB5E: 4E 4F 20 43 48 41 4E 47 45
                FCB     $07,$04                  ; FB67: 07 04          
CHECKSM         FCC     'CKSM '                  ; FB69: 43 4B 53 4D 20 
                FCB     $04                      ; FB6E: 04             
ADRMEMTAP       FCC     'ADDR/MEM/TAPE'          ; FB6F: 41 44 44 52 2F 4D 45 4D 2F 54 41 50 45
                FCB     $04                      ; FB7C: 04             
INVALID         FCC     ' INVL'                  ; FB7D: 20 49 4E 56 4C 
                FCB     $04                      ; FB82: 04             
EXEC            FCC     'EXEC '                  ; FB83: 45 58 45 43 20 
                FCB     $04                      ; FB88: 04             
SGLCONT         FCC     'SGL/CONT '              ; FB89: 53 47 4C 2F 43 4F 4E 54 20
                FCB     $04                      ; FB92: 04             
STOPONADDR      FCC     'STOP-ON-ADDRESS '       ; FB93: 53 54 4F 50 2D 4F 4E 2D 41 44 44 52 45 53 53 20 
                FCB     $04                      ; FBA3: 04             
STOPADDR        FCC     'STOP ADDR '             ; FBA4: 53 54 4F 50 20 41 44 44 52 20
                FCB     $04                      ; FBAE: 04             
ABORTED         FCC     'ABORTED '               ; FBAF: 41 42 4F 52 54 45 44 20 
                FCC     'AT '                    ; FBB7: 41 54 20       
                FCB     $04                      ; FBBA: 04             
MFBBB           FCB     $14                      ; FBBB: 14             
MFBBC           FCB     $13,$00,$00,$00,$00,$04  ; FBBC: 13 00 00 00 00 04 
MFBC2           FCB     $07                      ; FBC2: 07             
                FCC     ' ?'                     ; FBC3: 20 3F          
                FCB     $04                      ; FBC5: 04             
STAR1           FCB     '*'                      ; FBC6: 2A             
                FCB     $04                      ; FBC7: 04             
BKPTERR         FCC     'BKPT ERROR '            ; FBC8: 42 4B 50 54 20 45 52 52 4F 52 20 
                FCB     $04                      ; FBD3: 04             
S1_TXT          FCB     $0d,$0a,$00              ; FBD4: 0D 0A 00       
                FCC     'S1'                     ; FBD7: 53 31          
                FCB     $04                      ; FBD9: 04             
S9_TXT          FCB     $0d,$0a,$00              ; FBDA: 0D 0A 00       
                FCC     'S9030000'               ; FBDD: 53 39 30 33 30 30 30 30 
                FCC     'FC'                     ; FBE5: 46 43          
                FCB     $0d,$04                  ; FBE7: 0D 04          
S0_TXT          FCB     $0d,$0a,$00              ; FBE9: 0D 0A 00       
                FCC     'S00B0000'               ; FBEC: 53 30 30 42 30 30 30 30 
                FCC     '5820'                   ; FBF4: 35 38 32 30    
                FCB     $04                      ; FBF8: 04             
HD_TXT          FCC     'HD'                     ; FBF9: 48 44          
RTNUSR          FCC     'R=X '                   ; FBFB: 52 3D 58 20    
                FCB     $04                      ; FBFF: 04             


                END
