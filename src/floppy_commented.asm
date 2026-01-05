dasmfw: Disassembler Framework V0.35
Loaded: binary file "floppy.bin"
Loaded: Info file "floppy.info"

; This version does not work with my Exordisk remake!
; There are some differences, especially in the way
; STEP and DIR work.
; look for the file floppy2 - this works and 
; is able to reassemble with asl.

; The PIA has A0 and A1 switched!
; 00 with CRA2 Set is Peripheral Register A 
; 00 with CRA2 cleared is Data Direction Register A 
; 01 with CRB2 Set is Peripheral Register B 
; 01 with CRB2 cleared is Data Direction Register B 
; 02 is Control Register A
; 03 is Control Register B
;****************************************************
; Used Labels
;****************************************************

CURDRV     EQU     $0000
STRSCTH    EQU     $0001
STRSCTL    EQU     $0002
NUMSCTH    EQU     $0003
NUMSCTL    EQU     $0004
LSCTLN     EQU     $0005
CURADRH    EQU     $0006
CURADRL    EQU     $0007
FDSTAT     EQU     $0008
M0009      EQU     $0009
SECTOR     EQU     $000A
SECTCNT    EQU     $000B
STATSAV    EQU     $000D
FUNCSAV    EQU     $000E
NMIVECSAV  EQU     $000F
M0011      EQU     $0011
M0012      EQU     $0012
TRACKSAV   EQU     $0013
M0014      EQU     $0014
WRDCNT     EQU     $0015
M0016      EQU     $0016
M0018      EQU     $0018
M0019      EQU     $0019
LDADDR     EQU     $0020
EXADDR     EQU     $0022
ONECON     EQU     $0024
PIAREGA    EQU     $EC00
PIAREGB    EQU     $EC01
PIACTRL    EQU     $EC02
SSDA_0     EQU     $EC04
SSDA_1     EQU     $EC05
MEC10      EQU     $EC10
MEC11      EQU     $EC11
MEC12      EQU     $EC12
MEC13      EQU     $EC13
PWRUP      EQU     $F000
XBEGEN     EQU     $F003
XCBCDH     EQU     $F006
XCHEXL     EQU     $F009
XCHEXR     EQU     $F00C
XINADD     EQU     $F00F
XINCH      EQU     $F012
XINCHN     EQU     $F015
XOUTCH     EQU     $F018
XOUT2H     EQU     $F01B
XOUT4H     EQU     $F01E
XPCRLF     EQU     $F021
XPDATA     EQU     $F024
XPDAT      EQU     $F027
XPSPAC     EQU     $F02A
REENT2     EQU     $F564
XSTAK$     EQU     $FF8A
MFF2E      EQU     $FF2E
NMI$VC     EQU     $FFFC

;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $E800

OSLOAD          LDS     #XSTAK$                  ; E800: 8E FF 8A ; Set Stackpointer
                BSR     FDINIT                   ; E803: 8D 1D    ; Init PIA and SSDA
                CLR     CURDRV                   ; E805: 7F 00 00 ; Set Drive to 0
                BSR     RESTOR                   ; E808: 8D 6B    ; 
                BSR     CHKERR                   ; E80A: 8D 47    ; 
                LDX     #$0017                   ; E80C: CE 00 17 ; Start at Sector $17 (Bootblock) (0xB80)
                STX     STRSCTH                  ; E80F: DF 01    ; |
                LDX     #$0002                   ; E811: CE 00 02 ; Get 2 sectors
                STX     NUMSCTH                  ; E814: DF 03    ; |
                LDX     #LDADDR                  ; E816: CE 00 20 ; Load @ 0x20
                STX     CURADRH                  ; E819: DF 06    ; |
                BSR     READSC                   ; E81B: 8D 4C    ; Read the Sector
                BSR     CHKERR                   ; E81D: 8D 34    ; Check for Erroro
                JMP     LDADDR                   ; E81F: 7E 00 20 ; Execute loaded code....
;------------------------------------------------
FDINIT          LDX     #$0000                   ; E822: CE 00 00 ; |
                STX     PIACTRL                  ; E825: FF EC 02 ; clr both control Reg.
                STX     PIAREGA                  ; E828: FF EC 00 ; Set A and B to Input
                LDX     #$D0DA                   ; E82B: CE D0 DA ; 
                STX     SSDA_0                   ; E82E: FF EC 04 ; 
                LDX     #$0404                   ; E831: CE 04 04 ; |
                STX     PIACTRL                  ; E834: FF EC 02 ; Set A and B to Output Reg.
                LDX     #$1B02                   ; E837: CE 1B 02 ; |
                STX     PIAREGA                  ; E83A: FF EC 00 ; Set DS0, DS1, DIRQ, HLD, WG high
                LDX     #$0000                   ; E83D: CE 00 00 ; |
                STX     PIACTRL                  ; E840: FF EC 02 ; Set both to Data direction Reg.
                LDX     #$1F0F                   ; E843: CE 1F 0F ; |
                STX     PIAREGA                  ; E846: FF EC 00 ; PA0-PA4, PB0-PB3 Output
ZE849           LDX     #$3C3E                   ; E849: CE 3C 3E ; |
                STX     PIACTRL                  ; E84C: FF EC 02 ; Select both Output Reg., Set CA2 (STEP), Set CB2 (NMI Timer), IRQB (IRQ) Set by LH Transition of CB1 (IDX)
                LDX     PIAREGA                  ; E84F: FE EC 00 ; |
