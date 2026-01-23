         include "mdoseq.inc"

STRSCTH EQU     $0001
STRSCTL EQU     $0002
NUMSCTH EQU     $0003
NUMSCTL EQU     $0004
CURADRH EQU     $0006
SECTCNT EQU     $000B
M000C   EQU     $000C
M001A   EQU     $001A
LDADDRH EQU     $0020
LDADDRL EQU     $0021
EXADDRH EQU     $0022
EXADDRL EQU     $0023
ONECONH EQU     $0024
ONECONL EQU     $0025
M0027   EQU     $0027
M0029   EQU     $0029
M002A   EQU     $002A
M002B   EQU     $002B
M002C   EQU     $002C
M002D   EQU     $002D
M002E   EQU     $002E
M0034   EQU     $0034
M004C   EQU     $004C
M00FE   EQU     $00FE
M01BD   EQU     $01BD
MEBFE   EQU     $EBFE
MEBFF   EQU     $EBFF
PIAREGA EQU     $EC00
PIAREGB EQU     $EC01
PIACTRLA EQU    $EC02
PIACTRLB EQU    $EC03
SSDA_0  EQU     $EC04
SSDA_1  EQU     $EC05
MFFCC   EQU     $FFCC
MFFE6   EQU     $FFE6

;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $2000

M2000           FCC     '0300'                   ; 
M2004           FCB     $E5,$E5                  ; 
FORMATSTART     STS     M0027                    ; 
                LDAA    MEBFF                    ; 
                CMPA    #$45                     ; 
                BNE     Z201D                    ; 
                LDAB    #$0A                     ; 
Z2011           SCALL   MDERR1
                SCALL   MDENT1
Z2015           LDAB    #$0B                     ; 
                BRA     Z2011                    ; 
Z2019           LDAB    #$04                     ; 
                BRA     Z2011                    ; 
Z201D           CLRB                             ; 
                CMPA    #$43                     ; 
                BEQ     Z2024                    ; 
                LDAB    #$10                     ; 
Z2024           STAB    ONECONH                  ; 
                LDAA    #$31                     ; 
                STAA    M232F                    ; 
                LDX     M00FE                    ; 
                STX     M233A                    ; 
                LDX     #M232F                   ; 
                STX     M233C                    ; 
                LDX     #M233A                   ; 
                SCALL   PFNAM1
                LDAA    #$20                     ; 
                CMPA    M2330                    ; 
                BNE     Z2015                    ; 
                CMPA    M2338                    ; 
                BNE     Z2015                    ; 
                LDAB    M232F                    ; 
                CMPB    #$30                     ; 
                BLE     Z2019                    ; 
                CMPB    #$33                     ; 
                BGT     Z2019                    ; 
                STAB    M234B                    ; 
                LDX     #M233E                   ; 
                SCALL   DSPLY1
                LDX     #STORAGE                 ; 
                LDAB    #$01                     ; 
                SCALL   KEYIN1
                LDAA    STORAGE                  ; 
                CMPA    #$59                     ; 
                BEQ     Z206A                    ; 
                SCALL   MDENT1
Z206A           LDAB    M234B                    ; 
                ANDB    #$0F                     ; 
                STAB    CURDRV                   ; 
                LDX     #M004C                   ; 
                STX     LDADDRH                  ; 
                LDX     #FORMATSTART             ; 
                STX     M002E                    ; 
                LDX     #M2004                   ; 
                STX     CURADRH                  ; 
                JSR     FDINIT                   ; 
                LDAA    CURDRV                   ; 
                LDAB    #$66                     ; 
                LSRA                             ; 
                BEQ     Z208C                    ; 
                LDAB    #$46                     ; 
Z208C           STAB    PIAREGB                  ; 
                LDAB    #$02                     ; 
                BCC     Z2094                    ; 
                LSRB                             ; 
Z2094           STAB    PIAREGA                  ; 
                TST     ONECONH                  ; 
                BNE     Z20A7                    ; 
                LDAA    MEBFE                    ; 
                CMPA    #$11                     ; 
                BEQ     Z20A7                    ; 
                CMPA    #$12                     ; 
                BNE     Z20AB                    ; 
