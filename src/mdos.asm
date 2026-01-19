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
M0082   EQU     $0082
M00AE   EQU     $00AE
GETRC   EQU     $189D
Z18A0via02EB
        EQU     $18A0
CLOSE   EQU     $18A3
REWND   EQU     $18A6
Z18A9via02BD
        EQU     $18A9
OPEN    EQU     $1C0D
Z1F80   EQU     $1F80
M210C   EQU     $210C
M24BD   EQU     $24BD
M8DBD   EQU     $8DBD
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
MFFFF   EQU     $FFFF

;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $0100

VERSss          FDB     $2033                    ; 0100: 20 33          
REVSss          FDB     $3035                    ; 0102: 30 35          
KYIsSV          FDB     KEYIN                    ; 0104: 03 A8          
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
                FCB     'L,'P,'0,' ,' ,' ,' ,'   ; 014D: 4C 50 30 20 20 20 20 20 
                FCB     ' ,' ,' ,' ,'            ; 0155: 20 20 20 20 20 
                FCB     $00,$00,$05,$00,$00,$00  ; 015A: 00 00 05 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 0160: 00 00 00 00 00 00 
                FCB     $00,$7F,$00,$00          ; 0166: 00 7F 00 00    
SYEOCB          FCB     $00,$11                  ; 016A: 00 11          
M016C           FCB     $00,$00                  ; 016C: 00 00          
M016E           FCB     $00,$00                  ; 016E: 00 00          
M0170           FCB     $00,$00                  ; 0170: 00 00          
                FCB     'D,'K,'0,'M,'D,'O,'S,'E  ; 0172: 44 4B 30 4D 44 4F 53 45 
                FCB     'R                       ; 017A: 52             
M017B           FCB     ' ,' ,'S,'Y              ; 017B: 20 20 53 59    
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
M020F           TST     BKPINs                   ; 020F: 7D FF 4F       
                BEQ     SWI_ISR                  ; 0212: 27 1B          
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

; Stack after SWI:
; [[SP]] ← [PC(LO)]     | +7 | E7FF | 4C
; [[SP] - 1] ← [PC(HI)] | +6 | E7FE | 20
; [[SP] - 2] ← [X(LO)]  | +5 | E7FD | A9
; [[SP] - 3] ← [X(HI)]  | +4 | E7FC | 11
; [[SP] - 4] ← [A]      | +3 | E7FB | 2F
; [[SP] - 5] ← [B]      | +2 | E7FA | 02
; [[SP] - 6] ← [SR]     | +1 | E7F9 | D0
; [SP] ← [SP] - 7       | +0 | E7F8 | 00
; [PC(HI)] ← [$FFFA]
; [PC(LO)] ← [$FFFB]

SWI_ISR         TSX                              ; 022F: 30              transfer stackp. +1 to X, X<-SP+1 (E7F9)
                LDS     $05,X                    ; 0230: AE 05           load stackpointer with PC (204C)
                DES                              ; 0232: 34              decr. SP to
                PULB                             ; 0233: 33              get value from after SWI instruction into B, decr. SP
                INS                              ; 0234: 31              incr. SP (204D)
                STS     $05,X                    ; 0235: AF 05           fix return address (jump over the byte after the SWI instr.)
                TXS                              ; 0237: 35              restore stackp. SP<-X-1
                LDAA    ,X                       ; 0238: A6 00           get status reg value
                TAP                              ; 023A: 06              move to SR
                ASLB                             ; 023B: 58              get word address
                BCS     B7_SET                   ; 023C: 25 3B           check for Bit 7 set (Jump to USer Vector)
                CMPB    #$80                     ; 023E: C1 80           is it above $40 ?
                BCC     B6_SET                   ; 0240: 24 2A          
                STAB    M0249                    ; 0242: F7 02 49        patch LDX ,X two lines below
                LDX     #M027F                   ; 0245: CE 02 7F        get vector table
                LDX     ,X                       ; 0248: EE 00           get address with offset
                STX     M025A                    ; 024A: FF 02 5A        patch JSR command below
                TSX                              ; 024D: 30              transfer stackp. +1 to X, X<-SP+1 (E7F9)
                LDAA    $02,X                    ; 024E: A6 02           load old A from Stack
                PSHA                             ; 0250: 36              push old A to Stack and decrement
                LDAA    ,X                       ; 0251: A6 00           load old SR from Stack to A
                LDAB    $01,X                    ; 0253: E6 01           load old B from Stack to B
                LDX     $03,X                    ; 0255: EE 03           load old X from Stack to X
                TAP                              ; 0257: 06              restore SR
                PULA                             ; 0258: 32              get A from Stack into A
Z0259           JSR     Z0259                    ; 0259: BD 02 59        JSR to function from Jumptable
                TSX                              ; 025C: 30              transfer stackp. +1 to X, X<-SP+1 (E7F9)
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
B6_SET          LDAB    #$21                     ; 026C: C6 21          
                JSR     Z0F31via02BF             ; 026E: BD 0F 31       
                JMP     Z0617via02FD             ; 0271: 7E 06 17       
Z0274           LDX     SWIsSV                   ; 0274: FE 01 16       
                JMP     ,X                       ; 0277: 6E 00          
B7_SET          ASRB                             ; 0279: 57              restore B
                LDX     SWIsUV                   ; 027A: FE 01 18       
                JMP     ,X                       ; 027D: 6E 00          
