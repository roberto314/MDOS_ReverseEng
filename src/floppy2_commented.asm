; Ready to assemble with asl. binary matches original
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
FDSTAT  EQU     $0008
M0009   EQU     $0009
SECTOR  EQU     $000A
SECTCNT EQU     $000B
STATSAV EQU     $000D
FUNCSAV EQU     $000E
NMIVECSAV EQU     $000F
M0012   EQU     $0012
TRACKSAV EQU    $0013
M0014   EQU     $0014
WRDCNT  EQU     $0015
M0016   EQU     $0016
M0018   EQU     $0018
M0019   EQU     $0019
LDADDR  EQU     $0020
; The PIA has A0 and A1 switched!
; 00 with CRA2 Set is Peripheral Register A 
; 00 with CRA2 cleared is Data Direction Register A 
; 01 with CRB2 Set is Peripheral Register B 
; 01 with CRB2 cleared is Data Direction Register B 
; 02 is Control Register A
; 03 is Control Register B
PIAREGA EQU     $EC00
PIAREGB EQU     $EC01
PIACTRL EQU     $EC02
SSDA_0  EQU     $EC04
SSDA_1  EQU     $EC05
MEC26   EQU     $EC26
MEC27   EQU     $EC27
PWRUP   EQU     $F000

XOUTCH  EQU     $F018
REENT2  EQU     $F564
PROM_0  EQU     $FCFC
XSTAKs  EQU     $FF8A
NMIsVC  EQU     $FFFC

;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $E800

OSLOAD          LDS     #XSTAKs                  ; E800: 8E FF 8A  ; Set Stackpointer     
                CLRA                             ; E803: 4F        ; |    
                STAA    CURDRV                   ; E804: 97 00     ; Set Drive to zero   
                BSR     FDINIT2                  ; E806: 8D 48     ; Init PIA and SSDA
                BSR     RESTOR                   ; E808: 8D 6B     ; 
                BSR     CHKERR                   ; E80A: 8D 47     ; 
                LDX     #$0017                   ; E80C: CE 00 17  ; Start at Sector $17 (Bootblock) (0xB80)
                STX     STRSCTH                  ; E80F: DF 01     ; |
                LDX     #$0002                   ; E811: CE 00 02  ; Get 2 sectors
                STX     NUMSCTH                  ; E814: DF 03     ; |
                LDX     #LDADDR                  ; E816: CE 00 20  ; Load @ 0x20
                STX     CURADRH                  ; E819: DF 06     ; |
                BSR     READSC                   ; E81B: 8D 4C     ; Read the Sector
                BSR     CHKERR                   ; E81D: 8D 34     ; Check for Erroro
                JMP     LDADDR                   ; E81F: 7E 00 20  ; Execute loaded code....
;------------------------------------------------
FDINIT          LDX     #$0000                   ; E822: CE 00 00  ; |
                STX     PIACTRL                  ; E825: FF EC 02  ; clr both control Reg.
                STX     PIAREGA                  ; E828: FF EC 00  ; Set A and B to Input
                LDX     #$D0DA                   ; E82B: CE D0 DA  ; 
                STX     SSDA_0                   ; E82E: FF EC 04  ; 
                LDX     #$0404                   ; E831: CE 04 04  ; |
                STX     PIACTRL                  ; E834: FF EC 02  ; Set A and B to Output Reg.
                LDX     #$1B02                   ; E837: CE 1B 02  ; |
                STX     PIAREGA                  ; E83A: FF EC 00  ; Set DS0, DS1, DIRQ, HLD, WG high
                LDX     #$0000                   ; E83D: CE 00 00  ; |
                STX     PIACTRL                  ; E840: FF EC 02  ; Set both to Data direction Reg.
                LDX     #$1F0F                   ; E843: CE 1F 0F  ; |
                STX     PIAREGA                  ; E846: FF EC 00  ; PA0-PA4, PB0-PB3 Output
                LDX     #$3C3E                   ; E849: CE 3C 3E  ; |
                STX     PIACTRL                  ; E84C: FF EC 02  ; Select both Output Reg., Set CA2 (STEP), Set CB2 (NMI Timer), IRQB (IRQ) Set by LH Transition of CB1 (IDX)
ZE84F           RTS                              ; E84F: 39        ; Both Output Regsters Selected
;------------------------------------------------
FDINIT2         JSR     FDINIT3                  ; E850: BD EB A6  ; 
;------------------------------------------------
CHKERR          BCC     ZE84F                    ; E853: 24 FA     ; no carry - no error
                BSR     PRNTER                   ; E855: 8D 03     ; Print for ex.: 'E2 ' for Error 0x32
                JMP     REENT2                   ; E857: 7E F5 64  ; 
;------------------------------------------------
PRNTER          LDAA    #$45                     ; E85A: 86 45      ; Load 'E'
                BSR     ZE866                    ; E85C: 8D 08      ; 
                LDAA    FDSTAT                   ; E85E: 96 08      ; 
                BSR     ZE866                    ; E860: 8D 04      ; 
                LDAA    #$20                     ; E862: 86 20      ; 
                BSR     ZE866                    ; E864: 8D 00      ; 
