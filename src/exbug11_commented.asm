;-------------------------------------
; Exbug 1.1 for Motorola Exorciser System |
;-------------------------------------

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

         include "mdoseq.inc"

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
MFF03   EQU     $FF03 ; string Buffer for EXBUG
MFF04   EQU     $FF04 ; string Buffer for EXBUG
MFF05   EQU     $FF05 ; string Buffer for EXBUG
MFF06   EQU     $FF06 ; string Buffer for EXBUG
MFF07   EQU     $FF07 ; string Buffer for EXBUG
TEMP1H  EQU     $FF08
TEMP1L  EQU     $FF09
BEGAD1H EQU     $FF0A
BEGAD1L EQU     $FF0B
ENDAD1H EQU     $FF0C
ENDAD1L EQU     $FF0D
BEGAD2H EQU     $FF0E
ENDAD2H EQU     $FF10
MFF12   EQU     $FF12
MFF13   EQU     $FF13
MFF14   EQU     $FF14
MFF17   EQU     $FF17
MFF2F   EQU     $FF2F
MFF50   EQU     $FF50
MFF51   EQU     $FF51
MFF54   EQU     $FF54
DESTADR EQU     $FF56
MFF58   EQU     $FF58
TEMP2H  EQU     $FF5A
TEMP2L  EQU     $FF5B
MFF5C   EQU     $FF5C
MFF5D   EQU     $FF5D
MFF5E   EQU     $FF5E
MFF5F   EQU     $FF5F
MFF60   EQU     $FF60
MFF61   EQU     $FF61
PNCHTMP EQU     $FF62
MFF63   EQU     $FF63
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
RSTsVC  EQU     $FFFE ; Interrupt Vectors

;****************************************************
; Program's Code Areas
;****************************************************

                ORG     $F000

PWRUP           JMP     PWRUP1                   ; F000: 7E F5 47  ; Cold Start
XBEGEN          JMP     XBEGEN1                  ; F003: 7E F7 87  ; Get Begin and Endaddress
XCBCDH          JMP     XCBCDH1                  ; F006: 7E FA 86  ; Input HEX, convert to Number
XCHEXL          JMP     XCHEXL1                  ; F009: 7E F9 B8  ; Convert HEX High Nibble
XCHEXR          JMP     XCHEXR1                  ; F00C: 7E F9 BC  ; Convert HEX Low Nibble
XINADD          JMP     XINADD1                  ; F00F: 7E FA 43  ; Get HEX digits
XINCH           JMP     XINCH1                   ; F012: 7E FA 6B  ; Get any Character from Serial Port
XINCHN          JMP     XINCHN1                  ; F015: 7E FA 7F  ; Get only the first 127 ASCII Char. from Port
XOUTCH          JMP     XOUTCH1                  ; F018: 7E F9 E2  ; Print A
XOUT2H          JMP     XOUT2H1                  ; F01B: 7E F9 C9  ; Print 2-digit HEX
XOUT4H          JMP     XOUT4H1                  ; F01E: 7E F9 C7  ; Print 4-digit HEX
XPCRLF          JMP     XPCRLF1                  ; F021: 7E FA 21  ; Send LF, CR, NULL
XPDATA          JMP     XPDATA1                  ; F024: 7E FA 14  ; Starts with CRLF, otherwise same as below
XPDAT           JMP     XPDAT1                   ; F027: 7E FA 16  ; Print String from X
XPSPAC          JMP     XPSPAC1                  ; F02A: 7E F9 CB  ; Print space
MF02D           FCB     $27,$10,$03,$E8,$00      ; F02D: 27 10 03 E8 00 ; 
                FCB     $64,$00,$0A,$00,$01      ; F032: 64 00 0A 00 01 ; 
CONVHEX         JSR     XCBCDH1                  ; F037: BD FA A7  ; 
                BMI     OCTERR                   ; F03A: 2B 6C     ; 
                ASL     $01,X                    ; F03C: 68 01     ; 
                ROL     ,X                       ; F03E: 69 00     ; 
                BSR     MUL8                     ; F040: 8D 3C     ; 
                ADDA    $01,X                    ; F042: AB 01     ; 
                STAA    $01,X                    ; F044: A7 01     ; 
GOThs           JSR     XINCHN1                  ; F046: BD FA A0  ; Got '#$', Get ASCII from Port
                CMPA    #'='                     ; F049: 81 3D     ; 
                BNE     CONVHEX                  ; F04B: 26 EA     ; 
                LDAA    #$20                     ; F04D: 86 20     ; 
                JSR     XOUTCH1                  ; F04F: BD F9 DC  ; Print space
                LDX     #MF02D                   ; F052: CE F0 2D  ; 
                LDAA    TEMP1H                   ; F055: B6 FF 08  ; 
                LDAB    TEMP1L                   ; F058: F6 FF 09  ; 
ZF05B           CLR     TEMP2H                   ; F05B: 7F FF 5A  ; 
ZF05E           INC     TEMP2H                   ; F05E: 7C FF 5A  ; 
                SUBB    $01,X                    ; F061: E0 01     ; 
                SBCA    ,X                       ; F063: A2 00     ; 
                BCC     ZF05E                    ; F065: 24 F7     ; 
                ADDB    $01,X                    ; F067: EB 01     ; 
                ADCA    ,X                       ; F069: A9 00     ; 
                PSHA                             ; F06B: 36        ; 
                LDAA    TEMP2H                   ; F06C: B6 FF 5A  ; 
                ADDA    #$2F                     ; F06F: 8B 2F     ; 
                JSR     XOUTCH1                  ; F071: BD F9 DC  ; 
                PULA                             ; F074: 32        ; 
                INX                              ; F075: 08        ; 
                INX                              ; F076: 08        ; 
                CPX     #CONVHEX                 ; F077: 8C F0 37  ; 
                BNE     ZF05B                    ; F07A: 26 DF     ; 
                BRA     MAIDs                    ; F07C: 20 7B     ; 
;------------------------------------------------
MUL8            ASL     $01,X                    ; F07E: 68 01     ;
                ROL     ,X                       ; F080: 69 00     ;
                ASL     $01,X                    ; F082: 68 01     ;
                ROL     ,X                       ; F084: 69 00     ;
                ASL     $01,X                    ; F086: 68 01     ;
                ROL     ,X                       ; F088: 69 00     ;
                RTS                              ; F08A: 39        ;
;------------------------------------------------
GOTHASH         LDX     #TEMP1H                  ; F08B: CE FF 08  ; Got '#'
                CLR     MFF07                    ; F08E: 7F FF 07  ; 
                CLR     ,X                       ; F091: 6F 00     ; 
                CLR     $01,X                    ; F093: 6F 01     ; 
                JSR     XINCHN1                  ; F095: BD FA A0  ; Get ASCII from Port
                CMPA    #'$'                     ; F098: 81 24     ; 
                BEQ     GOThs                    ; F09A: 27 AA     ; 
                CMPA    #'@'                     ; F09C: 81 40     ; 
                BEQ     GOTas                    ; F09E: 27 4A     ; 
ZF0A0           CMPA    #'0'                     ; F0A0: 81 30     ; 
                BMI     OCTERR                   ; F0A2: 2B 04     ; 
                CMPA    #'9'                     ; F0A4: 81 39     ; 
                BLE     CONVDEC                  ; F0A6: 2F 03     ; 
OCTERR          JMP     OUTQM                    ; F0A8: 7E F1 28  ; no match, output '?'
;------------------------------------------------
CONVDEC         ANDA    #$0F                     ; F0AB: 84 0F     ; 
                STAA    TEMP2H                   ; F0AD: B7 FF 5A  ; 
                LDAA    ,X                       ; F0B0: A6 00     ; 
                LDAB    $01,X                    ; F0B2: E6 01     ; 
;               ASLD                             ; F0B4: 58 49     ; There is no ASLD in 6800
                ASLB                                               ; it was an error of the disassembler
                ROLA
                JSR     MUL8                     ; F0B6: BD F0 7E  ; 
                ADDB    $01,X                    ; F0B9: EB 01     ; 
                ADCA    ,X                       ; F0BB: A9 00     ; 
                ADDB    TEMP2H                   ; F0BD: FB FF 5A  ; 
                ADCA    #$00                     ; F0C0: 89 00     ; 
                STAA    ,X                       ; F0C2: A7 00     ; 
                STAB    $01,X                    ; F0C4: E7 01     ; 
                JSR     XINCHN1                  ; F0C6: BD FA A0  ; Get ASCII from Port
                CMPA    #$3D                     ; F0C9: 81 3D     ; 
                BNE     ZF0A0                    ; F0CB: 26 D3     ; 
ZF0CD           LDAA    #$20                     ; F0CD: 86 20     ; 
                JSR     XOUTCH1                  ; F0CF: BD F9 DC  ; Print space
                LDX     #TEMP1H                  ; F0D2: CE FF 08  ; 
                JSR     XOUT4H1                  ; F0D5: BD FA 22  ; 
                BRA     MAIDs                    ; F0D8: 20 1F     ; 
;------------------------------------------------
ZF0DA           CMPA    #'0'                     ; F0DA: 81 30     ; 
                BMI     OCTERR                   ; F0DC: 2B CA     ; below '0'
                CMPA    #'8'                     ; F0DE: 81 38     ; 
                BPL     OCTERR                   ; F0E0: 2A C6     ; above '7'
                BSR     MUL8                     ; F0E2: 8D 9A     ; 
                ANDA    #$07                     ; F0E4: 84 07     ; 
                ADDA    $01,X                    ; F0E6: AB 01     ; 
                STAA    $01,X                    ; F0E8: A7 01     ; 
GOTas           JSR     XINCHN1                  ; F0EA: BD FA A0  ; Got '@$', Get ASCII from Port
                CMPA    #$3D                     ; F0ED: 81 3D     ; 
                BNE     ZF0DA                    ; F0EF: 26 E9     ; 
                BRA     ZF0CD                    ; F0F1: 20 DA     ; 
;------------------------------------------------
MAID            CLR     MFF60                    ; F0F3: 7F FF 60  ; MAID Entry point
                CLR     MFF54                    ; F0F6: 7F FF 54  ; 
;MAIDs
                LDS     #XSTAKs                  ; F0F9: 8E FF 8A  ; 
                LDX     #STAR1                   ; F0FC: CE FB C2  ; Load Prompt '*'
                JSR     XPDATA1                  ; F0FF: BD FA 33  ; Output
                JSR     XINBFR                   ; F102: BD FA 62  ; input HEX digits to buffer (FF08)
                TSTB                             ; F105: 5D        ; 
                BNE     DIGITS                   ; F106: 26 28     ; we received digits
                CMPA    #'X'                     ; F108: 81 58     ; is it 'X'
                BNE     ZF10F                    ; F10A: 26 03     ; 
                JMP     REENT3                   ; F10C: 7E F5 DC  ; yes - exit
ZF10F           CMPA    #'$'                     ; F10F: 81 24     ; 
                BNE     ZF116                    ; F111: 26 03     ; 
                JMP     GOTDLR                   ; F113: 7E F3 3D  ; 

ZF116           CMPA    #';'                     ; F116: 81 3B     ; 
                BNE     ZF11D                    ; F118: 26 03     ; 
                JMP     GOTCLN                   ; F11A: 7E F2 7F  ; 

ZF11D           CMPA    #'N'                     ; F11D: 81 4E     ; 
                BEQ     GOTcN                    ; F11F: 27 34     ; 
                CMPA    #'#'                     ; F121: 81 23     ; 
                BNE     OUTQM                    ; F123: 26 03     ; no match, output '?'
                JMP     GOTHASH                  ; F125: 7E F0 8B  ; 
;------------------------------------------------
OUTQM           LDX     #QSTMRK                  ; F128: CE FB BE  ; 
                JSR     XPDAT1                   ; F12B: BD FA 35  ; 
ZF12E           BRA     MAIDs                    ; F12E: 20 C9     ; 
;------------------------------------------------
DIGITS          CMPA    #';'                     ; F130: 81 3B     ; 
                BEQ     nCOLON                   ; F132: 27 6F     ; 
                LDX     TEMP1H                   ; F134: FE FF 08  ; 
                CMPA    #'/'                     ; F137: 81 2F     ; 
                BNE     OUTQM                    ; F139: 26 ED     ; no match, output '?'
                JMP     nSLASH                   ; F13B: 7E F1 D6  ; 