M027F           FDB     RESRV                    ; 027F: 12 7F          
                FDB     RELES                    ; 0281: 12 82          
                FDB     OPEN                     ; 0283: 1C 0D          
                FDB     CLOSE                    ; 0285: 18 A3          
                FDB     GETRC                    ; 0287: 18 9D          
                FDB     PUTRC                    ; 0289: 12 85          
                FDB     REWND                    ; 028B: 18 A6          
                FDB     GETLS                    ; 028D: 07 1F          
                FDB     PUTLS                    ; 028F: 07 22          
                FDB     KEYIN                    ; 0291: 03 A8          
                FDB     DISPLY                   ; 0293: 04 17          
                FDB     DISPLX                   ; 0295: 04 1A          
                FDB     DISPLZ                   ; 0297: 04 0D          
                FDB     Z03D9via0299             ; 0299: 03 D9          
                FDB     Z0527via029B             ; 029B: 05 27          
                FDB     Z0536via029D             ; 029D: 05 36          
                FDB     Z032Dvia029F             ; 029F: 03 2D          
                FDB     Z0339via02A1             ; 02A1: 03 39          
                FDB     Z0362via02A3             ; 02A3: 03 62          
                FDB     Z0364via02A5             ; 02A5: 03 64          
                FDB     Z036Bvia02A7             ; 02A7: 03 6B          
                FDB     Z0374via02A9             ; 02A9: 03 74          
                FDB     Z0381via02AB             ; 02AB: 03 81          
                FDB     Z038Avia02AD             ; 02AD: 03 8A          
                FDB     Z0394via02AF             ; 02AF: 03 94          
                FDB     Z039Evia02B1             ; 02B1: 03 9E          
                FDB     Z0623via02B3             ; 02B3: 06 23          
                FDB     Z0C28via02B5             ; 02B5: 0C 28          
                FDB     Z09C7via02B7             ; 02B7: 09 C7          
                FDB     Z1279via02B9             ; 02B9: 12 79          
                FDB     Z127Cvia02BB             ; 02BB: 12 7C          
                FDB     Z18A9via02BD             ; 02BD: 18 A9          
                FDB     Z0F31via02BF             ; 02BF: 0F 31          
                FDB     Z1273via02C1             ; 02C1: 12 73          
                FDB     Z1276via02C3             ; 02C3: 12 76          
                FDB     Z0609via02C5             ; 02C5: 06 09          
                FDB     Z0461via02C7             ; 02C7: 04 61          
                FDB     Z0471via02C9             ; 02C9: 04 71          
                FDB     Z0477via02CB             ; 02CB: 04 77          
                FDB     Z0489via02CD             ; 02CD: 04 89          
                FDB     Z048Avia02CF             ; 02CF: 04 8A          
                FDB     Z048Bvia02D1             ; 02D1: 04 8B          
                FDB     Z0494via02D3             ; 02D3: 04 94          
                FDB     Z04A7via02D5             ; 02D5: 04 A7          
                FDB     Z04A8via02D7             ; 02D7: 04 A8          
                FDB     Z04A9via02D9             ; 02D9: 04 A9          
                FDB     Z04B9via02DB             ; 02DB: 04 B9          
                FDB     Z04C6via02DD             ; 02DD: 04 C6          
                FDB     Z04DAvia02DF             ; 02DF: 04 DA          
                FDB     Z04E0via02E1             ; 02E1: 04 E0          
                FDB     Z04E6via02E3             ; 02E3: 04 E6          
                FDB     Z0506via02E5             ; 02E5: 05 06          
                FDB     Z0446via02E7             ; 02E7: 04 46          
                FDB     Z0449via02E9             ; 02E9: 04 49          
                FDB     Z18A0via02EB             ; 02EB: 18 A0          
                FDB     Z1288via02ED             ; 02ED: 12 88          
                FDB     Z128Bvia02EF             ; 02EF: 12 8B          
                FDB     Z0524via02F1             ; 02F1: 05 24          
                FDB     Z0533via02F3             ; 02F3: 05 33          
                FDB     Z0521via02F5             ; 02F5: 05 21          
                FDB     Z0530via02F7             ; 02F7: 05 30          
                FDB     Z051Evia02F9             ; 02F9: 05 1E          
                FDB     Z052Dvia02FB             ; 02FB: 05 2D          
                FDB     Z0617via02FD             ; 02FD: 06 17          
IRQ_ISR         TST     PROM_1                   ; 02FF: 7D FC FD       
                BPL     Z030A                    ; 0302: 2A 06          
                PULA                             ; 0304: 32             
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
Z032Dvia029F    BSR     Z0347                    ; 032D: 8D 18          
                LDX     $02,X                    ; 032F: EE 02          
                STAA    ,X                       ; 0331: A7 00          
                BSR     Z0358                    ; 0333: 8D 23          
                DECB                             ; 0335: 5A             
                BNE     Z032Dvia029F             ; 0336: 26 F5          
                RTS                              ; 0338: 39             
Z0339via02A1    BSR     Z0347                    ; 0339: 8D 0C          
                LDX     $02,X                    ; 033B: EE 02          
                CMPA    ,X                       ; 033D: A1 00          
                BNE     Z0346                    ; 033F: 26 05          
                BSR     Z0358                    ; 0341: 8D 15          
                DECB                             ; 0343: 5A             
                BNE     Z0339via02A1             ; 0344: 26 F3          
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
Z0362via02A3    LDAA    #$20                     ; 0362: 86 20          
Z0364via02A5    STAA    ,X                       ; 0364: A7 00          
                INX                              ; 0366: 08             
                DECB                             ; 0367: 5A             
                BNE     Z0364via02A5             ; 0368: 26 FA          
                RTS                              ; 036A: 39             
Z036Bvia02A7    CMPA    #$41                     ; 036B: 81 41          
                BCS     Z0373                    ; 036D: 25 04          
                PSHA                             ; 036F: 36             
                ADDA    #$A5                     ; 0370: 8B A5          
                PULA                             ; 0372: 32             
Z0373           RTS                              ; 0373: 39             
Z0374via02A9    CMPA    #$30                     ; 0374: 81 30          
                BCS     Z0380                    ; 0376: 25 08          
                PSHA                             ; 0378: 36             
                ADDA    #$C6                     ; 0379: 8B C6          
                PULA                             ; 037B: 32             
                BCS     Z0380                    ; 037C: 25 02          
                ANDA    #$0F                     ; 037E: 84 0F          
Z0380           RTS                              ; 0380: 39             
Z0381via02AB    ADDA    $01,X                    ; 0381: AB 01          
                STAA    $01,X                    ; 0383: A7 01          
                BCC     Z0389                    ; 0385: 24 02          
                INC     ,X                       ; 0387: 6C 00          
Z0389           RTS                              ; 0389: 39             
Z038Avia02AD    NEGA                             ; 038A: 40             
                ADDA    $01,X                    ; 038B: AB 01          
                STAA    $01,X                    ; 038D: A7 01          
                BCS     Z0393                    ; 038F: 25 02          
                DEC     ,X                       ; 0391: 6A 00          
Z0393           RTS                              ; 0393: 39             
Z0394via02AF    PSHA                             ; 0394: 36             
Z0395           ASL     $01,X                    ; 0395: 68 01          
                ROL     ,X                       ; 0397: 69 00          
                DECA                             ; 0399: 4A             
                BNE     Z0395                    ; 039A: 26 F9          
                PULA                             ; 039C: 32             
                RTS                              ; 039D: 39             
Z039Evia02B1    PSHA                             ; 039E: 36             
Z039F           LSR     ,X                       ; 039F: 64 00          
                ROR     $01,X                    ; 03A1: 66 01          
                DECA                             ; 03A3: 4A             
                BNE     Z039F                    ; 03A4: 26 F9          
                PULA                             ; 03A6: 32             
                RTS                              ; 03A7: 39             
KEYIN           STX     M0124                    ; 03A8: FF 01 24       
                CPX     #M00AE                   ; 03AB: 8C 00 AE       
                BNE     Z03B6                    ; 03AE: 26 06          
                CMPB    #$50                     ; 03B0: C1 50          
                BMI     Z03B6                    ; 03B2: 2B 02          
                LDAB    #$4F                     ; 03B4: C6 4F          
Z03B6           SWI                              ; 03B6: 3F             
                FCB     $27                      ; 03B7: 27             
                STX     M0126                    ; 03B8: FF 01 26       
                LDX     #SYIOCB                  ; 03BB: CE 01 20       
                SWI                              ; 03BE: 3F             
                FCB     $04                      ; 03BF: 04             
                BCS     Z03CF                    ; 03C0: 25 0D          
Z03C2           LDAA    $03,X                    ; 03C2: A6 03          
                LDAB    $02,X                    ; 03C4: E6 02          
                LDX     $04,X                    ; 03C6: EE 04          
                SWI                              ; 03C8: 3F             
                FCB     $2E                      ; 03C9: 2E             
                TAB                              ; 03CA: 16             
                BEQ     Z03CD                    ; 03CB: 27 00          
