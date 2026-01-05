dasmfw: Disassembler Framework V0.35
Loaded: binary file "exbug11.bin"
Loaded: Info file "exbug11.info"

;****************************************************
; Used Labels
;****************************************************

M0000   EQU     $0000
Z1FFD   EQU     $1FFD
M83FF   EQU     $83FF
OSLOAD  EQU     $E800
ACIA_0  EQU     $FCF4
ACIA_1  EQU     $FCF5
PIA_0   EQU     $FCF8
PIA_1   EQU     $FCF9
PIA_2   EQU     $FCFA
PIA_3   EQU     $FCFB
PROM_1  EQU     $FCFD
RAMBGN  EQU     $FF00
MFF02   EQU     $FF02
MFF03   EQU     $FF03
MFF04   EQU     $FF04
MFF05   EQU     $FF05
MFF06   EQU     $FF06
MFF07   EQU     $FF07
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
IRQsVC  EQU     $FFF8
SWIsVC  EQU     $FFFA
NMIsVC  EQU     $FFFC
MFFFE   EQU     $FFFE

;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $F000

PWRUP           JMP     PWRUP1                   ; F000: 7E F5 58       
XBEGEN          JMP     XBEGEN1                  ; F003: 7E F7 89       
XCBCDH          JMP     XCBCDH1                  ; F006: 7E FA A7       
XCHEXL          JMP     XCHEXL1                  ; F009: 7E F9 C0       
XCHEXR          JMP     XCHEXR1                  ; F00C: 7E F9 C4       
XINADD          JMP     XINADD1                  ; F00F: 7E FA 65       
XINCH           JMP     XINCH1                   ; F012: 7E FA 8B       
XINCHN          JMP     XINCHN1                  ; F015: 7E FA A0       
XOUTCH          JMP     XOUTCH1                  ; F018: 7E F9 DC       
XOUT2H          JMP     XOUT2H1                  ; F01B: 7E FA 24       
XOUT4H          JMP     XOUT4H1                  ; F01E: 7E FA 22       
XPCRLF          JMP     XPCRLF1                  ; F021: 7E FA 41       
XPDATA          JMP     XPDATA1                  ; F024: 7E FA 33       
XPDAT           JMP     XPDAT1                   ; F027: 7E FA 35       
XPSPAC          JMP     XPSPAC1                  ; F02A: 7E FA 26       
MF02D           BEQ     ZF03F                    ; F02D: 27 10          
                FCB     $03                      ; F02F: 03             
                EORB    ,X                       ; F030: E8 00          
                LSR     ,X                       ; F032: 64 00          
                CLV                              ; F034: 0A             
                FCB     $00                      ; F035: 00             
                NOP                              ; F036: 01             
ZF037           JSR     XCBCDH1                  ; F037: BD FA A7       
                BMI     ZF0A8                    ; F03A: 2B 6C          
                ASL     $01,X                    ; F03C: 68 01          
                ROL     ,X                       ; F03E: 69 00          
                BSR     ZF07E                    ; F040: 8D 3C          
                ADDA    $01,X                    ; F042: AB 01          
                STAA    $01,X                    ; F044: A7 01          
ZF046           JSR     XINCHN1                  ; F046: BD FA A0       
                CMPA    #'=                      ; F049: 81 3D          
                BNE     ZF037                    ; F04B: 26 EA          
                LDAA    #$20                     ; F04D: 86 20          
                JSR     XOUTCH1                  ; F04F: BD F9 DC       
                LDX     #MF02D                   ; F052: CE F0 2D       
                LDAA    MFF08                    ; F055: B6 FF 08       
                LDAB    MFF09                    ; F058: F6 FF 09       
ZF05B           CLR     MFF5A                    ; F05B: 7F FF 5A       
ZF05E           INC     MFF5A                    ; F05E: 7C FF 5A       
                SUBB    $01,X                    ; F061: E0 01          
                SBCA    ,X                       ; F063: A2 00          
                BCC     ZF05E                    ; F065: 24 F7          
                ADDB    $01,X                    ; F067: EB 01          
                ADCA    ,X                       ; F069: A9 00          
                PSHA                             ; F06B: 36             
                LDAA    MFF5A                    ; F06C: B6 FF 5A       
                ADDA    #$2F                     ; F06F: 8B 2F          
                JSR     XOUTCH1                  ; F071: BD F9 DC       
                PULA                             ; F074: 32             
                INX                              ; F075: 08             
                INX                              ; F076: 08             
                CPX     #ZF037                   ; F077: 8C F0 37       
                BNE     ZF05B                    ; F07A: 26 DF          
                BRA     ZF0F9                    ; F07C: 20 7B          
ZF07E           ASL     $01,X                    ; F07E: 68 01          
                ROL     ,X                       ; F080: 69 00          
                ASL     $01,X                    ; F082: 68 01          
                ROL     ,X                       ; F084: 69 00          
                ASL     $01,X                    ; F086: 68 01          
                ROL     ,X                       ; F088: 69 00          
                RTS                              ; F08A: 39             
ZF08B           LDX     #MFF08                   ; F08B: CE FF 08       
                CLR     MFF07                    ; F08E: 7F FF 07       
                CLR     ,X                       ; F091: 6F 00          
                CLR     $01,X                    ; F093: 6F 01          
                JSR     XINCHN1                  ; F095: BD FA A0       
                CMPA    #$24                     ; F098: 81 24          
                BEQ     ZF046                    ; F09A: 27 AA          
                CMPA    #$40                     ; F09C: 81 40          
                BEQ     ZF0EA                    ; F09E: 27 4A          
ZF0A0           CMPA    #$30                     ; F0A0: 81 30          
                BMI     ZF0A8                    ; F0A2: 2B 04          
                CMPA    #$39                     ; F0A4: 81 39          
                BLE     ZF0AB                    ; F0A6: 2F 03          
ZF0A8           JMP     ZF128                    ; F0A8: 7E F1 28       
ZF0AB           ANDA    #$0F                     ; F0AB: 84 0F          
                STAA    MFF5A                    ; F0AD: B7 FF 5A       
                LDAA    ,X                       ; F0B0: A6 00          
                LDAB    $01,X                    ; F0B2: E6 01          
                ASLD                             ; F0B4: 58 49          
                JSR     ZF07E                    ; F0B6: BD F0 7E       
                ADDB    $01,X                    ; F0B9: EB 01          
                ADCA    ,X                       ; F0BB: A9 00          
                ADDB    MFF5A                    ; F0BD: FB FF 5A       
                ADCA    #$00                     ; F0C0: 89 00          
                STAA    ,X                       ; F0C2: A7 00          
                STAB    $01,X                    ; F0C4: E7 01          
                JSR     XINCHN1                  ; F0C6: BD FA A0       
                CMPA    #$3D                     ; F0C9: 81 3D          
                BNE     ZF0A0                    ; F0CB: 26 D3          
ZF0CD           LDAA    #$20                     ; F0CD: 86 20          
                JSR     XOUTCH1                  ; F0CF: BD F9 DC       
                LDX     #MFF08                   ; F0D2: CE FF 08       
                JSR     XOUT4H1                  ; F0D5: BD FA 22       
                BRA     ZF0F9                    ; F0D8: 20 1F          
ZF0DA           CMPA    #$30                     ; F0DA: 81 30          
                BMI     ZF0A8                    ; F0DC: 2B CA          
                CMPA    #$38                     ; F0DE: 81 38          
                BPL     ZF0A8                    ; F0E0: 2A C6          
                BSR     ZF07E                    ; F0E2: 8D 9A          
                ANDA    #$07                     ; F0E4: 84 07          
                ADDA    $01,X                    ; F0E6: AB 01          
                STAA    $01,X                    ; F0E8: A7 01          
ZF0EA           JSR     XINCHN1                  ; F0EA: BD FA A0       
                CMPA    #$3D                     ; F0ED: 81 3D          
                BNE     ZF0DA                    ; F0EF: 26 E9          
                BRA     ZF0CD                    ; F0F1: 20 DA          
MAID            CLR     MFF60                    ; F0F3: 7F FF 60       
                CLR     MFF54                    ; F0F6: 7F FF 54       
ZF0F9           LDS     #XSTAKs                  ; F0F9: 8E FF 8A       
                LDX     #MFBC2                   ; F0FC: CE FB C2       
                JSR     XPDATA1                  ; F0FF: BD FA 33       
                JSR     ZFA62                    ; F102: BD FA 62       
                TSTB                             ; F105: 5D             
                BNE     ZF130                    ; F106: 26 28          
                CMPA    #$58                     ; F108: 81 58          
                BNE     ZF10F                    ; F10A: 26 03          
                JMP     ZF5DC                    ; F10C: 7E F5 DC       
ZF10F           CMPA    #$24                     ; F10F: 81 24          
                BNE     ZF116                    ; F111: 26 03          
                JMP     ZF33D                    ; F113: 7E F3 3D       
ZF116           CMPA    #$3B                     ; F116: 81 3B          
                BNE     ZF11D                    ; F118: 26 03          
                JMP     ZF27F                    ; F11A: 7E F2 7F       
ZF11D           CMPA    #$4E                     ; F11D: 81 4E          
                BEQ     ZF155                    ; F11F: 27 34          
                CMPA    #$23                     ; F121: 81 23          
                BNE     ZF128                    ; F123: 26 03          
                JMP     ZF08B                    ; F125: 7E F0 8B       
ZF128           LDX     #MFBBE                   ; F128: CE FB BE       
                JSR     XPDAT1                   ; F12B: BD FA 35       
ZF12E           BRA     ZF0F9                    ; F12E: 20 C9          
ZF130           CMPA    #$3B                     ; F130: 81 3B          
                BEQ     ZF1A3                    ; F132: 27 6F          
                LDX     MFF08                    ; F134: FE FF 08       
                CMPA    #$2F                     ; F137: 81 2F          
                BNE     ZF128                    ; F139: 26 ED          
                JMP     ZF1D6                    ; F13B: 7E F1 D6       
ZF13E           LDX     MFF08                    ; F13E: FE FF 08       
                BEQ     ZF144                    ; F141: 27 01          
                DEX                              ; F143: 09             
ZF144           STX     MFF51                    ; F144: FF FF 51       
                LDAA    #$FF                     ; F147: 86 FF          
                STAA    MFF60                    ; F149: B7 FF 60       
                STAA    MFF50                    ; F14C: B7 FF 50       
                STAA    MFF54                    ; F14F: B7 FF 54       
                JMP     ZF431                    ; F152: 7E F4 31       
ZF155           LDX     #M0000                   ; F155: CE 00 00       
                BRA     ZF144                    ; F158: 20 EA          
