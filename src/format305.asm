dasmfw: Disassembler Framework V0.35
Loaded: binary file "format305.sy"
Loaded: Info file "format305.info"

;****************************************************
; Used Labels
;****************************************************

CURDRV  EQU     $0000
STRSCTH EQU     $0001
STRSCTL EQU     $0002
NUMSCTH EQU     $0003
NUMSCTL EQU     $0004
CURADRH EQU     $0006
FDSTAT  EQU     $0008
SECTCNT EQU     $000B
M000C   EQU     $000C
M001A   EQU     $001A
LDADDRH EQU     $0020
LDADDRL EQU     $0021
TRKNOW  EQU     $0022
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
M0030   EQU     $0030
M0034   EQU     $0034
M004C   EQU     $004C
M00FE   EQU     $00FE
M01BD   EQU     $01BD
FDINIT  EQU     $E822
RWTEST  EQU     $E872
RESTOR  EQU     $E875
SEEK    EQU     $E878
MEBFE   EQU     $EBFE
MEBFF   EQU     $EBFF
PIAREGA EQU     $EC00
PIAREGB EQU     $EC01
PIACTRLA EQU    $EC02
PIACTRLB EQU    $EC03
SSDA_0  EQU     $EC04
SSDA_1  EQU     $EC05
ZF018   EQU     $F018
MFFCC   EQU     $FFCC
MFFE6   EQU     $FFE6
NMIsVC  EQU     $FFFC

;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $2000

; This Version is pretty much the same as 300.
; There are some patches from $2350

M2000           FCC     ' 303'                   ; 2000: 20 33 30 33 ; Version 
M2004           FDB     $E5E5                    ; 2004: E5 E5       ; Data written to disk 
FORMATSTART     STS     M0027                    ; 2006: 9F 27       ;  
                LDAA    MEBFF                    ; 2008: B6 EB FF    ; Get some kind of Disk EPROM Version 
                CMPA    #$45                     ; 200B: 81 45       ; is it $45 
                BNE     Z201D                    ; 200D: 26 0E       ;  
                LDAB    #$0A                     ; 200F: C6 0A       ; yes, print error "INVALID DEVICE" 
Z2011           SCALL   MDERR1                   ; 2011: 3F          ;  
                SCALL   MDENT1                   ; 2012: 20          ; bail 
SERRB           LDAB    #$0B                     ; 2015: C6 0B       ; 
                BRA     Z2011                    ; 2017: 20 F8       ; 
;------------------------------------------------
Z2019           LDAB    #$04                     ; 2019: C6 04       ; 
                BRA     Z2011                    ; 201B: 20 F4       ; 
;------------------------------------------------
Z201D           CLRB                             ; 201D: 5F          ; 
                CMPA    #$43                     ; 201E: 81 43       ; 
                BEQ     Z2024                    ; 2020: 27 02       ; 
                LDAB    #$10                     ; 2022: C6 10       ; 
Z2024           STAB    ONECONH                  ; 2024: D7 24       ; 
                LDAA    #$31                     ; 2026: 86 31       ; 
                STAA    M232F                    ; 2028: B7 23 2F    ; 
                LDX     M00FE                    ; 202B: DE FE       ; 
                STX     M233A                    ; 202D: FF 23 3A    ; 
                LDX     #M232F                   ; 2030: CE 23 2F    ; 
                STX     M233C                    ; 2033: FF 23 3C    ; 
                LDX     #M233A                   ; 2036: CE 23 3A    ; 
                SWI                              ; 2039: 3F          ; 
                FCB     $1D                      ; 203A: 1D          ; 
                LDAA    #$20                     ; 203B: 86 20       ; 
                CMPA    M2330                    ; 203D: B1 23 30    ; 
                BNE     SERRB                    ; 2040: 26 D3       ; 
                CMPA    M2338                    ; 2042: B1 23 38    ; 
                BNE     SERRB                    ; 2045: 26 CE       ; 
                LDAB    M232F                    ; 2047: F6 23 2F    ; 
                CMPB    #$30                     ; 204A: C1 30       ; 
                BLE     Z2019                    ; 204C: 2F CB       ; 
                CMPB    #$33                     ; 204E: C1 33       ; 
                BGT     Z2019                    ; 2050: 2E C7       ; 
                STAB    M234B                    ; 2052: F7 23 4B    ; 
                LDX     #M233E                   ; 2055: CE 23 3E    ; 
                SWI                              ; 2058: 3F          ; 
                FCB     $0A                      ; 2059: 0A          ; 
                LDX     #STORAGE                 ; 205A: CE 23 4E    ; 
                LDAB    #$01                     ; 205D: C6 01       ; 
                SWI                              ; 205F: 3F          ; 
                FCB     $09                      ; 2060: 09          ; 
                LDAA    STORAGE                  ; 2061: B6 23 4E    ; 
                CMPA    #$59                     ; 2064: 81 59       ; 
                BEQ     Z206A                    ; 2066: 27 02       ; 
                SWI                              ; 2068: 3F          ; 
                FCB     $1A                      ; 2069: 1A          ; 