ZE866           JMP     XOUTCH                   ; E866: 7E F0 18   ; Print Accu A to Console
;------------------------------------------------
;READSC          LDAB    #$80                     ; E869: C6 80      ; 
;                STAB    LSCTLN                   ; E86B: D7 05      ; 
;READPS          CLRB                             ; E86D: 5F         ; 
;                CPX     #MC640                   ; E86E: 8C C6 40   ; These CPX are just a method to deactivate the code after the LDAB
;                CPX     #MC6C2                   ; E871: 8C C6 C2   ; These CPX are just a method to deactivate the code after the LDAB
;                CPX     #MC608                   ; E874: 8C C6 08   ; These CPX are just a method to deactivate the code after the LDAB
;                CPX     #MC610                   ; E877: 8C C6 10   ; These CPX are just a method to deactivate the code after the LDAB
;                CPX     #MC682                   ; E87A: 8C C6 82   ; These CPX are just a method to deactivate the code after the LDAB
;                CPX     #MC681                   ; E87D: 8C C6 81   ; These CPX are just a method to deactivate the code after the LDAB
;                CPX     #MC6C0                   ; E880: 8C C6 C0   ; These CPX are just a method to deactivate the code after the LDAB
;                CPX     #MC680                   ; E883: 8C C6 80   ; These CPX are just a method to deactivate the code after the LDAB
;                CPX     #MC604                   ; E886: 8C C6 04   ; These CPX are just a method to deactivate the code after the LDAB
;
READSC          LDAB    #$80                     ; E869: C6 80    ; Bit 7 set     ; causes the number of sectors contained in NUMSCT beginning with STRSCT from CURDRV to be read into memory starting at the address contained in CURADR
                STAB    LSCTLN                   ; E86B: D7 05      ; 
READPS          CLRB                             ; E86D: 5F       ; NO Bit set    ; similar to READSC with the exception that the last sector is only partially read according to the contents of LSCTLN
                FCB     $8C
RDCRC           LDAB    #$40                     ; E86F: C6 40    ; Bit 6 set     ; This entry point causes the number of sectors contained in NUMSCT beginning with STRSCT from CURDRV to be read to check their CRCs
                FCB     $8C
RWTEST          LDAB    #$C2                     ; E872: C6 C2    ; Bit 7,6,1 set ; 
                FCB     $8C
RESTOR          LDAB    #$08                     ; E875: C6 08    ; Bit 3 set     ; causes the read/write head on CURDRV to be positioned to cylinder zero. The only parameter required is CURDRV.
                FCB     $8C
SEEK            LDAB    #$10                     ; E878: C6 10    ; Bit 4 set     ; causes the read/write head of CURDRV to be positioned to the cylinder containing STRSCT
                FCB     $8C
WRTEST          LDAB    #$82                     ; E87B: C6 82    ; Bit 7,1 set   ; 
                FCB     $8C
WRDDAM          LDAB    #$81                     ; E87E: C6 81    ; Bit 7,0 set   ; 
                FCB     $8C
WRVERF          LDAB    #$C0                     ; E881: C6 C0    ; Bit 7,6 set   ; 
                FCB     $8C
WRITSC          LDAB    #$80                     ; E884: C6 80    ; Bit 7 set     ; 
                FCB     $8C
CLOCK           LDAB    #$04                     ; E887: C6 04    ; Bit 2 set     ; 

                TPA                              ; E889: 07         ; Transfer Status Reg to A
                SEI                              ; E88A: 0F        ; 
                STAA    STATSAV                  ; E88B: 97 0D     ; Save Status Reg.
                STAB    FUNCSAV                  ; E88D: D7 0E     ; Save Function
                LDAA    #$30                     ; E88F: 86 30     ; 
                STAA    FDSTAT                   ; E891: 97 08     ; Clear Errors ('0')
                STS     M0016                    ; E893: 9F 16     ; Set Stackpointer
                LDX     NMIsVC                   ; E895: FE FF FC  ; |
                STX     NMIVECSAV                ; E898: DF 0F     ; Save old NMIISR
                LDX     #NMIISR                  ; E89A: CE E9 39  ; |
                STX     NMIsVC                   ; E89D: FF FF FC  ; New NMIISR
                LDX     #M0012                   ; E8A0: CE 00 12  ;                                         <******************** different
                LDAA    #$01                     ; E8A3: 86 01     ; 
                CMPA    CURDRV                   ; E8A5: 91 00     ; 
                BCS     ZE8BB                    ; E8A7: 25 12     ; 
                BEQ     ZE8AD                    ; E8A9: 27 02     ; 
                DEX                              ; E8AB: 09        ; 
                INCA                             ; E8AC: 4C        ; 
ZE8AD           STAA    PIAREGA                  ; E8AD: B7 EC 00  ; Write DS0 low to Register
                LDAA    ,X                       ; E8B0: A6 00     ; X @ $11 for Drive 0 or $12 for Drive 1
                STAA    TRACKSAV                 ; E8B2: 97 13     ; 
                LDAA    #$40                     ; E8B4: 86 40     ; PA6 (RDY)
                BITA    PIAREGA                  ; E8B6: B5 EC 00  ; Check Drive Ready
                BEQ     DRVRDY                   ; E8B9: 27 07     ; 
ZE8BB           LDAB    #$33                     ; E8BB: C6 33     ; Error '3' (DISK NOT READY)
;                CPX     #MC636                   ; E8BD: 8C C6 36  ; 
                FCB     $8C
ZE8BE           LDAB    #$36                                       ; Set Error '6' (INVALID DISK ADDRESS)
                BRA     SETERR                   ; E8C0: 20 7E     ; 
;------------------------------------------------
DRVRDY          BITB    #$08                     ; E8C2: C5 08     ; Get Bit3 from FUNCSAV (RESTOR)
                BEQ     ZE8CB                    ; E8C4: 27 05     ; 
                CLRB                             ; E8C6: 5F        ; 
                LDAA    #$03                     ; E8C7: 86 03     ; <------------------------------------ What is this??????
                BRA     RESTORY                  ; E8C9: 20 3F          
