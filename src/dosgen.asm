dasmfw: Disassembler Framework V0.35
Loaded: binary file "DOSGEN.CM"
Loaded: Info file "dosgen.info"

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
CWRDCNT EQU     $0009
SECTCNT EQU     $000B
M000C   EQU     $000C
SIDES   EQU     $000D
M0014   EQU     $0014
M0017   EQU     $0017
M0018   EQU     $0018
M0020   EQU     $0020
M0021   EQU     $0021
M0022   EQU     $0022
M0025   EQU     $0025
M0026   EQU     $0026
M0028   EQU     $0028
M002A   EQU     $002A
M002B   EQU     $002B
M002C   EQU     $002C
M002D   EQU     $002D
M0039   EQU     $0039
M007F   EQU     $007F
M00A0   EQU     $00A0
CBUFPs  EQU     $00FE
M0100   EQU     $0100
M0102   EQU     $0102
M0108   EQU     $0108
M0109   EQU     $0109
M010E   EQU     $010E
M07D0   EQU     $07D0
M0FA4   EQU     $0FA4
M444B   EQU     $444B
M863F   EQU     $863F
ME800   EQU     $E800
ZE853   EQU     $E853
ZE86D   EQU     $E86D
ZE86F   EQU     $E86F
ZE872   EQU     $E872
ZE875   EQU     $E875
ZE87E   EQU     $E87E
ZEBC0   EQU     $EBC0

;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $2000

                FCB     ' ,'3,'0,'1              ; 2000: 20 33 30 31    
START           NOP                              ; 2004: 01             
                SEI                              ; 2005: 0F             
                LDX     CBUFPs                   ; 2006: DE FE          
                STX     M27BD                    ; 2008: FF 27 BD       
                LDX     #M27C1                   ; 200B: CE 27 C1       
                STX     M27BF                    ; 200E: FF 27 BF       
                LDAA    #$31                     ; 2011: 86 31          
                STAA    M27C1                    ; 2013: B7 27 C1       
                LDX     #M27BD                   ; 2016: CE 27 BD       
                SWI                              ; 2019: 3F             
                FCB     $1D                      ; 201A: 1D             
                ANDB    #$7F                     ; 201B: C4 7F          
                BNE     Z2077                    ; 201D: 26 58          
                CLRB                             ; 201F: 5F             
                LDX     M27BD                    ; 2020: FE 27 BD       
Z2023           LDAA    ,X                       ; 2023: A6 00          
                INX                              ; 2025: 08             
                CMPA    #$0D                     ; 2026: 81 0D          
                BEQ     Z2049                    ; 2028: 27 1F          
                CMPA    #$3B                     ; 202A: 81 3B          
                BNE     Z2023                    ; 202C: 26 F5          
Z202E           LDAA    ,X                       ; 202E: A6 00          
                INX                              ; 2030: 08             
                CMPA    #$20                     ; 2031: 81 20          
                BEQ     Z202E                    ; 2033: 27 F9          
                CMPA    #$0D                     ; 2035: 81 0D          
                BEQ     Z2049                    ; 2037: 27 10          
                CMPA    #$55                     ; 2039: 81 55          
                BNE     Z2041                    ; 203B: 26 04          
                ORAB    #$01                     ; 203D: CA 01          
                BRA     Z202E                    ; 203F: 20 ED          
Z2041           CMPA    #$54                     ; 2041: 81 54          
                BNE     Z2077                    ; 2043: 26 32          
                ORAB    #$02                     ; 2045: CA 02          
                BRA     Z202E                    ; 2047: 20 E5          
Z2049           STAB    M0025                    ; 2049: D7 25          
                LDX     #M27C1                   ; 204B: CE 27 C1       
                LDAA    ,X                       ; 204E: A6 00          
                CMPA    #$34                     ; 2050: 81 34          
                BGE     Z2080                    ; 2052: 2C 2C          
                STAA    M2838                    ; 2054: B7 28 38       
                ANDA    #$03                     ; 2057: 84 03          
                BEQ     Z2080                    ; 2059: 27 25          
                STAA    M0021                    ; 205B: 97 21          
                LDAB    #$20                     ; 205D: C6 20          
                LDAA    $01,X                    ; 205F: A6 01          
                CBA                              ; 2061: 11             
                BNE     Z2077                    ; 2062: 26 13          
                LDAA    $09,X                    ; 2064: A6 09          
                CBA                              ; 2066: 11             
                BNE     Z2077                    ; 2067: 26 0E          
                LDX     #M282B                   ; 2069: CE 28 2B       
                SWI                              ; 206C: 3F             
                FCB     $0C                      ; 206D: 0C             
                JSR     Z2527                    ; 206E: BD 25 27       
                CMPA    #$59                     ; 2071: 81 59          
                BEQ     Z2089                    ; 2073: 27 14          
Z2075           SWI                              ; 2075: 3F             
                FCB     $1A                      ; 2076: 1A             
Z2077           LDAB    #$0B                     ; 2077: C6 0B          
                FCB     $8C                      ; 2079: 8C             
Z207A           LDAB    #$00                     ; 207A: C6 00          
                FCB     $8C                      ; 207C: 8C             
Z207D           LDAB    #$01                     ; 207D: C6 01          
                FCB     $8C                      ; 207F: 8C             
Z2080           LDAB    #$04                     ; 2080: C6 04          
                FCB     $8C                      ; 2082: 8C             
Z2083           LDAB    #$06                     ; 2083: C6 06          
                SWI                              ; 2085: 3F             
                FCB     $20                      ; 2086: 20             
                BRA     Z2075                    ; 2087: 20 EC          
Z2089           LDAA    M0021                    ; 2089: 96 21          
                STAA    CURDRV                   ; 208B: 97 00          
M208D           JSR     ZE875                    ; 208D: BD E8 75       
                BCC     Z2098                    ; 2090: 24 06          
                LDX     #M208D                   ; 2092: CE 20 8D       
                JMP     Z21CC                    ; 2095: 7E 21 CC       
Z2098           CLR     M0022                    ; 2098: 7F 00 22       
                LDX     #M07D0                   ; 209B: CE 07 D0       
                LDAB    #$0F                     ; 209E: C6 0F          
                PSHB                             ; 20A0: 37             
                LDAB    #$3E                     ; 20A1: C6 3E          
                LDAA    SIDES                    ; 20A3: 96 0D          
                BMI     Z20B0                    ; 20A5: 2B 09          
                LDX     #M0FA4                   ; 20A7: CE 0F A4       
                INS                              ; 20AA: 31             
                LDAB    #$7F                     ; 20AB: C6 7F          
                PSHB                             ; 20AD: 37             
                LDAB    #$7D                     ; 20AE: C6 7D          
Z20B0           STX     M002A                    ; 20B0: DF 2A          
                STAB    M002C                    ; 20B2: D7 2C          
                PULB                             ; 20B4: 33             
                STAB    M002D                    ; 20B5: D7 2D          
Z20B7           LDX     #M283D                   ; 20B7: CE 28 3D       
                SWI                              ; 20BA: 3F             
                FCB     $0C                      ; 20BB: 0C             
                LDAB    #$08                     ; 20BC: C6 08          
                LDX     #M2630                   ; 20BE: CE 26 30       
                SWI                              ; 20C1: 3F             
                FCB     $12                      ; 20C2: 12             
                LDAB    #$08                     ; 20C3: C6 08          
                LDX     #M26B0                   ; 20C5: CE 26 B0       
                SWI                              ; 20C8: 3F             
                FCB     $09                      ; 20C9: 09             
                TSTB                             ; 20CA: 5D             
                BEQ     Z20B7                    ; 20CB: 27 EA          
                JSR     Z2531                    ; 20CD: BD 25 31       
                BCS     Z20B7                    ; 20D0: 25 E5          
                CMPB    #$08                     ; 20D2: C1 08          
                BLE     Z20D8                    ; 20D4: 2F 02          
                LDAB    #$08                     ; 20D6: C6 08          
Z20D8           LDX     #M26B0                   ; 20D8: CE 26 B0       
                STX     M27AD                    ; 20DB: FF 27 AD       
                LDX     #M2630                   ; 20DE: CE 26 30       
                STX     M27AF                    ; 20E1: FF 27 AF       
                LDX     #M27AD                   ; 20E4: CE 27 AD       
                SWI                              ; 20E7: 3F             
                FCB     $10                      ; 20E8: 10             