;------------------------------------------------
TRACEN          LDX     TEMP1H                   ; F13E: FE FF 08  ; 
                BEQ     ZF144                    ; F141: 27 01     ; 
                DEX                              ; F143: 09        ; 
ZF144           STX     MFF51                    ; F144: FF FF 51  ; 
                LDAA    #$FF                     ; F147: 86 FF     ; 
                STAA    MFF60                    ; F149: B7 FF 60  ; 
                STAA    MFF50                    ; F14C: B7 FF 50  ; 
                STAA    MFF54                    ; F14F: B7 FF 54  ; 
                JMP     ZF431                    ; F152: 7E F4 31  ; 
;------------------------------------------------
GOTcN           LDX     #M0000                   ; F155: CE 00 00  ; 
                BRA     ZF144                    ; F158: 20 EA     ; 
;------------------------------------------------
ENTBP           LDAA    TEMP1H                   ; F15A: B6 FF 08  ; Enter Breakpoints
                LDAB    TEMP1L                   ; F15D: F6 FF 09  ; 
                JSR     ZF2BA                    ; F160: BD F2 BA  ; 
                BEQ     MAIDs                    ; F163: 27 94     ; 
                LDX     #BRKPTs                  ; F165: CE FF 1F  ; 
ZF168           LDAA    ,X                       ; F168: A6 00     ; 
                ADDA    $01,X                    ; F16A: AB 01     ; 
                BNE     ZF179                    ; F16C: 26 0B     ; 
                LDS     TEMP1H                   ; F16E: BE FF 08  ; 
                STS     ,X                       ; F171: AF 00     ; 
                CLR     $20,X                    ; F173: 6F 20     ; 
                CLR     $21,X                    ; F175: 6F 21     ; 
                BRA     ZF12E                    ; F177: 20 B5     ; 
;------------------------------------------------
ZF179           INX                              ; F179: 08        ;
                INX                              ; F17A: 08        ;
                CPX     #MFF2F                   ; F17B: 8C FF 2F  ;
                BNE     ZF168                    ; F17E: 26 E8     ;
ZF180           JMP     OUTQM                    ; F180: 7E F1 28  ; no match, output '?'
;------------------------------------------------
REMBP           LDX     #BRKPTs                  ; F183: CE FF 1F  ; Remove Breakpoints
ZF186           LDAA    ,X                       ; F186: A6 00     ;
                CMPA    TEMP1H                   ; F188: B1 FF 08  ;
                BNE     ZF19A                    ; F18B: 26 0D     ;
                LDAA    $01,X                    ; F18D: A6 01     ;
                CMPA    TEMP1L                   ; F18F: B1 FF 09  ;
                BNE     ZF19A                    ; F192: 26 06     ;
                CLR     ,X                       ; F194: 6F 00     ;
                CLR     $01,X                    ; F196: 6F 01     ;
ZF198           BRA     ZF12E                    ; F198: 20 94     ;  
;------------------------------------------------
ZF19A           INX                              ; F19A: 08        ;
                INX                              ; F19B: 08        ;
                CPX     #MFF2F                   ; F19C: 8C FF 2F  ;
                BNE     ZF186                    ; F19F: 26 E5     ;
                BRA     ZF180                    ; F1A1: 20 DD     ;
;------------------------------------------------
nCOLON          JSR     XINCHN1                  ; F1A3: BD FA A0  ; Got nnnn: , Get ASCII from Port    
                CMPA    #'G'                     ; F1A6: 81 47     ;     
                BNE     ZF1AD                    ; F1A8: 26 03     ;     
                JMP     EXECUP                   ; F1AA: 7E F4 1C  ;     

ZF1AD           CMPA    #'N'                     ; F1AD: 81 4E     ;
                BEQ     TRACEN                   ; F1AF: 27 8D     ;
                CMPA    #'P'                     ; F1B1: 81 50     ;
                BNE     ZF1B8                    ; F1B3: 26 03     ;
                JMP     CONTBP                   ; F1B5: 7E F3 FC  ;
;------------------------------------------------
ZF1B8           CMPA    #'U'                     ; F1B8: 81 55     ;
                BEQ     REMBP                    ; F1BA: 27 C7     ;
                CMPA    #'V'                     ; F1BC: 81 56     ;
                BEQ     ENTBP                    ; F1BE: 27 9A     ;
                CMPA    #'W'                     ; F1C0: 81 57     ;
                BNE     ZF180                    ; F1C2: 26 BC     ;
                BRA     SRCHBT                   ; F1C4: 20 77     ;
;------------------------------------------------
ZF1C6           INX                              ; F1C6: 08        ;
                JSR     OUTCR                    ; F1C7: BD FA 45  ;
ZF1CA           STX     DESTADR                  ; F1CA: FF FF 56  ;
ZF1CD           LDX     #DESTADR                 ; F1CD: CE FF 56  ;
                JSR     ZFA2B                    ; F1D0: BD FA 2B  ;
                LDX     DESTADR                  ; F1D3: FE FF 56  ;
nSLASH          JSR     GETHEX2                  ; F1D6: BD F9 71  ;
                BMI     ZF1E9                    ; F1D9: 2B 0E     ;
                CMPA    #$0D                     ; F1DB: 81 0D     ;
                BEQ     ZF198                    ; F1DD: 27 B9     ;
                CMPA    #$0A                     ; F1DF: 81 0A     ;
                BEQ     ZF1C6                    ; F1E1: 27 E3     ;
                DEX                              ; F1E3: 09        ;
                JSR     XPCRLF1                  ; F1E4: BD FA 41  ; Send LF, CR, NULL
                BRA     ZF1CA                    ; F1E7: 20 E1     ;
;------------------------------------------------
ZF1E9           CMPA    #';'                     ; F1E9: 81 3B     ; 
                BNE     ZF180                    ; F1EB: 26 93     ; 
                JSR     XINCHN1                  ; F1ED: BD FA A0  ; Get ASCII from Port
                CMPA    #'O'                     ; F1F0: 81 4F     ; 
                BNE     ZF180                    ; F1F2: 26 8C     ; 
                LDX     DESTADR                  ; F1F4: FE FF 56  ; 
                INX                              ; F1F7: 08        ; 
                STX     TEMP2H                   ; F1F8: FF FF 5A  ; 
                LDAA    TEMP2H                   ; F1FB: B6 FF 5A  ; 
                LDAB    TEMP2L                   ; F1FE: F6 FF 5B  ; 
                SUBB    TEMP1L                   ; F201: F0 FF 09  ; 
                SBCA    TEMP1H                   ; F204: B2 FF 08  ; 
                BCS     ZF229                    ; F207: 25 20     ; 
                BNE     ZF221                    ; F209: 26 16     ; 
                CMPB    #$81                     ; F20B: C1 81     ; 
                BCC     ZF221                    ; F20D: 24 12     ; 
                NEGB                             ; F20F: 50        ; 
ZF210           STAB    MFF07                    ; F210: F7 FF 07  ; 
                JSR     XPSPAC1                  ; F213: BD FA 26  ; Print space
                LDX     #MFF07                   ; F216: CE FF 07  ; 
                JSR     XOUT2H1                  ; F219: BD FA 24  ; 
ZF21C           JSR     XPCRLF1                  ; F21C: BD FA 41  ; Send LF, CR, NULL
                BRA     ZF1CD                    ; F21F: 20 AC     ; 
;------------------------------------------------
ZF221           LDX     #INVALID                 ; F221: CE FB 79  ;
                JSR     XPDAT1                   ; F224: BD FA 35  ;
                BRA     ZF21C                    ; F227: 20 F3     ;
;------------------------------------------------
ZF229           LDAA    TEMP1H                   ; F229: B6 FF 08  ;
                LDAB    TEMP1L                   ; F22C: F6 FF 09  ;
                SUBB    TEMP2L                   ; F22F: F0 FF 5B  ;
                SBCA    TEMP2H                   ; F232: B2 FF 5A  ;
                BNE     ZF221                    ; F235: 26 EA     ;
                ASLB                             ; F237: 58        ;
                BCS     ZF221                    ; F238: 25 E7     ;
                LSRB                             ; F23A: 54        ;
                BRA     ZF210                    ; F23B: 20 D3     ;
;------------------------------------------------
SRCHBT          LDAA    TEMP1H                   ; F23D: B6 FF 08  ; Search for Bitpattern
                BNE     ZF2A3                    ; F240: 26 61     ; 
                LDAA    TEMP1L                   ; F242: B6 FF 09  ; 
                STAA    MFF13                    ; F245: B7 FF 13  ; 
                LDX     BEGAD2H                  ; F248: FE FF 0E  ; 
ZF24B           STX     DESTADR                  ; F24B: FF FF 56  ; 
                LDAA    ,X                       ; F24E: A6 00     ; 
                EORA    MFF13                    ; F250: B8 FF 13  ; 
                ANDA    MFF12                    ; F253: B4 FF 12  ; 
                BNE     ZF267                    ; F256: 26 0F     ; 
                JSR     XPCRLF1                  ; F258: BD FA 41  ; Send LF, CR, NULL
                LDX     #DESTADR                 ; F25B: CE FF 56  ; 
                JSR     XOUT4H1                  ; F25E: BD FA 22  ; 
                LDX     DESTADR                  ; F261: FE FF 56  ; 
                JSR     XOUT2H1                  ; F264: BD FA 24  ; 
ZF267           LDX     DESTADR                  ; F267: FE FF 56  ; 
                CPX     ENDAD2H                  ; F26A: BC FF 10  ; 
                BEQ     J2MAID1                  ; F26D: 27 42     ; 
                INX                              ; F26F: 08        ; 
                BRA     ZF24B                    ; F270: 20 D9     ; 
;------------------------------------------------
GOTcT           CLR     MFF60                    ; F272: 7F FF 60  ; Got ':T'
                CLR     MFF54                    ; F275: 7F FF 54  ;
                BRA     J2MAID1                  ; F278: 20 37     ;
;------------------------------------------------
GOTcS           CLR     MFF5D                    ; F27A: 7F FF 5D  ; Got ':S'
                BRA     J2MAID1                  ; F27D: 20 32     ;
;------------------------------------------------
GOTCLN          JSR     XINCHN1                  ; F27F: BD FA A0  ; got ':', Get ASCII from Port
                CMPA    #'G'                     ; F282: 81 47     ; 
                BNE     ZF289                    ; F284: 26 03     ; 
                JMP     GOTcG                    ; F286: 7E F4 14  ; 

ZF289           CMPA    #'N'                     ; F289: 81 4E     ;     
                BNE     ZF290                    ; F28B: 26 03     ;     
                JMP     GOTcN                    ; F28D: 7E F1 55  ;     

ZF290           CMPA    #'P'                     ; F290: 81 50     ;     
                BNE     ZF297                    ; F292: 26 03     ;     
                JMP     GOTcP                    ; F294: 7E F3 F0  ;     

ZF297           CMPA    #'S'                     ; F297: 81 53     ;
                BEQ     GOTcS                    ; F299: 27 DF     ;
                CMPA    #'T'                     ; F29B: 81 54     ;
                BEQ     GOTcT                    ; F29D: 27 D3     ;
                CMPA    #'U'                     ; F29F: 81 55     ;
                BEQ     GOTcU                    ; F2A1: 27 03     ;
ZF2A3           JMP     OUTQM                    ; F2A3: 7E F1 28  ;
;------------------------------------------------
GOTcU           LDX     #BRKPTs                  ; F2A6: CE FF 1F  ; Got ':U'
ZF2A9           CLR     ,X                       ; F2A9: 6F 00     ;
                INX                              ; F2AB: 08        ;
                CPX     #BKPINs                  ; F2AC: 8C FF 4F  ;
                BNE     ZF2A9                    ; F2AF: 26 F8     ;
J2MAID1         JMP     MAIDs                    ; F2B1: 7E F0 F9  ;
;------------------------------------------------
ZF2B4           LDAA    XREGsP                   ; F2B4: B6 FF 16  ;
                LDAB    MFF17                    ; F2B7: F6 FF 17  ;
ZF2BA           LDX     #BRKPTs                  ; F2BA: CE FF 1F  ;
ZF2BD           CMPA    ,X                       ; F2BD: A1 00     ;
                BNE     ZF2C6                    ; F2BF: 26 05     ;
                CMPB    $01,X                    ; F2C1: E1 01     ;
                BNE     ZF2C6                    ; F2C3: 26 01     ;
                RTS                              ; F2C5: 39        ;
