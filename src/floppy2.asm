dasmfw: Disassembler Framework V0.35
Loaded: binary file "floppy2.bin"
Loaded: Info file "floppy2.info"

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
NMIVECSAV
        EQU     $000F
M0012   EQU     $0012
TRACKSAV EQU    $0013
M0014   EQU     $0014
WRDCNT  EQU     $0015
M0016   EQU     $0016
M0017   EQU     $0017
M0018   EQU     $0018
M0019   EQU     $0019
LDADDR  EQU     $0020
M00FE   EQU     $00FE
M0187   EQU     $0187
M02C0   EQU     $02C0
M033C   EQU     $033C
M0404   EQU     $0404
M1B02   EQU     $1B02
M1F0F   EQU     $1F0F
Z1FFD   EQU     $1FFD
M3C3E   EQU     $3C3E
M83F5   EQU     $83F5
M9711   EQU     $9711
MC0DA   EQU     $C0DA
MC1AA   EQU     $C1AA
MC270   EQU     $C270
MC604   EQU     $C604
MC608   EQU     $C608
MC610   EQU     $C610
MC631   EQU     $C631
MC634   EQU     $C634
MC636   EQU     $C636
MC637   EQU     $C637
MC639   EQU     $C639
MC640   EQU     $C640
MC680   EQU     $C680
MC681   EQU     $C681
MC682   EQU     $C682
MC6C0   EQU     $C6C0
MC6C2   EQU     $C6C2
MD0D8   EQU     $D0D8
MD0DA   EQU     $D0DA
MD1F5   EQU     $D1F5
MD270   EQU     $D270
PIAREGA EQU     $EC00
PIAREGB EQU     $EC01
PIACTRL EQU     $EC02
SSDA_0  EQU     $EC04
SSDA_1  EQU     $EC05
MEC26   EQU     $EC26
MEC27   EQU     $EC27
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
REENT2  EQU     $F564
PROM_0  EQU     $FCFC
XSTAKs  EQU     $FF8A
NMIsVC  EQU     $FFFC

;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $E800

OSLOAD          LDS     #XSTAKs                  ; E800: 8E FF 8A       
                CLRA                             ; E803: 4F             
                STAA    CURDRV                   ; E804: 97 00          
                BSR     ZE850                    ; E806: 8D 48          
                BSR     RESTOR                   ; E808: 8D 6B          
                BSR     CHKERR                   ; E80A: 8D 47          
                LDX     #M0017                   ; E80C: CE 00 17       
                STX     STRSCTH                  ; E80F: DF 01          
                LDX     #STRSCTL                 ; E811: CE 00 02       
                STX     NUMSCTH                  ; E814: DF 03          
                LDX     #LDADDR                  ; E816: CE 00 20       
                STX     CURADRH                  ; E819: DF 06          
                BSR     READSC                   ; E81B: 8D 4C          
                BSR     CHKERR                   ; E81D: 8D 34          
                JMP     LDADDR                   ; E81F: 7E 00 20       
FDINIT          LDX     #CURDRV                  ; E822: CE 00 00       
                STX     PIACTRL                  ; E825: FF EC 02       
                STX     PIAREGA                  ; E828: FF EC 00       
                LDX     #MD0DA                   ; E82B: CE D0 DA       
                STX     SSDA_0                   ; E82E: FF EC 04       
                LDX     #M0404                   ; E831: CE 04 04       
                STX     PIACTRL                  ; E834: FF EC 02       
                LDX     #M1B02                   ; E837: CE 1B 02       
                STX     PIAREGA                  ; E83A: FF EC 00       
                LDX     #CURDRV                  ; E83D: CE 00 00       
                STX     PIACTRL                  ; E840: FF EC 02       
                LDX     #M1F0F                   ; E843: CE 1F 0F       
                STX     PIAREGA                  ; E846: FF EC 00       
                LDX     #M3C3E                   ; E849: CE 3C 3E       
                STX     PIACTRL                  ; E84C: FF EC 02       