Z20E9           LDX     #M2849                   ; 20E9: CE 28 49       
                SWI                              ; 20EC: 3F             
                FCB     $0C                      ; 20ED: 0C             
                LDAB    #$06                     ; 20EE: C6 06          
                LDX     #M263C                   ; 20F0: CE 26 3C       
                SWI                              ; 20F3: 3F             
                FCB     $12                      ; 20F4: 12             
                LDAB    #$06                     ; 20F5: C6 06          
                LDX     #M26B0                   ; 20F7: CE 26 B0       
                SWI                              ; 20FA: 3F             
                FCB     $09                      ; 20FB: 09             
                CMPB    #$06                     ; 20FC: C1 06          
                BNE     Z20E9                    ; 20FE: 26 E9          
                JSR     Z254B                    ; 2100: BD 25 4B       
                BCS     Z20E9                    ; 2103: 25 E4          
                CMPB    #$06                     ; 2105: C1 06          
                BLE     Z210B                    ; 2107: 2F 02          
                LDAB    #$06                     ; 2109: C6 06          
Z210B           LDX     #M26B0                   ; 210B: CE 26 B0       
                STX     M27AD                    ; 210E: FF 27 AD       
                LDX     #M263C                   ; 2111: CE 26 3C       
                STX     M27AF                    ; 2114: FF 27 AF       
                LDX     #M27AD                   ; 2117: CE 27 AD       
                SWI                              ; 211A: 3F             
                FCB     $10                      ; 211B: 10             
Z211C           LDX     #M2859                   ; 211C: CE 28 59       
                SWI                              ; 211F: 3F             
                FCB     $0C                      ; 2120: 0C             
                LDAB    #$14                     ; 2121: C6 14          
                LDX     #M2642                   ; 2123: CE 26 42       
                SWI                              ; 2126: 3F             
                FCB     $12                      ; 2127: 12             
                LDAB    #$14                     ; 2128: C6 14          
                LDX     #M26B0                   ; 212A: CE 26 B0       
                SWI                              ; 212D: 3F             
                FCB     $09                      ; 212E: 09             
                TSTB                             ; 212F: 5D             
                BEQ     Z211C                    ; 2130: 27 EA          
                CMPB    #$14                     ; 2132: C1 14          
                BLE     Z2138                    ; 2134: 2F 02          
                LDAB    #$14                     ; 2136: C6 14          
Z2138           STX     M27AD                    ; 2138: FF 27 AD       
                LDX     #M2642                   ; 213B: CE 26 42       
                STX     M27AF                    ; 213E: FF 27 AF       
                LDX     #M27AD                   ; 2141: CE 27 AD       
                SWI                              ; 2144: 3F             
                FCB     $10                      ; 2145: 10             
                LDX     M0100                    ; 2146: FE 01 00       
                STX     M2638                    ; 2149: FF 26 38       
                LDX     M0102                    ; 214C: FE 01 02       
                STX     M263A                    ; 214F: FF 26 3A       
                LDX     #M0017                   ; 2152: CE 00 17       
                STX     M27A9                    ; 2155: FF 27 A9       
                LDX     #M25B0                   ; 2158: CE 25 B0       
                STX     M27AB                    ; 215B: FF 27 AB       
                LDAB    M0021                    ; 215E: D6 21          
                LDX     #M27A8                   ; 2160: CE 27 A8       
                SWI                              ; 2163: 3F             
                FCB     $0F                      ; 2164: 0F             
                LDX     #CURDRV                  ; 2165: CE 00 00       
                STX     M27A9                    ; 2168: FF 27 A9       
                LDX     #M2630                   ; 216B: CE 26 30       
                STX     M27AB                    ; 216E: FF 27 AB       
                LDAB    M0021                    ; 2171: D6 21          
                LDX     #M27A8                   ; 2173: CE 27 A8       
                SWI                              ; 2176: 3F             
                FCB     $0F                      ; 2177: 0F             
                LDAB    #$80                     ; 2178: C6 80          
                CLRA                             ; 217A: 4F             
                LDX     #M2630                   ; 217B: CE 26 30       
                SWI                              ; 217E: 3F             
                FCB     $13                      ; 217F: 13             
                LDAA    M0025                    ; 2180: 96 25          
                BITA    #$02                     ; 2182: 85 02          
                BNE     Z2189                    ; 2184: 26 03          
                JMP     Z2236                    ; 2186: 7E 22 36       
Z2189           LDX     #M294B                   ; 2189: CE 29 4B       
                SWI                              ; 218C: 3F             
                FCB     $0A                      ; 218D: 0A             
                LDAA    M0021                    ; 218E: 96 21          
                STAA    CURDRV                   ; 2190: 97 00          
                LDAA    #$18                     ; 2192: 86 18          
                STAA    STRSCTL                  ; 2194: 97 02          
                LDAB    #$00                     ; 2196: C6 00          
                STAB    STRSCTH                  ; 2198: D7 01          
                LDX     M002A                    ; 219A: DE 2A          
                SWI                              ; 219C: 3F             
                FCB     $2D                      ; 219D: 2D             
                STX     NUMSCTH                  ; 219E: DF 03          
                LDX     #M27CC                   ; 21A0: CE 27 CC       
                STX     CURADRH                  ; 21A3: DF 06          
                CLR     M0020                    ; 21A5: 7F 00 20       
M21A8           JSR     ZE872                    ; 21A8: BD E8 72       
                BCS     Z21B7                    ; 21AB: 25 0A          
                SWI                              ; 21AD: 3F             
                FCB     $0D                      ; 21AE: 0D             
                BCC     Z21B4                    ; 21AF: 24 03          
                JMP     Z2075                    ; 21B1: 7E 20 75       
Z21B4           JMP     Z2236                    ; 21B4: 7E 22 36       
Z21B7           LDAA    FDSTAT                   ; 21B7: 96 08          
                CMPA    #$31                     ; 21B9: 81 31          
                BEQ     Z21D4                    ; 21BB: 27 17          
                CMPA    #$38                     ; 21BD: 81 38          
                BEQ     Z21D4                    ; 21BF: 27 13          
                CMPA    #$34                     ; 21C1: 81 34          
                BEQ     Z21D4                    ; 21C3: 27 0F          
                CMPA    M0039                    ; 21C5: 91 39          
                BEQ     Z21D4                    ; 21C7: 27 0B          
                LDX     #M21A8                   ; 21C9: CE 21 A8       
Z21CC           STX     CWRDCNT                  ; 21CC: DF 09          
                LDX     #FDSTAT                  ; 21CE: CE 00 08       
                JMP     Z207D                    ; 21D1: 7E 20 7D       
Z21D4           LDAB    M0020                    ; 21D4: D6 20          
                BNE     Z21DD                    ; 21D6: 26 05          
                INC     M0020                    ; 21D8: 7C 00 20       
                BRA     M21A8                    ; 21DB: 20 CB          
Z21DD           CLR     M0020                    ; 21DD: 7F 00 20       
                JSR     Z249F                    ; 21E0: BD 24 9F       
                JSR     Z2967                    ; 21E3: BD 29 67       
                LDX     #M2630                   ; 21E6: CE 26 30       
                SWI                              ; 21E9: 3F             
                FCB     $28                      ; 21EA: 28             
                ORAB    ,X                       ; 21EB: EA 00          
                STAB    ,X                       ; 21ED: E7 00          
                LDX     SECTCNT                  ; 21EF: DE 0B          
                STX     M0026                    ; 21F1: DF 26          
                LDX     #STRSCTH                 ; 21F3: CE 00 01       
                STX     NUMSCTH                  ; 21F6: DF 03          
                JSR     ZE87E                    ; 21F8: BD E8 7E       
M21FB           JSR     ZE86F                    ; 21FB: BD E8 6F       
                LDAA    FDSTAT                   ; 21FE: 96 08          
                CMPA    #$34                     ; 2200: 81 34          
                BEQ     Z220A                    ; 2202: 27 06          
                LDX     #M21FB                   ; 2204: CE 21 FB       
                JMP     Z21CC                    ; 2207: 7E 21 CC       