Z03CD           CLC                              ; 03CD: 0C             
                RTS                              ; 03CE: 39             
Z03CF           CMPB    #$0D                     ; 03CF: C1 0D          
                BEQ     Z03C2                    ; 03D1: 27 EF          
Z03D3           LDAB    #$00                     ; 03D3: C6 00          
                SWI                              ; 03D5: 3F             
                FCB     $20                      ; 03D6: 20             
                SWI                              ; 03D7: 3F             
                FCB     $1A                      ; 03D8: 1A             
Z03D9via0299    PSHA                             ; 03D9: 36             
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
DISPLZ          LDAB    M012A                    ; 040D: F6 01 2A       
                ANDB    #$DF                     ; 0410: C4 DF          
                STAB    M012A                    ; 0412: F7 01 2A       
                BRA     DISPLX                   ; 0415: 20 03          
DISPLY          LDAB    #$0D                     ; 0417: C6 0D          
                FCB     $8C                      ; 0419: 8C             
DISPLX          LDAB    #$04                     ; 041A: C6 04          
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
Z0446via02E7    LDAB    #$0D                     ; 0446: C6 0D          
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
Z0461via02C7    TSX                              ; 0461: 30             
                LDAA    $06,X                    ; 0462: A6 06          
                LDAB    $05,X                    ; 0464: E6 05          
                RTS                              ; 0466: 39             
                STX     M010C                    ; 0467: FF 01 0C       
                LDAB    M010C                    ; 046A: F6 01 0C       
                LDAA    M010D                    ; 046D: B6 01 0D       
                RTS                              ; 0470: 39             
Z0471via02C9    TSX                              ; 0471: 30             
                STAA    $06,X                    ; 0472: A7 06          
                STAB    $05,X                    ; 0474: E7 05          
                RTS                              ; 0476: 39             
Z0477via02CB    TSX                              ; 0477: 30             
                LDAB    $06,X                    ; 0478: E6 06          
                STAA    $06,X                    ; 047A: A7 06          
                STAB    $04,X                    ; 047C: E7 04          
                LDAB    $03,X                    ; 047E: E6 03          
                LDAA    $05,X                    ; 0480: A6 05          
                STAB    $05,X                    ; 0482: E7 05          
                STAA    $03,X                    ; 0484: A7 03          
                JMP     Z04FC                    ; 0486: 7E 04 FC       
Z0489via02CD    TBA                              ; 0489: 17             
Z048Avia02CF    CLRB                             ; 048A: 5F             
Z048Bvia02D1    TSX                              ; 048B: 30             
                BSR     Z0495                    ; 048C: 8D 07          
                STAA    $06,X                    ; 048E: A7 06          
                STAB    $05,X                    ; 0490: E7 05          
                BRA     Z04FC                    ; 0492: 20 68          
Z0494via02D3    TSX                              ; 0494: 30             
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
Z04A7via02D5    TBA                              ; 04A7: 17             
Z04A8via02D7    CLRB                             ; 04A8: 5F             
Z04A9via02D9    SWI                              ; 04A9: 3F             
                FCB     $26                      ; 04AA: 26             
                SWI                              ; 04AB: 3F             
                FCB     $2E                      ; 04AC: 2E             
                TSX                              ; 04AD: 30             
                PSHA                             ; 04AE: 36             
                TPA                              ; 04AF: 07             
                STAA    $02,X                    ; 04B0: A7 02          
                PULA                             ; 04B2: 32             
                STAA    $06,X                    ; 04B3: A7 06          
                STAB    $05,X                    ; 04B5: E7 05          
                BRA     Z04FC                    ; 04B7: 20 43          
Z04B9via02DB    TSX                              ; 04B9: 30             
                SUBA    $06,X                    ; 04BA: A0 06          
                PSHA                             ; 04BC: 36             
                TPA                              ; 04BD: 07             
                ORAA    #$FB                     ; 04BE: 8A FB          
                STAA    $02,X                    ; 04C0: A7 02          
                SBCB    $05,X                    ; 04C2: E2 05          
                BRA     Z049F                    ; 04C4: 20 D9          
Z04C6via02DD    TSX                              ; 04C6: 30             
                CMPB    $05,X                    ; 04C7: E1 05          
                BNE     Z04CD                    ; 04C9: 26 02          
                CMPA    $06,X                    ; 04CB: A1 06          
Z04CD           RTS                              ; 04CD: 39             
                STX     M010C                    ; 04CE: FF 01 0C       
                CMPB    M010C                    ; 04D1: F1 01 0C       
                BNE     Z04D9                    ; 04D4: 26 03          
                CMPA    M010D                    ; 04D6: B1 01 0D       
Z04D9           RTS                              ; 04D9: 39             
Z04DAvia02DF    TSX                              ; 04DA: 30             
                ASR     $05,X                    ; 04DB: 67 05          
                ROR     $06,X                    ; 04DD: 66 06          
                RTS                              ; 04DF: 39             
Z04E0via02E1    TSX                              ; 04E0: 30             
                ASL     $06,X                    ; 04E1: 68 06          
                ROL     $05,X                    ; 04E3: 69 05          
                RTS                              ; 04E5: 39             
Z04E6via02E3    LDAA    #$09                     ; 04E6: 86 09          
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
Z0506via02E5    TSX                              ; 0506: 30             
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
Z051Evia02F9    LDAA    #$C0                     ; 051E: 86 C0          
                FCB     $8C                      ; 0520: 8C             
Z0521via02F5    LDAA    #$40                     ; 0521: 86 40          
                FCB     $8C                      ; 0523: 8C             
Z0524via02F1    LDAA    #$80                     ; 0524: 86 80          
                FCB     $85                      ; 0526: 85             
Z0527via029B    CLRA                             ; 0527: 4F             
                LDX     #READSC                  ; 0528: CE E8 69       
                BRA     Z053A                    ; 052B: 20 0D          
Z052Dvia02FB    LDAA    #$C0                     ; 052D: 86 C0          
                FCB     $8C                      ; 052F: 8C             
Z0530via02F7    LDAA    #$40                     ; 0530: 86 40          
                FCB     $8C                      ; 0532: 8C             
Z0533via02F3    LDAA    #$80                     ; 0533: 86 80          
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
                CMPA    #'1                      ; 0569: 81 31          
                BEQ     Z05C1                    ; 056B: 27 54          
                CMPA    #'4                      ; 056D: 81 34          
                BEQ     Z05C1                    ; 056F: 27 50          
                CMPA    #'8                      ; 0571: 81 38          
                BEQ     Z05C1                    ; 0573: 27 4C          
                CMPA    #'9                      ; 0575: 81 39          
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
                FCB     $20                      ; 05BE: 20             
                SWI                              ; 05BF: 3F             
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
                FCB     $2E                      ; 05DC: 2E             
                ROLB                             ; 05DD: 59             
                BCC     Z05E5                    ; 05DE: 24 05          
                JSR     RESTOR                   ; 05E0: BD E8 75       
                BRA     Z05ED                    ; 05E3: 20 08          