ZE852           RTS                              ; E852: 39       ; Both Output Regsters Selected, X @ PIACTRL
;------------------------------------------------
CHKERR          BCC     ZE852                    ; E853: 24 FD    ; no carry - no error
ZE855           BSR     PRNTER                   ; E855: 8D 03    ; Print for ex.: 'E2 ' for Error 0x32
                JMP     REENT2                   ; E857: 7E F5 64 ; 
;------------------------------------------------
PRNTER          LDAA    #$45                     ; E85A: 86 45    ; Load 'E'
                BSR     ZE866                    ; E85C: 8D 08    ; 
                LDAA    FDSTAT                   ; E85E: 96 08    ; 
                BSR     ZE866                    ; E860: 8D 04    ; 
                LDAA    #$20                     ; E862: 86 20    ; 
                BSR     ZE866                    ; E864: 8D 00    ; 
ZE866           JMP     XOUTCH                   ; E866: 7E F0 18 ; Print Accu A to Console
;------------------------------------------------
READSC          LDAB    #$80                     ; E869: C6 80    ; 
                STAB    LSCTLN                   ; E86B: D7 05    ; 
READPS          CLRB                             ; E86D: 5F       ; 
                CPX     #MC640                   ; E86E: 8C C6 40 ; These CPX are just a method to deactivate the code after the LDAB
                CPX     #MC6C2                   ; E871: 8C C6 C2 ; These CPX are just a method to deactivate the code after the LDAB
                CPX     #MC608                   ; E874: 8C C6 08 ; These CPX are just a method to deactivate the code after the LDAB
                CPX     #MC610                   ; E877: 8C C6 10 ; These CPX are just a method to deactivate the code after the LDAB
                CPX     #MC682                   ; E87A: 8C C6 82 ; These CPX are just a method to deactivate the code after the LDAB
                CPX     #MC681                   ; E87D: 8C C6 81 ; These CPX are just a method to deactivate the code after the LDAB
                CPX     #MC6C0                   ; E880: 8C C6 C0 ; These CPX are just a method to deactivate the code after the LDAB
                CPX     #MC680                   ; E883: 8C C6 80 ; These CPX are just a method to deactivate the code after the LDAB
                TPA                              ; E886: 07       ; Transfer Status Reg to A

; READSC          LDAB    #$80                     ; E869: C6 80    ; Bit 7 set     ; causes the number of sectors contained in NUMSCT beginning with STRSCT from CURDRV to be read into memory starting at the address contained in CURADR
; READPS          CLRB                             ; E86D: 5F       ; NO Bit set    ; similar to READSC with the exception that the last sector is only partially read according to the contents of LSCTLN
; RDCRC           LDAB    #$40                     ; E86F: C6 40    ; Bit 6 set     ; This entry point causes the number of sectors contained in NUMSCT beginning with STRSCT from CURDRV to be read to check their CRCs
; RWTEST          LDAB    #$C2                     ; E872: C6 C2    ; Bit 7,6,1 set ; 
; RESTOR          LDAB    #$08                     ; E875: C6 08    ; Bit 3 set     ; causes the read/write head on CURDRV to be positioned to cylinder zero. The only parameter required is CURDRV.
; SEEK            LDAB    #$10                     ; E878: C6 10    ; Bit 4 set     ; causes the read/write head of CURDRV to be positioned to the cylinder containing STRSCT
; WRTEST          LDAB    #$82                     ; E87B: C6 82    ; Bit 7,1 set   ; 
; WRDDAM          LDAB    #$81                     ; E87E: C6 81    ; Bit 7,0 set   ; 
; WRVERF          LDAB    #$C0                     ; E881: C6 C0    ; Bit 7,6 set   ; 
; WRITSC          LDAB    #$80                     ; E884: C6 80    ; Bit 7 set     ; 

                SEI                              ; E887: 0F       ; 
                STAA    STATSAV                  ; E888: 97 0D    ; Save Status Reg.
                STAB    FUNCSAV                  ; E88A: D7 0E    ; Save Function
                LDAA    #$30                     ; E88C: 86 30    ; 
                STAA    FDSTAT                   ; E88E: 97 08    ; Clear Errors ('0')
                STS     M0016                    ; E890: 9F 16    ; Set Stackpointer
                LDX     NMI$VC                   ; E892: FE FF FC ; |
                STX     NMIVECSAV                ; E895: DF 0F    ; Save old NMIISR
                LDX     #NMIISR                  ; E897: CE E9 30 ; |
                STX     NMI$VC                   ; E89A: FF FF FC ; New NMIISR
                LDX     #M0011                   ; E89D: CE 00 11 ; 
                LDAA    PIAREGA                  ; E8A0: B6 EC 00 ; |
                ORAA    #$03                     ; E8A3: 8A 03    ; Get PA0,1 (DS0,1) (Low active)
                DECA                             ; E8A5: 4A       ; Set DS0 low
                TST     CURDRV                   ; E8A6: 7D 00 00 ; should be zero
                BEQ     ZE8AD                    ; E8A9: 27 02    ; 
                INX                              ; E8AB: 08       ; 
                DECA                             ; E8AC: 4A       ; 
ZE8AD           STAA    PIAREGA                  ; E8AD: B7 EC 00 ; Write DS0 low to Register
                LDAA    ,X                       ; E8B0: A6 00    ; X @ $11 for Drive 0 or $12 for Drive 1
                STAA    TRACKSAV                 ; E8B2: 97 13    ; 
                LDAA    #$40                     ; E8B4: 86 40    ; PA6 (RDY)
                BITA    PIAREGA                  ; E8B6: B5 EC 00 ; Check Drive Ready
                BEQ     DRVRDY                   ; E8B9: 27 07    ; 
                LDAB    #$33                     ; E8BB: C6 33    ; Error '3' (DISK NOT READY)
                CPX     #$C636                   ; E8BD: 8C C6 36 ; ZE8BE: C6 36 LDAB #$36 Set Error '6' (INVALID DISK ADDRESS)
                BRA     SETERR                   ; E8C0: 20 75    ; 