;------------------------------------------------
ZE8CB           BITB    #$04                     ; E8CB: C5 04     ; Get Bit2 from FUNCSAV (CLOCK)
                BEQ     RESTORN                  ; E8CD: 27 03     ;
                JMP     CLKDMD                   ; E8CF: 7E EB 85  ;
;------------------------------------------------
RESTORN         LDAB    STRSCTL                  ; E8D2: D6 02     ; RESTOR is NOT active
                LDAA    STRSCTH                  ; E8D4: 96 01     ; Get Startsector
                ADDB    NUMSCTL                  ; E8D6: DB 04     ; |
                ADCA    NUMSCTH                  ; E8D8: 99 03     ; Add Number of sectors
                BCS     ZE8BE                    ; E8DA: 25 E2     ; Set Error '6': INVALID DISK ADDRESS
                CMPB    #$D3                     ; E8DC: C1 D3     ; |
                SBCA    #$07                     ; E8DE: 82 07     ; 0x7D3 = 2003 (sector too big)
                BCC     ZE8BE                    ; E8E0: 24 DC     ; Set Error '6': INVALID DISK ADDRESS
                LDAA    #$FF                     ; E8E2: 86 FF     ; 
                STAA    SECTOR                   ; E8E4: 97 0A     ; 
                LDAA    STRSCTH                  ; E8E6: 96 01     ; Startsector is usually at $17 at boot
                LDAB    STRSCTL                  ; E8E8: D6 02     ; |
ZE8EA           INC     SECTOR                   ; E8EA: 7C 00 0A  ; is now at 0
                SUBB    #$D0                     ; E8ED: C0 D0     ; 0xd0 = 208 (8 tracks exactly)
                SBCA    #$00                     ; E8EF: 82 00     ; 
                BCC     ZE8EA                    ; E8F1: 24 F7     ; 
                ADDB    #$D0                     ; E8F3: CB D0     ; 
                LDAA    SECTOR                   ; E8F5: 96 0A     ; is 0
                ASLA                             ; E8F7: 48        ; 
                ASLA                             ; E8F8: 48        ; 
                ASLA                             ; E8F9: 48        ; 
                DECA                             ; E8FA: 4A        ; 
ZE8FB           INCA                             ; E8FB: 4C        ; 
                SUBB    #$1A                     ; E8FC: C0 1A     ; $1a = 26
                BCC     ZE8FB                    ; E8FE: 24 FB     ; 
                ADDB    #$1A                     ; E900: CB 1A     ; $1a = 26
                STAB    SECTOR                   ; E902: D7 0A     ; 
                LDX     NUMSCTH                  ; E904: DE 03     ; 
                STX     SECTCNT                  ; E906: DF 0B     ; 
                LDAB    TRACKSAV                 ; E908: D6 13     ; 
RESTORY         STAA    TRACKSAV                 ; E90A: 97 13     ; contains track (0 if RESTOR or 3)
                SBA                              ; E90C: 10        ; B cont. $56 (86) if RESTOR
                LDAB    PIAREGA                  ; E90D: F6 EC 00  ;                                        <******************** different
                ORAB    #$08                     ; E910: CA 08     ; Isolate Bit 3 (DIRQ)
                BCC     ZE917                    ; E912: 24 03     ; 
                ANDB    #$F7                     ; E914: C4 F7     ; Isolate Bit 3 (DIRQ)
                NEGA                             ; E916: 40        ; 
ZE917           ANDB    #$EF                     ; E917: C4 EF     ; Isolate PA4 (HLD)
                CMPA    #$04                     ; E919: 81 04     ; Compare A with Bit 3   <------------ WHY
                BLS     ZE91F                    ; E91B: 23 02     ; 
                ORAB    #$10                     ; E91D: CA 10     ; Set Bit 4 (HLD)
ZE91F           STAB    PIAREGA                  ; E91F: F7 EC 00  ; Write to Port
                DECA                             ; E922: 4A        ; 
                BMI     ZE96A                    ; E923: 2B 45     ; 
                BSR     STEP                     ; E925: 8D 1F     ; 
                LDAB    PIAREGA                  ; E927: F6 EC 00  ; 
                BPL     ZE917                    ; E92A: 2A EB     ; Bit 7 set? (TRK0)
                TSTA                             ; E92C: 4D        ; 
                BEQ     ZE96A                    ; E92D: 27 3B     ; 
                LDAA    FUNCSAV                  ; E92F: 96 0E     ; 
                BITA    #$08                     ; E931: 85 08     ; 
                BEQ     ZE93E                    ; E933: 27 09     ; Function = RESTOR, Set Error
                BSR     WAIT2                    ; E935: 8D 25     ; Wait
                BRA     ERRHNDLR                 ; E937: 20 58     ; 
;------------------------------------------------
NMIISR          LDS     M0016                    ; E939: 9E 16     ; 
                LDAB    #$35                     ; E93B: C6 35     ; Set Error '5' (TIMEOUT)
;                CPX     #MC637                   ; E93D: 8C C6 37  ; 
                FCB     $8C
ZE93E           LDAB    #$37                                       ; Set Error '7' (SEEK ERROR)
SETERR          STAB    FDSTAT                   ; E940: D7 08     ; 
                BSR     ERRHNDLR                 ; E942: 8D 4D     ; 
                SEC                              ; E944: 0D        ; 
                RTS                              ; E945: 39        ; 
;------------------------------------------------
STEP            LDAB    #$34                     ; E946: C6 34     ; Bit 5,4,2 set
                STAB    PIACTRL                  ; E948: F7 EC 02  ; CA2 low (STEP)
                LDAB    #$3C                     ; E94B: C6 3C     ; Bit 5,4,3,2 set
                STAB    PIACTRL                  ; E94D: F7 EC 02  ; CA2 high (STEP)
                LDX     #$00FE                   ; E950: CE 00 FE  ;                                        <******************** different