ZE84F           RTS                              ; E84F: 39             
ZE850           JSR     ZEBA6                    ; E850: BD EB A6       
CHKERR          BCC     ZE84F                    ; E853: 24 FA          
                BSR     PRNTER                   ; E855: 8D 03          
                JMP     REENT2                   ; E857: 7E F5 64       
PRNTER          LDAA    #$45                     ; E85A: 86 45          
                BSR     ZE866                    ; E85C: 8D 08          
                LDAA    FDSTAT                   ; E85E: 96 08          
                BSR     ZE866                    ; E860: 8D 04          
                LDAA    #$20                     ; E862: 86 20          
                BSR     ZE866                    ; E864: 8D 00          
ZE866           JMP     XOUTCH                   ; E866: 7E F0 18       
READSC          LDAB    #$80                     ; E869: C6 80          
                STAB    LSCTLN                   ; E86B: D7 05          
                CLRB                             ; E86D: 5F             
                CPX     #MC640                   ; E86E: 8C C6 40       
                CPX     #MC6C2                   ; E871: 8C C6 C2       
                CPX     #MC608                   ; E874: 8C C6 08       
                CPX     #MC610                   ; E877: 8C C6 10       
                CPX     #MC682                   ; E87A: 8C C6 82       
                CPX     #MC681                   ; E87D: 8C C6 81       
                CPX     #MC6C0                   ; E880: 8C C6 C0       
                CPX     #MC680                   ; E883: 8C C6 80       
                CPX     #MC604                   ; E886: 8C C6 04       
                TPA                              ; E889: 07             
                SEI                              ; E88A: 0F             
                STAA    STATSAV                  ; E88B: 97 0D          
                STAB    FUNCSAV                  ; E88D: D7 0E          
                LDAA    #$30                     ; E88F: 86 30          
                STAA    FDSTAT                   ; E891: 97 08          
                STS     M0016                    ; E893: 9F 16          
                LDX     NMIsVC                   ; E895: FE FF FC       
                STX     NMIVECSAV                ; E898: DF 0F          
                LDX     #ME939                   ; E89A: CE E9 39       
                STX     NMIsVC                   ; E89D: FF FF FC       
                LDX     #M0012                   ; E8A0: CE 00 12       
                LDAA    #$01                     ; E8A3: 86 01          
                CMPA    CURDRV                   ; E8A5: 91 00          
                BCS     ZE8BB                    ; E8A7: 25 12          
                BEQ     ZE8AD                    ; E8A9: 27 02          
                DEX                              ; E8AB: 09             
                INCA                             ; E8AC: 4C             
ZE8AD           STAA    PIAREGA                  ; E8AD: B7 EC 00       
                LDAA    ,X                       ; E8B0: A6 00          
                STAA    TRACKSAV                 ; E8B2: 97 13          
                LDAA    #$40                     ; E8B4: 86 40          
                BITA    PIAREGA                  ; E8B6: B5 EC 00       
                BEQ     ZE8C2                    ; E8B9: 27 07          
ZE8BB           LDAB    #$33                     ; E8BB: C6 33          
                CPX     #MC636                   ; E8BD: 8C C6 36       
                BRA     ZE940                    ; E8C0: 20 7E          
ZE8C2           BITB    #$08                     ; E8C2: C5 08          
                BEQ     ZE8CB                    ; E8C4: 27 05          
                CLRB                             ; E8C6: 5F             
                LDAA    #$03                     ; E8C7: 86 03          
                BRA     ZE90A                    ; E8C9: 20 3F          
ZE8CB           BITB    #$04                     ; E8CB: C5 04          
                BEQ     ZE8D2                    ; E8CD: 27 03          
                JMP     ZEB85                    ; E8CF: 7E EB 85       
ZE8D2           LDAB    STRSCTL                  ; E8D2: D6 02          
                LDAA    STRSCTH                  ; E8D4: 96 01          
                ADDB    NUMSCTL                  ; E8D6: DB 04          
                ADCA    NUMSCTH                  ; E8D8: 99 03          
                BCS     ZE8BE                    ; E8DA: 25 E2          
                CMPB    #$D3                     ; E8DC: C1 D3          
                SBCA    #$07                     ; E8DE: 82 07          
                BCC     ZE8BE                    ; E8E0: 24 DC          
                LDAA    #$FF                     ; E8E2: 86 FF          
                STAA    SECTOR                   ; E8E4: 97 0A          
                LDAA    STRSCTH                  ; E8E6: 96 01          
                LDAB    STRSCTL                  ; E8E8: D6 02          
