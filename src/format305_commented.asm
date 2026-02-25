        include "mdoseq.inc"

;****************************************************
; Used Labels
;****************************************************

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
SECNUM  EQU     $0023 ; 
M0024   EQU     $0024 ; 
NMISAV  EQU     $0025 ; Save old NMI Vector
STACKSAV EQU     $0027 ; 
CLKF1   EQU     $0029 ; CPU Frequency is calculated with rpm of disk (3 for 1MHz)
CLKF2   EQU     $002A ; This is half of the above value (1 for 1MHz)
STATS2  EQU     $002B ; Save of the Status Reg.
EXDSKSD EQU     $002C ; checks PA5 from the disk controller (SS or DS Variant)

M002D   EQU     $002D
M002E   EQU     $002E
M0030   EQU     $0030
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
XOUTCH  EQU     $F018
MFFCC   EQU     $FFCC
MFFE6   EQU     $FFE6

;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $2000

; This Version is pretty much the same as 300.
; There are some patches from $2350

M2000           FCC     ' 303'                   ; 2000: 20 33 30 33 ; Version 
M2004           FDB     $E5E5                    ; 2004: E5 E5       ; Data written to disk 
FORMATSTART     STS     STACKSAV                 ; 2006: 9F 27       ;  
                LDAA    MEBFF                    ; 2008: B6 EB FF    ; Get some kind of Disk EPROM Version 
                CMPA    #$45                     ; 200B: 81 45       ; is it $45 
                BNE     Z201D                    ; 200D: 26 0E       ;  
                LDAB    #$0A                     ; 200F: C6 0A       ; yes, print error "INVALID DEVICE" 
Z2011           SCALL   MDERR1                   ; 2011: 3F          ;  
                SCALL   MDENT1                   ; 2012: 20          ; bail 
SERRB           LDAB    #$0B                     ; 2015: C6 0B       ; 
                BRA     Z2011                    ; 2017: 20 F8       ; 
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
                LDAB    #$66                     ; Bit 1,2,5,6 - READ, DS3(SIDE) high, DS2 high
                LSRA                             ; check Bit 1, is it drive 2 or 3 ?
                BEQ     Z208C                    ; zero, must be DRV1 (0 is not allowed!)
                LDAB    #$46                     ; otherwise it must be DRV 2 or 3, Bit 1,2,6 - WG, READ, DS3(SIDE) high, DS2 low
Z208C           STAB    PIAREGB                  ; ******************* PROBLEM: DS3(SIDE) is never on! - Because it is NOT DS3 but SIDE
                LDAB    #$02                     ; Bit 1 - DS1
                BCC     Z2094                    ; carry clr = Drv. 2 (0 is not allowed!)
                LSRB                             ; 2>>1 = 1, DS0 high (DS1 active)
Z2094           JSR     SETDIRQ   ; 2094: BD 23 50  ; Different to v300! (sets DIRQ high)
;Z2094           STAB    PIAREGA                  ; or DS1 high, DS0 active, ****** PROBLEM: DS1 + DS2 is on!
                TST     M0024            ; 2097      ; init. with $10, gets reset by exordisk, if not, assume single sided 
                BNE     Z20A7            ; 209A      ; 
                LDAA    MEBFE            ; 209C      ; Get some kind of Disk EPROM Version
                CMPA    #$11             ; 209F      ; 
                BEQ     Z20A7            ; 20A1      ; Version 11 ignores RDY and is Singlesided
                CMPA    #$12             ; 20A3      ; Version 12 ignores RDY too and is Singlesided
                BNE     CHKRDY           ; 20A5      ; all other Versions use RDY Signal and are Doublesided
Z20A7           LDAA    #$FF             ; 20A7      ; 
                BRA     Z20B0            ; 20A9      ; 
;------------------------------------------------
CHKRDY          LDAA    PIAREGA          ; 20AB      ; 
                ASLA                     ; 20AE      ; |
                ASLA                     ; 20AF      ; shift PA6 (RDY) into carry, PA5 into Bit 7