;------------------------------------------------
ZF2C6           INX                              ; F2C6: 08        ;
                INX                              ; F2C7: 08        ;
                CPX     #MFF2F                   ; F2C8: 8C FF 2F  ;
                BNE     ZF2BD                    ; F2CB: 26 F0     ;
                LDAA    #$FF                     ; F2CD: 86 FF     ;
                RTS                              ; F2CF: 39        ;
;------------------------------------------------
GOTPXS          JSR     ZFAC0                    ; F2D0: BD FA C0  ;
                JSR     GETHEX4                  ; F2D3: BD F9 64  ;
                INX                              ; F2D6: 08        ;
                BRA     ZF2DF                    ; F2D7: 20 06     ;
;------------------------------------------------
GOTABC          JSR     ZFAC0                    ; F2D9: BD FA C0  ;
                JSR     GETHEX2                  ; F2DC: BD F9 71  ;
ZF2DF           CMPA    #$0D                     ; F2DF: 81 0D     ;
                BEQ     J2MAID2                  ; F2E1: 27 57     ;
                INX                              ; F2E3: 08        ;
                CMPA    #$0A                     ; F2E4: 81 0A     ;
                BEQ     ZF2EC                    ; F2E6: 27 04     ;
                JSR     XPCRLF1                  ; F2E8: BD FA 41  ; Send LF, CR, NULL
                RTS                              ; F2EB: 39        ;
;------------------------------------------------
ZF2EC           JSR     OUTCR                    ; F2EC: BD FA 45  ;
                RTS                              ; F2EF: 39        ;
;------------------------------------------------
GOTsR           JSR     PRNTREG1                 ; F2F0: BD FA C9  ; Got '$R', Print Registers
                JSR     XPCRLF1                  ; F2F3: BD FA 41  ; Send LF, CR, NULL
                LDX     #XREGsP                  ; F2F6: CE FF 16  ;
                LDAA    #'P'                     ; F2F9: 86 50     ;
                BSR     GOTPXS                   ; F2FB: 8D D3     ;
                LDAA    #'X'                     ; F2FD: 86 58     ;
                BSR     GOTPXS                   ; F2FF: 8D CF     ;
                LDAA    #'A'                     ; F301: 86 41     ;
                BSR     GOTABC                   ; F303: 8D D4     ;
                LDAA    #'B'                     ; F305: 86 42     ;
                BSR     GOTABC                   ; F307: 8D D0     ;
                LDAA    #'C'                     ; F309: 86 43     ;
                BSR     GOTABC                   ; F30B: 8D CC     ;
                LDAA    #'S'                     ; F30D: 86 53     ;
                BSR     GOTPXS                   ; F30F: 8D BF     ;
                BRA     J2MAID2                  ; F311: 20 27     ;
;------------------------------------------------
GOTsM           JSR     XPSPAC1                  ; F313: BD FA 26  ; Got '$M', Print space
                LDX     #MFF12                   ; F316: CE FF 12  ; 
                JSR     GETHEX2                  ; F319: BD F9 71  ; 
                BMI     ZF355                    ; F31C: 2B 37     ; 
ZF31E           LDX     #BEGINADDR               ; F31E: CE FB 36  ; Load Text (BEG ADDR)
                JSR     XPDATA1                  ; F321: BD FA 33  ; Output it
                LDX     #BEGAD2H                 ; F324: CE FF 0E  ; Set pointer to destination
                JSR     GETHEX4                  ; F327: BD F9 64  ; get HEX address
                BMI     ZF31E                    ; F32A: 2B F2     ; problem, try again     
ZF32C           LDX     #ENDADDR                 ; F32C: CE FB 40  ; Load Text (END ADDR)     
                JSR     XPDATA1                  ; F32F: BD FA 33  ; Output it     
                LDX     #ENDAD2H                 ; F332: CE FF 10  ; Set pointer to destination     
                JSR     GETHEX4                  ; F335: BD F9 64  ; get HEX address     
                BMI     ZF32C                    ; F338: 2B F2     ; problem, try again     
J2MAID2         JMP     MAIDs                    ; F33A: 7E F0 F9  ;
;------------------------------------------------
GOTDLR          JSR     XINCHN1                  ; F33D: BD FA A0  ; got dollar sign, Get ASCII from Port
                TAB                              ; F340: 16        ; 
                CMPB    #'R'                     ; F341: C1 52     ; 
                BEQ     GOTsR                    ; F343: 27 AB     ; 
                CMPB    #'V'                     ; F345: C1 56     ; 
                BEQ     GOTsV                    ; F347: 27 0F     ; 
                CMPB    #'M'                     ; F349: C1 4D     ; 
                BEQ     GOTsM                    ; F34B: 27 C6     ; 
                CMPB    #'T'                     ; F34D: C1 54     ; 
                BEQ     GOTsT                    ; F34F: 27 2C     ; 
                CMPB    #'S'                     ; F351: C1 53     ; 
                BEQ     GOTsS                    ; F353: 27 13     ; 
ZF355           JMP     OUTQM                    ; F355: 7E F1 28  ; no match, output '?'
;------------------------------------------------
GOTsV           JSR     XPCRLF1                  ; F358: BD FA 41  ; Got '$V', Send LF, CR, NULL
                LDX     #BRKPTs                  ; F35B: CE FF 1F  ; 
                LDAB    #$08                     ; F35E: C6 08     ; 
ZF360           JSR     XOUT4H1                  ; F360: BD FA 22  ; 
                DECB                             ; F363: 5A        ; 
                BNE     ZF360                    ; F364: 26 FA     ; 
                BRA     J2MAID2                  ; F366: 20 D2     ; 
;------------------------------------------------
GOTsS           LDX     #STOPADDR                ; F368: CE FB A0  ; Got '$S', Load Text
                JSR     XPDATA1                  ; F36B: BD FA 33  ; Output it
                LDX     #MFF5E                   ; F36E: CE FF 5E  ; 
                JSR     GETHEX4                  ; F371: BD F9 64  ; 
                BMI     ZF355                    ; F374: 2B DF     ; 
                LDAA    #$FF                     ; F376: 86 FF     ; 
                STAA    MFF5D                    ; F378: B7 FF 5D  ; 
                BRA     J2MAID2                  ; F37B: 20 BD     ; 
;------------------------------------------------
GOTsT           LDX     #ENDADDR                 ; F37D: CE FB 40  ; Got '$T', Load Text
                JSR     XPDATA1                  ; F380: BD FA 33  ; Output it
                LDX     #MFF14                   ; F383: CE FF 14  ; 
                JSR     GETHEX4                  ; F386: BD F9 64  ; 
                BMI     ZF355                    ; F389: 2B CA     ; 
                LDAA    #$FF                     ; F38B: 86 FF     ; 
                STAA    MFF60                    ; F38D: B7 FF 60  ; 
                CLR     MFF50                    ; F390: 7F FF 50  ; 
                BRA     J2MAID2                  ; F393: 20 A5     ; 
;------------------------------------------------
ZF395           TST     BKPINs                   ; F395: 7D FF 4F  ;
                BNE     ZF3C8                    ; F398: 26 2E     ;
                LDX     #BRKPTs                  ; F39A: CE FF 1F  ;
ZF39D           STX     DESTADR                  ; F39D: FF FF 56  ;
                LDAA    ,X                       ; F3A0: A6 00     ;
                BNE     ZF3A8                    ; F3A2: 26 04     ;
                LDAA    $01,X                    ; F3A4: A6 01     ;
                BEQ     ZF3BC                    ; F3A6: 27 14     ;
ZF3A8           LDX     ,X                       ; F3A8: EE 00     ;
                LDAA    ,X                       ; F3AA: A6 00     ;
                LDAB    #$3F                     ; F3AC: C6 3F     ;
                STAB    ,X                       ; F3AE: E7 00     ;
                CMPB    ,X                       ; F3B0: E1 00     ;
                BEQ     ZF3B7                    ; F3B2: 27 03     ;
                JMP     ZF9A4                    ; F3B4: 7E F9 A4  ;
;------------------------------------------------
ZF3B7           LDX     DESTADR                  ; F3B7: FE FF 56  ;
                STAA    $10,X                    ; F3BA: A7 10     ;
ZF3BC           INX                              ; F3BC: 08        ;
                INX                              ; F3BD: 08        ;
                CPX     #MFF2F                   ; F3BE: 8C FF 2F  ;
                BNE     ZF39D                    ; F3C1: 26 DA     ;
                LDAA    #$FF                     ; F3C3: 86 FF     ;
                STAA    BKPINs                   ; F3C5: B7 FF 4F  ;
ZF3C8           RTS                              ; F3C8: 39        ;
;------------------------------------------------
ZF3C9           TST     BKPINs                   ; F3C9: 7D FF 4F  ;
                BEQ     ZF3EC                    ; F3CC: 27 1E     ;
                LDX     #BRKPTs                  ; F3CE: CE FF 1F  ;
ZF3D1           STX     DESTADR                  ; F3D1: FF FF 56  ;
                LDAA    ,X                       ; F3D4: A6 00     ;
                BNE     ZF3DC                    ; F3D6: 26 04     ;
                LDAB    $01,X                    ; F3D8: E6 01     ;
                BEQ     ZF3E2                    ; F3DA: 27 06     ;
ZF3DC           LDAA    $10,X                    ; F3DC: A6 10     ;
                LDX     ,X                       ; F3DE: EE 00     ;
                STAA    ,X                       ; F3E0: A7 00     ;
ZF3E2           LDX     DESTADR                  ; F3E2: FE FF 56  ;
                INX                              ; F3E5: 08        ;
                INX                              ; F3E6: 08        ;
                CPX     #MFF2F                   ; F3E7: 8C FF 2F  ;
                BNE     ZF3D1                    ; F3EA: 26 E5     ;
ZF3EC           CLR     BKPINs                   ; F3EC: 7F FF 4F  ;
                RTS                              ; F3EF: 39        ;
;------------------------------------------------
GOTcP           TST     MFF60                    ; F3F0: 7D FF 60  ;
                BNE     ZF42C                    ; F3F3: 26 37     ;
                JSR     ZF2B4                    ; F3F5: BD F2 B4  ;
                BEQ     ZF42C                    ; F3F8: 27 32     ;
                BRA     ZF427                    ; F3FA: 20 2B     ;
;------------------------------------------------
CONTBP          TST     MFF60                    ; F3FC: 7D FF 60  ;
                BNE     ZF406                    ; F3FF: 26 05     ;
                JSR     ZF2B4                    ; F401: BD F2 B4  ;
                BEQ     ZF409                    ; F404: 27 03     ;
ZF406           JMP     OUTQM                    ; F406: 7E F1 28  ;
;------------------------------------------------
ZF409           LDS     TEMP1H                   ; F409: BE FF 08  ;
                DES                              ; F40C: 34        ;
                STS     $20,X                    ; F40D: AF 20     ;
                LDS     #XSTAKs                  ; F40F: 8E FF 8A  ;
                BRA     ZF42C                    ; F412: 20 18     ;
;------------------------------------------------
GOTcG           LDX     RAMBGN                   ; F414: FE FF 00  ;
                DEX                              ; F417: 09        ;
                LDX     ,X                       ; F418: EE 00     ;
                BRA     ZF41F                    ; F41A: 20 03     ;
;------------------------------------------------
EXECUP          LDX     TEMP1H                   ; F41C: FE FF 08  ;
ZF41F           STX     XREGsP                   ; F41F: FF FF 16  ;
                TST     MFF60                    ; F422: 7D FF 60  ;
                BMI     ZF42C                    ; F425: 2B 05     ;
ZF427           JSR     ZF395                    ; F427: BD F3 95  ;
                BRA     ZF431                    ; F42A: 20 05     ;
;------------------------------------------------
ZF42C           LDAA    #$FF                     ; F42C: 86 FF     ;
                STAA    MFF54                    ; F42E: B7 FF 54  ;
ZF431           LDAB    #$07                     ; F431: C6 07     ;
                LDS     XREGsS                   ; F433: BE FF 1D  ;
                LDX     #XREGsP                  ; F436: CE FF 16  ;
