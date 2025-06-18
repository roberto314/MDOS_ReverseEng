dasmfw: Disassembler Framework V0.35
Loaded: binary file "floppy.bin"
Loaded: Info file "floppy.info"

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
M0007   EQU     $0007
M0008   EQU     $0008
M0009   EQU     $0009
M000A   EQU     $000A
M000B   EQU     $000B
M000D   EQU     $000D
M000E   EQU     $000E
M000F   EQU     $000F
M0011   EQU     $0011
M0012   EQU     $0012
M0013   EQU     $0013
M0014   EQU     $0014
M0015   EQU     $0015
M0016   EQU     $0016
M0017   EQU     $0017
M0018   EQU     $0018
M0019   EQU     $0019
M0020   EQU     $0020
M0022   EQU     $0022
M0024   EQU     $0024
M0029   EQU     $0029
M003C   EQU     $003C
M0404   EQU     $0404
M04E2   EQU     $04E2
M09C4   EQU     $09C4
M1B02   EQU     $1B02
M1F0F   EQU     $1F0F
M3C3E   EQU     $3C3E
M8210   EQU     $8210
M83F5   EQU     $83F5
M9711   EQU     $9711
MC0DA   EQU     $C0DA
MC1AA   EQU     $C1AA
MC270   EQU     $C270
MC631   EQU     $C631
MC634   EQU     $C634
MC636   EQU     $C636
MC637   EQU     $C637
MC639   EQU     $C639
MCEFF   EQU     $CEFF
MD0D8   EQU     $D0D8
MD0DA   EQU     $D0DA
MD1F5   EQU     $D1F5
MD270   EQU     $D270
dPIA_0  EQU     $EC00
dPIA_1  EQU     $EC01
dPIA_2  EQU     $EC02
SSDA_0  EQU     $EC04
SSDA_1  EQU     $EC05
MEC10   EQU     $EC10
MEC11   EQU     $EC11
MEC12   EQU     $EC12
MEC13   EQU     $EC13
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
MFF07   EQU     $FF07
XSTAK$  EQU     $FF8A
NMI$VC  EQU     $FFFC
MFFFF   EQU     $FFFF

;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $E800

                LDS     #XSTAK$                  ; E800: 8E FF 8A       
                BSR     FDINIT                   ; E803: 8D 1D          
                CLR     M0000                    ; E805: 7F 00 00       
                BSR     RESTOR                   ; E808: 8D 6B          
                BSR     CHKERR                   ; E80A: 8D 47          
                LDX     #M0017                   ; E80C: CE 00 17       
                STX     M0001                    ; E80F: DF 01          
                LDX     #M0002                   ; E811: CE 00 02       
                STX     M0003                    ; E814: DF 03          
                LDX     #M0020                   ; E816: CE 00 20       
                STX     M0006                    ; E819: DF 06          
                BSR     READSC                   ; E81B: 8D 4C          
                BSR     CHKERR                   ; E81D: 8D 34          
                JMP     M0020                    ; E81F: 7E 00 20       
FDINIT          LDX     #M0000                   ; E822: CE 00 00       
                STX     dPIA_2                   ; E825: FF EC 02       
                STX     dPIA_0                   ; E828: FF EC 00       
                LDX     #MD0DA                   ; E82B: CE D0 DA       
                STX     SSDA_0                   ; E82E: FF EC 04       
                LDX     #M0404                   ; E831: CE 04 04       
                STX     dPIA_2                   ; E834: FF EC 02       
                LDX     #M1B02                   ; E837: CE 1B 02       
                STX     dPIA_0                   ; E83A: FF EC 00       
                LDX     #M0000                   ; E83D: CE 00 00       
                STX     dPIA_2                   ; E840: FF EC 02       
                LDX     #M1F0F                   ; E843: CE 1F 0F       
                STX     dPIA_0                   ; E846: FF EC 00       
ZE849           LDX     #M3C3E                   ; E849: CE 3C 3E       
                STX     dPIA_2                   ; E84C: FF EC 02       
                LDX     dPIA_0                   ; E84F: FE EC 00       