Z206A           LDAB    M234B                    ; 206A: F6 23 4B    ; 
                ANDB    #$0F                     ; 206D: C4 0F       ; 
                STAB    CURDRV                   ; 206F: D7 00       ; 
                LDX     #M004C                   ; 2071: CE 00 4C    ; 
                STX     LDADDRH                  ; 2074: DF 20       ; 
                LDX     #FORMATSTART             ; 2076: CE 20 06    ; 
                STX     M002E                    ; 2079: DF 2E       ; 
                LDX     #M2004                   ; 207B: CE 20 04    ; 
                STX     CURADRH                  ; 207E: DF 06       ; 
                JSR     FDINIT                   ; 2080: BD E8 22    ; 
                LDAA    CURDRV                   ; 2083: 96 00       ; 
                LDAB    #$66                     ; 2085: C6 66       ; 
                LSRA                             ; 2087: 44          ; 
                BEQ     Z208C                    ; 2088: 27 02       ; 
                LDAB    #$46                     ; 208A: C6 46       ; 
Z208C           STAB    PIAREGB                  ; 208C: F7 EC 01    ; 
                LDAB    #$02                     ; 208F: C6 02       ; 
                BCC     Z2094                    ; 2091: 24 01       ; 
                LSRB                             ; 2093: 54          ; 
Z2094           JSR     Z2350                    ; 2094: BD 23 50    ; 
                TST     ONECONH                  ; 2097: 7D 00 24    ; 
                BNE     Z20A7                    ; 209A: 26 0B       ; 
                LDAA    MEBFE                    ; 209C: B6 EB FE    ; 
                CMPA    #$11                     ; 209F: 81 11       ; 
                BEQ     Z20A7                    ; 20A1: 27 04       ; 
                CMPA    #$12                     ; 20A3: 81 12       ; 
                BNE     Z20AB                    ; 20A5: 26 04       ; 
Z20A7           LDAA    #$FF                     ; 20A7: 86 FF       ; 
                BRA     Z20B0                    ; 20A9: 20 05       ; 
;------------------------------------------------
Z20AB           LDAA    PIAREGA                  ; 20AB: B6 EC 00    ; 
                ASLA                             ; 20AE: 48          ; 
                ASLA                             ; 20AF: 48          ; 
Z20B0           STAA    M002C                    ; 20B0: 97 2C       ; 
                BCC     Z20BA                    ; 20B2: 24 06       ; 
                LDAA    #$33                     ; 20B4: 86 33       ; 
                STAA    FDSTAT                   ; 20B6: 97 08       ; 
                BRA     Z210A                    ; 20B8: 20 50       ; 
;------------------------------------------------
Z20BA           LDX     #M001A                   ; 20BA: CE 00 1A    ; 
                LDAA    M002C                    ; 20BD: 96 2C       ; 
                BMI     Z20C4                    ; 20BF: 2B 03       ; 
                LDX     #M0034                   ; 20C1: CE 00 34    ; 
Z20C4           STX     NUMSCTH                  ; 20C4: DF 03       ; 
                JSR     Z22B0                    ; 20C6: BD 22 B0    ; 
                LDAB    $01,X                    ; 20C9: E6 01       ; 
                CLRA                             ; 20CB: 4F          ; 
Z20CC           LDAB    $03,X                    ; 20CC: E6 03       ; 
                BPL     Z20CC                    ; 20CE: 2A FC       ; 
                LDAB    $01,X                    ; 20D0: E6 01       ; 