WAIT3           LDAB    M0019                    ; E953: D6 19     ; 
WAIT1           DECB                             ; E955: 5A        ; 
                BNE     WAIT1                    ; E956: 26 FD     ; 
                DEX                              ; E958: 09        ; 
                BNE     WAIT3                    ; E959: 26 F8     ; 
                RTS                              ; E95B: 39        ; 
;------------------------------------------------
WAIT2           LDX     #$0187                   ; E95C: CE 01 87  ; 
                BRA     WAIT3                    ; E95F: 20 F2     ; 
;------------------------------------------------
ZE961           LDAA    TRACKSAV                 ; E961: 96 13     ; 
                BEQ     ZE93E                    ; E963: 27 D9     ; 
                CLRA                             ; E965: 4F        ; 
                LDAB    #$56                     ; E966: C6 56     ; <------------------------------------ What is this??????
                BRA     RESTORY                  ; E968: 20 A0     ; 
;------------------------------------------------
ZE96A           LDX     #$02C0                   ; E96A: CE 02 C0  ; |
                BSR     WAIT3                    ; E96D: 8D E4     ; Wait
                LDAA    FUNCSAV                  ; E96F: 96 0E     ; 
                BITA    #$08                     ; E971: 85 08     ; Is Function = RESTOR ?
                BNE     ZE961                    ; E973: 26 EC     ; If yes Set Error '7' (SEEK ERROR)
                BITA    #$10                     ; E975: 85 10     ; Is FUNCTION SEEK?
                BNE     ERRHNDLR                 ; E977: 26 18     ; 
                LDAB    #$6F                     ; E979: C6 6F     ; 
                RORA                             ; E97B: 46        ; 
                BCC     ZE980                    ; E97C: 24 02     ; 
                LDAB    #$6A                     ; E97E: C6 6A     ; 
ZE980           STAB    M0014                    ; E980: D7 14     ; 
                BRA     ZE9D3                    ; E982: 20 4F     ; next sector
;------------------------------------------------
ZE984           LDAA    FUNCSAV                  ; E984: 96 0E     ; 
                BPL     ERRHNDLR                 ; E986: 2A 09     ; 
                ANDA    #$40                     ; E988: 84 40     ; 
                STAA    FUNCSAV                  ; E98A: 97 0E     ; 
                BEQ     ERRHNDLR                 ; E98C: 27 03     ; 
                JMP     RESTORN                  ; E98E: 7E E8 D2  ; 
;------------------------------------------------
ERRHNDLR        LDX     #$033C                   ; E991: CE 03 3C  ; 
                STX     PIAREGB                  ; E994: FF EC 01  ; Set PB0,1 (RESET and WG) and Select A Output Reg., Set CA2 (STEP)
                LDX     NMIVECSAV                ; E997: DE 0F     ; |
                STX     NMIsVC                   ; E999: FF FF FC  ; Restore old NMIISR
                LDAA    TRACKSAV                 ; E99C: 96 13     ; 
                LDAB    CURDRV                   ; E99E: D6 00     ; 
                BEQ     ZE9A5                    ; E9A0: 27 03     ; 
                STAA    M0012                    ; E9A2: 97 12     ; 
;                CPX     #$9711                   ; E9A4: 8C 97 11  ; 
                FCB     $8C
ZE9A5           STAA    $11                                       ;
                LDAA    STATSAV                  ; E9A7: 96 0D     ; 
                TAP                              ; E9A9: 06        ; Transfer A to Status Register
                CLC                              ; E9AA: 0C        ; 
                RTS                              ; E9AB: 39        ; 
;------------------------------------------------
READINIT        LDX     #$D0D8                   ; E9AC: CE D0 D8  ; Select CR2 and Inhibit SM, 2-Byte RDA, 8-Bit Word
                STX     SSDA_0                   ; E9AF: FF EC 04  ; |
                LDX     #PIAREGA                 ; E9B2: CE EC 00  ; 
                LDAA    #$50                     ; E9B5: 86 50     ; 
                STAA    $04,X                    ; E9B7: A7 04     ; Write $50 to SSDA_0
                LDAA    #$07                     ; E9B9: 86 07     ; 
                STAA    $01,X                    ; E9BB: A7 01     ; Write 7 to PIAREGB (Set to Read, Reset active., WG inact.)
                DEC     $01,X                    ; E9BD: 6A 01     ; Reset inact.
                INX                              ; E9BF: 08        ; 
                DEX                              ; E9C0: 09        ; 
                LDAA    #$40                     ; E9C1: 86 40     ; Write $40 to SSDA_0 (Enable Sync, Select CR2)
                STAA    $04,X                    ; E9C3: A7 04     ; 
                LDAA    #$98                     ; E9C5: 86 98     ; Write $98 to SSDA_1 (Enable SM Output)
                STAA    $05,X                    ; E9C7: A7 05     ; 
                RTS                              ; E9C9: 39        ; 
;------------------------------------------------
ZE9CA           STAA    SECTOR                   ; E9CA: 97 0A     ;                                        <******************** different
                JSR     STEP                     ; E9CC: BD E9 46  ; 
                BSR     WAIT2                    ; E9CF: 8D 8B     ; 
                INC     $13,X                    ; E9D1: 6C 13     ; 
