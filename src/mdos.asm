dasmfw: Disassembler Framework V0.35
Loaded: binary file "mdos.sy"
Loaded: Info file "mdos.info"

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
M0008   EQU     $0008
M000B   EQU     $000B
M000C   EQU     $000C
M000D   EQU     $000D
M007D   EQU     $007D
M0082   EQU     $0082
M00AE   EQU     $00AE
M1276   EQU     $1276
M127C   EQU     $127C
M1282   EQU     $1282
Z1291   EQU     $1291
Z1294   EQU     $1294
Z1297   EQU     $1297
Z129A   EQU     $129A
Z129D   EQU     $129D
Z12A0   EQU     $12A0
Z12A3   EQU     $12A3
Z12A6   EQU     $12A6
Z1FFD   EQU     $1FFD
Z2000   EQU     $2000
M2001   EQU     $2001
M4F27   EQU     $4F27
M8640   EQU     $8640
M8680   EQU     $8680
MA100   EQU     $A100
MC604   EQU     $C604
MC609   EQU     $C609
MC619   EQU     $C619
OSLOAD  EQU     $E800
CHKERR  EQU     $E853
READSC  EQU     $E869
READPS  EQU     $E86D
RESTOR  EQU     $E875
SEEK    EQU     $E878
WRVERF  EQU     $E881
LPINIT  EQU     $EBC0
LIST    EQU     $EBCC
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
MAIDs   EQU     $F0F3
ACIA_0  EQU     $FCF4
ACIA_1  EQU     $FCF5
PROM_0  EQU     $FCFC
PROM_1  EQU     $FCFD
XREGsP  EQU     $FF16
XREGsX  EQU     $FF18
XREGsS  EQU     $FF1D
BRKPTs  EQU     $FF1F
MFF2F   EQU     $FF2F
BKPINs  EQU     $FF4F
AECHO   EQU     $FF53
MFF63   EQU     $FF63
XSTAKs  EQU     $FF8A
MFF8D   EQU     $FF8D
MFF9C   EQU     $FF9C
MFF9E   EQU     $FF9E
MFFDD   EQU     $FFDD
MFFE3   EQU     $FFE3
IRQsVC  EQU     $FFF8
SWIsVC  EQU     $FFFA
NMIsVC  EQU     $FFFC

;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $0100

VERSss          FDB     $2033                    ; 0100: 20 33          
REVSss          FDB     $3035                    ; 0102: 30 35          
KYIsSV          FDB     $03A8                    ; 0104: 03 A8          
ENDOSs          FDB     $1FFF                    ; 0106: 1F FF          
ENDUSs          FDB     M0000                    ; 0108: 00 00           gets init to: $2001
ENDSYs          FDB     M0000                    ; 010A: 00 00           gets init to: $E7FF
M010C           FDB     M0000                    ; 010C: 00 00           gets init to: $00AE
RIBBAs          FDB     $018F                    ; 010E: 01 8F          
ENDRVs          FDB     $0020                    ; 0110: 00 20          
GDBAs           FDB     $065C                    ; 0112: 06 5C          
SYERRs          FDB     M0000                    ; 0114: 00 00          
SWIsSV          FDB     M0000                    ; 0116: 00 00           gets init to: $F477
SWIsUV          FDB     M0000                    ; 0118: 00 00           gets init to: $026B
IRQsUV          FDB     M0000                    ; 011A: 00 00           gets init to: $026B
IRQsSV          FDB     M0000                    ; 011C: 00 00          
CHFLGs          FDB     $8000                    ; 011E: 80 00           gets init to: $8000
SYIOCB          FCB     $00,$11,$00,$00          ; 0120: 00 11 00 00    
M0124           FCB     $00,$00                  ; 0124: 00 00          
M0126           FCB     $00,$00                  ; 0126: 00 00          
                FCB     $43,$4E                  ; 0128: 43 4E          
M012A           FCB     $30,$20,$20,$20,$20,$20  ; 012A: 30 20 20 20 20 20 
                FCB     $20,$20,$20,$20,$20      ; 0130: 20 20 20 20 20 
                FCB     $00,$00,$05,$00,$00,$00  ; 0135: 00 00 05 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 013B: 00 00 00 00 00 00 
                FCB     $00,$7F,$00,$00          ; 0141: 00 7F 00 00    
SYPOCB          FCB     $00,$12,$00,$00          ; 0145: 00 12 00 00    
M0149           FCB     $00,$00                  ; 0149: 00 00          
M014B           FCB     $00,$00                  ; 014B: 00 00          
                FCB     $4C,$50,$30,$20,$20,$20  ; 014D: 4C 50 30 20 20 20 
                FCB     $20,$20,$20,$20,$20,$20  ; 0153: 20 20 20 20 20 20 
                FCB     $20                      ; 0159: 20             
                FCB     $00,$00,$05,$00,$00,$00  ; 015A: 00 00 05 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 0160: 00 00 00 00 00 00 
                FCB     $00,$7F,$00,$00          ; 0166: 00 7F 00 00    
SYEOCB          FCB     $00,$11                  ; 016A: 00 11          
M016C           FCB     $00,$00                  ; 016C: 00 00          
M016E           FCB     $00,$00                  ; 016E: 00 00          
M0170           FCB     $00,$00                  ; 0170: 00 00          
                FCB     $44,$4B,$30,$4D,$44,$4F  ; 0172: 44 4B 30 4D 44 4F 
                FCB     $53,$45,$52              ; 0178: 53 45 52       
M017B           FCB     $20,$20,$53,$59          ; 017B: 20 20 53 59    
                FCB     $00,$00,$05,$00,$00,$00  ; 017F: 00 00 05 00 00 00 
                FCB     $00,$00                  ; 0185: 00 00          
M0187           FCB     $00,$00,$01,$8F,$02,$0E  ; 0187: 00 00 01 8F 02 0E 
                FCB     $00,$00,$00,$00,$00,$00  ; 018D: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 0193: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 0199: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 019F: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 01A5: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 01AB: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 01B1: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 01B7: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 01BD: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 01C3: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 01C9: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 01CF: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 01D5: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 01DB: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 01E1: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 01E7: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 01ED: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 01F3: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 01F9: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 01FF: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 0205: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00          ; 020B: 00 00 00 00    
M020F           FCB     $7D                      ; 020F: 7D             
                STX     M4F27                    ; 0210: FF 4F 27       
                ABA                              ; 0213: 1B             
                TSX                              ; 0214: 30             
                LDAA    $05,X                    ; 0215: A6 05          
                LDAB    $06,X                    ; 0217: E6 06          
                DECD                             ; 0219: C0 01 82 00    
                LDX     #BRKPTs                  ; 021D: CE FF 1F       
Z0220           CMPA    ,X                       ; 0220: A1 00          
                BNE     Z0228                    ; 0222: 26 04          
                CMPB    $01,X                    ; 0224: E1 01          
                BEQ     Z0274                    ; 0226: 27 4C          
Z0228           INX                              ; 0228: 08             
                INX                              ; 0229: 08             
                CPX     #MFF2F                   ; 022A: 8C FF 2F       
                BNE     Z0220                    ; 022D: 26 F1          
M022F           TSX                              ; 022F: 30             
                LDS     $05,X                    ; 0230: AE 05          
                DES                              ; 0232: 34             
                PULB                             ; 0233: 33             
                INS                              ; 0234: 31             
                STS     $05,X                    ; 0235: AF 05          
                TXS                              ; 0237: 35             
                LDAA    ,X                       ; 0238: A6 00          
                TAP                              ; 023A: 06             
                ASLB                             ; 023B: 58             
                BCS     Z0279                    ; 023C: 25 3B          
                CMPB    #$80                     ; 023E: C1 80          
                BCC     Z026C                    ; 0240: 24 2A          
                STAB    M0249                    ; 0242: F7 02 49       
                LDX     #M027F                   ; 0245: CE 02 7F       
                LDX     ,X                       ; 0248: EE 00          
                STX     M025A                    ; 024A: FF 02 5A       
                TSX                              ; 024D: 30             
                LDAA    $02,X                    ; 024E: A6 02          
                PSHA                             ; 0250: 36             
                LDAA    ,X                       ; 0251: A6 00          
                LDAB    $01,X                    ; 0253: E6 01          
                LDX     $03,X                    ; 0255: EE 03          
                TAP                              ; 0257: 06             
                PULA                             ; 0258: 32             
Z0259           JSR     Z0259                    ; 0259: BD 02 59       
                TSX                              ; 025C: 30             
                PSHA                             ; 025D: 36             
                TPA                              ; 025E: 07             
                STAB    $01,X                    ; 025F: E7 01          
                PULB                             ; 0261: 33             
                STAB    $02,X                    ; 0262: E7 02          
                PULB                             ; 0264: 33             
                ANDB    #$10                     ; 0265: C4 10          
                ANDA    #$EF                     ; 0267: 84 EF          
                ABA                              ; 0269: 1B             
                PSHA                             ; 026A: 36             
ISR_UNUSD       RTI                              ; 026B: 3B             
Z026C           LDAB    #$21                     ; 026C: C6 21          
                JSR     Z0F31                    ; 026E: BD 0F 31       
                JMP     Z0617                    ; 0271: 7E 06 17       
Z0274           LDX     SWIsSV                   ; 0274: FE 01 16       
                JMP     ,X                       ; 0277: 6E 00          
Z0279           ASRB                             ; 0279: 57             
                LDX     SWIsUV                   ; 027A: FE 01 18       
                JMP     ,X                       ; 027D: 6E 00          
M027F           FCB     $12                      ; 027F: 12             
                CLR     M1282                    ; 0280: 7F 12 82       
                FCB     $1C                      ; 0283: 1C             
                SEC                              ; 0284: 0D             
                FCB     $18                      ; 0285: 18             
                FCB     $A3                      ; 0286: A3             
                FCB     $18                      ; 0287: 18             
                FCB     $9D                      ; 0288: 9D             
                FCB     $12                      ; 0289: 12             
                BITA    #$18                     ; 028A: 85 18          
                LDAA    $07,X                    ; 028C: A6 07          
                FCB     $1F                      ; 028E: 1F             
                TPA                              ; 028F: 07             
                BHI     Z0295                    ; 0290: 22 03          
                EORA    $04,X                    ; 0292: A8 04          
                TBA                              ; 0294: 17             
Z0295           FCB     $04                      ; 0295: 04             
                FCB     $1A                      ; 0296: 1A             
                FCB     $04                      ; 0297: 04             
                SEC                              ; 0298: 0D             
                FCB     $03                      ; 0299: 03             
                ADCB    M0005                    ; 029A: D9 05          
                BEQ     Z02A3                    ; 029C: 27 05          
                PSHA                             ; 029E: 36             
                FCB     $03                      ; 029F: 03             
                BLT     Z02A5                    ; 02A0: 2D 03          
                RTS                              ; 02A2: 39             
Z02A3           FCB     $03                      ; 02A3: 03             
                FCB     $62                      ; 02A4: 62             
Z02A5           FCB     $03                      ; 02A5: 03             
                LSR     $03,X                    ; 02A6: 64 03          
                FCB     $6B                      ; 02A8: 6B             
                FCB     $03                      ; 02A9: 03             
                LSR     M0381                    ; 02AA: 74 03 81       
                FCB     $03                      ; 02AD: 03             
                ORAA    #$03                     ; 02AE: 8A 03          
                ANDA    M0003                    ; 02B0: 94 03          
                LDS     M0006                    ; 02B2: 9E 06          
                BLS     Z02C2                    ; 02B4: 23 0C          
                BVC     Z02C1                    ; 02B6: 28 09          
                FCB     $C7                      ; 02B8: C7             
                FCB     $12                      ; 02B9: 12             
                ROL     M127C                    ; 02BA: 79 12 7C       
                FCB     $18                      ; 02BD: 18             
                ADCA    $0F,X                    ; 02BE: A9 0F          
                INS                              ; 02C0: 31             
Z02C1           FCB     $12                      ; 02C1: 12             
Z02C2           COM     M1276                    ; 02C2: 73 12 76       
                TAP                              ; 02C5: 06             
                DEX                              ; 02C6: 09             
                FCB     $04                      ; 02C7: 04             
                FCB     $61                      ; 02C8: 61             
                FCB     $04                      ; 02C9: 04             
                FCB     $71                      ; 02CA: 71             
                FCB     $04                      ; 02CB: 04             
                ASR     M0489                    ; 02CC: 77 04 89       
                FCB     $04                      ; 02CF: 04             
                ORAA    #$04                     ; 02D0: 8A 04          
                ADDA    #$04                     ; 02D2: 8B 04          
                ANDA    M0004                    ; 02D4: 94 04          
                STAA    $04,X                    ; 02D6: A7 04          
                EORA    $04,X                    ; 02D8: A8 04          
                ADCA    $04,X                    ; 02DA: A9 04          
                ADCA    M04C6                    ; 02DC: B9 04 C6       
                FCB     $04                      ; 02DF: 04             
                ORAB    M0004                    ; 02E0: DA 04          
                SUBB    $04,X                    ; 02E2: E0 04          
                LDAB    $05,X                    ; 02E4: E6 05          
                TAP                              ; 02E6: 06             
                FCB     $04                      ; 02E7: 04             
                RORA                             ; 02E8: 46             
                FCB     $04                      ; 02E9: 04             
                ROLA                             ; 02EA: 49             
                FCB     $18                      ; 02EB: 18             
                SUBA    $12,X                    ; 02EC: A0 12          
                EORA    #$12                     ; 02EE: 88 12          
                ADDA    #$05                     ; 02F0: 8B 05          
                BCC     Z02F9                    ; 02F2: 24 05          
                PULB                             ; 02F4: 33             
                FCB     $05                      ; 02F5: 05             
                FCB     $21                      ; 02F6: 21             
                FCB     $05                      ; 02F7: 05             
                TSX                              ; 02F8: 30             
Z02F9           FCB     $05                      ; 02F9: 05             
                FCB     $1E                      ; 02FA: 1E             
                FCB     $05                      ; 02FB: 05             
                BLT     Z0304                    ; 02FC: 2D 06          
                TBA                              ; 02FE: 17             
                TST     PROM_1                   ; 02FF: 7D FC FD       
                BPL     Z030A                    ; 0302: 2A 06          
Z0304           PULA                             ; 0304: 32             
                PSHA                             ; 0305: 36             
                BITA    #$10                     ; 0306: 85 10          
                BEQ     Z0328                    ; 0308: 27 1E          
Z030A           LDAB    #$0F                     ; 030A: C6 0F          
                LDAA    #$02                     ; 030C: 86 02          
                TST     BKPINs                   ; 030E: 7D FF 4F       
                BNE     Z0317                    ; 0311: 26 04          
                LDAB    #$2F                     ; 0313: C6 2F          
                LDAA    #$02                     ; 0315: 86 02          
Z0317           PSHB                             ; 0317: 37             
                PSHA                             ; 0318: 36             
                TSX                              ; 0319: 30             
                LDAB    #$05                     ; 031A: C6 05          
Z031C           LDAA    $06,X                    ; 031C: A6 06          
                PSHA                             ; 031E: 36             
                DEX                              ; 031F: 09             
                DECB                             ; 0320: 5A             
                BNE     Z031C                    ; 0321: 26 F9          
                LDX     NMIsVC                   ; 0323: FE FF FC       
                JMP     ,X                       ; 0326: 6E 00          
Z0328           LDX     IRQsUV                   ; 0328: FE 01 1A       
                JMP     ,X                       ; 032B: 6E 00          
Z032D           BSR     Z0347                    ; 032D: 8D 18          
                LDX     $02,X                    ; 032F: EE 02          
                STAA    ,X                       ; 0331: A7 00          
                BSR     Z0358                    ; 0333: 8D 23          
                DECB                             ; 0335: 5A             
                BNE     Z032D                    ; 0336: 26 F5          
                RTS                              ; 0338: 39             
Z0339           BSR     Z0347                    ; 0339: 8D 0C          
                LDX     $02,X                    ; 033B: EE 02          
                CMPA    ,X                       ; 033D: A1 00          
                BNE     Z0346                    ; 033F: 26 05          
                BSR     Z0358                    ; 0341: 8D 15          
                DECB                             ; 0343: 5A             
                BNE     Z0339                    ; 0344: 26 F3          