ZF439           LDAA    ,X                       ; F439: A6 00     ;
                PSHA                             ; F43B: 36        ;
                INX                              ; F43C: 08        ;
                DECB                             ; F43D: 5A        ;
                BNE     ZF439                    ; F43E: 26 F9     ;
                TSX                              ; F440: 30        ;
                LDAA    $03,X                    ; F441: A6 03     ;
                LDAB    $04,X                    ; F443: E6 04     ;
                STAA    $04,X                    ; F445: A7 04     ;
                STAB    $03,X                    ; F447: E7 03     ;
                LDAA    $05,X                    ; F449: A6 05     ;
                LDAB    $06,X                    ; F44B: E6 06     ;
                STAA    $06,X                    ; F44D: A7 06     ;
                STAB    $05,X                    ; F44F: E7 05     ;
                TST     MFF5D                    ; F451: 7D FF 5D  ;
                BEQ     ZF467                    ; F454: 27 11     ;
                LDAA    MFF5F                    ; F456: B6 FF 5F  ;
                STAA    PIADRA                   ; F459: B7 FC F8  ;
                LDAA    MFF5E                    ; F45C: B6 FF 5E  ;
                STAA    PIADRB                   ; F45F: B7 FC FA  ;
                LDAA    #$34                     ; F462: 86 34     ;
                STAA    PIACRA                   ; F464: B7 FC F9  ;
ZF467           TST     MFF54                    ; F467: 7D FF 54  ;
                BEQ     ZF476                    ; F46A: 27 0A     ;
                LDAA    #$34                     ; F46C: 86 34     ;
                STAA    PIACRB                   ; F46E: B7 FC FB  ;
                LDAA    #$3C                     ; F471: 86 3C     ;
                STAA    PIACRB                   ; F473: B7 FC FB  ;
ZF476           RTI                              ; F476: 3B        ;
;------------------------------------------------
;               SWI Interrupt Service Routine
;------------------------------------------------
MF477           LDAB    #$07                     ; F477: C6 07     ; SWI ISR
                LDX     #XREGsC                  ; F479: CE FF 1C  ; set up store pointer
ZF47C           PULA                             ; F47C: 32        ; get values from stack 
                STAA    ,X                       ; F47D: A7 00     ; store it
                DEX                              ; F47F: 09        ; next addr
                DECB                             ; F480: 5A        ; next value
                BNE     ZF47C                    ; F481: 26 F9     ; continue for 7 values
                STS     XREGsS                   ; F483: BF FF 1D  ; save Stackpointer
                LDS     #XSTAKs                  ; F486: 8E FF 8A  ; 
                BSR     SWPWRORD                 ; F489: 8D 34     ; 
                LDX     XREGsP                   ; F48B: FE FF 16  ; 
                DEX                              ; F48E: 09        ; 
                STX     XREGsP                   ; F48F: FF FF 16  ; 
                TST     BKPINs                   ; F492: 7D FF 4F  ; 
                BEQ     ZF4AB                    ; F495: 27 14     ; 
                JSR     ZF3C9                    ; F497: BD F3 C9  ; 
                JSR     ZF2B4                    ; F49A: BD F2 B4  ; 
                BNE     ZF4AB                    ; F49D: 26 0C     ; 
                LDS     $20,X                    ; F49F: AE 20     ; 
                BEQ     ZF4B7                    ; F4A1: 27 14     ; 
                DES                              ; F4A3: 34        ; 
                STS     $20,X                    ; F4A4: AF 20     ; 
                LDS     #XSTAKs                  ; F4A6: 8E FF 8A  ; 
                BRA     ZF42C                    ; F4A9: 20 81     ; 

ZF4AB           LDX     #BKPTERR                 ; F4AB: CE FB C4  ; Load Text
                JSR     XPDATA1                  ; F4AE: BD FA 33  ; Output it
                CLR     MFF60                    ; F4B1: 7F FF 60  ;
                CLR     MFF54                    ; F4B4: 7F FF 54  ;
ZF4B7           LDS     #XSTAKs                  ; F4B7: 8E FF 8A  ;
                JSR     PRNTREG1                 ; F4BA: BD FA C9  ; Print Registers (with CRLF before)
                BRA     ZF536                    ; F4BD: 20 77     ;
;------------------------------------------------
SWPWRORD        LDX     #XREGsP                  ; F4BF: CE FF 16  ; SWAP 32bit word HI/LOW Bytes
                LDAA    ,X                       ; F4C2: A6 00     ; Swap HI/LOW Byte (upper word)
                LDAB    $01,X                    ; F4C4: E6 01     ; |
                STAA    $01,X                    ; F4C6: A7 01     ; |
                STAB    ,X                       ; F4C8: E7 00     ; |
                LDAA    $02,X                    ; F4CA: A6 02     ; Swap HI/LOW Byte (lower word)
                LDAB    $03,X                    ; F4CC: E6 03     ; |
                STAA    $03,X                    ; F4CE: A7 03     ; |
                STAB    $02,X                    ; F4D0: E7 02     ; |
                RTS                              ; F4D2: 39        ; 
;------------------------------------------------
                STS     XREGsS                   ; F4D3: BF FF 1D  ; dead code ?
ZF4D6           BRA     ZF4D6                    ; F4D6: 20 FE     ; dead code ?
;------------------------------------------------
;               NMI Interrupt Service Routine
;------------------------------------------------
MF4D8           LDAA    #$3C                     ; F4D8: 86 3C     ; NMI ISR
                STAA    PIACRA                   ; F4DA: B7 FC F9  ; sel output reg., CA2 high
                LDAA    #$34                     ; F4DD: 86 34     ; 
                STAA    PIACRB                   ; F4DF: B7 FC FB  ; sel output reg., CB2 low
                LDAB    #$07                     ; F4E2: C6 07     ;
                LDX     #XREGsC                  ; F4E4: CE FF 1C  ; set up store pointer
ZF4E7           PULA                             ; F4E7: 32        ; get values from stack 
                STAA    ,X                       ; F4E8: A7 00     ; store it
                DEX                              ; F4EA: 09        ; next addr
                DECB                             ; F4EB: 5A        ; next value
                BNE     ZF4E7                    ; F4EC: 26 F9     ; continue for 7 values
                STS     XREGsS                   ; F4EE: BF FF 1D  ; save Stackpointer
                LDS     #XSTAKs                  ; F4F1: 8E FF 8A  ; 
                BSR     SWPWRORD                 ; F4F4: 8D C9     ; 
                JSR     ZF3C9                    ; F4F6: BD F3 C9  ; 
                LDAA    PIACRA                   ; F4F9: B6 FC F9  ; 
                LDAB    PIADRA                   ; F4FC: F6 FC F8  ; 
                BITA    #$80                     ; F4FF: 85 80     ; 
                BNE     ZF54D                    ; F501: 26 4A     ; 
                LDAA    PIACRB                   ; F503: B6 FC FB  ; 
                LDAB    PIADRB                   ; F506: F6 FC FA  ; 
                BITA    #$80                     ; F509: 85 80     ; 
                BNE     ZF539                    ; F50B: 26 2C     ; 
                TST     MFF60                    ; F50D: 7D FF 60  ; 
                BEQ     ZF544                    ; F510: 27 32     ; 
                JSR     PRNTREG1                 ; F512: BD FA C9  ; Print Registers (with CRLF before)
                TST     MFF50                    ; F515: 7D FF 50  ; 
                BEQ     ZF525                    ; F518: 27 0B     ; 
                LDX     MFF51                    ; F51A: FE FF 51  ; 
                BEQ     ZF52D                    ; F51D: 27 0E     ; 
                DEX                              ; F51F: 09        ; 
                STX     MFF51                    ; F520: FF FF 51  ; 
                BRA     ZF54A                    ; F523: 20 25     ; 

ZF525           LDX     XREGsP                   ; F525: FE FF 16  ;
                CPX     MFF14                    ; F528: BC FF 14  ;
                BNE     ZF54A                    ; F52B: 26 1D     ;
ZF52D           CLR     MFF60                    ; F52D: 7F FF 60  ;
                CLR     MFF50                    ; F530: 7F FF 50  ;
                CLR     MFF54                    ; F533: 7F FF 54  ;
ZF536           JMP     MAIDs                    ; F536: 7E F0 F9  ;
ZF539           LDX     #STOPONADDR              ; F539: CE FB 8F  ; Load Text
                JSR     XPDATA1                  ; F53C: BD FA 33  ; Output it
                JSR     PRNTREG2                 ; F53F: BD FA CC  ; Print Registers
                BRA     ZF536                    ; F542: 20 F2     ;

ZF544           JSR     ZF395                    ; F544: BD F3 95  ;
                CLR     MFF54                    ; F547: 7F FF 54  ;
ZF54A           JMP     ZF431                    ; F54A: 7E F4 31  ;
ZF54D           LDX     #ABORTED                 ; F54D: CE FB AB  ; Load Text
                JSR     XPDATA1                  ; F550: BD FA 33  ; Output it
                JSR     PRNTREG2                 ; F553: BD FA CC  ; Print Registers
                BRA     ZF567                    ; F556: 20 0F     ;
;------------------------------------------------
PWRUP1          SEI                              ; F558: 0F        ; We start here after Reset
                LDX     #M83FF                   ; F559: CE 83 FF  ; 
                STX     RAMBGN                   ; F55C: FF FF 00  ; 
                LDAA    #$00                     ; F55F: 86 00     ; 
                STAA    MFF02                    ; F561: B7 FF 02  ; 
                LDS     #XSTAKs                  ; F564: 8E FF 8A  ; |
ZF567           STS     XREGsS                   ; F567: BF FF 1D  ; Set up stack
                LDX     #MF4D8                   ; F56A: CE F4 D8  ; |
                STX     NMIsVC                   ; F56D: FF FF FC  ; Set up NMI ISR
                LDX     #MF4D8                   ; F570: CE F4 D8  ; |
                STX     RSTsVC                   ; F573: FF FF FE  ; Set up RST ISR
                LDX     #MF477                   ; F576: CE F4 77  ; |
                STX     SWIsVC                   ; F579: FF FF FA  ; Set up SWI ISR
                LDX     RAMBGN                   ; F57C: FE FF 00  ; 
                DEX                              ; F57F: 09        ; 
                DEX                              ; F580: 09        ; 
                DEX                              ; F581: 09        ; 
                DEX                              ; F582: 09        ; 
                DEX                              ; F583: 09        ; 
                DEX                              ; F584: 09        ; 
                DEX                              ; F585: 09        ; 
                LDX     ,X                       ; F586: EE 00     ; Load from $83F8
                STX     IRQsVC                   ; F588: FF FF F8  ; Set up IRQ ISR
                LDX     #BRKPTs                  ; F58B: CE FF 1F  ; |
ZF58E           CLR     ,X                       ; F58E: 6F 00     ; |
                INX                              ; F590: 08        ; | Clear all Breakpoints
                CPX     #MFF63                   ; F591: 8C FF 63  ; |
                BNE     ZF58E                    ; F594: 26 F8     ; |
                LDS     #XSTAKs                  ; F596: 8E FF 8A  ; -----------
                LDAA    #$38                     ; F599: 86 38     ; |
                STAA    PIACRA                   ; F59B: B7 FC F9  ; |
                LDAA    #$30                     ; F59E: 86 30     ; |
                STAA    PIACRB                   ; F5A0: B7 FC FB  ; |
                LDAA    #$FF                     ; F5A3: 86 FF     ; |
                STAA    PIADRA                   ; F5A5: B7 FC F8  ; | Set up PIA
                STAA    PIADRB                   ; F5A8: B7 FC FA  ; |
                LDAA    #$34                     ; F5AB: 86 34     ; |
                STAA    PIACRB                   ; F5AD: B7 FC FB  ; |
                LDAA    #$3C                     ; F5B0: 86 3C     ; |
                STAA    PIACRA                   ; F5B2: B7 FC F9  ; |
                LDAA    #$03                     ; F5B5: 86 03     ; -----------
                STAA    ACIA_0                   ; F5B7: B7 FC F4  ; set up ACIA
                LDAA    PROM_1                   ; F5BA: B6 FC FD  ; for this we actually need the PROM
                ANDA    #$35                     ; F5BD: 84 35     ; |
                STAA    ACIA_0                   ; F5BF: B7 FC F4  ; ste up ACIA again
                LDAA    #$10                     ; F5C2: 86 10     ; |
                JSR     OUTCNSF                  ; F5C4: BD F9 CF  ; Print a DLE char
                LDAA    #':'                     ; F5C7: 86 3A     ; |
                JSR     OUTCNSF                  ; F5C9: BD F9 CF  ; Print ':'
                LDAA    #$10                     ; F5CC: 86 10     ; |
                JSR     OUTCNSF                  ; F5CE: BD F9 CF  ; Print a DLE char
                LDAA    #$39                     ; F5D1: 86 39     ; |
                JSR     OUTCNSF                  ; F5D3: BD F9 CF  ; Print '9'
                LDX     #MFBB7                   ; F5D6: CE FB B7  ; 
                JSR     XPDAT1                   ; F5D9: BD FA 35  ; Print String from FBB7