;------------------------------------------------
DRVRDY          BITB    #$08                     ; E8C2: C5 08    ; Get Bit3 from FUNCSAV (RESTOR)
                BEQ     RESTORN                  ; E8C4: 27 05    ; 
                CLRA                             ; E8C6: 4F       ; 
                LDAB    #$56                     ; E8C7: C6 56    ; <------------------------------------ What is this??????
                BRA     RESTORY                  ; E8C9: 20 38    ; 
;------------------------------------------------
RESTORN         LDAB    STRSCTL                  ; E8CB: D6 02    ; RESTOR is NOT active
                LDAA    STRSCTH                  ; E8CD: 96 01    ; Get Startsector
                ADDB    NUMSCTL                  ; E8CF: DB 04    ; |
                ADCA    NUMSCTH                  ; E8D1: 99 03    ; Add Number of sectors
                BCS     ZE8BE                    ; E8D3: 25 E9    ; Set Error '6': INVALID DISK ADDRESS
                CMPB    #$D3                     ; E8D5: C1 D3    ; |
                SBCA    #$07                     ; E8D7: 82 07    ; 0x7D3 = 2003 (sector too big)
                BCC     ZE8BE                    ; E8D9: 24 E3    ; Set Error '6': INVALID DISK ADDRESS
                LDAA    #$FF                     ; E8DB: 86 FF    ; 
                STAA    SECTOR                   ; E8DD: 97 0A    ; 
                LDAA    STRSCTH                  ; E8DF: 96 01    ; Startsector is usually at $17 at boot
                LDAB    STRSCTL                  ; E8E1: D6 02    ; |
ZE8E3           INC     SECTOR                   ; E8E3: 7C 00 0A ; is now at 0
                SUBB    #$D0                     ; E8E6: C0 D0    ; 0xd0 = 208 (8 tracks exactly)
                SBCA    #$00                     ; E8E8: 82 00    ; 
                BCC     ZE8E3                    ; E8EA: 24 F7    ; 
                ADDB    #$D0                     ; E8EC: CB D0    ; 
                LDAA    SECTOR                   ; E8EE: 96 0A    ; is 0
                ASLA                             ; E8F0: 48       ; 
                ASLA                             ; E8F1: 48       ; 
                ASLA                             ; E8F2: 48       ; 
                DECA                             ; E8F3: 4A       ; 
ZE8F4           INCA                             ; E8F4: 4C       ; 
                SUBB    #$1A                     ; E8F5: C0 1A    ; $1a = 26
                BCC     ZE8F4                    ; E8F7: 24 FB    ; 
                ADDB    #$1A                     ; E8F9: CB 1A    ; $1a = 26
                STAB    SECTOR                   ; E8FB: D7 0A    ; 
                LDX     NUMSCTH                  ; E8FD: DE 03    ; 
                STX     SECTCNT                  ; E8FF: DF 0B    ; 
                LDAB    TRACKSAV                 ; E901: D6 13    ; 
RESTORY         STAA    TRACKSAV                 ; E903: 97 13    ; contains track (0 if RESTOR)
                SBA                              ; E905: 10       ; B cont. $56 (86) if RESTOR
                STAA    M0019                    ; E906: 97 19    ; 
                BCC     ZE90B                    ; E908: 24 01    ; 
                NEGA                             ; E90A: 40       ; 
ZE90B           LDAB    PIAREGA                  ; E90B: F6 EC 00 ; 
                ANDB    #$EF                     ; E90E: C4 EF    ; Isolate PA4 (HLD)
                CMPA    #$04                     ; E910: 81 04    ; Compare A with Bit 3
                BLS     ZE916                    ; E912: 23 02    ; No
                ORAB    #$10                     ; E914: CA 10    ; Set Bit 4
ZE916           STAB    PIAREGA                  ; E916: F7 EC 00 ; PA4 (HLD)
                DECA                             ; E919: 4A       ; 
                BMI     ZE964                    ; E91A: 2B 48    ; 
                BSR     STEP                     ; E91C: 8D 1F    ; Step
                TST     PIAREGA                  ; E91E: 7D EC 00 ; 
                BPL     ZE90B                    ; E921: 2A E8    ; Bit 7 set? (TRK0)
                TSTA                             ; E923: 4D       ; 
                BEQ     ZE964                    ; E924: 27 3E    ; 
                LDAA    FUNCSAV                  ; E926: 96 0E    ; 
                BITA    #$08                     ; E928: 85 08    ; 
                BEQ     ZE935                    ; E92A: 27 09    ; Function = RESTOR, Set Error
                BSR     WAIT2                    ; E92C: 8D 31    ; Wait
                BRA     ERRHNDLR                 ; E92E: 20 5A    ; 
;------------------------------------------------
NMIISR          LDS     M0016                    ; E930: 9E 16    ; 
                LDAB    #$35                     ; E932: C6 35    ; Set Error '5' (TIMEOUT)
                CPX     #$C637                   ; E934: 8C C6 37 ; ZE935: C6 37 = LDAB #$37 Set Error '7' (SEEK ERROR)