ZE8EA           INC     SECTOR                   ; E8EA: 7C 00 0A       
                SUBB    #$D0                     ; E8ED: C0 D0          
                SBCA    #$00                     ; E8EF: 82 00          
                BCC     ZE8EA                    ; E8F1: 24 F7          
                ADDB    #$D0                     ; E8F3: CB D0          
                LDAA    SECTOR                   ; E8F5: 96 0A          
                ASLA                             ; E8F7: 48             
                ASLA                             ; E8F8: 48             
                ASLA                             ; E8F9: 48             
                DECA                             ; E8FA: 4A             
ZE8FB           INCA                             ; E8FB: 4C             
                SUBB    #$1A                     ; E8FC: C0 1A          
                BCC     ZE8FB                    ; E8FE: 24 FB          
                ADDB    #$1A                     ; E900: CB 1A          
                STAB    SECTOR                   ; E902: D7 0A          
                LDX     NUMSCTH                  ; E904: DE 03          
                STX     SECTCNT                  ; E906: DF 0B          
                LDAB    TRACKSAV                 ; E908: D6 13          
ZE90A           STAA    TRACKSAV                 ; E90A: 97 13          
                SBA                              ; E90C: 10             
                LDAB    PIAREGA                  ; E90D: F6 EC 00       
                ORAB    #$08                     ; E910: CA 08          
                BCC     ZE917                    ; E912: 24 03          
                ANDB    #$F7                     ; E914: C4 F7          
                NEGA                             ; E916: 40             
ZE917           ANDB    #$EF                     ; E917: C4 EF          
                CMPA    #$04                     ; E919: 81 04          
                BLS     ZE91F                    ; E91B: 23 02          
                ORAB    #$10                     ; E91D: CA 10          
ZE91F           STAB    PIAREGA                  ; E91F: F7 EC 00       
                DECA                             ; E922: 4A             
                BMI     ZE96A                    ; E923: 2B 45          
                BSR     ZE946                    ; E925: 8D 1F          
                LDAB    PIAREGA                  ; E927: F6 EC 00       
                BPL     ZE917                    ; E92A: 2A EB          
                TSTA                             ; E92C: 4D             
                BEQ     ZE96A                    ; E92D: 27 3B          
                LDAA    FUNCSAV                  ; E92F: 96 0E          
                BITA    #$08                     ; E931: 85 08          
                BEQ     ZE93E                    ; E933: 27 09          
                BSR     ZE95C                    ; E935: 8D 25          
                BRA     ZE991                    ; E937: 20 58          
ME939           LDS     M0016                    ; E939: 9E 16          
                LDAB    #$35                     ; E93B: C6 35          
                CPX     #MC637                   ; E93D: 8C C6 37       
ZE940           STAB    FDSTAT                   ; E940: D7 08          
                BSR     ZE991                    ; E942: 8D 4D          
                SEC                              ; E944: 0D             
                RTS                              ; E945: 39             
ZE946           LDAB    #$34                     ; E946: C6 34          
                STAB    PIACTRL                  ; E948: F7 EC 02       
                LDAB    #$3C                     ; E94B: C6 3C          
                STAB    PIACTRL                  ; E94D: F7 EC 02       
                LDX     #M00FE                   ; E950: CE 00 FE       
ZE953           LDAB    M0019                    ; E953: D6 19          
ZE955           DECB                             ; E955: 5A             
                BNE     ZE955                    ; E956: 26 FD          
                DEX                              ; E958: 09             
                BNE     ZE953                    ; E959: 26 F8          
                RTS                              ; E95B: 39             
ZE95C           LDX     #M0187                   ; E95C: CE 01 87       
                BRA     ZE953                    ; E95F: 20 F2          
ZE961           LDAA    TRACKSAV                 ; E961: 96 13          
                BEQ     ZE93E                    ; E963: 27 D9          
                CLRA                             ; E965: 4F             
                LDAB    #$56                     ; E966: C6 56          
                BRA     ZE90A                    ; E968: 20 A0          