Z0346           RTS                              ; 0346: 39             
Z0347           TSX                              ; 0347: 30             
                LDX     $07,X                    ; 0348: EE 07          
                LDX     ,X                       ; 034A: EE 00          
                LDAA    ,X                       ; 034C: A6 00          
                TSX                              ; 034E: 30             
                LDX     $07,X                    ; 034F: EE 07          
                INC     $01,X                    ; 0351: 6C 01          
                BNE     Z0357                    ; 0353: 26 02          
                INC     ,X                       ; 0355: 6C 00          
Z0357           RTS                              ; 0357: 39             
Z0358           TSX                              ; 0358: 30             
                LDX     $07,X                    ; 0359: EE 07          
                INC     $03,X                    ; 035B: 6C 03          
                BNE     Z0361                    ; 035D: 26 02          
                INC     $02,X                    ; 035F: 6C 02          
Z0361           RTS                              ; 0361: 39             
                LDAA    #$20                     ; 0362: 86 20          
Z0364           STAA    ,X                       ; 0364: A7 00          
                INX                              ; 0366: 08             
                DECB                             ; 0367: 5A             
                BNE     Z0364                    ; 0368: 26 FA          
                RTS                              ; 036A: 39             
                CMPA    #$41                     ; 036B: 81 41          
                BCS     Z0373                    ; 036D: 25 04          
                PSHA                             ; 036F: 36             
                ADDA    #$A5                     ; 0370: 8B A5          
                PULA                             ; 0372: 32             
Z0373           RTS                              ; 0373: 39             
                CMPA    #$30                     ; 0374: 81 30          
                BCS     Z0380                    ; 0376: 25 08          
                PSHA                             ; 0378: 36             
                ADDA    #$C6                     ; 0379: 8B C6          
                PULA                             ; 037B: 32             
                BCS     Z0380                    ; 037C: 25 02          
                ANDA    #$0F                     ; 037E: 84 0F          
Z0380           RTS                              ; 0380: 39             
M0381           ADDA    $01,X                    ; 0381: AB 01          
                STAA    $01,X                    ; 0383: A7 01          
                BCC     Z0389                    ; 0385: 24 02          
                INC     ,X                       ; 0387: 6C 00          
Z0389           RTS                              ; 0389: 39             
Z038A           NEGA                             ; 038A: 40             
                ADDA    $01,X                    ; 038B: AB 01          
                STAA    $01,X                    ; 038D: A7 01          
                BCS     Z0393                    ; 038F: 25 02          
                DEC     ,X                       ; 0391: 6A 00          
Z0393           RTS                              ; 0393: 39             
                PSHA                             ; 0394: 36             
Z0395           ASL     $01,X                    ; 0395: 68 01          
                ROL     ,X                       ; 0397: 69 00          
                DECA                             ; 0399: 4A             
                BNE     Z0395                    ; 039A: 26 F9          
                PULA                             ; 039C: 32             
                RTS                              ; 039D: 39             
                PSHA                             ; 039E: 36             
Z039F           LSR     ,X                       ; 039F: 64 00          
                ROR     $01,X                    ; 03A1: 66 01          
                DECA                             ; 03A3: 4A             
                BNE     Z039F                    ; 03A4: 26 F9          
                PULA                             ; 03A6: 32             
                RTS                              ; 03A7: 39             
                STX     M0124                    ; 03A8: FF 01 24       
                CPX     #M00AE                   ; 03AB: 8C 00 AE       
                BNE     Z03B6                    ; 03AE: 26 06          
                CMPB    #$50                     ; 03B0: C1 50          
                BMI     Z03B6                    ; 03B2: 2B 02          
                LDAB    #$4F                     ; 03B4: C6 4F          
Z03B6           SWI                              ; 03B6: 3F             
                BEQ     Z03B8                    ; 03B7: 27 FF          
                NOP                              ; 03B9: 01             
                BNE     Z038A                    ; 03BA: 26 CE          
                NOP                              ; 03BC: 01             
                BRA     Z03FE                    ; 03BD: 20 3F          
                FCB     $04                      ; 03BF: 04             
                BCS     Z03CF                    ; 03C0: 25 0D          
Z03C2           LDAA    $03,X                    ; 03C2: A6 03          
                LDAB    $02,X                    ; 03C4: E6 02          
                LDX     $04,X                    ; 03C6: EE 04          
                SWI                              ; 03C8: 3F             
                BGT     Z03E1                    ; 03C9: 2E 16          
                BEQ     Z03CD                    ; 03CB: 27 00          
Z03CD           CLC                              ; 03CD: 0C             
                RTS                              ; 03CE: 39             
Z03CF           CMPB    #$0D                     ; 03CF: C1 0D          
                BEQ     Z03C2                    ; 03D1: 27 EF          
Z03D3           LDAB    #$00                     ; 03D3: C6 00          
                SWI                              ; 03D5: 3F             
                BRA     Z0417                    ; 03D6: 20 3F          
                FCB     $1A                      ; 03D8: 1A             
                PSHA                             ; 03D9: 36             
Z03DA           CLC                              ; 03DA: 0C             
                LDAA    ACIA_0                   ; 03DB: B6 FC F4       
                BITA    #$10                     ; 03DE: 85 10          
                BEQ     Z03E7                    ; 03E0: 27 05          
                BSR     Z03F6                    ; 03E2: 8D 12          
                SEC                              ; 03E4: 0D             
Z03E5           PULA                             ; 03E5: 32             
                RTS                              ; 03E6: 39             
Z03E7           BITA    #$01                     ; 03E7: 85 01          
                BEQ     Z03E5                    ; 03E9: 27 FA          
Z03EB           LDAA    ACIA_1                   ; 03EB: B6 FC F5       
                ANDA    #$7F                     ; 03EE: 84 7F          
                CMPA    #$17                     ; 03F0: 81 17          
                BEQ     Z03EB                    ; 03F2: 27 F7          
                BRA     Z03DA                    ; 03F4: 20 E4          
Z03F6           BSR     Z0405                    ; 03F6: 8D 0D          
                BSR     Z0401                    ; 03F8: 8D 07          
                LDAA    ACIA_1                   ; 03FA: B6 FC F5       
                LDAA    ACIA_1                   ; 03FD: B6 FC F5       
                RTS                              ; 0400: 39             
Z0401           CLRA                             ; 0401: 4F             
                JSR     XOUTCH                   ; 0402: BD F0 18       
Z0405           LDAA    ACIA_0                   ; 0405: B6 FC F4       
                BITA    #$02                     ; 0408: 85 02          
                BEQ     Z0405                    ; 040A: 27 F9          
                RTS                              ; 040C: 39             
                LDAB    M012A                    ; 040D: F6 01 2A       
                ANDB    #$DF                     ; 0410: C4 DF          
                STAB    M012A                    ; 0412: F7 01 2A       
                BRA     Z041A                    ; 0415: 20 03          
Z0417           LDAB    #$0D                     ; 0417: C6 0D          
                CPX     #MC604                   ; 0419: 8C C6 04       
                STX     M0124                    ; 041C: FF 01 24       
                DEX                              ; 041F: 09             
Z0420           INX                              ; 0420: 08             
                CMPB    ,X                       ; 0421: E1 00          
                BNE     Z0420                    ; 0423: 26 FB          
                STX     M0126                    ; 0425: FF 01 26       
                LDX     #SYIOCB                  ; 0428: CE 01 20       
                SWI                              ; 042B: 3F             
                FCB     $05                      ; 042C: 05             
                BCC     Z0432                    ; 042D: 24 03          
                JMP     Z03D3                    ; 042F: 7E 03 D3       
Z0432           LDAB    $0A,X                    ; 0432: E6 0A          
                ORAB    #$20                     ; 0434: CA 20          
                STAB    $0A,X                    ; 0436: E7 0A          
Z0438           LDAB    $06,X                    ; 0438: E6 06          
                LDAA    $07,X                    ; 043A: A6 07          
                TSX                              ; 043C: 30             
                STAB    $05,X                    ; 043D: E7 05          
                STAA    $06,X                    ; 043F: A7 06          
                LDAB    $03,X                    ; 0441: E6 03          
                LDAA    $04,X                    ; 0443: A6 04          
                RTS                              ; 0445: 39             
                LDAB    #$0D                     ; 0446: C6 0D          
                CPX     #MC604                   ; 0448: 8C C6 04       
                STX     M0149                    ; 044B: FF 01 49       
                DEX                              ; 044E: 09             
Z044F           INX                              ; 044F: 08             
                CMPB    ,X                       ; 0450: E1 00          
                BNE     Z044F                    ; 0452: 26 FB          
                STX     M014B                    ; 0454: FF 01 4B       
                LDX     #SYPOCB                  ; 0457: CE 01 45       
                SWI                              ; 045A: 3F             
                FCB     $05                      ; 045B: 05             
                BCC     Z0438                    ; 045C: 24 DA          
                JMP     Z03D3                    ; 045E: 7E 03 D3       
                TSX                              ; 0461: 30             
                LDAA    $06,X                    ; 0462: A6 06          
                LDAB    $05,X                    ; 0464: E6 05          
                RTS                              ; 0466: 39             
                STX     M010C                    ; 0467: FF 01 0C       
                LDAB    M010C                    ; 046A: F6 01 0C       
                LDAA    M010D                    ; 046D: B6 01 0D       
                RTS                              ; 0470: 39             
                TSX                              ; 0471: 30             
                STAA    $06,X                    ; 0472: A7 06          
                STAB    $05,X                    ; 0474: E7 05          
                RTS                              ; 0476: 39             
                TSX                              ; 0477: 30             
                LDAB    $06,X                    ; 0478: E6 06          
                STAA    $06,X                    ; 047A: A7 06          
                STAB    $04,X                    ; 047C: E7 04          
                LDAB    $03,X                    ; 047E: E6 03          
                LDAA    $05,X                    ; 0480: A6 05          
                STAB    $05,X                    ; 0482: E7 05          
                STAA    $03,X                    ; 0484: A7 03          
                JMP     Z04FC                    ; 0486: 7E 04 FC       
M0489           TBA                              ; 0489: 17             
                CLRB                             ; 048A: 5F             
                TSX                              ; 048B: 30             
                BSR     Z0495                    ; 048C: 8D 07          
                STAA    $06,X                    ; 048E: A7 06          
                STAB    $05,X                    ; 0490: E7 05          
                BRA     Z04FC                    ; 0492: 20 68          
                TSX                              ; 0494: 30             
Z0495           ADDA    $06,X                    ; 0495: AB 06          
                PSHA                             ; 0497: 36             
                TPA                              ; 0498: 07             
                ORAA    #$FB                     ; 0499: 8A FB          
                STAA    $02,X                    ; 049B: A7 02          
                ADCB    $05,X                    ; 049D: E9 05          
Z049F           TPA                              ; 049F: 07             
                ANDA    $02,X                    ; 04A0: A4 02          
                STAA    $02,X                    ; 04A2: A7 02          
                TAP                              ; 04A4: 06             
                PULA                             ; 04A5: 32             
                RTS                              ; 04A6: 39             
                TBA                              ; 04A7: 17             
                CLRB                             ; 04A8: 5F             
                SWI                              ; 04A9: 3F             
                BNE     Z04EB                    ; 04AA: 26 3F          
                BGT     Z04DE                    ; 04AC: 2E 30          
                PSHA                             ; 04AE: 36             
                TPA                              ; 04AF: 07             
                STAA    $02,X                    ; 04B0: A7 02          
                PULA                             ; 04B2: 32             
                STAA    $06,X                    ; 04B3: A7 06          
                STAB    $05,X                    ; 04B5: E7 05          
                BRA     Z04FC                    ; 04B7: 20 43          
                TSX                              ; 04B9: 30             
                SUBA    $06,X                    ; 04BA: A0 06          
                PSHA                             ; 04BC: 36             
                TPA                              ; 04BD: 07             
                ORAA    #$FB                     ; 04BE: 8A FB          
                STAA    $02,X                    ; 04C0: A7 02          
                SBCB    $05,X                    ; 04C2: E2 05          
                BRA     Z049F                    ; 04C4: 20 D9          
M04C6           TSX                              ; 04C6: 30             
                CMPB    $05,X                    ; 04C7: E1 05          
                BNE     Z04CD                    ; 04C9: 26 02          
                CMPA    $06,X                    ; 04CB: A1 06          
Z04CD           RTS                              ; 04CD: 39             
                STX     M010C                    ; 04CE: FF 01 0C       
                CMPB    M010C                    ; 04D1: F1 01 0C       
                BNE     Z04D9                    ; 04D4: 26 03          
                CMPA    M010D                    ; 04D6: B1 01 0D       
Z04D9           RTS                              ; 04D9: 39             
                TSX                              ; 04DA: 30             
                ASR     $05,X                    ; 04DB: 67 05          
                ROR     $06,X                    ; 04DD: 66 06          
                RTS                              ; 04DF: 39             
                TSX                              ; 04E0: 30             
                ASL     $06,X                    ; 04E1: 68 06          
                ROL     $05,X                    ; 04E3: 69 05          
                RTS                              ; 04E5: 39             
                LDAA    #$09                     ; 04E6: 86 09          
                DES                              ; 04E8: 34             
                DES                              ; 04E9: 34             
                TSX                              ; 04EA: 30             
Z04EB           LDAB    $02,X                    ; 04EB: E6 02          
                STAB    ,X                       ; 04ED: E7 00          
                INX                              ; 04EF: 08             
                DECA                             ; 04F0: 4A             
                BNE     Z04EB                    ; 04F1: 26 F8          
                TSX                              ; 04F3: 30             
                LDAB    $05,X                    ; 04F4: E6 05          
                LDAA    $06,X                    ; 04F6: A6 06          
                STAA    $0A,X                    ; 04F8: A7 0A          
                STAB    $09,X                    ; 04FA: E7 09          
Z04FC           LDAA    $04,X                    ; 04FC: A6 04          
                LDAB    $03,X                    ; 04FE: E6 03          
                PSHA                             ; 0500: 36             
                LDAA    $02,X                    ; 0501: A6 02          
                TAP                              ; 0503: 06             
                PULA                             ; 0504: 32             
                RTS                              ; 0505: 39             
                TSX                              ; 0506: 30             
                LDAA    $0A,X                    ; 0507: A6 0A          
                LDAB    $09,X                    ; 0509: E6 09          
                STAA    $06,X                    ; 050B: A7 06          
                STAB    $05,X                    ; 050D: E7 05          
                LDAA    #$09                     ; 050F: 86 09          
Z0511           LDAB    $08,X                    ; 0511: E6 08          
                STAB    $0A,X                    ; 0513: E7 0A          
                DEX                              ; 0515: 09             
                DECA                             ; 0516: 4A             
                BNE     Z0511                    ; 0517: 26 F8          
                INS                              ; 0519: 31             
                INS                              ; 051A: 31             
                TSX                              ; 051B: 30             
                BRA     Z04FC                    ; 051C: 20 DE          
                LDAA    #$C0                     ; 051E: 86 C0          
                CPX     #M8640                   ; 0520: 8C 86 40       
                CPX     #M8680                   ; 0523: 8C 86 80       
                BITA    #$4F                     ; 0526: 85 4F          
                LDX     #READSC                  ; 0528: CE E8 69       
                BRA     Z053A                    ; 052B: 20 0D          
                LDAA    #$C0                     ; 052D: 86 C0          
                CPX     #M8640                   ; 052F: 8C 86 40       
                CPX     #M8680                   ; 0532: 8C 86 80       
                BITA    #$4F                     ; 0535: 85 4F          
                LDX     #WRVERF                  ; 0537: CE E8 81       
Z053A           STX     M0563                    ; 053A: FF 05 63       
                ANDB    #$03                     ; 053D: C4 03          
                STAB    M0000                    ; 053F: D7 00          
                LDX     #M0001                   ; 0541: CE 00 01       
                BITA    #$40                     ; 0544: 85 40          
                BEQ     Z054D                    ; 0546: 27 05          
                TSX                              ; 0548: 30             
                LDX     $05,X                    ; 0549: EE 05          
                LDX     $05,X                    ; 054B: EE 05          
Z054D           STX     M0003                    ; 054D: DF 03          
                LDAB    #$03                     ; 054F: C6 03          
                PSHA                             ; 0551: 36             
                PSHB                             ; 0552: 37             