ZF15A           LDAA    MFF08                    ; F15A: B6 FF 08       
                LDAB    MFF09                    ; F15D: F6 FF 09       
                JSR     ZF2BA                    ; F160: BD F2 BA       
                BEQ     ZF0F9                    ; F163: 27 94          
                LDX     #BRKPTs                  ; F165: CE FF 1F       
ZF168           LDAA    ,X                       ; F168: A6 00          
                ADDA    $01,X                    ; F16A: AB 01          
                BNE     ZF179                    ; F16C: 26 0B          
                LDS     MFF08                    ; F16E: BE FF 08       
                STS     ,X                       ; F171: AF 00          
                CLR     $20,X                    ; F173: 6F 20          
                CLR     $21,X                    ; F175: 6F 21          
                BRA     ZF12E                    ; F177: 20 B5          
ZF179           INX                              ; F179: 08             
                INX                              ; F17A: 08             
                CPX     #MFF2F                   ; F17B: 8C FF 2F       
                BNE     ZF168                    ; F17E: 26 E8          
ZF180           JMP     ZF128                    ; F180: 7E F1 28       
ZF183           LDX     #BRKPTs                  ; F183: CE FF 1F       
ZF186           LDAA    ,X                       ; F186: A6 00          
                CMPA    MFF08                    ; F188: B1 FF 08       
                BNE     ZF19A                    ; F18B: 26 0D          
                LDAA    $01,X                    ; F18D: A6 01          
                CMPA    MFF09                    ; F18F: B1 FF 09       
                BNE     ZF19A                    ; F192: 26 06          
                CLR     ,X                       ; F194: 6F 00          
                CLR     $01,X                    ; F196: 6F 01          
ZF198           BRA     ZF12E                    ; F198: 20 94          
ZF19A           INX                              ; F19A: 08             
                INX                              ; F19B: 08             
                CPX     #MFF2F                   ; F19C: 8C FF 2F       
                BNE     ZF186                    ; F19F: 26 E5          
                BRA     ZF180                    ; F1A1: 20 DD          
ZF1A3           JSR     XINCHN1                  ; F1A3: BD FA A0       
                CMPA    #'G                      ; F1A6: 81 47          
                BNE     ZF1AD                    ; F1A8: 26 03          
                JMP     ZF41C                    ; F1AA: 7E F4 1C       
ZF1AD           CMPA    #'N                      ; F1AD: 81 4E          
                BEQ     ZF13E                    ; F1AF: 27 8D          
                CMPA    #'P                      ; F1B1: 81 50          
                BNE     ZF1B8                    ; F1B3: 26 03          
                JMP     ZF3FC                    ; F1B5: 7E F3 FC       
ZF1B8           CMPA    #$55                     ; F1B8: 81 55          
                BEQ     ZF183                    ; F1BA: 27 C7          
                CMPA    #$56                     ; F1BC: 81 56          
                BEQ     ZF15A                    ; F1BE: 27 9A          
                CMPA    #$57                     ; F1C0: 81 57          
                BNE     ZF180                    ; F1C2: 26 BC          
                BRA     ZF23D                    ; F1C4: 20 77          
ZF1C6           INX                              ; F1C6: 08             
                JSR     ZFA45                    ; F1C7: BD FA 45       
ZF1CA           STX     MFF56                    ; F1CA: FF FF 56       
ZF1CD           LDX     #MFF56                   ; F1CD: CE FF 56       
                JSR     ZFA2B                    ; F1D0: BD FA 2B       
                LDX     MFF56                    ; F1D3: FE FF 56       
ZF1D6           JSR     ZF971                    ; F1D6: BD F9 71       
                BMI     ZF1E9                    ; F1D9: 2B 0E          
                CMPA    #$0D                     ; F1DB: 81 0D          
                BEQ     ZF198                    ; F1DD: 27 B9          
                CMPA    #$0A                     ; F1DF: 81 0A          
                BEQ     ZF1C6                    ; F1E1: 27 E3          
                DEX                              ; F1E3: 09             
                JSR     XPCRLF1                  ; F1E4: BD FA 41       
                BRA     ZF1CA                    ; F1E7: 20 E1          
ZF1E9           CMPA    #$3B                     ; F1E9: 81 3B          
                BNE     ZF180                    ; F1EB: 26 93          
                JSR     XINCHN1                  ; F1ED: BD FA A0       
                CMPA    #$4F                     ; F1F0: 81 4F          
                BNE     ZF180                    ; F1F2: 26 8C          
                LDX     MFF56                    ; F1F4: FE FF 56       
                INX                              ; F1F7: 08             
                STX     MFF5A                    ; F1F8: FF FF 5A       
                LDAA    MFF5A                    ; F1FB: B6 FF 5A       
                LDAB    MFF5B                    ; F1FE: F6 FF 5B       
                SUBB    MFF09                    ; F201: F0 FF 09       
                SBCA    MFF08                    ; F204: B2 FF 08       
                BCS     ZF229                    ; F207: 25 20          
                BNE     ZF221                    ; F209: 26 16          
                CMPB    #$81                     ; F20B: C1 81          
                BCC     ZF221                    ; F20D: 24 12          
                NEGB                             ; F20F: 50             
ZF210           STAB    MFF07                    ; F210: F7 FF 07       
                JSR     XPSPAC1                  ; F213: BD FA 26       
                LDX     #MFF07                   ; F216: CE FF 07       
                JSR     XOUT2H1                  ; F219: BD FA 24       
ZF21C           JSR     XPCRLF1                  ; F21C: BD FA 41       
                BRA     ZF1CD                    ; F21F: 20 AC          
ZF221           LDX     #INVALID                 ; F221: CE FB 79       
                JSR     XPDAT1                   ; F224: BD FA 35       
                BRA     ZF21C                    ; F227: 20 F3          
ZF229           LDAA    MFF08                    ; F229: B6 FF 08       
                LDAB    MFF09                    ; F22C: F6 FF 09       
                SUBB    MFF5B                    ; F22F: F0 FF 5B       
                SBCA    MFF5A                    ; F232: B2 FF 5A       
                BNE     ZF221                    ; F235: 26 EA          
                ASLB                             ; F237: 58             
                BCS     ZF221                    ; F238: 25 E7          
                LSRB                             ; F23A: 54             
                BRA     ZF210                    ; F23B: 20 D3          
ZF23D           LDAA    MFF08                    ; F23D: B6 FF 08       
                BNE     ZF2A3                    ; F240: 26 61          
                LDAA    MFF09                    ; F242: B6 FF 09       
                STAA    MFF13                    ; F245: B7 FF 13       
                LDX     MFF0E                    ; F248: FE FF 0E       
ZF24B           STX     MFF56                    ; F24B: FF FF 56       
                LDAA    ,X                       ; F24E: A6 00          
                EORA    MFF13                    ; F250: B8 FF 13       
                ANDA    MFF12                    ; F253: B4 FF 12       
                BNE     ZF267                    ; F256: 26 0F          
                JSR     XPCRLF1                  ; F258: BD FA 41       
                LDX     #MFF56                   ; F25B: CE FF 56       
                JSR     XOUT4H1                  ; F25E: BD FA 22       
                LDX     MFF56                    ; F261: FE FF 56       
                JSR     XOUT2H1                  ; F264: BD FA 24       
ZF267           LDX     MFF56                    ; F267: FE FF 56       
                CPX     MFF10                    ; F26A: BC FF 10       
                BEQ     ZF2B1                    ; F26D: 27 42          
                INX                              ; F26F: 08             
                BRA     ZF24B                    ; F270: 20 D9          
ZF272           CLR     MFF60                    ; F272: 7F FF 60       
                CLR     MFF54                    ; F275: 7F FF 54       
                BRA     ZF2B1                    ; F278: 20 37          
ZF27A           CLR     MFF5D                    ; F27A: 7F FF 5D       
                BRA     ZF2B1                    ; F27D: 20 32          
ZF27F           JSR     XINCHN1                  ; F27F: BD FA A0       
                CMPA    #$47                     ; F282: 81 47          
                BNE     ZF289                    ; F284: 26 03          
                JMP     ZF414                    ; F286: 7E F4 14       
ZF289           CMPA    #$4E                     ; F289: 81 4E          
                BNE     ZF290                    ; F28B: 26 03          
                JMP     ZF155                    ; F28D: 7E F1 55       
ZF290           CMPA    #'P                      ; F290: 81 50          
                BNE     ZF297                    ; F292: 26 03          
                JMP     ZF3F0                    ; F294: 7E F3 F0       
ZF297           CMPA    #$53                     ; F297: 81 53          
                BEQ     ZF27A                    ; F299: 27 DF          
                CMPA    #$54                     ; F29B: 81 54          
                BEQ     ZF272                    ; F29D: 27 D3          
                CMPA    #$55                     ; F29F: 81 55          
                BEQ     ZF2A6                    ; F2A1: 27 03          
ZF2A3           JMP     ZF128                    ; F2A3: 7E F1 28       
ZF2A6           LDX     #BRKPTs                  ; F2A6: CE FF 1F       
ZF2A9           CLR     ,X                       ; F2A9: 6F 00          
                INX                              ; F2AB: 08             
                CPX     #BKPINs                  ; F2AC: 8C FF 4F       
                BNE     ZF2A9                    ; F2AF: 26 F8          
ZF2B1           JMP     ZF0F9                    ; F2B1: 7E F0 F9       
ZF2B4           LDAA    XREGsP                   ; F2B4: B6 FF 16       
                LDAB    MFF17                    ; F2B7: F6 FF 17       
ZF2BA           LDX     #BRKPTs                  ; F2BA: CE FF 1F       
ZF2BD           CMPA    ,X                       ; F2BD: A1 00          
                BNE     ZF2C6                    ; F2BF: 26 05          
                CMPB    $01,X                    ; F2C1: E1 01          
                BNE     ZF2C6                    ; F2C3: 26 01          
                RTS                              ; F2C5: 39             
ZF2C6           INX                              ; F2C6: 08             
                INX                              ; F2C7: 08             
                CPX     #MFF2F                   ; F2C8: 8C FF 2F       
                BNE     ZF2BD                    ; F2CB: 26 F0          
                LDAA    #$FF                     ; F2CD: 86 FF          
                RTS                              ; F2CF: 39             
ZF2D0           JSR     ZFAC0                    ; F2D0: BD FA C0       
                JSR     ZF964                    ; F2D3: BD F9 64       
                INX                              ; F2D6: 08             
                BRA     ZF2DF                    ; F2D7: 20 06          