ZE852           RTS                              ; E852: 39             
CHKERR          BCC     ZE852                    ; E853: 24 FD          
ZE855           BSR     PRNTER                   ; E855: 8D 03          
                JMP     REENT2                   ; E857: 7E F5 64       
PRNTER          LDAA    #$45                     ; E85A: 86 45          
                BSR     ZE866                    ; E85C: 8D 08          
                LDAA    M0008                    ; E85E: 96 08          
                BSR     ZE866                    ; E860: 8D 04          
                LDAA    #$20                     ; E862: 86 20          
                BSR     ZE866                    ; E864: 8D 00          
ZE866           JMP     XOUTCH                   ; E866: 7E F0 18       
READSC          LDAB    #$80                     ; E869: C6 80          
                STAB    M0005                    ; E86B: D7 05          
                CLRB                             ; E86D: 5F             
                FCB     $8C                      ; E86E: 8C             
                LDAB    #$40                     ; E86F: C6 40          
                FCB     $8C                      ; E871: 8C             
                LDAB    #$C2                     ; E872: C6 C2          
                FCB     $8C                      ; E874: 8C             
RESTOR          LDAB    #$08                     ; E875: C6 08          
                FCB     $8C                      ; E877: 8C             
                LDAB    #$10                     ; E878: C6 10          
                FCB     $8C                      ; E87A: 8C             
                LDAB    #$82                     ; E87B: C6 82          
                FCB     $8C                      ; E87D: 8C             
                LDAB    #$81                     ; E87E: C6 81          
                FCB     $8C                      ; E880: 8C             
                LDAB    #$C0                     ; E881: C6 C0          
                FCB     $8C                      ; E883: 8C             
                LDAB    #$80                     ; E884: C6 80          
                TPA                              ; E886: 07             
                SEI                              ; E887: 0F             
                STAA    M000D                    ; E888: 97 0D          
                STAB    M000E                    ; E88A: D7 0E          
                LDAA    #$30                     ; E88C: 86 30          
                STAA    M0008                    ; E88E: 97 08          
                STS     M0016                    ; E890: 9F 16          
                LDX     NMI$VC                   ; E892: FE FF FC       
                STX     M000F                    ; E895: DF 0F          
                LDX     #ME930                   ; E897: CE E9 30       
                STX     NMI$VC                   ; E89A: FF FF FC       
                LDX     #M0011                   ; E89D: CE 00 11       
                LDAA    dPIA_0                   ; E8A0: B6 EC 00       
                ORAA    #$03                     ; E8A3: 8A 03          
                DECA                             ; E8A5: 4A             
                TST     M0000                    ; E8A6: 7D 00 00       
                BEQ     ZE8AD                    ; E8A9: 27 02          
                INX                              ; E8AB: 08             
                DECA                             ; E8AC: 4A             
ZE8AD           STAA    dPIA_0                   ; E8AD: B7 EC 00       
                LDAA    ,X                       ; E8B0: A6 00          
                STAA    M0013                    ; E8B2: 97 13          
                LDAA    #$40                     ; E8B4: 86 40          
                BITA    dPIA_0                   ; E8B6: B5 EC 00       
                BEQ     ZE8C2                    ; E8B9: 27 07          
                LDAB    #$33                     ; E8BB: C6 33          
                CPX     #MC636                   ; E8BD: 8C C6 36       
                BRA     ZE937                    ; E8C0: 20 75          
ZE8C2           BITB    #$08                     ; E8C2: C5 08          
                BEQ     ZE8CB                    ; E8C4: 27 05          
                CLRA                             ; E8C6: 4F             
                LDAB    #$56                     ; E8C7: C6 56          
                BRA     ZE903                    ; E8C9: 20 38          