ZE96A           LDX     #M02C0                   ; E96A: CE 02 C0       
                BSR     ZE953                    ; E96D: 8D E4          
                LDAA    FUNCSAV                  ; E96F: 96 0E          
                BITA    #$08                     ; E971: 85 08          
                BNE     ZE961                    ; E973: 26 EC          
                BITA    #$10                     ; E975: 85 10          
                BNE     ZE991                    ; E977: 26 18          
                LDAB    #$6F                     ; E979: C6 6F          
                RORA                             ; E97B: 46             
                BCC     ZE980                    ; E97C: 24 02          
                LDAB    #$6A                     ; E97E: C6 6A          
ZE980           STAB    M0014                    ; E980: D7 14          
                BRA     ZE9D3                    ; E982: 20 4F          
ZE984           LDAA    FUNCSAV                  ; E984: 96 0E          
                BPL     ZE991                    ; E986: 2A 09          
                ANDA    #$40                     ; E988: 84 40          
                STAA    FUNCSAV                  ; E98A: 97 0E          
                BEQ     ZE991                    ; E98C: 27 03          
                JMP     ZE8D2                    ; E98E: 7E E8 D2       
ZE991           LDX     #M033C                   ; E991: CE 03 3C       
                STX     PIAREGB                  ; E994: FF EC 01       
                LDX     NMIVECSAV                ; E997: DE 0F          
                STX     NMIsVC                   ; E999: FF FF FC       
                LDAA    TRACKSAV                 ; E99C: 96 13          
                LDAB    CURDRV                   ; E99E: D6 00          
                BEQ     ZE9A5                    ; E9A0: 27 03          
                STAA    M0012                    ; E9A2: 97 12          
                CPX     #M9711                   ; E9A4: 8C 97 11       
                LDAA    STATSAV                  ; E9A7: 96 0D          
                TAP                              ; E9A9: 06             
                CLC                              ; E9AA: 0C             
                RTS                              ; E9AB: 39             
ZE9AC           LDX     #MD0D8                   ; E9AC: CE D0 D8       
                STX     SSDA_0                   ; E9AF: FF EC 04       
                LDX     #PIAREGA                 ; E9B2: CE EC 00       
                LDAA    #$50                     ; E9B5: 86 50          
                STAA    $04,X                    ; E9B7: A7 04          
                LDAA    #$07                     ; E9B9: 86 07          
                STAA    $01,X                    ; E9BB: A7 01          
                DEC     $01,X                    ; E9BD: 6A 01          
                INX                              ; E9BF: 08             
                DEX                              ; E9C0: 09             
                LDAA    #$40                     ; E9C1: 86 40          
                STAA    $04,X                    ; E9C3: A7 04          
                LDAA    #$98                     ; E9C5: 86 98          
                STAA    $05,X                    ; E9C7: A7 05          
                RTS                              ; E9C9: 39             
ZE9CA           STAA    SECTOR                   ; E9CA: 97 0A          
                JSR     ZE946                    ; E9CC: BD E9 46       
                BSR     ZE95C                    ; E9CF: 8D 8B          
                INC     $13,X                    ; E9D1: 6C 13          
ZE9D3           INC     SECTOR                   ; E9D3: 7C 00 0A       
                LDAA    SECTOR                   ; E9D6: 96 0A          
                LDX     SECTCNT                  ; E9D8: DE 0B          
                BEQ     ZE984                    ; E9DA: 27 A8          
                SUBA    #$1B                     ; E9DC: 80 1B          
                BCC     ZE9CA                    ; E9DE: 24 EA          
                LDAA    #$05                     ; E9E0: 86 05          
                STAA    M0018                    ; E9E2: 97 18          
                DEX                              ; E9E4: 09             
ZE9E5           LDAA    #$40                     ; E9E5: 86 40          
                STX     SECTCNT                  ; E9E7: DF 0B          
                BNE     ZE9F2                    ; E9E9: 26 07          
                LDAA    LSCTLN                   ; E9EB: 96 05          
                ADDA    #$07                     ; E9ED: 8B 07          
                LSRA                             ; E9EF: 44             
                ANDA    #$FC                     ; E9F0: 84 FC          