ZF2D9           JSR     ZFAC0                    ; F2D9: BD FA C0       
                JSR     ZF971                    ; F2DC: BD F9 71       
ZF2DF           CMPA    #$0D                     ; F2DF: 81 0D          
                BEQ     ZF33A                    ; F2E1: 27 57          
                INX                              ; F2E3: 08             
                CMPA    #$0A                     ; F2E4: 81 0A          
                BEQ     ZF2EC                    ; F2E6: 27 04          
                JSR     XPCRLF1                  ; F2E8: BD FA 41       
                RTS                              ; F2EB: 39             
ZF2EC           JSR     ZFA45                    ; F2EC: BD FA 45       
                RTS                              ; F2EF: 39             
ZF2F0           JSR     ZFAC9                    ; F2F0: BD FA C9       
                JSR     XPCRLF1                  ; F2F3: BD FA 41       
                LDX     #XREGsP                  ; F2F6: CE FF 16       
                LDAA    #$50                     ; F2F9: 86 50          
                BSR     ZF2D0                    ; F2FB: 8D D3          
                LDAA    #$58                     ; F2FD: 86 58          
                BSR     ZF2D0                    ; F2FF: 8D CF          
                LDAA    #$41                     ; F301: 86 41          
                BSR     ZF2D9                    ; F303: 8D D4          
                LDAA    #$42                     ; F305: 86 42          
                BSR     ZF2D9                    ; F307: 8D D0          
                LDAA    #$43                     ; F309: 86 43          
                BSR     ZF2D9                    ; F30B: 8D CC          
                LDAA    #$53                     ; F30D: 86 53          
                BSR     ZF2D0                    ; F30F: 8D BF          
                BRA     ZF33A                    ; F311: 20 27          
ZF313           JSR     XPSPAC1                  ; F313: BD FA 26       
                LDX     #MFF12                   ; F316: CE FF 12       
                JSR     ZF971                    ; F319: BD F9 71       
                BMI     ZF355                    ; F31C: 2B 37          
ZF31E           LDX     #BEGINADDR               ; F31E: CE FB 36       
                JSR     XPDATA1                  ; F321: BD FA 33       
                LDX     #MFF0E                   ; F324: CE FF 0E       
                JSR     ZF964                    ; F327: BD F9 64       
                BMI     ZF31E                    ; F32A: 2B F2          
ZF32C           LDX     #ENDADDR                 ; F32C: CE FB 40       
                JSR     XPDATA1                  ; F32F: BD FA 33       
                LDX     #MFF10                   ; F332: CE FF 10       
                JSR     ZF964                    ; F335: BD F9 64       
                BMI     ZF32C                    ; F338: 2B F2          
ZF33A           JMP     ZF0F9                    ; F33A: 7E F0 F9       
ZF33D           JSR     XINCHN1                  ; F33D: BD FA A0       
                TAB                              ; F340: 16             
                CMPB    #$52                     ; F341: C1 52          
                BEQ     ZF2F0                    ; F343: 27 AB          
                CMPB    #$56                     ; F345: C1 56          
                BEQ     ZF358                    ; F347: 27 0F          
                CMPB    #$4D                     ; F349: C1 4D          
                BEQ     ZF313                    ; F34B: 27 C6          
                CMPB    #$54                     ; F34D: C1 54          
                BEQ     ZF37D                    ; F34F: 27 2C          
                CMPB    #$53                     ; F351: C1 53          
                BEQ     ZF368                    ; F353: 27 13          
ZF355           JMP     ZF128                    ; F355: 7E F1 28       
ZF358           JSR     XPCRLF1                  ; F358: BD FA 41       
                LDX     #BRKPTs                  ; F35B: CE FF 1F       
                LDAB    #$08                     ; F35E: C6 08          
ZF360           JSR     XOUT4H1                  ; F360: BD FA 22       
                DECB                             ; F363: 5A             
                BNE     ZF360                    ; F364: 26 FA          
                BRA     ZF33A                    ; F366: 20 D2          
ZF368           LDX     #STOPADDR                ; F368: CE FB A0       
                JSR     XPDATA1                  ; F36B: BD FA 33       
                LDX     #MFF5E                   ; F36E: CE FF 5E       
                JSR     ZF964                    ; F371: BD F9 64       
                BMI     ZF355                    ; F374: 2B DF          
                LDAA    #$FF                     ; F376: 86 FF          
                STAA    MFF5D                    ; F378: B7 FF 5D       
                BRA     ZF33A                    ; F37B: 20 BD          
ZF37D           LDX     #ENDADDR                 ; F37D: CE FB 40       
                JSR     XPDATA1                  ; F380: BD FA 33       
                LDX     #MFF14                   ; F383: CE FF 14       
                JSR     ZF964                    ; F386: BD F9 64       
                BMI     ZF355                    ; F389: 2B CA          
                LDAA    #$FF                     ; F38B: 86 FF          
                STAA    MFF60                    ; F38D: B7 FF 60       
                CLR     MFF50                    ; F390: 7F FF 50       
                BRA     ZF33A                    ; F393: 20 A5          
ZF395           TST     BKPINs                   ; F395: 7D FF 4F       
                BNE     ZF3C8                    ; F398: 26 2E          
                LDX     #BRKPTs                  ; F39A: CE FF 1F       
ZF39D           STX     MFF56                    ; F39D: FF FF 56       
                LDAA    ,X                       ; F3A0: A6 00          
                BNE     ZF3A8                    ; F3A2: 26 04          
                LDAA    $01,X                    ; F3A4: A6 01          
                BEQ     ZF3BC                    ; F3A6: 27 14          
ZF3A8           LDX     ,X                       ; F3A8: EE 00          
                LDAA    ,X                       ; F3AA: A6 00          
                LDAB    #$3F                     ; F3AC: C6 3F          
                STAB    ,X                       ; F3AE: E7 00          
                CMPB    ,X                       ; F3B0: E1 00          
                BEQ     ZF3B7                    ; F3B2: 27 03          
                JMP     ZF9A4                    ; F3B4: 7E F9 A4       
ZF3B7           LDX     MFF56                    ; F3B7: FE FF 56       
                STAA    $10,X                    ; F3BA: A7 10          
ZF3BC           INX                              ; F3BC: 08             
                INX                              ; F3BD: 08             
                CPX     #MFF2F                   ; F3BE: 8C FF 2F       
                BNE     ZF39D                    ; F3C1: 26 DA          
                LDAA    #$FF                     ; F3C3: 86 FF          
                STAA    BKPINs                   ; F3C5: B7 FF 4F       
ZF3C8           RTS                              ; F3C8: 39             
ZF3C9           TST     BKPINs                   ; F3C9: 7D FF 4F       
                BEQ     ZF3EC                    ; F3CC: 27 1E          
                LDX     #BRKPTs                  ; F3CE: CE FF 1F       
ZF3D1           STX     MFF56                    ; F3D1: FF FF 56       
                LDAA    ,X                       ; F3D4: A6 00          
                BNE     ZF3DC                    ; F3D6: 26 04          
                LDAB    $01,X                    ; F3D8: E6 01          
                BEQ     ZF3E2                    ; F3DA: 27 06          
ZF3DC           LDAA    $10,X                    ; F3DC: A6 10          
                LDX     ,X                       ; F3DE: EE 00          
                STAA    ,X                       ; F3E0: A7 00          
ZF3E2           LDX     MFF56                    ; F3E2: FE FF 56       
                INX                              ; F3E5: 08             
                INX                              ; F3E6: 08             
                CPX     #MFF2F                   ; F3E7: 8C FF 2F       
                BNE     ZF3D1                    ; F3EA: 26 E5          
ZF3EC           CLR     BKPINs                   ; F3EC: 7F FF 4F       
                RTS                              ; F3EF: 39             
ZF3F0           TST     MFF60                    ; F3F0: 7D FF 60       
                BNE     ZF42C                    ; F3F3: 26 37          
                JSR     ZF2B4                    ; F3F5: BD F2 B4       
                BEQ     ZF42C                    ; F3F8: 27 32          
                BRA     ZF427                    ; F3FA: 20 2B          
ZF3FC           TST     MFF60                    ; F3FC: 7D FF 60       
                BNE     ZF406                    ; F3FF: 26 05          
                JSR     ZF2B4                    ; F401: BD F2 B4       
                BEQ     ZF409                    ; F404: 27 03          
ZF406           JMP     ZF128                    ; F406: 7E F1 28       
ZF409           LDS     MFF08                    ; F409: BE FF 08       
                DES                              ; F40C: 34             
                STS     $20,X                    ; F40D: AF 20          
                LDS     #XSTAKs                  ; F40F: 8E FF 8A       
                BRA     ZF42C                    ; F412: 20 18          
ZF414           LDX     RAMBGN                   ; F414: FE FF 00       
                DEX                              ; F417: 09             
                LDX     ,X                       ; F418: EE 00          
                BRA     ZF41F                    ; F41A: 20 03          
ZF41C           LDX     MFF08                    ; F41C: FE FF 08       
ZF41F           STX     XREGsP                   ; F41F: FF FF 16       
                TST     MFF60                    ; F422: 7D FF 60       
                BMI     ZF42C                    ; F425: 2B 05          
ZF427           JSR     ZF395                    ; F427: BD F3 95       
                BRA     ZF431                    ; F42A: 20 05          
ZF42C           LDAA    #$FF                     ; F42C: 86 FF          
                STAA    MFF54                    ; F42E: B7 FF 54       
ZF431           LDAB    #$07                     ; F431: C6 07          
                LDS     XREGsS                   ; F433: BE FF 1D       
                LDX     #XREGsP                  ; F436: CE FF 16       
ZF439           LDAA    ,X                       ; F439: A6 00          
                PSHA                             ; F43B: 36             
                INX                              ; F43C: 08             
                DECB                             ; F43D: 5A             
                BNE     ZF439                    ; F43E: 26 F9          
                TSX                              ; F440: 30             
                LDAA    $03,X                    ; F441: A6 03          
                LDAB    $04,X                    ; F443: E6 04          
                STAA    $04,X                    ; F445: A7 04          
                STAB    $03,X                    ; F447: E7 03          
                LDAA    $05,X                    ; F449: A6 05          
                LDAB    $06,X                    ; F44B: E6 06          
                STAA    $06,X                    ; F44D: A7 06          
                STAB    $05,X                    ; F44F: E7 05          
                TST     MFF5D                    ; F451: 7D FF 5D       
                BEQ     ZF467                    ; F454: 27 11          
                LDAA    MFF5F                    ; F456: B6 FF 5F       
                STAA    PIA_0                    ; F459: B7 FC F8       
                LDAA    MFF5E                    ; F45C: B6 FF 5E       
                STAA    PIA_2                    ; F45F: B7 FC FA       
                LDAA    #$34                     ; F462: 86 34          
                STAA    PIA_1                    ; F464: B7 FC F9       