ZE8CB           LDAB    M0002                    ; E8CB: D6 02          
                LDAA    M0001                    ; E8CD: 96 01          
                ADDB    M0004                    ; E8CF: DB 04          
                ADCA    M0003                    ; E8D1: 99 03          
                BCS     ZE8BE                    ; E8D3: 25 E9          
                CMPB    #$D3                     ; E8D5: C1 D3          
                SBCA    #$07                     ; E8D7: 82 07          
                BCC     ZE8BE                    ; E8D9: 24 E3          
                LDAA    #$FF                     ; E8DB: 86 FF          
                STAA    M000A                    ; E8DD: 97 0A          
                LDAA    M0001                    ; E8DF: 96 01          
                LDAB    M0002                    ; E8E1: D6 02          
ZE8E3           INC     M000A                    ; E8E3: 7C 00 0A       
                SUBB    #$D0                     ; E8E6: C0 D0          
                SBCA    #$00                     ; E8E8: 82 00          
                BCC     ZE8E3                    ; E8EA: 24 F7          
                ADDB    #$D0                     ; E8EC: CB D0          
                LDAA    M000A                    ; E8EE: 96 0A          
                ASLA                             ; E8F0: 48             
                ASLA                             ; E8F1: 48             
                ASLA                             ; E8F2: 48             
                DECA                             ; E8F3: 4A             
ZE8F4           INCA                             ; E8F4: 4C             
                SUBB    #$1A                     ; E8F5: C0 1A          
                BCC     ZE8F4                    ; E8F7: 24 FB          
                ADDB    #$1A                     ; E8F9: CB 1A          
                STAB    M000A                    ; E8FB: D7 0A          
                LDX     M0003                    ; E8FD: DE 03          
                STX     M000B                    ; E8FF: DF 0B          
                LDAB    M0013                    ; E901: D6 13          
ZE903           STAA    M0013                    ; E903: 97 13          
                SBA                              ; E905: 10             
                STAA    M0019                    ; E906: 97 19          
                BCC     ZE90B                    ; E908: 24 01          
                NEGA                             ; E90A: 40             
ZE90B           LDAB    dPIA_0                   ; E90B: F6 EC 00       
                ANDB    #$EF                     ; E90E: C4 EF          
                CMPA    #$04                     ; E910: 81 04          
                BLS     ZE916                    ; E912: 23 02          
                ORAB    #$10                     ; E914: CA 10          
ZE916           STAB    dPIA_0                   ; E916: F7 EC 00       
                DECA                             ; E919: 4A             
                BMI     ZE964                    ; E91A: 2B 48          
                BSR     ZE93D                    ; E91C: 8D 1F          
                TST     dPIA_0                   ; E91E: 7D EC 00       
                BPL     ZE90B                    ; E921: 2A E8          
                TSTA                             ; E923: 4D             
                BEQ     ZE964                    ; E924: 27 3E          
                LDAA    M000E                    ; E926: 96 0E          
                BITA    #$08                     ; E928: 85 08          
                BEQ     ZE935                    ; E92A: 27 09          
                BSR     ZE95F                    ; E92C: 8D 31          
                BRA     ZE98A                    ; E92E: 20 5A          
ME930           LDS     M0016                    ; E930: 9E 16          
                LDAB    #$35                     ; E932: C6 35          
                CPX     #MC637                   ; E934: 8C C6 37       
ZE937           STAB    M0008                    ; E937: D7 08          
                BSR     ZE98A                    ; E939: 8D 4F          
                SEC                              ; E93B: 0D             
                RTS                              ; E93C: 39             
ZE93D           TST     M0019                    ; E93D: 7D 00 19       
                BPL     ZE94E                    ; E940: 2A 0C          
                LDAB    #$34                     ; E942: C6 34          
                STAB    dPIA_2                   ; E944: F7 EC 02       
                LDAB    #$3C                     ; E947: C6 3C          
                STAB    dPIA_2                   ; E949: F7 EC 02       
                BRA     ZE958                    ; E94C: 20 0A          
ZE94E           ANDB    #$F7                     ; E94E: C4 F7          
                STAB    dPIA_0                   ; E950: F7 EC 00       
                ORAB    #$08                     ; E953: CA 08          
                STAB    dPIA_0                   ; E955: F7 EC 00       