Z0553           TSX                              ; 0553: 30             
                LDX     $07,X                    ; 0554: EE 07          
                LDAB    $01,X                    ; 0556: E6 01          
                LDAA    $02,X                    ; 0558: A6 02          
                LDX     $03,X                    ; 055A: EE 03          
                STX     M0006                    ; 055C: DF 06          
                STAB    M0001                    ; 055E: D7 01          
                STAA    M0002                    ; 0560: 97 02          
                JSR     >M0000                   ; 0562: BD 00 00       
                BCC     Z057A                    ; 0565: 24 13          
                LDAA    M0008                    ; 0567: 96 08          
                CMPA    #$31                     ; 0569: 81 31          
                BEQ     Z05C1                    ; 056B: 27 54          
                CMPA    #$34                     ; 056D: 81 34          
                BEQ     Z05C1                    ; 056F: 27 50          
                CMPA    #$38                     ; 0571: 81 38          
                BEQ     Z05C1                    ; 0573: 27 4C          
                CMPA    #$39                     ; 0575: 81 39          
                BEQ     Z05C1                    ; 0577: 27 48          
Z0579           SEC                              ; 0579: 0D             
Z057A           PULB                             ; 057A: 33             
                PULA                             ; 057B: 32             
                TSX                              ; 057C: 30             
                LDX     $05,X                    ; 057D: EE 05          
                LDAB    M0008                    ; 057F: D6 08          
                STAB    ,X                       ; 0581: E7 00          
                BCC     Z05AB                    ; 0583: 24 26          
                PSHA                             ; 0585: 36             
                TPA                              ; 0586: 07             
                PSHA                             ; 0587: 36             
                CMPB    #$33                     ; 0588: C1 33          
                BEQ     Z05A4                    ; 058A: 27 18          
                CMPB    #$36                     ; 058C: C1 36          
                BEQ     Z05A4                    ; 058E: 27 14          
                LDAB    M0001                    ; 0590: D6 01          
                LDAA    M0002                    ; 0592: 96 02          
                ADDA    M0004                    ; 0594: 9B 04          
                ADCB    M0003                    ; 0596: D9 03          
                SUBA    M000C                    ; 0598: 90 0C          
                SBCB    M000B                    ; 059A: D2 0B          
                SUBA    #$01                     ; 059C: 80 01          
                SBCB    #$00                     ; 059E: C2 00          
                STAA    M0002                    ; 05A0: 97 02          
                STAB    M0001                    ; 05A2: D7 01          
Z05A4           PULA                             ; 05A4: 32             
                TAP                              ; 05A5: 06             
                PULA                             ; 05A6: 32             
                BITA    #$80                     ; 05A7: 85 80          
                BEQ     Z05AC                    ; 05A9: 27 01          
Z05AB           RTS                              ; 05AB: 39             
Z05AC           TSX                              ; 05AC: 30             
                LDAA    $08,X                    ; 05AD: A6 08          
                LDAB    $07,X                    ; 05AF: E6 07          
                SUBA    #$02                     ; 05B1: 80 02          
                SBCB    #$00                     ; 05B3: C2 00          
                LDX     $05,X                    ; 05B5: EE 05          
                STAA    $02,X                    ; 05B7: A7 02          
                STAB    $01,X                    ; 05B9: E7 01          
                LDAB    #$01                     ; 05BB: C6 01          
                SWI                              ; 05BD: 3F             
                BRA     Z05FF                    ; 05BE: 20 3F          
                FCB     $1A                      ; 05C0: 1A             
Z05C1           TSX                              ; 05C1: 30             
                DEC     ,X                       ; 05C2: 6A 00          
                BEQ     Z0579                    ; 05C4: 27 B3          
                LDAB    ,X                       ; 05C6: E6 00          
                LDX     #M0082                   ; 05C8: CE 00 82       
                TST     M000D                    ; 05CB: 7D 00 0D       
                BMI     Z05D3                    ; 05CE: 2B 03          
                LDX     #KYIsSV                  ; 05D0: CE 01 04       
Z05D3           CMPB    #$02                     ; 05D3: C1 02          
                BNE     Z05F0                    ; 05D5: 26 19          
                LDAB    M0001                    ; 05D7: D6 01          
                LDAA    M0002                    ; 05D9: 96 02          
                SWI                              ; 05DB: 3F             
                BGT     Z0637                    ; 05DC: 2E 59          
                BCC     Z05E5                    ; 05DE: 24 05          
                JSR     RESTOR                   ; 05E0: BD E8 75       
                BRA     Z05ED                    ; 05E3: 20 08          
Z05E5           RORB                             ; 05E5: 56             
                STAB    M0001                    ; 05E6: D7 01          
                STAA    M0002                    ; 05E8: 97 02          
                JSR     SEEK                     ; 05EA: BD E8 78       
Z05ED           JMP     Z0553                    ; 05ED: 7E 05 53       
Z05F0           LDAB    M0001                    ; 05F0: D6 01          
                LDAA    M0002                    ; 05F2: 96 02          
                SWI                              ; 05F4: 3F             
                BPL     Z05C5                    ; 05F5: 2A CE          
                TPA                              ; 05F7: 07             
                CMPB    M007D                    ; 05F8: D1 7D          
                FCB     $00                      ; 05FA: 00             
                SEC                              ; 05FB: 0D             
                BMI     Z0601                    ; 05FC: 2B 03          
                LDX     #M0FA5                   ; 05FE: CE 0F A5       
Z0601           SWI                              ; 0601: 3F             
                BLE     Z0629                    ; 0602: 2F 25          
                CMPB    $3F,X                    ; 0604: E1 3F          
                BCC     Z0628                    ; 0606: 24 20          
                FCB     $DD                      ; 0608: DD             
                STAB    M0115                    ; 0609: F7 01 15       
                PSHA                             ; 060C: 36             
                LDAA    SYERRs                   ; 060D: B6 01 14       
                ORAA    #$80                     ; 0610: 8A 80          
                STAA    SYERRs                   ; 0612: B7 01 14       
                PULA                             ; 0615: 32             
                RTS                              ; 0616: 39             
Z0617           LDX     SWIsSV                   ; 0617: FE 01 16       
                STX     SWIsVC                   ; 061A: FF FF FA       
                LDS     #XSTAKs                  ; 061D: 8E FF 8A       
                JMP     OSLOAD                   ; 0620: 7E E8 00       
SYSSTART        LDX     SWIsVC                   ; 0623: FE FF FA        Entry Point after floppy-boot
                CPX     #M022F                   ; 0626: 8C 02 2F       
Z0629           BEQ     Z0636                    ; 0629: 27 0B          
                CPX     #M020F                   ; 062B: 8C 02 0F       
                BEQ     Z0636                    ; 062E: 27 06          
                LDS     #XSTAKs                  ; 0630: 8E FF 8A       
                JSR     Z2000                    ; 0633: BD 20 00       
Z0636           LDS     ENDSYs                   ; 0636: BE 01 0A       
                LDX     #ISR_UNUSD               ; 0639: CE 02 6B       
                STX     SWIsUV                   ; 063C: FF 01 18       
                STX     IRQsUV                   ; 063F: FF 01 1A       
                LDAA    CHFLGs                   ; 0642: B6 01 1E       
                ORAA    #$80                     ; 0645: 8A 80          
                STAA    CHFLGs                   ; 0647: B7 01 1E       
                LDX     #M2001                   ; 064A: CE 20 01       
                STX     ENDUSs                   ; 064D: FF 01 08       
                CLR     M0000                    ; 0650: 7F 00 00       
                JSR     RESTOR                   ; 0653: BD E8 75       
                JSR     CHKERR                   ; 0656: BD E8 53       
                JMP     Z1FFD                    ; 0659: 7E 1F FD        Continue in mdosov6
                FCB     $44,$4B                  ; 065C: 44 4B          
                FCB     $06                      ; 065E: 06             
                FCB     $72,$4C,$50              ; 065F: 72 4C 50       
                FCB     $06,$7F                  ; 0662: 06 7F          
                FCB     $43,$52                  ; 0664: 43 52          
                FCB     $06,$8C                  ; 0666: 06 8C          
                FCB     $43,$50                  ; 0668: 43 50          
                FCB     $06,$99                  ; 066A: 06 99          
                FCB     $43,$4E                  ; 066C: 43 4E          
                FCB     $06,$A6,$00,$00,$01,$00  ; 066E: 06 A6 00 00 01 00 
                FCB     $00,$06,$B3,$00,$00      ; 0674: 00 06 B3 00 00 
                FCB     $72                      ; 0679: 72             
                FCB     $04,$00,$03,$00,$00,$01  ; 067A: 04 00 03 00 00 01 
                FCB     $00,$00,$09,$9E,$00,$00  ; 0680: 00 00 09 9E 00 00 
                FCB     $C1,$80,$00,$00,$00,$00  ; 0686: C1 80 00 00 00 00 
                FCB     $01,$00,$00,$09,$80,$00  ; 068C: 01 00 00 09 80 00 
                FCB     $00                      ; 0692: 00             
                FCB     $31                      ; 0693: 31             
                FCB     $80,$00,$00,$00,$00,$01  ; 0694: 80 00 00 00 00 01 
                FCB     $00,$00,$09,$8F,$00,$00  ; 069A: 00 00 09 8F 00 00 
                FCB     $51                      ; 06A0: 51             
                FCB     $80,$00,$00,$00,$00,$01  ; 06A1: 80 00 00 00 00 01 
                FCB     $00,$00,$09              ; 06A7: 00 00 09       
                FCB     $53                      ; 06AA: 53             
                FCB     $00,$00                  ; 06AB: 00 00          
                FCB     $65                      ; 06AD: 65             
                FCB     $80,$00,$00,$00,$00,$0C  ; 06AE: 80 00 00 00 00 0C 
                FCB     $20,$62                  ; 06B4: 20 62          
                FCB     $0C                      ; 06B6: 0C             
                FCB     $20,$5F                  ; 06B7: 20 5F          
                FCB     $0C                      ; 06B9: 0C             
                FCB     $20,$5C                  ; 06BA: 20 5C          
                FCB     $0C                      ; 06BC: 0C             
                FCB     $20,$59,$30              ; 06BD: 20 59 30       
                FCB     $EE,$00,$EE,$00,$EE,$00  ; 06C0: EE 00 EE 00 EE 00 
                FCB     $FF,$09                  ; 06C6: FF 09          
                FCB     $4F                      ; 06C8: 4F             
                FCB     $A6,$01,$B7,$09          ; 06C9: A6 01 B7 09    
                FCB     $51,$2A,$21              ; 06CD: 51 2A 21       
                FCB     $A6,$1E,$AA,$1D          ; 06D0: A6 1E AA 1D    
                FCB     $27                      ; 06D4: 27             
                FCB     $0A,$A6                  ; 06D5: 0A A6          
                FCB     $24                      ; 06D7: 24             
                FCB     $E6                      ; 06D8: E6             
                FCB     $23                      ; 06D9: 23             
                FCB     $A1,$1E,$E2,$1D          ; 06DA: A1 1E E2 1D    
                FCB     $24                      ; 06DE: 24             
                FCB     $04,$8D,$7F              ; 06DF: 04 8D 7F       
                FCB     $25,$34,$6C              ; 06E2: 25 34 6C       
                FCB     $1E,$26,$02              ; 06E5: 1E 26 02       
                FCB     $6C                      ; 06E8: 6C             
                FCB     $1D,$EE,$1D,$09,$E6,$00  ; 06E9: 1D EE 1D 09 E6 00 
                FCB     $20,$27                  ; 06EF: 20 27          
                FCB     $A6,$1E,$AA,$1D,$26,$08  ; 06F1: A6 1E AA 1D 26 08 
                FCB     $A6                      ; 06F7: A6             
                FCB     $20                      ; 06F8: 20             
                FCB     $A7,$1E,$A6,$1F,$A7,$1D  ; 06F9: A7 1E A6 1F A7 1D 
                FCB     $EE,$1D,$E7,$00,$FE,$09  ; 06FF: EE 1D E7 00 FE 09 
                FCB     $4F,$6C                  ; 0705: 4F 6C          
                FCB     $1E,$26,$02              ; 0707: 1E 26 02       
                FCB     $6C                      ; 070A: 6C             
                FCB     $1D,$A6                  ; 070B: 1D A6          
                FCB     $24                      ; 070D: 24             
                FCB     $E6                      ; 070E: E6             
                FCB     $23                      ; 070F: 23             
                FCB     $A1,$1E,$E2,$1D          ; 0710: A1 1E E2 1D    
                FCB     $24                      ; 0714: 24             
                FCB     $02,$8D                  ; 0715: 02 8D          
                FCB     $49,$30                  ; 0717: 49 30          
                FCB     $EE,$00                  ; 0719: EE 00          
                FCB     $31,$31,$6E              ; 071B: 31 31 6E       
                FCB     $02,$86,$82,$8C,$86      ; 071E: 02 86 82 8C 86 
                FCB     $41                      ; 0723: 41             
                FCB     $FF,$09                  ; 0724: FF 09          
                FCB     $4F,$6F                  ; 0726: 4F 6F          
                FCB     $00,$16,$E8,$01,$C4,$03  ; 0728: 00 16 E8 01 C4 03 
                FCB     $27                      ; 072E: 27             
                FCB     $0D,$E6,$01,$C5          ; 072F: 0D E6 01 C5    
                FCB     $20,$27                  ; 0733: 20 27          
                FCB     $07,$C5,$10              ; 0735: 07 C5 10       
                FCB     $27                      ; 0738: 27             
                FCB     $09,$C6,$08,$8C,$C6,$0B  ; 0739: 09 C6 08 8C C6 0B 
                FCB     $0D,$E7,$00              ; 073F: 0D E7 00       
                FCB     $39                      ; 0742: 39             
                FCB     $C4                      ; 0743: C4             
                FCB     $3F                      ; 0744: 3F             
                FCB     $84,$C0,$1B,$A7,$01,$B7  ; 0745: 84 C0 1B A7 01 B7 
                FCB     $09                      ; 074B: 09             
                FCB     $51                      ; 074C: 51             
                FCB     $8D,$12                  ; 074D: 8D 12          
                FCB     $20                      ; 074F: 20             
                FCB     $F1                      ; 0750: F1             
Z0751           LDAB    #$11                     ; 0751: C6 11          
Z0753           INS                              ; 0753: 31             
                INS                              ; 0754: 31             
                INS                              ; 0755: 31             
                INS                              ; 0756: 31             
                CPX     #MC619                   ; 0757: 8C C6 19       
                CPX     #MC609                   ; 075A: 8C C6 09       
                SEC                              ; 075D: 0D             
Z075E           STAB    ,X                       ; 075E: E7 00          
                RTS                              ; 0760: 39             
                LDAA    $01,X                    ; 0761: A6 01          
                BPL     Z0775                    ; 0763: 2A 10          
                LDAA    $14,X                    ; 0765: A6 14          
                LDAB    $13,X                    ; 0767: E6 13          
                SUBA    $12,X                    ; 0769: A0 12          
                SBCB    $11,X                    ; 076B: E2 11          
                BMI     Z075B                    ; 076D: 2B EC          
                LDAA    $22,X                    ; 076F: A6 22          
                LDAB    $21,X                    ; 0771: E6 21          
                BRA     Z0779                    ; 0773: 20 04          
Z0775           LDAA    $24,X                    ; 0775: A6 24          
                LDAB    $23,X                    ; 0777: E6 23          
Z0779           SUBA    $20,X                    ; 0779: A0 20          
                SBCB    $1F,X                    ; 077B: E2 1F          
                ADDA    #$01                     ; 077D: 8B 01          
                ADCB    #$00                     ; 077F: C9 00          
                ASLA                             ; 0781: 48             
                BNE     Z0758                    ; 0782: 26 D4          
                ROLB                             ; 0784: 59             
                ROLA                             ; 0785: 49             
                PSHB                             ; 0786: 37             
                PSHA                             ; 0787: 36             
                LDAA    $20,X                    ; 0788: A6 20          
                LDAB    $1F,X                    ; 078A: E6 1F          
                PSHA                             ; 078C: 36             
                PSHB                             ; 078D: 37             
                TST     $01,X                    ; 078E: 6D 01          
                BPL     Z079A                    ; 0790: 2A 08          
                SUBA    #$01                     ; 0792: 80 01          
                SBCB    #$00                     ; 0794: C2 00          
                STAA    $24,X                    ; 0796: A7 24          
                STAB    $23,X                    ; 0798: E7 23          