ZF467           TST     MFF54                    ; F467: 7D FF 54       
                BEQ     ZF476                    ; F46A: 27 0A          
                LDAA    #$34                     ; F46C: 86 34          
                STAA    PIA_3                    ; F46E: B7 FC FB       
                LDAA    #$3C                     ; F471: 86 3C          
                STAA    PIA_3                    ; F473: B7 FC FB       
ZF476           RTI                              ; F476: 3B             
MF477           LDAB    #$07                     ; F477: C6 07          
                LDX     #XREGsC                  ; F479: CE FF 1C       
ZF47C           PULA                             ; F47C: 32             
                STAA    ,X                       ; F47D: A7 00          
                DEX                              ; F47F: 09             
                DECB                             ; F480: 5A             
                BNE     ZF47C                    ; F481: 26 F9          
                STS     XREGsS                   ; F483: BF FF 1D       
                LDS     #XSTAKs                  ; F486: 8E FF 8A       
                BSR     ZF4BF                    ; F489: 8D 34          
                LDX     XREGsP                   ; F48B: FE FF 16       
                DEX                              ; F48E: 09             
                STX     XREGsP                   ; F48F: FF FF 16       
                TST     BKPINs                   ; F492: 7D FF 4F       
                BEQ     ZF4AB                    ; F495: 27 14          
                JSR     ZF3C9                    ; F497: BD F3 C9       
                JSR     ZF2B4                    ; F49A: BD F2 B4       
                BNE     ZF4AB                    ; F49D: 26 0C          
                LDS     $20,X                    ; F49F: AE 20          
                BEQ     ZF4B7                    ; F4A1: 27 14          
                DES                              ; F4A3: 34             
                STS     $20,X                    ; F4A4: AF 20          
                LDS     #XSTAKs                  ; F4A6: 8E FF 8A       
                BRA     ZF42C                    ; F4A9: 20 81          
ZF4AB           LDX     #BKPTERR                 ; F4AB: CE FB C4       
                JSR     XPDATA1                  ; F4AE: BD FA 33       
                CLR     MFF60                    ; F4B1: 7F FF 60       
                CLR     MFF54                    ; F4B4: 7F FF 54       
ZF4B7           LDS     #XSTAKs                  ; F4B7: 8E FF 8A       
                JSR     ZFAC9                    ; F4BA: BD FA C9       
                BRA     ZF536                    ; F4BD: 20 77          
ZF4BF           LDX     #XREGsP                  ; F4BF: CE FF 16       
                LDAA    ,X                       ; F4C2: A6 00          
                LDAB    $01,X                    ; F4C4: E6 01          
                STAA    $01,X                    ; F4C6: A7 01          
                STAB    ,X                       ; F4C8: E7 00          
                LDAA    $02,X                    ; F4CA: A6 02          
                LDAB    $03,X                    ; F4CC: E6 03          
                STAA    $03,X                    ; F4CE: A7 03          
                STAB    $02,X                    ; F4D0: E7 02          
                RTS                              ; F4D2: 39             
                STS     XREGsS                   ; F4D3: BF FF 1D       
ZF4D6           BRA     ZF4D6                    ; F4D6: 20 FE          
MF4D8           LDAA    #$3C                     ; F4D8: 86 3C          
                STAA    PIA_1                    ; F4DA: B7 FC F9       
                LDAA    #$34                     ; F4DD: 86 34          
                STAA    PIA_3                    ; F4DF: B7 FC FB       
                LDAB    #$07                     ; F4E2: C6 07          
                LDX     #XREGsC                  ; F4E4: CE FF 1C       
ZF4E7           PULA                             ; F4E7: 32             
                STAA    ,X                       ; F4E8: A7 00          
                DEX                              ; F4EA: 09             
                DECB                             ; F4EB: 5A             
                BNE     ZF4E7                    ; F4EC: 26 F9          
                STS     XREGsS                   ; F4EE: BF FF 1D       
                LDS     #XSTAKs                  ; F4F1: 8E FF 8A       
                BSR     ZF4BF                    ; F4F4: 8D C9          
                JSR     ZF3C9                    ; F4F6: BD F3 C9       
                LDAA    PIA_1                    ; F4F9: B6 FC F9       
                LDAB    PIA_0                    ; F4FC: F6 FC F8       
                BITA    #$80                     ; F4FF: 85 80          
                BNE     ZF54D                    ; F501: 26 4A          
                LDAA    PIA_3                    ; F503: B6 FC FB       
                LDAB    PIA_2                    ; F506: F6 FC FA       
                BITA    #$80                     ; F509: 85 80          
                BNE     ZF539                    ; F50B: 26 2C          
                TST     MFF60                    ; F50D: 7D FF 60       
                BEQ     ZF544                    ; F510: 27 32          
                JSR     ZFAC9                    ; F512: BD FA C9       
                TST     MFF50                    ; F515: 7D FF 50       
                BEQ     ZF525                    ; F518: 27 0B          
                LDX     MFF51                    ; F51A: FE FF 51       
                BEQ     ZF52D                    ; F51D: 27 0E          
                DEX                              ; F51F: 09             
                STX     MFF51                    ; F520: FF FF 51       
                BRA     ZF54A                    ; F523: 20 25          
ZF525           LDX     XREGsP                   ; F525: FE FF 16       
                CPX     MFF14                    ; F528: BC FF 14       
                BNE     ZF54A                    ; F52B: 26 1D          
ZF52D           CLR     MFF60                    ; F52D: 7F FF 60       
                CLR     MFF50                    ; F530: 7F FF 50       
                CLR     MFF54                    ; F533: 7F FF 54       
ZF536           JMP     ZF0F9                    ; F536: 7E F0 F9       
ZF539           LDX     #STOPONADDR              ; F539: CE FB 8F       
                JSR     XPDATA1                  ; F53C: BD FA 33       
                JSR     ZFACC                    ; F53F: BD FA CC       
                BRA     ZF536                    ; F542: 20 F2          
ZF544           JSR     ZF395                    ; F544: BD F3 95       
                CLR     MFF54                    ; F547: 7F FF 54       
ZF54A           JMP     ZF431                    ; F54A: 7E F4 31       
ZF54D           LDX     #ABORTED                 ; F54D: CE FB AB       
                JSR     XPDATA1                  ; F550: BD FA 33       
                JSR     ZFACC                    ; F553: BD FA CC       
                BRA     ZF567                    ; F556: 20 0F          
PWRUP1          SEI                              ; F558: 0F             
                LDX     #M83FF                   ; F559: CE 83 FF       
                STX     RAMBGN                   ; F55C: FF FF 00       
                LDAA    #$00                     ; F55F: 86 00          
                STAA    MFF02                    ; F561: B7 FF 02       
                LDS     #XSTAKs                  ; F564: 8E FF 8A       
ZF567           STS     XREGsS                   ; F567: BF FF 1D       
                LDX     #MF4D8                   ; F56A: CE F4 D8       
                STX     NMIsVC                   ; F56D: FF FF FC       
                LDX     #MF4D8                   ; F570: CE F4 D8       
                STX     MFFFE                    ; F573: FF FF FE       
                LDX     #MF477                   ; F576: CE F4 77       
                STX     SWIsVC                   ; F579: FF FF FA       
                LDX     RAMBGN                   ; F57C: FE FF 00       
                DEX                              ; F57F: 09             
                DEX                              ; F580: 09             
                DEX                              ; F581: 09             
                DEX                              ; F582: 09             
                DEX                              ; F583: 09             
                DEX                              ; F584: 09             
                DEX                              ; F585: 09             
                LDX     ,X                       ; F586: EE 00          
                STX     IRQsVC                   ; F588: FF FF F8       
                LDX     #BRKPTs                  ; F58B: CE FF 1F       
ZF58E           CLR     ,X                       ; F58E: 6F 00          
                INX                              ; F590: 08             
                CPX     #MFF63                   ; F591: 8C FF 63       
                BNE     ZF58E                    ; F594: 26 F8          
                LDS     #XSTAKs                  ; F596: 8E FF 8A       
                LDAA    #$38                     ; F599: 86 38          
                STAA    PIA_1                    ; F59B: B7 FC F9       
                LDAA    #$30                     ; F59E: 86 30          
                STAA    PIA_3                    ; F5A0: B7 FC FB       
                LDAA    #$FF                     ; F5A3: 86 FF          
                STAA    PIA_0                    ; F5A5: B7 FC F8       
                STAA    PIA_2                    ; F5A8: B7 FC FA       
                LDAA    #$34                     ; F5AB: 86 34          
                STAA    PIA_3                    ; F5AD: B7 FC FB       
                LDAA    #$3C                     ; F5B0: 86 3C          
                STAA    PIA_1                    ; F5B2: B7 FC F9       
                LDAA    #$03                     ; F5B5: 86 03          
                STAA    ACIA_0                   ; F5B7: B7 FC F4       
                LDAA    PROM_1                   ; F5BA: B6 FC FD       
                ANDA    #$35                     ; F5BD: 84 35          
                STAA    ACIA_0                   ; F5BF: B7 FC F4       
                LDAA    #$10                     ; F5C2: 86 10          
                JSR     OUTCNSF                  ; F5C4: BD F9 CF       
                LDAA    #$3A                     ; F5C7: 86 3A          
                JSR     OUTCNSF                  ; F5C9: BD F9 CF       
                LDAA    #$10                     ; F5CC: 86 10          
                JSR     OUTCNSF                  ; F5CE: BD F9 CF       
                LDAA    #$39                     ; F5D1: 86 39          
                JSR     OUTCNSF                  ; F5D3: BD F9 CF       
                LDX     #MFBB7                   ; F5D6: CE FB B7       
                JSR     XPDAT1                   ; F5D9: BD FA 35       
ZF5DC           LDX     #GREETING                ; F5DC: CE FB 2B       
                JSR     XPDATA1                  ; F5DF: BD FA 33       
                LDAA    ACIA_1                   ; F5E2: B6 FC F5       
                LDX     #MFF03                   ; F5E5: CE FF 03       
ZF5E8           JSR     ZFA4E                    ; F5E8: BD FA 4E       
                STAA    ,X                       ; F5EB: A7 00          
                INX                              ; F5ED: 08             
                CPX     #MFF07                   ; F5EE: 8C FF 07       
                BNE     ZF5E8                    ; F5F1: 26 F5          
                LDX     #MFAF5                   ; F5F3: CE FA F5       