Z20A7           LDAA    #$FF                     ; 
                BRA     Z20B0                    ; 
Z20AB           LDAA    PIAREGA                  ; 
                ASLA                             ; 
                ASLA                             ; 
Z20B0           STAA    M002C                    ; 
                BCC     Z20BA                    ; 
                LDAA    #$33                     ; 
                STAA    FDSTAT                   ; 
                BRA     Z210A                    ; 
Z20BA           LDX     #M001A                   ; 
                LDAA    M002C                    ; 
                BMI     Z20C4                    ; 
                LDX     #M0034                   ; 
Z20C4           STX     NUMSCTH                  ; 
                JSR     Z22B0                    ; 
                LDAB    $01,X                    ; 
                CLRA                             ; 
Z20CC           LDAB    $03,X                    ; 
                BPL     Z20CC                    ; 
                LDAB    $01,X                    ; 
Z20D2           CLRB                             ; 
Z20D3           DECB                             ; 
                BNE     Z20D3                    ; 
                INCA                             ; 
                TST     $03,X                    ; 
                BPL     Z20D2                    ; 
                INCB                             ; 
                SUBA    #$4B                     ; 
Z20DE           INCB                             ; 
                SUBA    #$16                     ; 
                BCC     Z20DE                    ; 
                STAB    M0029                    ; 
                LSRB                             ; 
                STAB    M002A                    ; 
                LDAA    #$03                     ; 
                STAA    $01,X                    ; 
                JSR     Z22D0                    ; 
                JSR     RESTOR                   ; 
                BCC     Z2117                    ; 
Z20F4           LDAB    STRSCTH                  ; 
                LDAA    STRSCTL                  ; 
                ADDA    NUMSCTL                  ; 
                ADCB    NUMSCTH                  ; 
                SUBA    M000C                    ; 
                SBCB    SECTCNT                  ; 
                SUBA    #$01                     ; 
                SBCB    #$00                     ; 
Z2104           STAA    STRSCTL                  ; 
                STAB    STRSCTH                  ; 
                LDAA    FDSTAT                   ; 
Z210A           STAA    M002D                    ; 
Z210C           LDAB    #$01                     ; 
                LDX     #M002D                   ; 
                SCALL   MDERR1
                BCS     Z210C                    ; 
                SCALL   MDENT1
Z2117           LDAA    M0029                    ; 
                SUBA    #$04                     ; 
                BCS     Z2132                    ; 
                SUBA    #$03                     ; 
                BCC     Z2126                    ; 
                LDX     #M2000                   ; 
                BRA     Z212F                    ; 
Z2126           LDX     #M22AB                   ; 
                STX     M21F0                    ; 
                LDX     #M01BD                   ; 
Z212F           STX     M21EE                    ; 
Z2132           LDAA    LDADDRH                  ; 
                STAA    EXADDRH                  ; 
                LDX     #MFFE6                   ; 
                TST     M002C                    ; 
                BMI     Z2141                    ; 
                LDX     #MFFCC                   ; 
Z2141           STX     STRSCTH                  ; 
Z2143           LDAB    STRSCTL                  ; 
                ADDB    NUMSCTL                  ; 
                STAB    STRSCTL                  ; 
                LDAB    STRSCTH                  ; 
                ADCB    #$00                     ; 
                STAB    STRSCTH                  ; 
                DECA                             ; 
                BPL     Z2143                    ; 
Z2152           JSR     SEEK                     ; 
                BCS     Z20F4                    ; 
                LDAA    ONECONH                  ; 
                LSRA                             ; 
                LSRA                             ; 
                LSRA                             ; 
                LSRA                             ; 
                ADDA    EXADDRH                  ; 
                LDAB    PIAREGA                  ; 
                ORAB    #$04                     ; 
                CMPA    #$2B                     ; 
                BLS     Z216A                    ; 
                ANDB    #$FB                     ; 
Z216A           STAB    PIAREGA                  ; 
                LDAA    #$01                     ; 
                STAA    EXADDRL                  ; 
                LDAA    PIAREGB                  ; 
                ORAA    #$40                     ; 