REENT3          LDX     #GREETING                ; F5DC: CE FB 2B  ; Load Text
                JSR     XPDATA1                  ; F5DF: BD FA 33  ; Output it
                LDAA    ACIA_1                   ; F5E2: B6 FC F5  ; Get character
                LDX     #MFF03                   ; F5E5: CE FF 03  ; Buffer start
ZF5E8           JSR     XCKBRK2                  ; F5E8: BD FA 4E  ; Check for 'X' or '^' (Returns character in A)
                STAA    ,X                       ; F5EB: A7 00     ; store it into buffer
                INX                              ; F5ED: 08        ; |
                CPX     #MFF07                   ; F5EE: 8C FF 07  ; |
                BNE     ZF5E8                    ; F5F1: 26 F5     ; |
                LDX     #XBUGCMD                 ; F5F3: CE FA F5  ; Load command strings start
ZF5F6           LDAA    MFF03                    ; F5F6: B6 FF 03  ; load buffer start
                CMPA    ,X                       ; F5F9: A1 00     ; compare first char
                BNE     NXTCMD                   ; F5FB: 26 19     ; no, try next command
                LDAA    MFF04                    ; F5FD: B6 FF 04  ; 1st char found
                CMPA    $01,X                    ; F600: A1 01     ; compare next char
                BNE     NXTCMD                   ; F602: 26 12     ; no, try next command
                LDAA    MFF05                    ; F604: B6 FF 05  ; 2nd char found
                CMPA    $02,X                    ; F607: A1 02     ; compare next char
                BNE     NXTCMD                   ; F609: 26 0B     ; no, try next command
                LDAA    MFF06                    ; F60B: B6 FF 06  ; 3rd char found
                CMPA    $03,X                    ; F60E: A1 03     ; compare next char
                BNE     NXTCMD                   ; F610: 26 04     ; no, try next command
                LDX     $04,X                    ; F612: EE 04     ; 4th char found
                JMP     ,X                       ; F614: 6E 00     ; execute!
NXTCMD          INX                              ; F616: 08        ; 
                INX                              ; F617: 08        ; 
                INX                              ; F618: 08        ; 
                INX                              ; F619: 08        ; 
                INX                              ; F61A: 08        ; 
                INX                              ; F61B: 08        ; 
                CPX     #GREETING                ; F61C: 8C FB 2B  ; searched util end
                BNE     ZF5F6                    ; F61F: 26 D5     ; no, try next command
                BRA     REENT3                   ; F621: 20 B9     ; nothing found, back to greeting
;------------------------------------------------
S10             CLRA                             ; F623: 4F        ;
                BRA     ZF628                    ; F624: 20 02     ;
;------------------------------------------------
S30             LDAA    #$01                     ; F626: 86 01     ;
ZF628           STAA    MFF02                    ; F628: B7 FF 02  ;
                BRA     REENT3                   ; F62B: 20 AF     ;
;------------------------------------------------
S120            LDAA    #$FF                     ; F62D: 86 FF     ;
                BRA     ZF628                    ; F62F: 20 F7     ;
;------------------------------------------------
GOTPNCH         LDX     #HD_TXT                  ; F631: CE FB F5  ; Load Text (Header)
                JSR     XPDATA1                  ; F634: BD FA 33  ; Output it
                LDX     #MFF8D                   ; F637: CE FF 8D  ; set up buffer
ZF63A           JSR     XINCHN1                  ; F63A: BD FA A0  ; Get ASCII from Port
                CMPA    #$20                     ; F63D: 81 20     ; |
                BLT     ZF645                    ; F63F: 2D 04     ; ASCII < $20 - control character - use space instead
                CMPA    #$61                     ; F641: 81 61     ; ASCII small letters - use space instead
                BLT     ZF647                    ; F643: 2D 02     ; |
ZF645           LDAA    #$20                     ; F645: 86 20     ; |
ZF647           STAA    ,X                       ; F647: A7 00     ; store it to buffer
                INX                              ; F649: 08        ; next char
                CPX     #MFF93                   ; F64A: 8C FF 93  ; buffer full?
                BNE     ZF63A                    ; F64D: 26 EB     ; continue
                JSR     ASKEXEC                  ; F64F: BD F7 0B  ; Execute ?
                SEC                              ; F652: 0D        ; 
                ROL     PNCHTMP                  ; F653: 79 FF 62  ; signaling in PUNCH
                TST     MFF02                    ; F656: 7D FF 02  ; should be 0
                BPL     ZF665                    ; F659: 2A 0A     ; yes
                LDAA    #$10                     ; F65B: 86 10     ; only if FF02 > $7F, Prints $10
                JSR     XOUTCH1                  ; F65D: BD F9 DC  ; only if FF02 > $7F, |
                LDAA    #$30                     ; F660: 86 30     ; only if FF02 > $7F, Prints '0'
                JSR     XOUTCH1                  ; F662: BD F9 DC  ; Device Control 2
ZF665           LDAA    #$12                     ; F665: 86 12     ; |
                JSR     XOUTCH1                  ; F667: BD F9 DC  ; Send NULL $37 times
                JSR     SNDNULL                  ; F66A: BD F7 00  ; prime checksum
                LDAB    #$83                     ; F66D: C6 83     ; Print CR, LF, NULL, 'S00B00005820'
                LDX     #S0_TXT                  ; F66F: CE FB E5  ; Print it
                JSR     XPDAT1                   ; F672: BD FA 35  ; 
                LDX     #MFF8D                   ; F675: CE FF 8D  ; get buffer (Header)
ZF678           JSR     PADDCHKSM                ; F678: BD F6 FA  ; Print it and add checksum
                CPX     #MFF93                   ; F67B: 8C FF 93  ; End of Header?
                BNE     ZF678                    ; F67E: 26 F8     ; no
                COMB                             ; F680: 53        ; 
                PSHB                             ; F681: 37        ; push B onto stack
                TSX                              ; F682: 30        ; transfer it to X
                BSR     PADDCHKSM                ; F683: 8D 75     ; print checksum
                PULB                             ; F685: 33        ; restore B
                LDX     BEGAD1H                  ; F686: FE FF 0A  ; |
                STX     TEMP2H                   ; F689: FF FF 5A  ; |
ZF68C           LDAA    ENDAD1L                  ; F68C: B6 FF 0D  ; |
                SUBA    TEMP2L                   ; F68F: B0 FF 5B  ; |
                LDAB    ENDAD1H                  ; F692: F6 FF 0C  ; | calculate linelength
                SBCB    TEMP2H                   ; F695: F2 FF 5A  ; |
                BNE     ZF69E                    ; F698: 26 04     ; |
                CMPA    #$10                     ; F69A: 81 10     ; |
                BCS     ZF6A0                    ; F69C: 25 02     ; |
ZF69E           LDAA    #$0F                     ; F69E: 86 0F     ; |
ZF6A0           ADDA    #$04                     ; F6A0: 8B 04     ; |
                STAA    MFF58                    ; F6A2: B7 FF 58  ; total length including address and checksum
                SUBA    #$03                     ; F6A5: 80 03     ; 
                STAA    MFF07                    ; F6A7: B7 FF 07  ; length of data only
                LDX     #S1_TXT                  ; F6AA: CE FB D0  ; |
                JSR     XPDAT1                   ; F6AD: BD FA 35  ; write CR,LF, NULL, 'S1'
                CLRB                             ; F6B0: 5F        ; 
                LDX     #MFF58                   ; F6B1: CE FF 58  ; get length of line
                BSR     PADDCHKSM                ; F6B4: 8D 44     ; print it
                LDX     #TEMP2H                  ; F6B6: CE FF 5A  ; get STARTADDR
                BSR     PADDCHKSM                ; F6B9: 8D 3F     ; send highbyte
                BSR     PADDCHKSM                ; F6BB: 8D 3D     ; send lowbyte
                LDX     TEMP2H                   ; F6BD: FE FF 5A  ; get data @ address
ZF6C0           BSR     PADDCHKSM                ; F6C0: 8D 38     ; print data
                DEC     MFF07                    ; F6C2: 7A FF 07  ; next databyte
                BNE     ZF6C0                    ; F6C5: 26 F9     ; continue
                STX     TEMP2H                   ; F6C7: FF FF 5A  ; 
                COMB                             ; F6CA: 53        ; 
                PSHB                             ; F6CB: 37        ; push B onto stack
                TSX                              ; F6CC: 30        ; transfer it to X
                BSR     PADDCHKSM                ; F6CD: 8D 2B     ; print checksum
                PULB                             ; F6CF: 33        ; restore B
                LDX     TEMP2H                   ; F6D0: FE FF 5A  ;
                DEX                              ; F6D3: 09        ;
                CPX     ENDAD1H                  ; F6D4: BC FF 0C  ;
                BNE     ZF68C                    ; F6D7: 26 B3     ; next line
                LDX     #S9_TXT                  ; F6D9: CE FB D6  ; |
                JSR     XPDAT1                   ; F6DC: BD FA 35  ; Print 'S9030000FC'
                BSR     SNDNULL                  ; F6DF: 8D 1F     ; Send NULL $37 times
                LDAA    #$14                     ; F6E1: 86 14     ; Send LF, CR, NULL
                JSR     XOUTCH1                  ; F6E3: BD F9 DC  ; |
                TST     MFF02                    ; F6E6: 7D FF 02  ; Send Formfeed
                BPL     ZF6F5                    ; F6E9: 2A 0A     ; should be 0
                LDAA    #$10                     ; F6EB: 86 10     ; yes
                JSR     XOUTCH1                  ; F6ED: BD F9 DC  ; only if FF02 > $7F, Printts $10
                LDAA    #$39                     ; F6F0: 86 39     ; only if FF02 > $7F, |
                JSR     XOUTCH1                  ; F6F2: BD F9 DC  ; only if FF02 > $7F, Prints '9'
ZF6F5           CLR     PNCHTMP                  ; F6F5: 7F FF 62  ; finished in PUNCH
                BRA     PUNCH                    ; F6F8: 20 1F     ; again
;------------------------------------------------
PADDCHKSM       ADDB    ,X                       ; F6FA: EB 00     ;
                JSR     OUTHX2                   ; F6FC: BD FA 14  ;
                RTS                              ; F6FF: 39        ;
;------------------------------------------------
SNDNULL         LDAB    #$28                     ; F700: C6 28     ;
ZF702           LDAA    #$00                     ; F702: 86 00     ;
                JSR     XOUTCH1                  ; F704: BD F9 DC  ;
                DECB                             ; F707: 5A        ;
                BNE     ZF702                    ; F708: 26 F8     ;
                RTS                              ; F70A: 39        ;
;------------------------------------------------
ASKEXEC         LDX     #EXEC                    ; F70B: CE FB 7F  ; Load Text
                JSR     XPDATA1                  ; F70E: BD FA 33  ; Output it
                JSR     XCKBRK2                  ; F711: BD FA 4E  ; Check for 'X' or '^' (Returns character in A) (Returns character in A)
                CMPA    #'Y'                     ; F714: 81 59     ; Is it 'Y'
                BNE     ASKEXEC                  ; F716: 26 F3     ; no, again
                RTS                              ; F718: 39        ;
;------------------------------------------------
PUNCH           JSR     XBEGEN1                  ; F719: BD F7 89  ; Get Begin and Endaddr.
                LDAA    MFF04                    ; F71C: B6 FF 04  ; Get second char from buffer
                CMPA    #'R'                     ; F71F: 81 52     ; is it an 'R' for PRNT or not for PNCH
                BEQ     GOTPRNT                  ; F721: 27 03     ; 
                JMP     GOTPNCH                  ; F723: 7E F6 31  ; 
GOTPRNT         BSR     ASKEXEC                  ; F726: 8D E3     ; 
                LDX     BEGAD1H                  ; F728: FE FF 0A  ; 
                STX     TEMP1H                   ; F72B: FF FF 08  ; temp
                LDAA    TEMP1L                   ; F72E: B6 FF 09  ; get low byte
                ANDA    #$F0                     ; F731: 84 F0     ; limit to 16 byte boundaries
                STAA    TEMP1L                   ; F733: B7 FF 09  ; |