ZF5F6           LDAA    MFF03                    ; F5F6: B6 FF 03       
                CMPA    ,X                       ; F5F9: A1 00          
                BNE     ZF616                    ; F5FB: 26 19          
                LDAA    MFF04                    ; F5FD: B6 FF 04       
                CMPA    $01,X                    ; F600: A1 01          
                BNE     ZF616                    ; F602: 26 12          
                LDAA    MFF05                    ; F604: B6 FF 05       
                CMPA    $02,X                    ; F607: A1 02          
                BNE     ZF616                    ; F609: 26 0B          
                LDAA    MFF06                    ; F60B: B6 FF 06       
                CMPA    $03,X                    ; F60E: A1 03          
                BNE     ZF616                    ; F610: 26 04          
                LDX     $04,X                    ; F612: EE 04          
                JMP     ,X                       ; F614: 6E 00          
ZF616           INX                              ; F616: 08             
                INX                              ; F617: 08             
                INX                              ; F618: 08             
                INX                              ; F619: 08             
                INX                              ; F61A: 08             
                INX                              ; F61B: 08             
                CPX     #GREETING                ; F61C: 8C FB 2B       
                BNE     ZF5F6                    ; F61F: 26 D5          
                BRA     ZF5DC                    ; F621: 20 B9          
S10             CLRA                             ; F623: 4F             
                BRA     ZF628                    ; F624: 20 02          
S30             LDAA    #$01                     ; F626: 86 01          
ZF628           STAA    MFF02                    ; F628: B7 FF 02       
                BRA     ZF5DC                    ; F62B: 20 AF          
S120            LDAA    #$FF                     ; F62D: 86 FF          
                BRA     ZF628                    ; F62F: 20 F7          
ZF631           LDX     #HD_TXT                  ; F631: CE FB F5       
                JSR     XPDATA1                  ; F634: BD FA 33       
                LDX     #MFF8D                   ; F637: CE FF 8D       
ZF63A           JSR     XINCHN1                  ; F63A: BD FA A0       
                CMPA    #$20                     ; F63D: 81 20          
                BLT     ZF645                    ; F63F: 2D 04          
                CMPA    #$61                     ; F641: 81 61          
                BLT     ZF647                    ; F643: 2D 02          
ZF645           LDAA    #$20                     ; F645: 86 20          
ZF647           STAA    ,X                       ; F647: A7 00          
                INX                              ; F649: 08             
                CPX     #MFF93                   ; F64A: 8C FF 93       
                BNE     ZF63A                    ; F64D: 26 EB          
                JSR     ZF70B                    ; F64F: BD F7 0B       
                SEC                              ; F652: 0D             
                ROL     MFF62                    ; F653: 79 FF 62       
                TST     MFF02                    ; F656: 7D FF 02       
                BPL     ZF665                    ; F659: 2A 0A          
                LDAA    #$10                     ; F65B: 86 10          
                JSR     XOUTCH1                  ; F65D: BD F9 DC       
                LDAA    #$30                     ; F660: 86 30          
                JSR     XOUTCH1                  ; F662: BD F9 DC       
ZF665           LDAA    #$12                     ; F665: 86 12          
                JSR     XOUTCH1                  ; F667: BD F9 DC       
                JSR     ZF700                    ; F66A: BD F7 00       
                LDAB    #$83                     ; F66D: C6 83          
                LDX     #S0_TXT                  ; F66F: CE FB E5       
                JSR     XPDAT1                   ; F672: BD FA 35       
                LDX     #MFF8D                   ; F675: CE FF 8D       
ZF678           JSR     ZF6FA                    ; F678: BD F6 FA       
                CPX     #MFF93                   ; F67B: 8C FF 93       
                BNE     ZF678                    ; F67E: 26 F8          
                COMB                             ; F680: 53             
                PSHB                             ; F681: 37             
                TSX                              ; F682: 30             
                BSR     ZF6FA                    ; F683: 8D 75          
                PULB                             ; F685: 33             
                LDX     MFF0A                    ; F686: FE FF 0A       
                STX     MFF5A                    ; F689: FF FF 5A       
ZF68C           LDAA    MFF0D                    ; F68C: B6 FF 0D       
                SUBA    MFF5B                    ; F68F: B0 FF 5B       
                LDAB    MFF0C                    ; F692: F6 FF 0C       
                SBCB    MFF5A                    ; F695: F2 FF 5A       
                BNE     ZF69E                    ; F698: 26 04          
                CMPA    #$10                     ; F69A: 81 10          
                BCS     ZF6A0                    ; F69C: 25 02          
ZF69E           LDAA    #$0F                     ; F69E: 86 0F          
ZF6A0           ADDA    #$04                     ; F6A0: 8B 04          
                STAA    MFF58                    ; F6A2: B7 FF 58       
                SUBA    #$03                     ; F6A5: 80 03          
                STAA    MFF07                    ; F6A7: B7 FF 07       
                LDX     #S1_TXT                  ; F6AA: CE FB D0       
                JSR     XPDAT1                   ; F6AD: BD FA 35       
                CLRB                             ; F6B0: 5F             
                LDX     #MFF58                   ; F6B1: CE FF 58       
                BSR     ZF6FA                    ; F6B4: 8D 44          
                LDX     #MFF5A                   ; F6B6: CE FF 5A       
                BSR     ZF6FA                    ; F6B9: 8D 3F          
                BSR     ZF6FA                    ; F6BB: 8D 3D          
                LDX     MFF5A                    ; F6BD: FE FF 5A       
ZF6C0           BSR     ZF6FA                    ; F6C0: 8D 38          
                DEC     MFF07                    ; F6C2: 7A FF 07       
                BNE     ZF6C0                    ; F6C5: 26 F9          
                STX     MFF5A                    ; F6C7: FF FF 5A       
                COMB                             ; F6CA: 53             
                PSHB                             ; F6CB: 37             
                TSX                              ; F6CC: 30             
                BSR     ZF6FA                    ; F6CD: 8D 2B          
                PULB                             ; F6CF: 33             
                LDX     MFF5A                    ; F6D0: FE FF 5A       
                DEX                              ; F6D3: 09             
                CPX     MFF0C                    ; F6D4: BC FF 0C       
                BNE     ZF68C                    ; F6D7: 26 B3          
                LDX     #S9_TXT                  ; F6D9: CE FB D6       
                JSR     XPDAT1                   ; F6DC: BD FA 35       
                BSR     ZF700                    ; F6DF: 8D 1F          
                LDAA    #$14                     ; F6E1: 86 14          
                JSR     XOUTCH1                  ; F6E3: BD F9 DC       
                TST     MFF02                    ; F6E6: 7D FF 02       
                BPL     ZF6F5                    ; F6E9: 2A 0A          
                LDAA    #$10                     ; F6EB: 86 10          
                JSR     XOUTCH1                  ; F6ED: BD F9 DC       
                LDAA    #$39                     ; F6F0: 86 39          
                JSR     XOUTCH1                  ; F6F2: BD F9 DC       
ZF6F5           CLR     MFF62                    ; F6F5: 7F FF 62       
                BRA     PUNCH                    ; F6F8: 20 1F          
ZF6FA           ADDB    ,X                       ; F6FA: EB 00          
                JSR     ZFA14                    ; F6FC: BD FA 14       
                RTS                              ; F6FF: 39             
ZF700           LDAB    #$28                     ; F700: C6 28          
ZF702           LDAA    #$00                     ; F702: 86 00          
                JSR     XOUTCH1                  ; F704: BD F9 DC       
                DECB                             ; F707: 5A             
                BNE     ZF702                    ; F708: 26 F8          
                RTS                              ; F70A: 39             
ZF70B           LDX     #EXEC                    ; F70B: CE FB 7F       
                JSR     XPDATA1                  ; F70E: BD FA 33       
                JSR     ZFA4E                    ; F711: BD FA 4E       
                CMPA    #$59                     ; F714: 81 59          
                BNE     ZF70B                    ; F716: 26 F3          
                RTS                              ; F718: 39             
PUNCH           JSR     XBEGEN1                  ; F719: BD F7 89       
                LDAA    MFF04                    ; F71C: B6 FF 04       
                CMPA    #'R                      ; F71F: 81 52          
                BEQ     ZF726                    ; F721: 27 03          
                JMP     ZF631                    ; F723: 7E F6 31       
ZF726           BSR     ZF70B                    ; F726: 8D E3          
                LDX     MFF0A                    ; F728: FE FF 0A       
                STX     MFF08                    ; F72B: FF FF 08       
                LDAA    MFF09                    ; F72E: B6 FF 09       
                ANDA    #$F0                     ; F731: 84 F0          
                STAA    MFF09                    ; F733: B7 FF 09       
ZF736           JSR     XPCRLF1                  ; F736: BD FA 41       
ZF739           JSR     XPCRLF1                  ; F739: BD FA 41       
                LDX     #MFF08                   ; F73C: CE FF 08       
                JSR     XOUT4H1                  ; F73F: BD FA 22       
                LDX     MFF08                    ; F742: FE FF 08       
                LDAB    #$10                     ; F745: C6 10          
ZF747           JSR     XOUT2H1                  ; F747: BD FA 24       
                DECB                             ; F74A: 5A             
                BNE     ZF747                    ; F74B: 26 FA          
                LDAA    #$20                     ; F74D: 86 20          
                JSR     XOUTCH1                  ; F74F: BD F9 DC       
                LDAB    #$10                     ; F752: C6 10          
                LDX     MFF08                    ; F754: FE FF 08       
ZF757           LDAA    ,X                       ; F757: A6 00          
                ANDA    #$7F                     ; F759: 84 7F          
                CMPA    #$20                     ; F75B: 81 20          
                BLT     ZF763                    ; F75D: 2D 04          
                CMPA    #$61                     ; F75F: 81 61          
                BLT     ZF765                    ; F761: 2D 02          
ZF763           LDAA    #$2E                     ; F763: 86 2E          
ZF765           JSR     XOUTCH1                  ; F765: BD F9 DC       
                INX                              ; F768: 08             
                DECB                             ; F769: 5A             
                BNE     ZF757                    ; F76A: 26 EB          
                STX     MFF08                    ; F76C: FF FF 08       
                CPX     #M0000                   ; F76F: 8C 00 00       
                BEQ     PUNCH                    ; F772: 27 A5          
                LDAA    MFF0C                    ; F774: B6 FF 0C       
                LDAB    MFF0D                    ; F777: F6 FF 0D       
                SUBB    MFF09                    ; F77A: F0 FF 09       
                SBCA    MFF08                    ; F77D: B2 FF 08       
                BCS     PUNCH                    ; F780: 25 97          
                TST     MFF09                    ; F782: 7D FF 09       
                BNE     ZF739                    ; F785: 26 B2          
                BRA     ZF736                    ; F787: 20 AD          