ZE9D3           INC     SECTOR                   ; E9D3: 7C 00 0A  ; 
                LDAA    SECTOR                   ; E9D6: 96 0A     ; 
                LDX     SECTCNT                  ; E9D8: DE 0B     ; 
                BEQ     ZE984                    ; E9DA: 27 A8     ; 
                SUBA    #$1B                     ; E9DC: 80 1B     ; Sector == 27?
                BCC     ZE9CA                    ; E9DE: 24 EA     ; increase Track
                LDAA    #$05                     ; E9E0: 86 05     ; 
                STAA    M0018                    ; E9E2: 97 18     ; 
                DEX                              ; E9E4: 09        ; 
ZE9E5           LDAA    #$40                     ; E9E5: 86 40     ; One Sector is $40 words
                STX     SECTCNT                  ; E9E7: DF 0B     ; 
                BNE     ZE9F2                    ; E9E9: 26 07     ; 
                LDAA    LSCTLN                   ; E9EB: 96 05     ; LAST SECTOR LENGTH (1-128)
                ADDA    #$07                     ; E9ED: 8B 07     ; 
                LSRA                             ; E9EF: 44        ; convert to words
                ANDA    #$FC                     ; E9F0: 84 FC     ; 
ZE9F2           STAA    WRDCNT                   ; E9F2: 97 15     ; is $40 for every full sector
                NEGA                             ; E9F4: 40        ; 
                LDAB    FUNCSAV                  ; E9F5: D6 0E     ; 
                ASLB                             ; E9F7: 58        ; 
                BPL     ZE9FB                    ; E9F8: 2A 01     ; if reading jump
                CLRA                             ; E9FA: 4F        ; 
ZE9FB           ADDA    #$40                     ; E9FB: 8B 40     ; 
                STAA    M0009                    ; E9FD: 97 09     ; 
                JSR     RETRG                    ; E9FF: BD EB 74  ; Retrigger NMI Timer
                LDAA    TRACKSAV                 ; EA02: 96 13     ; 
                ORAB    #$0C                     ; EA04: CA 0C     ; In B is PIA Port A, isol. Bit 2,3 (TG43, DIRQ)
                CMPA    #$2B                     ; EA06: 81 2B     ; check for Track > 43
                BLS     ZEA0C                    ; EA08: 23 02     ; No
                ANDB    #$FB                     ; EA0A: C4 FB     ; Clr Bit 2 (TG43)
ZEA0C           STAB    ,X                       ; EA0C: E7 00     ; Set Port
                LDX     #$D270                   ; EA0E: CE D2 70  ; Inhibit: Sync,Tx,Rx,Select CR3 and 1 Sync Character,Internal Sync,Clear: TUF,CTS
                STX     SSDA_0                   ; EA11: FF EC 04  ; |
                LDX     #$D1F5                   ; EA14: CE D1 F5  ; Select Sync Code Register and Set Sync Code to hex F5
                STX     SSDA_0                   ; EA17: FF EC 04  ; |
;*************************************************
; Looking for ID Addr. Mark, correct Track and Sector
;*************************************************
ZEA1A           BSR     READINIT                 ; EA1A: 8D 90     ; X is on PIAREGA (EC00), Toggle RESET
ZEA1C           LDAA    $04,X                    ; EA1C: A6 04     ; Read SSDA Status Reg.
                BPL     ZEA1C                    ; EA1E: 2A FC     ; Wait for Data
                LDAA    $05,X                    ; EA20: A6 05     ; Read SSDA Data Reg
                CMPA    #$7E                     ; EA22: 81 7E     ; ID address mark ?
                BNE     ZEA1A                    ; EA24: 26 F4     ; No ?, Try again.
ZEA26           LDAA    $04,X                    ; EA26: A6 04     ; *********** Found Id Addr. Mark ***********
                BPL     ZEA26                    ; EA28: 2A FC     ; Wait for Data
                LDAA    $05,X                    ; EA2A: A6 05     ; Read SSDA Data Reg into A
                LDAB    $05,X                    ; EA2C: E6 05     ; Read SSDA Data Reg into B
                CMPA    TRACKSAV                 ; EA2E: 91 13     ; Compare with Track
                BNE     ZEA1A                    ; EA30: 26 E8     ; Try again
ZEA32           LDAA    $04,X                    ; EA32: A6 04     ; We are on the right Track, Read SSDA Status Reg.
                BPL     ZEA32                    ; EA34: 2A FC     ; Wait for Data
                LDAA    $05,X                    ; EA36: A6 05     ; Read SSDA Data Reg into A
                LDAB    $05,X                    ; EA38: E6 05     ; Read SSDA Data Reg into B
                CMPA    SECTOR                   ; EA3A: 91 0A     ; Compare with sector
                BNE     ZEA1A                    ; EA3C: 26 DC     ; Try again
ZEA3E           LDAA    $04,X                    ; EA3E: A6 04     ; Found Sector, Read SSDA Status Reg.
                BPL     ZEA3E                    ; EA40: 2A FC     ; Wait for Data
                TST     $05,X                    ; EA42: 6D 05     ; 
                LDAA    M0019                    ; EA44: 96 19     ; 
ZEA46           SUBA    #$03                     ; EA46: 80 03     ; 
                BHI     ZEA46                    ; EA48: 22 FC     ; 
                LDAA    $01,X                    ; EA4A: A6 01     ; Read PIAREGB
                BMI     ZEA89                    ; EA4C: 2B 3B     ; PB7 High ? (CRC-0) - ERROR
;*************************************************
; Found corr. Track and Sector, now look for Data Addr. Mark
;*************************************************
                LDAA    $05,X                    ; EA4E: A6 05     ;                                        <******************** different
                LDAA    #$04                     ; EA50: 86 04     ; Try four times