ZE9F2           STAA    WRDCNT                   ; E9F2: 97 15          
                NEGA                             ; E9F4: 40             
                LDAB    FUNCSAV                  ; E9F5: D6 0E          
                ASLB                             ; E9F7: 58             
                BPL     ZE9FB                    ; E9F8: 2A 01          
                CLRA                             ; E9FA: 4F             
ZE9FB           ADDA    #$40                     ; E9FB: 8B 40          
                STAA    M0009                    ; E9FD: 97 09          
                JSR     ZEB74                    ; E9FF: BD EB 74       
                LDAA    TRACKSAV                 ; EA02: 96 13          
                ORAB    #$0C                     ; EA04: CA 0C          
                CMPA    #$2B                     ; EA06: 81 2B          
                BLS     ZEA0C                    ; EA08: 23 02          
                ANDB    #$FB                     ; EA0A: C4 FB          
ZEA0C           STAB    ,X                       ; EA0C: E7 00          
                LDX     #MD270                   ; EA0E: CE D2 70       
                STX     SSDA_0                   ; EA11: FF EC 04       
                LDX     #MD1F5                   ; EA14: CE D1 F5       
                STX     SSDA_0                   ; EA17: FF EC 04       
ZEA1A           BSR     ZE9AC                    ; EA1A: 8D 90          
ZEA1C           LDAA    $04,X                    ; EA1C: A6 04          
                BPL     ZEA1C                    ; EA1E: 2A FC          
                LDAA    $05,X                    ; EA20: A6 05          
                CMPA    #$7E                     ; EA22: 81 7E          
                BNE     ZEA1A                    ; EA24: 26 F4          
ZEA26           LDAA    $04,X                    ; EA26: A6 04          
                BPL     ZEA26                    ; EA28: 2A FC          
                LDAA    $05,X                    ; EA2A: A6 05          
                LDAB    $05,X                    ; EA2C: E6 05          
                CMPA    TRACKSAV                 ; EA2E: 91 13          
                BNE     ZEA1A                    ; EA30: 26 E8          
ZEA32           LDAA    $04,X                    ; EA32: A6 04          
                BPL     ZEA32                    ; EA34: 2A FC          
                LDAA    $05,X                    ; EA36: A6 05          
                LDAB    $05,X                    ; EA38: E6 05          
                CMPA    SECTOR                   ; EA3A: 91 0A          
                BNE     ZEA1A                    ; EA3C: 26 DC          
ZEA3E           LDAA    $04,X                    ; EA3E: A6 04          
                BPL     ZEA3E                    ; EA40: 2A FC          
                TST     $05,X                    ; EA42: 6D 05          
                LDAA    M0019                    ; EA44: 96 19          
ZEA46           SUBA    #$03                     ; EA46: 80 03          
                BHI     ZEA46                    ; EA48: 22 FC          
                LDAA    $01,X                    ; EA4A: A6 01          
                BMI     ZEA89                    ; EA4C: 2B 3B          
                LDAA    $05,X                    ; EA4E: A6 05          
                LDAA    #$04                     ; EA50: 86 04          
ZEA52           TST     $04,X                    ; EA52: 6D 04          
                BPL     ZEA52                    ; EA54: 2A FC          
                CMPA    $05,X                    ; EA56: A1 05          
                CMPA    $05,X                    ; EA58: A1 05          
                DECA                             ; EA5A: 4A             
                BNE     ZEA52                    ; EA5B: 26 F5          
                LDAB    FUNCSAV                  ; EA5D: D6 0E          
                BMI     ZEADD                    ; EA5F: 2B 7C          
                LDAB    M0019                    ; EA61: D6 19          
                ASLB                             ; EA63: 58             
ZEA64           INX                              ; EA64: 08             
                DEX                              ; EA65: 09             
                DECB                             ; EA66: 5A             
                BNE     ZEA64                    ; EA67: 26 FB          
                LDAB    #$04                     ; EA69: C6 04          