XBEGEN1         LDX     #BEGINADDR               ; F789: CE FB 36       
                JSR     XPDATA1                  ; F78C: BD FA 33       
                LDX     #MFF0A                   ; F78F: CE FF 0A       
                JSR     ZF964                    ; F792: BD F9 64       
                BMI     XBEGEN1                  ; F795: 2B F2          
ZF797           LDX     #ENDADDR                 ; F797: CE FB 40       
                JSR     XPDATA1                  ; F79A: BD FA 33       
                LDX     #MFF0C                   ; F79D: CE FF 0C       
                JSR     ZF964                    ; F7A0: BD F9 64       
                BMI     ZF797                    ; F7A3: 2B F2          
                LDAA    MFF0C                    ; F7A5: B6 FF 0C       
                LDAB    MFF0D                    ; F7A8: F6 FF 0D       
                SUBB    MFF0B                    ; F7AB: F0 FF 0B       
                SBCA    MFF0A                    ; F7AE: B2 FF 0A       
                BCS     XBEGEN1                  ; F7B1: 25 D6          
                RTS                              ; F7B3: 39             
SEARCH          LDAA    #$FF                     ; F7B4: 86 FF          
                STAA    MFF5A                    ; F7B6: B7 FF 5A       
                BRA     ZF7DF                    ; F7B9: 20 24          
LOAD            CLR     MFF5A                    ; F7BB: 7F FF 5A       
                BRA     ZF7C8                    ; F7BE: 20 08          
VERIFY          LDAA    #$01                     ; F7C0: 86 01          
                STAA    MFF5A                    ; F7C2: B7 FF 5A       
                CLR     MFF61                    ; F7C5: 7F FF 61       
ZF7C8           LDX     #SGLCONT                 ; F7C8: CE FB 85       
                JSR     XPDATA1                  ; F7CB: BD FA 33       
                JSR     ZFA4E                    ; F7CE: BD FA 4E       
                STAA    MFF58                    ; F7D1: B7 FF 58       
                CMPA    #$53                     ; F7D4: 81 53          
                BEQ     ZF7DF                    ; F7D6: 27 07          
                CMPA    #$43                     ; F7D8: 81 43          
                BNE     ZF7C8                    ; F7DA: 26 EC          
                JSR     XPCRLF1                  ; F7DC: BD FA 41       
ZF7DF           JSR     ROBJREC                  ; F7DF: BD F8 A4       
                LDAA    MFF8C                    ; F7E2: B6 FF 8C       
                CMPA    #$30                     ; F7E5: 81 30          
                BNE     ZF81C                    ; F7E7: 26 33          
                LDAA    MFF8D                    ; F7E9: B6 FF 8D       
                LDX     #MFF8D                   ; F7EC: CE FF 8D       
ZF7EF           INX                              ; F7EF: 08             
                DECA                             ; F7F0: 4A             
                BNE     ZF7EF                    ; F7F1: 26 FC          
                LDAA    #$04                     ; F7F3: 86 04          
                STAA    ,X                       ; F7F5: A7 00          
                LDX     #MFF90                   ; F7F7: CE FF 90       
                JSR     XPDATA1                  ; F7FA: BD FA 33       
                JSR     ZF91D                    ; F7FD: BD F9 1D       
                TST     MFF5A                    ; F800: 7D FF 5A       
                BPL     ZF7DF                    ; F803: 2A DA          
ZF805           LDX     #CONTLDVERF              ; F805: CE FB 4A       
                JSR     XPDATA1                  ; F808: BD FA 33       
                JSR     ZFA4E                    ; F80B: BD FA 4E       
                CMPA    #$43                     ; F80E: 81 43          
                BEQ     ZF7DF                    ; F810: 27 CD          
                CMPA    #$4C                     ; F812: 81 4C          
                BEQ     LOAD                     ; F814: 27 A5          
                CMPA    #$56                     ; F816: 81 56          
                BEQ     VERIFY                   ; F818: 27 A6          
                BRA     ZF805                    ; F81A: 20 E9          
ZF81C           TST     MFF5A                    ; F81C: 7D FF 5A       
                BMI     ZF7DF                    ; F81F: 2B BE          
                JSR     ZF91D                    ; F821: BD F9 1D       
                LDAA    MFF8C                    ; F824: B6 FF 8C       
                CMPA    #$31                     ; F827: 81 31          
                BEQ     ZF839                    ; F829: 27 0E          
                CMPA    #$39                     ; F82B: 81 39          
                BNE     ZF7DF                    ; F82D: 26 B0          
                LDAA    MFF58                    ; F82F: B6 FF 58       
                CMPA    #$43                     ; F832: 81 43          
                BEQ     ZF7DF                    ; F834: 27 A9          
                JMP     ZF5DC                    ; F836: 7E F5 DC       
ZF839           LDAA    MFF8D                    ; F839: B6 FF 8D       
                SUBA    #$03                     ; F83C: 80 03          
                STAA    MFF8D                    ; F83E: B7 FF 8D       
                LDX     #MFF90                   ; F841: CE FF 90       
                STX     MFF08                    ; F844: FF FF 08       
                LDX     MFF8E                    ; F847: FE FF 8E       
ZF84A           STX     MFF56                    ; F84A: FF FF 56       
                LDX     MFF08                    ; F84D: FE FF 08       
                LDAA    ,X                       ; F850: A6 00          
                INX                              ; F852: 08             
                STX     MFF08                    ; F853: FF FF 08       
                LDX     MFF56                    ; F856: FE FF 56       
                TST     MFF5A                    ; F859: 7D FF 5A       
                BEQ     ZF895                    ; F85C: 27 37          
                CMPA    ,X                       ; F85E: A1 00          
                BEQ     ZF88C                    ; F860: 27 2A          
                PSHA                             ; F862: 36             
                STX     MFF56                    ; F863: FF FF 56       
                TST     MFF61                    ; F866: 7D FF 61       
                BNE     ZF875                    ; F869: 26 0A          
                SEC                              ; F86B: 0D             
                ROL     MFF61                    ; F86C: 79 FF 61       
                LDX     #ADRMEMTAP               ; F86F: CE FB 6B       
                JSR     XPDATA1                  ; F872: BD FA 33       
ZF875           LDX     #MFF56                   ; F875: CE FF 56       
                JSR     XPCRLF1                  ; F878: BD FA 41       
                JSR     XOUT4H1                  ; F87B: BD FA 22       
                LDX     MFF56                    ; F87E: FE FF 56       
                JSR     XOUT2H1                  ; F881: BD FA 24       
                TSX                              ; F884: 30             
                JSR     XOUT2H1                  ; F885: BD FA 24       
                PULA                             ; F888: 32             
                LDX     MFF56                    ; F889: FE FF 56       
ZF88C           INX                              ; F88C: 08             
                DEC     MFF8D                    ; F88D: 7A FF 8D       
                BNE     ZF84A                    ; F890: 26 B8          
                JMP     ZF7DF                    ; F892: 7E F7 DF       
ZF895           STAA    ,X                       ; F895: A7 00          
                CMPA    ,X                       ; F897: A1 00          
                BEQ     ZF88C                    ; F899: 27 F1          
                LDX     #NOCHNGE                 ; F89B: CE FB 5A       
                JSR     XPDATA1                  ; F89E: BD FA 33       
                JMP     ZF5DC                    ; F8A1: 7E F5 DC       
ROBJREC         CLR     MFF8C                    ; F8A4: 7F FF 8C       
                TST     MFF02                    ; F8A7: 7D FF 02       
                BPL     ZF8B8                    ; F8AA: 2A 0C          
ZF8AC           LDAA    #$10                     ; F8AC: 86 10          
                JSR     OUTCNSF                  ; F8AE: BD F9 CF       
                LDAA    #$37                     ; F8B1: 86 37          
                JSR     OUTCNSF                  ; F8B3: BD F9 CF       
                BRA     ZF8C5                    ; F8B6: 20 0D          
ZF8B8           LDAA    PROM_1                   ; F8B8: B6 FC FD       
                ANDA    #$55                     ; F8BB: 84 55          
                STAA    ACIA_0                   ; F8BD: B7 FC F4       
                LDAA    #$11                     ; F8C0: 86 11          
                JSR     XOUTCH1                  ; F8C2: BD F9 DC       
ZF8C5           SEC                              ; F8C5: 0D             
                ROL     AECHO                    ; F8C6: 79 FF 53       
                JSR     XINCHN1                  ; F8C9: BD FA A0       
                CMPA    #$0D                     ; F8CC: 81 0D          
                BNE     ZF8D5                    ; F8CE: 26 05          
                TST     MFF02                    ; F8D0: 7D FF 02       
                BMI     ZF8AC                    ; F8D3: 2B D7          
ZF8D5           CMPA    #$53                     ; F8D5: 81 53          
                BNE     ZF8C5                    ; F8D7: 26 EC          
                LDX     #MFF8D                   ; F8D9: CE FF 8D       
ZF8DC           SEC                              ; F8DC: 0D             
                ROL     AECHO                    ; F8DD: 79 FF 53       
                JSR     XINCHN1                  ; F8E0: BD FA A0       
                CMPA    #$7F                     ; F8E3: 81 7F          
                BEQ     ZF8DC                    ; F8E5: 27 F5          
                CMPA    #$30                     ; F8E7: 81 30          
                BEQ     ZF8F3                    ; F8E9: 27 08          
                CMPA    #$31                     ; F8EB: 81 31          
                BEQ     ZF8F3                    ; F8ED: 27 04          
                CMPA    #$39                     ; F8EF: 81 39          
                BNE     ZF8C5                    ; F8F1: 26 D2          
ZF8F3           STAA    MFF8C                    ; F8F3: B7 FF 8C       
                CLR     MFF8B                    ; F8F6: 7F FF 8B       
                BSR     ZF94B                    ; F8F9: 8D 50          
                STAA    MFF07                    ; F8FB: B7 FF 07       
ZF8FE           BSR     ZF94B                    ; F8FE: 8D 4B          
                DEC     MFF07                    ; F900: 7A FF 07       
                BNE     ZF8FE                    ; F903: 26 F9          
                INC     MFF8B                    ; F905: 7C FF 8B       
                LDAA    PROM_1                   ; F908: B6 FC FD       
                ANDA    #$35                     ; F90B: 84 35          
                STAA    ACIA_0                   ; F90D: B7 FC F4       
                LDX     #MFBB8                   ; F910: CE FB B8       
                JSR     XPDAT1                   ; F913: BD FA 35       
                LDAA    ACIA_1                   ; F916: B6 FC F5       
                LDAA    ACIA_1                   ; F919: B6 FC F5       
                RTS                              ; F91C: 39             