Z2176           STAA    PIAREGB                  ; 
                JSR     Z22B0                    ; 
                LDAB    #$27                     ; 
                LDAA    M002A                    ; 
Z2180           DECA                             ; 
                BNE     Z2180                    ; 
                LDX     #$C0DA                   ; 
                STX     SSDA_0                   ; 
                LDX     #$C1FF                   ; 
                STX     SSDA_0                   ; 
                LDX     #$8270                   ; 
                STX     SSDA_0                   ; 
                LDAA    PIAREGB                  ; 
                ANDA    #$F2                     ; 
                STAA    PIAREGB                  ; 
                EORA    ONECONH                  ; 
                BITA    #$10                     ; 
                BNE     Z21AD                    ; 
                JSR     Z22D0                    ; 
                LDAA    #$32                     ; 
                STAA    FDSTAT                   ; 
                JMP     Z210A                    ; 
Z21AD           ANDA    #$60                     ; 
                STAA    PIAREGB                  ; 
Z21B2           LDAA    PIACTRLB                 ; 
                BPL     Z21B2                    ; 
                LDX     #$8210                   ; 
                STX     SSDA_0                   ; 
                JSR     Z22E2                    ; 
                LDX     #$83F7                   ; 
                STX     SSDA_0                   ; 
                LDAA    #$7A                     ; 
                STAA    SSDA_1                   ; 
                LDX     #$81FF                   ; 
                STX     SSDA_0                   ; 
                LDAB    #$17                     ; 
Z21D3           LDAA    #$18                     ; 
                LDX     #$8210                   ; 
                STX     SSDA_0                   ; 
Z21DB           BITA    SSDA_0                   ; 
                BEQ     Z21DB                    ; 
                STAA    SSDA_1                   ; 
Z21E3           BITA    SSDA_0                   ; 
                BEQ     Z21E3                    ; 
                LDX     #$C270                   ; 
                STX     SSDA_0                   ; 
M21EE           BITA    #$00                     ; 
M21F0           LDAA    #$82                     ; 
                INC     PIAREGB                  ; 
                DEC     PIAREGB                  ; 
                STAA    SSDA_0                   ; 
                JSR     Z22E2                    ; 
                LDX     #$83F5                   ; 
                STX     SSDA_0                   ; 
                LDAB    #$7E                     ; 
                LDAA    #$40                     ; 
                STAB    SSDA_1                   ; 
Z220B           BITA    SSDA_0                   ; 
                BEQ     Z220B                    ; 
                LDAB    EXADDRH                  ; 
                STAB    SSDA_1                   ; 
                CLRB                             ; 
                STAB    SSDA_1                   ; 
Z2219           BITA    SSDA_0                   ; 
                BEQ     Z2219                    ; 
                LDAB    EXADDRL                  ; 
                STAB    SSDA_1                   ; 
                CLRB                             ; 
                STAB    SSDA_1                   ; 
Z2227           BITA    SSDA_0                   ; 
                BEQ     Z2227                    ; 
                STAB    SSDA_1                   ; 
Z222F           BITA    SSDA_0                   ; 
                BEQ     Z222F                    ; 
                LDAB    PIAREGB                  ; 
                ORAB    #$08                     ; 
                STAB    PIAREGB                  ; 
                STAB    SSDA_1                   ; 
Z223F           BITA    SSDA_0                   ; 
                BEQ     Z223F                    ; 
                LDAA    #$FF                     ; 
                STAA    SSDA_1                   ; 
                LDAA    #$40                     ; 
Z224B           BITA    SSDA_0                   ; 
                BEQ     Z224B                    ; 
                ANDB    #$60                     ; 
                STAB    PIAREGB                  ; 
                LDX     #$81FF                   ; 
                STX     SSDA_0                   ; 
                LDAB    #$AC                     ; 
                LDAA    EXADDRL                  ; 
                INCA                             ; 
                STAA    EXADDRL                  ; 
                CMPA    #$1B                     ; 
                BEQ     Z226D                    ; 
                CMPA    #$35                     ; 
                BEQ     Z226D                    ; 
                JMP     Z21D3                    ; 