ZE958           LDX     #M04E2                   ; E958: CE 04 E2       
ZE95B           DEX                              ; E95B: 09             
                BNE     ZE95B                    ; E95C: 26 FD          
                RTS                              ; E95E: 39             
ZE95F           LDX     #M09C4                   ; E95F: CE 09 C4       
                BRA     ZE95B                    ; E962: 20 F7          
ZE964           BSR     ZE95F                    ; E964: 8D F9          
                BSR     ZE95F                    ; E966: 8D F7          
                LDAA    M000E                    ; E968: 96 0E          
                BITA    #$08                     ; E96A: 85 08          
                BNE     ZE935                    ; E96C: 26 C7          
                BITA    #$10                     ; E96E: 85 10          
                BNE     ZE98A                    ; E970: 26 18          
                LDAB    #$6F                     ; E972: C6 6F          
                RORA                             ; E974: 46             
                BCC     ZE979                    ; E975: 24 02          
                LDAB    #$6A                     ; E977: C6 6A          
ZE979           STAB    M0014                    ; E979: D7 14          
                BRA     ZE9D1                    ; E97B: 20 54          
ZE97D           LDAA    M000E                    ; E97D: 96 0E          
                BPL     ZE98A                    ; E97F: 2A 09          
                ANDA    #$40                     ; E981: 84 40          
                STAA    M000E                    ; E983: 97 0E          
                BEQ     ZE98A                    ; E985: 27 03          
                JMP     ZE8CB                    ; E987: 7E E8 CB       
ZE98A           LDAA    #$03                     ; E98A: 86 03          
                STAA    dPIA_1                   ; E98C: B7 EC 01       
                JSR     ZE849                    ; E98F: BD E8 49       
                LDX     M000F                    ; E992: DE 0F          
                STX     NMI$VC                   ; E994: FF FF FC       
                LDAA    M0013                    ; E997: 96 13          
                LDAB    M0000                    ; E999: D6 00          
                BEQ     ZE9A0                    ; E99B: 27 03          
                STAA    M0012                    ; E99D: 97 12          
                CPX     #M9711                   ; E99F: 8C 97 11       
                LDAA    M000D                    ; E9A2: 96 0D          
                TAP                              ; E9A4: 06             
                CLC                              ; E9A5: 0C             
                RTS                              ; E9A6: 39             
ZE9A7           LDX     #MD0D8                   ; E9A7: CE D0 D8       
                STX     SSDA_0                   ; E9AA: FF EC 04       
                LDX     #dPIA_0                  ; E9AD: CE EC 00       
                LDAA    #$50                     ; E9B0: 86 50          
                STAA    $04,X                    ; E9B2: A7 04          
                LDAA    #$07                     ; E9B4: 86 07          
                STAA    $01,X                    ; E9B6: A7 01          
                DEC     $01,X                    ; E9B8: 6A 01          
                INX                              ; E9BA: 08             
                DEX                              ; E9BB: 09             
                LDAA    #$40                     ; E9BC: 86 40          
                STAA    $04,X                    ; E9BE: A7 04          
                LDAA    #$98                     ; E9C0: 86 98          
                STAA    $05,X                    ; E9C2: A7 05          
                RTS                              ; E9C4: 39             
ZE9C5           INC     M0013                    ; E9C5: 7C 00 13       
                LDAB    dPIA_0                   ; E9C8: F6 EC 00       
                BSR     ZE94E                    ; E9CB: 8D 81          
                STAA    M000A                    ; E9CD: 97 0A          
                BSR     ZE95F                    ; E9CF: 8D 8E          
ZE9D1           INC     M000A                    ; E9D1: 7C 00 0A       
                LDAA    M000A                    ; E9D4: 96 0A          
                LDX     M000B                    ; E9D6: DE 0B          
                BEQ     ZE97D                    ; E9D8: 27 A3          
                SUBA    #$1B                     ; E9DA: 80 1B          
                BCC     ZE9C5                    ; E9DC: 24 E7          
                LDAA    #$05                     ; E9DE: 86 05          
                STAA    M0018                    ; E9E0: 97 18          
                DEX                              ; E9E2: 09             
