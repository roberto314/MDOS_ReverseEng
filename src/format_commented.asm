         include "mdoseq.inc"

;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
; From studying this code i am pretty sure that PIA PB6 is NOT DS3 but SIDE SELECT
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

STRSCTH EQU     $0001 ; 
STRSCTL EQU     $0002 ; 
NUMSCTH EQU     $0003 ; |
NUMSCTL EQU     $0004 ; contains 26 or 52 according to SS or DS
CURADRH EQU     $0006 ; getes init. w. Address $2004 ($E5E5 gets written to disk)
SECTCNT EQU     $000B ; 
M000C   EQU     $000C ; 
M001A   EQU     $001A ; 
LDADDRH EQU     $0020 ; |
LDADDRL EQU     $0021 ; cont. 76 (max. Track# ?)
TRKNOW  EQU     $0022 ; 
M0023   EQU     $0023 ; 
M0024   EQU     $0024 ; 
NMISAV  EQU     $0025 ; Save old NMI Vector
STACKSAV EQU     $0027 ; 
CLKF1   EQU     $0029 ; CPU Frequency is calculated with rpm of disk (3 for 1MHz)
CLKF2   EQU     $002A ; This is half of the above value (1 for 1MHz)
STATS2  EQU     $002B ; Save of the Status Reg.
EXDSKSD EQU     $002C ; checks PA5 from the disk controller (SS or DS Variant)
M002D   EQU     $002D ; 
M002E   EQU     $002E ; 
M0034   EQU     $0034 ; 
M004C   EQU     $004C ; 
M00FE   EQU     $00FE ; 
M01BD   EQU     $01BD ; 
MEBFE   EQU     $EBFE ; 
MEBFF   EQU     $EBFF ; 
PIAREGA EQU     $EC00 ; 
PIAREGB EQU     $EC01 ; 
PIACTRLA EQU    $EC02 ; 
PIACTRLB EQU    $EC03 ; 
SSDA_0  EQU     $EC04 ; 
SSDA_1  EQU     $EC05 ; 
MFFCC   EQU     $FFCC ; 
MFFE6   EQU     $FFE6 ; 

;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $2000

M2000           FCC     '0300'                   ; Version
M2004           FDB     $E5E5                    ; Data written to disk
FORMATSTART     STS     STACKSAV                 ; 
                LDAA    MEBFF                    ; Get some kind of Disk EPROM Version
                CMPA    #$45                     ; is it $45
                BNE     Z201D                    ; 
                LDAB    #$0A                     ; yes, print error "INVALID DEVICE"
Z2011           SCALL   MDERR1                   ;
                SCALL   MDENT1                   ; bail
SERRB           LDAB    #$0B                     ; 
                BRA     Z2011                    ; 
;------------------------------------------------
Z2019           LDAB    #$04                     ; print error "INVALID LOGICAL UNIT NUMBER"
                BRA     Z2011                    ; 
;------------------------------------------------
Z201D           CLRB                             ; EBFF is not $45
                CMPA    #$43                     ; is it $43
                BEQ     Z2024                    ; 
                LDAB    #$10                     ; 
Z2024           STAB    M0024                    ; 
                LDAA    #$31                     ; LUN
                STAA    M232F                    ; store logical unit # to filename area
                LDX     M00FE                    ; 
                STX     M233A                    ; Address of Input Buffer
                LDX     #M232F                   ; 
                STX     M233C                    ; Address of Standard Filename area (11bytes)
                LDX     #M233A                   ; X: The address of a file name packet
                SCALL   PFNAM1                   ; PROCESS FILE NAME
                LDAA    #$20                     ; 
                CMPA    M2330                    ; check first Byte for $20 (SPACE)
                BNE     SERRB                    ; Set Error index to $B (COMMAND SYNTAX ERROR)
                CMPA    M2338                    ; check last Byte for $20 (SPACE)
                BNE     SERRB                    ; Set Error index to $B (COMMAND SYNTAX ERROR)
                LDAB    M232F                    ; Check LUN
                CMPB    #$30                     ; 
                BLE     Z2019                    ; below or equal $30 - Error 4
                CMPB    #$33                     ; 
                BGT     Z2019                    ; above $33 - Error 4
                STAB    DRVNUM                   ; store drive #
                LDX     #M233E                   ; |
                SCALL   DSPLY1                   ; Output Question "Format Drive X?"
                LDX     #STORAGE                 ; Set up input buffer
                LDAB    #$01                     ; expect one character
                SCALL   KEYIN1                   ; Get it
                LDAA    STORAGE                  ; 
                CMPA    #'Y'                     ;
                BEQ     Z206A                    ; is it Y ? 
                SCALL   MDENT1                   ; No, bail
Z206A           LDAB    DRVNUM                   ; get drive # ($31 for drv. 1)
                ANDB    #$0F                     ; convert from ASCII to number
                STAB    CURDRV                   ; store drive # for floppy controller
                LDX     #$004C                   ; 
                STX     LDADDRH                  ; $4C = 76 (Tracks?)
                LDX     #$2006                   ; 
                STX     M002E                    ; second part of Error Packet (pg. 380 of MDOS User Guide Jun79)
                LDX     #$2004                   ; 
                STX     CURADRH                  ; Which data to write to disk
                JSR     FDINIT    ;EXORDISK      ; the version i have only inits DS0,1 to high and ignores DS2,3
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
; This is an enlightnig piece of code. It shows how the EXORDISK 3 PIA is connected
; to the Diskdrives. We have four Outputs. One (PB6) is identified as SIDE Output, 
; PA0, PA1 and PB5 as driveselect. Lets assume PA0 is for DS0 (not inverted). From
; here we can see that:
;             PA0 PA1 PB5
;             DS0 DS1 DS2
; DRVNUM = 1  hi  low hi
; DRVNUM = 2  low hi  low
; DRVNUM = 3  hi  low low
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

                LDAA    CURDRV                   ; can be 1-3 (0 is not allowed!)
                LDAB    #$66                     ; Bit 1,2,5,6 - WG, READ, DS3(SIDE) high, DS2 high
                LSRA                             ; check Bit 1, is it drive 2 or 3 ?
                BEQ     Z208C                    ; zero, must be DRV1 (0 is not allowed!)
                LDAB    #$46                     ; otherwise it must be DRV 2 or 3, Bit 1,2,6 - WG, READ, DS3(SIDE) high, DS2 low
Z208C           STAB    PIAREGB                  ; ******************* PROBLEM: DS3(SIDE) is never on! - Because it is NOT DS3 but SIDE
                LDAB    #$02                     ; Bit 1 - DS1
                BCC     Z2094                    ; carry clr = Drv. 2 (0 is not allowed!)
                LSRB                             ; 2>>1 = 1, DS0 high (DS1 active)
Z2094           STAB    PIAREGA                  ; or DS1 high, DS0 active, ****** PROBLEM: DS1 + DS2 is on!
                TST     M0024                    ; init. with $10
                BNE     Z20A7                    ; 
                LDAA    MEBFE                    ; Get some kind of Disk EPROM Version
                CMPA    #$11                     ; 
                BEQ     Z20A7                    ; Version 11 ignores RDY
                CMPA    #$12                     ; Version 12 ignores RDY too
                BNE     CHKRDY                   ; all other Versions use RDY Signal
Z20A7           LDAA    #$FF                     ; 
                BRA     Z20B0                    ; 
;------------------------------------------------
CHKRDY          LDAA    PIAREGA                  ; 
                ASLA                             ; |
                ASLA                             ; shift PA6 (RDY) into carry, PA5 into Bit 7
Z20B0           STAA    EXDSKSD                  ; |
                BCC     Z20BA                    ; no problem if RDY is low
                LDAA    #$33                     ; Error '3' (DISK NOT READY)
                STAA    FDSTAT                   ; 
                BRA     Z210A                    ; Jump to show Error Msg.
;------------------------------------------------
Z20BA           LDX     #$001A                   ; $1a = 26
                LDAA    EXDSKSD                  ; |
                BMI     Z20C4                    ; Bit 7 is now PA5
                LDX     #$0034                   ; $34 = 52
Z20C4           STX     NUMSCTH                  ; 26 for SS and 52 for DS
;------------------------------------------------
; From here it is the same code as CLKDMD in the
; EXORDISK ROM $EB85
;------------------------------------------------
                JSR     SETUPNMI                 ; X is on PIAREGA now
                LDAB    $01,X                    ; Load PIAREGB (CLR Interrupt Flag)
                CLRA                             ; 
Z20CC           LDAB    $03,X                    ; Load PIACTRLB
                BPL     Z20CC                    ; Wait for IRQB on CB1 (IDX)
                LDAB    $01,X                    ; Load PIAREGB (CLR Interrupt Flag)
Z20D2           CLRB                             ; 
Z20D3           DECB                             ; |
                BNE     Z20D3                    ; wait
                INCA                             ; A was 0, is now 1
                TST     $03,X                    ; Test PIACTRLB
                BPL     Z20D2                    ; Wait for IRQB on CB1 (IDX) 166ms later
                INCB                             ; 
                SUBA    #$4B                     ; 
Z20DE           INCB                             ; 
                SUBA    #$16                     ; 
                BCC     Z20DE                    ; 
                STAB    CLKF1                    ; 
;------------------------------------------------
                LSRB                             ; 
                STAB    CLKF2                    ; 
                LDAA    #$03                     ; 
                STAA    $01,X                    ; 3 -> PIAREGB (WG high, RESET inactive)
                JSR     Z22D0                    ; Init PIA
                JSR     RESTOR   ;EXORDISK       ; Set up drive
                BCC     Z2117                    ; no error
Z20F4           LDAB    STRSCTH                  ; 
                LDAA    STRSCTL                  ; 
                ADDA    NUMSCTL                  ; |
                ADCB    NUMSCTH                  ; contains 26 or 52 according to SS or DS
                SUBA    M000C                    ; 
                SBCB    SECTCNT                  ; 
                SUBA    #$01                     ; 
                SBCB    #$00                     ; 
Z2104           STAA    STRSCTL                  ; 
                STAB    STRSCTH                  ; 
                LDAA    FDSTAT                   ; 
Z210A           STAA    M002D                    ; first part of Error Packet (pg. 380 of MDOS User Guide Jun79)
Z210C           LDAB    #$01                     ; Error: "**PROM I/O ERROR -- STATUS = \3 AT h DRIVE i - PSN j"
                LDX     #M002D                   ; set pointer to Error Packet
                SCALL   MDERR1                   ; bail
                BCS     Z210C                    ; 
                SCALL   MDENT1                   ; bail
Z2117           LDAA    CLKF1                    ; is 3 for 1MHz
                SUBA    #$04                     ; 
                BCS     Z2132                    ; carry is set on a 1MHz Machine
                SUBA    #$03                     ; 
                BCC     Z2126                    ; carry is clear on a 2MHz machine ??
                LDX     #$2000                   ; 
                BRA     Z212F                    ; otherwise it is a 1.5MHz machine
;------------------------------------------------
Z2126           LDX     #$22AB                   ; |
                STX     M21F0                    ; | Patch it according to CPU freq.
                LDX     #$01BD                   ; |
Z212F           STX     M21EE                    ; |
Z2132           LDAA    LDADDRH                  ; High Byte is zero
                STAA    TRKNOW                   ; 
                LDX     #MFFE6                   ; $10000-$FFE6 = 26
                TST     EXDSKSD                  ; Bit 7 is now PA5
                BMI     Z2141                    ; check for SS or DS
                LDX     #MFFCC                   ; $10000-$FFCC = 52
Z2141           STX     STRSCTH                  ; 26 or 52 until overflow
Z2143           LDAB    STRSCTL                  ; 
                ADDB    NUMSCTL                  ; contains 26 or 52 according to SS or DS
                STAB    STRSCTL                  ; 
                LDAB    STRSCTH                  ; 
                ADCB    #$00                     ; 
                STAB    STRSCTH                  ; 
                DECA                             ; 
                BPL     Z2143                    ; 
NXTTRK          JSR     SEEK         ;EXORDISK   ; get to next track
                BCS     Z20F4                    ; error or done
                LDAA    M0024                    ; init w. $10
                LSRA                             ; 
                LSRA                             ; 
                LSRA                             ; 
                LSRA                             ; should be 1
                ADDA    TRKNOW                   ; should be 0 but gets increased (Track?)
                LDAB    PIAREGA                  ; Load PIAA
                ORAB    #$04                     ; isolate bit 2 (TG43)
                CMPA    #$2B                     ; check for Track > 43
                BLS     Z216A                    ; No
                ANDB    #$FB                     ; Clr Bit 2 (TG43 on PA2)
Z216A           STAB    PIAREGA                  ; write
                LDAA    #$01                     ; 
                STAA    M0023                    ; init w. 1
                LDAA    PIAREGB                  ; |
                ORAA    #$40                     ; set Bit 6 (DS3(SIDE) high)
Z2176           STAA    PIAREGB                  ; or coming from JMP write $23 (DS2, PB0(Reset inact.); WG high, DS3(SIDE) low)
                JSR     SETUPNMI                 ; X is on PIAREGA now, also Rerigger NMI Timer
                LDAB    #$27                     ; Counter for below (approx. $22F5)
                LDAA    CLKF2                    ; |
Z2180           DECA                             ; |
                BNE     Z2180                    ; wait
                LDX     #$C0DA                   ; 
                STX     SSDA_0                   ; 
                LDX     #$C1FF                   ; 
                STX     SSDA_0                   ; 
                LDX     #$8270                   ; 
                STX     SSDA_0                   ; 
                LDAA    PIAREGB                  ; 
                ANDA    #$F2                     ; clr bit 0,2,3 (RESET, WRITE, SHIFT-CRC)
                STAA    PIAREGB                  ; 
Z219D           EORA    M0024                    ; init w. $10 (do A EXOR $10) basically check PB4 and toggle it
                BITA    #$10                     ; check PB4 (WPROT)
                BNE     Z21AD                    ; if PB4 was low then continue ** THIS IS THE OPPOSITE OF EXORDISK2 ROM **
                JSR     Z22D0                    ; Init PIA
                LDAA    #$32                     ; |
                STAA    FDSTAT                   ; Error: "DISK WRITE PROTECTED"
                JMP     Z210A                    ; Output Error "PROM I/O..."
;------------------------------------------------
Z21AD           ANDA    #$60                     ; Clear all except Bit 5,6 (DS2 and DS3(SIDE) )
                STAA    PIAREGB                  ; 
Z21B2           LDAA    PIACTRLB                 ; |
                BPL     Z21B2                    ; Wait for IRQB on CB1 (IDX)
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
NXTSEC          LDAA    #$18                     ; 
                LDX     #$8210                   ; 
                STX     SSDA_0                   ; 
Z21DB           BITA    SSDA_0                   ; 
                BEQ     Z21DB                    ; 
                STAA    SSDA_1                   ; 
Z21E3           BITA    SSDA_0                   ; 
                BEQ     Z21E3                    ; 
                LDX     #$C270                   ; 
                STX     SSDA_0                   ; 
M21EE           BITA    #$00                     ; < gets patched to $01BD - NOP, JSR M22AB or $2000 - BRA M21F0
M21F0           LDAA    #$82                     ; < gets patched to $22AB - used only with JSR from above!
                INC     PIAREGB                  ; |
                DEC     PIAREGB                  ; Toggle PB0 (RESET)
                STAA    SSDA_0                   ; A is still $82
                JSR     Z22E2                    ; 
                LDX     #$83F5                   ; 
                STX     SSDA_0                   ; 
                LDAB    #$7E                     ; 
                LDAA    #$40                     ; 
                STAB    SSDA_1                   ; 
Z220B           BITA    SSDA_0                   ; 
                BEQ     Z220B                    ; 
                LDAB    TRKNOW                   ; 
                STAB    SSDA_1                   ; 
                CLRB                             ; 
                STAB    SSDA_1                   ; 
Z2219           BITA    SSDA_0                   ; 
                BEQ     Z2219                    ; 
                LDAB    M0023                    ; init w. 1
                STAB    SSDA_1                   ; 
                CLRB                             ; 
                STAB    SSDA_1                   ; 
Z2227           BITA    SSDA_0                   ; 
                BEQ     Z2227                    ; 
                STAB    SSDA_1                   ; 
Z222F           BITA    SSDA_0                   ; 
                BEQ     Z222F                    ; 
                LDAB    PIAREGB                  ; |
                ORAB    #$08                     ; Set SHIFT-CRC high
                STAB    PIAREGB                  ; |
                STAB    SSDA_1                   ; 
Z223F           BITA    SSDA_0                   ; 
                BEQ     Z223F                    ; 
                LDAA    #$FF                     ; 
                STAA    SSDA_1                   ; 
                LDAA    #$40                     ; 
Z224B           BITA    SSDA_0                   ; 
                BEQ     Z224B                    ; 
                ANDB    #$60                     ; Clear all bits except Bit 5,6 (DS2 and DS3(SIDE) unaffected)
                STAB    PIAREGB                  ; |
                LDX     #$81FF                   ; 
                STX     SSDA_0                   ; 
                LDAB    #$AC                     ; 
                LDAA    M0023                    ; |
                INCA                             ; incr. $23
                STAA    M0023                    ; |
                CMPA    #$1B                     ; $1B = 27
                BEQ     SIDEDONE                 ; 
                CMPA    #$35                     ; $35 = 53
                BEQ     SIDEDONE                 ; 
                JMP     NXTSEC                   ; 
;------------------------------------------------
SIDEDONE        LDAA    PIACTRLB                 ; |
                BPL     SIDEDONE                 ; Wait for IRQB on CB1 (IDX)
                DEC     PIAREGB                  ; Toggle RESET
                DEC     PIAREGB                  ; 
                BSR     Z22D0                    ; Init PIA
                LDAA    M0023                    ; 
                CMPA    #$1B                     ; $1B = 27
                BNE     Z2289                    ; 
                LDAA    EXDSKSD                  ; Bit 7 is now PA5
                BMI     Z2289                    ; check for SS or DS
                LDAA    #$23                     ; value for PIAREGB
                JMP     Z2176                    ; 
;------------------------------------------------
Z2289           JSR     RWTEST    ;EXORDISK      ; actually write data to disk
                BCC     Z2291                    ; 
                JMP     Z20F4                    ; Error or done
;------------------------------------------------
Z2291           LDAA    STRSCTL                  ; 
                LDAB    STRSCTH                  ; 
                ADDA    NUMSCTL                  ; contains 26 or 52 according to SS or DS
                ADCB    #$00                     ; 
                STAA    STRSCTL                  ; 
                STAB    STRSCTH                  ; 
                INC     TRKNOW                   ; 
                LDAA    LDADDRL                  ; 
                CMPA    TRKNOW                   ; 
                BCS     Z22A9                    ; bail
                JMP     NXTTRK                   ; 
;------------------------------------------------
Z22A9           SCALL   MDENT1
M22AB           LDAA    #$82                     ; 
                BITA    LDADDRH                  ; 
                RTS                              ; 
;------------------------------------------------
SETUPNMI        TPA                              ; 
                SEI                              ; 
                STAA    STATS2                   ; 
                LDX     NMIsVC                   ; 
                STX     NMISAV                   ; 
                LDX     #NMI_ISR                 ; 
                STX     NMIsVC                   ; 
                LDX     #PIAREGA                 ; 
                LDAA    #$36                     ; |
                STAA    $03,X                    ; $36 -> PIACTRLB (CB2 Low - Trigger NMI Timer, IRQB Flag set by HL on CB1 - IDX, Select Output Reg. B)
                LDAA    #$3E                     ; |
                STAA    $03,X                    ; $3E -> PIACTRLB (CB2 high)
                LDAB    ,X                       ; Get Port A
                DECA                             ; 
                STAA    $02,X                    ; $3D -> PIACTRLA (En. IRQA interrupt by CA1 - NMI Timer, Sel. Output Reg. A, CA2 high - STEP)
                RTS                              ; 
;------------------------------------------------
Z22D0           LDX     #$3C3E                   ; Select both Output Reg., Set CA2 (STEP), Set CB2 (NMI Timer), IRQB (IRQ) Set by LH Transition of CB1 (IDX)
                STX     PIACTRLA                 ; 
                LDX     PIAREGA                  ; 
                LDX     NMISAV                   ; 
                STX     NMIsVC                   ; 
                LDAA    STATS2                   ; 
                TAP                              ; 
                RTS                              ; 
;------------------------------------------------
Z22E2           LDAA    #$18                     ; 
Z22E4           BITA    SSDA_0                   ; |
                BEQ     Z22E4                    ; wait
                LDAA    CLKF2                    ; 
Z22EB           DECA                             ; 
                BNE     Z22EB                    ; 
                LDAA    #$18                     ; 
                STAA    SSDA_1                   ; 
                DECB                             ; B is init to $27 above (approx. $217B)
                BNE     Z22E4                    ; 
                LDX     #$81AA                   ; 
                LDAB    #$05                     ; 
                NOP                              ; 
                NOP                              ; 
                STX     SSDA_0                   ; 
                LDX     #$8210                   ; 
                STX     SSDA_0                   ; 
Z2306           BITA    SSDA_0                   ; |
                BEQ     Z2306                    ; wait
                LDAA    CLKF2                    ; 
Z230D           DECA                             ; |
                BNE     Z230D                    ; wait
                LDAA    #$18                     ; 
                STAA    SSDA_1                   ; 
                DECB                             ; 
                BNE     Z2306                    ; 
                RTS                              ; 
;------------------------------------------------
NMI_ISR         LDS     STACKSAV                 ; 
                BSR     Z22D0                    ; Init PIA
                JSR     FDINIT   ;EXORDISK       ; 
                LDAA    #$35                     ; Error: "TIMEOUT"
                STAA    FDSTAT                   ; 
                LDAA    M0023                    ; 
                DECA                             ; 
                CLRB                             ; 
                ADDA    STRSCTL                  ; 
                ADCB    STRSCTH                  ; 
                JMP     Z2104                    ; 
;------------------------------------------------
M232F           FCC     ' '                      ; 
M2330           FCC     '        '               ; 
M2338           FCC     '  '                     ; 
M233A           FDB     $0000                    ; 
M233C           FDB     $0000                    ; 
M233E           FCC     'FORMAT DRIVE '          ; 
DRVNUM          FCC     'X?'                     ; 
                FCB     $0d                      ; 
STORAGE         FCB     $00                      ; 
                REPT    $B1                      ; Filler
                FCB     $00
                ENDM
                END