Z20B0           STAA    EXDSKSD          ; 20B0      ; |
                BCC     Z20BA            ; 20B2      ; no problem if RDY is low
                LDAA    #$33             ; 20B4      ; Error '3' (DISK NOT READY)
                STAA    FDSTAT           ; 20B6      ; 
                BRA     Z210A            ; 20B8      ; Jump to show Error Msg.
;------------------------------------------------
Z20BA           LDX     #$001A                   ; $1a = 26
                LDAA    EXDSKSD                  ; |
                BMI     Z20C4                    ; Bit 7 is now PA5, if PA5 is high -> Single Sided
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
                JSR     INITPIA                  ; Init PIA
                JSR     RESTOR   ;EXORDISK       ; Set up drive
                BCC     Z2117                    ; no error
;------------------------------------------------
FATALERROR      LDAB    STRSCTH                  ; 
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
                BMI     Z2141                    ; check for SS or DS, if PA5 is high -> Single Sided
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
Z2152           JMP     RELOADNXTTR   ; 2152: 7E 23 6D   ; Different from v300! (stores $5 to $0030)
;NXTTRK          JSR     SEEK         ;EXORDISK   ; get to next track
;------------------------------------------------
; #############  Writeloop  #####################
;------------------------------------------------
NXTTRK          BCS     FATALERROR           ; 2155    ; error or done
                LDAA    M0024                ; 2157    ; init w. $10 for SS or $00 for DS (gets reset from exordisk firmware)
                LSRA                         ; 2159    ; 
                LSRA                         ; 215A    ; 
                LSRA                         ; 215B    ; 
                LSRA                         ; 215C    ; should be 1 for SS or 0 for DS
                ADDA    TRKNOW               ; 215D    ; gets increased in DATADONE
                LDAB    PIAREGA              ; 215F    ; Load PIAA
                ORAB    #$04                 ; 2162    ; isolate bit 2 (TG43)
                CMPA    #$2B                 ; 2164    ; check for Track > 43
                BLS     Z216A                ; 2166    ; No
                ANDB    #$FB                 ; 2168    ; Clr Bit 2 (TG43 on PA2)
Z216A           STAB    PIAREGA              ; 216A    ; write
                LDAA    #$01                 ; 216D    ; 
                STAA    SECNUM               ; 216F    ; init w. 1
                LDAA    PIAREGB              ; 2171    ; |
                ORAA    #$40                 ; 2174    ; set Bit 6 (DS3(SIDE) high)
Z2176           STAA    PIAREGB              ; 2176    ; or coming from JMP write $23 (DS2, PB0(Reset inact.); WG high, DS3(SIDE) whatever)
                JSR     SETUPNMI             ; 2179    ; X is on PIAREGA now, also Rerigger NMI Timer
                LDAB    #$27                 ; 217C    ; Counter for below (approx. $22F5)
                LDAA    CLKF2                ; 217E    ; |
Z2180           DECA                         ; 2180    ; |
                BNE     Z2180                ; 2181    ; wait
                LDX     #$C0DA               ; 2183    ; RXRs, TXRs, Sel. CR2 | PC12 - SM Inhibit, 8-Bit, TX Syn 
                STX     SSDA_0               ; 2186    ; |
                LDX     #$C1FF               ; 2189    ; RXRs, TXRs, Sel. Sync Code Reg. | $FF Sync 
                STX     SSDA_0               ; 218C    ; |
                LDX     #$8270               ; 218F    ; RXRs, Sel. CR3 | 1 Sync Char., Clr. CTS, Clr. TUF 
                STX     SSDA_0               ; 2192    ; |
                LDAA    PIAREGB              ; 2195    ; |
                ANDA    #$F2                 ; 2198    ; clr bit 0,2,3 (RESET, WRITE, SHIFT-CRC)
                STAA    PIAREGB              ; 219A    ; |
Z219D           EORA    M0024                ; 219D    ; init w. $10 (do A EXOR $10) basically check PB4 and toggle it
                BITA    #$10                 ; 219F    ; check PB4 (WPROT)
                BNE     WRITID               ; 21A1    ; if PB4 was low then continue ** THIS IS THE OPPOSITE OF EXORDISK2 ROM **
                JSR     INITPIA              ; 21A3    ; Init PIA
                LDAA    #$32                 ; 21A6    ; |
                STAA    FDSTAT               ; 21A8    ; Error: "DISK WRITE PROTECTED"
                JMP     Z210A       ;--> ERROR    ; Output Error "PROM I/O..."