Z079A           LDAA    $12,X                    ; 079A: A6 12          
                LDAB    $11,X                    ; 079C: E6 11          
                CMPA    #$FF                     ; 079E: 81 FF          
                SBCB    #$FF                     ; 07A0: C2 FF          
                BMI     Z0751                    ; 07A2: 2B AD          
                LDAB    $11,X                    ; 07A4: E6 11          
                SUBA    $10,X                    ; 07A6: A0 10          
                SBCB    $0F,X                    ; 07A8: E2 0F          
                BNE     Z07BA                    ; 07AA: 26 0E          
                LDAB    $0D,X                    ; 07AC: E6 0D          
                BMI     Z0751                    ; 07AE: 2B A1          
                ANDB    #$7C                     ; 07B0: C4 7C          
                ADDB    #$04                     ; 07B2: CB 04          
                SBA                              ; 07B4: 10             
                BCC     Z07BA                    ; 07B5: 24 03          
                JMP     Z0865                    ; 07B7: 7E 08 65       
Z07BA           LDAB    $0A,X                    ; 07BA: E6 0A          
                LDAA    M010F                    ; 07BC: B6 01 0F       
                PSHA                             ; 07BF: 36             
                LDAA    RIBBAs                   ; 07C0: B6 01 0E       
                PSHA                             ; 07C3: 36             
                LDX     $15,X                    ; 07C4: EE 15          
                SWI                              ; 07C6: 3F             
                PULA                             ; 07C7: 32             
                DES                              ; 07C8: 34             
                TSX                              ; 07C9: 30             
                SWI                              ; 07CA: 3F             
                CLI                              ; 07CB: 0E             
                PULB                             ; 07CC: 33             
                INS                              ; 07CD: 31             
                INS                              ; 07CE: 31             
                INS                              ; 07CF: 31             
                INS                              ; 07D0: 31             
                LDX     M094F                    ; 07D1: FE 09 4F       
                LDAB    RIBBAs                   ; 07D4: F6 01 0E       
                LDAA    M010F                    ; 07D7: B6 01 0F       
                STAB    $1D,X                    ; 07DA: E7 1D          
                STAA    $1E,X                    ; 07DC: A7 1E          
                LDAA    #$FE                     ; 07DE: 86 FE          
                PSHA                             ; 07E0: 36             
                INCA                             ; 07E1: 4C             
                PSHA                             ; 07E2: 36             
Z07E3           LDX     $1D,X                    ; 07E3: EE 1D          
                LDAA    ,X                       ; 07E5: A6 00          
                BPL     Z080D                    ; 07E7: 2A 24          
                LDX     M094F                    ; 07E9: FE 09 4F       
                LDAA    $01,X                    ; 07EC: A6 01          
                BMI     Z083F                    ; 07EE: 2B 4F          
                PULB                             ; 07F0: 33             
                PULA                             ; 07F1: 32             
                CLR     $1E,X                    ; 07F2: 6F 1E          
                CLR     $1D,X                    ; 07F4: 6F 1D          
                LDAA    #$0A                     ; 07F6: 86 0A          
                SWI                              ; 07F8: 3F             
                BVC     Z083A                    ; 07F9: 28 3F          
                FCB     $21                      ; 07FB: 21             
                LDX     M094F                    ; 07FC: FE 09 4F       
                BCS     Z080A                    ; 07FF: 25 09          
                LDAA    $01,X                    ; 0801: A6 01          
                ORAA    #$08                     ; 0803: 8A 08          
                STAA    $01,X                    ; 0805: A7 01          
                JMP     Z079A                    ; 0807: 7E 07 9A       
Z080A           JMP     Z0753                    ; 080A: 7E 07 53       
Z080D           ANDA    #$7C                     ; 080D: 84 7C          
                ADDA    #$04                     ; 080F: 8B 04          
                CLRB                             ; 0811: 5F             
                SWI                              ; 0812: 3F             
                PULB                             ; 0813: 33             
                SWI                              ; 0814: 3F             
                BPL     Z084D                    ; 0815: 2A 36          
                PSHB                             ; 0817: 37             
                LDX     M094F                    ; 0818: FE 09 4F       
                SUBA    $12,X                    ; 081B: A0 12          
                SBCB    $11,X                    ; 081D: E2 11          
                BPL     Z0844                    ; 081F: 2A 23          
                INC     $1E,X                    ; 0821: 6C 1E          
                BNE     Z0827                    ; 0823: 26 02          
                INC     $1D,X                    ; 0825: 6C 1D          
Z0827           INC     $1E,X                    ; 0827: 6C 1E          
                BNE     Z082D                    ; 0829: 26 02          
                INC     $1D,X                    ; 082B: 6C 1D          
Z082D           LDAA    M010F                    ; 082D: B6 01 0F       
                LDAB    RIBBAs                   ; 0830: F6 01 0E       
                ADDA    #$80                     ; 0833: 8B 80          
                ADCB    #$00                     ; 0835: C9 00          
                CMPA    $1E,X                    ; 0837: A1 1E          
                BNE     Z07E3                    ; 0839: 26 A8          
                CMPB    $1D,X                    ; 083B: E1 1D          
                BNE     Z07E3                    ; 083D: 26 A4          
Z083F           INS                              ; 083F: 31             
                INS                              ; 0840: 31             
                JMP     Z0751                    ; 0841: 7E 07 51       
Z0844           LDX     $1D,X                    ; 0844: EE 1D          
                LDAA    $01,X                    ; 0846: A6 01          
                LDAB    ,X                       ; 0848: E6 00          
                LDX     M094F                    ; 084A: FE 09 4F       
Z084D           STAA    $0E,X                    ; 084D: A7 0E          
                STAB    $0D,X                    ; 084F: E7 0D          
                ANDB    #$7C                     ; 0851: C4 7C          
                ADDB    #$03                     ; 0853: CB 03          
                SWI                              ; 0855: 3F             
                PULB                             ; 0856: 33             
                SWI                              ; 0857: 3F             
                BMI     Z0899                    ; 0858: 2B 3F          
Z085A           BCC     Z085A                    ; 085A: 24 FE          
                DEX                              ; 085C: 09             
                CLRA                             ; 085D: 4F             
                STAA    $10,X                    ; 085E: A7 10          
                STAB    $0F,X                    ; 0860: E7 0F          
                JMP     Z079A                    ; 0862: 7E 07 9A       
Z0865           ABA                              ; 0865: 1B             
                PSHA                             ; 0866: 36             
                SBA                              ; 0867: 10             
                NEGA                             ; 0868: 40             
                PSHA                             ; 0869: 36             
                LDAA    $0E,X                    ; 086A: A6 0E          
                LDAB    $0D,X                    ; 086C: E6 0D          
                ANDB    #$03                     ; 086E: C4 03          
                ASLA                             ; 0870: 48             
                ROLB                             ; 0871: 59             
                ASLA                             ; 0872: 48             
                ROLB                             ; 0873: 59             
                TSX                              ; 0874: 30             
                ADDA    $01,X                    ; 0875: AB 01          
                ADCB    #$00                     ; 0877: C9 00          
                STAA    $01,X                    ; 0879: A7 01          
                PULA                             ; 087B: 32             
                PSHB                             ; 087C: 37             
                LDX     M094F                    ; 087D: FE 09 4F       
                LDAB    $0A,X                    ; 0880: E6 0A          
                PSHB                             ; 0882: 37             
                LDAB    $01,X                    ; 0883: E6 01          
                BPL     Z08A9                    ; 0885: 2A 22          
                CLR     M0952                    ; 0887: 7F 09 52       
                PSHA                             ; 088A: 36             
                LDAA    $14,X                    ; 088B: A6 14          
                LDAB    $13,X                    ; 088D: E6 13          
                SUBA    $10,X                    ; 088F: A0 10          
                SBCB    $0F,X                    ; 0891: E2 0F          
                BNE     Z08A8                    ; 0893: 26 13          
                LDAB    $0D,X                    ; 0895: E6 0D          
                ANDB    #$7C                     ; 0897: C4 7C          
Z0899           ADDB    #$04                     ; 0899: CB 04          
                SBA                              ; 089B: 10             
                LDAA    $14,X                    ; 089C: A6 14          
                BCC     Z08A8                    ; 089E: 24 08          
                SUBA    $12,X                    ; 08A0: A0 12          
                INCA                             ; 08A2: 4C             
                INS                              ; 08A3: 31             
                PSHA                             ; 08A4: 36             
                INC     M0952                    ; 08A5: 7C 09 52       
Z08A8           PULA                             ; 08A8: 32             
Z08A9           TSX                              ; 08A9: 30             
                CLRB                             ; 08AA: 5F             
                CMPA    $06,X                    ; 08AB: A1 06          
                SBCB    $05,X                    ; 08AD: E2 05          
                BCC     Z08F7                    ; 08AF: 24 46          
                LDAB    $06,X                    ; 08B1: E6 06          
                STAA    $06,X                    ; 08B3: A7 06          
                LDAA    $05,X                    ; 08B5: A6 05          
                CLR     $05,X                    ; 08B7: 6F 05          
                SUBB    $06,X                    ; 08B9: E0 06          
                SBCA    $05,X                    ; 08BB: A2 05          
                PSHB                             ; 08BD: 37             
                PSHA                             ; 08BE: 36             
                LDAB    ,X                       ; 08BF: E6 00          
                TST     M0951                    ; 08C1: 7D 09 51       
                BMI     Z08CA                    ; 08C4: 2B 04          
                SWI                              ; 08C6: 3F             
                FCB     $3C                      ; 08C7: 3C             
                BRA     Z08D5                    ; 08C8: 20 0B          
Z08CA           SWI                              ; 08CA: 3F             
                RTI                              ; 08CB: 3B             
                TST     M0952                    ; 08CC: 7D 09 52       
                BEQ     Z08D5                    ; 08CF: 27 04          
                INS                              ; 08D1: 31             
                INS                              ; 08D2: 31             
                BRA     Z0904                    ; 08D3: 20 2F          
Z08D5           LDAA    $06,X                    ; 08D5: A6 06          
                CLRB                             ; 08D7: 5F             
                BSR     Z0915                    ; 08D8: 8D 3B          
                TSX                              ; 08DA: 30             
                LDAB    $08,X                    ; 08DB: E6 08          
                CLRA                             ; 08DD: 4F             
                LSRB                             ; 08DE: 54             
                RORA                             ; 08DF: 46             
                ADDA    $06,X                    ; 08E0: AB 06          
                ADCB    $05,X                    ; 08E2: E9 05          
                STAA    $06,X                    ; 08E4: A7 06          
                STAB    $05,X                    ; 08E6: E7 05          
                PULB                             ; 08E8: 33             
                PULA                             ; 08E9: 32             
                STAB    $07,X                    ; 08EA: E7 07          
                STAA    $08,X                    ; 08EC: A7 08          
                INS                              ; 08EE: 31             
                INS                              ; 08EF: 31             
                INS                              ; 08F0: 31             
                LDX     M094F                    ; 08F1: FE 09 4F       
                JMP     Z079A                    ; 08F4: 7E 07 9A       
Z08F7           LDAB    ,X                       ; 08F7: E6 00          
                TST     M0951                    ; 08F9: 7D 09 51       
                BMI     Z0902                    ; 08FC: 2B 04          
                SWI                              ; 08FE: 3F             
                FCB     $3C                      ; 08FF: 3C             
                BRA     Z0904                    ; 0900: 20 02          
Z0902           SWI                              ; 0902: 3F             
                RTI                              ; 0903: 3B             
Z0904           LDAA    $06,X                    ; 0904: A6 06          
                LDAB    $05,X                    ; 0906: E6 05          
                INS                              ; 0908: 31             
                INS                              ; 0909: 31             
                INS                              ; 090A: 31             
                BSR     Z0915                    ; 090B: 8D 08          
                INS                              ; 090D: 31             
                INS                              ; 090E: 31             
                INS                              ; 090F: 31             
                INS                              ; 0910: 31             
                CLRB                             ; 0911: 5F             
                JMP     Z075E                    ; 0912: 7E 07 5E       
Z0915           LDX     M094F                    ; 0915: FE 09 4F       
                PSHA                             ; 0918: 36             
                PSHB                             ; 0919: 37             
                ADDA    $12,X                    ; 091A: AB 12          
                ADCB    $11,X                    ; 091C: E9 11          
                STAA    $12,X                    ; 091E: A7 12          
                STAB    $11,X                    ; 0920: E7 11          
                TST     $01,X                    ; 0922: 6D 01          
                BMI     Z0936                    ; 0924: 2B 10          
                SUBA    #$01                     ; 0926: 80 01          
                SBCB    #$00                     ; 0928: C2 00          
                CMPA    $0C,X                    ; 092A: A1 0C          
                PSHB                             ; 092C: 37             
                SBCB    $0B,X                    ; 092D: E2 0B          
                PULB                             ; 092F: 33             
                BMI     Z0936                    ; 0930: 2B 04          
                STAA    $0C,X                    ; 0932: A7 0C          
                STAB    $0B,X                    ; 0934: E7 0B          
Z0936           LDAA    $20,X                    ; 0936: A6 20          
                LDAB    $1F,X                    ; 0938: E6 1F          
                STAA    $1E,X                    ; 093A: A7 1E          
                STAB    $1D,X                    ; 093C: E7 1D          
                PULA                             ; 093E: 32             
                PULB                             ; 093F: 33             
                TST     $01,X                    ; 0940: 6D 01          
                BPL     Z094E                    ; 0942: 2A 0A          
                LSRB                             ; 0944: 54             
                RORA                             ; 0945: 46             
                ADDA    $24,X                    ; 0946: AB 24          
                ADCB    $23,X                    ; 0948: E9 23          
                STAA    $24,X                    ; 094A: A7 24          
                STAB    $23,X                    ; 094C: E7 23          
Z094E           RTS                              ; 094E: 39             
M094F           FCB     $00                      ; 094F: 00             
                FCB     $00                      ; 0950: 00             
M0951           FCB     $00                      ; 0951: 00             
M0952           FCB     $00                      ; 0952: 00             
                CLC                              ; 0953: 0C             
                BRA     Z095D                    ; 0954: 20 07          
                CLC                              ; 0956: 0C             
                BRA     Z095D                    ; 0957: 20 04          
                CLC                              ; 0959: 0C             
                BRA     Z095D                    ; 095A: 20 01          
                CLC                              ; 095C: 0C             
Z095D           BRA     Z0979                    ; 095D: 20 1A          
                TSX                              ; 095F: 30             
                LDX     ,X                       ; 0960: EE 00          
                LDX     ,X                       ; 0962: EE 00          
                LDX     ,X                       ; 0964: EE 00          
                LDAA    $01,X                    ; 0966: A6 01          
                BPL     Z0975                    ; 0968: 2A 0B          
                INC     AECHO                    ; 096A: 7C FF 53       
                JSR     XINCHN                   ; 096D: BD F0 15       
                PSHA                             ; 0970: 36             
                TSTB                             ; 0971: 5D             
                PULB                             ; 0972: 33             
                BNE     Z0979                    ; 0973: 26 04          
Z0975           TBA                              ; 0975: 17             
                JSR     XOUTCH                   ; 0976: BD F0 18       
Z0979           TSX                              ; 0979: 30             
                LDX     ,X                       ; 097A: EE 00          
                INS                              ; 097C: 31             
                INS                              ; 097D: 31             
                JMP     $02,X                    ; 097E: 6E 02          
                JMP     Z1291                    ; 0980: 7E 12 91       
                JMP     Z1294                    ; 0983: 7E 12 94       
                CLC                              ; 0986: 0C             
                BRA     Z0979                    ; 0987: 20 F0          
                CLC                              ; 0989: 0C             
                BRA     Z0979                    ; 098A: 20 ED          
                JMP     Z1297                    ; 098C: 7E 12 97       
                JMP     Z129A                    ; 098F: 7E 12 9A       
                JMP     Z129D                    ; 0992: 7E 12 9D       
                JMP     Z12A0                    ; 0995: 7E 12 A0       
                JMP     Z12A3                    ; 0998: 7E 12 A3       
                JMP     Z12A6                    ; 099B: 7E 12 A6       
                CLC                              ; 099E: 0C             
                BRA     Z09C0                    ; 099F: 20 1F          
                CLC                              ; 09A1: 0C             
                BRA     Z09C0                    ; 09A2: 20 1C          
                CLC                              ; 09A4: 0C             
                BRA     Z09BD                    ; 09A5: 20 16          
                CLC                              ; 09A7: 0C             
                BRA     Z09C0                    ; 09A8: 20 16          
                TBA                              ; 09AA: 17             
                JSR     LIST                     ; 09AB: BD EB CC       
                BCC     Z09C0                    ; 09AE: 24 10          
                TSX                              ; 09B0: 30             
                LDX     ,X                       ; 09B1: EE 00          
                LDX     ,X                       ; 09B3: EE 00          
                LDX     ,X                       ; 09B5: EE 00          
                LDAA    #$04                     ; 09B7: 86 04          
                STAA    ,X                       ; 09B9: A7 00          
                BRA     Z09C0                    ; 09BB: 20 03          