ZF736           JSR     XPCRLF1                  ; F736: BD FA 41  ; Send LF, CR, NULL
ZF739           JSR     XPCRLF1                  ; F739: BD FA 41  ; Send LF, CR, NULL
                LDX     #TEMP1H                  ; F73C: CE FF 08  ; 
                JSR     XOUT4H1                  ; F73F: BD FA 22  ; Output BEGADDR starting at 16 byte boundary
                LDX     TEMP1H                   ; F742: FE FF 08  ; Start at BEGADDR & FFF0
                LDAB    #$10                     ; F745: C6 10     ; print 16 bytes
ZF747           JSR     XOUT2H1                  ; F747: BD FA 24  ; Print HEX Byte
                DECB                             ; F74A: 5A        ; |
                BNE     ZF747                    ; F74B: 26 FA     ; done?
                LDAA    #$20                     ; F74D: 86 20     ; |
                JSR     XOUTCH1                  ; F74F: BD F9 DC  ; Print space
                LDAB    #$10                     ; F752: C6 10     ; print 16 characters
                LDX     TEMP1H                   ; F754: FE FF 08  ; Start at BEGADDR & FFF0
ZF757           LDAA    ,X                       ; F757: A6 00     ; Get Value
                ANDA    #$7F                     ; F759: 84 7F     ; Limit to ASCII
                CMPA    #$20                     ; F75B: 81 20     ; no unprintable characters
                BLT     ZF763                    ; F75D: 2D 04     ; 
                CMPA    #$61                     ; F75F: 81 61     ; lowercase characters?
                BLT     ZF765                    ; F761: 2D 02     ; yes
ZF763           LDAA    #$2E                     ; F763: 86 2E     ; Output a '.' instead
ZF765           JSR     XOUTCH1                  ; F765: BD F9 DC  ; print it
                INX                              ; F768: 08        ; next address
                DECB                             ; F769: 5A        ; next char
                BNE     ZF757                    ; F76A: 26 EB     ; done?
                STX     TEMP1H                   ; F76C: FF FF 08  ; store new BEGADDR
                CPX     #M0000                   ; F76F: 8C 00 00  ; |
                BEQ     PUNCH                    ; F772: 27 A5     ; If overflow to 0000 begin anew
                LDAA    ENDAD1H                  ; F774: B6 FF 0C  ; 
                LDAB    ENDAD1L                  ; F777: F6 FF 0D  ; 
                SUBB    TEMP1L                   ; F77A: F0 FF 09  ; 
                SBCA    TEMP1H                   ; F77D: B2 FF 08  ; 
                BCS     PUNCH                    ; F780: 25 97     ; 
                TST     TEMP1L                   ; F782: 7D FF 09  ; 
                BNE     ZF739                    ; F785: 26 B2     ; next line
                BRA     ZF736                    ; F787: 20 AD     ; make extra line after 16 lines
;------------------------------------------------
;  Get Begin and Endaddress, check for END > BEGIN, store it to FF0A-FF0D
;------------------------------------------------
XBEGEN1         LDX     #BEGINADDR               ; F789: CE FB 36  ; Load Text (BEG ADDR)
                JSR     XPDATA1                  ; F78C: BD FA 33  ; Output it
                LDX     #BEGAD1H                 ; F78F: CE FF 0A  ; Set pointer to destination
                JSR     GETHEX4                  ; F792: BD F9 64  ; get HEX address
                BMI     XBEGEN1                  ; F795: 2B F2     ; problem, try again
ZF797           LDX     #ENDADDR                 ; F797: CE FB 40  ; Load Text (END ADDR)
                JSR     XPDATA1                  ; F79A: BD FA 33  ; Output it
                LDX     #ENDAD1H                 ; F79D: CE FF 0C  ; Set pointer to destination
                JSR     GETHEX4                  ; F7A0: BD F9 64  ; get HEX address
                BMI     ZF797                    ; F7A3: 2B F2     ; problem, try again
                LDAA    ENDAD1H                  ; F7A5: B6 FF 0C  ; Test if END > BEGIN
                LDAB    ENDAD1L                  ; F7A8: F6 FF 0D  ; |
                SUBB    BEGAD1L                  ; F7AB: F0 FF 0B  ; |
                SBCA    BEGAD1H                  ; F7AE: B2 FF 0A  ; |
                BCS     XBEGEN1                  ; F7B1: 25 D6     ; no, try again
                RTS                              ; F7B3: 39        ; 
;------------------------------------------------
SEARCH          LDAA    #$FF                     ; F7B4: 86 FF     ;
                STAA    TEMP2H                   ; F7B6: B7 FF 5A  ;
                BRA     SINGLE                   ; F7B9: 20 24     ;
;------------------------------------------------
LOAD            CLR     TEMP2H                   ; F7BB: 7F FF 5A  ;
                BRA     CONTIN                   ; F7BE: 20 08     ;
;------------------------------------------------
VERIFY          LDAA    #$01                     ; F7C0: 86 01     ; 
                STAA    TEMP2H                   ; F7C2: B7 FF 5A  ; 
                CLR     MFF61                    ; F7C5: 7F FF 61  ; 
CONTIN          LDX     #SGLCONT                 ; F7C8: CE FB 85  ; Load Text
                JSR     XPDATA1                  ; F7CB: BD FA 33  ; Output it
                JSR     XCKBRK2                  ; F7CE: BD FA 4E  ; Check for 'X' or '^' (Returns character in A)
                STAA    MFF58                    ; F7D1: B7 FF 58  ; store character for later
                CMPA    #$53                     ; F7D4: 81 53     ; |
                BEQ     SINGLE                   ; F7D6: 27 07     ; Single
                CMPA    #$43                     ; F7D8: 81 43     ; |
                BNE     CONTIN                   ; F7DA: 26 EC     ; neiher, try again
                JSR     XPCRLF1                  ; F7DC: BD FA 41  ; Continuous, Send LF, CR, NULL
SINGLE          JSR     PRSSREC                  ; F7DF: BD F8 A4  ; Parse SRECORD line, Checksum is in FF8B
                LDAA    MFF8C                    ; F7E2: B6 FF 8C  ; linetype (can be '0', '1' or '9')
                CMPA    #$30                     ; F7E5: 81 30     ; 
                BNE     S1orS9                   ; F7E7: 26 33     ; 
                LDAA    MFF8D                    ; F7E9: B6 FF 8D  ; 
                LDX     #MFF8D                   ; F7EC: CE FF 8D  ; set up buffer
ZF7EF           INX                              ; F7EF: 08        ; 
                DECA                             ; F7F0: 4A        ; 
                BNE     ZF7EF                    ; F7F1: 26 FC     ; 
                LDAA    #$04                     ; F7F3: 86 04     ; 
                STAA    ,X                       ; F7F5: A7 00     ; 
                LDX     #MFF90                   ; F7F7: CE FF 90  ; Load Text
                JSR     XPDATA1                  ; F7FA: BD FA 33  ; Output it
                JSR     ZF91D                    ; F7FD: BD F9 1D  ; test checksum
                TST     TEMP2H                   ; F800: 7D FF 5A  ; SEARCH or VERIFY
                BPL     SINGLE                   ; F803: 2A DA     ; 
ZF805           LDX     #CONTLDVERF              ; F805: CE FB 4A  ; Load Text
                JSR     XPDATA1                  ; F808: BD FA 33  ; Output it
                JSR     XCKBRK2                  ; F80B: BD FA 4E  ; Check for 'X' or '^' (Returns character in A)
                CMPA    #$43                     ; F80E: 81 43     ; |
                BEQ     SINGLE                   ; F810: 27 CD     ; |
                CMPA    #$4C                     ; F812: 81 4C     ; |
                BEQ     LOAD                     ; F814: 27 A5     ; | again?
                CMPA    #$56                     ; F816: 81 56     ; |
                BEQ     VERIFY                   ; F818: 27 A6     ; |
                BRA     ZF805                    ; F81A: 20 E9     ; |
;------------------------------------------------
S1orS9          TST     TEMP2H                   ; F81C: 7D FF 5A  ; Search, Load or Verify ?
                BMI     SINGLE                   ; F81F: 2B BE     ; 
                JSR     ZF91D                    ; F821: BD F9 1D  ; test checksum
                LDAA    MFF8C                    ; F824: B6 FF 8C  ; linetype (can be '0', '1' or '9')
                CMPA    #$31                     ; F827: 81 31     ; 
                BEQ     S1LINE                   ; F829: 27 0E     ; 
                CMPA    #$39                     ; F82B: 81 39     ; 
                BNE     SINGLE                   ; F82D: 26 B0     ; 
                LDAA    MFF58                    ; F82F: B6 FF 58  ; last character
                CMPA    #$43                     ; F832: 81 43     ; 
                BEQ     SINGLE                   ; F834: 27 A9     ; 
                JMP     REENT3                   ; F836: 7E F5 DC  ; Exit
;------------------------------------------------
S1LINE          LDAA    MFF8D                    ; F839: B6 FF 8D  ; Load count
                SUBA    #$03                     ; F83C: 80 03     ; subtract Address and Checksum
                STAA    MFF8D                    ; F83E: B7 FF 8D  ; |
                LDX     #MFF90                   ; F841: CE FF 90  ; first data byte in buffer
                STX     TEMP1H                   ; F844: FF FF 08  ; 
                LDX     MFF8E                    ; F847: FE FF 8E  ; Address of code
ZF84A           STX     DESTADR                  ; F84A: FF FF 56  ; store address
                LDX     TEMP1H                   ; F84D: FE FF 08  ; |
                LDAA    ,X                       ; F850: A6 00     ; get first data byte
                INX                              ; F852: 08        ; |
                STX     TEMP1H                   ; F853: FF FF 08  ; point to next
                LDX     DESTADR                  ; F856: FE FF 56  ; 
                TST     TEMP2H                   ; F859: 7D FF 5A  ; Search, Load or Verify ?
                BEQ     ZF895                    ; F85C: 27 37     ; Load = 0
                CMPA    ,X                       ; F85E: A1 00     ; Compare with memory
                BEQ     ZF88C                    ; F860: 27 2A     ; all good, next byte
                PSHA                             ; F862: 36        ;
                STX     DESTADR                  ; F863: FF FF 56  ;
                TST     MFF61                    ; F866: 7D FF 61  ;
                BNE     ZF875                    ; F869: 26 0A     ;
                SEC                              ; F86B: 0D        ;
                ROL     MFF61                    ; F86C: 79 FF 61  ;
                LDX     #ADRMEMTAP               ; F86F: CE FB 6B  ; Load Text ('ADDR/MEM/TAPE')
                JSR     XPDATA1                  ; F872: BD FA 33  ; Output it
ZF875           LDX     #DESTADR                 ; F875: CE FF 56  ; 
                JSR     XPCRLF1                  ; F878: BD FA 41  ; Send LF, CR, NULL
                JSR     XOUT4H1                  ; F87B: BD FA 22  ; print destination address start
                LDX     DESTADR                  ; F87E: FE FF 56  ; 
                JSR     XOUT2H1                  ; F881: BD FA 24  ; print addres now
                TSX                              ; F884: 30        ; 
                JSR     XOUT2H1                  ; F885: BD FA 24  ; print data byte
                PULA                             ; F888: 32        ; 
                LDX     DESTADR                  ; F889: FE FF 56  ; 
ZF88C           INX                              ; F88C: 08        ; inc pointer
                DEC     MFF8D                    ; F88D: 7A FF 8D  ; decrement counter
                BNE     ZF84A                    ; F890: 26 B8     ; next byte
                JMP     SINGLE                   ; F892: 7E F7 DF  ; done

ZF895           STAA    ,X                       ; F895: A7 00     ; Store Byte to address
                CMPA    ,X                       ; F897: A1 00     ; check it 
                BEQ     ZF88C                    ; F899: 27 F1     ; ok, next
                LDX     #NOCHNGE                 ; F89B: CE FB 5A  ; Load Text
                JSR     XPDATA1                  ; F89E: BD FA 33  ; Output it
                JMP     REENT3                   ; F8A1: 7E F5 DC  ;
;------------------------------------------------
PRSSREC         CLR     MFF8C                    ; F8A4: 7F FF 8C  ; Parse SREC file, clear linetype
                TST     MFF02                    ; F8A7: 7D FF 02  ; should be 0
                BPL     ZF8B8                    ; F8AA: 2A 0C     ; yes