ZE9E3           LDAA    #$40                     ; E9E3: 86 40          
                STX     M000B                    ; E9E5: DF 0B          
                BNE     ZE9F0                    ; E9E7: 26 07          
                LDAA    M0005                    ; E9E9: 96 05          
                ADDA    #$07                     ; E9EB: 8B 07          
                LSRA                             ; E9ED: 44             
                ANDA    #$FC                     ; E9EE: 84 FC          
ZE9F0           STAA    M0015                    ; E9F0: 97 15          
                NEGA                             ; E9F2: 40             
                LDAB    M000E                    ; E9F3: D6 0E          
                ASLB                             ; E9F5: 58             
                BPL     ZE9F9                    ; E9F6: 2A 01          
                CLRA                             ; E9F8: 4F             
ZE9F9           ADDA    #$40                     ; E9F9: 8B 40          
                STAA    M0009                    ; E9FB: 97 09          
                LDX     #dPIA_0                  ; E9FD: CE EC 00       
                LDAA    #$36                     ; EA00: 86 36          
                STAA    $03,X                    ; EA02: A7 03          
                LDAA    #$3E                     ; EA04: 86 3E          
                STAA    $03,X                    ; EA06: A7 03          
                LDAB    ,X                       ; EA08: E6 00          
                DECA                             ; EA0A: 4A             
                STAA    $02,X                    ; EA0B: A7 02          
                LDAA    M0013                    ; EA0D: 96 13          
                ORAB    #$04                     ; EA0F: CA 04          
                CMPA    #$2A                     ; EA11: 81 2A          
                BLS     ZEA17                    ; EA13: 23 02          
                ANDB    #$FB                     ; EA15: C4 FB          
ZEA17           STAB    ,X                       ; EA17: E7 00          
                LDX     #MD270                   ; EA19: CE D2 70       
                STX     SSDA_0                   ; EA1C: FF EC 04       
                LDX     #MD1F5                   ; EA1F: CE D1 F5       
                STX     SSDA_0                   ; EA22: FF EC 04       
ZEA25           BSR     ZE9A7                    ; EA25: 8D 80          
ZEA27           LDAA    $04,X                    ; EA27: A6 04          
                BPL     ZEA27                    ; EA29: 2A FC          
                LDAA    $05,X                    ; EA2B: A6 05          
                CMPA    #$7E                     ; EA2D: 81 7E          
                BNE     ZEA25                    ; EA2F: 26 F4          
ZEA31           LDAA    $04,X                    ; EA31: A6 04          
                BPL     ZEA31                    ; EA33: 2A FC          
                LDAA    $05,X                    ; EA35: A6 05          
                LDAB    $05,X                    ; EA37: E6 05          
                CMPA    M0013                    ; EA39: 91 13          
                BNE     ZEA25                    ; EA3B: 26 E8          
ZEA3D           LDAA    $04,X                    ; EA3D: A6 04          
                BPL     ZEA3D                    ; EA3F: 2A FC          
                LDAA    $05,X                    ; EA41: A6 05          
                LDAB    $05,X                    ; EA43: E6 05          
                CMPA    M000A                    ; EA45: 91 0A          
                BNE     ZEA25                    ; EA47: 26 DC          
ZEA49           LDAA    $04,X                    ; EA49: A6 04          
                BPL     ZEA49                    ; EA4B: 2A FC          
                LDAA    $05,X                    ; EA4D: A6 05          
                LDAA    $05,X                    ; EA4F: A6 05          
                INCA                             ; EA51: 4C             
                INX                              ; EA52: 08             
                LDAA    ,X                       ; EA53: A6 00          
                BMI     ZEA81                    ; EA55: 2B 2A          
                LDAB    M000E                    ; EA57: D6 0E          
                BMI     ZEACE                    ; EA59: 2B 73          
                LDX     #M0029                   ; EA5B: CE 00 29       