ZEA6B           JSR     ZE9AC                    ; EA6B: BD E9 AC       
                LDX     CURADRH                  ; EA6E: DE 06          
ZEA70           LDAA    SSDA_0                   ; EA70: B6 EC 04       
                BPL     ZEA70                    ; EA73: 2A FB          
                LDAA    SSDA_1                   ; EA75: B6 EC 05       
                CMPA    #$6F                     ; EA78: 81 6F          
                BEQ     ZEA9D                    ; EA7A: 27 21          
                CMPA    #$6A                     ; EA7C: 81 6A          
                BEQ     ZEA98                    ; EA7E: 27 18          
                DECB                             ; EA80: 5A             
                BNE     ZEA6B                    ; EA81: 26 E8          
                LDAB    #$38                     ; EA83: C6 38          
                CPX     #MC631                   ; EA85: 8C C6 31       
                CPX     #MC639                   ; EA88: 8C C6 39       
                DEC     M0018                    ; EA8B: 7A 00 18       
                BEQ     ZEA9A                    ; EA8E: 27 0A          
                LDX     SECTCNT                  ; EA90: DE 0B          
                JMP     ZE9E5                    ; EA92: 7E E9 E5       
ZEA95           LDAB    #$32                     ; EA95: C6 32          
                CPX     #MC634                   ; EA97: 8C C6 34       
ZEA9A           JMP     ZE940                    ; EA9A: 7E E9 40       
ZEA9D           LDAB    FUNCSAV                  ; EA9D: D6 0E          
                ASLB                             ; EA9F: 58             
                BMI     ZEABB                    ; EAA0: 2B 19          
                LDAB    WRDCNT                   ; EAA2: D6 15          
ZEAA4           LDAA    SSDA_0                   ; EAA4: B6 EC 04       
                BPL     ZEAA4                    ; EAA7: 2A FB          
                LDAA    SSDA_1                   ; EAA9: B6 EC 05       
                CPX     PROM_0                   ; EAAC: BC FC FC       
                STAA    ,X                       ; EAAF: A7 00          
                LDAA    SSDA_1                   ; EAB1: B6 EC 05       
                STAA    $01,X                    ; EAB4: A7 01          
                INX                              ; EAB6: 08             
                INX                              ; EAB7: 08             
                DECB                             ; EAB8: 5A             
                BNE     ZEAA4                    ; EAB9: 26 E9          
ZEABB           LDAB    M0009                    ; EABB: D6 09          
ZEABD           LDAA    SSDA_0                   ; EABD: B6 EC 04       
                BPL     ZEABD                    ; EAC0: 2A FB          
                DECB                             ; EAC2: 5A             
                BMI     ZEACD                    ; EAC3: 2B 08          
                LDAA    SSDA_1                   ; EAC5: B6 EC 05       
                LDAA    SSDA_1                   ; EAC8: B6 EC 05       
                BRA     ZEABD                    ; EACB: 20 F0          
ZEACD           LDAA    M0019                    ; EACD: 96 19          
ZEACF           SUBA    #$03                     ; EACF: 80 03          
                BHI     ZEACF                    ; EAD1: 22 FC          
                LDAA    PIAREGB                  ; EAD3: B6 EC 01       
                BMI     ZEA86                    ; EAD6: 2B AE          
                STX     CURADRH                  ; EAD8: DF 06          
                JMP     ZE9D3                    ; EADA: 7E E9 D3       
ZEADD           LDX     #MC0DA                   ; EADD: CE C0 DA       
                STX     SSDA_0                   ; EAE0: FF EC 04       
                LDX     #MC1AA                   ; EAE3: CE C1 AA       
                STX     SSDA_0                   ; EAE6: FF EC 04       
                LDX     #MC270                   ; EAE9: CE C2 70       
                STX     SSDA_0                   ; EAEC: FF EC 04       
                INC     PIAREGB                  ; EAEF: 7C EC 01       
                LDAA    #$82                     ; EAF2: 86 82          
                STAA    SSDA_0                   ; EAF4: B7 EC 04       
                DEX                              ; EAF7: 09             
                STAA    PIAREGB                  ; EAF8: B7 EC 01       
                LDAA    #$10                     ; EAFB: 86 10          
                BITA    PIAREGB                  ; EAFD: B5 EC 01       
                BEQ     ZEA95                    ; EB00: 27 93          
                LDAA    M0019                    ; EB02: 96 19          
                SUBA    #$03                     ; EB04: 80 03          
                ASLA                             ; EB06: 48             