Z20D2           CLRB                             ; 20D2: 5F          ; 
Z20D3           DECB                             ; 20D3: 5A          ; 
                BNE     Z20D3                    ; 20D4: 26 FD       ; 
                INCA                             ; 20D6: 4C          ; 
                TST     $03,X                    ; 20D7: 6D 03       ; 
                BPL     Z20D2                    ; 20D9: 2A F7       ; 
                INCB                             ; 20DB: 5C          ; 
                SUBA    #$4B                     ; 20DC: 80 4B       ; 
Z20DE           INCB                             ; 20DE: 5C          ; 
                SUBA    #$16                     ; 20DF: 80 16       ; 
                BCC     Z20DE                    ; 20E1: 24 FB       ; 
                STAB    M0029                    ; 20E3: D7 29       ; 
                LSRB                             ; 20E5: 54          ; 
                STAB    M002A                    ; 20E6: D7 2A       ; 
                LDAA    #$03                     ; 20E8: 86 03       ; 
                STAA    $01,X                    ; 20EA: A7 01       ; 
                JSR     Z22D0                    ; 20EC: BD 22 D0    ; 
                JSR     RESTOR                   ; 20EF: BD E8 75    ; 
                BCC     Z2117                    ; 20F2: 24 23       ; 
Z20F4           LDAB    STRSCTH                  ; 20F4: D6 01       ; 
                LDAA    STRSCTL                  ; 20F6: 96 02       ; 
                ADDA    NUMSCTL                  ; 20F8: 9B 04       ; 
                ADCB    NUMSCTH                  ; 20FA: D9 03       ; 
                SUBA    M000C                    ; 20FC: 90 0C       ; 
                SBCB    SECTCNT                  ; 20FE: D2 0B       ; 
                SUBA    #$01                     ; 2100: 80 01       ; 
                SBCB    #$00                     ; 2102: C2 00       ; 
Z2104           STAA    STRSCTL                  ; 2104: 97 02       ; 
                STAB    STRSCTH                  ; 2106: D7 01       ; 
                LDAA    FDSTAT                   ; 2108: 96 08       ; 
Z210A           STAA    M002D                    ; 210A: 97 2D       ; 
Z210C           LDAB    #$01                     ; 210C: C6 01       ; 
                LDX     #M002D                   ; 210E: CE 00 2D    ; 
                SWI                              ; 2111: 3F          ; 
                FCB     $20                      ; 2112: 20          ; 
                BCS     Z210C                    ; 2113: 25 F7       ; 
                SWI                              ; 2115: 3F          ; 
                FCB     $1A                      ; 2116: 1A          ; 
Z2117           LDAA    M0029                    ; 2117: 96 29       ; 
                SUBA    #$04                     ; 2119: 80 04       ; 
                BCS     Z2132                    ; 211B: 25 15       ; 
                SUBA    #$03                     ; 211D: 80 03       ; 
                BCC     Z2126                    ; 211F: 24 05       ; 
                LDX     #M2000                   ; 2121: CE 20 00    ; 
                BRA     Z212F                    ; 2124: 20 09       ; 
;------------------------------------------------
Z2126           LDX     #M22AB                   ; 2126: CE 22 AB    ; 
                STX     M21F0                    ; 2129: FF 21 F0    ; 
                LDX     #M01BD                   ; 212C: CE 01 BD    ; 
Z212F           STX     M21EE                    ; 212F: FF 21 EE    ; 
Z2132           LDAA    LDADDRH                  ; 2132: 96 20       ; 
                STAA    TRKNOW                   ; 2134: 97 22       ; 
                LDX     #MFFE6                   ; 2136: CE FF E6    ; 
                TST     M002C                    ; 2139: 7D 00 2C    ; 
                BMI     Z2141                    ; 213C: 2B 03       ; 
                LDX     #MFFCC                   ; 213E: CE FF CC    ; 
Z2141           STX     STRSCTH                  ; 2141: DF 01       ; 
Z2143           LDAB    STRSCTL                  ; 2143: D6 02       ; 
                ADDB    NUMSCTL                  ; 2145: DB 04       ; 
                STAB    STRSCTL                  ; 2147: D7 02       ; 
                LDAB    STRSCTH                  ; 2149: D6 01       ; 
                ADCB    #$00                     ; 214B: C9 00       ; 
                STAB    STRSCTH                  ; 214D: D7 01       ; 
                DECA                             ; 214F: 4A          ; 
                BPL     Z2143                    ; 2150: 2A F1       ; 
                JMP     Z236D                    ; 2152: 7E 23 6D    ; 