SETERR          STAB    FDSTAT                   ; E937: D7 08    ; 
                BSR     ERRHNDLR                 ; E939: 8D 4F    ; 
                SEC                              ; E93B: 0D       ; 
                RTS                              ; E93C: 39       ; 
;------------------------------------------------
STEP            TST     M0019                    ; E93D: 7D 00 19 ; 
                BPL     ZE94E                    ; E940: 2A 0C    ; 
                LDAB    #$34                     ; E942: C6 34    ; Bit 5,4,2 set
                STAB    PIACTRL                  ; E944: F7 EC 02 ; CA2 low (STEP)
                LDAB    #$3C                     ; E947: C6 3C    ; Bit 5,4,3,2 set
                STAB    PIACTRL                  ; E949: F7 EC 02 ; CA2 high (STEP)
                BRA     WAIT3                    ; E94C: 20 0A    ; 
;------------------------------------------------
ZE94E           ANDB    #$F7                     ; E94E: C4 F7    ; Clr Bit3 (DIRQ)
                STAB    PIAREGA                  ; E950: F7 EC 00 ; 
                ORAB    #$08                     ; E953: CA 08    ; Set Bit3 (DIRQ)
                STAB    PIAREGA                  ; E955: F7 EC 00 ; 
WAIT3           LDX     #$04E2                   ; E958: CE 04 E2 ; Waitloop
WAIT1           DEX                              ; E95B: 09       ; |
                BNE     WAIT1                    ; E95C: 26 FD    ; |
                RTS                              ; E95E: 39       ; 
;------------------------------------------------
WAIT2           LDX     #$09C4                   ; E95F: CE 09 C4 ; Waitloop
                BRA     WAIT1                    ; E962: 20 F7    ; |
;------------------------------------------------
ZE964           BSR     WAIT2                    ; E964: 8D F9    ; Wait
                BSR     WAIT2                    ; E966: 8D F7    ; Wait
                LDAA    FUNCSAV                  ; E968: 96 0E    ; 
                BITA    #$08                     ; E96A: 85 08    ; Is Function = RESTOR ?
                BNE     ZE935                    ; E96C: 26 C7    ; If yes Set Error '7' (SEEK ERROR)
                BITA    #$10                     ; E96E: 85 10    ; Is FUNCTION SEEK?
                BNE     ERRHNDLR                 ; E970: 26 18    ; 
                LDAB    #$6F                     ; E972: C6 6F    ; 
                RORA                             ; E974: 46       ; 
                BCC     ZE979                    ; E975: 24 02    ; 
                LDAB    #$6A                     ; E977: C6 6A    ; 
ZE979           STAB    M0014                    ; E979: D7 14    ; 
                BRA     ZE9D1                    ; E97B: 20 54    ; next sector
;------------------------------------------------
ZE97D           LDAA    FUNCSAV                  ; E97D: 96 0E    ; 
                BPL     ERRHNDLR                 ; E97F: 2A 09    ; 
                ANDA    #$40                     ; E981: 84 40    ; 
                STAA    FUNCSAV                  ; E983: 97 0E    ; 
                BEQ     ERRHNDLR                 ; E985: 27 03    ; 
                JMP     RESTORN                  ; E987: 7E E8 CB ; 
;------------------------------------------------
ERRHNDLR        LDAA    #$03                     ; E98A: 86 03    ; Set Bit 0,1
                STAA    PIAREGB                  ; E98C: B7 EC 01 ; Set PB0,1 (RESET and WG)
                JSR     ZE849                    ; E98F: BD E8 49 ; Init PIA (only CA2, CB2) and X @ EC00
                LDX     NMIVECSAV                ; E992: DE 0F    ; |
                STX     NMI$VC                   ; E994: FF FF FC ; Restore old NMIISR
                LDAA    TRACKSAV                 ; E997: 96 13    ; 
                LDAB    CURDRV                   ; E999: D6 00    ; 
                BEQ     ZE9A0                    ; E99B: 27 03    ; 
                STAA    M0012                    ; E99D: 97 12    ; 
                CPX     #$9711                   ; E99F: 8C 97 11 ; ZE9A0: 97 11 = STAA #$11 
                LDAA    STATSAV                  ; E9A2: 96 0D    ; 
                TAP                              ; E9A4: 06       ; Transfer A to Status Register
                CLC                              ; E9A5: 0C       ; 
                RTS                              ; E9A6: 39       ; 
;------------------------------------------------
READINIT        LDX     #$D0D8                   ; E9A7: CE D0 D8 ; Select CR2 and Inhibit SM, 2-Byte RDA, 8-Bit Word
                STX     SSDA_0                   ; E9AA: FF EC 04 ; |
                LDX     #PIAREGA                 ; E9AD: CE EC 00 ; 
                LDAA    #$50                     ; E9B0: 86 50    ; 
                STAA    $04,X                    ; E9B2: A7 04    ; Write $50 to SSDA_0
                LDAA    #$07                     ; E9B4: 86 07    ; 
                STAA    $01,X                    ; E9B6: A7 01    ; Write 7 to PIAREGB (Set to Read, Reset active., WG inact.)
                DEC     $01,X                    ; E9B8: 6A 01    ; Reset inact.
                INX                              ; E9BA: 08       ; 
                DEX                              ; E9BB: 09       ; 
                LDAA    #$40                     ; E9BC: 86 40    ; Write $40 to SSDA_0 (Enable Sync, Select CR2)
                STAA    $04,X                    ; E9BE: A7 04    ; 
                LDAA    #$98                     ; E9C0: 86 98    ; Write $98 to SSDA_1 (Enable SM Output)
                STAA    $05,X                    ; E9C2: A7 05    ; 
                RTS                              ; E9C4: 39       ; 