ZEB07           DECA                             ; EB07: 4A             
                BPL     ZEB07                    ; EB08: 2A FD          
                CLR     PIAREGB                  ; EB0A: 7F EC 01       
                RORB                             ; EB0D: 56             
                BCC     ZEB11                    ; EB0E: 24 01          
                FCB     $85                      ; EB10: 85             
ZEB11           RORB                             ; EB11: 56             
                LDX     #LSCTLN                  ; EB12: CE 00 05       
                JSR     ZE953                    ; EB15: BD E9 53       
                LDAB    #$40                     ; EB18: C6 40          
                LDAA    M0014                    ; EB1A: 96 14          
                LDX     #M83F5                   ; EB1C: CE 83 F5       
                STX     SSDA_0                   ; EB1F: FF EC 04       
                LDX     CURADRH                  ; EB22: DE 06          
                STAA    SSDA_1                   ; EB24: B7 EC 05       
                JMP     ZEB31                    ; EB27: 7E EB 31       
ZEB2A           LDAA    #$40                     ; EB2A: 86 40          
ZEB2C           BITA    SSDA_0                   ; EB2C: B5 EC 04       
                BEQ     ZEB2C                    ; EB2F: 27 FB          
ZEB31           LDAA    PROM_0                   ; EB31: B6 FC FC       
                NOP                              ; EB34: 01             
                LDAA    ,X                       ; EB35: A6 00          
                STAA    SSDA_1                   ; EB37: B7 EC 05       
                LDAA    $01,X                    ; EB3A: A6 01          
                STAA    SSDA_1                   ; EB3C: B7 EC 05       
                BCS     ZEB43                    ; EB3F: 25 02          
                INX                              ; EB41: 08             
                INX                              ; EB42: 08             
ZEB43           DECB                             ; EB43: 5A             
                BNE     ZEB2A                    ; EB44: 26 E4          
                STX     CURADRH                  ; EB46: DF 06          
                LDX     #PIAREGA                 ; EB48: CE EC 00       
                LDAA    #$40                     ; EB4B: 86 40          
ZEB4D           BITA    $04,X                    ; EB4D: A5 04          
                BEQ     ZEB4D                    ; EB4F: 27 FC          
                STAB    $05,X                    ; EB51: E7 05          
ZEB53           BITA    $04,X                    ; EB53: A5 04          
                BEQ     ZEB53                    ; EB55: 27 FC          
                LDAB    #$08                     ; EB57: C6 08          
                STAB    $01,X                    ; EB59: E7 01          
                STAB    $05,X                    ; EB5B: E7 05          
ZEB5D           BITA    $04,X                    ; EB5D: A5 04          
                BEQ     ZEB5D                    ; EB5F: 27 FC          
                LDAB    #$FF                     ; EB61: C6 FF          
                STAB    $05,X                    ; EB63: E7 05          
                STAB    $05,X                    ; EB65: E7 05          
ZEB67           BITA    $04,X                    ; EB67: A5 04          
                BEQ     ZEB67                    ; EB69: 27 FC          
                CLR     $01,X                    ; EB6B: 6F 01          
                INC     $01,X                    ; EB6D: 6C 01          
                INC     $01,X                    ; EB6F: 6C 01          
                JMP     ZE9D3                    ; EB71: 7E E9 D3       
ZEB74           LDX     #PIAREGA                 ; EB74: CE EC 00       
                LDAA    #$36                     ; EB77: 86 36          
                STAA    $03,X                    ; EB79: A7 03          
                LDAA    #$3E                     ; EB7B: 86 3E          
                STAA    $03,X                    ; EB7D: A7 03          
                LDAB    ,X                       ; EB7F: E6 00          
                DECA                             ; EB81: 4A             
                STAA    $02,X                    ; EB82: A7 02          
                RTS                              ; EB84: 39             