Z2155           BCS     Z20F4                    ; 2155: 25 9D       ; 
                LDAA    ONECONH                  ; 2157: 96 24       ; 
                LSRA                             ; 2159: 44          ; 
                LSRA                             ; 215A: 44          ; 
                LSRA                             ; 215B: 44          ; 
                LSRA                             ; 215C: 44          ; 
                ADDA    TRKNOW                   ; 215D: 9B 22       ; 
                LDAB    PIAREGA                  ; 215F: F6 EC 00    ; 
                ORAB    #$04                     ; 2162: CA 04       ; 
                CMPA    #$2B                     ; 2164: 81 2B       ; 
                BLS     Z216A                    ; 2166: 23 02       ; 
                ANDB    #$FB                     ; 2168: C4 FB       ; 
Z216A           STAB    PIAREGA                  ; 216A: F7 EC 00    ; 
                LDAA    #$01                     ; 216D: 86 01       ; 
                STAA    EXADDRL                  ; 216F: 97 23       ; 
                LDAA    PIAREGB                  ; 2171: B6 EC 01    ; 
                ORAA    #$40                     ; 2174: 8A 40       ; 
Z2176           STAA    PIAREGB                  ; 2176: B7 EC 01    ; 
                JSR     Z22B0                    ; 2179: BD 22 B0    ; 
                LDAB    #$27                     ; 217C: C6 27       ; 
                LDAA    M002A                    ; 217E: 96 2A       ; 
Z2180           DECA                             ; 2180: 4A          ; 
                BNE     Z2180                    ; 2181: 26 FD       ; 
                LDX     #$C0DA                   ; 2183: CE C0 DA    ; 
                STX     SSDA_0                   ; 2186: FF EC 04    ; 
                LDX     #$C1FF                   ; 2189: CE C1 FF    ; 
                STX     SSDA_0                   ; 218C: FF EC 04    ; 
                LDX     #$8270                   ; 218F: CE 82 70    ; 
                STX     SSDA_0                   ; 2192: FF EC 04    ; 
                LDAA    PIAREGB                  ; 2195: B6 EC 01    ; 
                ANDA    #$F2                     ; 2198: 84 F2       ; 
                STAA    PIAREGB                  ; 219A: B7 EC 01    ; 
                EORA    ONECONH                  ; 219D: 98 24       ; 
                BITA    #$10                     ; 219F: 85 10       ; 
                BNE     Z21AD                    ; 21A1: 26 0A       ; 
                JSR     Z22D0                    ; 21A3: BD 22 D0    ; 
                LDAA    #$32                     ; 21A6: 86 32       ; 
                STAA    FDSTAT                   ; 21A8: 97 08       ; 
                JMP     Z210A                    ; 21AA: 7E 21 0A    ; 
Z21AD           ANDA    #$60                     ; 21AD: 84 60       ; 
                STAA    PIAREGB                  ; 21AF: B7 EC 01    ; 
Z21B2           LDAA    PIACTRLB                 ; 21B2: B6 EC 03    ; 
                BPL     Z21B2                    ; 21B5: 2A FB       ; 
                LDX     #$8210                   ; 21B7: CE 82 10    ; 
                STX     SSDA_0                   ; 21BA: FF EC 04    ; 
                JSR     Z22E2                    ; 21BD: BD 22 E2    ; 
                LDX     #$83F7                   ; 21C0: CE 83 F7    ; 
                STX     SSDA_0                   ; 21C3: FF EC 04    ; 
                LDAA    #$7A                     ; 21C6: 86 7A       ; 
                STAA    SSDA_1                   ; 21C8: B7 EC 05    ; 
                LDX     #$81FF                   ; 21CB: CE 81 FF    ; 
                STX     SSDA_0                   ; 21CE: FF EC 04    ; 
                LDAB    #$17                     ; 21D1: C6 17       ; 
Z21D3           LDAA    #$18                     ; 21D3: 86 18       ; 
                LDX     #$8210                   ; 21D5: CE 82 10    ; 
                STX     SSDA_0                   ; 21D8: FF EC 04    ; 