Z220A           LDX     STRSCTH                  ; 220A: DE 01          
                STX     M27B1                    ; 220C: FF 27 B1       
                LDX     #M286F                   ; 220F: CE 28 6F       
                STX     M27B3                    ; 2212: FF 27 B3       
                LDX     #M27B1                   ; 2215: CE 27 B1       
                LDAB    #$04                     ; 2218: C6 04          
                JSR     Z2982                    ; 221A: BD 29 82       
                LDX     #M2865                   ; 221D: CE 28 65       
                SWI                              ; 2220: 3F             
                FCB     $0A                      ; 2221: 0A             
                LDAB    #$81                     ; 2222: C6 81          
                SWI                              ; 2224: 3F             
                FCB     $23                      ; 2225: 23             
                LDX     STRSCTH                  ; 2226: DE 01          
                INX                              ; 2228: 08             
                CPX     M002A                    ; 2229: 9C 2A          
                BEQ     Z21B4                    ; 222B: 27 87          
                STX     STRSCTH                  ; 222D: DF 01          
                LDX     M0026                    ; 222F: DE 26          
                STX     NUMSCTH                  ; 2231: DF 03          
                JMP     M21A8                    ; 2233: 7E 21 A8       
Z2236           SWI                              ; 2236: 3F             
                FCB     $0D                      ; 2237: 0D             
                BCC     Z223D                    ; 2238: 24 03          
                JMP     Z2075                    ; 223A: 7E 20 75       
Z223D           LDX     #M287D                   ; 223D: CE 28 7D       
                SWI                              ; 2240: 3F             
                FCB     $0C                      ; 2241: 0C             
                JSR     Z2527                    ; 2242: BD 25 27       
                CMPA    #$4E                     ; 2245: 81 4E          
                BNE     Z224C                    ; 2247: 26 03          
                JMP     Z22EC                    ; 2249: 7E 22 EC       
Z224C           CMPA    #$59                     ; 224C: 81 59          
                BNE     Z2236                    ; 224E: 26 E6          
                LDX     #M289A                   ; 2250: CE 28 9A       
                SWI                              ; 2253: 3F             
                FCB     $0C                      ; 2254: 0C             
                LDAB    #$03                     ; 2255: C6 03          
                LDX     #M26B0                   ; 2257: CE 26 B0       
                STX     M27B5                    ; 225A: FF 27 B5       
                SWI                              ; 225D: 3F             
                FCB     $09                      ; 225E: 09             
                TSTB                             ; 225F: 5D             
                BEQ     Z2236                    ; 2260: 27 D4          
                LDX     #M27B5                   ; 2262: CE 27 B5       
                JSR     Z29C3                    ; 2265: BD 29 C3       
                BCS     Z227B                    ; 2268: 25 11          
                LDAA    M27B8                    ; 226A: B6 27 B8       
                ANDA    #$03                     ; 226D: 84 03          
                BNE     Z227B                    ; 226F: 26 0A          
                LDX     M27B7                    ; 2271: FE 27 B7       
                CLRB                             ; 2274: 5F             
                LDAA    #$17                     ; 2275: 86 17          
                SWI                              ; 2277: 3F             
                FCB     $2F                      ; 2278: 2F             
                BLS     Z2288                    ; 2279: 23 0D          
Z227B           LDX     #M28F7                   ; 227B: CE 28 F7       
                SWI                              ; 227E: 3F             
                FCB     $0A                      ; 227F: 0A             
                LDAA    #$40                     ; 2280: 86 40          
                LDAB    #$80                     ; 2282: C6 80          
                SWI                              ; 2284: 3F             
                FCB     $23                      ; 2285: 23             
                BRA     Z2236                    ; 2286: 20 AE          
Z2288           LDX     #M28B8                   ; 2288: CE 28 B8       
                SWI                              ; 228B: 3F             
                FCB     $0C                      ; 228C: 0C             
                LDAB    #$03                     ; 228D: C6 03          
                LDX     #M26B0                   ; 228F: CE 26 B0       
                STX     M27B9                    ; 2292: FF 27 B9       
                SWI                              ; 2295: 3F             
                FCB     $09                      ; 2296: 09             
                TSTB                             ; 2297: 5D             
                BEQ     Z2236                    ; 2298: 27 9C          
                LDX     #M27B9                   ; 229A: CE 27 B9       
                JSR     Z29C3                    ; 229D: BD 29 C3       
                BCS     Z227B                    ; 22A0: 25 D9          
                LDAA    M27BC                    ; 22A2: B6 27 BC       
                ANDA    #$03                     ; 22A5: 84 03          
                BNE     Z227B                    ; 22A7: 26 D2          
                LDX     M27BB                    ; 22A9: FE 27 BB       
                LDAA    M002B                    ; 22AC: 96 2B          
                LDAB    M002A                    ; 22AE: D6 2A          
                SWI                              ; 22B0: 3F             
                FCB     $2F                      ; 22B1: 2F             
                BLS     Z227B                    ; 22B2: 23 C7          
                LDAB    M27B7                    ; 22B4: F6 27 B7       
                LDAA    M27B8                    ; 22B7: B6 27 B8       
                SWI                              ; 22BA: 3F             
                FCB     $2F                      ; 22BB: 2F             
                BLS     Z22C1                    ; 22BC: 23 03          
                JMP     Z227B                    ; 22BE: 7E 22 7B       
Z22C1           LDAA    M27B8                    ; 22C1: B6 27 B8       
                LDAB    M27B7                    ; 22C4: F6 27 B7       
Z22C7           JSR     Z2967                    ; 22C7: BD 29 67       
                LDX     #M2630                   ; 22CA: CE 26 30       
                SWI                              ; 22CD: 3F             
                FCB     $28                      ; 22CE: 28             
                ORAB    ,X                       ; 22CF: EA 00          
                STAB    ,X                       ; 22D1: E7 00          
                LDAA    #$04                     ; 22D3: 86 04          
                LDX     #M27B7                   ; 22D5: CE 27 B7       
                SWI                              ; 22D8: 3F             
                FCB     $16                      ; 22D9: 16             
                LDX     M27BB                    ; 22DA: FE 27 BB       
                LDAB    M27B7                    ; 22DD: F6 27 B7       
                LDAA    M27B8                    ; 22E0: B6 27 B8       
                SWI                              ; 22E3: 3F             
                FCB     $2F                      ; 22E4: 2F             
                BLS     Z22C7                    ; 22E5: 23 E0          
                LDX     #M28D4                   ; 22E7: CE 28 D4       
                SWI                              ; 22EA: 3F             
                FCB     $0A                      ; 22EB: 0A             
Z22EC           LDX     #M2630                   ; 22EC: CE 26 30       
                LDAA    #$FC                     ; 22EF: 86 FC          
                ORAA    ,X                       ; 22F1: AA 00          
                STAA    ,X                       ; 22F3: A7 00          
                LDAB    M002C                    ; 22F5: D6 2C          
                SWI                              ; 22F7: 3F             
                FCB     $27                      ; 22F8: 27             
                LDAA    M002D                    ; 22F9: 96 2D          
                ORAA    ,X                       ; 22FB: AA 00          
                STAA    ,X                       ; 22FD: A7 00          
                INX                              ; 22FF: 08             
                SUBB    #$80                     ; 2300: C0 80          
                NEGB                             ; 2302: 50             
                LDAA    #$FF                     ; 2303: 86 FF          
                SWI                              ; 2305: 3F             
                FCB     $13                      ; 2306: 13             
                LDX     #STRSCTL                 ; 2307: CE 00 02       
                STX     M27A9                    ; 230A: FF 27 A9       
                LDX     #M2630                   ; 230D: CE 26 30       
                STX     M27AB                    ; 2310: FF 27 AB       
                LDAB    M0021                    ; 2313: D6 21          
                LDX     #M27A8                   ; 2315: CE 27 A8       
                SWI                              ; 2318: 3F             
                FCB     $0F                      ; 2319: 0F             
                LDX     #STRSCTH                 ; 231A: CE 00 01       
                STX     M27A9                    ; 231D: FF 27 A9       
                LDX     #M2630                   ; 2320: CE 26 30       
                STX     M27AB                    ; 2323: FF 27 AB       
                LDAB    M0021                    ; 2326: D6 21          
                LDX     #M27A8                   ; 2328: CE 27 A8       
                SWI                              ; 232B: 3F             
                FCB     $0F                      ; 232C: 0F             
                LDAA    M0021                    ; 232D: 96 21          
                STAA    CURDRV                   ; 232F: 97 00          
                LDX     #NUMSCTH                 ; 2331: CE 00 03       
                STX     STRSCTH                  ; 2334: DF 01          
                LDX     #M0014                   ; 2336: CE 00 14       
                STX     NUMSCTH                  ; 2339: DF 03          
                LDX     #M27CE                   ; 233B: CE 27 CE       
                STX     CURADRH                  ; 233E: DF 06          