ZEA5E           DEX                              ; EA5E: 09             
                BNE     ZEA5E                    ; EA5F: 26 FD          
                LDAB    #$04                     ; EA61: C6 04          
ZEA63           JSR     ZE9A7                    ; EA63: BD E9 A7       
                LDX     M0006                    ; EA66: DE 06          
ZEA68           LDAA    SSDA_0                   ; EA68: B6 EC 04       
                BPL     ZEA68                    ; EA6B: 2A FB          
                LDAA    SSDA_1                   ; EA6D: B6 EC 05       
                CMPA    #$6F                     ; EA70: 81 6F          
                BEQ     ZEA95                    ; EA72: 27 21          
                CMPA    #$6A                     ; EA74: 81 6A          
                BEQ     ZEA90                    ; EA76: 27 18          
                DECB                             ; EA78: 5A             
                BNE     ZEA63                    ; EA79: 26 E8          
                LDAB    #$38                     ; EA7B: C6 38          
                CPX     #MC631                   ; EA7D: 8C C6 31       
                CPX     #MC639                   ; EA80: 8C C6 39       
                DEC     M0018                    ; EA83: 7A 00 18       
                BEQ     ZEA92                    ; EA86: 27 0A          
                LDX     M000B                    ; EA88: DE 0B          
                JMP     ZE9E3                    ; EA8A: 7E E9 E3       
ZEA8D           LDAB    #$32                     ; EA8D: C6 32          
                CPX     #MC634                   ; EA8F: 8C C6 34       
ZEA92           JMP     ZE937                    ; EA92: 7E E9 37       
ZEA95           LDAB    M000E                    ; EA95: D6 0E          
                ASLB                             ; EA97: 58             
                BMI     ZEAB0                    ; EA98: 2B 16          
                LDAB    M0015                    ; EA9A: D6 15          
ZEA9C           LDAA    SSDA_0                   ; EA9C: B6 EC 04       
                BPL     ZEA9C                    ; EA9F: 2A FB          
                LDAA    SSDA_1                   ; EAA1: B6 EC 05       
                STAA    ,X                       ; EAA4: A7 00          
                LDAA    SSDA_1                   ; EAA6: B6 EC 05       
                STAA    $01,X                    ; EAA9: A7 01          
                INX                              ; EAAB: 08             
                INX                              ; EAAC: 08             
                DECB                             ; EAAD: 5A             
                BNE     ZEA9C                    ; EAAE: 26 EC          
ZEAB0           LDAA    SSDA_0                   ; EAB0: B6 EC 04       
                BPL     ZEAB0                    ; EAB3: 2A FB          
                LDAA    SSDA_1                   ; EAB5: B6 EC 05       
                LDAA    SSDA_1                   ; EAB8: B6 EC 05       
                LDAB    M0009                    ; EABB: D6 09          
                BEQ     ZEAC4                    ; EABD: 27 05          
                DEC     M0009                    ; EABF: 7A 00 09       
                BRA     ZEAB0                    ; EAC2: 20 EC          
ZEAC4           LDAA    dPIA_1                   ; EAC4: B6 EC 01       
                BMI     ZEA7E                    ; EAC7: 2B B5          
                STX     M0006                    ; EAC9: DF 06          
                JMP     ZE9D1                    ; EACB: 7E E9 D1       