Z05E5           RORB                             ; 05E5: 56             
Z05E6           STAB    M0001                    ; 05E6: D7 01          
                STAA    M0002                    ; 05E8: 97 02          
                JSR     SEEK                     ; 05EA: BD E8 78       
Z05ED           JMP     Z0553                    ; 05ED: 7E 05 53       
Z05F0           LDAB    M0001                    ; 05F0: D6 01          
                LDAA    M0002                    ; 05F2: 96 02          
                SWI                              ; 05F4: 3F             
                FCB     $2A                      ; 05F5: 2A             
                LDX     #M07D1                   ; 05F6: CE 07 D1       
                TST     M000D                    ; 05F9: 7D 00 0D       
                BMI     Z0601                    ; 05FC: 2B 03          
                LDX     #M0FA5                   ; 05FE: CE 0F A5       
Z0601           SWI                              ; 0601: 3F             
                FCB     $2F                      ; 0602: 2F             
                BCS     Z05E6                    ; 0603: 25 E1          
                SWI                              ; 0605: 3F             
                FCB     $24                      ; 0606: 24             
                BRA     Z05E6                    ; 0607: 20 DD          
Z0609via02C5    STAB    M0115                    ; 0609: F7 01 15       
                PSHA                             ; 060C: 36             
                LDAA    SYERRs                   ; 060D: B6 01 14       
                ORAA    #$80                     ; 0610: 8A 80          
                STAA    SYERRs                   ; 0612: B7 01 14       
                PULA                             ; 0615: 32             
                RTS                              ; 0616: 39             
Z0617via02FD    LDX     SWIsSV                   ; 0617: FE 01 16       
                STX     SWIsVC                   ; 061A: FF FF FA       
                LDS     #XSTAKs                  ; 061D: 8E FF 8A       
                JMP     OSLOAD                   ; 0620: 7E E8 00       
Z0623via02B3    LDX     SWIsVC                   ; 0623: FE FF FA        Entry Point after floppy-boot
                CPX     #SWI_ISR                 ; 0626: 8C 02 2F       
                BEQ     Z0636                    ; 0629: 27 0B          
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
                FCB     $02                      ; 071E: 02             
GETLS           FCB     $86,$82,$8C              ; 071F: 86 82 8C       
PUTLS           FCB     $86                      ; 0722: 86             
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
                FCB     $32                      ; 07C7: 32             
                DES                              ; 07C8: 34             
                TSX                              ; 07C9: 30             
                SWI                              ; 07CA: 3F             
                FCB     $0E                      ; 07CB: 0E             
                PULB                             ; 07CC: 33             
                INS                              ; 07CD: 31             
                INS                              ; 07CE: 31             
                INS                              ; 07CF: 31             
                INS                              ; 07D0: 31             
M07D1           LDX     M094F                    ; 07D1: FE 09 4F       
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
                FCB     $28                      ; 07F9: 28             
                SWI                              ; 07FA: 3F             
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
                FCB     $33                      ; 0813: 33             
                SWI                              ; 0814: 3F             
                FCB     $2A                      ; 0815: 2A             
                PSHA                             ; 0816: 36             
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
                STAA    $0E,X                    ; 084D: A7 0E          
                STAB    $0D,X                    ; 084F: E7 0D          
                ANDB    #$7C                     ; 0851: C4 7C          
                ADDB    #$03                     ; 0853: CB 03          
                SWI                              ; 0855: 3F             
                FCB     $33                      ; 0856: 33             
                SWI                              ; 0857: 3F             
                FCB     $2B                      ; 0858: 2B             
                SWI                              ; 0859: 3F             
                FCB     $24                      ; 085A: 24             
                LDX     M094F                    ; 085B: FE 09 4F       
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
                ADDB    #$04                     ; 0899: CB 04          
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
                FCB     $3B                      ; 08CB: 3B             
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
                FCB     $3B                      ; 0903: 3B             
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
M098F           JMP     Z129A                    ; 098F: 7E 12 9A       
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
Z09C7via02B7    ANDB    #$7F                     ; 09C7: C4 7F          
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
                JSR     Z0BD4                    ; 09EC: BD 0B D4       
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
                FCB     $28                      ; 0A61: 28             
                STX     M0C26                    ; 0A62: FF 0C 26       
                LDAA    #$FF                     ; 0A65: 86 FF          
                CMPA    ,X                       ; 0A67: A1 00          
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
                FCB     $10                      ; 0A94: 10             
                LDAB    M0C22                    ; 0A95: F6 0C 22       
                CMPB    #$10                     ; 0A98: C1 10          
                BEQ     Z0ADE                    ; 0A9A: 27 42          
Z0A9C           CLRB                             ; 0A9C: 5F             
                RTS                              ; 0A9D: 39             
Z0A9E           CMPB    #$20                     ; 0A9E: C1 20          
                BNE     Z0ABE                    ; 0AA0: 26 1C          
                LDAB    #$0C                     ; 0AA2: C6 0C          
                SWI                              ; 0AA4: 3F             
                FCB     $27                      ; 0AA5: 27             
                LDAA    ,X                       ; 0AA6: A6 00          
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
                FCB     $11                      ; 0ACE: 11             
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
                FCB     $22                      ; 0B07: 22             
                BCC     Z0B10                    ; 0B08: 24 06          
                LDAB    #$11                     ; 0B0A: C6 11          
                SWI                              ; 0B0C: 3F             
                FCB     $20                      ; 0B0D: 20             
                SWI                              ; 0B0E: 3F             
                FCB     $1A                      ; 0B0F: 1A             
Z0B10           LDAB    M0C26                    ; 0B10: F6 0C 26       
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
                LDX     $05,X                    ; 0B2D: EE 05          
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
                CLR     $12,X                    ; 0B4E: 6F 12          
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
                FCB     $20                      ; 0B60: 20             
                SWI                              ; 0B61: 3F             
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
                FCB     $10                      ; 0B76: 10             
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
                FCB     $0E                      ; 0BCB: 0E             
                BRA     Z0BD0                    ; 0BCC: 20 02          
Z0BCE           SWI                              ; 0BCE: 3F             
                FCB     $0F                      ; 0BCF: 0F             
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
Z0C28via02B5    STAB    M0F1C                    ; 0C28: F7 0F 1C       
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
                FCB     $20                      ; 0C84: 20             
                SWI                              ; 0C85: 3F             
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
                BNE     Z0C8D                    ; 0CA0: 26 EB          
Z0CA2           JSR     Z0DE0                    ; 0CA2: BD 0D E0       
                LDX     M0F24                    ; 0CA5: FE 0F 24       
                LDX     $78,X                    ; 0CA8: EE 78          
                STX     M0F26                    ; 0CAA: FF 0F 26       
                JSR     Z0E6C                    ; 0CAD: BD 0E 6C       
                LDAB    M0F26                    ; 0CB0: F6 0F 26       
                LDAA    M0F27                    ; 0CB3: B6 0F 27       
                LDX     M0F28                    ; 0CB6: FE 0F 28       
                SWI                              ; 0CB9: 3F             
                FCB     $29                      ; 0CBA: 29             
                BCS     Z0CC8                    ; 0CBB: 25 0B          
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
                FCB     $28                      ; 0CDC: 28             
                BCS     Z0CC8                    ; 0CDD: 25 E9          