M2340           JSR     ZE872                    ; 2340: BD E8 72       
                BCC     Z234E                    ; 2343: 24 09          
                JSR     Z249F                    ; 2345: BD 24 9F       
                LDX     #M2340                   ; 2348: CE 23 40       
                JMP     Z21CC                    ; 234B: 7E 21 CC       
Z234E           LDX     #M444B                   ; 234E: CE 44 4B       
                STX     M26CD                    ; 2351: FF 26 CD       
                STX     M26F2                    ; 2354: FF 26 F2       
                LDX     M0108                    ; 2357: FE 01 08       
                INX                              ; 235A: 08             
                STX     M26E4                    ; 235B: FF 26 E4       
                LDAB    #$02                     ; 235E: C6 02          
                SWI                              ; 2360: 3F             
                FCB     $1E                      ; 2361: 1E             
                LDX     M26E4                    ; 2362: FE 26 E4       
                LDAB    M0108                    ; 2365: F6 01 08       
                LDAA    M0109                    ; 2368: B6 01 09       
                SWI                              ; 236B: 3F             
                FCB     $2E                      ; 236C: 2E             
                ANDA    #$80                     ; 236D: 84 80          
                BNE     Z237A                    ; 236F: 26 09          
                TSTB                             ; 2371: 5D             
                BNE     Z237A                    ; 2372: 26 06          
                LDAB    #$36                     ; 2374: C6 36          
                SWI                              ; 2376: 3F             
                FCB     $20                      ; 2377: 20             
                SWI                              ; 2378: 3F             
                FCB     $1A                      ; 2379: 1A             
Z237A           SWI                              ; 237A: 3F             
                FCB     $29                      ; 237B: 29             
                DEX                              ; 237C: 09             
                STX     M26E6                    ; 237D: FF 26 E6       
                LDX     #M26C5                   ; 2380: CE 26 C5       
                LDAA    M0022                    ; 2383: 96 22          
                STAA    $0A,X                    ; 2385: A7 0A          
                LDAA    #$31                     ; 2387: 86 31          
                STAA    $01,X                    ; 2389: A7 01          
                SWI                              ; 238B: 3F             
                FCB     $00                      ; 238C: 00             
                BEQ     Z2392                    ; 238D: 27 03          
                JMP     Z207A                    ; 238F: 7E 20 7A       
Z2392           LDX     #M26EA                   ; 2392: CE 26 EA       
                LDAA    M0021                    ; 2395: 96 21          
                STAA    $0A,X                    ; 2397: A7 0A          
                LDAA    #$32                     ; 2399: 86 32          
                STAA    $01,X                    ; 239B: A7 01          
                SWI                              ; 239D: 3F             
                FCB     $00                      ; 239E: 00             
                BEQ     Z23A4                    ; 239F: 27 03          
                JMP     Z207A                    ; 23A1: 7E 20 7A       
Z23A4           LDX     #M27D0                   ; 23A4: CE 27 D0       
                STX     M0028                    ; 23A7: DF 28          
Z23A9           JSR     Z2419                    ; 23A9: BD 24 19       
                BCS     Z23E6                    ; 23AC: 25 38          
                JSR     Z2436                    ; 23AE: BD 24 36       
                JSR     Z245F                    ; 23B1: BD 24 5F       
                BNE     Z23CD                    ; 23B4: 26 17          
                JSR     Z250E                    ; 23B6: BD 25 0E       
                BCS     Z2416                    ; 23B9: 25 5B          
                LDX     #M290D                   ; 23BB: CE 29 0D       
                SWI                              ; 23BE: 3F             
                FCB     $0A                      ; 23BF: 0A             
                JSR     Z24B1                    ; 23C0: BD 24 B1       
                BNE     Z23CD                    ; 23C3: 26 08          
                JSR     Z255C                    ; 23C5: BD 25 5C       
                JSR     Z24D0                    ; 23C8: BD 24 D0       
                BEQ     Z23A9                    ; 23CB: 27 DC          
Z23CD           TSTB                             ; 23CD: 5D             
                BEQ     Z2416                    ; 23CE: 27 46          
                CMPB    #$07                     ; 23D0: C1 07          
                BEQ     Z23D7                    ; 23D2: 27 03          
                JMP     Z207A                    ; 23D4: 7E 20 7A       
Z23D7           LDAB    #$0A                     ; 23D7: C6 0A          
                SWI                              ; 23D9: 3F             
                FCB     $27                      ; 23DA: 27             
                LDAB    ,X                       ; 23DB: E6 00          
                ANDB    #$03                     ; 23DD: C4 03          
                ORAB    #$30                     ; 23DF: CA 30          
                STAB    ,X                       ; 23E1: E7 00          
                JMP     Z2083                    ; 23E3: 7E 20 83       
Z23E6           LDAA    M0025                    ; 23E6: 96 25          
                BITA    #$01                     ; 23E8: 85 01          
                BNE     Z2416                    ; 23EA: 26 2A          
                LDAA    M0022                    ; 23EC: 96 22          
                STAA    M278F                    ; 23EE: B7 27 8F       
                CLR     M27A0                    ; 23F1: 7F 27 A0       
Z23F4           JSR     Z24DB                    ; 23F4: BD 24 DB       
                BCS     Z2416                    ; 23F7: 25 1D          
                JSR     Z242B                    ; 23F9: BD 24 2B       
                JSR     Z2436                    ; 23FC: BD 24 36       
                JSR     Z245F                    ; 23FF: BD 24 5F       
                BNE     Z23CD                    ; 2402: 26 C9          
                LDX     #M290D                   ; 2404: CE 29 0D       
                SWI                              ; 2407: 3F             
                FCB     $0A                      ; 2408: 0A             
                JSR     Z24B1                    ; 2409: BD 24 B1       
                BNE     Z23CD                    ; 240C: 26 BF          
                JSR     Z255C                    ; 240E: BD 25 5C       
                JSR     Z24D0                    ; 2411: BD 24 D0       
                BRA     Z23F4                    ; 2414: 20 DE          
Z2416           JMP     Z2075                    ; 2416: 7E 20 75       
Z2419           LDX     M0028                    ; 2419: DE 28          
                LDAA    ,X                       ; 241B: A6 00          
                ASLA                             ; 241D: 48             
                BCS     Z245E                    ; 241E: 25 3E          
                STX     M27AD                    ; 2420: FF 27 AD       
                LDAB    #$0A                     ; 2423: C6 0A          
                SWI                              ; 2425: 3F             
                FCB     $27                      ; 2426: 27             
                STX     M0028                    ; 2427: DF 28          
                BRA     Z2431                    ; 2429: 20 06          
Z242B           LDX     #M2790                   ; 242B: CE 27 90       
                STX     M27AD                    ; 242E: FF 27 AD       
Z2431           LDX     #M26D0                   ; 2431: CE 26 D0       
                BRA     Z2454                    ; 2434: 20 1E          
Z2436           LDX     #M26D0                   ; 2436: CE 26 D0       
                STX     M27AD                    ; 2439: FF 27 AD       
                LDX     #M26F5                   ; 243C: CE 26 F5       
                BSR     Z2454                    ; 243F: 8D 13          
                LDX     M26D8                    ; 2441: FE 26 D8       
                STX     M2923                    ; 2444: FF 29 23       
                LDX     #M26D0                   ; 2447: CE 26 D0       
                STX     M27AD                    ; 244A: FF 27 AD       
                LDX     #M291A                   ; 244D: CE 29 1A       
                LDAB    #$08                     ; 2450: C6 08          
                BRA     Z2456                    ; 2452: 20 02          
Z2454           LDAB    #$0A                     ; 2454: C6 0A          
Z2456           STX     M27AF                    ; 2456: FF 27 AF       
                LDX     #M27AD                   ; 2459: CE 27 AD       
                SWI                              ; 245C: 3F             
                FCB     $10                      ; 245D: 10             