;------------------------------------------------
ZE9C5           INC     TRACKSAV                 ; E9C5: 7C 00 13 ; 
                LDAB    PIAREGA                  ; E9C8: F6 EC 00 ; 
                BSR     ZE94E                    ; E9CB: 8D 81    ; Set DIRQ
                STAA    SECTOR                   ; E9CD: 97 0A    ; 
                BSR     WAIT2                    ; E9CF: 8D 8E    ; 
ZE9D1           INC     SECTOR                   ; E9D1: 7C 00 0A ; 
                LDAA    SECTOR                   ; E9D4: 96 0A    ; 
                LDX     SECTCNT                  ; E9D6: DE 0B    ; 
                BEQ     ZE97D                    ; E9D8: 27 A3    ; 
                SUBA    #$1B                     ; E9DA: 80 1B    ; Sector == 27?
                BCC     ZE9C5                    ; E9DC: 24 E7    ; increase Track
                LDAA    #$05                     ; E9DE: 86 05    ; 
                STAA    M0018                    ; E9E0: 97 18    ; 
                DEX                              ; E9E2: 09       ; 
ZE9E3           LDAA    #$40                     ; E9E3: 86 40    ; One Sector is $40 words
                STX     SECTCNT                  ; E9E5: DF 0B    ; 
                BNE     ZE9F0                    ; E9E7: 26 07    ; 
                LDAA    LSCTLN                   ; E9E9: 96 05    ; LAST SECTOR LENGTH (1-128)
                ADDA    #$07                     ; E9EB: 8B 07    ; 
                LSRA                             ; E9ED: 44       ; convert to words
                ANDA    #$FC                     ; E9EE: 84 FC    ; 
ZE9F0           STAA    WRDCNT                   ; E9F0: 97 15    ; is $40 for every full sector
                NEGA                             ; E9F2: 40       ; 
                LDAB    FUNCSAV                  ; E9F3: D6 0E    ; 
                ASLB                             ; E9F5: 58       ; 
                BPL     ZE9F9                    ; E9F6: 2A 01    ; if reading jump
                CLRA                             ; E9F8: 4F       ; 
ZE9F9           ADDA    #$40                     ; E9F9: 8B 40    ; 
                STAA    M0009                    ; E9FB: 97 09    ; 
                LDX     #PIAREGA                 ; E9FD: CE EC 00 ; 
                LDAA    #$36                     ; EA00: 86 36    ; |
                STAA    $03,X                    ; EA02: A7 03    ; $36 -> PIACTRLB (CB2 Low - Trigger NMI Timer, IRQB Flag set by HL on CB1 - IDX, Select Output Reg. B)
                LDAA    #$3E                     ; EA04: 86 3E    ; |
                STAA    $03,X                    ; EA06: A7 03    ; $3E -> PIACTRLB (CB2 high)
                LDAB    ,X                       ; EA08: E6 00    ; Get Port A
                DECA                             ; EA0A: 4A       ; 
                STAA    $02,X                    ; EA0B: A7 02    ; $3D -> PIACTRLA (En. IRQA interrupt by CA1 - NMI Timer, Sel. Output Reg. A, CA2 high - STEP)
                LDAA    TRACKSAV                 ; EA0D: 96 13    ; 
                ORAB    #$04                     ; EA0F: CA 04    ; isolate PA2 (TG43)
                CMPA    #$2A                     ; EA11: 81 2A    ; check for Track > 42
                BLS     ZEA17                    ; EA13: 23 02    ; No
                ANDB    #$FB                     ; EA15: C4 FB    ; Clear Bit 2 (TG43)
ZEA17           STAB    ,X                       ; EA17: E7 00    ; Set Port
                LDX     #$D270                   ; EA19: CE D2 70 ; Inhibit: Sync,Tx,Rx,Select CR3 and 1 Sync Character,Internal Sync,Clear: TUF,CTS
                STX     SSDA_0                   ; EA1C: FF EC 04 ; 
                LDX     #$D1F5                   ; EA1F: CE D1 F5 ; Select Sync Code Register and Set Sync Code to hex F5
                STX     SSDA_0                   ; EA22: FF EC 04 ; 
;*************************************************
; Looking for ID Addr. Mark, correct Track and Sector
;*************************************************
ZEA25           BSR     READINIT                 ; EA25: 8D 80    ; X is on PIAREGA (EC00), Toggle RESET
ZEA27           LDAA    $04,X                    ; EA27: A6 04    ; Read SSDA Status Reg.
                BPL     ZEA27                    ; EA29: 2A FC    ; Wait for Data
                LDAA    $05,X                    ; EA2B: A6 05    ; Read SSDA Data Reg
                CMPA    #$7E                     ; EA2D: 81 7E    ; ID address mark ?
                BNE     ZEA25                    ; EA2F: 26 F4    ; No ?, Try again.
ZEA31           LDAA    $04,X                    ; EA31: A6 04    ; *********** Found Id Addr. Mark ***********
                BPL     ZEA31                    ; EA33: 2A FC    ; Wait for Data
                LDAA    $05,X                    ; EA35: A6 05    ; Read SSDA Data Reg into A
                LDAB    $05,X                    ; EA37: E6 05    ; Read SSDA Data Reg into B
                CMPA    TRACKSAV                 ; EA39: 91 13    ; Compare with Track
                BNE     ZEA25                    ; EA3B: 26 E8    ; Try again