Z09BD           JSR     LPINIT                   ; 09BD: BD EB C0       
Z09C0           TSX                              ; 09C0: 30             
                LDX     ,X                       ; 09C1: EE 00          
                INS                              ; 09C3: 31             
                INS                              ; 09C4: 31             
                JMP     $02,X                    ; 09C5: 6E 02          
                ANDB    #$7F                     ; 09C7: C4 7F          
                BNE     Z09CE                    ; 09C9: 26 03          
Z09CB           JMP     Z0B8C                    ; 09CB: 7E 0B 8C       
Z09CE           STAB    M0C22                    ; 09CE: F7 0C 22       
                CLC                              ; 09D1: 0C             
Z09D2           RORB                             ; 09D2: 56             
                BCC     Z09D2                    ; 09D3: 24 FD          
                TSTB                             ; 09D5: 5D             
                BNE     Z09CB                    ; 09D6: 26 F3          
                LDAB    ,X                       ; 09D8: E6 00          
                ANDB    #$03                     ; 09DA: C4 03          
                STAB    M0000                    ; 09DC: D7 00          
                CLR     M0C23                    ; 09DE: 7F 0C 23       
                LDAB    M0C22                    ; 09E1: F6 0C 22       
                ANDB    #$21                     ; 09E4: C4 21          
                BEQ     Z09F5                    ; 09E6: 27 0D          
                TST     $11,X                    ; 09E8: 6D 11          
                BNE     Z0A08                    ; 09EA: 26 1C          
Z09EC           JSR     Z0BD4                    ; 09EC: BD 0B D4       
                LDAA    #$18                     ; 09EF: 86 18          
Z09F1           STAA    $11,X                    ; 09F1: A7 11          
                BRA     Z0A51                    ; 09F3: 20 5C          
Z09F5           JSR     Z0BD4                    ; 09F5: BD 0B D4       
                INX                              ; 09F8: 08             
                JSR     HASH                     ; 09F9: BD 0B DF       
                ADDA    #$03                     ; 09FC: 8B 03          
                ASLA                             ; 09FE: 48             
                ASLA                             ; 09FF: 48             
                ASLA                             ; 0A00: 48             
                TSX                              ; 0A01: 30             
                LDX     $05,X                    ; 0A02: EE 05          
                STAA    $12,X                    ; 0A04: A7 12          
                BRA     Z09F1                    ; 0A06: 20 E9          
Z0A08           TSX                              ; 0A08: 30             
                LDX     $05,X                    ; 0A09: EE 05          
                LDAA    $11,X                    ; 0A0B: A6 11          
                ANDA    #$07                     ; 0A0D: 84 07          
                CMPA    #$07                     ; 0A0F: 81 07          
                BEQ     Z0A17                    ; 0A11: 27 04          
                INC     $11,X                    ; 0A13: 6C 11          
                BRA     Z0A55                    ; 0A15: 20 3E          
Z0A17           TSX                              ; 0A17: 30             
                LDX     $05,X                    ; 0A18: EE 05          
                LDAA    $11,X                    ; 0A1A: A6 11          
                LDAB    M0C22                    ; 0A1C: F6 0C 22       
                ANDB    #$21                     ; 0A1F: C4 21          
                ANDA    #$F8                     ; 0A21: 84 F8          
                CMPA    #$B0                     ; 0A23: 81 B0          
                BEQ     Z0A2B                    ; 0A25: 27 04          
                ADDA    #$08                     ; 0A27: 8B 08          
                BRA     Z0A33                    ; 0A29: 20 08          
Z0A2B           TSTB                             ; 0A2B: 5D             
                BEQ     Z0A31                    ; 0A2C: 27 03          
                JMP     Z0B90                    ; 0A2E: 7E 0B 90       
Z0A31           LDAA    #$18                     ; 0A31: 86 18          
Z0A33           TSTB                             ; 0A33: 5D             
                BNE     Z0A4F                    ; 0A34: 26 19          
                CMPA    $12,X                    ; 0A36: A1 12          
                BNE     Z0A4F                    ; 0A38: 26 15          
                LDAB    M0C22                    ; 0A3A: F6 0C 22       
                ANDB    #$12                     ; 0A3D: C4 12          
                BEQ     Z0A44                    ; 0A3F: 27 03          
                JMP     Z0B88                    ; 0A41: 7E 0B 88       
Z0A44           TST     M0C23                    ; 0A44: 7D 0C 23       
                BNE     Z0A4C                    ; 0A47: 26 03          
                JMP     Z0B94                    ; 0A49: 7E 0B 94       
Z0A4C           JMP     Z0B2C                    ; 0A4C: 7E 0B 2C       
Z0A4F           STAA    $11,X                    ; 0A4F: A7 11          
Z0A51           CLRB                             ; 0A51: 5F             
                JSR     Z0BA8                    ; 0A52: BD 0B A8       
Z0A55           LDAA    $11,X                    ; 0A55: A6 11          
                TAB                              ; 0A57: 16             
                ANDA    #$07                     ; 0A58: 84 07          
                ASLA                             ; 0A5A: 48             
                ASLA                             ; 0A5B: 48             
                ASLA                             ; 0A5C: 48             
                ASLA                             ; 0A5D: 48             
                LDX     $15,X                    ; 0A5E: EE 15          
                SWI                              ; 0A60: 3F             
                BVC     Z0A62                    ; 0A61: 28 FF          
                CLC                              ; 0A63: 0C             
                BNE     Z09EC                    ; 0A64: 26 86          
                STX     MA100                    ; 0A66: FF A1 00       
                BNE     Z0A73                    ; 0A69: 26 08          
                STAB    M0C23                    ; 0A6B: F7 0C 23       
                STX     M0C24                    ; 0A6E: FF 0C 24       
                BRA     Z0A08                    ; 0A71: 20 95          
Z0A73           TST     ,X                       ; 0A73: 6D 00          
                BNE     Z0A7A                    ; 0A75: 26 03          
                JMP     Z0B1D                    ; 0A77: 7E 0B 1D       
Z0A7A           LDAB    M0C22                    ; 0A7A: F6 0C 22       
                CMPB    #$01                     ; 0A7D: C1 01          
                BNE     Z0A9E                    ; 0A7F: 26 1D          
Z0A81           LDX     M0C26                    ; 0A81: FE 0C 26       
                STX     M0C1B                    ; 0A84: FF 0C 1B       
                TSX                              ; 0A87: 30             
                LDX     $05,X                    ; 0A88: EE 05          
                INX                              ; 0A8A: 08             
                STX     M0C1D                    ; 0A8B: FF 0C 1D       
                LDX     #M0C1B                   ; 0A8E: CE 0C 1B       
                LDAB    #$10                     ; 0A91: C6 10          
                SWI                              ; 0A93: 3F             
                SBA                              ; 0A94: 10             
                LDAB    M0C22                    ; 0A95: F6 0C 22       
                CMPB    #$10                     ; 0A98: C1 10          
                BEQ     Z0ADE                    ; 0A9A: 27 42          
Z0A9C           CLRB                             ; 0A9C: 5F             
                RTS                              ; 0A9D: 39             
Z0A9E           CMPB    #$20                     ; 0A9E: C1 20          
                BNE     Z0ABE                    ; 0AA0: 26 1C          
                LDAB    #$0C                     ; 0AA2: C6 0C          
                SWI                              ; 0AA4: 3F             
                BEQ     Z0A4D                    ; 0AA5: 27 A6          
                FCB     $00                      ; 0AA7: 00             
                LDAB    $01,X                    ; 0AA8: E6 01          
                TSX                              ; 0AAA: 30             
                LDX     $05,X                    ; 0AAB: EE 05          
                ANDA    $0D,X                    ; 0AAD: A4 0D          
                EORA    $0D,X                    ; 0AAF: A8 0D          
                BNE     Z0ABB                    ; 0AB1: 26 08          
                ANDB    $0E,X                    ; 0AB3: E4 0E          
                EORB    $0E,X                    ; 0AB5: E8 0E          
                BNE     Z0ABB                    ; 0AB7: 26 02          
                BRA     Z0A81                    ; 0AB9: 20 C6          
Z0ABB           JMP     Z0A08                    ; 0ABB: 7E 0A 08       
Z0ABE           STX     M0C1B                    ; 0ABE: FF 0C 1B       
                TSX                              ; 0AC1: 30             
                LDX     $05,X                    ; 0AC2: EE 05          
                INX                              ; 0AC4: 08             
                STX     M0C1D                    ; 0AC5: FF 0C 1D       
                LDAB    #$0A                     ; 0AC8: C6 0A          
                LDX     #M0C1B                   ; 0ACA: CE 0C 1B       
                SWI                              ; 0ACD: 3F             
                CBA                              ; 0ACE: 11             
                BEQ     Z0AD4                    ; 0ACF: 27 03          
                JMP     Z0A08                    ; 0AD1: 7E 0A 08       
Z0AD4           LDAB    M0C22                    ; 0AD4: F6 0C 22       
                ANDB    #$44                     ; 0AD7: C4 44          
                BEQ     Z0A81                    ; 0AD9: 27 A6          
                JMP     Z0B9C                    ; 0ADB: 7E 0B 9C       
Z0ADE           LDX     M0C26                    ; 0ADE: FE 0C 26       
                LDAB    #$C0                     ; 0AE1: C6 C0          
                BITB    $0C,X                    ; 0AE3: E5 0C          
                BEQ     Z0AEA                    ; 0AE5: 27 03          
                JMP     Z0BA4                    ; 0AE7: 7E 0B A4       
Z0AEA           LDAB    #$02                     ; 0AEA: C6 02          
                LDAA    #$FF                     ; 0AEC: 86 FF          
                SWI                              ; 0AEE: 3F             
                FCB     $13                      ; 0AEF: 13             
                TSX                              ; 0AF0: 30             
                LDX     $05,X                    ; 0AF1: EE 05          
                LDAB    #$01                     ; 0AF3: C6 01          
                JSR     Z0BA8                    ; 0AF5: BD 0B A8       
                LDX     $01,X                    ; 0AF8: EE 01          
                STX     M0C26                    ; 0AFA: FF 0C 26       
                TSX                              ; 0AFD: 30             
                LDX     $05,X                    ; 0AFE: EE 05          
                LDAA    #$FF                     ; 0B00: 86 FF          
                STAA    $01,X                    ; 0B02: A7 01          
                STAA    $02,X                    ; 0B04: A7 02          
                SWI                              ; 0B06: 3F             
                BHI     Z0B2D                    ; 0B07: 22 24          
                TAP                              ; 0B09: 06             
                LDAB    #$11                     ; 0B0A: C6 11          
                SWI                              ; 0B0C: 3F             
                BRA     Z0B4E                    ; 0B0D: 20 3F          
                FCB     $1A                      ; 0B0F: 1A             
                LDAB    M0C26                    ; 0B10: F6 0C 26       
                LDAA    M0C27                    ; 0B13: B6 0C 27       
                STAB    $01,X                    ; 0B16: E7 01          
                STAA    $02,X                    ; 0B18: A7 02          
                JMP     Z0A9C                    ; 0B1A: 7E 0A 9C       
Z0B1D           LDAB    M0C22                    ; 0B1D: F6 0C 22       
                TBA                              ; 0B20: 17             
                ANDB    #$21                     ; 0B21: C4 21          
                BEQ     Z0B28                    ; 0B23: 27 03          
                JMP     Z0A17                    ; 0B25: 7E 0A 17       
Z0B28           ANDA    #$12                     ; 0B28: 84 12          
                BNE     Z0B88                    ; 0B2A: 26 5C          
Z0B2C           TSX                              ; 0B2C: 30             
Z0B2D           LDX     $05,X                    ; 0B2D: EE 05          
                LDAB    M0C23                    ; 0B2F: F6 0C 23       
                BEQ     Z0B3F                    ; 0B32: 27 0B          
                STAB    $11,X                    ; 0B34: E7 11          
                LDX     M0C24                    ; 0B36: FE 0C 24       
                STX     M0C26                    ; 0B39: FF 0C 26       
                TSX                              ; 0B3C: 30             
                LDX     $05,X                    ; 0B3D: EE 05          
Z0B3F           LDAB    M0C22                    ; 0B3F: F6 0C 22       
                CMPB    #$40                     ; 0B42: C1 40          
                BEQ     Z0B63                    ; 0B44: 27 1D          
                CLR     $0B,X                    ; 0B46: 6F 0B          
                CLR     $0C,X                    ; 0B48: 6F 0C          
                CLR     $0F,X                    ; 0B4A: 6F 0F          
                CLR     $10,X                    ; 0B4C: 6F 10          
Z0B4E           CLR     $12,X                    ; 0B4E: 6F 12          
                SWI                              ; 0B50: 3F             
                FCB     $21                      ; 0B51: 21             
                TSTB                             ; 0B52: 5D             
                BEQ     Z0B63                    ; 0B53: 27 0E          
                CMPB    #$11                     ; 0B55: C1 11          
                BEQ     Z0B98                    ; 0B57: 27 3F          
                CMPB    #$12                     ; 0B59: C1 12          
                BEQ     Z0B98                    ; 0B5B: 27 3B          
                LDAB    #$0C                     ; 0B5D: C6 0C          
                SWI                              ; 0B5F: 3F             
                BRA     Z0BA1                    ; 0B60: 20 3F          
                FCB     $1A                      ; 0B62: 1A             
Z0B63           CLRB                             ; 0B63: 5F             
                BSR     Z0BA8                    ; 0B64: 8D 42          
                INX                              ; 0B66: 08             
                STX     M0C1B                    ; 0B67: FF 0C 1B       
                LDX     M0C26                    ; 0B6A: FE 0C 26       
                STX     M0C1D                    ; 0B6D: FF 0C 1D       
                LDX     #M0C1B                   ; 0B70: CE 0C 1B       
                LDAB    #$10                     ; 0B73: C6 10          
                SWI                              ; 0B75: 3F             
                SBA                              ; 0B76: 10             
                LDAB    #$01                     ; 0B77: C6 01          
                TSX                              ; 0B79: 30             
                LDX     $05,X                    ; 0B7A: EE 05          
                BSR     Z0BA8                    ; 0B7C: 8D 2A          
                LDAB    M0C22                    ; 0B7E: F6 0C 22       
                CMPB    #$08                     ; 0B81: C1 08          
                BEQ     Z0BA0                    ; 0B83: 27 1B          
                JMP     Z0A9C                    ; 0B85: 7E 0A 9C       
Z0B88           LDAB    #$01                     ; 0B88: C6 01          
Z0B8A           SEC                              ; 0B8A: 0D             
                RTS                              ; 0B8B: 39             
Z0B8C           LDAB    #$02                     ; 0B8C: C6 02          
                BRA     Z0B8A                    ; 0B8E: 20 FA          
Z0B90           LDAB    #$03                     ; 0B90: C6 03          
                BRA     Z0B8A                    ; 0B92: 20 F6          
Z0B94           LDAB    #$04                     ; 0B94: C6 04          
                BRA     Z0B8A                    ; 0B96: 20 F2          
Z0B98           LDAB    #$05                     ; 0B98: C6 05          
                BRA     Z0B8A                    ; 0B9A: 20 EE          
Z0B9C           LDAB    #$07                     ; 0B9C: C6 07          
                BRA     Z0B8A                    ; 0B9E: 20 EA          
Z0BA0           LDAB    #$08                     ; 0BA0: C6 08          
                BRA     Z0B8A                    ; 0BA2: 20 E6          
Z0BA4           LDAB    #$09                     ; 0BA4: C6 09          
                BRA     Z0B8A                    ; 0BA6: 20 E2          