ZEB85           BSR     ZEB74                    ; EB85: 8D ED          
                LDAB    $01,X                    ; EB87: E6 01          
                CLRA                             ; EB89: 4F             
ZEB8A           LDAB    $03,X                    ; EB8A: E6 03          
                BPL     ZEB8A                    ; EB8C: 2A FC          
                LDAB    $01,X                    ; EB8E: E6 01          
CLRTOP          CLRB                             ; EB90: 5F             
ZEB91           DECB                             ; EB91: 5A             
                BNE     ZEB91                    ; EB92: 26 FD          
                INCA                             ; EB94: 4C             
                TST     $03,X                    ; EB95: 6D 03          
                BPL     CLRTOP                   ; EB97: 2A F7          
                INCB                             ; EB99: 5C             
                SUBA    #$4B                     ; EB9A: 80 4B          
ZEB9C           INCB                             ; EB9C: 5C             
                SUBA    #$16                     ; EB9D: 80 16          
                BCC     ZEB9C                    ; EB9F: 24 FB          
                STAB    M0019                    ; EBA1: D7 19          
                JMP     ZE991                    ; EBA3: 7E E9 91       
ZEBA6           JSR     FDINIT                   ; EBA6: BD E8 22       
                JMP     CLOCK                    ; EBA9: 7E E8 87       
ZEBAC           PSHA                             ; EBAC: 36             
ZEBAD           LDAB    MEC26                    ; EBAD: F6 EC 26       
                BITB    #$01                     ; EBB0: C5 01          
                BEQ     ZEBDA                    ; EBB2: 27 26          
                LDAA    MEC27                    ; EBB4: B6 EC 27       
                CMPA    #$13                     ; EBB7: 81 13          
                BNE     ZEBDA                    ; EBB9: 26 1F          
ZEBBB           LDAB    MEC26                    ; EBBB: F6 EC 26       
                BRA     ZEBCF                    ; EBBE: 20 0F          
                LDAA    #$03                     ; EBC0: 86 03          
                STAA    MEC26                    ; EBC2: B7 EC 26       
                LDAA    #$15                     ; EBC5: 86 15          
                STAA    MEC26                    ; EBC7: B7 EC 26       
                RTS                              ; EBCA: 39             
                NOP                              ; EBCB: 01             
LIST            PSHB                             ; EBCC: 37             
                BRA     ZEBAC                    ; EBCD: 20 DD          
ZEBCF           BITB    #$01                     ; EBCF: C5 01          
                BEQ     ZEBBB                    ; EBD1: 27 E8          
                LDAA    MEC27                    ; EBD3: B6 EC 27       
                CMPA    #$11                     ; EBD6: 81 11          
                BNE     ZEBBB                    ; EBD8: 26 E1          
ZEBDA           BITB    #$02                     ; EBDA: C5 02          
                BEQ     ZEBAD                    ; EBDC: 27 CF          
                PULA                             ; EBDE: 32             
                STAA    MEC27                    ; EBDF: B7 EC 27       
                PULB                             ; EBE2: 33             
                RTS                              ; EBE3: 39             
                LDAA    #$0D                     ; EBE4: 86 0D          
                BSR     LIST                     ; EBE6: 8D E4          
                DEX                              ; EBE8: 09             
                LDAA    #$0A                     ; EBE9: 86 0A          
                BRA     ZEBEF                    ; EBEB: 20 02          
                NOP                              ; EBED: 01             
                NOP                              ; EBEE: 01             
ZEBEF           BSR     LIST                     ; EBEF: 8D DB          
                INX                              ; EBF1: 08             
                LDAA    ,X                       ; EBF2: A6 00          
                CMPA    #$04                     ; EBF4: 81 04          
                BNE     ZEBEF                    ; EBF6: 26 F7          
                LDAA    #$1B                     ; EBF8: 86 1B          
                BSR     LIST                     ; EBFA: 8D D0          
                RTS                              ; EBFC: 39             
                FCB     $00                      ; EBFD: 00             
                FCB     $00                      ; EBFE: 00             
                FCB     $00                      ; EBFF: 00             


                END