ZEA3D           LDAA    $04,X                    ; EA3D: A6 04    ; We are on the right Track, Read SSDA Status Reg.
                BPL     ZEA3D                    ; EA3F: 2A FC    ; Wait for Data
                LDAA    $05,X                    ; EA41: A6 05    ; Read SSDA Data Reg into A
                LDAB    $05,X                    ; EA43: E6 05    ; Read SSDA Data Reg into B
                CMPA    SECTOR                   ; EA45: 91 0A    ; Compare with sector
                BNE     ZEA25                    ; EA47: 26 DC    ; Try again
ZEA49           LDAA    $04,X                    ; EA49: A6 04    ; Found Sector, Read SSDA Status Reg.
                BPL     ZEA49                    ; EA4B: 2A FC    ; Wait for Data
                LDAA    $05,X                    ; EA4D: A6 05    ; Read SSDA Data Reg into A
                LDAA    $05,X                    ; EA4F: A6 05    ; Read SSDA Data Reg into A
                INCA                             ; EA51: 4C       ; 
                INX                              ; EA52: 08       ; Set X to EC01
                LDAA    ,X                       ; EA53: A6 00    ; Read PIAREGB
                BMI     ZEA81                    ; EA55: 2B 2A    ; PB7 High ? (CRC-0) - ERROR
                LDAB    FUNCSAV                  ; EA57: D6 0E    ; 
                BMI     WRITINIT                 ; EA59: 2B 73    ; Bit 7 set - Write Function
                LDX     #$0029                   ; EA5B: CE 00 29 ; Waitloop
ZEA5E           DEX                              ; EA5E: 09       ; |
                BNE     ZEA5E                    ; EA5F: 26 FD    ; |
;*************************************************
; Found corr. Track and Sector, now look for Data Addr. Mark
;*************************************************
                LDAB    #$04                     ; EA61: C6 04    ; Try four times
ZEA63           JSR     READINIT                 ; EA63: BD E9 A7 ; Initialize SSDA for Read, Toggle RESET
                LDX     CURADRH                  ; EA66: DE 06    ; 
ZEA68           LDAA    SSDA_0                   ; EA68: B6 EC 04 ; Read SSDA Status Reg.
                BPL     ZEA68                    ; EA6B: 2A FB    ; Wait and Test RDA for 2 Bytes Ready
                LDAA    SSDA_1                   ; EA6D: B6 EC 05 ; Read Data
                CMPA    #$6F                     ; EA70: 81 6F    ; Sync data address mark
                BEQ     READSECT                 ; EA72: 27 21    ; ********** Found data address mark *************
                CMPA    #$6A                     ; EA74: 81 6A    ; Read DELETED DATA MARK (set Error '4')
                BEQ     ZEA90                    ; EA76: 27 18    ; |
                DECB                             ; EA78: 5A       ; 
                BNE     ZEA63                    ; EA79: 26 E8    ; 
                LDAB    #$38                     ; EA7B: C6 38    ; 
                CPX     #$C631                   ; EA7D: 8C C6 31 ; ZEA7E: C6 31 = LDAB #$31 (Set Error '1') (DATA CRC ERROR)
                CPX     #$C639                   ; EA80: 8C C6 39 ; ZEA81: C6 39 = LDAB #$39 (Set Error '9') (ADDRESS MARK CRC ERROR)
                DEC     M0018                    ; EA83: 7A 00 18 ; 
                BEQ     ZEA92                    ; EA86: 27 0A    ; 
                LDX     SECTCNT                  ; EA88: DE 0B    ; 
                JMP     ZE9E3                    ; EA8A: 7E E9 E3 ; 
;------------------------------------------------
DSKWPROT        LDAB    #$32                     ; EA8D: C6 32    ; Set Error '2' (DISK WRITE PROTECTED)
                CPX     #$C634                   ; EA8F: 8C C6 34 ; ZEA90: C6 34 = LDAB #$34 (Set Error '4') (READ DELETED DATA MARK)
ZEA92           JMP     SETERR                   ; EA92: 7E E9 37 ; 
;------------------------------------------------
READSECT        LDAB    FUNCSAV                  ; EA95: D6 0E    ; data address mark found
                ASLB                             ; EA97: 58       ; 
                BMI     READCRC                  ; EA98: 2B 16    ; Check for READCRC ($40)
                LDAB    WRDCNT                   ; EA9A: D6 15    ; Wordcount?
ZEA9C           LDAA    SSDA_0                   ; EA9C: B6 EC 04 ; Read SSDA Status Reg.
                BPL     ZEA9C                    ; EA9F: 2A FB    ; Wait and Test RDA for 2 Bytes Ready
                LDAA    SSDA_1                   ; EAA1: B6 EC 05 ; Read Data to Buffer
                STAA    ,X                       ; EAA4: A7 00    ; |
                LDAA    SSDA_1                   ; EAA6: B6 EC 05 ; |
                STAA    $01,X                    ; EAA9: A7 01    ; |
                INX                              ; EAAB: 08       ; |
                INX                              ; EAAC: 08       ; |
                DECB                             ; EAAD: 5A       ; |
                BNE     ZEA9C                    ; EAAE: 26 EC    ; |
READCRC         LDAA    SSDA_0                   ; EAB0: B6 EC 04 ; Read SSDA Status Reg.
                BPL     READCRC                  ; EAB3: 2A FB    ; Wait and Test RDA for 2 Bytes Ready
                LDAA    SSDA_1                   ; EAB5: B6 EC 05 ; Read SSDA Data to A
                LDAA    SSDA_1                   ; EAB8: B6 EC 05 ; Read SSDA Data to A
                LDAB    M0009                    ; EABB: D6 09    ; Counter
                BEQ     ZEAC4                    ; EABD: 27 05    ; finished ?
                DEC     M0009                    ; EABF: 7A 00 09 ; dec. counter
                BRA     READCRC                  ; EAC2: 20 EC    ; continue