;------------------------------------------------
; Write Index Mark $F7, $7A
;------------------------------------------------
WRITID          ANDA    #$60                 ; 21AD    ; Clear all except Bit 5,6 (DS2 and DS3(SIDE) )
                STAA    PIAREGB              ; 21AF    ; 
Z21B2           LDAA    PIACTRLB             ; 21B2    ; |
                BPL     Z21B2                ; 21B5    ; Wait for IRQB on CB1 (IDX)
                LDX     #$8210               ; 21B7    ; RXRs, Sel. CR3 | Clr TUF
                STX     SSDA_0               ; 21BA    ; |
                JSR     Z22E2                ; 21BD    ; 
                LDX     #$83F7               ; 21C0    ; RXRs, sel. TxFIFO | $F7 Transmit FIFO
                STX     SSDA_0               ; 21C3    ; |
                LDAA    #$7A                 ; 21C6    ; $7A TX FIFO
                STAA    SSDA_1               ; 21C8    ; |
                LDX     #$81FF               ; 21CB    ; RXRs, Sel Sync Code Reg. | $FF > Sync Code
                STX     SSDA_0               ; 21CE    ; 
                LDAB    #$17                 ; 21D1    ; 
;------------------------------------------------
; #########  Sector Writeloop  ##############
;------------------------------------------------
NXTSEC          LDAA    #$18                 ; 21D3    ; 
                LDX     #$8210               ; 21D5    ; RXRs, Sel. CR3 | Clr. TUF
                STX     SSDA_0               ; 21D8    ; |
Z21DB           BITA    SSDA_0               ; 21DB    ; |
                BEQ     Z21DB                ; 21DE    ; wait for Transmitter empty
                STAA    SSDA_1               ; 21E0    ; CR2 ? <$18 - 8-bit word
Z21E3           BITA    SSDA_0               ; 21E3    ; |
                BEQ     Z21E3                ; 21E6    ; wait for Transmitter empty
                LDX     #$C270               ; 21E8    ; RXRs, TXRs, sel. CR3 | 1 Sync Char, Clr. CTS, Clr. TUF
                STX     SSDA_0               ; 21EB    ; |
M21EE           BITA    #$00                 ; 21EE    ; < gets patched to $01BD - NOP, JSR M22AB or $2000 - BRA M21F0
M21F0           LDAA    #$82                 ; 21F0    ; < gets patched to $22AB - used only with JSR from above!
                INC     PIAREGB              ; 21F2    ; |
                DEC     PIAREGB              ; 21F5    ; Toggle PB0 (RESET)
                STAA    SSDA_0               ; 21F8    ; A is still $82, CR1: RXRs, Sel. CR3
                JSR     Z22E2                ; 21FB    ; 
;------------------------------------------------
; Write ID Mark $F5, $7E and build ID Record
; Format: F5 | 7E | TRK | 00 | SEC | 00 | 00 | 
;------------------------------------------------
                LDX     #$83F5               ; 21FE    ; RXRs, sel. TxFIFO | $F5 Transmit FIFO (Sync Code)
                STX     SSDA_0               ; 2201    ; |
                LDAB    #$7E                 ; 2204    ; ID address mark 
                LDAA    #$40                 ; 2206    ; get Bit 6 from Status Reg.
                STAB    SSDA_1               ; 2208    ; Store ID mark 
;--------------
Z220B           BITA    SSDA_0               ; 220B    ; |
                BEQ     Z220B                ; 220E    ; Wait for TX FIFO write to finish
;--------------
                LDAB    TRKNOW               ; 2210    ; |
                STAB    SSDA_1               ; 2212    ; Store Track#
                CLRB                         ; 2215    ; |
                STAB    SSDA_1               ; 2216    ; Write 0
;--------------
Z2219           BITA    SSDA_0               ; 2219    ; |
                BEQ     Z2219                ; 221C    ; Wait for TX FIFO write to finish
;--------------
                LDAB    SECNUM               ; 221E    ; init w. 1
                STAB    SSDA_1               ; 2220    ; Store Sector#
                CLRB                         ; 2223    ; |
                STAB    SSDA_1               ; 2224    ; write 0