Z0CDF           STX     M0F2A                    ; 0CDF: FF 0F 2A       
                JSR     Z0E37                    ; 0CE2: BD 0E 37       
                BCS     Z0CC8                    ; 0CE5: 25 E1          
                LDAB    M0F1C                    ; 0CE7: F6 0F 1C       
                BITB    #$10                     ; 0CEA: C5 10          
                BEQ     Z0D08                    ; 0CEC: 27 1A          
                LDX     M0F2A                    ; 0CEE: FE 0F 2A       
                LDAB    ENDSYs                   ; 0CF1: F6 01 0A       
                LDAA    M010B                    ; 0CF4: B6 01 0B       
                SWI                              ; 0CF7: 3F             
                FCB     $2F                      ; 0CF8: 2F             
                BCS     Z0CC8                    ; 0CF9: 25 CD          
                LDAB    ENDOSs                   ; 0CFB: F6 01 06       
                LDAA    M0107                    ; 0CFE: B6 01 07       
                SWI                              ; 0D01: 3F             
                FCB     $2F                      ; 0D02: 2F             
                BCC     Z0CC8                    ; 0D03: 24 C3          
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
                BNE     Z0D61                    ; 0D28: 26 37          
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
                FCB     $39                      ; 0DF6: 39             
                JSR     CHKERR                   ; 0DF7: BD E8 53       
                LDX     M0F24                    ; 0DFA: FE 0F 24       
                LDX     $7A,X                    ; 0DFD: EE 7A          
                STX     M0F2C                    ; 0DFF: FF 0F 2C       
                RTS                              ; 0E02: 39             
Z0E03           SWI                              ; 0E03: 3F             
                FCB     $24                      ; 0E04: 24             
                LDX     M0F26                    ; 0E05: FE 0F 26       
                SWI                              ; 0E08: 3F             
                FCB     $2F                      ; 0E09: 2F             
                BCC     Z0E10                    ; 0E0A: 24 04          
Z0E0C           INS                              ; 0E0C: 31             
                INS                              ; 0E0D: 31             
                BRA     Z0DDC                    ; 0E0E: 20 CC          
Z0E10           LDX     M0F28                    ; 0E10: FE 0F 28       
                SWI                              ; 0E13: 3F             
                FCB     $26                      ; 0E14: 26             
                SWI                              ; 0E15: 3F             
                FCB     $2F                      ; 0E16: 2F             
                BCS     Z0E0C                    ; 0E17: 25 F3          
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
                FCB     $2D                      ; 0E35: 2D             
Z0E36           RTS                              ; 0E36: 39             
Z0E37           LDAB    M0F1C                    ; 0E37: F6 0F 1C       
                BITB    #$A0                     ; 0E3A: C5 A0          
                BNE     Z0E47                    ; 0E3C: 26 09          
                LDAB    ENDSYs                   ; 0E3E: F6 01 0A       
                LDAA    M010B                    ; 0E41: B6 01 0B       
                SWI                              ; 0E44: 3F             
                FCB     $2E                      ; 0E45: 2E             
                RTS                              ; 0E46: 39             
Z0E47           CLC                              ; 0E47: 0C             
                RTS                              ; 0E48: 39             
Z0E49           TSX                              ; 0E49: 30             
                LDX     $07,X                    ; 0E4A: EE 07          
                LDAA    M0F30                    ; 0E4C: B6 0F 30       
                STAA    M0000                    ; 0E4F: 97 00          
                LDX     M0F22                    ; 0E51: FE 0F 22       
                INX                              ; 0E54: 08             
                STX     M0001                    ; 0E55: DF 01          
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
Z0F31via02BF    CLR     M110C                    ; 0F31: 7F 11 0C       
                STX     M1105                    ; 0F34: FF 11 05       
Z0F37           STAB    M110B                    ; 0F37: F7 11 0B       
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
                FCB     $29                      ; 0F93: 29             
                LDX     ,X                       ; 0F94: EE 00          
Z0F96           LDAB    M110B                    ; 0F96: F6 11 0B       
Z0F99           SWI                              ; 0F99: 3F             
                FCB     $23                      ; 0F9A: 23             
                STX     M1101                    ; 0F9B: FF 11 01       
                LDX     #MFF8D                   ; 0F9E: CE FF 8D       
                LDAB    #$0D                     ; 0FA1: C6 0D          
                STAB    ,X                       ; 0FA3: E7 00          
M0FA5           INX                              ; 0FA5: 08             
                LDAB    #$2A                     ; 0FA6: C6 2A          
                STAB    ,X                       ; 0FA8: E7 00          
                INX                              ; 0FAA: 08             
                STAB    ,X                       ; 0FAB: E7 00          
                INX                              ; 0FAD: 08             
                STX     M1103                    ; 0FAE: FF 11 03       
                LDX     M1105                    ; 0FB1: FE 11 05       
                LDAB    M110B                    ; 0FB4: F6 11 0B       
                BEQ     Z0FF7                    ; 0FB7: 27 3E          
                CMPB    #$01                     ; 0FB9: C1 01          
                BNE     Z0FD8                    ; 0FBB: 26 1B          
                LDAB    $01,X                    ; 0FBD: E6 01          
                LDAA    $02,X                    ; 0FBF: A6 02          
                LDX     #M1190                   ; 0FC1: CE 11 90       
                JSR     Z10E0                    ; 0FC4: BD 10 E0       
                LDAA    M0000                    ; 0FC7: 96 00          
                ORAA    #$30                     ; 0FC9: 8A 30          
                STAA    M119E                    ; 0FCB: B7 11 9E       
                LDAB    M0001                    ; 0FCE: D6 01          
                LDAA    M0002                    ; 0FD0: 96 02          
                LDX     #M11A4                   ; 0FD2: CE 11 A4       
                JSR     Z10E0                    ; 0FD5: BD 10 E0       
Z0FD8           LDX     M1101                    ; 0FD8: FE 11 01       
                LDAA    ,X                       ; 0FDB: A6 00          
                CMPA    #$04                     ; 0FDD: 81 04          
                BEQ     Z103B                    ; 0FDF: 27 5A          
                CMPA    #$5C                     ; 0FE1: 81 5C          
                BEQ     Z1010                    ; 0FE3: 27 2B          
                LDX     M1103                    ; 0FE5: FE 11 03       
                STAA    ,X                       ; 0FE8: A7 00          
                INX                              ; 0FEA: 08             
                STX     M1103                    ; 0FEB: FF 11 03       
                LDX     M1101                    ; 0FEE: FE 11 01       
                INX                              ; 0FF1: 08             
                STX     M1101                    ; 0FF2: FF 11 01       
                BRA     Z0FD8                    ; 0FF5: 20 E1          