ZEACE           LDAA    #$04                     ; EACE: 86 04          
ZEAD0           TST     SSDA_0                   ; EAD0: 7D EC 04       
                BPL     ZEAD0                    ; EAD3: 2A FB          
                CMPA    SSDA_1                   ; EAD5: B1 EC 05       
                CMPA    SSDA_1                   ; EAD8: B1 EC 05       
                DECA                             ; EADB: 4A             
                BNE     ZEAD0                    ; EADC: 26 F2          
                LDX     #MC0DA                   ; EADE: CE C0 DA       
                STX     SSDA_0                   ; EAE1: FF EC 04       
                LDX     #MC1AA                   ; EAE4: CE C1 AA       
                STX     SSDA_0                   ; EAE7: FF EC 04       
                LDX     #MC270                   ; EAEA: CE C2 70       
                STX     SSDA_0                   ; EAED: FF EC 04       
                INC     dPIA_1                   ; EAF0: 7C EC 01       
                LDAA    #$82                     ; EAF3: 86 82          
                STAA    dPIA_1                   ; EAF5: B7 EC 01       
                STAA    SSDA_0                   ; EAF8: B7 EC 04       
                LDAA    #$10                     ; EAFB: 86 10          
                BITA    dPIA_1                   ; EAFD: B5 EC 01       
                BNE     ZEA8D                    ; EB00: 26 8B          
                RORB                             ; EB02: 56             
                BCC     ZEB06                    ; EB03: 24 01          
                BITA    #$56                     ; EB05: 85 56          
                NOP                              ; EB07: 01             
                LDAA    #$00                     ; EB08: 86 00          
                LDAB    #$06                     ; EB0A: C6 06          
                STAA    dPIA_1                   ; EB0C: B7 EC 01       
                LDAA    #$08                     ; EB0F: 86 08          
                LDX     #M8210                   ; EB11: CE 82 10       
                STX     SSDA_0                   ; EB14: FF EC 04       
ZEB17           BITA    SSDA_0                   ; EB17: B5 EC 04       
                BEQ     ZEB17                    ; EB1A: 27 FB          
                STX     SSDA_0                   ; EB1C: FF EC 04       
                DECB                             ; EB1F: 5A             
                BNE     ZEB17                    ; EB20: 26 F5          
                LDAB    #$40                     ; EB22: C6 40          
                LDAA    M0014                    ; EB24: 96 14          
                LDX     #M83F5                   ; EB26: CE 83 F5       
                STX     SSDA_0                   ; EB29: FF EC 04       
                LDX     M0006                    ; EB2C: DE 06          
                STAA    SSDA_1                   ; EB2E: B7 EC 05       
                JMP     ZEB3B                    ; EB31: 7E EB 3B       
ZEB34           LDAA    #$40                     ; EB34: 86 40          
ZEB36           BITA    SSDA_0                   ; EB36: B5 EC 04       
                BEQ     ZEB36                    ; EB39: 27 FB          
ZEB3B           LDAA    ,X                       ; EB3B: A6 00          
                STAA    SSDA_1                   ; EB3D: B7 EC 05       
                LDAA    $01,X                    ; EB40: A6 01          
                STAA    SSDA_1                   ; EB42: B7 EC 05       
                BCS     ZEB49                    ; EB45: 25 02          
                INX                              ; EB47: 08             
                INX                              ; EB48: 08             
ZEB49           DECB                             ; EB49: 5A             
                BNE     ZEB34                    ; EB4A: 26 E8          
                STX     M0006                    ; EB4C: DF 06          
                LDAA    #$40                     ; EB4E: 86 40          
ZEB50           BITA    SSDA_0                   ; EB50: B5 EC 04       
                BEQ     ZEB50                    ; EB53: 27 FB          
                STAB    SSDA_1                   ; EB55: F7 EC 05       
ZEB58           BITA    SSDA_0                   ; EB58: B5 EC 04       
                BEQ     ZEB58                    ; EB5B: 27 FB          
                LDAB    #$08                     ; EB5D: C6 08          
                STAB    dPIA_1                   ; EB5F: F7 EC 01       
                STAB    SSDA_1                   ; EB62: F7 EC 05       
ZEB65           BITA    SSDA_0                   ; EB65: B5 EC 04       
                BEQ     ZEB65                    ; EB68: 27 FB          
                LDAB    #$FF                     ; EB6A: C6 FF          
                STAB    SSDA_1                   ; EB6C: F7 EC 05       
                STAB    SSDA_1                   ; EB6F: F7 EC 05       