ZF91D           TST     MFF8B                    ; F91D: 7D FF 8B       
                BEQ     ZF93E                    ; F920: 27 1C          
ZF922           LDX     #CHECKSM                 ; F922: CE FB 65       
                JSR     XPDATA1                  ; F925: BD FA 33       
                LDX     #MFF8E                   ; F928: CE FF 8E       
                JSR     XOUT4H1                  ; F92B: BD FA 22       
                JSR     ZFA4E                    ; F92E: BD FA 4E       
                CMPA    #$52                     ; F931: 81 52          
                BNE     ZF938                    ; F933: 26 03          
                JMP     ZF7DF                    ; F935: 7E F7 DF       
ZF938           CMPA    #$43                     ; F938: 81 43          
                BNE     ZF922                    ; F93A: 26 E6          
                LDAA    #$FF                     ; F93C: 86 FF          
ZF93E           RTS                              ; F93E: 39             
ZF93F           SEC                              ; F93F: 0D             
                ROL     AECHO                    ; F940: 79 FF 53       
                JSR     ZFAA5                    ; F943: BD FA A5       
                CMPA    #$7F                     ; F946: 81 7F          
                BEQ     ZF93F                    ; F948: 27 F5          
                RTS                              ; F94A: 39             
ZF94B           BSR     ZF93F                    ; F94B: 8D F2          
                ASLA                             ; F94D: 48             
                ASLA                             ; F94E: 48             
                ASLA                             ; F94F: 48             
                ASLA                             ; F950: 48             
                TAB                              ; F951: 16             
                BSR     ZF93F                    ; F952: 8D EB          
                ABA                              ; F954: 1B             
                STAA    ,X                       ; F955: A7 00          
                ADDA    MFF8B                    ; F957: BB FF 8B       
                STAA    MFF8B                    ; F95A: B7 FF 8B       
                CPX     #MFFD5                   ; F95D: 8C FF D5       
                BEQ     ZF963                    ; F960: 27 01          
                INX                              ; F962: 08             
ZF963           RTS                              ; F963: 39             
ZF964           STX     MFF56                    ; F964: FF FF 56       
                LDAA    #$04                     ; F967: 86 04          
                STAA    MFF5C                    ; F969: B7 FF 5C       
                JSR     XOUT4H1                  ; F96C: BD FA 22       
                BRA     ZF97C                    ; F96F: 20 0B          
ZF971           STX     MFF56                    ; F971: FF FF 56       
                LDAA    #$02                     ; F974: 86 02          
                STAA    MFF5C                    ; F976: B7 FF 5C       
                JSR     XOUT2H1                  ; F979: BD FA 24       
ZF97C           JSR     ZFA62                    ; F97C: BD FA 62       
                LDX     MFF56                    ; F97F: FE FF 56       
                JSR     ZFA50                    ; F982: BD FA 50       
                BNE     ZF9BD                    ; F985: 26 36          
                TSTB                             ; F987: 5D             
                BEQ     ZF9B7                    ; F988: 27 2D          
                CMPB    MFF5C                    ; F98A: F1 FF 5C       
                BHI     ZF9BD                    ; F98D: 22 2E          
                CMPB    MFF07                    ; F98F: F1 FF 07       
                BHI     ZF9BD                    ; F992: 22 29          
                LDAB    MFF5C                    ; F994: F6 FF 5C       
                CMPB    #$02                     ; F997: C1 02          
                BEQ     ZF9AE                    ; F999: 27 13          
                LDAB    MFF08                    ; F99B: F6 FF 08       
                STAB    ,X                       ; F99E: E7 00          
                CMPB    ,X                       ; F9A0: E1 00          
                BEQ     ZF9AD                    ; F9A2: 27 09          
ZF9A4           LDX     #NOCHNGE                 ; F9A4: CE FB 5A       
                JSR     XPDATA1                  ; F9A7: BD FA 33       
                JMP     ZF0F9                    ; F9AA: 7E F0 F9       
ZF9AD           INX                              ; F9AD: 08             
ZF9AE           LDAB    MFF09                    ; F9AE: F6 FF 09       
                STAB    ,X                       ; F9B1: E7 00          
                CMPB    ,X                       ; F9B3: E1 00          
                BNE     ZF9A4                    ; F9B5: 26 ED          
ZF9B7           CLRB                             ; F9B7: 5F             
                LDX     MFF56                    ; F9B8: FE FF 56       
                TSTB                             ; F9BB: 5D             
                RTS                              ; F9BC: 39             
ZF9BD           LDAB    #$FF                     ; F9BD: C6 FF          
                RTS                              ; F9BF: 39             
XCHEXL1         LSRA                             ; F9C0: 44             
                LSRA                             ; F9C1: 44             
                LSRA                             ; F9C2: 44             
                LSRA                             ; F9C3: 44             
XCHEXR1         ANDA    #$0F                     ; F9C4: 84 0F          
                ADDA    #$30                     ; F9C6: 8B 30          
                CMPA    #$39                     ; F9C8: 81 39          
                BLS     ZF9CE                    ; F9CA: 23 02          
                ADDA    #$07                     ; F9CC: 8B 07          
ZF9CE           RTS                              ; F9CE: 39             
OUTCNSF         PSHB                             ; F9CF: 37             
ZF9D0           LDAB    ACIA_0                   ; F9D0: F6 FC F4       
                BITB    #$02                     ; F9D3: C5 02          
                BEQ     ZF9D0                    ; F9D5: 27 F9          
                STAA    ACIA_1                   ; F9D7: B7 FC F5       
                PULB                             ; F9DA: 33             
                RTS                              ; F9DB: 39             
XOUTCH1         PSHB                             ; F9DC: 37             
ZF9DD           LDAB    ACIA_0                   ; F9DD: F6 FC F4       
                BITB    #$02                     ; F9E0: C5 02          
                BEQ     ZF9DD                    ; F9E2: 27 F9          
                STAA    ACIA_1                   ; F9E4: B7 FC F5       
                CMPA    #$0D                     ; F9E7: 81 0D          
                BNE     ZFA06                    ; F9E9: 26 1B          
                TST     MFF62                    ; F9EB: 7D FF 62       
                BNE     ZF9F9                    ; F9EE: 26 09          
                LDAB    #$17                     ; F9F0: C6 17          
                TST     MFF02                    ; F9F2: 7D FF 02       
                BEQ     ZFA04                    ; F9F5: 27 0D          
                BMI     ZF9FB                    ; F9F7: 2B 02          
ZF9F9           LDAB    #$04                     ; F9F9: C6 04          
ZF9FB           PSHA                             ; F9FB: 36             
                LDAA    #$00                     ; F9FC: 86 00          
                BSR     OUTCNSF                  ; F9FE: 8D CF          
                PULA                             ; FA00: 32             
                DECB                             ; FA01: 5A             
                BNE     ZF9FB                    ; FA02: 26 F7          
ZFA04           PULB                             ; FA04: 33             
                RTS                              ; FA05: 39             
ZFA06           TST     MFF02                    ; FA06: 7D FF 02       
                BPL     ZFA04                    ; FA09: 2A F9          
                TST     MFF62                    ; FA0B: 7D FF 62       
                BNE     ZFA04                    ; FA0E: 26 F4          
                LDAB    #$03                     ; FA10: C6 03          
                BRA     ZF9FB                    ; FA12: 20 E7          
ZFA14           LDAA    ,X                       ; FA14: A6 00          
                BSR     XCHEXL1                  ; FA16: 8D A8          
                BSR     XOUTCH1                  ; FA18: 8D C2          
                LDAA    ,X                       ; FA1A: A6 00          
                BSR     XCHEXR1                  ; FA1C: 8D A6          
                BSR     XOUTCH1                  ; FA1E: 8D BC          
                INX                              ; FA20: 08             
                RTS                              ; FA21: 39             
XOUT4H1         BSR     ZFA14                    ; FA22: 8D F0          
XOUT2H1         BSR     ZFA14                    ; FA24: 8D EE          
XPSPAC1         LDAA    #$20                     ; FA26: 86 20          
ZFA28           BSR     XOUTCH1                  ; FA28: 8D B2          
                RTS                              ; FA2A: 39             
ZFA2B           BSR     ZFA14                    ; FA2B: 8D E7          
                BSR     ZFA14                    ; FA2D: 8D E5          
                LDAA    #$2F                     ; FA2F: 86 2F          
                BRA     ZFA28                    ; FA31: 20 F5          
XPDATA1         BSR     XPCRLF1                  ; FA33: 8D 0C          
XPDAT1          LDAA    ,X                       ; FA35: A6 00          
                CMPA    #$04                     ; FA37: 81 04          
                BEQ     ZFA40                    ; FA39: 27 05          
                BSR     XOUTCH1                  ; FA3B: 8D 9F          
                INX                              ; FA3D: 08             
                BRA     XPDAT1                   ; FA3E: 20 F5          
ZFA40           RTS                              ; FA40: 39             
XPCRLF1         LDAA    #$0A                     ; FA41: 86 0A          
                BSR     XOUTCH1                  ; FA43: 8D 97          
ZFA45           LDAA    #$0D                     ; FA45: 86 0D          
                BSR     XOUTCH1                  ; FA47: 8D 93          
                LDAA    #$00                     ; FA49: 86 00          
                BSR     XOUTCH1                  ; FA4B: 8D 8F          
                RTS                              ; FA4D: 39             
ZFA4E           BSR     XINCHN1                  ; FA4E: 8D 50          
ZFA50           CMPA    #$58                     ; FA50: 81 58          
                BNE     ZFA57                    ; FA52: 26 03          
                JMP     ZF5DC                    ; FA54: 7E F5 DC       
ZFA57           CMPA    #$5E                     ; FA57: 81 5E          
                BEQ     ZFA61                    ; FA59: 27 06          
                CMPA    #$0D                     ; FA5B: 81 0D          
                BEQ     ZFA61                    ; FA5D: 27 02          
                CMPA    #$0A                     ; FA5F: 81 0A          
ZFA61           RTS                              ; FA61: 39             
ZFA62           LDX     #MFF08                   ; FA62: CE FF 08       
XINADD1         CLR     MFF07                    ; FA65: 7F FF 07       
                CLR     ,X                       ; FA68: 6F 00          
                CLR     $01,X                    ; FA6A: 6F 01          