Z0BA8           STX     TMP2                     ; 0BA8: FF 0C 20       
                STAB    TMP1                     ; 0BAB: F7 0C 1F       
                LDAB    ,X                       ; 0BAE: E6 00          
                LDAA    $11,X                    ; 0BB0: A6 11          
                LDX     $15,X                    ; 0BB2: EE 15          
                STX     M0C1D                    ; 0BB4: FF 0C 1D       
                ANDA    #$F8                     ; 0BB7: 84 F8          
                LSRA                             ; 0BB9: 44             
                LSRA                             ; 0BBA: 44             
                LSRA                             ; 0BBB: 44             
                CLR     M0C1B                    ; 0BBC: 7F 0C 1B       
                STAA    M0C1C                    ; 0BBF: B7 0C 1C       
                LDX     #M0C1A                   ; 0BC2: CE 0C 1A       
                TST     TMP1                     ; 0BC5: 7D 0C 1F       
                BNE     Z0BCE                    ; 0BC8: 26 04          
                SWI                              ; 0BCA: 3F             
                CLI                              ; 0BCB: 0E             
                BRA     Z0BD0                    ; 0BCC: 20 02          
Z0BCE           SWI                              ; 0BCE: 3F             
                SEI                              ; 0BCF: 0F             
Z0BD0           LDX     TMP2                     ; 0BD0: FE 0C 20       
                RTS                              ; 0BD3: 39             
Z0BD4           LDAA    M0000                    ; 0BD4: 96 00          
                BEQ     Z0BDE                    ; 0BD6: 27 06          
                JSR     RESTOR                   ; 0BD8: BD E8 75       
                TSX                              ; 0BDB: 30             
                LDX     $07,X                    ; 0BDC: EE 07          
Z0BDE           RTS                              ; 0BDE: 39             
HASH            LDAB    #$0A                     ; 0BDF: C6 0A          
                STAB    TMP3                     ; 0BE1: F7 0C 21       
                CLC                              ; 0BE4: 0C             
                CLRB                             ; 0BE5: 5F             
HASH2           STAB    TMP1                     ; 0BE6: F7 0C 1F       
                TPA                              ; 0BE9: 07             
                STAA    TMP2                     ; 0BEA: B7 0C 20       
                LDAB    ,X                       ; 0BED: E6 00          
                SUBB    #$25                     ; 0BEF: C0 25          
                BPL     HASH25                   ; 0BF1: 2A 01          
                CLRB                             ; 0BF3: 5F             
HASH25          LDAA    TMP2                     ; 0BF4: B6 0C 20       
                TAP                              ; 0BF7: 06             
                ADCB    TMP1                     ; 0BF8: F9 0C 1F       
                ROLB                             ; 0BFB: 59             
                INX                              ; 0BFC: 08             
                DEC     TMP3                     ; 0BFD: 7A 0C 21       
                BNE     HASH2                    ; 0C00: 26 E4          
                RORB                             ; 0C02: 56             
                TBA                              ; 0C03: 17             
                RORA                             ; 0C04: 46             
                RORA                             ; 0C05: 46             
                RORA                             ; 0C06: 46             
                RORA                             ; 0C07: 46             
                ABA                              ; 0C08: 1B             
                TAB                              ; 0C09: 16             
                ANDB    #$1F                     ; 0C0A: C4 1F          
                CMPB    #$13                     ; 0C0C: C1 13          
                BLS     Z0C18                    ; 0C0E: 23 08          
                SUBB    #$14                     ; 0C10: C0 14          
                CMPB    #$09                     ; 0C12: C1 09          
                BHI     Z0C18                    ; 0C14: 22 02          
                ASRA                             ; 0C16: 47             
                ROLB                             ; 0C17: 59             
Z0C18           TBA                              ; 0C18: 17             
                RTS                              ; 0C19: 39             
M0C1A           FCB     $00                      ; 0C1A: 00             
M0C1B           FCB     $00                      ; 0C1B: 00             
M0C1C           FCB     $00                      ; 0C1C: 00             
M0C1D           FCB     $00                      ; 0C1D: 00             
                FCB     $00                      ; 0C1E: 00             
TMP1            FCB     $00                      ; 0C1F: 00             
TMP2            FCB     $00                      ; 0C20: 00             
TMP3            FCB     $00                      ; 0C21: 00             
M0C22           FCB     $00                      ; 0C22: 00             
M0C23           FCB     $00                      ; 0C23: 00             
M0C24           FCB     $00                      ; 0C24: 00             
                FCB     $00                      ; 0C25: 00             
M0C26           FCB     $00                      ; 0C26: 00             
M0C27           FCB     $00                      ; 0C27: 00             
                STAB    M0F1C                    ; 0C28: F7 0F 1C       
                LDX     $11,X                    ; 0C2B: EE 11          
                STX     M0F1F                    ; 0C2D: FF 0F 1F       
                ANDB    #$07                     ; 0C30: C4 07          
                BEQ     Z0C3E                    ; 0C32: 27 0A          
                CLC                              ; 0C34: 0C             
Z0C35           RORB                             ; 0C35: 56             
                BCC     Z0C35                    ; 0C36: 24 FD          
                TSTB                             ; 0C38: 5D             
                BEQ     Z0C3E                    ; 0C39: 27 03          
Z0C3B           JMP     Z0DBF                    ; 0C3B: 7E 0D BF       
Z0C3E           LDAB    M0F1C                    ; 0C3E: F6 0F 1C       
                BITB    #$08                     ; 0C41: C5 08          
                BNE     Z0C3B                    ; 0C43: 26 F6          
                ANDB    #$A0                     ; 0C45: C4 A0          
                BEQ     Z0C63                    ; 0C47: 27 1A          
                CMPB    #$A0                     ; 0C49: C1 A0          
                BEQ     Z0C3B                    ; 0C4B: 27 EE          
                LDAB    M0F1C                    ; 0C4D: F6 0F 1C       
                BITB    #$50                     ; 0C50: C5 50          
                BNE     Z0C3B                    ; 0C52: 26 E7          
                BITB    #$20                     ; 0C54: C5 20          
                BNE     Z0C5E                    ; 0C56: 26 06          
                BITB    #$07                     ; 0C58: C5 07          
                BEQ     Z0C3B                    ; 0C5A: 27 DF          
                BRA     Z0C63                    ; 0C5C: 20 05          
Z0C5E           JSR     Z0EC0                    ; 0C5E: BD 0E C0       
                BEQ     Z0C3B                    ; 0C61: 27 D8          
Z0C63           TSX                              ; 0C63: 30             
                LDX     $05,X                    ; 0C64: EE 05          
                LDAA    ,X                       ; 0C66: A6 00          
                ANDA    #$03                     ; 0C68: 84 03          
                STAA    M0F30                    ; 0C6A: B7 0F 30       
                LDAB    M0F1C                    ; 0C6D: F6 0F 1C       
                BITB    #$40                     ; 0C70: C5 40          
                BNE     Z0C90                    ; 0C72: 26 1C          
                LDAB    #$02                     ; 0C74: C6 02          
                SWI                              ; 0C76: 3F             
                FCB     $1C                      ; 0C77: 1C             
                BCC     Z0C87                    ; 0C78: 24 0D          
                CMPB    #$01                     ; 0C7A: C1 01          
                BNE     Z0C81                    ; 0C7C: 26 03          
                JMP     Z0DD0                    ; 0C7E: 7E 0D D0       
Z0C81           LDAB    #$0C                     ; 0C81: C6 0C          
                SWI                              ; 0C83: 3F             
                BRA     Z0CC5                    ; 0C84: 20 3F          
                FCB     $1A                      ; 0C86: 1A             
Z0C87           LDAA    $0D,X                    ; 0C87: A6 0D          
                BITA    #$10                     ; 0C89: 85 10          
                BNE     Z0C9C                    ; 0C8B: 26 0F          
Z0C8D           JMP     Z0DD4                    ; 0C8D: 7E 0D D4       
Z0C90           STAA    M0000                    ; 0C90: 97 00          
                BEQ     Z0CA2                    ; 0C92: 27 0E          
                JSR     RESTOR                   ; 0C94: BD E8 75       
                TSX                              ; 0C97: 30             
                LDX     $05,X                    ; 0C98: EE 05          
                BRA     Z0CA2                    ; 0C9A: 20 06          
Z0C9C           ANDA    #$07                     ; 0C9C: 84 07          
                CMPA    #$02                     ; 0C9E: 81 02          
Z0CA0           BNE     Z0C8D                    ; 0CA0: 26 EB          
Z0CA2           JSR     Z0DE0                    ; 0CA2: BD 0D E0       
                LDX     M0F24                    ; 0CA5: FE 0F 24       
                LDX     $78,X                    ; 0CA8: EE 78          
                STX     M0F26                    ; 0CAA: FF 0F 26       
                JSR     Z0E6C                    ; 0CAD: BD 0E 6C       
                LDAB    M0F26                    ; 0CB0: F6 0F 26       
                LDAA    M0F27                    ; 0CB3: B6 0F 27       
                LDX     M0F28                    ; 0CB6: FE 0F 28       
                SWI                              ; 0CB9: 3F             
                BVS     Z0CE1                    ; 0CBA: 29 25          
                SEV                              ; 0CBC: 0B             
                STX     M0F28                    ; 0CBD: FF 0F 28       
                LDX     M0F26                    ; 0CC0: FE 0F 26       
                JSR     Z0E1A                    ; 0CC3: BD 0E 1A       
                BCC     Z0CCB                    ; 0CC6: 24 03          
Z0CC8           JMP     Z0DD8                    ; 0CC8: 7E 0D D8       
Z0CCB           LDX     M0F28                    ; 0CCB: FE 0F 28       
                LDAB    M0F1C                    ; 0CCE: F6 0F 1C       
                BITB    #$A0                     ; 0CD1: C5 A0          
                BNE     Z0CDF                    ; 0CD3: 26 0A          
                BITB    #$07                     ; 0CD5: C5 07          
                BEQ     Z0CDF                    ; 0CD7: 27 06          
                LDAA    #$08                     ; 0CD9: 86 08          
                SWI                              ; 0CDB: 3F             
                BVC     Z0D03                    ; 0CDC: 28 25          
                ADCB    $FF,X                    ; 0CDE: E9 FF          
                SEI                              ; 0CE0: 0F             
Z0CE1           BPL     Z0CA0                    ; 0CE1: 2A BD          
                CLI                              ; 0CE3: 0E             
                PSHB                             ; 0CE4: 37             
                BCS     Z0CC8                    ; 0CE5: 25 E1          
                LDAB    M0F1C                    ; 0CE7: F6 0F 1C       
                BITB    #$10                     ; 0CEA: C5 10          
                BEQ     Z0D08                    ; 0CEC: 27 1A          
                LDX     M0F2A                    ; 0CEE: FE 0F 2A       
                LDAB    ENDSYs                   ; 0CF1: F6 01 0A       
                LDAA    M010B                    ; 0CF4: B6 01 0B       
                SWI                              ; 0CF7: 3F             
                BLE     Z0D1F                    ; 0CF8: 2F 25          
                FCB     $CD                      ; 0CFA: CD             
                LDAB    ENDOSs                   ; 0CFB: F6 01 06       
                LDAA    M0107                    ; 0CFE: B6 01 07       
                SWI                              ; 0D01: 3F             
                BLE     Z0D28                    ; 0D02: 2F 24          
                FCB     $C3                      ; 0D04: C3             
                STX     ENDUSs                   ; 0D05: FF 01 08       
Z0D08           LDX     M0F2C                    ; 0D08: FE 0F 2C       
                LDAB    M0F1C                    ; 0D0B: F6 0F 1C       
                BITB    #$04                     ; 0D0E: C5 04          
                BEQ     Z0D15                    ; 0D10: 27 03          
                LDX     M0F1F                    ; 0D12: FE 0F 1F       
Z0D15           JSR     Z0E03                    ; 0D15: BD 0E 03       
                STX     M0F1D                    ; 0D18: FF 0F 1D       
                LDAB    M0F1C                    ; 0D1B: F6 0F 1C       
                BITB    #$07                     ; 0D1E: C5 07          
                BEQ     Z0D69                    ; 0D20: 27 47          
                BITB    #$20                     ; 0D22: C5 20          
                BNE     Z0D69                    ; 0D24: 26 43          
                BITB    #$02                     ; 0D26: C5 02          
Z0D28           BNE     Z0D61                    ; 0D28: 26 37          
Z0D2A           JSR     Z0EA9                    ; 0D2A: BD 0E A9       
                JSR     Z0E49                    ; 0D2D: BD 0E 49       
                LDS     #XSTAKs                  ; 0D30: 8E FF 8A       
                LDAB    M0F1C                    ; 0D33: F6 0F 1C       
                BITB    #$80                     ; 0D36: C5 80          
                BNE     Z0D3D                    ; 0D38: 26 03          
                LDS     M0F2A                    ; 0D3A: BE 0F 2A       
Z0D3D           BITB    #$20                     ; 0D3D: C5 20          
                BEQ     Z0D4E                    ; 0D3F: 27 0D          
                LDX     M0F1D                    ; 0D41: FE 0F 1D       
                LDAB    #$37                     ; 0D44: C6 37          
                STAB    PROM_0                   ; 0D46: F7 FC FC       
                TST     PROM_0                   ; 0D49: 7D FC FC       
                JMP     ,X                       ; 0D4C: 6E 00          
Z0D4E           LDAA    M0F1D                    ; 0D4E: B6 0F 1D       
                LDAB    M0F1E                    ; 0D51: F6 0F 1E       
                PSHB                             ; 0D54: 37             
                PSHA                             ; 0D55: 36             
                LDAA    M0F2E                    ; 0D56: B6 0F 2E       
                LDAB    M0F2F                    ; 0D59: F6 0F 2F       
                PSHB                             ; 0D5C: 37             
                PSHA                             ; 0D5D: 36             
                JMP     READPS                   ; 0D5E: 7E E8 6D       
Z0D61           JSR     Z0EEC                    ; 0D61: BD 0E EC       
                STX     M0F1D                    ; 0D64: FF 0F 1D       
                BRA     Z0D2A                    ; 0D67: 20 C1          
Z0D69           JSR     Z0E49                    ; 0D69: BD 0E 49       
                LDAB    M0F1C                    ; 0D6C: F6 0F 1C       
                BITB    #$20                     ; 0D6F: C5 20          
                BEQ     Z0D78                    ; 0D71: 27 05          
                LDAB    #$32                     ; 0D73: C6 32          
                STAB    PROM_0                   ; 0D75: F7 FC FC       
Z0D78           JSR     READPS                   ; 0D78: BD E8 6D       
                LDAB    M0F1C                    ; 0D7B: F6 0F 1C       
                BITB    #$20                     ; 0D7E: C5 20          
                BEQ     Z0D9E                    ; 0D80: 27 1C          
                LDAA    #$00                     ; 0D82: 86 00          
                STAA    PROM_0                   ; 0D84: B7 FC FC       
                BCS     Z0D9E                    ; 0D87: 25 15          
                BITB    #$07                     ; 0D89: C5 07          
                BEQ     Z0D9E                    ; 0D8B: 27 11          
                BITB    #$02                     ; 0D8D: C5 02          
                BEQ     Z0D2A                    ; 0D8F: 27 99          
                LDAB    #$30                     ; 0D91: C6 30          
                STAB    MFFE3                    ; 0D93: F7 FF E3       
                STAB    PROM_0                   ; 0D96: F7 FC FC       
                JSR     Z0EEC                    ; 0D99: BD 0E EC       
                JMP     ,X                       ; 0D9C: 6E 00          
Z0D9E           LDAA    M0F26                    ; 0D9E: B6 0F 26       
                LDAB    M0F27                    ; 0DA1: F6 0F 27       
                TSX                              ; 0DA4: 30             
                LDX     $05,X                    ; 0DA5: EE 05          
                STAA    $0F,X                    ; 0DA7: A7 0F          
                STAB    $10,X                    ; 0DA9: E7 10          
                LDAA    M0F2C                    ; 0DAB: B6 0F 2C       
                LDAB    M0F2D                    ; 0DAE: F6 0F 2D       
                STAA    $11,X                    ; 0DB1: A7 11          
                STAB    $12,X                    ; 0DB3: E7 12          
                LDAB    M0008                    ; 0DB5: D6 08          
                CMPB    #$30                     ; 0DB7: C1 30          
                BNE     Z0DBD                    ; 0DB9: 26 02          
                CLRB                             ; 0DBB: 5F             
                RTS                              ; 0DBC: 39             
Z0DBD           SEC                              ; 0DBD: 0D             
                RTS                              ; 0DBE: 39             
Z0DBF           LDAB    #$01                     ; 0DBF: C6 01          
Z0DC1           TSX                              ; 0DC1: 30             
                LDX     $05,X                    ; 0DC2: EE 05          
                LDAA    M0F1F                    ; 0DC4: B6 0F 1F       
                STAA    $11,X                    ; 0DC7: A7 11          
                LDAA    M0F20                    ; 0DC9: B6 0F 20       
                STAA    $12,X                    ; 0DCC: A7 12          
                SEC                              ; 0DCE: 0D             
                RTS                              ; 0DCF: 39             