ZEB72           BITA    SSDA_0                   ; EB72: B5 EC 04       
                BEQ     ZEB72                    ; EB75: 27 FB          
                CLR     dPIA_1                   ; EB77: 7F EC 01       
                INC     dPIA_1                   ; EB7A: 7C EC 01       
                INC     dPIA_1                   ; EB7D: 7C EC 01       
                LDX     #M003C                   ; EB80: CE 00 3C       
ZEB83           DEX                              ; EB83: 09             
                BNE     ZEB83                    ; EB84: 26 FD          
                JMP     ZE9D1                    ; EB86: 7E E9 D1       

                ORG     $EB90

                LDX     #M0014                   ; EB90: CE 00 14       
ZEB93           CLR     $5F,X                    ; EB93: 6F 5F          
                DEX                              ; EB95: 09             
                BNE     ZEB93                    ; EB96: 26 FB          
                JSR     FDINIT                   ; EB98: BD E8 22       
                JSR     RESTOR                   ; EB9B: BD E8 75       
ZEB9E           LDX     M0020                    ; EB9E: DE 20          
                STX     M0006                    ; EBA0: DF 06          
                LDX     M0022                    ; EBA2: DE 22          
                JSR     ,X                       ; EBA4: AD 00          
                LDAA    M0024                    ; EBA6: 96 24          
                BNE     ZEBB9                    ; EBA8: 26 0F          
                STAA    M0007                    ; EBAA: 97 07          
                ASL     M0008                    ; EBAC: 78 00 08       
                LDX     M0007                    ; EBAF: DE 07          
                INC     $01,X                    ; EBB1: 6C 01          
                BNE     ZEB9E                    ; EBB3: 26 E9          
                INC     ,X                       ; EBB5: 6C 00          
                BNE     ZEB9E                    ; EBB7: 26 E5          
ZEBB9           JMP     ZE855                    ; EBB9: 7E E8 55       
                STX     MFFFF                    ; EBBC: FF FF FF       
                STX     MCEFF                    ; EBBF: FF CE FF       
                BGT     ZEBC3                    ; EBC2: 2E FF          
                FCB     $EC                      ; EBC4: EC             
                SBA                              ; EBC5: 10             
                LDAA    #$3C                     ; EBC6: 86 3C          
                STAA    MEC13                    ; EBC8: B7 EC 13       
                RTS                              ; EBCB: 39             
LIST            STAA    MEC10                    ; EBCC: B7 EC 10       
                LDAA    MEC10                    ; EBCF: B6 EC 10       
ZEBD2           PSHB                             ; EBD2: 37             
                LDAB    MEC12                    ; EBD3: F6 EC 12       
                ANDB    #$03                     ; EBD6: C4 03          
                DECB                             ; EBD8: 5A             
                PULB                             ; EBD9: 33             
                BNE     ZEBE2                    ; EBDA: 26 06          
                TST     MEC11                    ; EBDC: 7D EC 11       
                BPL     ZEBD2                    ; EBDF: 2A F1          
                RTS                              ; EBE1: 39             
ZEBE2           SEC                              ; EBE2: 0D             
                RTS                              ; EBE3: 39             
                LDAA    #$0D                     ; EBE4: 86 0D          
ZEBE6           BSR     LIST                     ; EBE6: 8D E4          
                BCS     ZEBE6                    ; EBE8: 25 FC          
                LDAA    #$0A                     ; EBEA: 86 0A          
                DEX                              ; EBEC: 09             
ZEBED           BSR     LIST                     ; EBED: 8D DD          
                BCS     ZEBED                    ; EBEF: 25 FC          
                INX                              ; EBF1: 08             
                LDAA    ,X                       ; EBF2: A6 00          
                CMPA    #$04                     ; EBF4: 81 04          
                BNE     ZEBED                    ; EBF6: 26 F5          
                RTS                              ; EBF8: 39             
                STX     MFFFF                    ; EBF9: FF FF FF       
                STX     MFF07                    ; EBFC: FF FF 07       
                NEGB                             ; EBFF: 50             


                END