Z0FF7           TST     M110C                    ; 0FF7: 7D 11 0C       
                BNE     Z0FD8                    ; 0FFA: 26 DC          
                INC     M110C                    ; 0FFC: 7C 11 0C       
                LDAA    ,X                       ; 0FFF: A6 00          
                DECA                             ; 1001: 4A             
                CMPA    #$18                     ; 1002: 81 18          
                BHI     Z0FD8                    ; 1004: 22 D2          
                LDX     #M111E                   ; 1006: CE 11 1E       
                SWI                              ; 1009: 3F             
                FCB     $28                      ; 100A: 28             
                LDAB    ,X                       ; 100B: E6 00          
                JMP     Z0F37                    ; 100D: 7E 0F 37       
Z1010           INX                              ; 1010: 08             
                STX     M1101                    ; 1011: FF 11 01       
                LDAA    ,X                       ; 1014: A6 00          
                LDX     #M110D                   ; 1016: CE 11 0D       
Z1019           TST     ,X                       ; 1019: 6D 00          
                BEQ     Z0FD8                    ; 101B: 27 BB          
                CMPA    ,X                       ; 101D: A1 00          
                BEQ     Z1027                    ; 101F: 27 06          
                LDAB    #$04                     ; 1021: C6 04          
                SWI                              ; 1023: 3F             
                FCB     $27                      ; 1024: 27             
                BRA     Z1019                    ; 1025: 20 F2          
Z1027           INC     M1102                    ; 1027: 7C 11 02       
                BNE     Z102F                    ; 102A: 26 03          
                INC     M1101                    ; 102C: 7C 11 01       
Z102F           LDAB    $01,X                    ; 102F: E6 01          
                LDX     $02,X                    ; 1031: EE 02          
                STX     M1037                    ; 1033: FF 10 37       
Z1036           JSR     Z1036                    ; 1036: BD 10 36       
                BRA     Z0FD8                    ; 1039: 20 9D          
Z103B           LDX     M1103                    ; 103B: FE 11 03       
                LDAA    #$04                     ; 103E: 86 04          
                STAA    ,X                       ; 1040: A7 00          
                LDX     #M098F                   ; 1042: CE 09 8F       
                JSR     $03,X                    ; 1045: AD 03          
                NOP                              ; 1047: 01             
                BRA     Z1018                    ; 1048: 20 CE          
                STX     M8DBD                    ; 104A: FF 8D BD       
                SUBB    M24BD                    ; 104D: F0 24 BD       
                SUBB    M210C                    ; 1050: F0 21 0C       
                RTS                              ; 1053: 39             
                LDX     M1103                    ; 1054: FE 11 03       
                STX     M1109                    ; 1057: FF 11 09       
                LDX     M1105                    ; 105A: FE 11 05       
                INX                              ; 105D: 08             
                STX     M1107                    ; 105E: FF 11 07       
                LDAB    #$08                     ; 1061: C6 08          
                LDX     #M1107                   ; 1063: CE 11 07       
                SWI                              ; 1066: 3F             
                FCB     $10                      ; 1067: 10             
                LDX     M1109                    ; 1068: FE 11 09       
                LDAA    #$2E                     ; 106B: 86 2E          
                STAA    ,X                       ; 106D: A7 00          
                INX                              ; 106F: 08             
                STX     M1109                    ; 1070: FF 11 09       
                LDAB    #$02                     ; 1073: C6 02          
                LDX     #M1107                   ; 1075: CE 11 07       
                SWI                              ; 1078: 3F             
                FCB     $10                      ; 1079: 10             
                LDX     M1105                    ; 107A: FE 11 05       
                LDAB    ,X                       ; 107D: E6 00          
                LDX     M1109                    ; 107F: FE 11 09       
                LDAA    #$3A                     ; 1082: 86 3A          
                STAA    ,X                       ; 1084: A7 00          
                INX                              ; 1086: 08             
                STAB    ,X                       ; 1087: E7 00          
                INX                              ; 1089: 08             
                STX     M1103                    ; 108A: FF 11 03       
                LDX     M1107                    ; 108D: FE 11 07       
                STX     M1105                    ; 1090: FF 11 05       
                RTS                              ; 1093: 39             
Z1094           LDX     M1105                    ; 1094: FE 11 05       
                STX     M1107                    ; 1097: FF 11 07       
Z109A           LDX     M1103                    ; 109A: FE 11 03       
                TBA                              ; 109D: 17             
                ADDA    M1104                    ; 109E: BB 11 04       
                STAA    M1104                    ; 10A1: B7 11 04       
                BCC     Z10A9                    ; 10A4: 24 03          
                INC     M1103                    ; 10A6: 7C 11 03       
Z10A9           LDAA    M1108                    ; 10A9: B6 11 08       
                CMPB    #$04                     ; 10AC: C1 04          
                BNE     Z10B7                    ; 10AE: 26 07          
                LDAB    M1107                    ; 10B0: F6 11 07       
                JSR     Z10E0                    ; 10B3: BD 10 E0       
                RTS                              ; 10B6: 39             
Z10B7           JSR     Z10E5                    ; 10B7: BD 10 E5       
                RTS                              ; 10BA: 39             
                LDX     M1105                    ; 10BB: FE 11 05       
                LDAA    ,X                       ; 10BE: A6 00          
                CLR     M1107                    ; 10C0: 7F 11 07       
                STAA    M1108                    ; 10C3: B7 11 08       
                TBA                              ; 10C6: 17             
                ASRA                             ; 10C7: 47             
                ADDA    M1106                    ; 10C8: BB 11 06       
                STAA    M1106                    ; 10CB: B7 11 06       
                BCC     Z10D3                    ; 10CE: 24 03          
                INC     M1105                    ; 10D0: 7C 11 05       
Z10D3           BRA     Z109A                    ; 10D3: 20 C5          
                TSX                              ; 10D5: 30             
                LDX     $09,X                    ; 10D6: EE 09          
                DEX                              ; 10D8: 09             
                DEX                              ; 10D9: 09             
                STX     M1105                    ; 10DA: FF 11 05       
                JMP     Z1094                    ; 10DD: 7E 10 94       
Z10E0           PSHA                             ; 10E0: 36             
                TBA                              ; 10E1: 17             
                BSR     Z10E5                    ; 10E2: 8D 01          
                PULA                             ; 10E4: 32             
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
M1101           FCB     $00                      ; 1101: 00             
M1102           FCB     $00                      ; 1102: 00             
M1103           FCB     $00                      ; 1103: 00             
M1104           FCB     $00                      ; 1104: 00             
M1105           FCB     $00                      ; 1105: 00             
M1106           FCB     $00                      ; 1106: 00             
M1107           FCB     $00                      ; 1107: 00             
M1108           FCB     $00                      ; 1108: 00             
M1109           FCB     $00,$00                  ; 1109: 00 00          
M110B           FCB     $00                      ; 110B: 00             
M110C           FCB     $00                      ; 110C: 00             
M110D           FCB     $30                      ; 110D: 30             
                FCB     $0D,$10                  ; 110E: 0D 10          
                FCB     $54,$31                  ; 1110: 54 31          
                FCB     $04,$10,$94              ; 1112: 04 10 94       
                FCB     $33                      ; 1115: 33             
                FCB     $02,$10,$BB              ; 1116: 02 10 BB       
                FCB     $38                      ; 1119: 38             
                FCB     $04,$10,$D5,$00          ; 111A: 04 10 D5 00    