ZF8AC           LDAA    #$10                     ; F8AC: 86 10     ; only if FF02 > $7F 
                JSR     OUTCNSF                  ; F8AE: BD F9 CF  ; only if FF02 > $7F 
                LDAA    #$37                     ; F8B1: 86 37     ; only if FF02 > $7F
                JSR     OUTCNSF                  ; F8B3: BD F9 CF  ; only if FF02 > $7F, output A to serial
                BRA     ZF8C5                    ; F8B6: 20 0D     ;

ZF8B8           LDAA    PROM_1                   ; F8B8: B6 FC FD  ; only if FF02 < $80     
                ANDA    #$55                     ; F8BB: 84 55     ; only if FF02 < $80
                STAA    ACIA_0                   ; F8BD: B7 FC F4  ; only if FF02 < $80
                LDAA    #$11                     ; F8C0: 86 11     ; only if FF02 < $80, |
                JSR     XOUTCH1                  ; F8C2: BD F9 DC  ; only if FF02 < $80, Send Device Control 1
ZF8C5           SEC                              ; F8C5: 0D        ;|
                ROL     AECHO                    ; F8C6: 79 FF 53  ; supress echo
                JSR     XINCHN1                  ; F8C9: BD FA A0  ; Get ASCII from Port
                CMPA    #$0D                     ; F8CC: 81 0D     ;
                BNE     ZF8D5                    ; F8CE: 26 05     ;
                TST     MFF02                    ; F8D0: 7D FF 02  ; should be 0
                BMI     ZF8AC                    ; F8D3: 2B D7     ; if not go again
ZF8D5           CMPA    #'S'                     ; F8D5: 81 53     ; We have a start
                BNE     ZF8C5                    ; F8D7: 26 EC     ; if not continue receiving
                LDX     #MFF8D                   ; F8D9: CE FF 8D  ; set up buffer
ZF8DC           SEC                              ; F8DC: 0D        ; |
                ROL     AECHO                    ; F8DD: 79 FF 53  ; supress echo
                JSR     XINCHN1                  ; F8E0: BD FA A0  ; Get ASCII from Port
                CMPA    #$7F                     ; F8E3: 81 7F     ; DEL character
                BEQ     ZF8DC                    ; F8E5: 27 F5     ; ignore, continue to next char
                CMPA    #'0'                     ; F8E7: 81 30     ; |
                BEQ     ZF8F3                    ; F8E9: 27 08     ; |
                CMPA    #'1'                     ; F8EB: 81 31     ; |
                BEQ     ZF8F3                    ; F8ED: 27 04     ; |
                CMPA    #'9'                     ; F8EF: 81 39     ; |
                BNE     ZF8C5                    ; F8F1: 26 D2     ; we don't have 'S0', 'S1' or 'S9' - continue to next char
ZF8F3           STAA    MFF8C                    ; F8F3: B7 FF 8C  ; valid line, store type
                CLR     MFF8B                    ; F8F6: 7F FF 8B  ; Clear Checksum
                BSR     ZF94B                    ; F8F9: 8D 50     ;
                STAA    MFF07                    ; F8FB: B7 FF 07  ; first byte is Count
ZF8FE           BSR     ZF94B                    ; F8FE: 8D 4B     ;
                DEC     MFF07                    ; F900: 7A FF 07  ; decrement count
                BNE     ZF8FE                    ; F903: 26 F9     ; get whole line
                INC     MFF8B                    ; F905: 7C FF 8B  ; inc Checksum
                LDAA    PROM_1                   ; F908: B6 FC FD  ;
                ANDA    #$35                     ; F90B: 84 35     ;
                STAA    ACIA_0                   ; F90D: B7 FC F4  ;
                LDX     #MFBB8                   ; F910: CE FB B8  ;
                JSR     XPDAT1                   ; F913: BD FA 35  ;
                LDAA    ACIA_1                   ; F916: B6 FC F5  ;
                LDAA    ACIA_1                   ; F919: B6 FC F5  ;
                RTS                              ; F91C: 39        ;
;------------------------------------------------
ZF91D           TST     MFF8B                    ; F91D: 7D FF 8B  ; test Checksum
                BEQ     ZF93E                    ; F920: 27 1C     ; is it zero?
ZF922           LDX     #CHECKSM                 ; F922: CE FB 65  ; Load Text
                JSR     XPDATA1                  ; F925: BD FA 33  ; Output it (CKSM )
                LDX     #MFF8E                   ; F928: CE FF 8E  ; Address
                JSR     XOUT4H1                  ; F92B: BD FA 22  ; Output Address
                JSR     XCKBRK2                  ; F92E: BD FA 4E  ; Check for 'X' or '^' (Returns character in A)
                CMPA    #'R'                     ; F931: 81 52     ; 
                BNE     ZF938                    ; F933: 26 03     ; 
                JMP     SINGLE                   ; F935: 7E F7 DF  ; 
ZF938           CMPA    #'C'                     ; F938: 81 43     ; 
                BNE     ZF922                    ; F93A: 26 E6     ; 
                LDAA    #$FF                     ; F93C: 86 FF     ;
ZF93E           RTS                              ; F93E: 39        ;
;------------------------------------------------
GETNIB          SEC                              ; F93F: 0D        ; |
                ROL     AECHO                    ; F940: 79 FF 53  ; supress echo
                JSR     XINHEX                   ; F943: BD FA A5  ; Get HEX Nibble
                CMPA    #$7F                     ; F946: 81 7F     ; ignore DEL char.
                BEQ     GETNIB                   ; F948: 27 F5     ;
                RTS                              ; F94A: 39        ;

ZF94B           BSR     GETNIB                   ; F94B: 8D F2     ; Get one HEX nibble
                ASLA                             ; F94D: 48        ; |
                ASLA                             ; F94E: 48        ; |
                ASLA                             ; F94F: 48        ; |
                ASLA                             ; F950: 48        ; | *16
                TAB                              ; F951: 16        ; to B
                BSR     GETNIB                   ; F952: 8D EB     ; next nibble
                ABA                              ; F954: 1B        ; Add
                STAA    ,X                       ; F955: A7 00     ; Store 8 Byte Number
                ADDA    MFF8B                    ; F957: BB FF 8B  ; add it
                STAA    MFF8B                    ; F95A: B7 FF 8B  ; and store new Checksum
                CPX     #MFFD5                   ; F95D: 8C FF D5  ; end of buffer ?
                BEQ     ZF963                    ; F960: 27 01     ; yes, done
                INX                              ; F962: 08        ; no, cont.
ZF963           RTS                              ; F963: 39        ;
;------------------------------------------------
GETHEX4         STX     DESTADR                  ; F964: FF FF 56  ; store destination address
                LDAA    #$04                     ; F967: 86 04     ; output HEX digits
                STAA    MFF5C                    ; F969: B7 FF 5C  ; 4 characters (digits) needed
                JSR     XOUT4H1                  ; F96C: BD FA 22  ;
                BRA     ZF97C                    ; F96F: 20 0B     ;

GETHEX2         STX     DESTADR                  ; F971: FF FF 56  ; store destination address
                LDAA    #$02                     ; F974: 86 02     ; output HEX digits
                STAA    MFF5C                    ; F976: B7 FF 5C  ; 2 characters (digits) needed
                JSR     XOUT2H1                  ; F979: BD FA 24  ; digits temp
ZF97C           JSR     XINBFR                   ; F97C: BD FA 62  ; input HEX digits to buffer (FF08)
                LDX     DESTADR                  ; F97F: FE FF 56  ; destination address
                JSR     XCKBRK1                  ; F982: BD FA 50  ; check for 'X' or '^'
                BNE     BREAK                    ; F985: 26 36     ; 
                TSTB                             ; F987: 5D        ; 
                BEQ     ZF9B7                    ; F988: 27 2D     ; 
                CMPB    MFF5C                    ; F98A: F1 FF 5C  ; digits temp
                BHI     BREAK                    ; F98D: 22 2E     ; 
                CMPB    MFF07                    ; F98F: F1 FF 07  ; 
                BHI     BREAK                    ; F992: 22 29     ; 
                LDAB    MFF5C                    ; F994: F6 FF 5C  ; digits temp
                CMPB    #$02                     ; F997: C1 02     ; 
                BEQ     ZF9AE                    ; F999: 27 13     ; 
                LDAB    TEMP1H                   ; F99B: F6 FF 08  ; 
                STAB    ,X                       ; F99E: E7 00     ; 
                CMPB    ,X                       ; F9A0: E1 00     ; 
                BEQ     ZF9AD                    ; F9A2: 27 09     ; 
ZF9A4           LDX     #NOCHNGE                 ; F9A4: CE FB 5A  ; Load Text
                JSR     XPDATA1                  ; F9A7: BD FA 33  ; Output it
                JMP     MAIDs                    ; F9AA: 7E F0 F9  ; 

ZF9AD           INX                              ; F9AD: 08        ;
ZF9AE           LDAB    TEMP1L                   ; F9AE: F6 FF 09  ;
                STAB    ,X                       ; F9B1: E7 00     ;
                CMPB    ,X                       ; F9B3: E1 00     ;
                BNE     ZF9A4                    ; F9B5: 26 ED     ;
ZF9B7           CLRB                             ; F9B7: 5F        ;
                LDX     DESTADR                  ; F9B8: FE FF 56  ;
                TSTB                             ; F9BB: 5D        ;
                RTS                              ; F9BC: 39        ;

BREAK           LDAB    #$FF                     ; F9BD: C6 FF     ;
                RTS                              ; F9BF: 39        ;
;------------------------------------------------
XCHEXL1         LSRA                             ; F9C0: 44        ; convert high nibble
                LSRA                             ; F9C1: 44        ;
                LSRA                             ; F9C2: 44        ;
                LSRA                             ; F9C3: 44        ;
XCHEXR1         ANDA    #$0F                     ; F9C4: 84 0F     ; mask lower nibble and convert
                ADDA    #'0'                     ; F9C6: 8B 30     ; convert to ASCII
                CMPA    #'9'                     ; F9C8: 81 39     ; is it above '9'
                BLS     ZF9CE                    ; F9CA: 23 02     ; no - exit
                ADDA    #$07                     ; F9CC: 8B 07     ; yes, add 7 to get to 'A'
ZF9CE           RTS                              ; F9CE: 39        ;
;------------------------------------------------
OUTCNSF         PSHB                             ; F9CF: 37        ;
ZF9D0           LDAB    ACIA_0                   ; F9D0: F6 FC F4  ; Load Status
                BITB    #$02                     ; F9D3: C5 02     ; Check Transmit Ready
                BEQ     ZF9D0                    ; F9D5: 27 F9     ; if not, wait
                STAA    ACIA_1                   ; F9D7: B7 FC F5  ; Output Character
                PULB                             ; F9DA: 33        ;
                RTS                              ; F9DB: 39        ;
;------------------------------------------------
XOUTCH1         PSHB                             ; F9DC: 37        ;
ZF9DD           LDAB    ACIA_0                   ; F9DD: F6 FC F4  ; Load Status
                BITB    #$02                     ; F9E0: C5 02     ; Check Transmit Ready
                BEQ     ZF9DD                    ; F9E2: 27 F9     ; if not, wait
                STAA    ACIA_1                   ; F9E4: B7 FC F5  ; Output Character
                CMPA    #$0D                     ; F9E7: 81 0D     ; check for CR
                BNE     ZFA06                    ; F9E9: 26 1B     ; no
                TST     PNCHTMP                  ; F9EB: 7D FF 62  ; does it come from PUNCH?
                BNE     PNCHPRNT                 ; F9EE: 26 09     ; yes
                LDAB    #$17                     ; F9F0: C6 17     ;
                TST     MFF02                    ; F9F2: 7D FF 02  ;
                BEQ     ZFA04                    ; F9F5: 27 0D     ;
                BMI     ZF9FB                    ; F9F7: 2B 02     ;
PNCHPRNT        LDAB    #$04                     ; F9F9: C6 04     ; counter
ZF9FB           PSHA                             ; F9FB: 36        ;
                LDAA    #$00                     ; F9FC: 86 00     ; |
                BSR     OUTCNSF                  ; F9FE: 8D CF     ; Print NULL (four times)
                PULA                             ; FA00: 32        ;
                DECB                             ; FA01: 5A        ; decrement counter
                BNE     ZF9FB                    ; FA02: 26 F7     ; again
ZFA04           PULB                             ; FA04: 33        ;
                RTS                              ; FA05: 39        ;