;------------------------------------------------
ZEAC4           LDAA    PIAREGB                  ; EAC4: B6 EC 01 ; |
                BMI     ZEA7E                    ; EAC7: 2B B5    ; PB7 High ? (CRC-0) Error
                STX     CURADRH                  ; EAC9: DF 06    ; CRC ok
                JMP     ZE9D1                    ; EACB: 7E E9 D1 ; next sector
;------------------------------------------------
WRITINIT        LDAA    #$04                     ; EACE: 86 04    ; 
ZEAD0           TST     SSDA_0                   ; EAD0: 7D EC 04 ; Wait and Check RIE Flag ?
                BPL     ZEAD0                    ; EAD3: 2A FB    ; |
                CMPA    SSDA_1                   ; EAD5: B1 EC 05 ; |
                CMPA    SSDA_1                   ; EAD8: B1 EC 05 ; |
                DECA                             ; EADB: 4A       ; |
                BNE     ZEAD0                    ; EADC: 26 F2    ; |
                LDX     #$C0DA                   ; EADE: CE C0 DA ; 
                STX     SSDA_0                   ; EAE1: FF EC 04 ; 
                LDX     #$C1AA                   ; EAE4: CE C1 AA ; 
                STX     SSDA_0                   ; EAE7: FF EC 04 ; 
                LDX     #$C270                   ; EAEA: CE C2 70 ; 
                STX     SSDA_0                   ; EAED: FF EC 04 ; 
                INC     PIAREGB                  ; EAF0: 7C EC 01 ; ??????????
                LDAA    #$82                     ; EAF3: 86 82    ; Bit 1,7
                STAA    PIAREGB                  ; EAF5: B7 EC 01 ; WG off, PB7 is an Input 
                STAA    SSDA_0                   ; EAF8: B7 EC 04 ; 
                LDAA    #$10                     ; EAFB: 86 10    ; Bit 4
                BITA    PIAREGB                  ; EAFD: B5 EC 01 ; Check Writeprot?
                BNE     DSKWPROT                 ; EB00: 26 8B    ; If yes set Error
                RORB                             ; EB02: 56       ; 
                BCC     ZEB06                    ; EB03: 24 01    ; 
                BITA    #$56                     ; EB05: 85 56    ; 
                NOP                              ; EB07: 01       ; 
                LDAA    #$00                     ; EB08: 86 00    ; 
                LDAB    #$06                     ; EB0A: C6 06    ; Bit 1,2
                STAA    PIAREGB                  ; EB0C: B7 EC 01 ; Clear all PB (Set to Write, Reset off, ShiftCRC off, WG on)
                LDAA    #$08                     ; EB0F: 86 08    ; 
                LDX     #$8210                   ; EB11: CE 82 10 ; 
                STX     SSDA_0                   ; EB14: FF EC 04 ; 
ZEB17           BITA    SSDA_0                   ; EB17: B5 EC 04 ; 
                BEQ     ZEB17                    ; EB1A: 27 FB    ; 
                STX     SSDA_0                   ; EB1C: FF EC 04 ; 
                DECB                             ; EB1F: 5A       ; 
                BNE     ZEB17                    ; EB20: 26 F5    ; 
                LDAB    #$40                     ; EB22: C6 40    ; 
                LDAA    M0014                    ; EB24: 96 14    ; 
                LDX     #$83F5                   ; EB26: CE 83 F5 ; 
                STX     SSDA_0                   ; EB29: FF EC 04 ; 
                LDX     CURADRH                  ; EB2C: DE 06    ; 
                STAA    SSDA_1                   ; EB2E: B7 EC 05 ; 
                JMP     ZEB3B                    ; EB31: 7E EB 3B ; 
;------------------------------------------------
ZEB34           LDAA    #$40                     ; EB34: 86 40    ; 
ZEB36           BITA    SSDA_0                   ; EB36: B5 EC 04 ; 
                BEQ     ZEB36                    ; EB39: 27 FB    ; 
ZEB3B           LDAA    ,X                       ; EB3B: A6 00    ; 
                STAA    SSDA_1                   ; EB3D: B7 EC 05 ; 
                LDAA    $01,X                    ; EB40: A6 01    ; 
                STAA    SSDA_1                   ; EB42: B7 EC 05 ; 
                BCS     ZEB49                    ; EB45: 25 02    ; 
                INX                              ; EB47: 08       ; 
                INX                              ; EB48: 08       ; 
ZEB49           DECB                             ; EB49: 5A       ; 
                BNE     ZEB34                    ; EB4A: 26 E8    ; 
                STX     CURADRH                  ; EB4C: DF 06    ; 
                LDAA    #$40                     ; EB4E: 86 40    ; 
ZEB50           BITA    SSDA_0                   ; EB50: B5 EC 04 ; 
                BEQ     ZEB50                    ; EB53: 27 FB    ; 
                STAB    SSDA_1                   ; EB55: F7 EC 05 ; 
ZEB58           BITA    SSDA_0                   ; EB58: B5 EC 04 ; 
                BEQ     ZEB58                    ; EB5B: 27 FB    ; 
                LDAB    #$08                     ; EB5D: C6 08    ; Bit 3
                STAB    PIAREGB                  ; EB5F: F7 EC 01 ; 
                STAB    SSDA_1                   ; EB62: F7 EC 05 ; 