M111E           FCB     $09,$22                  ; 111E: 09 22          
                FCB     $23,$24                  ; 1120: 23 24          
                FCB     $0A,$1A,$1B              ; 1122: 0A 1A 1B       
                FCB     $25                      ; 1125: 25             
                FCB     $26,$13                  ; 1126: 26 13          
                FCB     '','(,'),'*,'+           ; 1128: 27 28 29 2A 2B 
                FCB     $1c,$15,$03,$02,$10      ; 112D: 1C 15 03 02 10 
                FCB     ',                       ; 1132: 2C             
                FCB     $11                      ; 1133: 11             
                FCB     '-,'.,'5                 ; 1134: 2D 2E 35       
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
                FCB     ' ,'A,'T,'               ; 118C: 20 41 54 20    
M1190           FCB     'X,'X,'X,'X,' ,'O,'N,'   ; 1190: 58 58 58 58 20 4F 4E 20 
                FCB     'D,'R,'I,'V,'E,'         ; 1198: 44 52 49 56 45 20 
M119E           FCB     'X,'-,'P,'S,'N,'         ; 119E: 58 2D 50 53 4E 20 
M11A4           FCB     'X,'X,'X,'X              ; 11A4: 58 58 58 58    
                FCB     $04                      ; 11A8: 04             
M11A9           FCB     '0,'M,'D,'O,'S,'O,'V     ; 11A9: 30 4D 44 4F 53 4F 56 
M11B0           FCB     $00                      ; 11B0: 00             
                FCB     ' ,'S,'Y                 ; 11B1: 20 53 59       
M11B4           FCB     $00                      ; 11B4: 00             
M11B5           FCB     $00,$00,$00,$00,$00,$00  ; 11B5: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$01,$8f,$02  ; 11BB: 00 00 00 01 8F 02 
                FCB     $0e                      ; 11C1: 0E             
M11C2           FCB     $ff,$ff,$ff,$ff,$ff,$ff  ; 11C2: FF FF FF FF FF FF 
                FCB     $ff,$ff,$ff,$ff,$ff,$ff  ; 11C8: FF FF FF FF FF FF 
                FCB     $ff,$ff                  ; 11CE: FF FF          
M11D0           FCB     $00,$00,$01,$01,$01,$01  ; 11D0: 00 00 01 01 01 01 
                FCB     $01,$01,$01,$01,$01,$01  ; 11D6: 01 01 01 01 01 01 
                FCB     $01,$01,$01,$01,$01,$01  ; 11DC: 01 01 01 01 01 01 
M11E2           FCB     $02,$02,$03,$03,$03      ; 11E2: 02 02 03 03 03 
M11E7           FCB     $04,$05                  ; 11E7: 04 05          
M11E9           FCB     $06,$12                  ; 11E9: 06 12          
M11EB           FCB     's                       ; 11EB: 73             
                FCB     $18                      ; 11EC: 18             
M11ED           FCB     $9d,$1c                  ; 11ED: 9D 1C          
M11EF           FCB     $0d,$1f                  ; 11EF: 0D 1F          
M11F1           FCB     $fd                      ; 11F1: FD             
Z11F2           PSHA                             ; 11F2: 36             
                TPA                              ; 11F3: 07             
                LDX     #M11D0                   ; 11F4: CE 11 D0       
                LDAB    M11EB                    ; 11F7: F6 11 EB       
                BRA     Z1218                    ; 11FA: 20 1C          
                PSHA                             ; 11FC: 36             
                TPA                              ; 11FD: 07             
                LDX     #M11E2                   ; 11FE: CE 11 E2       
                LDAB    M11ED                    ; 1201: F6 11 ED       
                BRA     Z1218                    ; 1204: 20 12          
                PSHA                             ; 1206: 36             
                TPA                              ; 1207: 07             
                LDX     #M11E7                   ; 1208: CE 11 E7       
                LDAB    M11EF                    ; 120B: F6 11 EF       
                BRA     Z1218                    ; 120E: 20 08          
Z1210           PSHA                             ; 1210: 36             
                TPA                              ; 1211: 07             
                LDX     #M11E9                   ; 1212: CE 11 E9       
                LDAB    M11F1                    ; 1215: F6 11 F1       
Z1218           PSHA                             ; 1218: 36             
                STX     M122A                    ; 1219: FF 12 2A       
                TSX                              ; 121C: 30             
                LDAA    $03,X                    ; 121D: A6 03          
                SUBA    #$03                     ; 121F: 80 03          
                STAA    $03,X                    ; 1221: A7 03          
                BCC     Z1227                    ; 1223: 24 02          
                DEC     $02,X                    ; 1225: 6A 02          
Z1227           LDAA    $03,X                    ; 1227: A6 03          
                LDX     #M0000                   ; 1229: CE 00 00       
                SBA                              ; 122C: 10             
                CLRB                             ; 122D: 5F             
                BITA    #$5C                     ; 122E: 85 5C          
                SUBA    #$03                     ; 1230: 80 03          
                BCC     Z122F                    ; 1232: 24 FB          
                STAB    M1238                    ; 1234: F7 12 38       
                LDAA    ,X                       ; 1237: A6 00          
                ASLA                             ; 1239: 48             
                STAA    M1247                    ; 123A: B7 12 47       
                STAA    M1244                    ; 123D: B7 12 44       
                LDX     #M11C2                   ; 1240: CE 11 C2       
                LDAB    ,X                       ; 1243: E6 00          
                INX                              ; 1245: 08             
                LDAA    ,X                       ; 1246: A6 00          
                STAB    M11B4                    ; 1248: F7 11 B4       
                STAA    M11B5                    ; 124B: B7 11 B5       
                LDAA    ENDOSs                   ; 124E: B6 01 06       
                PSHA                             ; 1251: 36             
                CLR     ENDOSs                   ; 1252: 7F 01 06       
                LDX     #M11A9                   ; 1255: CE 11 A9       
                LDAB    #$40                     ; 1258: C6 40          
                SWI                              ; 125A: 3F             
                FCB     $1B                      ; 125B: 1B             
                BCS     Z126B                    ; 125C: 25 0D          
                PULA                             ; 125E: 32             
                STAA    ENDOSs                   ; 125F: B7 01 06       
                TSX                              ; 1262: 30             
                LDAB    $07,X                    ; 1263: E6 07          
                LDX     $09,X                    ; 1265: EE 09          
                PULA                             ; 1267: 32             
                TAP                              ; 1268: 06             
                PULA                             ; 1269: 32             
                RTS                              ; 126A: 39             
Z126B           LDAA    #$56                     ; 126B: 86 56          
                STAA    M0008                    ; 126D: 97 08          
                SEC                              ; 126F: 0D             
                JSR     CHKERR                   ; 1270: BD E8 53       