;------------------------------------------------
ZFA06           TST     MFF02                    ; FA06: 7D FF 02  ;
                BPL     ZFA04                    ; FA09: 2A F9     ;
                TST     PNCHTMP                  ; FA0B: 7D FF 62  ; does it come from PUNCH?
                BNE     ZFA04                    ; FA0E: 26 F4     ; yes
                LDAB    #$03                     ; FA10: C6 03     ;
                BRA     ZF9FB                    ; FA12: 20 E7     ;
;------------------------------------------------
OUTHX2          LDAA    ,X                       ; FA14: A6 00     ; 
                BSR     XCHEXL1                  ; FA16: 8D A8     ; 
                BSR     XOUTCH1                  ; FA18: 8D C2     ; 
                LDAA    ,X                       ; FA1A: A6 00     ; 
                BSR     XCHEXR1                  ; FA1C: 8D A6     ; 
                BSR     XOUTCH1                  ; FA1E: 8D BC     ; 
                INX                              ; FA20: 08        ; 
                RTS                              ; FA21: 39        ; 
;------------------------------------------------
XOUT4H1         BSR     OUTHX2                   ; FA22: 8D F0     ; Output high byte (INX)
XOUT2H1         BSR     OUTHX2                   ; FA24: 8D EE     ; Output low byte
XPSPAC1         LDAA    #$20                     ; FA26: 86 20     ; |
ZFA28           BSR     XOUTCH1                  ; FA28: 8D B2     ; Output Space
                RTS                              ; FA2A: 39        ; 
;------------------------------------------------
ZFA2B           BSR     OUTHX2                   ; FA2B: 8D E7     ; Output high byte (INX)
                BSR     OUTHX2                   ; FA2D: 8D E5     ; Output low byte
                LDAA    #'/'                     ; FA2F: 86 2F     ; |
                BRA     ZFA28                    ; FA31: 20 F5     ; Output Slash
;------------------------------------------------
XPDATA1         BSR     XPCRLF1                  ; FA33: 8D 0C     ; Send LF, CR, NULL
XPDAT1          LDAA    ,X                       ; FA35: A6 00     ; load char
                CMPA    #$04                     ; FA37: 81 04     ; String terminator
                BEQ     ZFA40                    ; FA39: 27 05     ; RTS
                BSR     XOUTCH1                  ; FA3B: 8D 9F     ; else, output characters
                INX                              ; FA3D: 08        ; next char
                BRA     XPDAT1                   ; FA3E: 20 F5     ; continue

ZFA40           RTS                              ; FA40: 39        ;
;------------------------------------------------
XPCRLF1         LDAA    #$0A                     ; FA41: 86 0A     ; LF
                BSR     XOUTCH1                  ; FA43: 8D 97     ; Output
OUTCR           LDAA    #$0D                     ; FA45: 86 0D     ; CR
                BSR     XOUTCH1                  ; FA47: 8D 93     ; Output
                LDAA    #$00                     ; FA49: 86 00     ; NULL
                BSR     XOUTCH1                  ; FA4B: 8D 8F     ; Output
                RTS                              ; FA4D: 39        ; 
;------------------------------------------------
XCKBRK2         BSR     XINCHN1                  ; FA4E: 8D 50    ; Get ASCII from Port
XCKBRK1         CMPA    #'X'                     ; FA50: 81 58    ; is it 'X'
                BNE     ZFA57                    ; FA52: 26 03    ; no
                JMP     REENT3                   ; FA54: 7E F5 DC ; Got 'X' - restart
ZFA57           CMPA    #'^'                     ; FA57: 81 5E    ; not 'X', is it '^'?
                BEQ     ZFA61                    ; FA59: 27 06    ; yes, done
                CMPA    #$0D                     ; FA5B: 81 0D    ; ignore CR and LF
                BEQ     ZFA61                    ; FA5D: 27 02    ; |
                CMPA    #$0A                     ; FA5F: 81 0A    ; |
ZFA61           RTS                              ; FA61: 39       ; |
;------------------------------------------------
XINBFR          LDX     #TEMP1H                  ; FA62: CE FF 08 ; set up buffer
XINADD1         CLR     MFF07                    ; FA65: 7F FF 07 ; clear
                CLR     ,X                       ; FA68: 6F 00    ; |
                CLR     $01,X                    ; FA6A: 6F 01    ; |
ZFA6C           BSR     XINHEX                   ; FA6C: 8D 37    ; get HEX digit
                BMI     ZFA87                    ; FA6E: 2B 17    ; error
                LDAB    #$04                     ; FA70: C6 04    ; |
ZFA72           ASL     $01,X                    ; FA72: 68 01    ; |
                ROL     ,X                       ; FA74: 69 00    ; |
                DECB                             ; FA76: 5A       ; |
                BNE     ZFA72                    ; FA77: 26 F9    ; multiply with 16
                ORAA    $01,X                    ; FA79: AA 01    ;
                STAA    $01,X                    ; FA7B: A7 01    ;
                INC     MFF07                    ; FA7D: 7C FF 07 ; next digit
                LDAB    MFF07                    ; FA80: F6 FF 07 ; |
                CMPB    #$05                     ; FA83: C1 05    ; done?
                BNE     ZFA6C                    ; FA85: 26 E5    ; no
ZFA87           LDAB    MFF07                    ; FA87: F6 FF 07 ; how many digits received
                RTS                              ; FA8A: 39       ;
;------------------------------------------------
XINCH1          LDAA    ACIA_0                   ; FA8B: B6 FC F4 ; Load Status
                ASRA                             ; FA8E: 47       ; 
                BCC     XINCH1                   ; FA8F: 24 FA    ; Wait
                LDAA    ACIA_1                   ; FA91: B6 FC F5 ; Load Data
                TST     AECHO                    ; FA94: 7D FF 53 ; Echo it?
                BNE     ZFA9C                    ; FA97: 26 03    ; No
                JMP     XOUTCH1                  ; FA99: 7E F9 DC ; Output if ECHO is on

ZFA9C           CLR     AECHO                    ; FA9C: 7F FF 53 ;
                RTS                              ; FA9F: 39       ;
;------------------------------------------------
XINCHN1         BSR     XINCH1                   ; FAA0: 8D E9    ; Get actual character from serial port 
                ANDA    #$7F                     ; FAA2: 84 7F    ; only first 127 ASCII characters 
                RTS                              ; FAA4: 39       ; 
;------------------------------------------------
XINHEX          BSR     XINCHN1                  ; FAA5: 8D F9    ; Get ASCII from port
XCBCDH1         CMPA    #'0'                     ; FAA7: 81 30    ; 
                BMI     BCDERR                   ; FAA9: 2B 11    ; below '0'
                CMPA    #'9'                     ; FAAB: 81 39    ; 
                BLE     ZFAB9                    ; FAAD: 2F 0A    ; 
                CMPA    #'A'                     ; FAAF: 81 41    ; 
                BMI     BCDERR                   ; FAB1: 2B 09    ; below 'A'
                CMPA    #'F'                     ; FAB3: 81 46    ; 
                BGT     BCDERR                   ; FAB5: 2E 05    ; above 'F'
                SUBA    #$07                     ; FAB7: 80 07    ; 
ZFAB9           ANDA    #$0F                     ; FAB9: 84 0F    ; 
                RTS                              ; FABB: 39       ; 
;------------------------------------------------
BCDERR          TST     $FAF4                    ; FABC: 7D FA F4 ; is $FF - set N Flag
                RTS                              ; FABF: 39       ; 
;------------------------------------------------
ZFAC0           JSR     XOUTCH1                  ; FAC0: BD F9 DC ; Print A
                LDAA    #'-'                     ; FAC3: 86 2D    ; |
                JSR     XOUTCH1                  ; FAC5: BD F9 DC ; print '-'
                RTS                              ; FAC8: 39       ; 
;------------------------------------------------
PRNTREG1        JSR     XPCRLF1                  ; FAC9: BD FA 41 ; Send LF, CR, NULL
PRNTREG2        LDX     #XREGsP                  ; FACC: CE FF 16 ; Get register address
                LDAA    #'P'                     ; FACF: 86 50    ; |
                BSR     PRNLN4                   ; FAD1: 8D 1B    ; |
                LDAA    #'X'                     ; FAD3: 86 58    ; |
                BSR     PRNLN4                   ; FAD5: 8D 17    ; |
                LDAA    #'A'                     ; FAD7: 86 41    ; |
                BSR     PRNLN2                   ; FAD9: 8D 0D    ; |
                LDAA    #'B'                     ; FADB: 86 42    ; |
                BSR     PRNLN2                   ; FADD: 8D 09    ; |
                LDAA    #'C'                     ; FADF: 86 43    ; |
                BSR     PRNLN2                   ; FAE1: 8D 05    ; |
                LDAA    #'S'                     ; FAE3: 86 53    ; |
                BSR     PRNLN4                   ; FAE5: 8D 07    ; print it 
                RTS                              ; FAE7: 39       ; 

PRNLN2          BSR     ZFAC0                    ; FAE8: 8D D6    ; 
                JSR     XOUT2H1                  ; FAEA: BD FA 24 ; 
                RTS                              ; FAED: 39       ; 

PRNLN4          BSR     ZFAC0                    ; FAEE: 8D D0    ; 
                JSR     XOUT4H1                  ; FAF0: BD FA 22 ; 
                RTS                              ; FAF3: 39       ; 
;------------------------------------------------
MFAF4           FCB     $FF                      ; FAF4: FF             
XBUGCMD         FCC     'LOAD'                   ; FAF5: 4C 4F 41 44
                FDB     LOAD                     ; FAF9: F7 B9      
                FCC     'VERF'                   ; FAFB: 56 45 52 46
                FDB     VERIFY                   ; FAFF: F7 BE      
                FCC     'SRCH'                   ; FB01: 53 52 43 48
                FDB     SEARCH                   ; FB05: F7 B2      
                FCC     'PRNT'                   ; FB07: 50 52 4E 54
                FDB     PUNCH                    ; FB0B: F7 1A      
                FCC     'PNCH'                   ; FB0D: 50 4E 43 48
                FDB     PUNCH                    ; FB11: F7 1A      
                FCC     'MAID'                   ; FB13: 4D 41 49 44
                FDB     MAID                     ; FB17: F0 ED      
                FCC     'S10.'                   ; FB19: 53 31 30 2E
                FDB     S10                      ; FB1D: FA CD      
                FCC     'S30.'                   ; FB1F: 53 33 30 2E
                FDB     S30                      ; FB23: FA DA      
                FCC     'S120'                   ; FB25: 53 31 32 30
                FDB     S120                     ; FB29: FA E1      
GREETING        FCC     'EXBUG 1.1 '             ; FB2B: 45 58 42 55 47 20 31 2E 31 20
                FCB     $04                      ; FB35: 04             
BEGINADDR       FCC     'BEG ADDR '              ; FB36: 42 45 47 20 41 44 44 52 20
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
ABORTED         FCC     'ABORTED AT '            ; FBAF: 41 42 4F 52 54 45 44 20 41 54 20
                FCB     $04                      ; FBBA: 04             
MFBB7           FCB     $14                      ; FBB7: 14             
MFBB8           FCB     $13,$00,$00,$00,$00,$04  ; FBB8: 13 00 00 00 00 04 
QSTMRK          FCB     $07                      ; FBBE: 07             
                FCC     ' ?'                     ; FBBF: 20 3F          
                FCB     $04                      ; FBC1: 04             
STAR1           FCB     '*'                      ; FBC2: 2A             
                FCB     $04                      ; FBC3: 04             
BKPTERR         FCC     'BKPT ERROR '            ; FBC8: 42 4B 50 54 20 45 52 52 4F 52 20 
                FCB     $04                      ; FBD3: 04             
S1_TXT          FCB     $0d,$0a,$00              ; FBD4: 0D 0A 00       
                FCC     'S1'                     ; FBD7: 53 31          
                FCB     $04                      ; FBD9: 04             
S9_TXT          FCB     $0d,$0a,$00              ; FBDA: 0D 0A 00       
                FCC     'S9030000FC'             ; FBDD: 53 39 30 33 30 30 30 30 46 43 
                FCB     $0d,$04                  ; FBE7: 0D 04          
S0_TXT          FCB     $0d,$0a,$00              ; FBE9: 0D 0A 00       
                FCC     'S00B00005820'           ; FBEC: 53 30 30 42 30 30 30 30 35 38 32 30
                FCB     $04                      ; FBF8: 04             
HD_TXT          FCC     'HDR=X '                 ; FBF9: 48 44 52 3D 58 20         
                FCB     $04,$04,$04,$f6,$ea      ; FBFB: 04 04 04 F6 EA 


                END