Z245E           RTS                              ; 245E: 39             
Z245F           LDX     #M26C5                   ; 245F: CE 26 C5       
                SWI                              ; 2462: 3F             
                FCB     $02                      ; 2463: 02             
                BCS     Z249E                    ; 2464: 25 38          
                LDX     M26D8                    ; 2466: FE 26 D8       
                STX     M2707                    ; 2469: FF 27 07       
                LDX     M26DC                    ; 246C: FE 26 DC       
                STX     M2701                    ; 246F: FF 27 01       
                LDX     #CURDRV                  ; 2472: CE 00 00       
                STX     M2703                    ; 2475: FF 27 03       
                LDX     M26E4                    ; 2478: FE 26 E4       
                STX     M2709                    ; 247B: FF 27 09       
                LDX     M26E6                    ; 247E: FE 26 E6       
                STX     M270B                    ; 2481: FF 27 0B       
                LDX     #M26EA                   ; 2484: CE 26 EA       
Z2487           SWI                              ; 2487: 3F             
                FCB     $02                      ; 2488: 02             
                BCC     Z249E                    ; 2489: 24 13          
                CMPB    #$12                     ; 248B: C1 12          
                BNE     Z249E                    ; 248D: 26 0F          
                LDAB    $1D,X                    ; 248F: E6 1D          
                ADDB    $1E,X                    ; 2491: EB 1E          
                BEQ     Z249B                    ; 2493: 27 06          
                CLR     $1D,X                    ; 2495: 6F 1D          
                CLR     $1E,X                    ; 2497: 6F 1E          
                BRA     Z2487                    ; 2499: 20 EC          
Z249B           LDAB    #$12                     ; 249B: C6 12          
                SEC                              ; 249D: 0D             
Z249E           RTS                              ; 249E: 39             
Z249F           LDX     NUMSCTH                  ; 249F: DE 03          
                LDAA    STRSCTL                  ; 24A1: 96 02          
                LDAB    STRSCTH                  ; 24A3: D6 01          
                SWI                              ; 24A5: 3F             
                FCB     $2A                      ; 24A6: 2A             
                LDX     SECTCNT                  ; 24A7: DE 0B          
                INX                              ; 24A9: 08             
                SWI                              ; 24AA: 3F             
                FCB     $2E                      ; 24AB: 2E             
                STAA    STRSCTL                  ; 24AC: 97 02          
                STAB    STRSCTH                  ; 24AE: D7 01          
                RTS                              ; 24B0: 39             
Z24B1           LDX     #M26C5                   ; 24B1: CE 26 C5       
                SWI                              ; 24B4: 3F             
                FCB     $07                      ; 24B5: 07             
                BCS     Z24CD                    ; 24B6: 25 15          
                SWI                              ; 24B8: 3F             
                FCB     $0D                      ; 24B9: 0D             
                BCS     Z24CD                    ; 24BA: 25 11          
                LDX     M26E8                    ; 24BC: FE 26 E8       
                STX     M270D                    ; 24BF: FF 27 0D       
                LDX     #M26EA                   ; 24C2: CE 26 EA       
                SWI                              ; 24C5: 3F             
                FCB     $08                      ; 24C6: 08             
                BCS     Z24CD                    ; 24C7: 25 04          
                SWI                              ; 24C9: 3F             
                FCB     $0D                      ; 24CA: 0D             
                BCC     Z24B1                    ; 24CB: 24 E4          
Z24CD           CMPB    #$09                     ; 24CD: C1 09          
                RTS                              ; 24CF: 39             
Z24D0           LDX     #M26C5                   ; 24D0: CE 26 C5       
                SWI                              ; 24D3: 3F             
                FCB     $03                      ; 24D4: 03             
                LDX     #M26EA                   ; 24D5: CE 26 EA       
                SWI                              ; 24D8: 3F             
                FCB     $03                      ; 24D9: 03             
                RTS                              ; 24DA: 39             
Z24DB           LDAB    #$20                     ; 24DB: C6 20          
                STAB    M279C                    ; 24DD: F7 27 9C       
                LDX     #M278F                   ; 24E0: CE 27 8F       
                LDAB    #$20                     ; 24E3: C6 20          
                SWI                              ; 24E5: 3F             
                FCB     $1C                      ; 24E6: 1C             
                BCS     Z250D                    ; 24E7: 25 24          
                LDX     #M27D0                   ; 24E9: CE 27 D0       
                STX     M0028                    ; 24EC: DF 28          
Z24EE           LDX     M0028                    ; 24EE: DE 28          
                LDAA    ,X                       ; 24F0: A6 00          
                BMI     Z250C                    ; 24F2: 2B 18          
                STX     M27AD                    ; 24F4: FF 27 AD       
                LDAB    #$0A                     ; 24F7: C6 0A          
                SWI                              ; 24F9: 3F             
                FCB     $27                      ; 24FA: 27             
                STX     M0028                    ; 24FB: DF 28          
                LDX     #M2790                   ; 24FD: CE 27 90       
                STX     M27AF                    ; 2500: FF 27 AF       
                LDX     #M27AD                   ; 2503: CE 27 AD       
                SWI                              ; 2506: 3F             
                FCB     $11                      ; 2507: 11             
                BNE     Z24EE                    ; 2508: 26 E4          
                BRA     Z24DB                    ; 250A: 20 CF          
Z250C           CLRA                             ; 250C: 4F             
Z250D           RTS                              ; 250D: 39             
Z250E           LDX     #M27DA                   ; 250E: CE 27 DA       
                CPX     M0028                    ; 2511: 9C 28          
                BNE     Z2524                    ; 2513: 26 0F          
                LDX     M26FF                    ; 2515: FE 26 FF       
                CPX     #M0018                   ; 2518: 8C 00 18       
                BEQ     Z2524                    ; 251B: 27 07          
                LDX     #M2926                   ; 251D: CE 29 26       
                SWI                              ; 2520: 3F             
                FCB     $0A                      ; 2521: 0A             
                SEC                              ; 2522: 0D             
Z2523           RTS                              ; 2523: 39             
Z2524           CLC                              ; 2524: 0C             
                BRA     Z2523                    ; 2525: 20 FC          
Z2527           LDX     #M26B0                   ; 2527: CE 26 B0       
                LDAB    #$01                     ; 252A: C6 01          
                SWI                              ; 252C: 3F             
                FCB     $09                      ; 252D: 09             
                LDAA    ,X                       ; 252E: A6 00          
                RTS                              ; 2530: 39             
Z2531           PSHB                             ; 2531: 37             
                LDAA    ,X                       ; 2532: A6 00          
                BRA     Z253C                    ; 2534: 20 06          
Z2536           LDAA    ,X                       ; 2536: A6 00          
                SWI                              ; 2538: 3F             
                FCB     $15                      ; 2539: 15             
                BCC     Z2544                    ; 253A: 24 08          
Z253C           CMPA    #$0D                     ; 253C: 81 0D          
                BEQ     Z2548                    ; 253E: 27 08          
                SWI                              ; 2540: 3F             
                FCB     $14                      ; 2541: 14             
                BCS     Z2549                    ; 2542: 25 05          
Z2544           INX                              ; 2544: 08             
                DECB                             ; 2545: 5A             
                BNE     Z2536                    ; 2546: 26 EE          
Z2548           CLC                              ; 2548: 0C             
Z2549           PULB                             ; 2549: 33             
                RTS                              ; 254A: 39             
Z254B           PSHB                             ; 254B: 37             
Z254C           LDAA    ,X                       ; 254C: A6 00          
                CMPA    #$0D                     ; 254E: 81 0D          
                BEQ     Z255A                    ; 2550: 27 08          
                SWI                              ; 2552: 3F             
                FCB     $15                      ; 2553: 15             
                BCS     Z255A                    ; 2554: 25 04          
                INX                              ; 2556: 08             
                DECB                             ; 2557: 5A             
                BNE     Z254C                    ; 2558: 26 F2          
Z255A           PULB                             ; 255A: 33             
                RTS                              ; 255B: 39             