Z21DB           BITA    SSDA_0                   ; 21DB: B5 EC 04    ; 
                BEQ     Z21DB                    ; 21DE: 27 FB       ; 
                STAA    SSDA_1                   ; 21E0: B7 EC 05    ; 
Z21E3           BITA    SSDA_0                   ; 21E3: B5 EC 04    ; 
                BEQ     Z21E3                    ; 21E6: 27 FB       ; 
                LDX     #$C270                   ; 21E8: CE C2 70    ; 
                STX     SSDA_0                   ; 21EB: FF EC 04    ; 
M21EE           BITA    #$00                     ; 21EE: 85 00       ; 
M21F0           LDAA    #$82                     ; 21F0: 86 82       ; 
                INC     PIAREGB                  ; 21F2: 7C EC 01    ; 
                DEC     PIAREGB                  ; 21F5: 7A EC 01    ; 
                STAA    SSDA_0                   ; 21F8: B7 EC 04    ; 
                JSR     Z22E2                    ; 21FB: BD 22 E2    ; 
                LDX     #$83F5                   ; 21FE: CE 83 F5    ; 
                STX     SSDA_0                   ; 2201: FF EC 04    ; 
                LDAB    #$7E                     ; 2204: C6 7E       ; 
                LDAA    #$40                     ; 2206: 86 40       ; 
                STAB    SSDA_1                   ; 2208: F7 EC 05    ; 
Z220B           BITA    SSDA_0                   ; 220B: B5 EC 04    ; 
                BEQ     Z220B                    ; 220E: 27 FB       ; 
                LDAB    TRKNOW                   ; 2210: D6 22       ; 
                STAB    SSDA_1                   ; 2212: F7 EC 05    ; 
                CLRB                             ; 2215: 5F          ; 
                STAB    SSDA_1                   ; 2216: F7 EC 05    ; 
Z2219           BITA    SSDA_0                   ; 2219: B5 EC 04    ; 
                BEQ     Z2219                    ; 221C: 27 FB       ; 
                LDAB    EXADDRL                  ; 221E: D6 23       ; 
                STAB    SSDA_1                   ; 2220: F7 EC 05    ; 
                CLRB                             ; 2223: 5F          ; 
                STAB    SSDA_1                   ; 2224: F7 EC 05    ; 
Z2227           BITA    SSDA_0                   ; 2227: B5 EC 04    ; 
                BEQ     Z2227                    ; 222A: 27 FB       ; 
                STAB    SSDA_1                   ; 222C: F7 EC 05    ; 
Z222F           BITA    SSDA_0                   ; 222F: B5 EC 04    ; 
                BEQ     Z222F                    ; 2232: 27 FB       ; 
                LDAB    PIAREGB                  ; 2234: F6 EC 01    ; 
                ORAB    #$08                     ; 2237: CA 08       ; 
                STAB    PIAREGB                  ; 2239: F7 EC 01    ; 
                STAB    SSDA_1                   ; 223C: F7 EC 05    ; 
Z223F           BITA    SSDA_0                   ; 223F: B5 EC 04    ; 
                BEQ     Z223F                    ; 2242: 27 FB       ; 
                LDAA    #$FF                     ; 2244: 86 FF       ; 
                STAA    SSDA_1                   ; 2246: B7 EC 05    ; 
                LDAA    #$40                     ; 2249: 86 40       ; 
Z224B           BITA    SSDA_0                   ; 224B: B5 EC 04    ; 
                BEQ     Z224B                    ; 224E: 27 FB       ; 
                ANDB    #$60                     ; 2250: C4 60       ; 
                STAB    PIAREGB                  ; 2252: F7 EC 01    ; 
                LDX     #$81FF                   ; 2255: CE 81 FF    ; 
                STX     SSDA_0                   ; 2258: FF EC 04    ; 
                LDAB    #$AC                     ; 225B: C6 AC       ; 
                LDAA    EXADDRL                  ; 225D: 96 23       ; 
                INCA                             ; 225F: 4C          ; 
                STAA    EXADDRL                  ; 2260: 97 23       ; 
                CMPA    #$1B                     ; 2262: 81 1B       ; 
                BEQ     Z226D                    ; 2264: 27 07       ; 
                CMPA    #$35                     ; 2266: 81 35       ; 
                BEQ     Z226D                    ; 2268: 27 03       ; 
                JMP     Z21D3                    ; 226A: 7E 21 D3    ; 