ZEA52           TST     $04,X                    ; EA52: 6D 04     ; Read SSDA Status Reg.
                BPL     ZEA52                    ; EA54: 2A FC     ; Wait for Data
                CMPA    $05,X                    ; EA56: A1 05     ; Compare SSDA Data Reg to A (04)
                CMPA    $05,X                    ; EA58: A1 05     ; Compare SSDA Data Reg to A (04)
                DECA                             ; EA5A: 4A        ; |
                BNE     ZEA52                    ; EA5B: 26 F5     ; try again
                LDAB    FUNCSAV                  ; EA5D: D6 0E     ; 
                BMI     WRITINIT                 ; EA5F: 2B 7C     ; Bit 7 set - Write Function
                LDAB    M0019                    ; EA61: D6 19     ; Waitloop
                ASLB                             ; EA63: 58        ; |
ZEA64           INX                              ; EA64: 08        ; |
                DEX                              ; EA65: 09        ; |
                DECB                             ; EA66: 5A        ; |
                BNE     ZEA64                    ; EA67: 26 FB     ; |
                LDAB    #$04                     ; EA69: C6 04     ; Try four times
ZEA6B           JSR     READINIT                 ; EA6B: BD E9 AC  ; Initialize SSDA for Read, Toggle RESET
                LDX     CURADRH                  ; EA6E: DE 06     ; 
ZEA70           LDAA    SSDA_0                   ; EA70: B6 EC 04  ; Read SSDA Status Reg.
                BPL     ZEA70                    ; EA73: 2A FB     ; Wait and Test RDA for 2 Bytes Ready
                LDAA    SSDA_1                   ; EA75: B6 EC 05  ; Read Data
                CMPA    #$6F                     ; EA78: 81 6F     ; Sync data address mark
                BEQ     READSECT                 ; EA7A: 27 21     ; ********** Found data address mark *************
                CMPA    #$6A                     ; EA7C: 81 6A     ; Read DELETED DATA MARK (set Error '4')
                BEQ     ZEA98                    ; EA7E: 27 18     ; |
                DECB                             ; EA80: 5A        ; |
                BNE     ZEA6B                    ; EA81: 26 E8     ; again
                LDAB    #$38                     ; EA83: C6 38     ; 
;                CPX     #MC631                   ; EA85: 8C C6 31  ; 
                FCB     $8C
ZEA86           LDAB    #$31                                       ; (Set Error '1') (DATA CRC ERROR)
;                CPX     #MC639                   ; EA88: 8C C6 39  ; 
                FCB     $8C
ZEA89           LDAB    #$39                                        ; (Set Error '9') (ADDRESS MARK CRC ERROR)
                DEC     M0018                    ; EA8B: 7A 00 18  ; 
                BEQ     ZEA9A                    ; EA8E: 27 0A     ; 
                LDX     SECTCNT                  ; EA90: DE 0B     ; 
                JMP     ZE9E5                    ; EA92: 7E E9 E5  ; 
;------------------------------------------------
DSKWPROT        LDAB    #$32                     ; EA95: C6 32     ; Set Error '2' (DISK WRITE PROTECTED)
;                CPX     #MC634                   ; EA97: 8C C6 34  ; 
                FCB     $8C
ZEA98           LDAB    #$34                                        ; (Set Error '4') (READ DELETED DATA MARK)
ZEA9A           JMP     SETERR                   ; EA9A: 7E E9 40  ; 
;------------------------------------------------
READSECT        LDAB    FUNCSAV                  ; EA9D: D6 0E     ; data address mark found
                ASLB                             ; EA9F: 58        ; 
                BMI     ZEABB                    ; EAA0: 2B 19     ; Check for READCRC ($40)
                LDAB    WRDCNT                   ; EAA2: D6 15     ; Wordcount?
ZEAA4           LDAA    SSDA_0                   ; EAA4: B6 EC 04  ; Read SSDA Status Reg.
                BPL     ZEAA4                    ; EAA7: 2A FB     ; Wait and Test RDA for 2 Bytes Ready
                LDAA    SSDA_1                   ; EAA9: B6 EC 05  ; Read Data to Buffer
                CPX     PROM_0                   ; EAAC: BC FC FC  ; in PROM_0 is zero *** This does nothing ! ***
                STAA    ,X                       ; EAAF: A7 00     ; |
                LDAA    SSDA_1                   ; EAB1: B6 EC 05  ; |
                STAA    $01,X                    ; EAB4: A7 01     ; |
                INX                              ; EAB6: 08        ; |
                INX                              ; EAB7: 08        ; |
                DECB                             ; EAB8: 5A        ; |
                BNE     ZEAA4                    ; EAB9: 26 E9     ; 
ZEABB           LDAB    M0009                    ; EABB: D6 09     ; counter
READCRC         LDAA    SSDA_0                   ; EABD: B6 EC 04  ; Read SSDA Status Reg.
                BPL     READCRC                  ; EAC0: 2A FB     ; Wait and Test RDA for 2 Bytes Ready
                DECB                             ; EAC2: 5A        ; dec. counter
                BMI     ZEACD                    ; EAC3: 2B 08     ; finished ?
                LDAA    SSDA_1                   ; EAC5: B6 EC 05  ; Read SSDA Data to A
                LDAA    SSDA_1                   ; EAC8: B6 EC 05  ; Read SSDA Data to A
                BRA     READCRC                  ; EACB: 20 F0     ; continue
;------------------------------------------------
ZEACD           LDAA    M0019                    ; EACD: 96 19     ; 
ZEACF           SUBA    #$03                     ; EACF: 80 03     ; 
                BHI     ZEACF                    ; EAD1: 22 FC     ; 
                LDAA    PIAREGB                  ; EAD3: B6 EC 01  ; |
                BMI     ZEA86                    ; EAD6: 2B AE     ; PB7 High ? (CRC-0) Error
                STX     CURADRH                  ; EAD8: DF 06     ; CRC ok
                JMP     ZE9D3                    ; EADA: 7E E9 D3  ; next sector