Z255C           LDX     #M26C5                   ; 255C: CE 26 C5       
                LDAA    $17,X                    ; 255F: A6 17          
                ANDA    #$07                     ; 2561: 84 07          
                CMPA    #$02                     ; 2563: 81 02          
                BNE     Z25AF                    ; 2565: 26 48          
                LDX     $15,X                    ; 2567: EE 15          
                STX     M27A9                    ; 2569: FF 27 A9       
                LDX     #M2630                   ; 256C: CE 26 30       
                STX     M27AB                    ; 256F: FF 27 AB       
                LDX     #M27A8                   ; 2572: CE 27 A8       
                LDAB    M26CF                    ; 2575: F6 26 CF       
                SWI                              ; 2578: 3F             
                FCB     $0E                      ; 2579: 0E             
                LDX     #M26EA                   ; 257A: CE 26 EA       
                LDX     $15,X                    ; 257D: EE 15          
                STX     M27A9                    ; 257F: FF 27 A9       
                LDX     M010E                    ; 2582: FE 01 0E       
                STX     M27AB                    ; 2585: FF 27 AB       
                LDX     #M27A8                   ; 2588: CE 27 A8       
                LDAB    M26F4                    ; 258B: F6 26 F4       
                SWI                              ; 258E: 3F             
                FCB     $0E                      ; 258F: 0E             
                LDX     #M26A5                   ; 2590: CE 26 A5       
                STX     M27AD                    ; 2593: FF 27 AD       
                LDX     M010E                    ; 2596: FE 01 0E       
                LDAA    #$75                     ; 2599: 86 75          
                SWI                              ; 259B: 3F             
                FCB     $28                      ; 259C: 28             
                STX     M27AF                    ; 259D: FF 27 AF       
                LDAB    #$0B                     ; 25A0: C6 0B          
                LDX     #M27AD                   ; 25A2: CE 27 AD       
                SWI                              ; 25A5: 3F             
                FCB     $10                      ; 25A6: 10             
                LDX     #M27A8                   ; 25A7: CE 27 A8       
                LDAB    M26F4                    ; 25AA: F6 26 F4       
                SWI                              ; 25AD: 3F             
                FCB     $0F                      ; 25AE: 0F             
Z25AF           RTS                              ; 25AF: 39             
M25B0           LDAA    ME800                    ; 25B0: B6 E8 00       
                CMPA    #$8E                     ; 25B3: 81 8E          
                LDAA    #$50                     ; 25B5: 86 50          
                BCS     Z2628                    ; 25B7: 25 6F          
                INC     CURDRV                   ; 25B9: 7C 00 00       
                JSR     ZE875                    ; 25BC: BD E8 75       
                JSR     ZEBC0                    ; 25BF: BD EB C0       
                LDX     #M00A0                   ; 25C2: CE 00 A0       
                LDAA    $75,X                    ; 25C5: A6 75          
                STAA    LSCTLN                   ; 25C7: 97 05          
                LDAB    ,X                       ; 25C9: E6 00          
                BMI     Z2626                    ; 25CB: 2B 59          
                ANDB    #$03                     ; 25CD: C4 03          
                LDAA    $01,X                    ; 25CF: A6 01          
                ASLA                             ; 25D1: 48             
                ROLB                             ; 25D2: 59             
                ASLA                             ; 25D3: 48             
                ROLB                             ; 25D4: 59             
                ADDA    #$01                     ; 25D5: 8B 01          
                ADCB    #$00                     ; 25D7: C9 00          
                STAB    STRSCTH                  ; 25D9: D7 01          
                STAA    STRSCTL                  ; 25DB: 97 02          
                LDAB    $7A,X                    ; 25DD: E6 7A          
                LDAA    $7B,X                    ; 25DF: A6 7B          
                PSHA                             ; 25E1: 36             
                PSHB                             ; 25E2: 37             
                LDAA    $77,X                    ; 25E3: A6 77          
                LDAB    $76,X                    ; 25E5: E6 76          
                STAA    NUMSCTL                  ; 25E7: 97 04          
                STAB    NUMSCTH                  ; 25E9: D7 03          
                LDX     $78,X                    ; 25EB: EE 78          
                STX     CURADRH                  ; 25ED: DF 06          
                LDX     #CURADRL                 ; 25EF: CE 00 07       
Z25F2           ASLA                             ; 25F2: 48             
                ROLB                             ; 25F3: 59             
                DEX                              ; 25F4: 09             
                BNE     Z25F2                    ; 25F5: 26 FB          
                ADDA    CURADRL                  ; 25F7: 9B 07          
                ADCB    CURADRH                  ; 25F9: D9 06          
                STAA    M000C                    ; 25FB: 97 0C          
                STAB    SECTCNT                  ; 25FD: D7 0B          
                LDX     #M007F                   ; 25FF: CE 00 7F       
Z2602           LDAA    #$AA                     ; 2602: 86 AA          
                INX                              ; 2604: 08             
                LDAB    ,X                       ; 2605: E6 00          
                STAA    ,X                       ; 2607: A7 00          
                CMPA    ,X                       ; 2609: A1 00          
                TPA                              ; 260B: 07             
                STAB    ,X                       ; 260C: E7 00          
                TAP                              ; 260E: 06             
                BNE     Z2621                    ; 260F: 26 10          
                CPX     SECTCNT                  ; 2611: 9C 0B          
                BNE     Z2602                    ; 2613: 26 ED          
                CLR     CURDRV                   ; 2615: 7F 00 00       
                LDAA    #$53                     ; 2618: 86 53          
                PSHA                             ; 261A: 36             
                LDAA    #$E8                     ; 261B: 86 E8          
                PSHA                             ; 261D: 36             
                JMP     ZE86D                    ; 261E: 7E E8 6D       
Z2621           STX     CURDRV                   ; 2621: DF 00          
                LDAA    #$4D                     ; 2623: 86 4D          
                CPX     #M863F                   ; 2625: 8C 86 3F       
Z2628           STAA    FDSTAT                   ; 2628: 97 08          
                COMB                             ; 262A: 53             
                JMP     ZE853                    ; 262B: 7E E8 53       
                FCB     $00,$00                  ; 262E: 00 00          
M2630           FCB     ' ,' ,' ,' ,' ,' ,' ,'   ; 2630: 20 20 20 20 20 20 20 20 
M2638           FCB     ' ,'                     ; 2638: 20 20          
M263A           FCB     ' ,'                     ; 263A: 20 20          
M263C           FCB     ' ,' ,' ,' ,' ,'         ; 263C: 20 20 20 20 20 20 
M2642           FCB     ' ,' ,' ,' ,' ,' ,' ,'   ; 2642: 20 20 20 20 20 20 20 20 
                FCB     ' ,' ,' ,' ,' ,' ,' ,'   ; 264A: 20 20 20 20 20 20 20 20 
                FCB     ' ,' ,' ,'               ; 2652: 20 20 20 20    
                FCB     $00,$00,$00,$00,$00,$00  ; 2656: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 265C: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2662: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2668: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 266E: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2674: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 267A: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2680: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2686: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 268C: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2692: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2698: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 269E: 00 00 00 00 00 00 
                FCB     $00                      ; 26A4: 00             
M26A5           FCB     $00,$00,$00,$00,$00,$00  ; 26A5: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00      ; 26AB: 00 00 00 00 00 
M26B0           FCB     $00,$00,$00,$00,$00,$00  ; 26B0: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 26B6: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 26BC: 00 00 00 00 00 00 
                FCB     $00,$00,$00              ; 26C2: 00 00 00       
M26C5           FCB     $00,$00,$00,$00,$00,$00  ; 26C5: 00 00 00 00 00 00 
                FCB     $00,$00                  ; 26CB: 00 00          
M26CD           FCB     $00,$00                  ; 26CD: 00 00          
M26CF           FCB     $00                      ; 26CF: 00             
M26D0           FCB     $00,$00,$00,$00,$00,$00  ; 26D0: 00 00 00 00 00 00 
                FCB     $00,$00                  ; 26D6: 00 00          
M26D8           FCB     $00,$00,$00,$00          ; 26D8: 00 00 00 00    
M26DC           FCB     $00,$00,$00,$00,$00,$00  ; 26DC: 00 00 00 00 00 00 
                FCB     $00,$00                  ; 26E2: 00 00          
M26E4           FCB     $00,$00                  ; 26E4: 00 00          
M26E6           FCB     $00,$00                  ; 26E6: 00 00          
M26E8           FCB     $00,$00                  ; 26E8: 00 00          
M26EA           FCB     $00,$00,$00,$00,$00,$00  ; 26EA: 00 00 00 00 00 00 
                FCB     $00,$00                  ; 26F0: 00 00          