Z0DD0           LDAB    #$03                     ; 0DD0: C6 03          
                BRA     Z0DC1                    ; 0DD2: 20 ED          
Z0DD4           LDAB    #$04                     ; 0DD4: C6 04          
                BRA     Z0DC1                    ; 0DD6: 20 E9          
Z0DD8           LDAB    #$05                     ; 0DD8: C6 05          
                BRA     Z0DC1                    ; 0DDA: 20 E5          
Z0DDC           LDAB    #$06                     ; 0DDC: C6 06          
                BRA     Z0DC1                    ; 0DDE: 20 E1          
Z0DE0           LDAA    $0B,X                    ; 0DE0: A6 0B          
                LDAB    $0C,X                    ; 0DE2: E6 0C          
                LDX     $15,X                    ; 0DE4: EE 15          
                STX     M0F24                    ; 0DE6: FF 0F 24       
                STAA    M0F22                    ; 0DE9: B7 0F 22       
                STAB    M0F23                    ; 0DEC: F7 0F 23       
                LDAB    M0F30                    ; 0DEF: F6 0F 30       
                LDX     #M0F21                   ; 0DF2: CE 0F 21       
                SWI                              ; 0DF5: 3F             
                RTS                              ; 0DF6: 39             
                JSR     CHKERR                   ; 0DF7: BD E8 53       
                LDX     M0F24                    ; 0DFA: FE 0F 24       
                LDX     $7A,X                    ; 0DFD: EE 7A          
                STX     M0F2C                    ; 0DFF: FF 0F 2C       
                RTS                              ; 0E02: 39             
Z0E03           SWI                              ; 0E03: 3F             
Z0E04           BCC     Z0E04                    ; 0E04: 24 FE          
                SEI                              ; 0E06: 0F             
                BNE     Z0E48                    ; 0E07: 26 3F          
                BLE     Z0E2F                    ; 0E09: 2F 24          
                FCB     $04                      ; 0E0B: 04             
                INS                              ; 0E0C: 31             
                INS                              ; 0E0D: 31             
                BRA     Z0DDC                    ; 0E0E: 20 CC          
                LDX     M0F28                    ; 0E10: FE 0F 28       
                SWI                              ; 0E13: 3F             
                BNE     Z0E55                    ; 0E14: 26 3F          
                BLE     Z0E3D                    ; 0E16: 2F 25          
                FCB     $F3                      ; 0E18: F3             
                RTS                              ; 0E19: 39             
Z0E1A           CLC                              ; 0E1A: 0C             
                LDAB    M0F1C                    ; 0E1B: F6 0F 1C       
                BITB    #$20                     ; 0E1E: C5 20          
                BNE     Z0E36                    ; 0E20: 26 14          
                BITB    #$80                     ; 0E22: C5 80          
                BEQ     Z0E2E                    ; 0E24: 27 08          
                LDAB    ENDRVs                   ; 0E26: F6 01 10       
                LDAA    M0111                    ; 0E29: B6 01 11       
                BRA     Z0E34                    ; 0E2C: 20 06          
Z0E2E           LDAB    ENDOSs                   ; 0E2E: F6 01 06       
                LDAA    M0107                    ; 0E31: B6 01 07       
Z0E34           SWI                              ; 0E34: 3F             
                BLT     Z0E70                    ; 0E35: 2D 39          
                LDAB    M0F1C                    ; 0E37: F6 0F 1C       
                BITB    #$A0                     ; 0E3A: C5 A0          
                BNE     Z0E47                    ; 0E3C: 26 09          
                LDAB    ENDSYs                   ; 0E3E: F6 01 0A       
                LDAA    M010B                    ; 0E41: B6 01 0B       
                SWI                              ; 0E44: 3F             
                BGT     Z0E80                    ; 0E45: 2E 39          
Z0E47           CLC                              ; 0E47: 0C             
Z0E48           RTS                              ; 0E48: 39             
Z0E49           TSX                              ; 0E49: 30             
                LDX     $07,X                    ; 0E4A: EE 07          
                LDAA    M0F30                    ; 0E4C: B6 0F 30       
                STAA    M0000                    ; 0E4F: 97 00          
                LDX     M0F22                    ; 0E51: FE 0F 22       
                INX                              ; 0E54: 08             
Z0E55           STX     M0001                    ; 0E55: DF 01          
                LDX     M0F24                    ; 0E57: FE 0F 24       
                LDAA    $75,X                    ; 0E5A: A6 75          
                ADDA    #$07                     ; 0E5C: 8B 07          
                ANDA    #$F8                     ; 0E5E: 84 F8          
                STAA    M0005                    ; 0E60: 97 05          
                LDX     $76,X                    ; 0E62: EE 76          
                STX     M0003                    ; 0E64: DF 03          
                LDX     M0F26                    ; 0E66: FE 0F 26       
                STX     M0006                    ; 0E69: DF 06          
                RTS                              ; 0E6B: 39             
Z0E6C           LDX     M0F24                    ; 0E6C: FE 0F 24       
                LDX     $76,X                    ; 0E6F: EE 76          
                BEQ     Z0E96                    ; 0E71: 27 23          
                DEX                              ; 0E73: 09             
                STX     M0F28                    ; 0E74: FF 0F 28       
                LDX     #M0F28                   ; 0E77: CE 0F 28       
                LDAA    #$07                     ; 0E7A: 86 07          
                SWI                              ; 0E7C: 3F             
                FCB     $18                      ; 0E7D: 18             
                LDX     M0F24                    ; 0E7E: FE 0F 24       
                LDAA    $75,X                    ; 0E81: A6 75          
                BEQ     Z0E96                    ; 0E83: 27 11          
                ADDA    #$07                     ; 0E85: 8B 07          
                ANDA    #$F8                     ; 0E87: 84 F8          
                DECA                             ; 0E89: 4A             
                ADDA    M0F29                    ; 0E8A: BB 0F 29       
                STAA    M0F29                    ; 0E8D: B7 0F 29       
                BCC     Z0E95                    ; 0E90: 24 03          
                INC     M0F28                    ; 0E92: 7C 0F 28       
Z0E95           RTS                              ; 0E95: 39             
Z0E96           INS                              ; 0E96: 31             
                INS                              ; 0E97: 31             
                JMP     Z0DD4                    ; 0E98: 7E 0D D4       
Z0E9B           LDX     #BRKPTs                  ; 0E9B: CE FF 1F       
Z0E9E           CLR     ,X                       ; 0E9E: 6F 00          
                CPX     #MFF63                   ; 0EA0: 8C FF 63       
                BEQ     Z0EA8                    ; 0EA3: 27 03          
                INX                              ; 0EA5: 08             
                BRA     Z0E9E                    ; 0EA6: 20 F6          
Z0EA8           RTS                              ; 0EA8: 39             
Z0EA9           LDAB    M0F1C                    ; 0EA9: F6 0F 1C       
                BITB    #$A0                     ; 0EAC: C5 A0          
                BEQ     Z0EBF                    ; 0EAE: 27 0F          
                LDX     SWIsSV                   ; 0EB0: FE 01 16       
                STX     SWIsVC                   ; 0EB3: FF FF FA       
                LDX     IRQsSV                   ; 0EB6: FE 01 1C       
                STX     IRQsVC                   ; 0EB9: FF FF F8       
                JSR     Z0E9B                    ; 0EBC: BD 0E 9B       
Z0EBF           RTS                              ; 0EBF: 39             
Z0EC0           JSR     Z0ED3                    ; 0EC0: BD 0E D3       
                BNE     Z0ED2                    ; 0EC3: 26 0D          
                COMB                             ; 0EC5: 53             
                STAB    SWIsVC                   ; 0EC6: F7 FF FA       
                JSR     Z0ED3                    ; 0EC9: BD 0E D3       
                TPA                              ; 0ECC: 07             
                COMB                             ; 0ECD: 53             
                STAB    SWIsVC                   ; 0ECE: F7 FF FA       
                TAP                              ; 0ED1: 06             
Z0ED2           RTS                              ; 0ED2: 39             
Z0ED3           LDAB    SWIsVC                   ; 0ED3: F6 FF FA       
                LDAA    #$30                     ; 0ED6: 86 30          
                STAA    PROM_0                   ; 0ED8: B7 FC FC       
                LDX     #SWIsVC                  ; 0EDB: CE FF FA       
                TST     PROM_0                   ; 0EDE: 7D FC FC       
                LDAA    ,X                       ; 0EE1: A6 00          
                PSHA                             ; 0EE3: 36             
                LDAA    #$00                     ; 0EE4: 86 00          
                STAA    PROM_0                   ; 0EE6: B7 FC FC       
                PULA                             ; 0EE9: 32             
                CBA                              ; 0EEA: 11             
                RTS                              ; 0EEB: 39             
Z0EEC           LDX     M0F2C                    ; 0EEC: FE 0F 2C       
                STX     XREGsP                   ; 0EEF: FF FF 16       
                LDX     M0F26                    ; 0EF2: FE 0F 26       
                STX     XREGsX                   ; 0EF5: FF FF 18       
                LDX     M0F2A                    ; 0EF8: FE 0F 2A       
                LDAB    M0F1C                    ; 0EFB: F6 0F 1C       
                BITB    #$80                     ; 0EFE: C5 80          
                BEQ     Z0F05                    ; 0F00: 27 03          
                LDX     #XSTAKs                  ; 0F02: CE FF 8A       
Z0F05           STX     XREGsS                   ; 0F05: FF FF 1D       
                JSR     Z0E9B                    ; 0F08: BD 0E 9B       
                JSR     Z0EA9                    ; 0F0B: BD 0E A9       
                BITB    #$A0                     ; 0F0E: C5 A0          
                BNE     Z0F18                    ; 0F10: 26 06          
                LDX     #M020F                   ; 0F12: CE 02 0F       
                STX     SWIsVC                   ; 0F15: FF FF FA       
Z0F18           LDX     #MAIDs                   ; 0F18: CE F0 F3       
                RTS                              ; 0F1B: 39             
M0F1C           FCB     $00                      ; 0F1C: 00             
M0F1D           FCB     $00                      ; 0F1D: 00             
M0F1E           FCB     $00                      ; 0F1E: 00             
M0F1F           FCB     $00                      ; 0F1F: 00             
M0F20           FCB     $00                      ; 0F20: 00             
M0F21           FCB     $00                      ; 0F21: 00             
M0F22           FCB     $00                      ; 0F22: 00             
M0F23           FCB     $00                      ; 0F23: 00             
M0F24           FCB     $00,$00                  ; 0F24: 00 00          
M0F26           FCB     $00                      ; 0F26: 00             
M0F27           FCB     $00                      ; 0F27: 00             
M0F28           FCB     $00                      ; 0F28: 00             
M0F29           FCB     $00                      ; 0F29: 00             
M0F2A           FCB     $00,$00                  ; 0F2A: 00 00          
M0F2C           FCB     $00                      ; 0F2C: 00             
M0F2D           FCB     $00                      ; 0F2D: 00             
M0F2E           FCB     $E8                      ; 0F2E: E8             
M0F2F           FCB     $53                      ; 0F2F: 53             
M0F30           FCB     $00                      ; 0F30: 00             
Z0F31           CLR     M110C                    ; 0F31: 7F 11 0C       
                STX     M1105                    ; 0F34: FF 11 05       
                STAB    M110B                    ; 0F37: F7 11 0B       
                CMPB    #$01                     ; 0F3A: C1 01          
                BLS     Z0F8B                    ; 0F3C: 23 4D          
                TBA                              ; 0F3E: 17             
                LDX     #M1107                   ; 0F3F: CE 11 07       
                JSR     Z10E5                    ; 0F42: BD 10 E5       
                LDX     #MFF9C                   ; 0F45: CE FF 9C       
                STX     M016E                    ; 0F48: FF 01 6E       
                LDX     #MFFDD                   ; 0F4B: CE FF DD       
                STX     M0170                    ; 0F4E: FF 01 70       
                LDX     M017B                    ; 0F51: FE 01 7B       
                BEQ     Z0F5F                    ; 0F54: 27 09          
                LDX     #M0000                   ; 0F56: CE 00 00       
                STX     M017B                    ; 0F59: FF 01 7B       
                STX     M0187                    ; 0F5C: FF 01 87       
Z0F5F           LDX     #SYEOCB                  ; 0F5F: CE 01 6A       
                SWI                              ; 0F62: 3F             
                FCB     $04                      ; 0F63: 04             
                BEQ     Z0F6A                    ; 0F64: 27 04          
                CMPB    #$0D                     ; 0F66: C1 0D          
                BNE     Z0F7E                    ; 0F68: 26 14          
Z0F6A           LDX     MFF9C                    ; 0F6A: FE FF 9C       
                CPX     M1107                    ; 0F6D: BC 11 07       
                BNE     Z0F5F                    ; 0F70: 26 ED          
                LDX     M016C                    ; 0F72: FE 01 6C       
                LDAB    #$04                     ; 0F75: C6 04          
                STAB    ,X                       ; 0F77: E7 00          
                LDX     #MFF9E                   ; 0F79: CE FF 9E       
                BRA     Z0F96                    ; 0F7C: 20 18          
Z0F7E           LDX     #M110B                   ; 0F7E: CE 11 0B       
                STX     M1105                    ; 0F81: FF 11 05       
                LDX     #M113B                   ; 0F84: CE 11 3B       
                LDAB    #$FF                     ; 0F87: C6 FF          
                BRA     Z0F99                    ; 0F89: 20 0E          
Z0F8B           LDX     #M1137                   ; 0F8B: CE 11 37       
                TBA                              ; 0F8E: 17             
                CLRB                             ; 0F8F: 5F             
                ASLA                             ; 0F90: 48             
                ROLB                             ; 0F91: 59             
                SWI                              ; 0F92: 3F             
                BVS     Z0F83                    ; 0F93: 29 EE          
                FCB     $00                      ; 0F95: 00             
Z0F96           LDAB    M110B                    ; 0F96: F6 11 0B       
Z0F99           SWI                              ; 0F99: 3F             
                BLS     Z0F9B                    ; 0F9A: 23 FF          
                CBA                              ; 0F9C: 11             
                NOP                              ; 0F9D: 01             
                LDX     #MFF8D                   ; 0F9E: CE FF 8D       
                LDAB    #$0D                     ; 0FA1: C6 0D          
                STAB    ,X                       ; 0FA3: E7 00          