;------------------------------------------------
WRITINIT        LDX     #$C0DA                   ; EADD: CE C0 DA  ; 
                STX     SSDA_0                   ; EAE0: FF EC 04  ; 
                LDX     #$C1AA                   ; EAE3: CE C1 AA  ; 
                STX     SSDA_0                   ; EAE6: FF EC 04  ; 
                LDX     #$C270                   ; EAE9: CE C2 70  ; 
                STX     SSDA_0                   ; EAEC: FF EC 04  ; 
                INC     PIAREGB                  ; EAEF: 7C EC 01  ; 
                LDAA    #$82                     ; EAF2: 86 82     ; Bit 1,7
                STAA    SSDA_0                   ; EAF4: B7 EC 04  ; WG off, PB7 is an Input 
                DEX                              ; EAF7: 09        ; 
                STAA    PIAREGB                  ; EAF8: B7 EC 01  ; 
                LDAA    #$10                     ; EAFB: 86 10     ; Bit 4
                BITA    PIAREGB                  ; EAFD: B5 EC 01  ; Check Writeprot?
                BEQ     DSKWPROT                 ; EB00: 27 93     ; If yes set Error
                LDAA    M0019                    ; EB02: 96 19     ; Waitloop
                SUBA    #$03                     ; EB04: 80 03     ; |
                ASLA                             ; EB06: 48        ; |
ZEB07           DECA                             ; EB07: 4A        ; |
                BPL     ZEB07                    ; EB08: 2A FD     ; |
                CLR     PIAREGB                  ; EB0A: 7F EC 01  ; Clear all PB (Set to Write, Reset off, ShiftCRC off, WG on)
                RORB                             ; EB0D: 56        ; 
                BCC     ZEB11                    ; EB0E: 24 01     ; 
;                BITA    #$56                     ; EB10: 85 56     ; 
                FCB     $85                
ZEB11           RORB                             ;                 
                LDX     #$0005                   ; EB12: CE 00 05  ; 
                JSR     WAIT3                    ; EB15: BD E9 53  ; 
                LDAB    #$40                     ; EB18: C6 40     ; 
                LDAA    M0014                    ; EB1A: 96 14     ; 
                LDX     #$83F5                   ; EB1C: CE 83 F5  ; 
                STX     SSDA_0                   ; EB1F: FF EC 04  ; 
                LDX     CURADRH                  ; EB22: DE 06     ; 
                STAA    SSDA_1                   ; EB24: B7 EC 05  ; 
                JMP     ZEB31                    ; EB27: 7E EB 31  ; 
;------------------------------------------------
ZEB2A           LDAA    #$40                     ; EB2A: 86 40     ; 
ZEB2C           BITA    SSDA_0                   ; EB2C: B5 EC 04  ; 
                BEQ     ZEB2C                    ; EB2F: 27 FB     ; 
ZEB31           LDAA    PROM_0                   ; EB31: B6 FC FC  ; in PROM_0 is zero
                NOP                              ; EB34: 01        ; 
                LDAA    ,X                       ; EB35: A6 00     ; 
                STAA    SSDA_1                   ; EB37: B7 EC 05  ; 
                LDAA    $01,X                    ; EB3A: A6 01     ; 
                STAA    SSDA_1                   ; EB3C: B7 EC 05  ; 
                BCS     ZEB43                    ; EB3F: 25 02     ; 
                INX                              ; EB41: 08        ; 
                INX                              ; EB42: 08        ; 
ZEB43           DECB                             ; EB43: 5A        ; 
                BNE     ZEB2A                    ; EB44: 26 E4     ; 
                STX     CURADRH                  ; EB46: DF 06     ; 
                LDX     #PIAREGA                 ; EB48: CE EC 00  ; 
                LDAA    #$40                     ; EB4B: 86 40     ; 
ZEB4D           BITA    $04,X                    ; EB4D: A5 04     ; 
                BEQ     ZEB4D                    ; EB4F: 27 FC     ; 
                STAB    $05,X                    ; EB51: E7 05     ; 
ZEB53           BITA    $04,X                    ; EB53: A5 04     ; 
                BEQ     ZEB53                    ; EB55: 27 FC     ; 
                LDAB    #$08                     ; EB57: C6 08     ; 
                STAB    $01,X                    ; EB59: E7 01     ; 
                STAB    $05,X                    ; EB5B: E7 05     ; 
ZEB5D           BITA    $04,X                    ; EB5D: A5 04     ; 
                BEQ     ZEB5D                    ; EB5F: 27 FC     ; 
                LDAB    #$FF                     ; EB61: C6 FF     ; 
                STAB    $05,X                    ; EB63: E7 05     ; 
                STAB    $05,X                    ; EB65: E7 05     ; 
ZEB67           BITA    $04,X                    ; EB67: A5 04     ; 
                BEQ     ZEB67                    ; EB69: 27 FC     ; 
                CLR     $01,X                    ; EB6B: 6F 01     ; 
                INC     $01,X                    ; EB6D: 6C 01     ; 
                INC     $01,X                    ; EB6F: 6C 01     ; 
                JMP     ZE9D3                    ; EB71: 7E E9 D3  ; next sector