M26F2           FCB     $00,$00                  ; 26F2: 00 00          
M26F4           FCB     $00                      ; 26F4: 00             
M26F5           FCB     $00,$00,$00,$00,$00,$00  ; 26F5: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00          ; 26FB: 00 00 00 00    
M26FF           FCB     $00,$00                  ; 26FF: 00 00          
M2701           FCB     $00,$00                  ; 2701: 00 00          
M2703           FCB     $00,$00,$00,$00          ; 2703: 00 00 00 00    
M2707           FCB     $00,$00                  ; 2707: 00 00          
M2709           FCB     $00,$00                  ; 2709: 00 00          
M270B           FCB     $00,$00                  ; 270B: 00 00          
M270D           FCB     $00,$00,$00,$00,$00,$00  ; 270D: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2713: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2719: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 271F: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2725: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 272B: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2731: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2737: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 273D: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2743: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2749: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 274F: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2755: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 275B: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2761: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2767: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 276D: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2773: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2779: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 277F: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2785: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00          ; 278B: 00 00 00 00    
M278F           FCB     $00                      ; 278F: 00             
M2790           FCB     ' ,' ,' ,' ,' ,' ,' ,'   ; 2790: 20 20 20 20 20 20 20 20 
                FCB     ' ,'                     ; 2798: 20 20          
                FCB     $00,$00                  ; 279A: 00 00          
M279C           FCB     $00,$00,$00,$00          ; 279C: 00 00 00 00    
M27A0           FCB     $00,$00,$00,$00          ; 27A0: 00 00 00 00    
                FCB     ''                       ; 27A4: 27             
                FCB     $0f                      ; 27A5: 0F             
                FCB     ''                       ; 27A6: 27             
                FCB     $8e                      ; 27A7: 8E             
M27A8           FCB     $00                      ; 27A8: 00             
M27A9           FCB     $00,$00                  ; 27A9: 00 00          
M27AB           FCB     $00,$00                  ; 27AB: 00 00          
M27AD           FCB     $00,$00                  ; 27AD: 00 00          
M27AF           FCB     $00,$00                  ; 27AF: 00 00          
M27B1           FCB     $00,$00                  ; 27B1: 00 00          
M27B3           FCB     '(,'o                    ; 27B3: 28 6F          
M27B5           FCB     '&,$b0                   ; 27B5: 26 B0          
M27B7           FCB     $00                      ; 27B7: 00             
M27B8           FCB     $00                      ; 27B8: 00             
M27B9           FCB     '&,$b0                   ; 27B9: 26 B0          
M27BB           FCB     $00                      ; 27BB: 00             
M27BC           FCB     $00                      ; 27BC: 00             
M27BD           FCB     $00,$00                  ; 27BD: 00 00          
M27BF           FCB     ''                       ; 27BF: 27             
                FCB     $c1                      ; 27C0: C1             
M27C1           FCB     ' ,' ,' ,' ,' ,' ,' ,'   ; 27C1: 20 20 20 20 20 20 20 20 
                FCB     ' ,' ,'                  ; 27C9: 20 20 20       
M27CC           FCB     $c5,$00                  ; 27CC: C5 00          
M27CE           FCB     $00,$00                  ; 27CE: 00 00          
M27D0           FCB     'M,'D,'O,'S,' ,' ,' ,'   ; 27D0: 4D 44 4F 53 20 20 20 20 
                FCB     'S,'Y                    ; 27D8: 53 59          
M27DA           FCB     'M,'D,'O,'S,'O,'V,'0,'   ; 27DA: 4D 44 4F 53 4F 56 30 20 
                FCB     'S,'Y,'M,'D,'O,'S,'O,'V  ; 27E2: 53 59 4D 44 4F 53 4F 56 
                FCB     '1,' ,'S,'Y,'M,'D,'O,'S  ; 27EA: 31 20 53 59 4D 44 4F 53 
                FCB     'O,'V,'2,' ,'S,'Y,'M,'D  ; 27F2: 4F 56 32 20 53 59 4D 44 
                FCB     'O,'S,'O,'V,'3,' ,'S,'Y  ; 27FA: 4F 53 4F 56 33 20 53 59 
                FCB     'M,'D,'O,'S,'O,'V,'4,'   ; 2802: 4D 44 4F 53 4F 56 34 20 
                FCB     'S,'Y,'M,'D,'O,'S,'O,'V  ; 280A: 53 59 4D 44 4F 53 4F 56 
                FCB     '5,' ,'S,'Y,'M,'D,'O,'S  ; 2812: 35 20 53 59 4D 44 4F 53 
                FCB     'O,'V,'6,' ,'S,'Y,'M,'D  ; 281A: 4F 56 36 20 53 59 4D 44 
                FCB     'O,'S,'E,'R,' ,' ,'S,'Y  ; 2822: 4F 53 45 52 20 20 53 59 
                FCB     $ff                      ; 282A: FF             
M282B           FCB     'D,'O,'S,'G,'E,'N,' ,'D  ; 282B: 44 4F 53 47 45 4E 20 44 
                FCB     'R,'I,'V,'E,'            ; 2833: 52 49 56 45 20 
M2838           FCB     ' ,' ,'?,'               ; 2838: 20 20 3F 20    
                FCB     $04                      ; 283C: 04             
M283D           FCB     'D,'I,'S,'K,' ,'N,'A,'M  ; 283D: 44 49 53 4B 20 4E 41 4D 
                FCB     'E,':,'                  ; 2845: 45 3A 20       
                FCB     $04                      ; 2848: 04             
