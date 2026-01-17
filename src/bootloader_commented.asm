; This file is loaded from floppy to address $20
; It sits in sector $17 @ 0xB80
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
SECTCNTH EQU     $000B
SECTCNTL EQU     $000C
CHKERR  EQU     $E853
READPS  EQU     $E86D
RESTOR  EQU     $E875
LPINIT  EQU     $EBC0

;****************************************************
; Program's Code Areas
;****************************************************

; RIB from System disk
;      00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
;-----------------------------------------------------
; 00 - 40 06 80 3F 00 00 00 00 00 00 00 00 00 00 00 00
; 10 - 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
; 20 - 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
; 30 - 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
; 40 - 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
; 50 - 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
; 60 - 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
; 70 - 00 00 00 00 00 10 00 40 01 00 06 23 00 00 00 00

                ORG     $0020

                INC     CURDRV                   ; 0020: 7C 00 00  ; Why?
                JSR     RESTOR                   ; 0023: BD E8 75  ; 
                JSR     LPINIT                   ; 0026: BD EB C0  ; 
                LDX     #$00A0                   ; 0029: CE 00 A0  ; Start of RIB in Memory 128 + $20 = $A0
                LDAA    $75,X                    ; 002C: A6 75     ; RIB $75: the number of bytes to load from the last sector
                STAA    LSCTLN                   ; 002E: 97 05     ; LAST SECTOR LENGTH ($10)
                LDAB    ,X                       ; 0030: E6 00     ; X is at $A0, Get Segment descriptor word ($40)
                BMI     SERRQM                   ; 0032: 2B 58     ; RIB SDW Bit 7 set - Error '?'
                ANDB    #$03                     ; 0034: C4 03     ; isolate Bit 0,1 - is part of starting cluster number
                LDAA    $01,X                    ; 0036: A6 01     ; LDA from $A1, Get Segment descriptor word ($06)
                ASLA                             ; 0038: 48        ; 
                ROLB                             ; 0039: 59        ; *2
                ASLA                             ; 003A: 48        ; 
                ROLB                             ; 003B: 59        ; *4 - four sectors / cluster (6 * 4 = 24)
                ADDA    #$01                     ; 003C: 8B 01     ; |
                ADCB    #$00                     ; 003E: C9 00     ; +1 (25, $19)
                STAB    STRSCTH                  ; 0040: D7 01     ; |
                STAA    STRSCTL                  ; 0042: 97 02     ; Startsector (25, $19) 25*128=$C80
                LDAA    $77,X                    ; 0044: A6 77     ; |
                LDAB    $76,X                    ; 0046: E6 76     ; ($76,77), the number of sectors to load ($0040)
                STAA    NUMSCTL                  ; 0048: 97 04     ; |
                STAB    NUMSCTH                  ; 004A: D7 03     ; save
                LDAB    $7A,X                    ; 004C: E6 7A     ; |
                LDAA    $7B,X                    ; 004E: A6 7B     ; ($7A,7B), the starting execution address ($0623)
                PSHA                             ; 0050: 36        ; 
                PSHB                             ; 0051: 37        ; 
                LDX     $78,X                    ; 0052: EE 78     ; ($78,79), the starting load address ($0100)
                STX     CURADRH                  ; 0054: DF 06     ; save
                LDAA    NUMSCTL                  ; 0056: 96 04     ; 
                LDAB    NUMSCTH                  ; 0058: D6 03     ; 
                LDX     #$07                     ; 005A: CE 00 07  ; |
Z005D           ASLA                             ; 005D: 48        ; |
                ROLB                             ; 005E: 59        ; | multiply by 128 to get bytecount
                DEX                              ; 005F: 09        ; |
                BNE     Z005D                    ; 0060: 26 FB     ; |
                ADDA    CURADRL                  ; 0062: 9B 07     ; |
                ADCB    CURADRH                  ; 0064: D9 06     ; add start address
                STAA    SECTCNTL                 ; 0066: 97 0C     ; |
                STAB    SECTCNTH                 ; 0068: D7 0B     ; is actually Endaddress
                LDX     #$03FF                   ; 006A: CE 03 FF  ; 
Z006D           LDAA    #$4D                     ; 006D: 86 4D     ; Check Memory @ $400 upwards
                INX                              ; 006F: 08        ; 
                LDAB    ,X                       ; 0070: E6 00     ; Load whats there
                STAA    ,X                       ; 0072: A7 00     ; write $4D
                CMPA    ,X                       ; 0074: A1 00     ; compare
                TPA                              ; 0076: 07        ; Transfer Status to A
                STAB    ,X                       ; 0077: E7 00     ; write the old value back
                TAP                              ; 0079: 06        ; restore status reg.
                BNE     SERRM                    ; 007A: 26 18     ; if not zero - Error 'M'
                CPX     SECTCNTH                 ; 007C: 9C 0B     ; are we done?
                BNE     Z006D                    ; 007E: 26 ED     ; no - continue
                CLR     CURDRV                   ; 0080: 7F 00 00  ; go back to drive 0
                LDAA    #$53                     ; 0083: 86 53     ; |
                PSHA                             ; 0085: 36        ; |
                LDAA    #$E8                     ; 0086: 86 E8     ; |
                PSHA                             ; 0088: 36        ; E853 is CHKERR
                JMP     READPS                   ; 0089: 7E E8 6D  ; on stack is CHKERR and Execution Address
;------------------------------------------------
SERRQM          LDAA    #'?'                     ; 008C: 86 3F     ; 
Z008E           STAA    FDSTAT                   ; 008E: 97 08     ; 
                SEC                              ; 0090: 0D        ; 
                JMP     CHKERR                   ; 0091: 7E E8 53  ; 

SERRM           LDAA    #'M'                     ; 0094: 86 4D     ; 
                BRA     Z008E                    ; 0096: 20 F6     ; 
;------------------------------------------------
                FCB     $00                      ; 0098: 00        ; filler
                FCB     $00                      ; 0099: 00        ; |
                FCB     $00                      ; 009A: 00        ; |
                FCB     $00                      ; 009B: 00        ; |
                FCB     $00                      ; 009C: 00        ; |
                FCB     $00                      ; 009D: 00        ; |
                FCB     $00                      ; 009E: 00        ; |
                FCB     $00                      ; 009F: 00        ; |


                END