ZFA6C           BSR     ZFAA5                    ; FA6C: 8D 37          
                BMI     ZFA87                    ; FA6E: 2B 17          
                LDAB    #$04                     ; FA70: C6 04          
ZFA72           ASL     $01,X                    ; FA72: 68 01          
                ROL     ,X                       ; FA74: 69 00          
                DECB                             ; FA76: 5A             
                BNE     ZFA72                    ; FA77: 26 F9          
                ORAA    $01,X                    ; FA79: AA 01          
                STAA    $01,X                    ; FA7B: A7 01          
                INC     MFF07                    ; FA7D: 7C FF 07       
                LDAB    MFF07                    ; FA80: F6 FF 07       
                CMPB    #$05                     ; FA83: C1 05          
                BNE     ZFA6C                    ; FA85: 26 E5          
ZFA87           LDAB    MFF07                    ; FA87: F6 FF 07       
                RTS                              ; FA8A: 39             
XINCH1          LDAA    ACIA_0                   ; FA8B: B6 FC F4       
                ASRA                             ; FA8E: 47             
                BCC     XINCH1                   ; FA8F: 24 FA          
                LDAA    ACIA_1                   ; FA91: B6 FC F5       
                TST     AECHO                    ; FA94: 7D FF 53       
                BNE     ZFA9C                    ; FA97: 26 03          
                JMP     XOUTCH1                  ; FA99: 7E F9 DC       
ZFA9C           CLR     AECHO                    ; FA9C: 7F FF 53       
                RTS                              ; FA9F: 39             
XINCHN1         BSR     XINCH1                   ; FAA0: 8D E9          
                ANDA    #$7F                     ; FAA2: 84 7F          
                RTS                              ; FAA4: 39             
ZFAA5           BSR     XINCHN1                  ; FAA5: 8D F9          
XCBCDH1         CMPA    #$30                     ; FAA7: 81 30          
                BMI     ZFABC                    ; FAA9: 2B 11          
                CMPA    #'9                      ; FAAB: 81 39          
                BLE     ZFAB9                    ; FAAD: 2F 0A          
                CMPA    #'A                      ; FAAF: 81 41          
                BMI     ZFABC                    ; FAB1: 2B 09          
                CMPA    #'F                      ; FAB3: 81 46          
                BGT     ZFABC                    ; FAB5: 2E 05          
                SUBA    #$07                     ; FAB7: 80 07          
ZFAB9           ANDA    #$0F                     ; FAB9: 84 0F          
                RTS                              ; FABB: 39             
ZFABC           TST     MFAF4                    ; FABC: 7D FA F4       
                RTS                              ; FABF: 39             
ZFAC0           JSR     XOUTCH1                  ; FAC0: BD F9 DC       
                LDAA    #$2D                     ; FAC3: 86 2D          
                JSR     XOUTCH1                  ; FAC5: BD F9 DC       
                RTS                              ; FAC8: 39             
ZFAC9           JSR     XPCRLF1                  ; FAC9: BD FA 41       
ZFACC           LDX     #XREGsP                  ; FACC: CE FF 16       
                LDAA    #$50                     ; FACF: 86 50          
                BSR     ZFAEE                    ; FAD1: 8D 1B          
                LDAA    #$58                     ; FAD3: 86 58          
                BSR     ZFAEE                    ; FAD5: 8D 17          
                LDAA    #$41                     ; FAD7: 86 41          
                BSR     S240                     ; FAD9: 8D 0D          
                LDAA    #$42                     ; FADB: 86 42          
                BSR     S240                     ; FADD: 8D 09          
                LDAA    #$43                     ; FADF: 86 43          
                BSR     S240                     ; FAE1: 8D 05          
                LDAA    #$53                     ; FAE3: 86 53          
                BSR     ZFAEE                    ; FAE5: 8D 07          
                RTS                              ; FAE7: 39             
S240            BSR     ZFAC0                    ; FAE8: 8D D6          
                JSR     XOUT2H1                  ; FAEA: BD FA 24       
                RTS                              ; FAED: 39             
ZFAEE           BSR     ZFAC0                    ; FAEE: 8D D0          
                JSR     XOUT4H1                  ; FAF0: BD FA 22       
                RTS                              ; FAF3: 39             
MFAF4           FCB     $FF                      ; FAF4: FF             
MFAF5           FCB     'L,'O,'A,'D              ; FAF5: 4C 4F 41 44    
                FDB     LOAD                     ; FAF9: F7 BB          
                FCB     'V,'E,'R,'F              ; FAFB: 56 45 52 46    
                FDB     VERIFY                   ; FAFF: F7 C0          
                FCB     'S,'R,'C,'H              ; FB01: 53 52 43 48    
                FDB     SEARCH                   ; FB05: F7 B4          
                FCB     'P,'R,'N,'T              ; FB07: 50 52 4E 54    
                FDB     PUNCH                    ; FB0B: F7 19          
                FCB     'P,'N,'C,'H              ; FB0D: 50 4E 43 48    
                FDB     PUNCH                    ; FB11: F7 19          
                FCB     'M,'A,'I,'D              ; FB13: 4D 41 49 44    
                FDB     MAID                     ; FB17: F0 F3          
                FCB     'S,'1,'0,'.              ; FB19: 53 31 30 2E    
                FDB     S10                      ; FB1D: F6 23          
                FCB     'S,'3,'0,'.              ; FB1F: 53 33 30 2E    
                FDB     S30                      ; FB23: F6 26          
                FCB     'S,'1,'2,'0              ; FB25: 53 31 32 30    
                FDB     S120                     ; FB29: F6 2D          
GREETING        FCB     'E,'X,'B,'U,'G,' ,'1,'.  ; FB2B: 45 58 42 55 47 20 31 2E 
                FCB     '1,'                     ; FB33: 31 20          
                FCB     $04                      ; FB35: 04             
BEGINADDR       FCB     'B,'E,'G,' ,'A,'D,'D,'R  ; FB36: 42 45 47 20 41 44 44 52 
                FCB     '                        ; FB3E: 20             
                FCB     $04                      ; FB3F: 04             
ENDADDR         FCB     'E,'N,'D,' ,'A,'D,'D,'R  ; FB40: 45 4E 44 20 41 44 44 52 
                FCB     '                        ; FB48: 20             
                FCB     $04                      ; FB49: 04             
CONTLDVERF      FCB     'C,'O,'N,'T,'/,'L,'O,'A  ; FB4A: 43 4F 4E 54 2F 4C 4F 41 
                FCB     'D,'/,'V,'E,'R,'F,'      ; FB52: 44 2F 56 45 52 46 20 
                FCB     $04                      ; FB59: 04             
NOCHNGE         FCB     'N,'O,' ,'C,'H,'A,'N,'G  ; FB5A: 4E 4F 20 43 48 41 4E 47 
                FCB     'E                       ; FB62: 45             
                FCB     $07,$04                  ; FB63: 07 04          
CHECKSM         FCB     'C,'K,'S,'M,'            ; FB65: 43 4B 53 4D 20 
                FCB     $04                      ; FB6A: 04             
ADRMEMTAP       FCB     'A,'D,'D,'R,'/,'M,'E,'M  ; FB6B: 41 44 44 52 2F 4D 45 4D 
                FCB     '/,'T,'A,'P,'E           ; FB73: 2F 54 41 50 45 
                FCB     $04                      ; FB78: 04             
INVALID         FCB     ' ,'I,'N,'V,'L           ; FB79: 20 49 4E 56 4C 
                FCB     $04                      ; FB7E: 04             
EXEC            FCB     'E,'X,'E,'C,'            ; FB7F: 45 58 45 43 20 
                FCB     $04                      ; FB84: 04             
SGLCONT         FCB     'S,'G,'L,'/,'C,'O,'N,'T  ; FB85: 53 47 4C 2F 43 4F 4E 54 
                FCB     '                        ; FB8D: 20             
                FCB     $04                      ; FB8E: 04             
STOPONADDR      FCB     'S,'T,'O,'P,'-,'O,'N,'-  ; FB8F: 53 54 4F 50 2D 4F 4E 2D 
                FCB     'A,'D,'D,'R,'E,'S,'S,'   ; FB97: 41 44 44 52 45 53 53 20 
                FCB     $04                      ; FB9F: 04             
STOPADDR        FCB     'S,'T,'O,'P,' ,'A,'D,'D  ; FBA0: 53 54 4F 50 20 41 44 44 
                FCB     'R,'                     ; FBA8: 52 20          
                FCB     $04                      ; FBAA: 04             
ABORTED         FCB     'A,'B,'O,'R,'T,'E,'D,'   ; FBAB: 41 42 4F 52 54 45 44 20 
                FCB     'A,'T,'                  ; FBB3: 41 54 20       
                FCB     $04                      ; FBB6: 04             
MFBB7           FCB     $14                      ; FBB7: 14             
MFBB8           FCB     $13,$00,$00,$00,$00,$04  ; FBB8: 13 00 00 00 00 04 
MFBBE           FCB     $07                      ; FBBE: 07             
                FCB     ' ,'?                    ; FBBF: 20 3F          
                FCB     $04                      ; FBC1: 04             
MFBC2           FCB     '*                       ; FBC2: 2A             
                FCB     $04                      ; FBC3: 04             
BKPTERR         FCB     'B,'K,'P,'T,' ,'E,'R,'R  ; FBC4: 42 4B 50 54 20 45 52 52 
                FCB     'O,'R,'                  ; FBCC: 4F 52 20       
                FCB     $04                      ; FBCF: 04             
S1_TXT          FCB     $0d,$0a,$00              ; FBD0: 0D 0A 00       
                FCB     'S,'1                    ; FBD3: 53 31          
                FCB     $04                      ; FBD5: 04             
S9_TXT          FCB     $0d,$0a,$00              ; FBD6: 0D 0A 00       
                FCB     'S,'9,'0,'3,'0,'0,'0,'0  ; FBD9: 53 39 30 33 30 30 30 30 
                FCB     'F,'C                    ; FBE1: 46 43          
                FCB     $0d,$04                  ; FBE3: 0D 04          
S0_TXT          FCB     $0d,$0a,$00              ; FBE5: 0D 0A 00       
                FCB     'S,'0,'0,'B,'0,'0,'0,'0  ; FBE8: 53 30 30 42 30 30 30 30 
                FCB     '5,'8,'2,'0              ; FBF0: 35 38 32 30    
                FCB     $04                      ; FBF4: 04             
HD_TXT          FCB     'H,'D,'R,'=,'X,'         ; FBF5: 48 44 52 3D 58 20 
RTNUSR          FCB     $04,$04,$04,$f6,$ea      ; FBFB: 04 04 04 F6 EA 


                END