ZEB65           BITA    SSDA_0                   ; EB65: B5 EC 04 ; 
                BEQ     ZEB65                    ; EB68: 27 FB    ; 
                LDAB    #$FF                     ; EB6A: C6 FF    ; 
                STAB    SSDA_1                   ; EB6C: F7 EC 05 ; 
                STAB    SSDA_1                   ; EB6F: F7 EC 05 ; 
ZEB72           BITA    SSDA_0                   ; EB72: B5 EC 04 ; 
                BEQ     ZEB72                    ; EB75: 27 FB    ; 
                CLR     PIAREGB                  ; EB77: 7F EC 01 ; 
                INC     PIAREGB                  ; EB7A: 7C EC 01 ; 
                INC     PIAREGB                  ; EB7D: 7C EC 01 ; 
                LDX     #$003C                   ; EB80: CE 00 3C ; Waitloop
ZEB83           DEX                              ; EB83: 09       ; |
                BNE     ZEB83                    ; EB84: 26 FD    ; |
                JMP     ZE9D1                    ; EB86: 7E E9 D1 ; next sector
;------------------------------------------------
; Disk Mini Diagnostic Routine
;------------------------------------------------

                ORG     $EB90

CLRTOP          LDX     #M0014                   ; EB90: CE 00 14 ; Diagnostic with clear
ZEB93           CLR     $5F,X                    ; EB93: 6F 5F    ; Clear $60-$73
                DEX                              ; EB95: 09       ; |
                BNE     ZEB93                    ; EB96: 26 FB    ; |
TOP             JSR     FDINIT                   ; EB98: BD E8 22 ; Diagnostic without clear
                JSR     RESTOR                   ; EB9B: BD E8 75 ; 
ZEB9E           LDX     LDADDR                   ; EB9E: DE 20    ; 
                STX     CURADRH                  ; EBA0: DF 06    ; 
                LDX     EXADDR                   ; EBA2: DE 22    ; must contain addres of function (READSC,...)
                JSR     ,X                       ; EBA4: AD 00    ; 
                LDAA    ONECON                   ; EBA6: 96 24    ; 
                BNE     ZEBB9                    ; EBA8: 26 0F    ; 
                STAA    CURADRL                  ; EBAA: 97 07    ; 
                ASL     FDSTAT                   ; EBAC: 78 00 08 ; 
                LDX     CURADRL                  ; EBAF: DE 07    ; 
                INC     $01,X                    ; EBB1: 6C 01    ; 
                BNE     ZEB9E                    ; EBB3: 26 E9    ; 
                INC     ,X                       ; EBB5: 6C 00    ; 
                BNE     ZEB9E                    ; EBB7: 26 E5    ; 
ZEBB9           JMP     ZE855                    ; EBB9: 7E E8 55 ; Print Error Code
;------------------------------------------------
                FCB     $FF,$FF,$FF,$FF          ; EBBC: FF FF FF FF
LPINIT          LDX     #MFF2E                   ; EBC0: CE FF 2E ; Line Printer Init
                STX     MEC10                    ; EBC3: FF EC 10 ; <------------------------------------ no RAM here!
                LDAA    #$3C                     ; EBC6: 86 3C    ; 
                STAA    MEC13                    ; EBC8: B7 EC 13 ; <------------------------------------ no RAM here!
                RTS                              ; EBCB: 39       ; 
;------------------------------------------------
LIST            STAA    MEC10                    ; EBCC: B7 EC 10 ; Print contents of A
                LDAA    MEC10                    ; EBCF: B6 EC 10 ; <------------------------------------ no RAM here!
ZEBD2           PSHB                             ; EBD2: 37       ; 
                LDAB    MEC12                    ; EBD3: F6 EC 12 ; <------------------------------------ no RAM here!
                ANDB    #$03                     ; EBD6: C4 03    ; 
                DECB                             ; EBD8: 5A       ; 
                PULB                             ; EBD9: 33       ; 
                BNE     ZEBE2                    ; EBDA: 26 06    ; 
                TST     MEC11                    ; EBDC: 7D EC 11 ; <------------------------------------ no RAM here!
                BPL     ZEBD2                    ; EBDF: 2A F1    ; 
                RTS                              ; EBE1: 39       ; 
;------------------------------------------------
ZEBE2           SEC                              ; EBE2: 0D       ; 
                RTS                              ; EBE3: 39       ; 
;------------------------------------------------
LDATA0          LDAA    #$0D                     ; EBE4: 86 0D    ; Send String to Printer
ZEBE6           BSR     LIST                     ; EBE6: 8D E4    ; 
                BCS     ZEBE6                    ; EBE8: 25 FC    ; 
                LDAA    #$0A                     ; EBEA: 86 0A    ; 
                DEX                              ; EBEC: 09       ; 
ZEBED           BSR     LIST                     ; EBED: 8D DD    ; 
                BCS     ZEBED                    ; EBEF: 25 FC    ; 
                INX                              ; EBF1: 08       ; 
LDATA1          LDAA    ,X                       ; EBF2: A6 00    ; 
                CMPA    #$04                     ; EBF4: 81 04    ; 
                BNE     ZEBED                    ; EBF6: 26 F5    ; 
                RTS                              ; EBF8: 39       ; 
;------------------------------------------------
                FCB     $FF,$FF,$FF,$FF,$FF      ; EBF9: FF FF FF FF FF '.....'
                FDB     $0750                    ; EBFE: 07 50          '.P'

                END
