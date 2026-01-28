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
SECTCNT EQU     $000B
SECTCNT EQU     $000C
CHKERR  EQU     $E853
READPS  EQU     $E86D
RESTOR  EQU     $E875
LPINIT  EQU     $EBC0
OSLOAD  EQU     $E800
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

                LDAA    OSLOAD                   ; 0020: B6 E8 00       ; Check E800
                CMPA    #$8E                     ; 0023: 81 8E          ; is there a 6800 LDS command or is it a 6809 System?
                LDAA    #'P'                     ; 0025: 86 50          ; Error 'P' should be wrong CPU (It is, see '6800 MDOS  3.04 NEWS')
                BCS     Z0098                    ; 0027: 25 6F          ; No
                INC     CURDRV                   ; 0029: 7C 00 00       ; Why? - Guess: to check if there is a second drive present
                JSR     RESTOR                   ; 002C: BD E8 75       ; 
                JSR     LPINIT                   ; 002F: BD EB C0       ; 
                LDX     #$00A0                   ; 0032: CE 00 A0       ; Start of RIB in Memory 128 + $20 = $A0
                LDAA    $75,X                    ; 0035: A6 75          ; RIB $75: the number of bytes to load from the last sector
                STAA    LSCTLN                   ; 0037: 97 05          ; LAST SECTOR LENGTH ($10)
                LDAB    ,X                       ; 0039: E6 00          ; X is at $A0, Get Segment descriptor word ($40)
                BMI     SERRQM                   ; 003B: 2B 59          ; RIB SDW Bit 7 set - Error '?'
                ANDB    #$03                     ; 003D: C4 03          ; isolate Bit 0,1 - is part of starting cluster number
                LDAA    $01,X                    ; 003F: A6 01          ; LDA from $A1, Get Segment descriptor word ($06)
                ASLA                             ; 0041: 48             ; 
                ROLB                             ; 0042: 59             ; *2
                ASLA                             ; 0043: 48             ; 
                ROLB                             ; 0044: 59             ; *4 - four sectors / cluster (6 * 4 = 24)
                ADDA    #$01                     ; 0045: 8B 01          ; |
                ADCB    #$00                     ; 0047: C9 00          ; +1 (25, $19)
                STAB    STRSCTH                  ; 0049: D7 01          ; |
                STAA    STRSCTL                  ; 004B: 97 02          ; Startsector (25, $19) 25*128=$C80
                LDAB    $7A,X                    ; 004D: E6 7A          ; |
                LDAA    $7B,X                    ; 004F: A6 7B          ; ($7A,7B), the starting execution address ($0623)
                PSHA                             ; 0051: 36             ; on stack
                PSHB                             ; 0052: 37             ; on stack
                LDAA    $77,X                    ; 0053: A6 77          ; |
                LDAB    $76,X                    ; 0055: E6 76          ; ($76,77), the number of sectors to load ($0040)
                STAA    NUMSCTL                  ; 0057: 97 04          ; |
                STAB    NUMSCTH                  ; 0059: D7 03          ; save
                LDX     $78,X                    ; 005B: EE 78          ; ($78,79), the starting load address ($0100)
                STX     CURADRH                  ; 005D: DF 06          ; save
                LDX     #$07                     ; 005F: CE 00 07       ; |
Z0062           ASLA                             ; 0062: 48             ; |
                ROLB                             ; 0063: 59             ; | multiply by 128 to get bytecount
                DEX                              ; 0064: 09             ; |
                BNE     Z0062                    ; 0065: 26 FB          ; |
                ADDA    CURADRL                  ; 0067: 9B 07          ; |
                ADCB    CURADRH                  ; 0069: D9 06          ; add start address
                STAA    SECTCNTL                 ; 006B: 97 0C          ; |
                STAB    SECTCNTH                 ; 006D: D7 0B          ; is actually Endaddress
                LDX     #$0007F                  ; 006F: CE 00 7F       ; Check Memory @ $80 upwards
Z0072           LDAA    #$AA                     ; 0072: 86 AA          ;
                INX                              ; 0074: 08             ;
                LDAB    ,X                       ; 0075: E6 00          ; Load whats there
                STAA    ,X                       ; 0077: A7 00          ; write $AA
                CMPA    ,X                       ; 0079: A1 00          ; compare
                TPA                              ; 007B: 07             ; Transfer Status to A
                STAB    ,X                       ; 007C: E7 00          ; write the old value back
                TAP                              ; 007E: 06             ; restore status reg.
M007F           BNE     SERRM                    ; 007F: 26 10          ; if not zero - Error 'M'
                CPX     SECTCNTH                 ; 0081: 9C 0B          ; are we done?
                BNE     Z0072                    ; 0083: 26 ED          ; no - continue
                CLR     CURDRV                   ; 0085: 7F 00 00       ; go back to drive 0
                LDAA    #$53                     ; 0088: 86 53          ; |
                PSHA                             ; 008A: 36             ; |
                LDAA    #$E8                     ; 008B: 86 E8          ; |
                PSHA                             ; 008D: 36             ; E853 is CHKERR
                JMP     READPS                   ; 008E: 7E E8 6D       ; on stack is CHKERR and Execution Address
;------------------------------------------------
SERRM           STX     CURDRV                   ; 0091: DF 00          ;
                LDAA    #'M'                     ; 0093: 86 4D          ; if Problem set Error 'M'
;                CPX     #M863F                   ; 0095: 8C 86 3F      ;
                FCB     $8C                                             ;
SERRQM          LDAA    #'?'                     ; 0096: 86 3F          ;
Z0098           STAA    FDSTAT                   ; 0098: 97 08          ; Store Error
                COMB                             ; 009A: 53             ;
                JMP     CHKERR                   ; 009B: 7E E8 53       ;
;------------------------------------------------
                FCB     $00                      ; 009E: 00             ;
                FCB     $00                      ; 009F: 00             ;


                END