M0FA5           FCB     $08,$C6                  ; 0FA5: 08 C6          
                FCB     $2A                      ; 0FA7: 2A             
                FCB     $E7,$00,$08,$E7,$00,$08  ; 0FA8: E7 00 08 E7 00 08 
                FCB     $FF,$11,$03,$FE,$11,$05  ; 0FAE: FF 11 03 FE 11 05 
                FCB     $F6,$11,$0B              ; 0FB4: F6 11 0B       
                FCB     $27,$3E                  ; 0FB7: 27 3E          
                FCB     $C1,$01,$26,$1B,$E6,$01  ; 0FB9: C1 01 26 1B E6 01 
                FCB     $A6,$02,$CE,$11,$90,$BD  ; 0FBF: A6 02 CE 11 90 BD 
                FCB     $10,$E0,$96,$00,$8A      ; 0FC5: 10 E0 96 00 8A 
                FCB     $30                      ; 0FCA: 30             
                FCB     $B7,$11,$9E,$D6,$01,$96  ; 0FCB: B7 11 9E D6 01 96 
                FCB     $02,$CE,$11,$A4,$BD,$10  ; 0FD1: 02 CE 11 A4 BD 10 
                FCB     $E0,$FE,$11,$01,$A6,$00  ; 0FD7: E0 FE 11 01 A6 00 
                FCB     $81,$04                  ; 0FDD: 81 04          
                FCB     $27,$5A                  ; 0FDF: 27 5A          
                FCB     $81                      ; 0FE1: 81             
                FCB     $5C,$27,$2B              ; 0FE2: 5C 27 2B       
                FCB     $FE,$11,$03,$A7,$00,$08  ; 0FE5: FE 11 03 A7 00 08 
                FCB     $FF,$11,$03,$FE,$11,$01  ; 0FEB: FF 11 03 FE 11 01 
                FCB     $08,$FF,$11,$01          ; 0FF1: 08 FF 11 01    
                FCB     $20                      ; 0FF5: 20             
                FCB     $E1                      ; 0FF6: E1             
                FCB     $7D                      ; 0FF7: 7D             
                FCB     $11,$0C,$26,$DC          ; 0FF8: 11 0C 26 DC    
                FCB     $7C                      ; 0FFC: 7C             
                FCB     $11,$0C,$A6,$00          ; 0FFD: 11 0C A6 00    
                FCB     $4A                      ; 1001: 4A             
                FCB     $81,$18,$22,$D2,$CE,$11  ; 1002: 81 18 22 D2 CE 11 
                FCB     $1E                      ; 1008: 1E             
                FCB     $3F,$28                  ; 1009: 3F 28          
                FCB     $E6,$00                  ; 100B: E6 00          
                FCB     $7E                      ; 100D: 7E             
                FCB     $0F                      ; 100E: 0F             
                FCB     $37                      ; 100F: 37             
                FCB     $08,$FF,$11,$01,$A6,$00  ; 1010: 08 FF 11 01 A6 00 
                FCB     $CE,$11,$0D              ; 1016: CE 11 0D       
                FCB     $6D                      ; 1019: 6D             
                FCB     $00                      ; 101A: 00             
                FCB     $27                      ; 101B: 27             
                FCB     $BB,$A1,$00              ; 101C: BB A1 00       
                FCB     $27                      ; 101F: 27             
                FCB     $06,$C6,$04              ; 1020: 06 C6 04       
                FCB     $3F,$27,$20              ; 1023: 3F 27 20       
                FCB     $F2                      ; 1026: F2             
                FCB     $7C                      ; 1027: 7C             
                FCB     $11,$02,$26,$03          ; 1028: 11 02 26 03    
                FCB     $7C                      ; 102C: 7C             
                FCB     $11,$01,$E6,$01,$EE,$02  ; 102D: 11 01 E6 01 EE 02 
                FCB     $FF,$10                  ; 1033: FF 10          
                FCB     $37                      ; 1035: 37             
                FCB     $BD,$10                  ; 1036: BD 10          
                FCB     $36,$20                  ; 1038: 36 20          
                FCB     $9D,$FE,$11,$03,$86,$04  ; 103A: 9D FE 11 03 86 04 
                FCB     $A7,$00,$CE,$09,$8F,$AD  ; 1040: A7 00 CE 09 8F AD 
                FCB     $03,$01                  ; 1046: 03 01          
                FCB     $20                      ; 1048: 20             
                FCB     $CE,$FF,$8D,$BD,$F0      ; 1049: CE FF 8D BD F0 
                FCB     $24                      ; 104E: 24             
                FCB     $BD,$F0                  ; 104F: BD F0          
                FCB     $21                      ; 1051: 21             
                FCB     $0C                      ; 1052: 0C             
                FCB     $39                      ; 1053: 39             
                FCB     $FE,$11,$03,$FF,$11,$09  ; 1054: FE 11 03 FF 11 09 
                FCB     $FE,$11,$05,$08,$FF,$11  ; 105A: FE 11 05 08 FF 11 
                FCB     $07,$C6,$08,$CE,$11,$07  ; 1060: 07 C6 08 CE 11 07 
                FCB     $3F                      ; 1066: 3F             
                FCB     $10,$FE,$11,$09,$86      ; 1067: 10 FE 11 09 86 
                FCB     $2E                      ; 106C: 2E             
                FCB     $A7,$00,$08,$FF,$11,$09  ; 106D: A7 00 08 FF 11 09 
                FCB     $C6,$02,$CE,$11,$07      ; 1073: C6 02 CE 11 07 
                FCB     $3F                      ; 1078: 3F             
                FCB     $10,$FE,$11,$05,$E6,$00  ; 1079: 10 FE 11 05 E6 00 
                FCB     $FE,$11,$09,$86          ; 107F: FE 11 09 86    
                FCB     $3A                      ; 1083: 3A             
                FCB     $A7,$00,$08,$E7,$00,$08  ; 1084: A7 00 08 E7 00 08 
                FCB     $FF,$11,$03,$FE,$11,$07  ; 108A: FF 11 03 FE 11 07 
                FCB     $FF,$11,$05              ; 1090: FF 11 05       
                FCB     $39                      ; 1093: 39             
                FCB     $FE,$11,$05,$FF,$11,$07  ; 1094: FE 11 05 FF 11 07 
                FCB     $FE,$11,$03,$17,$BB,$11  ; 109A: FE 11 03 17 BB 11 
                FCB     $04,$B7,$11,$04          ; 10A0: 04 B7 11 04    
                FCB     $24                      ; 10A4: 24             
                FCB     $03                      ; 10A5: 03             
                FCB     $7C                      ; 10A6: 7C             
                FCB     $11,$03,$B6,$11,$08,$C1  ; 10A7: 11 03 B6 11 08 C1 
                FCB     $04,$26,$07,$F6,$11,$07  ; 10AD: 04 26 07 F6 11 07 
                FCB     $BD,$10,$E0              ; 10B3: BD 10 E0       
                FCB     $39                      ; 10B6: 39             
                FCB     $BD,$10,$E5              ; 10B7: BD 10 E5       
                FCB     $39                      ; 10BA: 39             
                FCB     $FE,$11,$05,$A6,$00,$7F  ; 10BB: FE 11 05 A6 00 7F 
                FCB     $11,$07,$B7,$11,$08,$17  ; 10C1: 11 07 B7 11 08 17 
                FCB     $47                      ; 10C7: 47             
                FCB     $BB,$11,$06,$B7,$11,$06  ; 10C8: BB 11 06 B7 11 06 
                FCB     $24                      ; 10CE: 24             
                FCB     $03                      ; 10CF: 03             
                FCB     $7C                      ; 10D0: 7C             
                FCB     $11,$05                  ; 10D1: 11 05          
                FCB     $20                      ; 10D3: 20             
                FCB     $C5                      ; 10D4: C5             
                FCB     $30                      ; 10D5: 30             
                FCB     $EE,$09,$09,$09,$FF,$11  ; 10D6: EE 09 09 09 FF 11 
                FCB     $05                      ; 10DC: 05             
                FCB     $7E                      ; 10DD: 7E             
                FCB     $10,$94                  ; 10DE: 10 94          
                FCB     $36                      ; 10E0: 36             
                FCB     $17,$8D,$01              ; 10E1: 17 8D 01       
                FCB     $32                      ; 10E4: 32             
Z10E5           PSHA                             ; 10E5: 36             
                BSR     Z10F2                    ; 10E6: 8D 0A          
                STAA    ,X                       ; 10E8: A7 00          
                INX                              ; 10EA: 08             
                PULA                             ; 10EB: 32             
                BSR     Z10F6                    ; 10EC: 8D 08          
                STAA    ,X                       ; 10EE: A7 00          
                INX                              ; 10F0: 08             
                RTS                              ; 10F1: 39             
Z10F2           LSRA                             ; 10F2: 44             
                LSRA                             ; 10F3: 44             
                LSRA                             ; 10F4: 44             
                LSRA                             ; 10F5: 44             
Z10F6           ANDA    #$0F                     ; 10F6: 84 0F          
                ADDA    #$30                     ; 10F8: 8B 30          
                CMPA    #$39                     ; 10FA: 81 39          
                BLS     Z1100                    ; 10FC: 23 02          
                ADDA    #$07                     ; 10FE: 8B 07          
Z1100           RTS                              ; 1100: 39             
                FCB     $00                      ; 1101: 00             
                FCB     $00                      ; 1102: 00             
                FCB     $00                      ; 1103: 00             
                FCB     $00                      ; 1104: 00             
M1105           FCB     $00,$00                  ; 1105: 00 00          
M1107           FCB     $00,$00,$00,$00          ; 1107: 00 00 00 00    
M110B           FCB     $00                      ; 110B: 00             
M110C           FCB     $00                      ; 110C: 00             
                FCB     $30                      ; 110D: 30             
                FCB     $0D,$10                  ; 110E: 0D 10          
                FCB     $54,$31                  ; 1110: 54 31          
                FCB     $04,$10,$94              ; 1112: 04 10 94       
                FCB     $33                      ; 1115: 33             
                FCB     $02,$10,$BB              ; 1116: 02 10 BB       
                FCB     $38                      ; 1119: 38             
                FCB     $04,$10,$D5,$00,$09,$22  ; 111A: 04 10 D5 00 09 22 
                FCB     $23,$24                  ; 1120: 23 24          
                FCB     $0A,$1A,$1B              ; 1122: 0A 1A 1B       
                FCB     $25                      ; 1125: 25             
                FCB     $26,$13                  ; 1126: 26 13          
                FCB     $27,$28,$29,$2A,$2B      ; 1128: 27 28 29 2A 2B 
                FCB     $1C,$15,$03,$02,$10      ; 112D: 1C 15 03 02 10 
                FCB     $2C                      ; 1132: 2C             
                FCB     $11                      ; 1133: 11             
                FCB     $2D,$2E,$35              ; 1134: 2D 2E 35       
M1137           FCB     $11                      ; 1137: 11             
                FCB     'T                       ; 1138: 54             
                FCB     $11                      ; 1139: 11             
                FCB     't                       ; 113A: 74             
M113B           FCB     'I,'N,'V,'A,'L,'I,'D,'   ; 113B: 49 4E 56 41 4C 49 44 20 
                FCB     'M,'E,'S,'S,'A,'G,'E,'   ; 1143: 4D 45 53 53 41 47 45 20 
                FCB     '\,'3,' ,'A,'T,' ,'\,'8  ; 114B: 5C 33 20 41 54 20 5C 38 
                FCB     $04                      ; 1153: 04             
                FCB     'U,'N,'I,'F,'.,' ,'I,'/  ; 1154: 55 4E 49 46 2E 20 49 2F 
                FCB     'O,' ,'E,'R,'R,'O,'R,'-  ; 115C: 4F 20 45 52 52 4F 52 2D 
                FCB     'S,'T,'A,'T,'U,'S,'=,'\  ; 1164: 53 54 41 54 55 53 3D 5C 
                FCB     '3,' ,'A,'T,' ,'\,'8     ; 116C: 33 20 41 54 20 5C 38 
                FCB     $04                      ; 1173: 04             
                FCB     'P,'R,'O,'M,' ,'I,'/,'O  ; 1174: 50 52 4F 4D 20 49 2F 4F 
                FCB     ' ,'E,'R,'R,'O,'R,'-,'S  ; 117C: 20 45 52 52 4F 52 2D 53 
                FCB     'T,'A,'T,'U,'S,'=,'\,'3  ; 1184: 54 41 54 55 53 3D 5C 33 
                FCB     ' ,'A,'T,' ,'X,'X,'X,'X  ; 118C: 20 41 54 20 58 58 58 58 
                FCB     ' ,'O,'N,' ,'D,'R,'I,'V  ; 1194: 20 4F 4E 20 44 52 49 56 
                FCB     'E,' ,'X,'-,'P,'S,'N,'   ; 119C: 45 20 58 2D 50 53 4E 20 
                FCB     'X,'X,'X,'X              ; 11A4: 58 58 58 58    
                FCB     $04                      ; 11A8: 04             
                FCB     '0,'M,'D,'O,'S,'O,'V     ; 11A9: 30 4D 44 4F 53 4F 56 
                FCB     $00                      ; 11B0: 00             
                FCB     ' ,$53,$59               ; 11B1: 20 53 59       
                FCB     $00,$00,$00,$00,$00,$00  ; 11B4: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$01,$8F  ; 11BA: 00 00 00 00 01 8F 
                FCB     $02,$0E,$FF,$FF,$FF,$FF  ; 11C0: 02 0E FF FF FF FF 
                FCB     $FF,$FF,$FF,$FF,$FF,$FF  ; 11C6: FF FF FF FF FF FF 
                FCB     $FF,$FF,$FF,$FF,$00,$00  ; 11CC: FF FF FF FF 00 00 
                FCB     $01,$01,$01,$01,$01,$01  ; 11D2: 01 01 01 01 01 01 
                FCB     $01,$01,$01,$01,$01,$01  ; 11D8: 01 01 01 01 01 01 
                FCB     $01,$01,$01,$01,$02,$02  ; 11DE: 01 01 01 01 02 02 
                FCB     $03,$03,$03,$04,$05,$06  ; 11E4: 03 03 03 04 05 06 
                FCB     $12                      ; 11EA: 12             
                FCB     $73                      ; 11EB: 73             
                FCB     $18,$9D,$1C,$0D,$1F,$FD  ; 11EC: 18 9D 1C 0D 1F FD 
                FCB     $36                      ; 11F2: 36             
                FCB     $07,$CE,$11,$D0,$F6,$11  ; 11F3: 07 CE 11 D0 F6 11 
                FCB     $EB                      ; 11F9: EB             
                FCB     $20                      ; 11FA: 20             
                FCB     $1C                      ; 11FB: 1C             
                FCB     $36                      ; 11FC: 36             
                FCB     $07,$CE,$11,$E2,$F6,$11  ; 11FD: 07 CE 11 E2 F6 11 
                FCB     $ED                      ; 1203: ED             
                FCB     $20                      ; 1204: 20             
                FCB     $12                      ; 1205: 12             
                FCB     $36                      ; 1206: 36             
                FCB     $07,$CE,$11,$E7,$F6,$11  ; 1207: 07 CE 11 E7 F6 11 
                FCB     $EF                      ; 120D: EF             
                FCB     $20                      ; 120E: 20             
                FCB     $08                      ; 120F: 08             
                FCB     $36                      ; 1210: 36             
                FCB     $07,$CE,$11,$E9,$F6,$11  ; 1211: 07 CE 11 E9 F6 11 
                FCB     $F1                      ; 1217: F1             
                FCB     $36                      ; 1218: 36             
                FCB     $FF,$12                  ; 1219: FF 12          
                FCB     $2A,$30                  ; 121B: 2A 30          
                FCB     $A6,$03,$80,$03,$A7,$03  ; 121D: A6 03 80 03 A7 03 
                FCB     $24                      ; 1223: 24             
                FCB     $02                      ; 1224: 02             
                FCB     $6A                      ; 1225: 6A             
                FCB     $02,$A6,$03,$CE,$00,$00  ; 1226: 02 A6 03 CE 00 00 
                FCB     $10                      ; 122C: 10             
                FCB     $5F                      ; 122D: 5F             
                FCB     $85                      ; 122E: 85             
                FCB     $5C                      ; 122F: 5C             
                FCB     $80,$03                  ; 1230: 80 03          
                FCB     $24                      ; 1232: 24             
                FCB     $FB,$F7,$12              ; 1233: FB F7 12       
                FCB     $38                      ; 1236: 38             
                FCB     $A6,$00                  ; 1237: A6 00          
                FCB     $48                      ; 1239: 48             
                FCB     $B7,$12                  ; 123A: B7 12          
                FCB     $47                      ; 123C: 47             
                FCB     $B7,$12                  ; 123D: B7 12          
                FCB     $44                      ; 123F: 44             
                FCB     $CE,$11,$C2,$E6,$00,$08  ; 1240: CE 11 C2 E6 00 08 
                FCB     $A6,$00,$F7,$11,$B4,$B7  ; 1246: A6 00 F7 11 B4 B7 
                FCB     $11,$B5,$B6,$01,$06      ; 124C: 11 B5 B6 01 06 
                FCB     $36                      ; 1251: 36             
                FCB     $7F,$01,$06,$CE,$11,$A9  ; 1252: 7F 01 06 CE 11 A9 
                FCB     $C6                      ; 1258: C6             
                FCB     $40,$3F                  ; 1259: 40 3F          
                FCB     $1B                      ; 125B: 1B             
                FCB     $25                      ; 125C: 25             
                FCB     $0D                      ; 125D: 0D             
                FCB     $32                      ; 125E: 32             
                FCB     $B7,$01,$06              ; 125F: B7 01 06       
                FCB     $30                      ; 1262: 30             
                FCB     $E6,$07,$EE,$09          ; 1263: E6 07 EE 09    
                FCB     $32                      ; 1267: 32             
                FCB     $06                      ; 1268: 06             
                FCB     $32,$39                  ; 1269: 32 39          
                FCB     $86                      ; 126B: 86             
                FCB     $56                      ; 126C: 56             
                FCB     $97,$08,$0D,$BD,$E8      ; 126D: 97 08 0D BD E8 
                FCB     $53                      ; 1272: 53             


                END