;--------------
Z2227           BITA    SSDA_0               ; 2227    ; |
                BEQ     Z2227                ; 222A    ; Wait for TX FIFO write to finish
;--------------
                STAB    SSDA_1               ; 222C    ; write 0
;--------------
Z222F           BITA    SSDA_0               ; 222F    ; |
                BEQ     Z222F                ; 2232    ; Wait for TX FIFO write to finish
;--------------
                LDAB    PIAREGB              ; 2234    ; |
                ORAB    #$08                 ; 2237    ; Set SHIFT-CRC high
                STAB    PIAREGB              ; 2239    ; |
                STAB    SSDA_1               ; 223C    ; ?
;--------------
Z223F           BITA    SSDA_0               ; 223F    ; Wait for TX FIFO write to finish
                BEQ     Z223F                ; 2242    ; |
;--------------
                LDAA    #$FF                 ; 2244    ; |
                STAA    SSDA_1               ; 2246    ; Write Gap
                LDAA    #$40                 ; 2249    ; |
;--------------
Z224B           BITA    SSDA_0               ; 224B    ; Wait for TX FIFO write to finish
                BEQ     Z224B                ; 224E    ; |
;--------------
                ANDB    #$60                 ; 2250    ; Clear all bits except Bit 5,6 (DS2 and DS3(SIDE) unaffected)
                STAB    PIAREGB              ; 2252    ; |
                LDX     #$81FF               ; 2255    ; RXRs, Sel Sync Code Reg. | $FF > Sync Code
                STX     SSDA_0               ; 2258    ; |
                LDAB    #$AC                 ; 225B    ; 
                LDAA    SECNUM               ; 225D    ; |
                INCA                         ; 225F    ; incr. $23
                STAA    SECNUM               ; 2260    ; |
                CMPA    #$1B                 ; 2262    ; $1B = 27
                BEQ     SIDEDONE             ; 2264    ; 
                CMPA    #$35                 ; 2266    ; $35 = 53
                BEQ     SIDEDONE             ; 2268    ; 
                JMP     NXTSEC      ;--> BACK ; 226A    ; 
;------------------------------------------------
SIDEDONE        LDAA    PIACTRLB             ; 226D    ; |
                BPL     SIDEDONE             ; 2270    ; Wait for IRQB on CB1 (IDX)
;--------------
                DEC     PIAREGB              ; 2272    ; Toggle RESET
                DEC     PIAREGB              ; 2275    ; 
                BSR     INITPIA              ; 2278    ; Init PIA
                LDAA    SECNUM               ; 227A    ; at this point SECNUM can only be $1B or $35
                CMPA    #$1B                 ; 227C    ; $1B = 27
                BNE     WRITDAT              ; 227E    ; it was $35, now write data
                LDAA    EXDSKSD              ; 2280    ; Bit 7 is now PA5
                BMI     WRITDAT              ; 2282    ; check for SS or DS, if PA5 is high -> Single Sided
                JMP     WRITEDONE            ; 2284 ; Different from v300! (sets PB0-RESET and WG, clears all but DS2) and Jumps to 2176
;                LDAA    #$23                     ; value for PIAREGB, next Side
                FDB     $2176                    ; old code, not used anymore
;------------------------------------------------
WRITDAT         JSR     RWTEST    ;EXORDISK      ; actually write data to disk
                BCC     DATADONE                 ; Data written successfully
                JMP     TRYAGAIN ; 228E: 7E 23 77  ;  Different from v300! Jumps to 20F4 if Error persists 5 times
                                             ; otherwise SEEK & NXTTRK
;               JMP     FATALERROR               ; Error or done
;------------------------------------------------
DATADONE        LDAA    STRSCTL                  ; 
                LDAB    STRSCTH                  ; 
                ADDA    NUMSCTL                  ; contains 26 or 52 according to SS or DS
                ADCB    #$00                     ; 
                STAA    STRSCTL                  ; 
                STAB    STRSCTH                  ; 
                INC     TRKNOW                   ; 
                LDAA    LDADDRL                  ; contains $76
                CMPA    TRKNOW                   ; are we finished?
                JMP     CHKDONE    ; 22A4: 7E 23 60  ;  Different from v300!