;------------------------------------------------
RETRG           LDX     #PIAREGA                 ; EB74: CE EC 00  ; 
                LDAA    #$36                     ; EB77: 86 36     ; |
                STAA    $03,X                    ; EB79: A7 03     ; $36 -> PIACTRLB (CB2 Low - Trigger NMI Timer, IRQB Flag set by HL on CB1 - IDX, Select Output Reg. B)
                LDAA    #$3E                     ; EB7B: 86 3E     ; |
                STAA    $03,X                    ; EB7D: A7 03     ; $3E -> PIACTRLB (CB2 high)
                LDAB    ,X                       ; EB7F: E6 00     ; Get Port A
                DECA                             ; EB81: 4A        ; 
                STAA    $02,X                    ; EB82: A7 02     ; $3D -> PIACTRLA (En. IRQA interrupt by CA1 - NMI Timer, Sel. Output Reg. A, CA2 high - STEP)
                RTS                              ; EB84: 39        ; 
;------------------------------------------------
CLKDMD          BSR     RETRG                    ; EB85: 8D ED     ; Retrigger NMI Timer
                LDAB    $01,X                    ; EB87: E6 01     ; 
                CLRA                             ; EB89: 4F        ; 
ZEB8A           LDAB    $03,X                    ; EB8A: E6 03     ; 
                BPL     ZEB8A                    ; EB8C: 2A FC     ; 
                LDAB    $01,X                    ; EB8E: E6 01     ; 
CLRTOP          CLRB                             ; EB90: 5F        ; 
ZEB91           DECB                             ; EB91: 5A        ; 
                BNE     ZEB91                    ; EB92: 26 FD     ; 
                INCA                             ; EB94: 4C        ; 
                TST     $03,X                    ; EB95: 6D 03     ; 
                BPL     CLRTOP                   ; EB97: 2A F7     ; 
                INCB                             ; EB99: 5C        ; 
                SUBA    #$4B                     ; EB9A: 80 4B     ; 
ZEB9C           INCB                             ; EB9C: 5C        ; 
                SUBA    #$16                     ; EB9D: 80 16     ; 
                BCC     ZEB9C                    ; EB9F: 24 FB     ; 
                STAB    M0019                    ; EBA1: D7 19     ; 
                JMP     ERRHNDLR                 ; EBA3: 7E E9 91  ; 
;------------------------------------------------
FDINIT3         JSR     FDINIT                   ; EBA6: BD E8 22  ; 
                JMP     CLOCK                    ; EBA9: 7E E8 87  ; 
;------------------------------------------------
ZEBAC           PSHA                             ; EBAC: 36        ; 
ZEBAD           LDAB    MEC26                    ; EBAD: F6 EC 26  ; <------------------------------------ no RAM here!
                BITB    #$01                     ; EBB0: C5 01     ; 
                BEQ     ZEBDA                    ; EBB2: 27 26     ; 
                LDAA    MEC27                    ; EBB4: B6 EC 27  ; <------------------------------------ no RAM here!
                CMPA    #$13                     ; EBB7: 81 13     ; 
                BNE     ZEBDA                    ; EBB9: 26 1F     ; 
ZEBBB           LDAB    MEC26                    ; EBBB: F6 EC 26  ; <------------------------------------ no RAM here!
                BRA     ZEBCF                    ; EBBE: 20 0F     ; 
;------------------------------------------------
LPINIT          LDAA    #$03                     ; EBC0: 86 03     ; 
                STAA    MEC26                    ; EBC2: B7 EC 26  ; <------------------------------------ no RAM here!
                LDAA    #$15                     ; EBC5: 86 15     ; 
                STAA    MEC26                    ; EBC7: B7 EC 26  ; <------------------------------------ no RAM here! 
                RTS                              ; EBCA: 39        ; 
;------------------------------------------------
                NOP                              ; EBCB: 01        ; 
LIST            PSHB                             ; EBCC: 37        ; 
                BRA     ZEBAC                    ; EBCD: 20 DD     ; 
;------------------------------------------------
ZEBCF           BITB    #$01                     ; EBCF: C5 01     ; 
                BEQ     ZEBBB                    ; EBD1: 27 E8     ; 
                LDAA    MEC27                    ; EBD3: B6 EC 27  ; <------------------------------------ no RAM here!
                CMPA    #$11                     ; EBD6: 81 11     ; 
                BNE     ZEBBB                    ; EBD8: 26 E1     ; 
ZEBDA           BITB    #$02                     ; EBDA: C5 02     ; 
                BEQ     ZEBAD                    ; EBDC: 27 CF     ; 
                PULA                             ; EBDE: 32        ; 
                STAA    MEC27                    ; EBDF: B7 EC 27  ; <------------------------------------ no RAM here!
                PULB                             ; EBE2: 33        ; 
                RTS                              ; EBE3: 39        ; 
;------------------------------------------------
LDATA0          LDAA    #$0D                     ; EBE4: 86 0D     ; Send String to Printer
                BSR     LIST                     ; EBE6: 8D E4     ; 
                DEX                              ; EBE8: 09        ; 
                LDAA    #$0A                     ; EBE9: 86 0A     ; 
                BRA     ZEBEF                    ; EBEB: 20 02     ; 
;------------------------------------------------
                NOP                              ; EBED: 01        ; 
                NOP                              ; EBEE: 01        ; 
ZEBEF           BSR     LIST                     ; EBEF: 8D DB     ; 
                INX                              ; EBF1: 08        ; 
                LDAA    ,X                       ; EBF2: A6 00     ; 
                CMPA    #$04                     ; EBF4: 81 04     ; End of line ?
                BNE     ZEBEF                    ; EBF6: 26 F7     ; 
                LDAA    #$1B                     ; EBF8: 86 1B     ; 
                BSR     LIST                     ; EBFA: 8D D0     ; 
                RTS                              ; EBFC: 39        ; 
;------------------------------------------------
                FCB     $00                      ; EBFD: 00             
                FCB     $00                      ; EBFE: 00             
                FCB     $00                      ; EBFF: 00             


                END