Z226D           LDAA    PIACTRLB                 ; 226D: B6 EC 03    ; 
                BPL     Z226D                    ; 2270: 2A FB       ; 
                DEC     PIAREGB                  ; 2272: 7A EC 01    ; 
                DEC     PIAREGB                  ; 2275: 7A EC 01    ; 
                BSR     Z22D0                    ; 2278: 8D 56       ; 
                LDAA    EXADDRL                  ; 227A: 96 23       ; 
                CMPA    #$1B                     ; 227C: 81 1B       ; 
                BNE     Z2289                    ; 227E: 26 09       ; 
                LDAA    M002C                    ; 2280: 96 2C       ; 
                BMI     Z2289                    ; 2282: 2B 05       ; 
                JMP     Z2356                    ; 2284: 7E 23 56    ; 
                FCB     $21                      ; 2287: 21          ; 
                FCB     $76                      ; 2288: 76          ; 
Z2289           JSR     RWTEST                   ; 2289: BD E8 72    ; 
                BCC     Z2291                    ; 228C: 24 03       ; 
                JMP     Z2377                    ; 228E: 7E 23 77    ; 
Z2291           LDAA    STRSCTL                  ; 2291: 96 02       ; 
                LDAB    STRSCTH                  ; 2293: D6 01       ; 
                ADDA    NUMSCTL                  ; 2295: 9B 04       ; 
                ADCB    #$00                     ; 2297: C9 00       ; 
                STAA    STRSCTL                  ; 2299: 97 02       ; 
                STAB    STRSCTH                  ; 229B: D7 01       ; 
                INC     TRKNOW                   ; 229D: 7C 00 22    ; 
                LDAA    LDADDRL                  ; 22A0: 96 21       ; 
                CMPA    TRKNOW                   ; 22A2: 91 22       ; 
                JMP     Z2360                    ; 22A4: 7E 23 60    ; 
                FCB     $21                      ; 22A7: 21          ; 
                FCB     $52                      ; 22A8: 52          ; 
                SWI                              ; 22A9: 3F          ; 
                FCB     $1A                      ; 22AA: 1A          ; 
M22AB           LDAA    #$82                     ; 22AB: 86 82       ; 
                BITA    LDADDRH                  ; 22AD: 95 20       ; 
                RTS                              ; 22AF: 39          ; 
Z22B0           TPA                              ; 22B0: 07          ; 
                SEI                              ; 22B1: 0F          ; 
                STAA    M002B                    ; 22B2: 97 2B       ; 
                LDX     NMIsVC                   ; 22B4: FE FF FC    ; 
                STX     ONECONL                  ; 22B7: DF 25       ; 
                LDX     #M2319                   ; 22B9: CE 23 19    ; 
                STX     NMIsVC                   ; 22BC: FF FF FC    ; 
                LDX     #PIAREGA                 ; 22BF: CE EC 00    ; 
                LDAA    #$36                     ; 22C2: 86 36       ; 
                STAA    $03,X                    ; 22C4: A7 03       ; 
                LDAA    #$3E                     ; 22C6: 86 3E       ; 
                STAA    $03,X                    ; 22C8: A7 03       ; 
                LDAB    ,X                       ; 22CA: E6 00       ; 
                DECA                             ; 22CC: 4A          ; 
                STAA    $02,X                    ; 22CD: A7 02       ; 
                RTS                              ; 22CF: 39          ; 
Z22D0           LDX     #$3C3E                   ; 22D0: CE 3C 3E    ; 
                STX     PIACTRLA                 ; 22D3: FF EC 02    ; 
                LDX     PIAREGA                  ; 22D6: FE EC 00    ; 
                LDX     ONECONL                  ; 22D9: DE 25       ; 
                STX     NMIsVC                   ; 22DB: FF FF FC    ; 
                LDAA    M002B                    ; 22DE: 96 2B       ; 
                TAP                              ; 22E0: 06          ; 
                RTS                              ; 22E1: 39          ; 
Z22E2           LDAA    #$18                     ; 22E2: 86 18       ; 
Z22E4           BITA    SSDA_0                   ; 22E4: B5 EC 04    ; 
                BEQ     Z22E4                    ; 22E7: 27 FB       ; 
                LDAA    M002A                    ; 22E9: 96 2A       ; 