;                BCS     Z22A9                    ; if yes, restart
;                JMP     NXTTRK                   ; if no, seek to next track
                FDB     $2152                     ; old code
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
INITPIA         LDX     #$3C3E                   ; Select both Output Reg., Set CA2 (STEP), Set CB2 (NMI Timer), IRQB (IRQ) Set by LH Transition of CB1 (IDX)
                STX     PIACTRLA                 ; 
                LDX     PIAREGA                  ; 
                LDX     NMISAV                   ; 
                STX     NMIsVC                   ; 
                LDAA    STATS2                   ; 
                TAP                              ; 
                RTS                              ; 
;------------------------------------------------
Z22E2           LDAA    #$18              ; 22E2      ; CR3 selected
Z22E4           BITA    SSDA_0            ; 22E4      ; |
                BEQ     Z22E4             ; 22E7      ; wait for Transmitter empty
                LDAA    CLKF2             ; 22E9      ; 
Z22EB           DECA                      ; 22EB      ; 
                BNE     Z22EB             ; 22EC      ; 
                LDAA    #$18              ; 22EE      ; |
                STAA    SSDA_1            ; 22F0      ; CR3: Clr. TUF, 8 has no effet
                DECB                      ; 22F3      ; B is init to $27 above (approx. $217B)
                BNE     Z22E4             ; 22F4      ; 
                LDX     #$81AA            ; 22F6      ; RXRs, Sel. SyncCodeReg | $AA Sync
                LDAB    #$05              ; 22F9      ; 
                NOP                       ; 22FB      ; 
                NOP                       ; 22FC      ; 
                STX     SSDA_0            ; 22FD      ; 
                LDX     #$8210            ; 2300      ; RxRs, Sel. CR3 | Clr. TUF
                STX     SSDA_0            ; 2303      ; 
Z2306           BITA    SSDA_0            ; 2306      ; |
                BEQ     Z2306             ; 2309      ; wait for Transmitter empty
                LDAA    CLKF2             ; 230B      ; 
Z230D           DECA                      ; 230D      ; |
                BNE     Z230D             ; 230E      ; wait
                LDAA    #$18              ; 2310      ; |
                STAA    SSDA_1            ; 2312      ; CR3: Clr. TUF, 8 has no effet
                DECB                      ; 2315      ; 
                BNE     Z2306             ; 2316      ; 
                RTS                       ; 2318      ; 
;------------------------------------------------
NMI_ISR         LDS     STACKSAV                 ; 
                BSR     INITPIA                  ; Init PIA
                JSR     FDINIT   ;EXORDISK       ; 
                LDAA    #$35                     ; Error: "TIMEOUT"
                STAA    FDSTAT                   ; 
                LDAA    SECNUM                   ; 
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
STORAGE         FDB     $0000                    ; 
;------------------------------------------------
; Here are all the Patches which makes this
; Version different from 300.
;------------------------------------------------
SETDIRQ         ORAB    #$08                     ; Set DIRQ high
                STAB    PIAREGA                  ; store it.
                RTS                              ; 
;------------------------------------------------
WRITEDONE       LDAA    PIAREGB                  ; 
                ANDA    #$20                     ; Clear all but DS2
                ORAA    #$03                     ; Set PB0 (RESET inactive) and WG inactive
                JMP     Z2176                    ; 
;------------------------------------------------
CHKDONE         BCS     SIGNALDONE               ; 
                JMP     RELOADNXTTR              ; 
;------------------------------------------------
SIGNALDONE      LDAA    #$07                     ; Bell for finished
                JSR     XOUTCH                   ; output
                JMP     FORMATSTART              ; restart
;------------------------------------------------
RELOADNXTTR     LDAA    #$05                     ; Reload 5 tries and
                STAA    M0030                    ; |
Z2371           JSR     SEEK        ;EXORDISK    ; go to next track
                JMP     NXTTRK                   ; go again
;------------------------------------------------
TRYAGAIN        DEC     M0030                    ; try again for max 5 times
                BNE     Z2371                    ; 
                JMP     FATALERROR               ; give up...


                END