; the following code gets overwritten by mdosov1
Z1273via02C1    JSR     Z11F2                    ; 1273: BD 11 F2       
Z1276via02C3    JSR     Z11F2                    ; 1276: BD 11 F2       
Z1279via02B9    JSR     Z11F2                    ; 1279: BD 11 F2       
Z127Cvia02BB    JSR     Z11F2                    ; 127C: BD 11 F2       
RESRV           JSR     Z11F2                    ; 127F: BD 11 F2       
RELES           JSR     Z11F2                    ; 1282: BD 11 F2       
PUTRC           JSR     Z11F2                    ; 1285: BD 11 F2        gets init to: $7e $150D in mdosov1
Z1288via02ED    JSR     Z11F2                    ; 1288: BD 11 F2       
Z128Bvia02EF    JSR     Z11F2                    ; 128B: BD 11 F2       
                JSR     Z11F2                    ; 128E: BD 11 F2       
Z1291           JSR     Z11F2                    ; 1291: BD 11 F2       
Z1294           JSR     Z11F2                    ; 1294: BD 11 F2       
Z1297           JSR     Z11F2                    ; 1297: BD 11 F2       
Z129A           JSR     Z11F2                    ; 129A: BD 11 F2       
Z129D           JSR     Z11F2                    ; 129D: BD 11 F2       
Z12A0           JSR     Z11F2                    ; 12A0: BD 11 F2       
Z12A3           JSR     Z11F2                    ; 12A3: BD 11 F2       
Z12A6           JSR     Z11F2                    ; 12A6: BD 11 F2       

                ORG     $1FFD

; the following code gets overwritten by mdosov6
Z1FFD           JSR     Z1210                    ; 1FFD: BD 12 10       
Z2000           SEI                              ; 2000: 0F             
M2001           STS     M2081                    ; 2001: BF 20 81       
                LDX     #MFFFF                   ; 2004: CE FF FF       
Z2007           LDAA    #$AA                     ; 2007: 86 AA          
                JMP     Z20BE                    ; 2009: 7E 20 BE       
Z200C           STAA    ,X                       ; 200C: A7 00          
                JMP     Z208E                    ; 200E: 7E 20 8E       
Z2011           CMPA    ,X                       ; 2011: A1 00          
                TPA                              ; 2013: 07             
                STAB    ,X                       ; 2014: E7 00          
                TAP                              ; 2016: 06             
                BEQ     Z2007                    ; 2017: 27 EE          
Z2019           DEX                              ; 2019: 09             
                JMP     Z209E                    ; 201A: 7E 20 9E       
Z201D           LDX     SWIsVC                   ; 201D: FE FF FA       
                STX     SWIsSV                   ; 2020: FF 01 16       
                LDX     IRQsVC                   ; 2023: FE FF F8       
                STX     IRQsSV                   ; 2026: FF 01 1C       
                LDX     #SWI_ISR                 ; 2029: CE 02 2F       
                STX     SWIsVC                   ; 202C: FF FF FA       
                LDX     #IRQ_ISR                 ; 202F: CE 02 FF       
                STX     IRQsVC                   ; 2032: FF FF F8       
                LDS     ENDSYs                   ; 2035: BE 01 0A       
                LDAA    #$2F                     ; 2038: 86 2F          
                LDX     #M11C2                   ; 203A: CE 11 C2       
                STAA    M11B0                    ; 203D: B7 11 B0       
Z2040           INC     M11B0                    ; 2040: 7C 11 B0       
                STX     M2083                    ; 2043: FF 20 83       
                LDX     #M11A9                   ; 2046: CE 11 A9       
                LDAB    #$02                     ; 2049: C6 02          
                SWI                              ; 204B: 3F             
                FCB     $1C                      ; 204C: 1C             
                BCC     Z2052                    ; 204D: 24 03          
                JMP     Z126B                    ; 204F: 7E 12 6B       
Z2052           LDAB    $0B,X                    ; 2052: E6 0B          
                LDAA    $0C,X                    ; 2054: A6 0C          
                LDX     M2083                    ; 2056: FE 20 83       
                STAA    $01,X                    ; 2059: A7 01          
                STAB    ,X                       ; 205B: E7 00          
                INX                              ; 205D: 08             
                INX                              ; 205E: 08             
                CPX     #M11D0                   ; 205F: 8C 11 D0       
                BNE     Z2040                    ; 2062: 26 DC          
                CLRB                             ; 2064: 5F             
                LDX     #M2085                   ; 2065: CE 20 85       
                SWI                              ; 2068: 3F             
                RTS                              ; 2069: 39             
                JSR     CHKERR                   ; 206A: BD E8 53       
                JSR     Z1F80                    ; 206D: BD 1F 80       
                LDAB    #$0E                     ; 2070: C6 0E          
                SWI                              ; 2072: 3F             
                SBA                              ; 2073: 10             
                LDX     #M2085                   ; 2074: CE 20 85       
                SWI                              ; 2077: 3F             
                FCB     $3A                      ; 2078: 3A             
                JSR     CHKERR                   ; 2079: BD E8 53       
                LDS     M2081                    ; 207C: BE 20 81       
                CLI                              ; 207F: 0E             
                RTS                              ; 2080: 39             
M2081           FCB     $00,$00                  ; 2081: 00 00          
M2083           FCB     $00,$00                  ; 2083: 00 00          
M2085           FCB     $00,$00,$00,$01,$8F,$11  ; 2085: 00 00 00 01 8F 11 
                FCB     $C2,$01,$B5              ; 208B: C2 01 B5       
Z208E           STAB    Z2000                    ; 208E: F7 20 00       
                CMPA    ,X                       ; 2091: A1 00          
                BNE     Z209B                    ; 2093: 26 06          
                COMA                             ; 2095: 43             
                STAA    ,X                       ; 2096: A7 00          
                JMP     Z2011                    ; 2098: 7E 20 11       
Z209B           JMP     Z2019                    ; 209B: 7E 20 19       
Z209E           STX     ENDSYs                   ; 209E: FF 01 0A       
                LDAA    ENDSYs                   ; 20A1: B6 01 0A       
                CMPA    #$3F                     ; 20A4: 81 3F          
                BHI     Z20BB                    ; 20A6: 22 13          
                BEQ     Z20B5                    ; 20A8: 27 0B          
Z20AA           INX                              ; 20AA: 08             
                STX     M0000                    ; 20AB: DF 00          
                LDAA    #$4D                     ; 20AD: 86 4D          
                STAA    M0008                    ; 20AF: 97 08          
                SEC                              ; 20B1: 0D             
                JMP     CHKERR                   ; 20B2: 7E E8 53       
Z20B5           LDAA    M010B                    ; 20B5: B6 01 0B       
                INCA                             ; 20B8: 4C             
                BNE     Z20AA                    ; 20B9: 26 EF          
Z20BB           JMP     Z201D                    ; 20BB: 7E 20 1D       
Z20BE           INX                              ; 20BE: 08             
                CPX     #Z2000                   ; 20BF: 8C 20 00       
                BNE     Z20C7                    ; 20C2: 26 03          
                LDX     #M209D                   ; 20C4: CE 20 9D       
Z20C7           LDAB    ,X                       ; 20C7: E6 00          
                JMP     Z200C                    ; 20C9: 7E 20 0C       


                END