Z226D           LDAA    PIACTRLB                 ; 
                BPL     Z226D                    ; 
                DEC     PIAREGB                  ; 
                DEC     PIAREGB                  ; 
                BSR     Z22D0                    ; 
                LDAA    EXADDRL                  ; 
                CMPA    #$1B                     ; 
                BNE     Z2289                    ; 
                LDAA    M002C                    ; 
                BMI     Z2289                    ; 
                LDAA    #$23                     ; 
                JMP     Z2176                    ; 
Z2289           JSR     RWTEST                   ; 
                BCC     Z2291                    ; 
                JMP     Z20F4                    ; 
Z2291           LDAA    STRSCTL                  ; 
                LDAB    STRSCTH                  ; 
                ADDA    NUMSCTL                  ; 
                ADCB    #$00                     ; 
                STAA    STRSCTL                  ; 
                STAB    STRSCTH                  ; 
                INC     EXADDRH                  ; 
                LDAA    LDADDRL                  ; 
                CMPA    EXADDRH                  ; 
                BCS     Z22A9                    ; 
                JMP     Z2152                    ; 
Z22A9           SCALL   MDENT1
M22AB           LDAA    #$82                     ; 
                BITA    LDADDRH                  ; 
                RTS                              ; 
Z22B0           TPA                              ; 
                SEI                              ; 
                STAA    M002B                    ; 
                LDX     NMIsVC                   ; 
                STX     ONECONL                  ; 
                LDX     #M2319                   ; 
                STX     NMIsVC                   ; 
                LDX     #PIAREGA                 ; 
                LDAA    #$36                     ; 
                STAA    $03,X                    ; 
                LDAA    #$3E                     ; 
                STAA    $03,X                    ; 
                LDAB    ,X                       ; 
                DECA                             ; 
                STAA    $02,X                    ; 
                RTS                              ; 
Z22D0           LDX     #$3C3E                   ; 
                STX     PIACTRLA                 ; 
                LDX     PIAREGA                  ; 
                LDX     ONECONL                  ; 
                STX     NMIsVC                   ; 
                LDAA    M002B                    ; 
                TAP                              ; 
                RTS                              ; 
Z22E2           LDAA    #$18                     ; 
Z22E4           BITA    SSDA_0                   ; 
                BEQ     Z22E4                    ; 
                LDAA    M002A                    ; 
Z22EB           DECA                             ; 
                BNE     Z22EB                    ; 
                LDAA    #$18                     ; 
                STAA    SSDA_1                   ; 
                DECB                             ; 
                BNE     Z22E4                    ; 
                LDX     #$81AA                   ; 
                LDAB    #$05                     ; 
                NOP                              ; 
                NOP                              ; 
                STX     SSDA_0                   ; 
                LDX     #$8210                   ; 
                STX     SSDA_0                   ; 
Z2306           BITA    SSDA_0                   ; 
                BEQ     Z2306                    ; 
                LDAA    M002A                    ; 
Z230D           DECA                             ; 
                BNE     Z230D                    ; 
                LDAA    #$18                     ; 
                STAA    SSDA_1                   ; 
                DECB                             ; 
                BNE     Z2306                    ; 
                RTS                              ; 
M2319           LDS     M0027                    ; 
                BSR     Z22D0                    ; 
                JSR     FDINIT                   ; 
                LDAA    #$35                     ; 
                STAA    FDSTAT                   ; 
                LDAA    EXADDRL                  ; 
                DECA                             ; 
                CLRB                             ; 
                ADDA    STRSCTL                  ; 
                ADCB    STRSCTH                  ; 
                JMP     Z2104                    ; 
M232F           FCC     ' '                      ; 
M2330           FCC     '        '               ; 
M2338           FCC     '  '                     ; 
M233A           FCB     $00,$00                  ; 
M233C           FCB     $00,$00                  ; 
M233E           FCC     'FORMAT DRIVE '          ; 
M234B           FCC     'X?'                     ; 
                FCB     $0d                      ; 
STORAGE         FCB     $00                      ; 
                REPT    $B1                      ; Filler
                FCB     $00
                ENDM
                END