M2849           FCB     'D,'A,'T,'E,' ,'(,'M,'M  ; 2849: 44 41 54 45 20 28 4D 4D 
                FCB     'D,'D,'Y,'Y,'),':,'      ; 2851: 44 44 59 59 29 3A 20 
                FCB     $04                      ; 2858: 04             
M2859           FCB     'U,'S,'E,'R,' ,'N,'A,'M  ; 2859: 55 53 45 52 20 4E 41 4D 
                FCB     'E,':,'                  ; 2861: 45 3A 20       
                FCB     $04                      ; 2864: 04             
M2865           FCB     'S,'E,'C,'T,'O,'R,' ,'0  ; 2865: 53 45 43 54 4F 52 20 30 
                FCB     '0,'0                    ; 286D: 30 30          
M286F           FCB     '0,' ,'L,'O,'C,'K,'E,'D  ; 286F: 30 20 4C 4F 43 4B 45 44 
                FCB     ' ,'O,'U,'T,'            ; 2877: 20 4F 55 54 20 
                FCB     $0d                      ; 287C: 0D             
M287D           FCB     'L,'O,'C,'K,'O,'U,'T,'   ; 287D: 4C 4F 43 4B 4F 55 54 20 
                FCB     'A,'D,'D,'I,'T,'I,'O,'N  ; 2885: 41 44 44 49 54 49 4F 4E 
                FCB     'A,'L,' ,'S,'E,'C,'T,'O  ; 288D: 41 4C 20 53 45 43 54 4F 
                FCB     'R,'S,':,'               ; 2895: 52 53 3A 20    
                FCB     $04                      ; 2899: 04             
M289A           FCB     'E,'N,'T,'E,'R,' ,'S,'T  ; 289A: 45 4E 54 45 52 20 53 54 
                FCB     'A,'R,'T,'I,'N,'G,' ,'S  ; 28A2: 41 52 54 49 4E 47 20 53 
                FCB     'E,'C,'T,'O,'R,' ,'(,'H  ; 28AA: 45 43 54 4F 52 20 28 48 
                FCB     'H,'H,'),':,'            ; 28B2: 48 48 29 3A 20 
                FCB     $04                      ; 28B7: 04             
M28B8           FCB     'E,'N,'T,'E,'R,' ,'E,'N  ; 28B8: 45 4E 54 45 52 20 45 4E 
                FCB     'D,'I,'N,'G,' ,'S,'E,'C  ; 28C0: 44 49 4E 47 20 53 45 43 
                FCB     'T,'O,'R,' ,'(,'H,'H,'H  ; 28C8: 54 4F 52 20 28 48 48 48 
                FCB     '),':,'                  ; 28D0: 29 3A 20       
                FCB     $04                      ; 28D3: 04             
M28D4           FCB     'A,'B,'O,'V,'E,' ,'S,'E  ; 28D4: 41 42 4F 56 45 20 53 45 
                FCB     'C,'T,'O,'R,'S,' ,'H,'A  ; 28DC: 43 54 4F 52 53 20 48 41 
                FCB     'V,'E,' ,'B,'E,'E,'N,'   ; 28E4: 56 45 20 42 45 45 4E 20 
                FCB     'L,'O,'C,'K,'E,'D,' ,'O  ; 28EC: 4C 4F 43 4B 45 44 20 4F 
                FCB     'U,'T                    ; 28F4: 55 54          
                FCB     $0d                      ; 28F6: 0D             
M28F7           FCB     'I,'N,'V,'A,'L,'I,'D,'   ; 28F7: 49 4E 56 41 4C 49 44 20 
                FCB     'S,'E,'C,'T,'O,'R,' ,'N  ; 28FF: 53 45 43 54 4F 52 20 4E 
                FCB     'U,'M,'B,'E,'R           ; 2907: 55 4D 42 45 52 
                FCB     $0d                      ; 290C: 0D             
M290D           FCB     'C,'O,'P,'Y,'I,'N,'G,'   ; 290D: 43 4F 50 59 49 4E 47 20 
                FCB     'F,'I,'L,'E,'            ; 2915: 46 49 4C 45 20 
M291A           FCB     ' ,' ,' ,' ,' ,' ,' ,'   ; 291A: 20 20 20 20 20 20 20 20 
                FCB     '.                       ; 2922: 2E             
M2923           FCB     ' ,'                     ; 2923: 20 20          
                FCB     $0d                      ; 2925: 0D             
M2926           FCB     'M,'D,'O,'S,'.,'S,'Y,'   ; 2926: 4D 44 4F 53 2E 53 59 20 
                FCB     'D,'O,'E,'S,' ,'N,'O,'T  ; 292E: 44 4F 45 53 20 4E 4F 54 
                FCB     ' ,'S,'T,'A,'R,'T,' ,'A  ; 2936: 20 53 54 41 52 54 20 41 
                FCB     'T,' ,'S,'E,'C,'T,'O,'R  ; 293E: 54 20 53 45 43 54 4F 52 
                FCB     ' ,'$,'1,'8              ; 2946: 20 24 31 38    
                FCB     $0d                      ; 294A: 0D             
M294B           FCB     'W,'R,'I,'T,'E,'/,'R,'E  ; 294B: 57 52 49 54 45 2F 52 45 
                FCB     'A,'D,' ,'T,'E,'S,'T,'   ; 2953: 41 44 20 54 45 53 54 20 
                FCB     'I,'N,' ,'P,'R,'O,'G,'R  ; 295B: 49 4E 20 50 52 4F 47 52 
                FCB     'E,'S,'S                 ; 2963: 45 53 53       
                FCB     $0d                      ; 2966: 0D             
Z2967           ANDB    #$0F                     ; 2967: C4 0F          
                LSRB                             ; 2969: 54             
                RORA                             ; 296A: 46             
                LSRB                             ; 296B: 54             
                RORA                             ; 296C: 46             
                ANDB    #$03                     ; 296D: C4 03          
                LSRB                             ; 296F: 54             
                RORA                             ; 2970: 46             
                RORB                             ; 2971: 56             
                RORA                             ; 2972: 46             
                RORB                             ; 2973: 56             
                LSRA                             ; 2974: 44             
                PSHA                             ; 2975: 36             
                ROLB                             ; 2976: 59             
                ROLB                             ; 2977: 59             
                ROLB                             ; 2978: 59             
                CLRA                             ; 2979: 4F             
                SEC                              ; 297A: 0D             
Z297B           RORA                             ; 297B: 46             
                DECB                             ; 297C: 5A             
                BGE     Z297B                    ; 297D: 2C FC          
                TAB                              ; 297F: 16             
                PULA                             ; 2980: 32             
                RTS                              ; 2981: 39             
Z2982           TSTB                             ; 2982: 5D             
                BEQ     Z29B4                    ; 2983: 27 2F          
                INC     $03,X                    ; 2985: 6C 03          
                BNE     Z298B                    ; 2987: 26 02          
                INC     $02,X                    ; 2989: 6C 02          
Z298B           STX     M29B5                    ; 298B: FF 29 B5       
Z298E           LDX     M29B5                    ; 298E: FE 29 B5       
                LDAA    $01,X                    ; 2991: A6 01          
                ANDA    #$0F                     ; 2993: 84 0F          
                CMPA    #$09                     ; 2995: 81 09          
                BLS     Z299B                    ; 2997: 23 02          
                ADDA    #$07                     ; 2999: 8B 07          
Z299B           ADDA    #$30                     ; 299B: 8B 30          
                TST     $03,X                    ; 299D: 6D 03          
                BNE     Z29A3                    ; 299F: 26 02          
                DEC     $02,X                    ; 29A1: 6A 02          
Z29A3           DEC     $03,X                    ; 29A3: 6A 03          
                LDX     $02,X                    ; 29A5: EE 02          
                STAA    ,X                       ; 29A7: A7 00          
                LDX     M29B5                    ; 29A9: FE 29 B5       
                BSR     Z29B7                    ; 29AC: 8D 09          
                DECB                             ; 29AE: 5A             
                BNE     Z298E                    ; 29AF: 26 DD          
                LDX     M29B5                    ; 29B1: FE 29 B5       
Z29B4           RTS                              ; 29B4: 39             
M29B5           FCB     $00                      ; 29B5: 00             
                FCB     $00                      ; 29B6: 00             
Z29B7           PSHA                             ; 29B7: 36             
                LDAA    #$04                     ; 29B8: 86 04          
Z29BA           LSR     ,X                       ; 29BA: 64 00          
                ROR     $01,X                    ; 29BC: 66 01          
                DECA                             ; 29BE: 4A             
                BNE     Z29BA                    ; 29BF: 26 F9          
                PULA                             ; 29C1: 32             
                RTS                              ; 29C2: 39             
Z29C3           TSTB                             ; 29C3: 5D             
                BEQ     Z29F1                    ; 29C4: 27 2B          
                STX     M29F2                    ; 29C6: FF 29 F2       
                CLR     $02,X                    ; 29C9: 6F 02          
                CLR     $03,X                    ; 29CB: 6F 03          
Z29CD           LDX     M29F2                    ; 29CD: FE 29 F2       
                LDX     ,X                       ; 29D0: EE 00          
                LDAA    ,X                       ; 29D2: A6 00          
                LDX     M29F2                    ; 29D4: FE 29 F2       
                INC     $01,X                    ; 29D7: 6C 01          
                BNE     Z29DD                    ; 29D9: 26 02          
                INC     ,X                       ; 29DB: 6C 00          
Z29DD           JSR     Z29F4                    ; 29DD: BD 29 F4       
                BCS     Z29F1                    ; 29E0: 25 0F          
                INX                              ; 29E2: 08             
                INX                              ; 29E3: 08             
                JSR     Z2A0F                    ; 29E4: BD 2A 0F       
                ORAA    $01,X                    ; 29E7: AA 01          
                STAA    $01,X                    ; 29E9: A7 01          
                DECB                             ; 29EB: 5A             
                BNE     Z29CD                    ; 29EC: 26 DF          
                LDX     M29F2                    ; 29EE: FE 29 F2       
Z29F1           RTS                              ; 29F1: 39             
M29F2           FCB     $00                      ; 29F2: 00             
                FCB     $00                      ; 29F3: 00             
Z29F4           CMPA    #$41                     ; 29F4: 81 41          
                BCS     Z2A02                    ; 29F6: 25 0A          
                PSHA                             ; 29F8: 36             
                ADDA    #$B9                     ; 29F9: 8B B9          
                PULA                             ; 29FB: 32             
                BCS     Z2A0E                    ; 29FC: 25 10          
                SUBA    #$07                     ; 29FE: 80 07          
                BRA     Z2A0C                    ; 2A00: 20 0A          
Z2A02           CMPA    #$30                     ; 2A02: 81 30          
                BCS     Z2A0E                    ; 2A04: 25 08          
                PSHA                             ; 2A06: 36             
                ADDA    #$C6                     ; 2A07: 8B C6          
                PULA                             ; 2A09: 32             
                BCS     Z2A0E                    ; 2A0A: 25 02          
Z2A0C           ANDA    #$0F                     ; 2A0C: 84 0F          
Z2A0E           RTS                              ; 2A0E: 39             
Z2A0F           PSHA                             ; 2A0F: 36             
                LDAA    #$04                     ; 2A10: 86 04          
Z2A12           ASL     $01,X                    ; 2A12: 68 01          
                ROL     ,X                       ; 2A14: 69 00          
                DECA                             ; 2A16: 4A             
                BNE     Z2A12                    ; 2A17: 26 F9          
                PULA                             ; 2A19: 32             
                RTS                              ; 2A1A: 39             


                END