Z22EB           DECA                             ; 22EB: 4A          ; 
                BNE     Z22EB                    ; 22EC: 26 FD       ; 
                LDAA    #$18                     ; 22EE: 86 18       ; 
                STAA    SSDA_1                   ; 22F0: B7 EC 05    ; 
                DECB                             ; 22F3: 5A          ; 
                BNE     Z22E4                    ; 22F4: 26 EE       ; 
                LDX     #$81AA                   ; 22F6: CE 81 AA    ; 
                LDAB    #$05                     ; 22F9: C6 05       ; 
                NOP                              ; 22FB: 01          ; 
                NOP                              ; 22FC: 01          ; 
                STX     SSDA_0                   ; 22FD: FF EC 04    ; 
                LDX     #$8210                   ; 2300: CE 82 10    ; 
                STX     SSDA_0                   ; 2303: FF EC 04    ; 
Z2306           BITA    SSDA_0                   ; 2306: B5 EC 04    ; 
                BEQ     Z2306                    ; 2309: 27 FB       ; 
                LDAA    M002A                    ; 230B: 96 2A       ; 
Z230D           DECA                             ; 230D: 4A          ; 
                BNE     Z230D                    ; 230E: 26 FD       ; 
                LDAA    #$18                     ; 2310: 86 18       ; 
                STAA    SSDA_1                   ; 2312: B7 EC 05    ; 
                DECB                             ; 2315: 5A          ; 
                BNE     Z2306                    ; 2316: 26 EE       ; 
                RTS                              ; 2318: 39          ; 
M2319           LDS     M0027                    ; 2319: 9E 27       ; 
                BSR     Z22D0                    ; 231B: 8D B3       ; 
                JSR     FDINIT                   ; 231D: BD E8 22    ; 
                LDAA    #$35                     ; 2320: 86 35       ; 
                STAA    FDSTAT                   ; 2322: 97 08       ; 
                LDAA    EXADDRL                  ; 2324: 96 23       ; 
                DECA                             ; 2326: 4A          ; 
                CLRB                             ; 2327: 5F          ; 
                ADDA    STRSCTL                  ; 2328: 9B 02       ; 
                ADCB    STRSCTH                  ; 232A: D9 01       ; 
                JMP     Z2104                    ; 232C: 7E 21 04    ; 
M232F           FCB     '                        ; 232F: 20          ; 
M2330           FCB     ' ,' ,' ,' ,' ,' ,' ,'   ; 2330: 20 20 20 20 20 20 20 20 
M2338           FCB     ' ,'                     ; 2338: 20 20          
M233A           FCB     $00,$00                  ; 233A: 00 00          
M233C           FCB     $00,$00                  ; 233C: 00 00          
M233E           FCB     'F,'O,'R,'M,'A,'T,' ,'D  ; 233E: 46 4F 52 4D 41 54 20 44 
                FCB     'R,'I,'V,'E,'            ; 2346: 52 49 56 45 20 
M234B           FCB     'X,'?                    ; 234B: 58 3F          
                FCB     $0d                      ; 234D: 0D             
STORAGE         FCB     $00                      ; 234E: 00             
                FCB     $00                      ; 234F: 00             
Z2350           ORAB    #$08                     ; 2350: CA 08          
                STAB    PIAREGA                  ; 2352: F7 EC 00       
                RTS                              ; 2355: 39             
Z2356           LDAA    PIAREGB                  ; 2356: B6 EC 01       
                ANDA    #$20                     ; 2359: 84 20          
                ORAA    #$03                     ; 235B: 8A 03          
                JMP     Z2176                    ; 235D: 7E 21 76       
Z2360           BCS     Z2365                    ; 2360: 25 03          
                JMP     Z236D                    ; 2362: 7E 23 6D       
Z2365           LDAA    #$07                     ; 2365: 86 07          
                JSR     ZF018                    ; 2367: BD F0 18       
                JMP     FORMATSTART              ; 236A: 7E 20 06       
Z236D           LDAA    #$05                     ; 236D: 86 05          
                STAA    M0030                    ; 236F: 97 30          
Z2371           JSR     SEEK                     ; 2371: BD E8 78       
                JMP     Z2155                    ; 2374: 7E 21 55       
Z2377           DEC     M0030                    ; 2377: 7A 00 30       
                BNE     Z2371                    ; 237A: 26 F5          
                JMP     Z20F4                    ; 237C: 7E 20 F4       


                END
