dasmfw: Disassembler Framework V0.35
Loaded: binary file "COPY.CM"
Loaded: Info file "copy.info"

;****************************************************
; Used Labels
;****************************************************

M00FE   EQU     $00FE
M0106   EQU     $0106
M0108   EQU     $0108
M0116   EQU     $0116
M020F   EQU     $020F
M2EA2   EQU     $2EA2
M2EA3   EQU     $2EA3
M434E   EQU     $434E
M444B   EQU     $444B
M5341   EQU     $5341
M5544   EQU     $5544
MFFFA   EQU     $FFFA
MFFFF   EQU     $FFFF

;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $2000

                FCB     '0,'3,'0,'0              ; 2000: 30 33 30 30    
START           CLI                              ; 2004: 0E             
                LDX     M00FE                    ; 2005: DE FE          
                STX     M29D1                    ; 2007: FF 29 D1       
                LDX     #M2C7B                   ; 200A: CE 2C 7B       
                STX     M29D3                    ; 200D: FF 29 D3       
                LDX     #M29D1                   ; 2010: CE 29 D1       
                SWI                              ; 2013: 3F             
                FCB     $1D                      ; 2014: 1D             
                BEQ     Z201E                    ; 2015: 27 07          
                BITB    #$07                     ; 2017: C5 07          
                BNE     Z2022                    ; 2019: 26 07          
                JMP     Z2123                    ; 201B: 7E 21 23       
Z201E           LDAB    #$01                     ; 201E: C6 01          
                BRA     Z2039                    ; 2020: 20 17          
Z2022           BITB    #$04                     ; 2022: C5 04          
                BNE     Z2029                    ; 2024: 26 03          
Z2026           JMP     Z2704                    ; 2026: 7E 27 04       
Z2029           LDAB    #$02                     ; 2029: C6 02          
                LDX     M2C7C                    ; 202B: FE 2C 7C       
                CPX     #M444B                   ; 202E: 8C 44 4B       
                BNE     Z2036                    ; 2031: 26 03          
Z2033           JMP     Z2708                    ; 2033: 7E 27 08       
Z2036           STX     M2C79                    ; 2036: FF 2C 79       
Z2039           ORAB    M2C58                    ; 2039: FA 2C 58       
                STAB    M2C58                    ; 203C: F7 2C 58       
                LDX     #M2CA0                   ; 203F: CE 2C A0       
                STX     M29D3                    ; 2042: FF 29 D3       
                LDX     #M29D1                   ; 2045: CE 29 D1       
                SWI                              ; 2048: 3F             
                FCB     $1D                      ; 2049: 1D             
                BEQ     Z2052                    ; 204A: 27 06          
                BITB    #$07                     ; 204C: C5 07          
                BNE     Z2056                    ; 204E: 26 06          
                BRA     Z206D                    ; 2050: 20 1B          
Z2052           LDAB    #$04                     ; 2052: C6 04          
                BRA     Z2067                    ; 2054: 20 11          
Z2056           BITB    #$04                     ; 2056: C5 04          
                BEQ     Z2026                    ; 2058: 27 CC          
                LDAB    #$08                     ; 205A: C6 08          
                LDX     M2CA1                    ; 205C: FE 2C A1       
                CPX     #M444B                   ; 205F: 8C 44 4B       
                BEQ     Z2033                    ; 2062: 27 CF          
                STX     M2C9E                    ; 2064: FF 2C 9E       
Z2067           ORAB    M2C58                    ; 2067: FA 2C 58       
                STAB    M2C58                    ; 206A: F7 2C 58       
Z206D           LDX     M29D1                    ; 206D: FE 29 D1       
                CLRB                             ; 2070: 5F             
Z2071           LDAA    ,X                       ; 2071: A6 00          
                INX                              ; 2073: 08             
                CMPA    #$0D                     ; 2074: 81 0D          
                BEQ     Z20CF                    ; 2076: 27 57          
                CMPA    #$3B                     ; 2078: 81 3B          
                BEQ     Z207E                    ; 207A: 27 02          
                BRA     Z2071                    ; 207C: 20 F3          
Z207E           LDAA    ,X                       ; 207E: A6 00          
                INX                              ; 2080: 08             
                STX     M29D1                    ; 2081: FF 29 D1       
                CMPA    #$0D                     ; 2084: 81 0D          
                BEQ     Z20CF                    ; 2086: 27 47          
                CMPA    #$20                     ; 2088: 81 20          
                BEQ     Z207E                    ; 208A: 27 F2          
                LDX     #M2C60                   ; 208C: CE 2C 60       
Z208F           CMPA    ,X                       ; 208F: A1 00          
                BNE     Z20C6                    ; 2091: 26 33          
                ORAB    $01,X                    ; 2093: EA 01          
                LDX     M29D1                    ; 2095: FE 29 D1       
                CMPA    #$44                     ; 2098: 81 44          
                BNE     Z207E                    ; 209A: 26 E2          
                LDAA    #$3D                     ; 209C: 86 3D          
                CMPA    ,X                       ; 209E: A1 00          
                BNE     Z20CC                    ; 20A0: 26 2A          
                LDX     #M2CBB                   ; 20A2: CE 2C BB       
                STX     M29D3                    ; 20A5: FF 29 D3       
                LDX     #M29D1                   ; 20A8: CE 29 D1       
                PSHB                             ; 20AB: 37             
                SWI                              ; 20AC: 3F             
                FCB     $1D                      ; 20AD: 1D             
                BEQ     Z20B7                    ; 20AE: 27 07          
                BITB    #$07                     ; 20B0: C5 07          
                BEQ     Z2123                    ; 20B2: 27 6F          
                JMP     Z2704                    ; 20B4: 7E 27 04       
Z20B7           PULB                             ; 20B7: 33             
                CMPA    #$0D                     ; 20B8: 81 0D          
                BEQ     Z20CF                    ; 20BA: 27 13          
                CMPA    #$2C                     ; 20BC: 81 2C          
                BNE     Z20CC                    ; 20BE: 26 0C          
                LDX     M29D1                    ; 20C0: FE 29 D1       
                INX                              ; 20C3: 08             
                BRA     Z207E                    ; 20C4: 20 B8          
Z20C6           INX                              ; 20C6: 08             
                INX                              ; 20C7: 08             
                TST     ,X                       ; 20C8: 6D 00          
                BNE     Z208F                    ; 20CA: 26 C3          
Z20CC           JMP     Z270C                    ; 20CC: 7E 27 0C       
Z20CF           STAB    M2C5B                    ; 20CF: F7 2C 5B       
                BITB    #$04                     ; 20D2: C5 04          
                BEQ     Z20DA                    ; 20D4: 27 04          
                BITB    #$60                     ; 20D6: C5 60          
                BEQ     Z20FE                    ; 20D8: 27 24          
Z20DA           BITB    #$40                     ; 20DA: C5 40          
                BEQ     Z20E2                    ; 20DC: 27 04          
                BITB    #$20                     ; 20DE: C5 20          
                BNE     Z20FE                    ; 20E0: 26 1C          
Z20E2           LDX     #M5544                   ; 20E2: CE 55 44       
                BITB    #$80                     ; 20E5: C5 80          
                BEQ     Z2101                    ; 20E7: 27 18          
                LDAB    M2C58                    ; 20E9: F6 2C 58       
                BITB    #$02                     ; 20EC: C5 02          
                BEQ     Z20F5                    ; 20EE: 27 05          
                CPX     M2C7C                    ; 20F0: BC 2C 7C       
                BEQ     Z211C                    ; 20F3: 27 27          
Z20F5           BITB    #$08                     ; 20F5: C5 08          
                BEQ     Z20FE                    ; 20F7: 27 05          
                CPX     M2CA1                    ; 20F9: BC 2C A1       
                BEQ     Z211C                    ; 20FC: 27 1E          
Z20FE           JMP     Z2714                    ; 20FE: 7E 27 14       
Z2101           BITB    #$02                     ; 2101: C5 02          
                BNE     Z20FE                    ; 2103: 26 F9          
                LDAB    M2C58                    ; 2105: F6 2C 58       
                BITB    #$02                     ; 2108: C5 02          
                BEQ     Z2113                    ; 210A: 27 07          
                CPX     M2C7C                    ; 210C: BC 2C 7C       
                BEQ     Z20FE                    ; 210F: 27 ED          
                BRA     Z211C                    ; 2111: 20 09          
Z2113           BITB    #$08                     ; 2113: C5 08          
                BEQ     Z211C                    ; 2115: 27 05          
                CPX     M2CA1                    ; 2117: BC 2C A1       
                BEQ     Z20FE                    ; 211A: 27 E2          
Z211C           TBA                              ; 211C: 17             
                ANDB    #$0A                     ; 211D: C4 0A          
                CMPB    #$0A                     ; 211F: C1 0A          
                BNE     Z2126                    ; 2121: 26 03          
Z2123           JMP     Z26F9                    ; 2123: 7E 26 F9       
Z2126           BITA    #$01                     ; 2126: 85 01          
                BEQ     Z213F                    ; 2128: 27 15          
                BITA    #$0C                     ; 212A: 85 0C          
                BNE     Z213F                    ; 212C: 26 11          
                LDAB    #$20                     ; 212E: C6 20          
                CMPB    M2CA0                    ; 2130: F1 2C A0       
                BNE     Z213A                    ; 2133: 26 05          
                CMPB    M2CA9                    ; 2135: F1 2C A9       
                BEQ     Z2123                    ; 2138: 27 E9          
Z213A           ORAA    #$04                     ; 213A: 8A 04          
                STAA    M2C58                    ; 213C: B7 2C 58       
Z213F           ANDA    #$05                     ; 213F: 84 05          
                CMPA    #$05                     ; 2141: 81 05          
                BEQ     Z2148                    ; 2143: 27 03          
                JMP     Z241E                    ; 2145: 7E 24 1E       
Z2148           LDAB    #$20                     ; 2148: C6 20          
                CMPB    M2CA0                    ; 214A: F1 2C A0       
                BNE     Z2155                    ; 214D: 26 06          
                LDAA    M2C7B                    ; 214F: B6 2C 7B       
                STAA    M2CA0                    ; 2152: B7 2C A0       
Z2155           CMPB    M2CA9                    ; 2155: F1 2C A9       
                BNE     Z2160                    ; 2158: 26 06          
                LDX     M2C84                    ; 215A: FE 2C 84       
                STX     M2CA9                    ; 215D: FF 2C A9       
Z2160           CMPB    M2CA1                    ; 2160: F1 2C A1       
                BNE     Z2178                    ; 2163: 26 13          
                LDX     #M2C7C                   ; 2165: CE 2C 7C       
                STX     M29D1                    ; 2168: FF 29 D1       
                LDX     #M2CA1                   ; 216B: CE 2C A1       
                STX     M29D3                    ; 216E: FF 29 D3       
                LDX     #M29D1                   ; 2171: CE 29 D1       
                LDAB    #$08                     ; 2174: C6 08          
                SWI                              ; 2176: 3F             
                SBA                              ; 2177: 10             
Z2178           LDAB    #$74                     ; 2178: C6 74          
                COMB                             ; 217A: 53             
                BITB    M2C5B                    ; 217B: F5 2C 5B       
                BEQ     Z2183                    ; 217E: 27 03          
Z2180           JMP     Z2714                    ; 2180: 7E 27 14       
Z2183           LDAB    M2C5B                    ; 2183: F6 2C 5B       
                ANDB    #$50                     ; 2186: C4 50          
                CMPB    #$50                     ; 2188: C1 50          
                BEQ     Z2180                    ; 218A: 27 F4          
                LDAB    #$20                     ; 218C: C6 20          
                ORAB    M2C72                    ; 218E: FA 2C 72       
                STAB    M2C72                    ; 2191: F7 2C 72       
                LDAB    #$20                     ; 2194: C6 20          
                ORAB    M2C97                    ; 2196: FA 2C 97       
                STAB    M2C97                    ; 2199: F7 2C 97       
                JSR     Z2969                    ; 219C: BD 29 69       
                BCC     Z21A4                    ; 219F: 24 03          
                JMP     Z272F                    ; 21A1: 7E 27 2F       
Z21A4           LDAB    M2C5B                    ; 21A4: F6 2C 5B       
                BITB    #$20                     ; 21A7: C5 20          
                BEQ     Z21BE                    ; 21A9: 27 13          
                LDX     #M2C9E                   ; 21AB: CE 2C 9E       
                STX     M29D1                    ; 21AE: FF 29 D1       
                LDX     #M29BD                   ; 21B1: CE 29 BD       
                STX     M29D3                    ; 21B4: FF 29 D3       
                LDAB    #$0D                     ; 21B7: C6 0D          
                LDX     #M29D1                   ; 21B9: CE 29 D1       
                SWI                              ; 21BC: 3F             
                SBA                              ; 21BD: 10             
Z21BE           LDX     #M2C71                   ; 21BE: CE 2C 71       
                SWI                              ; 21C1: 3F             
                FCB     $00                      ; 21C2: 00             
                BEQ     Z21C8                    ; 21C3: 27 03          
Z21C5           JMP     Z26F0                    ; 21C5: 7E 26 F0       
Z21C8           SWI                              ; 21C8: 3F             
                FCB     $02                      ; 21C9: 02             
                BNE     Z21C5                    ; 21CA: 26 F9          
                LDAB    M2C5B                    ; 21CC: F6 2C 5B       
                BITB    #$40                     ; 21CF: C5 40          
                BEQ     Z21D6                    ; 21D1: 27 03          
                JMP     Z22DD                    ; 21D3: 7E 22 DD       
Z21D6           LDAB    M2C88                    ; 21D6: F6 2C 88       
                ANDB    #$7F                     ; 21D9: C4 7F          
                STAB    M2CAD                    ; 21DB: F7 2C AD       
                LDAB    M2C89                    ; 21DE: F6 2C 89       
                STAB    M2CAE                    ; 21E1: F7 2C AE       
                LDX     M2C8A                    ; 21E4: FE 2C 8A       
                STX     M2CAF                    ; 21E7: FF 2C AF       
                LDX     M2C84                    ; 21EA: FE 2C 84       
                INX                              ; 21ED: 08             
                INX                              ; 21EE: 08             
                STX     M2CB3                    ; 21EF: FF 2C B3       
                JSR     Z27A8                    ; 21F2: BD 27 A8       
                LDAB    #$03                     ; 21F5: C6 03          
                ORAB    M2C97                    ; 21F7: FA 2C 97       
                STAB    M2C97                    ; 21FA: F7 2C 97       
                LDX     #M2C96                   ; 21FD: CE 2C 96       
                SWI                              ; 2200: 3F             
                FCB     $00                      ; 2201: 00             
                BNE     Z21C5                    ; 2202: 26 C1          
Z2204           SWI                              ; 2204: 3F             
                FCB     $02                      ; 2205: 02             
                BEQ     Z221E                    ; 2206: 27 16          
                TST     M2CB3                    ; 2208: 7D 2C B3       
                BNE     Z2212                    ; 220B: 26 05          
                TST     M2CB4                    ; 220D: 7D 2C B4       
                BEQ     Z21C5                    ; 2210: 27 B3          
Z2212           CMPB    #$12                     ; 2212: C1 12          
                BNE     Z21C5                    ; 2214: 26 AF          
                CLR     M2CB3                    ; 2216: 7F 2C B3       
                CLR     M2CB4                    ; 2219: 7F 2C B4       
                BRA     Z2204                    ; 221C: 20 E6          
Z221E           JSR     Z2733                    ; 221E: BD 27 33       
                LDX     #M2C71                   ; 2221: CE 2C 71       
                SWI                              ; 2224: 3F             
                TPA                              ; 2225: 07             
                BNE     Z222B                    ; 2226: 26 03          
                JMP     Z22CA                    ; 2228: 7E 22 CA       
Z222B           CMPB    #$09                     ; 222B: C1 09          
                BNE     Z21C5                    ; 222D: 26 96          
                LDAB    M2C88                    ; 222F: F6 2C 88       
                ANDB    #$07                     ; 2232: C4 07          
                CMPB    #$02                     ; 2234: C1 02          
                BNE     Z228F                    ; 2236: 26 57          
                LDX     #MFFFF                   ; 2238: CE FF FF       
                STX     M2C82                    ; 223B: FF 2C 82       
                STX     M2CA7                    ; 223E: FF 2C A7       
                LDX     M2C90                    ; 2241: FE 2C 90       
                LDAB    #$7F                     ; 2244: C6 7F          
Z2246           SWI                              ; 2246: 3F             
                BEQ     Z2248                    ; 2247: 27 FF          
                BGE     Z21DD                    ; 2249: 2C 92          
                LDX     #M2C71                   ; 224B: CE 2C 71       
                SWI                              ; 224E: 3F             
                TPA                              ; 224F: 07             
                BEQ     Z2255                    ; 2250: 27 03          
                JMP     Z22DA                    ; 2252: 7E 22 DA       
Z2255           LDX     #M29D6                   ; 2255: CE 29 D6       
                STX     M2CB5                    ; 2258: FF 2C B5       
                LDX     #M2A55                   ; 225B: CE 2A 55       
                STX     M2CB7                    ; 225E: FF 2C B7       
                STX     M2CB9                    ; 2261: FF 2C B9       
                LDX     #M2C96                   ; 2264: CE 2C 96       
                SWI                              ; 2267: 3F             
                TPA                              ; 2268: 07             
                BNE     Z22DA                    ; 2269: 26 6F          
                LDX     M2C90                    ; 226B: FE 2C 90       
                LDAB    #$75                     ; 226E: C6 75          
                SWI                              ; 2270: 3F             
                BEQ     Z2272                    ; 2271: 27 FF          
                BVS     Z2246                    ; 2273: 29 D1          
                LDX     #M2A4B                   ; 2275: CE 2A 4B       
                STX     M29D3                    ; 2278: FF 29 D3       
                LDX     #M29D1                   ; 227B: CE 29 D1       
                LDAB    #$0B                     ; 227E: C6 0B          
                SWI                              ; 2280: 3F             
                SBA                              ; 2281: 10             
                LDX     #MFFFF                   ; 2282: CE FF FF       
                STX     M2CA7                    ; 2285: FF 2C A7       
                LDX     #M2C96                   ; 2288: CE 2C 96       
                SWI                              ; 228B: 3F             
                INX                              ; 228C: 08             
                BNE     Z22DA                    ; 228D: 26 4B          
Z228F           LDAB    M2C5B                    ; 228F: F6 2C 5B       
                BITB    #$20                     ; 2292: C5 20          
                BEQ     Z22B8                    ; 2294: 27 22          
                JSR     Z2743                    ; 2296: BD 27 43       
                LDX     #M2C71                   ; 2299: CE 2C 71       
                SWI                              ; 229C: 3F             
                TAP                              ; 229D: 06             
                BEQ     Z22A3                    ; 229E: 27 03          
                JMP     Z26F0                    ; 22A0: 7E 26 F0       
Z22A3           LDX     #M29BD                   ; 22A3: CE 29 BD       
                STX     M29D1                    ; 22A6: FF 29 D1       
                LDX     #M2C9E                   ; 22A9: CE 2C 9E       
                STX     M29D3                    ; 22AC: FF 29 D3       
                LDX     #M29D1                   ; 22AF: CE 29 D1       
                LDAB    #$0D                     ; 22B2: C6 0D          
                SWI                              ; 22B4: 3F             
                SBA                              ; 22B5: 10             
                BRA     Z22DD                    ; 22B6: 20 25          
Z22B8           JSR     Z273D                    ; 22B8: BD 27 3D       
                TST     M29CA                    ; 22BB: 7D 29 CA       
                BEQ     Z22C8                    ; 22BE: 27 08          
                LDAB    #$42                     ; 22C0: C6 42          
                SUBB    M29CA                    ; 22C2: F0 29 CA       
                JSR     Z282A                    ; 22C5: BD 28 2A       
Z22C8           SWI                              ; 22C8: 3F             
                FCB     $1A                      ; 22C9: 1A             
Z22CA           LDX     M2C94                    ; 22CA: FE 2C 94       
                STX     M2CB9                    ; 22CD: FF 2C B9       
                LDX     #M2C96                   ; 22D0: CE 2C 96       
                SWI                              ; 22D3: 3F             
                INX                              ; 22D4: 08             
                BNE     Z22DA                    ; 22D5: 26 03          
                JMP     Z221E                    ; 22D7: 7E 22 1E       
Z22DA           JMP     Z26F0                    ; 22DA: 7E 26 F0       
Z22DD           LDX     M2A56                    ; 22DD: FE 2A 56       
                STX     M2CB5                    ; 22E0: FF 2C B5       
                DEX                              ; 22E3: 09             
                STX     M2C92                    ; 22E4: FF 2C 92       
                STX     M2C94                    ; 22E7: FF 2C 94       
                LDX     M2A58                    ; 22EA: FE 2A 58       
                STX     M2CB7                    ; 22ED: FF 2C B7       
                LDX     #M2C96                   ; 22F0: CE 2C 96       
                JSR     Z2787                    ; 22F3: BD 27 87       
                LDX     M2CB7                    ; 22F6: FE 2C B7       
                INX                              ; 22F9: 08             
                STX     M29CD                    ; 22FA: FF 29 CD       
                STX     M29CF                    ; 22FD: FF 29 CF       
Z2300           JSR     Z2733                    ; 2300: BD 27 33       
                LDX     #M2C71                   ; 2303: CE 2C 71       
                LDAB    $23,X                    ; 2306: E6 23          
                LDAA    $24,X                    ; 2308: A6 24          
                LDX     M29CD                    ; 230A: FE 29 CD       
                SWI                              ; 230D: 3F             
                BLE     Z2335                    ; 230E: 2F 25          
                FCB     $03                      ; 2310: 03             
                JMP     Z23A4                    ; 2311: 7E 23 A4       
                LDX     #M2C71                   ; 2314: CE 2C 71       
                LDAB    $1F,X                    ; 2317: E6 1F          
                LDAA    $20,X                    ; 2319: A6 20          
                STAB    M29CD                    ; 231B: F7 29 CD       
                STAA    M29CE                    ; 231E: B7 29 CE       
                SWI                              ; 2321: 3F             
                TPA                              ; 2322: 07             
                BEQ     Z23A4                    ; 2323: 27 7F          
                CMPB    #$09                     ; 2325: C1 09          
                BEQ     Z232C                    ; 2327: 27 03          
Z2329           JMP     Z26F0                    ; 2329: 7E 26 F0       
Z232C           LDX     #M2C96                   ; 232C: CE 2C 96       
                LDAB    $23,X                    ; 232F: E6 23          
                LDAA    $24,X                    ; 2331: A6 24          
                LDX     M29CF                    ; 2333: FE 29 CF       
                SWI                              ; 2336: 3F             
                BLE     Z235D                    ; 2337: 2F 24          
                TPA                              ; 2339: 07             
                LDX     #M2C96                   ; 233A: CE 2C 96       
                SWI                              ; 233D: 3F             
                TPA                              ; 233E: 07             
                BNE     Z2344                    ; 233F: 26 03          
                JMP     Z2401                    ; 2341: 7E 24 01       
Z2344           CMPB    #$09                     ; 2344: C1 09          
                BNE     Z2329                    ; 2346: 26 E1          
                LDAB    M2C88                    ; 2348: F6 2C 88       
                ANDB    #$07                     ; 234B: C4 07          
                CMPB    #$02                     ; 234D: C1 02          
                BEQ     Z2354                    ; 234F: 27 03          
Z2351           JMP     Z22B8                    ; 2351: 7E 22 B8       
Z2354           LDX     #MFFFF                   ; 2354: CE FF FF       
                STX     M2C82                    ; 2357: FF 2C 82       
                STX     M2CA7                    ; 235A: FF 2C A7       
Z235D           STX     M29CB                    ; 235D: FF 29 CB       
                LDX     M2C90                    ; 2360: FE 2C 90       
                LDAB    #$7F                     ; 2363: C6 7F          
                SWI                              ; 2365: 3F             
                BEQ     Z2367                    ; 2366: 27 FF          
                BGE     Z22FC                    ; 2368: 2C 92          
                LDX     #M29D6                   ; 236A: CE 29 D6       
                STX     M2CB5                    ; 236D: FF 2C B5       
                LDX     #M2A55                   ; 2370: CE 2A 55       
                STX     M2CB7                    ; 2373: FF 2C B7       
                LDX     #M2C71                   ; 2376: CE 2C 71       
                SWI                              ; 2379: 3F             
                TPA                              ; 237A: 07             
                BNE     Z2329                    ; 237B: 26 AC          
                LDX     #M2C96                   ; 237D: CE 2C 96       
                SWI                              ; 2380: 3F             
                TPA                              ; 2381: 07             
                BNE     Z2329                    ; 2382: 26 A5          
                LDX     M2C90                    ; 2384: FE 2C 90       
                LDAB    #$75                     ; 2387: C6 75          
                SWI                              ; 2389: 3F             
                BEQ     Z238B                    ; 238A: 27 FF          
                BVS     Z235F                    ; 238C: 29 D1          
                LDX     #M2A4B                   ; 238E: CE 2A 4B       
                STX     M29D3                    ; 2391: FF 29 D3       
                LDAB    #$0B                     ; 2394: C6 0B          
Z2396           LDX     #M29D1                   ; 2396: CE 29 D1       
                SWI                              ; 2399: 3F             
                CBA                              ; 239A: 11             
                BEQ     Z2351                    ; 239B: 27 B4          
                JSR     Z2867                    ; 239D: BD 28 67       
                BNE     Z2396                    ; 23A0: 26 F4          
                BRA     Z2351                    ; 23A2: 20 AD          
Z23A4           LDX     #M2C96                   ; 23A4: CE 2C 96       
                LDAB    $23,X                    ; 23A7: E6 23          
                LDAA    $24,X                    ; 23A9: A6 24          
                LDX     M29CF                    ; 23AB: FE 29 CF       
                SWI                              ; 23AE: 3F             
                BLE     Z23D5                    ; 23AF: 2F 24          
                FCB     $18                      ; 23B1: 18             
                LDX     #M2C96                   ; 23B2: CE 2C 96       
                LDAB    $1F,X                    ; 23B5: E6 1F          
                LDAA    $20,X                    ; 23B7: A6 20          
                STAB    M29CF                    ; 23B9: F7 29 CF       
                STAA    M29D0                    ; 23BC: B7 29 D0       
                SWI                              ; 23BF: 3F             
                TPA                              ; 23C0: 07             
                BEQ     Z23CA                    ; 23C1: 27 07          
                CMPB    #$09                     ; 23C3: C1 09          
                BEQ     Z2401                    ; 23C5: 27 3A          
                JMP     Z26F0                    ; 23C7: 7E 26 F0       
Z23CA           LDX     M29CD                    ; 23CA: FE 29 CD       
                STX     M29D1                    ; 23CD: FF 29 D1       
                LDX     M29CF                    ; 23D0: FE 29 CF       
                STX     M29D3                    ; 23D3: FF 29 D3       
                LDAB    #$80                     ; 23D6: C6 80          
Z23D8           LDX     #M29D1                   ; 23D8: CE 29 D1       
                SWI                              ; 23DB: 3F             
                SEC                              ; 23DC: 0D             
                BCC     Z23E2                    ; 23DD: 24 03          
                JMP     Z22B8                    ; 23DF: 7E 22 B8       
Z23E2           SWI                              ; 23E2: 3F             
                CBA                              ; 23E3: 11             
                BEQ     Z23EB                    ; 23E4: 27 05          
                JSR     Z2867                    ; 23E6: BD 28 67       
                BNE     Z23D8                    ; 23E9: 26 ED          
Z23EB           LDX     M29D1                    ; 23EB: FE 29 D1       
                STX     M29CD                    ; 23EE: FF 29 CD       
                LDX     M29D3                    ; 23F1: FE 29 D3       
                STX     M29CF                    ; 23F4: FF 29 CF       
                LDX     M29CB                    ; 23F7: FE 29 CB       
                INX                              ; 23FA: 08             
                STX     M29CB                    ; 23FB: FF 29 CB       
                JMP     Z2300                    ; 23FE: 7E 23 00       
Z2401           LDX     M29CB                    ; 2401: FE 29 CB       
                STX     M29D1                    ; 2404: FF 29 D1       
                LDX     #M2D21                   ; 2407: CE 2D 21       
                STX     M29D3                    ; 240A: FF 29 D3       
                LDX     #M29D1                   ; 240D: CE 29 D1       
                LDAB    #$04                     ; 2410: C6 04          
                JSR     Z2DE2                    ; 2412: BD 2D E2       
                LDX     #M2D17                   ; 2415: CE 2D 17       
Z2418           JSR     Z2834                    ; 2418: BD 28 34       
                JMP     Z22B8                    ; 241B: 7E 22 B8       
Z241E           LDAB    M2C5B                    ; 241E: F6 2C 5B       
                BITB    #$20                     ; 2421: C5 20          
                BEQ     Z2428                    ; 2423: 27 03          
                JMP     Z2714                    ; 2425: 7E 27 14       
Z2428           BITB    #$80                     ; 2428: C5 80          
                BEQ     Z247F                    ; 242A: 27 53          
                LDX     M0106                    ; 242C: FE 01 06       
                STX     M2C5E                    ; 242F: FF 2C 5E       
                LDX     M0108                    ; 2432: FE 01 08       
                STX     M0106                    ; 2435: FF 01 06       
                LDAB    #$10                     ; 2438: C6 10          
                LDX     #M2CBB                   ; 243A: CE 2C BB       
                SWI                              ; 243D: 3F             
                ABA                              ; 243E: 1B             
                LDX     M2C5E                    ; 243F: FE 2C 5E       
                STX     M0106                    ; 2442: FF 01 06       
                BCC     Z245F                    ; 2445: 24 18          
                CMPB    #$03                     ; 2447: C1 03          
                BNE     Z244E                    ; 2449: 26 03          
                JMP     Z26FD                    ; 244B: 7E 26 FD       
Z244E           CMPB    #$04                     ; 244E: C1 04          
                BNE     Z2455                    ; 2450: 26 03          
                JMP     Z2724                    ; 2452: 7E 27 24       
Z2455           CMPB    #$05                     ; 2455: C1 05          
                BNE     Z245C                    ; 2457: 26 03          
                JMP     Z2718                    ; 2459: 7E 27 18       
Z245C           JMP     Z2710                    ; 245C: 7E 27 10       
Z245F           LDAB    M2C5B                    ; 245F: F6 2C 5B       
                BITB    #$02                     ; 2462: C5 02          
                BEQ     Z247F                    ; 2464: 27 19          
                LDAA    M2C5D                    ; 2466: B6 2C 5D       
                PSHA                             ; 2469: 36             
                LDAA    M2C5C                    ; 246A: B6 2C 5C       
                PSHA                             ; 246D: 36             
                DES                              ; 246E: 34             
                DES                              ; 246F: 34             
                DES                              ; 2470: 34             
                DES                              ; 2471: 34             
                TPA                              ; 2472: 07             
                PSHA                             ; 2473: 36             
                LDX     #M020F                   ; 2474: CE 02 0F       
                STX     MFFFA                    ; 2477: FF FF FA       
                LDX     M0116                    ; 247A: FE 01 16       
                JMP     ,X                       ; 247D: 6E 00          
Z247F           LDAB    #$20                     ; 247F: C6 20          
                CMPB    M2CA0                    ; 2481: F1 2C A0       
                BNE     Z248B                    ; 2484: 26 05          
                LDAB    #$30                     ; 2486: C6 30          
                STAB    M2CA0                    ; 2488: F7 2C A0       
Z248B           JSR     Z2969                    ; 248B: BD 29 69       
                BCC     Z2493                    ; 248E: 24 03          
                JMP     Z272F                    ; 2490: 7E 27 2F       
Z2493           LDAB    M2C58                    ; 2493: F6 2C 58       
                BITB    #$01                     ; 2496: C5 01          
                BNE     Z249D                    ; 2498: 26 03          
                JMP     Z263A                    ; 249A: 7E 26 3A       
Z249D           LDX     #M2C7C                   ; 249D: CE 2C 7C       
                STX     M29D1                    ; 24A0: FF 29 D1       
                LDX     #M2CA1                   ; 24A3: CE 2C A1       
                STX     M29D3                    ; 24A6: FF 29 D3       
                LDX     #M29D1                   ; 24A9: CE 29 D1       
                LDAB    #$0A                     ; 24AC: C6 0A          
                SWI                              ; 24AE: 3F             
                SBA                              ; 24AF: 10             
                LDX     #M2C71                   ; 24B0: CE 2C 71       
                SWI                              ; 24B3: 3F             
                FCB     $00                      ; 24B4: 00             
                BEQ     Z24BA                    ; 24B5: 27 03          
Z24B7           JMP     Z26F0                    ; 24B7: 7E 26 F0       
Z24BA           SWI                              ; 24BA: 3F             
                FCB     $02                      ; 24BB: 02             
                BNE     Z24B7                    ; 24BC: 26 F9          
                LDAB    M2C88                    ; 24BE: F6 2C 88       
                ANDB    #$07                     ; 24C1: C4 07          
                CMPB    #$05                     ; 24C3: C1 05          
                BEQ     Z24CE                    ; 24C5: 27 07          
                CMPB    #$03                     ; 24C7: C1 03          
                BEQ     Z24CE                    ; 24C9: 27 03          
                JMP     Z271C                    ; 24CB: 7E 27 1C       
Z24CE           LDAA    M2C5B                    ; 24CE: B6 2C 5B       
                BITA    #$10                     ; 24D1: 85 10          
                BEQ     Z24D8                    ; 24D3: 27 03          
Z24D5           JMP     Z2714                    ; 24D5: 7E 27 14       
Z24D8           BITA    #$08                     ; 24D8: 85 08          
                BEQ     Z24E4                    ; 24DA: 27 08          
                CMPB    #$03                     ; 24DC: C1 03          
                BNE     Z24D5                    ; 24DE: 26 F5          
                LDAB    #$07                     ; 24E0: C6 07          
                BRA     Z24EA                    ; 24E2: 20 06          
Z24E4           CMPB    #$05                     ; 24E4: C1 05          
                BEQ     Z24EA                    ; 24E6: 27 02          
                LDAB    #$01                     ; 24E8: C6 01          
Z24EA           LDAA    M2C88                    ; 24EA: B6 2C 88       
                ANDA    #$78                     ; 24ED: 84 78          
                ABA                              ; 24EF: 1B             
                STAA    M2CAD                    ; 24F0: B7 2C AD       
                LDAA    M2C5B                    ; 24F3: B6 2C 5B       
                BITA    #$01                     ; 24F6: 85 01          
                BEQ     Z2508                    ; 24F8: 27 0E          
                CMPB    #$05                     ; 24FA: C1 05          
                BNE     Z24D5                    ; 24FC: 26 D7          
                LDAA    #$04                     ; 24FE: 86 04          
                ORAA    M2C97                    ; 2500: BA 2C 97       
                STAA    M2C97                    ; 2503: B7 2C 97       
                BRA     Z250B                    ; 2506: 20 03          
Z2508           INC     M29D5                    ; 2508: 7C 29 D5       
Z250B           LDAA    M2C5B                    ; 250B: B6 2C 5B       
                BITA    #$40                     ; 250E: 85 40          
                BNE     Z255D                    ; 2510: 26 4B          
                LDAB    #$02                     ; 2512: C6 02          
Z2514           ORAB    M2C97                    ; 2514: FA 2C 97       
                STAB    M2C97                    ; 2517: F7 2C 97       
                LDX     #M2C96                   ; 251A: CE 2C 96       
                JSR     Z2934                    ; 251D: BD 29 34       
                BEQ     Z2529                    ; 2520: 27 07          
                SWI                              ; 2522: 3F             
                FCB     $00                      ; 2523: 00             
                BEQ     Z2529                    ; 2524: 27 03          
Z2526           JMP     Z26F0                    ; 2526: 7E 26 F0       
Z2529           SWI                              ; 2529: 3F             
                FCB     $02                      ; 252A: 02             
                BNE     Z2526                    ; 252B: 26 F9          
Z252D           JSR     Z2733                    ; 252D: BD 27 33       
                LDX     #M2C71                   ; 2530: CE 2C 71       
                SWI                              ; 2533: 3F             
                FCB     $04                      ; 2534: 04             
                BEQ     Z253E                    ; 2535: 27 07          
                CMPB    #$09                     ; 2537: C1 09          
                BNE     Z2526                    ; 2539: 26 EB          
                JMP     Z22B8                    ; 253B: 7E 22 B8       
Z253E           TST     M29D5                    ; 253E: 7D 29 D5       
                BNE     Z254E                    ; 2541: 26 0B          
                LDX     M2C75                    ; 2543: FE 2C 75       
                CPX     M2C73                    ; 2546: BC 2C 73       
                BEQ     Z252D                    ; 2549: 27 E2          
                INC     M29D5                    ; 254B: 7C 29 D5       
Z254E           LDX     M2C73                    ; 254E: FE 2C 73       
                STX     M2C9C                    ; 2551: FF 2C 9C       
                LDX     #M2C96                   ; 2554: CE 2C 96       
                SWI                              ; 2557: 3F             
                FCB     $05                      ; 2558: 05             
                BNE     Z2526                    ; 2559: 26 CB          
                BRA     Z252D                    ; 255B: 20 D0          
Z255D           LDX     #M434E                   ; 255D: CE 43 4E       
                CPX     M2C9E                    ; 2560: BC 2C 9E       
                BNE     Z2568                    ; 2563: 26 03          
                JMP     Z2708                    ; 2565: 7E 27 08       
Z2568           LDX     #M2B59                   ; 2568: CE 2B 59       
                STX     M2C9A                    ; 256B: FF 2C 9A       
                LDX     #M2C57                   ; 256E: CE 2C 57       
                STX     M2C9C                    ; 2571: FF 2C 9C       
                LDAB    M2C5B                    ; 2574: F6 2C 5B       
                BITB    #$01                     ; 2577: C5 01          
                BNE     Z257E                    ; 2579: 26 03          
                INC     M29D5                    ; 257B: 7C 29 D5       
Z257E           JSR     Z2787                    ; 257E: BD 27 87       
Z2581           JSR     Z2733                    ; 2581: BD 27 33       
                LDAA    #$01                     ; 2584: 86 01          
                JSR     Z2927                    ; 2586: BD 29 27       
                LDX     #M2C71                   ; 2589: CE 2C 71       
                SWI                              ; 258C: 3F             
                FCB     $04                      ; 258D: 04             
                BEQ     Z25C4                    ; 258E: 27 34          
                CMPB    #$09                     ; 2590: C1 09          
                BNE     Z2526                    ; 2592: 26 92          
                LDAA    #$04                     ; 2594: 86 04          
                JSR     Z2927                    ; 2596: BD 29 27       
                LDX     #M2C96                   ; 2599: CE 2C 96       
                SWI                              ; 259C: 3F             
                FCB     $04                      ; 259D: 04             
                BEQ     Z25AA                    ; 259E: 27 0A          
                CMPB    #$09                     ; 25A0: C1 09          
                BNE     Z25A7                    ; 25A2: 26 03          
                JMP     Z22B8                    ; 25A4: 7E 22 B8       
Z25A7           JMP     Z26F0                    ; 25A7: 7E 26 F0       
Z25AA           LDX     M29CB                    ; 25AA: FE 29 CB       
                STX     M29D1                    ; 25AD: FF 29 D1       
                LDX     #M2D15                   ; 25B0: CE 2D 15       
                STX     M29D3                    ; 25B3: FF 29 D3       
                LDX     #M29D1                   ; 25B6: CE 29 D1       
                LDAB    #$05                     ; 25B9: C6 05          
                JSR     Z2D3F                    ; 25BB: BD 2D 3F       
                LDX     #M2D0A                   ; 25BE: CE 2D 0A       
                JMP     Z2418                    ; 25C1: 7E 24 18       
Z25C4           TST     M29D5                    ; 25C4: 7D 29 D5       
                BNE     Z25D0                    ; 25C7: 26 07          
                LDX     $04,X                    ; 25C9: EE 04          
                CPX     M2C73                    ; 25CB: BC 2C 73       
                BEQ     Z2581                    ; 25CE: 27 B1          
Z25D0           LDAA    #$04                     ; 25D0: 86 04          
                JSR     Z2927                    ; 25D2: BD 29 27       
                LDX     #M2C96                   ; 25D5: CE 2C 96       
                SWI                              ; 25D8: 3F             
                FCB     $04                      ; 25D9: 04             
                BEQ     Z25E3                    ; 25DA: 27 07          
                CMPB    #$09                     ; 25DC: C1 09          
                BEQ     Z25AA                    ; 25DE: 27 CA          
                JMP     Z2526                    ; 25E0: 7E 25 26       
Z25E3           TST     M29D5                    ; 25E3: 7D 29 D5       
                BNE     Z25F2                    ; 25E6: 26 0A          
                LDX     $04,X                    ; 25E8: EE 04          
                CPX     M2C98                    ; 25EA: BC 2C 98       
                BEQ     Z25D0                    ; 25ED: 27 E1          
                INC     M29D5                    ; 25EF: 7C 29 D5       
Z25F2           LDX     M2C75                    ; 25F2: FE 2C 75       
                LDAB    M2C73                    ; 25F5: F6 2C 73       
                LDAA    M2C74                    ; 25F8: B6 2C 74       
                SWI                              ; 25FB: 3F             
                BGT     Z264A                    ; 25FC: 2E 4C          
                STAA    M29B6                    ; 25FE: B7 29 B6       
                LDX     M2C9A                    ; 2601: FE 2C 9A       
                LDAB    M2C98                    ; 2604: F6 2C 98       
                LDAA    M2C99                    ; 2607: B6 2C 99       
                SWI                              ; 260A: 3F             
                BGT     Z2659                    ; 260B: 2E 4C          
                CMPA    M29B6                    ; 260D: B1 29 B6       
                BCC     Z2615                    ; 2610: 24 03          
                STAA    M29B6                    ; 2612: B7 29 B6       
Z2615           LDX     M2C75                    ; 2615: FE 2C 75       
                STX     M29D1                    ; 2618: FF 29 D1       
                LDX     M2C9A                    ; 261B: FE 2C 9A       
                STX     M29D3                    ; 261E: FF 29 D3       
                LDAB    M29B6                    ; 2621: F6 29 B6       
Z2624           LDX     #M29D1                   ; 2624: CE 29 D1       
                SWI                              ; 2627: 3F             
                SEC                              ; 2628: 0D             
                BCC     Z262E                    ; 2629: 24 03          
                JMP     Z22B8                    ; 262B: 7E 22 B8       
Z262E           SWI                              ; 262E: 3F             
                CBA                              ; 262F: 11             
                BEQ     Z2637                    ; 2630: 27 05          
                JSR     Z28A9                    ; 2632: BD 28 A9       
                BNE     Z2624                    ; 2635: 26 ED          
Z2637           JMP     Z2581                    ; 2637: 7E 25 81       
Z263A           LDX     #M434E                   ; 263A: CE 43 4E       
                CPX     M2C79                    ; 263D: BC 2C 79       
                BNE     Z2648                    ; 2640: 26 06          
                JMP     Z2708                    ; 2642: 7E 27 08       
Z2645           JMP     Z2714                    ; 2645: 7E 27 14       
Z2648           LDAB    M2C5B                    ; 2648: F6 2C 5B       
                BITB    #$01                     ; 264B: C5 01          
                BEQ     Z2665                    ; 264D: 27 16          
                LDAA    M2C58                    ; 264F: B6 2C 58       
                BITA    #$04                     ; 2652: 85 04          
                BEQ     Z2645                    ; 2654: 27 EF          
                LDAA    #$04                     ; 2656: 86 04          
                ORAA    M2C72                    ; 2658: BA 2C 72       
                STAA    M2C72                    ; 265B: B7 2C 72       
                LDAA    #$05                     ; 265E: 86 05          
                STAA    M2C88                    ; 2660: B7 2C 88       
                BRA     Z2668                    ; 2663: 20 03          
Z2665           INC     M29D5                    ; 2665: 7C 29 D5       
Z2668           CLR     M2C7C                    ; 2668: 7F 2C 7C       
                LDAB    M2C58                    ; 266B: F6 2C 58       
                BITB    #$04                     ; 266E: C5 04          
                BEQ     Z2692                    ; 2670: 27 20          
                LDAB    #$20                     ; 2672: C6 20          
                CMPB    M2CA9                    ; 2674: F1 2C A9       
                BNE     Z267F                    ; 2677: 26 06          
                LDX     #M5341                   ; 2679: CE 53 41       
                STX     M2CA9                    ; 267C: FF 2C A9       
Z267F           LDX     #M2CA1                   ; 267F: CE 2C A1       
                STX     M29D1                    ; 2682: FF 29 D1       
                LDX     #M2C7C                   ; 2685: CE 2C 7C       
                STX     M29D3                    ; 2688: FF 29 D3       
                LDX     #M29D1                   ; 268B: CE 29 D1       
                LDAB    #$0A                     ; 268E: C6 0A          
                SWI                              ; 2690: 3F             
                SBA                              ; 2691: 10             
Z2692           LDX     #M2C71                   ; 2692: CE 2C 71       
                JSR     Z2934                    ; 2695: BD 29 34       
                BEQ     Z26A1                    ; 2698: 27 07          
                SWI                              ; 269A: 3F             
                FCB     $00                      ; 269B: 00             
                BEQ     Z26A1                    ; 269C: 27 03          
Z269E           JMP     Z26F0                    ; 269E: 7E 26 F0       
Z26A1           SWI                              ; 26A1: 3F             
                FCB     $02                      ; 26A2: 02             
                BNE     Z269E                    ; 26A3: 26 F9          
                LDAB    M2C88                    ; 26A5: F6 2C 88       
                ANDB    #$07                     ; 26A8: C4 07          
                CMPB    #$05                     ; 26AA: C1 05          
                BEQ     Z26BB                    ; 26AC: 27 0D          
                CMPB    #$03                     ; 26AE: C1 03          
                BEQ     Z26B9                    ; 26B0: 27 07          
Z26B2           CMPB    #$07                     ; 26B2: C1 07          
                BEQ     Z26B9                    ; 26B4: 27 03          
                JMP     Z271C                    ; 26B6: 7E 27 1C       
Z26B9           LDAB    #$01                     ; 26B9: C6 01          
Z26BB           LDAA    M2C88                    ; 26BB: B6 2C 88       
                ANDA    #$78                     ; 26BE: 84 78          
                ABA                              ; 26C0: 1B             
                STAA    M2CAD                    ; 26C1: B7 2C AD       
                LDAB    M2C58                    ; 26C4: F6 2C 58       
                BITB    #$04                     ; 26C7: C5 04          
                BNE     Z26DE                    ; 26C9: 26 13          
                LDX     #M2C7C                   ; 26CB: CE 2C 7C       
                STX     M29D1                    ; 26CE: FF 29 D1       
                LDX     #M2CA1                   ; 26D1: CE 2C A1       
                STX     M29D3                    ; 26D4: FF 29 D3       
                LDX     #M29D1                   ; 26D7: CE 29 D1       
                LDAB    #$0A                     ; 26DA: C6 0A          
                SWI                              ; 26DC: 3F             
                SBA                              ; 26DD: 10             
Z26DE           LDAB    M2C5B                    ; 26DE: F6 2C 5B       
                BITB    #$40                     ; 26E1: C5 40          
                BEQ     Z26E8                    ; 26E3: 27 03          
                JMP     Z255D                    ; 26E5: 7E 25 5D       
Z26E8           JSR     Z27A8                    ; 26E8: BD 27 A8       
                LDAB    #$03                     ; 26EB: C6 03          
                JMP     Z2514                    ; 26ED: 7E 25 14       
Z26F0           LDAB    #$00                     ; 26F0: C6 00          
Z26F2           SWI                              ; 26F2: 3F             
                BRA     Z26B2                    ; 26F3: 20 BD          
                BEQ     Z2734                    ; 26F5: 27 3D          
                SWI                              ; 26F7: 3F             
                FCB     $1A                      ; 26F8: 1A             
Z26F9           LDAB    #$05                     ; 26F9: C6 05          
                BRA     Z26F2                    ; 26FB: 20 F5          
Z26FD           LDAB    #$06                     ; 26FD: C6 06          
Z26FF           LDX     #M2CBB                   ; 26FF: CE 2C BB       
                BRA     Z26F2                    ; 2702: 20 EE          
Z2704           LDAB    #$07                     ; 2704: C6 07          
                BRA     Z26F2                    ; 2706: 20 EA          
Z2708           LDAB    #$0A                     ; 2708: C6 0A          
                BRA     Z26F2                    ; 270A: 20 E6          
Z270C           LDAB    #$0B                     ; 270C: C6 0B          
                BRA     Z26F2                    ; 270E: 20 E2          
Z2710           LDAB    #$0C                     ; 2710: C6 0C          
                BRA     Z26F2                    ; 2712: 20 DE          
Z2714           LDAB    #$0D                     ; 2714: C6 0D          
                BRA     Z26F2                    ; 2716: 20 DA          
Z2718           LDAB    #$0F                     ; 2718: C6 0F          
                BRA     Z26F2                    ; 271A: 20 D6          
Z271C           LDAB    #$13                     ; 271C: C6 13          
                BRA     Z26F2                    ; 271E: 20 D2          
Z2720           LDAB    #$1E                     ; 2720: C6 1E          
                BRA     Z26F2                    ; 2722: 20 CE          
Z2724           LDAB    #$1F                     ; 2724: C6 1F          
                BRA     Z26FF                    ; 2726: 20 D7          
Z2728           LDX     #M2CA0                   ; 2728: CE 2C A0       
                LDAB    #$20                     ; 272B: C6 20          
                BRA     Z26F2                    ; 272D: 20 C3          
Z272F           LDAB    #$36                     ; 272F: C6 36          
                BRA     Z26F2                    ; 2731: 20 BF          
Z2733           SWI                              ; 2733: 3F             
Z2734           SEC                              ; 2734: 0D             
                BCC     Z273C                    ; 2735: 24 05          
                JSR     Z273D                    ; 2737: BD 27 3D       
                SWI                              ; 273A: 3F             
                FCB     $1A                      ; 273B: 1A             
Z273C           RTS                              ; 273C: 39             
Z273D           LDX     #M2C71                   ; 273D: CE 2C 71       
                JSR     Z2768                    ; 2740: BD 27 68       
Z2743           LDAB    M2C97                    ; 2743: F6 2C 97       
                ANDB    #$03                     ; 2746: C4 03          
                CMPB    #$03                     ; 2748: C1 03          
                BNE     Z2761                    ; 274A: 26 15          
                LDAB    #$08                     ; 274C: C6 08          
                BITB    M2C97                    ; 274E: F5 2C 97       
                BNE     Z2761                    ; 2751: 26 0E          
                LDX     #MFFFF                   ; 2753: CE FF FF       
                CPX     M2CA1                    ; 2756: BC 2C A1       
                BEQ     Z2761                    ; 2759: 27 06          
                ORAB    M2C97                    ; 275B: FA 2C 97       
                STAB    M2C97                    ; 275E: F7 2C 97       
Z2761           LDX     #M2C96                   ; 2761: CE 2C 96       
                JSR     Z2768                    ; 2764: BD 27 68       
                RTS                              ; 2767: 39             
Z2768           STX     M2785                    ; 2768: FF 27 85       
                SWI                              ; 276B: 3F             
                FCB     $03                      ; 276C: 03             
                BEQ     Z2776                    ; 276D: 27 07          
                CMPB    #$08                     ; 276F: C1 08          
                BEQ     Z2776                    ; 2771: 27 03          
                CLRB                             ; 2773: 5F             
                SWI                              ; 2774: 3F             
Z2775           BRA     Z2775                    ; 2775: 20 FE          
                BEQ     Z26FE                    ; 2777: 27 85          
                SWI                              ; 2779: 3F             
                NOP                              ; 277A: 01             
                BEQ     Z2784                    ; 277B: 27 07          
                CMPB    #$03                     ; 277D: C1 03          
                BEQ     Z2784                    ; 277F: 27 03          
                CLRB                             ; 2781: 5F             
                SWI                              ; 2782: 3F             
                BRA     Z27BE                    ; 2783: 20 39          
M2785           FCB     $00                      ; 2785: 00             
                FCB     $00                      ; 2786: 00             
Z2787           LDX     #M2C96                   ; 2787: CE 2C 96       
                LDAB    $01,X                    ; 278A: E6 01          
                ANDB    #$FC                     ; 278C: C4 FC          
                ORAB    #$01                     ; 278E: CA 01          
                STAB    $01,X                    ; 2790: E7 01          
                JSR     Z2934                    ; 2792: BD 29 34       
                BEQ     Z279B                    ; 2795: 27 04          
                SWI                              ; 2797: 3F             
                FCB     $00                      ; 2798: 00             
                BNE     Z27A5                    ; 2799: 26 0A          
Z279B           SWI                              ; 279B: 3F             
                FCB     $02                      ; 279C: 02             
                BNE     Z27A5                    ; 279D: 26 06          
                LDX     #M2CD4                   ; 279F: CE 2C D4       
                SWI                              ; 27A2: 3F             
                SEV                              ; 27A3: 0B             
                RTS                              ; 27A4: 39             
Z27A5           JMP     Z26F0                    ; 27A5: 7E 26 F0       
Z27A8           LDX     #M2CA0                   ; 27A8: CE 2C A0       
                LDAB    #$02                     ; 27AB: C6 02          
                SWI                              ; 27AD: 3F             
                FCB     $1C                      ; 27AE: 1C             
                BEQ     Z27B2                    ; 27AF: 27 01          
                RTS                              ; 27B1: 39             
Z27B2           LDAB    M2CAD                    ; 27B2: F6 2C AD       
                BITB    #$80                     ; 27B5: C5 80          
                BEQ     Z27BC                    ; 27B7: 27 03          
                JMP     Z2728                    ; 27B9: 7E 27 28       
Z27BC           ANDB    #$07                     ; 27BC: C4 07          
Z27BE           LDAA    M2C88                    ; 27BE: B6 2C 88       
                ANDA    #$07                     ; 27C1: 84 07          
                CBA                              ; 27C3: 11             
                BEQ     Z27D1                    ; 27C4: 27 0B          
                CMPA    #$07                     ; 27C6: 81 07          
                BEQ     Z27CD                    ; 27C8: 27 03          
Z27CA           JMP     Z2720                    ; 27CA: 7E 27 20       
Z27CD           CMPB    #$03                     ; 27CD: C1 03          
                BNE     Z27CA                    ; 27CF: 26 F9          
Z27D1           LDAB    M2C58                    ; 27D1: F6 2C 58       
                ANDB    #$05                     ; 27D4: C4 05          
                CMPB    #$05                     ; 27D6: C1 05          
                BNE     Z27E7                    ; 27D8: 26 0D          
                LDAB    M2CAD                    ; 27DA: F6 2C AD       
                ANDB    #$18                     ; 27DD: C4 18          
                LDAA    M2C88                    ; 27DF: B6 2C 88       
                ANDA    #$18                     ; 27E2: 84 18          
                CBA                              ; 27E4: 11             
                BNE     Z27CA                    ; 27E5: 26 E3          
Z27E7           LDAB    M2C5B                    ; 27E7: F6 2C 5B       
                BITB    #$10                     ; 27EA: C5 10          
                BEQ     Z27EF                    ; 27EC: 27 01          
Z27EE           RTS                              ; 27EE: 39             
Z27EF           LDX     #M2CA1                   ; 27EF: CE 2C A1       
                STX     M29D1                    ; 27F2: FF 29 D1       
                LDX     #M2CE7                   ; 27F5: CE 2C E7       
                STX     M29D3                    ; 27F8: FF 29 D3       
                LDX     #M29D1                   ; 27FB: CE 29 D1       
                LDAB    #$08                     ; 27FE: C6 08          
                SWI                              ; 2800: 3F             
                SBA                              ; 2801: 10             
                LDX     M2CA9                    ; 2802: FE 2C A9       
                STX     M2CF0                    ; 2805: FF 2C F0       
                LDAB    M2CA0                    ; 2808: F6 2C A0       
                STAB    M2CF3                    ; 280B: F7 2C F3       
                LDX     #M2CE7                   ; 280E: CE 2C E7       
                SWI                              ; 2811: 3F             
                CLC                              ; 2812: 0C             
                LDX     #M29D6                   ; 2813: CE 29 D6       
                LDAB    #$01                     ; 2816: C6 01          
                SWI                              ; 2818: 3F             
                DEX                              ; 2819: 09             
                LDAB    M29D6                    ; 281A: F6 29 D6       
                CMPB    #$59                     ; 281D: C1 59          
                BEQ     Z27EE                    ; 281F: 27 CD          
                LDAB    #$80                     ; 2821: C6 80          
                SWI                              ; 2823: 3F             
                BLS     Z27E3                    ; 2824: 23 BD          
                BEQ     Z2865                    ; 2826: 27 3D          
                SWI                              ; 2828: 3F             
                FCB     $1A                      ; 2829: 1A             
Z282A           LDX     #M2833                   ; 282A: CE 28 33       
                SWI                              ; 282D: 3F             
                TXS                              ; 282E: 35             
Z282F           DECB                             ; 282F: 5A             
                BNE     Z282A                    ; 2830: 26 F8          
                RTS                              ; 2832: 39             
M2833           FCB     $04                      ; 2833: 04             
Z2834           LDAB    #$81                     ; 2834: C6 81          
                SWI                              ; 2836: 3F             
                BLS     Z282F                    ; 2837: 23 F6          
                BGE     Z2896                    ; 2839: 2C 5B          
                BITB    #$04                     ; 283B: C5 04          
                BNE     Z2842                    ; 283D: 26 03          
                SWI                              ; 283F: 3F             
                SEV                              ; 2840: 0B             
                RTS                              ; 2841: 39             
Z2842           TST     M29CA                    ; 2842: 7D 29 CA       
                BNE     Z2855                    ; 2845: 26 0E          
                STX     Z2865                    ; 2847: FF 28 65       
                LDAB    #$06                     ; 284A: C6 06          
                STAB    M29CA                    ; 284C: F7 29 CA       
                JSR     Z282A                    ; 284F: BD 28 2A       
                LDX     Z2865                    ; 2852: FE 28 65       
Z2855           SWI                              ; 2855: 3F             
                TXS                              ; 2856: 35             
                INC     M29CA                    ; 2857: 7C 29 CA       
                LDAB    M29CA                    ; 285A: F6 29 CA       
                CMPB    #$42                     ; 285D: C1 42          
                BLT     Z2864                    ; 285F: 2D 03          
                CLR     M29CA                    ; 2861: 7F 29 CA       
Z2864           RTS                              ; 2864: 39             
Z2865           FCB     $00                      ; 2865: 00             
                FCB     $00                      ; 2866: 00             
Z2867           PSHB                             ; 2867: 37             
                LDX     M29CB                    ; 2868: FE 29 CB       
                CPX     M29B7                    ; 286B: BC 29 B7       
                BEQ     Z288A                    ; 286E: 27 1A          
                STX     M29B7                    ; 2870: FF 29 B7       
                STX     M29B9                    ; 2873: FF 29 B9       
                LDX     #M2D21                   ; 2876: CE 2D 21       
                STX     M29BB                    ; 2879: FF 29 BB       
                LDX     #M29B9                   ; 287C: CE 29 B9       
                LDAB    #$04                     ; 287F: C6 04          
                JSR     Z2DE2                    ; 2881: BD 2D E2       
                LDX     #M2D17                   ; 2884: CE 2D 17       
                JSR     Z2834                    ; 2887: BD 28 34       
Z288A           PULB                             ; 288A: 33             
                PSHB                             ; 288B: 37             
                LDAA    #$80                     ; 288C: 86 80          
                SBA                              ; 288E: 10             
                STAA    M29BA                    ; 288F: B7 29 BA       
                CLR     M29B9                    ; 2892: 7F 29 B9       
                LDX     #M2D2D                   ; 2895: CE 2D 2D       
                STX     M29BB                    ; 2898: FF 29 BB       
                LDX     #M29B9                   ; 289B: CE 29 B9       
                LDAB    #$02                     ; 289E: C6 02          
                JSR     Z2DE2                    ; 28A0: BD 2D E2       
                JSR     Z28EC                    ; 28A3: BD 28 EC       
                PULB                             ; 28A6: 33             
                DECB                             ; 28A7: 5A             
                RTS                              ; 28A8: 39             
Z28A9           PSHB                             ; 28A9: 37             
                LDX     M29CB                    ; 28AA: FE 29 CB       
                CPX     M29B7                    ; 28AD: BC 29 B7       
                BEQ     Z28CC                    ; 28B0: 27 1A          
                STX     M29B7                    ; 28B2: FF 29 B7       
                STX     M29B9                    ; 28B5: FF 29 B9       
                LDX     #M2D15                   ; 28B8: CE 2D 15       
                STX     M29BB                    ; 28BB: FF 29 BB       
                LDX     #M29B9                   ; 28BE: CE 29 B9       
                LDAB    #$05                     ; 28C1: C6 05          
                JSR     Z2D3F                    ; 28C3: BD 2D 3F       
                LDX     #M2D0A                   ; 28C6: CE 2D 0A       
                JSR     Z2834                    ; 28C9: BD 28 34       
Z28CC           PULB                             ; 28CC: 33             
                PSHB                             ; 28CD: 37             
                LDAA    M29B6                    ; 28CE: B6 29 B6       
                SBA                              ; 28D1: 10             
                STAA    M29BA                    ; 28D2: B7 29 BA       
                CLR     M29B9                    ; 28D5: 7F 29 B9       
                LDX     #M2D2E                   ; 28D8: CE 2D 2E       
                STX     M29BB                    ; 28DB: FF 29 BB       
                LDX     #M29B9                   ; 28DE: CE 29 B9       
                LDAB    #$03                     ; 28E1: C6 03          
                JSR     Z2D3F                    ; 28E3: BD 2D 3F       
                JSR     Z28EC                    ; 28E6: BD 28 EC       
                PULB                             ; 28E9: 33             
                DECB                             ; 28EA: 5A             
                RTS                              ; 28EB: 39             
Z28EC           LDX     M29D1                    ; 28EC: FE 29 D1       
                DEX                              ; 28EF: 09             
                LDAB    ,X                       ; 28F0: E6 00          
                STAB    M29BA                    ; 28F2: F7 29 BA       
                CLR     M29B9                    ; 28F5: 7F 29 B9       
                LDX     #M2D35                   ; 28F8: CE 2D 35       
                STX     M29BB                    ; 28FB: FF 29 BB       
Z28FE           LDX     #M29B9                   ; 28FE: CE 29 B9       
                LDAB    #$02                     ; 2901: C6 02          
                JSR     Z2DE2                    ; 2903: BD 2D E2       
                LDX     M29D3                    ; 2906: FE 29 D3       
                LDAB    ,X                       ; 2909: E6 00          
                INX                              ; 290B: 08             
                STX     M29D3                    ; 290C: FF 29 D3       
                STAB    M29BA                    ; 290F: F7 29 BA       
                LDX     #M2D3D                   ; 2912: CE 2D 3D       
                STX     M29BB                    ; 2915: FF 29 BB       
                LDX     #M29B9                   ; 2918: CE 29 B9       
                LDAB    #$02                     ; 291B: C6 02          
                JSR     Z2DE2                    ; 291D: BD 2D E2       
                LDX     #M2D23                   ; 2920: CE 2D 23       
                JSR     Z2834                    ; 2923: BD 28 34       
                RTS                              ; 2926: 39             
Z2927           BITA    M2C58                    ; 2927: B5 2C 58       
                BEQ     Z2933                    ; 292A: 27 07          
                LDX     M29CB                    ; 292C: FE 29 CB       
                INX                              ; 292F: 08             
                STX     M29CB                    ; 2930: FF 29 CB       
Z2933           RTS                              ; 2933: 39             
Z2934           LDAA    $08,X                    ; 2934: A6 08          
                CMPA    #$48                     ; 2936: 81 48          
                BNE     Z2953                    ; 2938: 26 19          
                LDAA    $09,X                    ; 293A: A6 09          
                CMPA    #$52                     ; 293C: 81 52          
                BNE     Z2953                    ; 293E: 26 13          
                LDAA    M2C59                    ; 2940: B6 2C 59       
                STAA    $08,X                    ; 2943: A7 08          
                LDAA    M2C5A                    ; 2945: B6 2C 5A       
Z2948           STAA    $09,X                    ; 2948: A7 09          
                LDAA    $0A,X                    ; 294A: A6 0A          
                ORAA    #$40                     ; 294C: 8A 40          
                STAA    $0A,X                    ; 294E: A7 0A          
                CLR     ,X                       ; 2950: 6F 00          
Z2952           RTS                              ; 2952: 39             
Z2953           LDAA    $08,X                    ; 2953: A6 08          
                CMPA    #$55                     ; 2955: 81 55          
                BNE     Z2952                    ; 2957: 26 F9          
                LDAA    $09,X                    ; 2959: A6 09          
                CMPA    #$44                     ; 295B: 81 44          
                BNE     Z2952                    ; 295D: 26 F3          
                LDAA    M2CCA                    ; 295F: B6 2C CA       
                STAA    $08,X                    ; 2962: A7 08          
                LDAA    M2CCB                    ; 2964: B6 2C CB       
                BRA     Z2948                    ; 2967: 20 DF          
Z2969           LDX     M0108                    ; 2969: FE 01 08       
                INX                              ; 296C: 08             
                STX     M2C90                    ; 296D: FF 2C 90       
                STX     M2CB5                    ; 2970: FF 2C B5       
                LDAB    #$02                     ; 2973: C6 02          
                SWI                              ; 2975: 3F             
                FCB     $1E                      ; 2976: 1E             
                SWI                              ; 2977: 3F             
                BCC     Z28FE                    ; 2978: 24 84          
                SUBA    #$48                     ; 297A: 80 48          
                ROLB                             ; 297C: 59             
                ROLA                             ; 297D: 49             
                TSTA                             ; 297E: 4D             
                BNE     Z2987                    ; 297F: 26 06          
                CMPB    #$01                     ; 2981: C1 01          
                BHI     Z2987                    ; 2983: 22 02          
                SEC                              ; 2985: 0D             
                RTS                              ; 2986: 39             
Z2987           LSRD                             ; 2987: 44 56          
                ANDA    #$01                     ; 2989: 84 01          
                LSRD                             ; 298B: 44 56          
                RORA                             ; 298D: 46             
                STAB    M29B4                    ; 298E: F7 29 B4       
                STAA    M29B5                    ; 2991: B7 29 B5       
                ADDA    M2C91                    ; 2994: BB 2C 91       
                ADCB    M2C90                    ; 2997: F9 2C 90       
                STAB    M2A56                    ; 299A: F7 2A 56       
                STAA    M2A57                    ; 299D: B7 2A 57       
                ADDA    M29B5                    ; 29A0: BB 29 B5       
                ADCB    M29B4                    ; 29A3: F9 29 B4       
                SWI                              ; 29A6: 3F             
                BCS     Z29B2                    ; 29A7: 25 09          
                STX     M2C92                    ; 29A9: FF 2C 92       
                STX     M2CB7                    ; 29AC: FF 2C B7       
                STX     M2A58                    ; 29AF: FF 2A 58       
Z29B2           CLC                              ; 29B2: 0C             
                RTS                              ; 29B3: 39             
M29B4           FCB     $00                      ; 29B4: 00             
M29B5           FCB     $00                      ; 29B5: 00             
M29B6           FCB     $00                      ; 29B6: 00             
M29B7           FCB     $ff,$fe                  ; 29B7: FF FE          
M29B9           FCB     $00                      ; 29B9: 00             
M29BA           FCB     $00                      ; 29BA: 00             
M29BB           FCB     $00,$00                  ; 29BB: 00 00          
M29BD           FCB     $00,$00,$00,$00,$00,$00  ; 29BD: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 29C3: 00 00 00 00 00 00 
                FCB     $00                      ; 29C9: 00             
M29CA           FCB     $00                      ; 29CA: 00             
M29CB           FCB     $00,$00                  ; 29CB: 00 00          
M29CD           FCB     $00                      ; 29CD: 00             
M29CE           FCB     $00                      ; 29CE: 00             
M29CF           FCB     $00                      ; 29CF: 00             
M29D0           FCB     $00                      ; 29D0: 00             
M29D1           FCB     $00,$00                  ; 29D1: 00 00          
M29D3           FCB     $00,$00                  ; 29D3: 00 00          
M29D5           FCB     $00                      ; 29D5: 00             
M29D6           FCB     $00,$00,$00,$00,$00,$00  ; 29D6: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 29DC: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 29E2: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 29E8: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 29EE: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 29F4: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 29FA: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2A00: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2A06: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2A0C: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2A12: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2A18: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2A1E: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2A24: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2A2A: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2A30: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2A36: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2A3C: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2A42: 00 00 00 00 00 00 
                FCB     $00,$00,$00              ; 2A48: 00 00 00       
M2A4B           FCB     $00,$00,$00,$00,$00,$00  ; 2A4B: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00          ; 2A51: 00 00 00 00    
M2A55           FCB     $00                      ; 2A55: 00             
M2A56           FCB     $00                      ; 2A56: 00             
M2A57           FCB     $00                      ; 2A57: 00             
M2A58           FCB     $00,$00,$00,$00,$00,$00  ; 2A58: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2A5E: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2A64: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2A6A: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2A70: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2A76: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2A7C: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2A82: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2A88: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2A8E: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2A94: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2A9A: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2AA0: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2AA6: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2AAC: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2AB2: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2AB8: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2ABE: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2AC4: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2ACA: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2AD0: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2AD6: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2ADC: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2AE2: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2AE8: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2AEE: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2AF4: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2AFA: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B00: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B06: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B0C: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B12: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B18: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B1E: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B24: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B2A: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B30: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B36: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B3C: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B42: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B48: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B4E: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00      ; 2B54: 00 00 00 00 00 
M2B59           FCB     $00,$00,$00,$00,$00,$00  ; 2B59: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B5F: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B65: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B6B: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B71: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B77: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B7D: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B83: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B89: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B8F: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B95: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2B9B: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2BA1: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2BA7: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2BAD: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2BB3: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2BB9: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2BBF: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2BC5: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2BCB: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2BD1: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2BD7: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2BDD: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2BE3: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2BE9: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2BEF: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2BF5: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2BFB: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2C01: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2C07: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2C0D: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2C13: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2C19: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2C1F: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2C25: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2C2B: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2C31: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2C37: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2C3D: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2C43: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2C49: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2C4F: 00 00 00 00 00 00 
                FCB     $00,$00                  ; 2C55: 00 00          
M2C57           FCB     $00                      ; 2C57: 00             
M2C58           FCB     $00                      ; 2C58: 00             
M2C59           FCB     '.                       ; 2C59: 2E             
M2C5A           FCB     $98                      ; 2C5A: 98             
M2C5B           FCB     $00                      ; 2C5B: 00             
M2C5C           FCB     '$                       ; 2C5C: 24             
M2C5D           FCB     $80                      ; 2C5D: 80             
M2C5E           FCB     $00,$00                  ; 2C5E: 00 00          
M2C60           FCB     'N                       ; 2C60: 4E             
                FCB     $01                      ; 2C61: 01             
                FCB     'C                       ; 2C62: 43             
                FCB     $08                      ; 2C63: 08             
                FCB     'W                       ; 2C64: 57             
                FCB     $10                      ; 2C65: 10             
                FCB     'B,' ,'L                 ; 2C66: 42 20 4C       
                FCB     $04                      ; 2C69: 04             
                FCB     'V,'@,'D                 ; 2C6A: 56 40 44       
                FCB     $80                      ; 2C6D: 80             
                FCB     'M                       ; 2C6E: 4D             
                FCB     $02,$00                  ; 2C6F: 02 00          
M2C71           FCB     $00                      ; 2C71: 00             
M2C72           FCB     $11                      ; 2C72: 11             
M2C73           FCB     $00                      ; 2C73: 00             
M2C74           FCB     $00                      ; 2C74: 00             
M2C75           FCB     '*,'Z,'+,'X              ; 2C75: 2A 5A 2B 58    
M2C79           FCB     'D,'K                    ; 2C79: 44 4B          
M2C7B           FCB     '0                       ; 2C7B: 30             
M2C7C           FCB     ' ,' ,' ,' ,' ,'         ; 2C7C: 20 20 20 20 20 20 
M2C82           FCB     ' ,'                     ; 2C82: 20 20          
M2C84           FCB     'S,'A                    ; 2C84: 53 41          
                FCB     $00,$00                  ; 2C86: 00 00          
M2C88           FCB     $00                      ; 2C88: 00             
M2C89           FCB     $00                      ; 2C89: 00             
M2C8A           FCB     $00,$00,$00,$00,$00,$00  ; 2C8A: 00 00 00 00 00 00 
M2C90           FCB     $00                      ; 2C90: 00             
M2C91           FCB     $00                      ; 2C91: 00             
M2C92           FCB     $00,$00                  ; 2C92: 00 00          
M2C94           FCB     $00,$00                  ; 2C94: 00 00          
M2C96           FCB     $00                      ; 2C96: 00             
M2C97           FCB     $10                      ; 2C97: 10             
M2C98           FCB     $00                      ; 2C98: 00             
M2C99           FCB     $00                      ; 2C99: 00             
M2C9A           FCB     '*,'Z                    ; 2C9A: 2A 5A          
M2C9C           FCB     '+,'X                    ; 2C9C: 2B 58          
M2C9E           FCB     'D,'K                    ; 2C9E: 44 4B          
M2CA0           FCB     '                        ; 2CA0: 20             
M2CA1           FCB     ' ,' ,' ,' ,' ,'         ; 2CA1: 20 20 20 20 20 20 
M2CA7           FCB     ' ,'                     ; 2CA7: 20 20          
M2CA9           FCB     ' ,'                     ; 2CA9: 20 20          
                FCB     $00,$00                  ; 2CAB: 00 00          
M2CAD           FCB     $00                      ; 2CAD: 00             
M2CAE           FCB     $00                      ; 2CAE: 00             
M2CAF           FCB     $00,$00,$00,$00          ; 2CAF: 00 00 00 00    
M2CB3           FCB     $00                      ; 2CB3: 00             
M2CB4           FCB     $00                      ; 2CB4: 00             
M2CB5           FCB     $00,$00                  ; 2CB5: 00 00          
M2CB7           FCB     $00,$00                  ; 2CB7: 00 00          
M2CB9           FCB     $00,$00                  ; 2CB9: 00 00          
M2CBB           FCB     '0,' ,' ,' ,' ,' ,' ,'   ; 2CBB: 30 20 20 20 20 20 20 20 
                FCB     ' ,'L,'O                 ; 2CC3: 20 4C 4F       
                FCB     $00,$00,$00,$00          ; 2CC6: 00 00 00 00    
M2CCA           FCB     $00                      ; 2CCA: 00             
M2CCB           FCB     $00,$00,$00,$00,$00      ; 2CCB: 00 00 00 00 00 
                FCB     ')                       ; 2CD0: 29             
                FCB     $d6                      ; 2CD1: D6             
                FCB     '*,'U                    ; 2CD2: 2A 55          
M2CD4           FCB     'V,'E,'R,'I,'F,'Y,' ,'I  ; 2CD4: 56 45 52 49 46 59 20 49 
                FCB     'N,' ,'P,'R,'O,'G,'R,'E  ; 2CDC: 4E 20 50 52 4F 47 52 45 
                FCB     'S,'S                    ; 2CE4: 53 53          
                FCB     $04                      ; 2CE6: 04             
M2CE7           FCB     'X,'X,'X,'X,'X,'X,'X,'X  ; 2CE7: 58 58 58 58 58 58 58 58 
                FCB     '.                       ; 2CEF: 2E             
M2CF0           FCB     'X,'X,':                 ; 2CF0: 58 58 3A       
M2CF3           FCB     'X,' ,'E,'X,'I,'S,'T,'S  ; 2CF3: 58 20 45 58 49 53 54 53 
                FCB     '.,' ,'O,'V,'E,'R,'W,'R  ; 2CFB: 2E 20 4F 56 45 52 57 52 
                FCB     'I,'T,'E,'?,' ,'         ; 2D03: 49 54 45 3F 20 20 
                FCB     $04                      ; 2D09: 04             
M2D0A           FCB     'R,'E,'C,'O,'R,'D,' ,'X  ; 2D0A: 52 45 43 4F 52 44 20 58 
                FCB     'X,'X,'X                 ; 2D12: 58 58 58       
M2D15           FCB     'X                       ; 2D15: 58             
                FCB     $04                      ; 2D16: 04             
M2D17           FCB     'S,'E,'C,'T,'O,'R,' ,'X  ; 2D17: 53 45 43 54 4F 52 20 58 
                FCB     'X,'X                    ; 2D1F: 58 58          
M2D21           FCB     'X                       ; 2D21: 58             
                FCB     $04                      ; 2D22: 04             
M2D23           FCB     ' ,' ,'O,'F,'F,'S,'E,'T  ; 2D23: 20 20 4F 46 46 53 45 54 
                FCB     ' ,'X                    ; 2D2B: 20 58          
M2D2D           FCB     'X                       ; 2D2D: 58             
M2D2E           FCB     ' ,' ,'S,'R,'C,'-,'X     ; 2D2E: 20 20 53 52 43 2D 58 
M2D35           FCB     'X,' ,' ,'D,'S,'T,'-,'X  ; 2D35: 58 20 20 44 53 54 2D 58 
M2D3D           FCB     'X                       ; 2D3D: 58             
                FCB     $04                      ; 2D3E: 04             
Z2D3F           FCB     ']                       ; 2D3F: 5D             
                FCB     '&,$03                   ; 2D40: 26 03          
                FCB     '~,'-                    ; 2D42: 7E 2D          
                FCB     $cb                      ; 2D44: CB             
                FCB     'l                       ; 2D45: 6C             
                FCB     $03,'&,$02               ; 2D46: 03 26 02       
                FCB     'l                       ; 2D49: 6C             
                FCB     $02,$f7                  ; 2D4A: 02 F7          
                FCB     '-                       ; 2D4C: 2D             
                FCB     $de,$ff                  ; 2D4D: DE FF          
                FCB     '-                       ; 2D4F: 2D             
                FCB     $e0,$ce                  ; 2D50: E0 CE          
                FCB     '-                       ; 2D52: 2D             
                FCB     $cc,$ff                  ; 2D53: CC FF          
                FCB     '-                       ; 2D55: 2D             
                FCB     $db,$86,$04,$b7          ; 2D56: DB 86 04 B7    
                FCB     '-                       ; 2D5A: 2D             
                FCB     $df,$fe                  ; 2D5B: DF FE          
                FCB     '-                       ; 2D5D: 2D             
                FCB     $e0,$a6,$00,$e6,$01,$ce  ; 2D5E: E0 A6 00 E6 01 CE 
                FCB     '-                       ; 2D64: 2D             
                FCB     $d6                      ; 2D65: D6             
                FCB     'o                       ; 2D66: 6F             
                FCB     $07,$ee,$05,$e0,$01,$a2  ; 2D67: 07 EE 05 E0 01 A2 
                FCB     $00                      ; 2D6D: 00             
                FCB     '%                       ; 2D6E: 25             
                FCB     $07,$ce                  ; 2D6F: 07 CE          
                FCB     '-                       ; 2D71: 2D             
                FCB     $d6                      ; 2D72: D6             
                FCB     'l                       ; 2D73: 6C             
                FCB     $07                      ; 2D74: 07             
                FCB     '                        ; 2D75: 20             
                FCB     $f1,$eb,$01,$a9,$00,$ce  ; 2D76: F1 EB 01 A9 00 CE 
                FCB     '-                       ; 2D7C: 2D             
                FCB     $d6                      ; 2D7D: D6             
                FCB     '6,'7                    ; 2D7E: 36 37          
                FCB     $a6,$07,$8b              ; 2D80: A6 07 8B       
                FCB     '0                       ; 2D83: 30             
                FCB     $e6,$09                  ; 2D84: E6 09          
                FCB     ''                       ; 2D86: 27             
                FCB     $04,$08                  ; 2D87: 04 08          
                FCB     'Z                       ; 2D89: 5A             
                FCB     '&,$fc,$a7,$00           ; 2D8A: 26 FC A7 00    
                FCB     '3,'2                    ; 2D8E: 33 32          
                FCB     $ce                      ; 2D90: CE             
                FCB     '-                       ; 2D91: 2D             
                FCB     $d6                      ; 2D92: D6             
                FCB     'l                       ; 2D93: 6C             
                FCB     $06,'&,$02               ; 2D94: 06 26 02       
                FCB     'l                       ; 2D97: 6C             
                FCB     $05                      ; 2D98: 05             
                FCB     'l                       ; 2D99: 6C             
                FCB     $06,'&,$02               ; 2D9A: 06 26 02       
                FCB     'l                       ; 2D9D: 6C             
                FCB     $05                      ; 2D9E: 05             
                FCB     'j                       ; 2D9F: 6A             
                FCB     $09                      ; 2DA0: 09             
                FCB     ',                       ; 2DA1: 2C             
                FCB     $c3,$ef,$05,$ee,$05,$a6  ; 2DA2: C3 EF 05 EE 05 A6 
                FCB     $00,$ce                  ; 2DA8: 00 CE          
                FCB     '-                       ; 2DAA: 2D             
                FCB     $d6,$ee,$0a              ; 2DAB: D6 EE 0A       
                FCB     'm                       ; 2DAE: 6D             
                FCB     $03,'&,$02               ; 2DAF: 03 26 02       
                FCB     'j                       ; 2DB2: 6A             
                FCB     $02                      ; 2DB3: 02             
                FCB     'j                       ; 2DB4: 6A             
                FCB     $03,$ee,$02,$a7,$00,$ce  ; 2DB5: 03 EE 02 A7 00 CE 
                FCB     '-                       ; 2DBB: 2D             
                FCB     $d6                      ; 2DBC: D6             
                FCB     'l                       ; 2DBD: 6C             
                FCB     $06,'&,$02               ; 2DBE: 06 26 02       
                FCB     'l                       ; 2DC1: 6C             
                FCB     $05                      ; 2DC2: 05             
                FCB     'j                       ; 2DC3: 6A             
                FCB     $08,'&,$de,$fe           ; 2DC4: 08 26 DE FE    
                FCB     '-                       ; 2DC8: 2D             
                FCB     $e0                      ; 2DC9: E0             
                FCB     'O,'9,''                 ; 2DCA: 4F 39 27       
                FCB     $10,$03,$e8,$00          ; 2DCD: 10 03 E8 00    
                FCB     'd                       ; 2DD1: 64             
                FCB     $00,$0a,$00,$01,$00,$00  ; 2DD2: 00 0A 00 01 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2DD8: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00          ; 2DDE: 00 00 00 00    
Z2DE2           TSTB                             ; 2DE2: 5D             
                BEQ     Z2E14                    ; 2DE3: 27 2F          
                INC     $03,X                    ; 2DE5: 6C 03          
                BNE     Z2DEB                    ; 2DE7: 26 02          
                INC     $02,X                    ; 2DE9: 6C 02          
Z2DEB           STX     M2E15                    ; 2DEB: FF 2E 15       
Z2DEE           LDX     M2E15                    ; 2DEE: FE 2E 15       
                LDAA    $01,X                    ; 2DF1: A6 01          
                ANDA    #$0F                     ; 2DF3: 84 0F          
                CMPA    #$09                     ; 2DF5: 81 09          
                BLS     Z2DFB                    ; 2DF7: 23 02          
                ADDA    #$07                     ; 2DF9: 8B 07          
Z2DFB           ADDA    #$30                     ; 2DFB: 8B 30          
                TST     $03,X                    ; 2DFD: 6D 03          
                BNE     Z2E03                    ; 2DFF: 26 02          
                DEC     $02,X                    ; 2E01: 6A 02          
Z2E03           DEC     $03,X                    ; 2E03: 6A 03          
                LDX     $02,X                    ; 2E05: EE 02          
                STAA    ,X                       ; 2E07: A7 00          
                LDX     M2E15                    ; 2E09: FE 2E 15       
                BSR     Z2E17                    ; 2E0C: 8D 09          
                DECB                             ; 2E0E: 5A             
                BNE     Z2DEE                    ; 2E0F: 26 DD          
                LDX     M2E15                    ; 2E11: FE 2E 15       
Z2E14           RTS                              ; 2E14: 39             
M2E15           FCB     $00                      ; 2E15: 00             
                FCB     $00                      ; 2E16: 00             
Z2E17           PSHA                             ; 2E17: 36             
                LDAA    #$04                     ; 2E18: 86 04          
Z2E1A           LSR     ,X                       ; 2E1A: 64 00          
                ROR     $01,X                    ; 2E1C: 66 01          
                DECA                             ; 2E1E: 4A             
                BNE     Z2E1A                    ; 2E1F: 26 F9          
                PULA                             ; 2E21: 32             
                RTS                              ; 2E22: 39             
                CLC                              ; 2E23: 0C             
                BRA     Z2E40                    ; 2E24: 20 1A          
                CLC                              ; 2E26: 0C             
                BRA     Z2E40                    ; 2E27: 20 17          
                JSR     Z2E47                    ; 2E29: BD 2E 47       
                CLC                              ; 2E2C: 0C             
                BRA     Z2E40                    ; 2E2D: 20 11          
                JSR     Z2E59                    ; 2E2F: BD 2E 59       
                TAB                              ; 2E32: 16             
                BCC     Z2E40                    ; 2E33: 24 0B          
                TSX                              ; 2E35: 30             
                LDX     ,X                       ; 2E36: EE 00          
                LDX     ,X                       ; 2E38: EE 00          
                LDX     ,X                       ; 2E3A: EE 00          
                LDAA    #$0C                     ; 2E3C: 86 0C          
                STAA    ,X                       ; 2E3E: A7 00          
Z2E40           TSX                              ; 2E40: 30             
                LDX     ,X                       ; 2E41: EE 00          
                INS                              ; 2E43: 31             
                INS                              ; 2E44: 31             
                JMP     $02,X                    ; 2E45: 6E 02          
Z2E47           STX     M2EA0                    ; 2E47: FF 2E A0       
                LDX     M2E9C                    ; 2E4A: FE 2E 9C       
                CLR     $01,X                    ; 2E4D: 6F 01          
                CLR     ,X                       ; 2E4F: 6F 00          
                LDAA    #$3C                     ; 2E51: 86 3C          
                STAA    $01,X                    ; 2E53: A7 01          
                LDX     M2EA0                    ; 2E55: FE 2E A0       
                RTS                              ; 2E58: 39             
Z2E59           STX     M2EA0                    ; 2E59: FF 2E A0       
                LDX     M2E9C                    ; 2E5C: FE 2E 9C       
                LDAA    ,X                       ; 2E5F: A6 00          
                LDAA    #$34                     ; 2E61: 86 34          
                STAA    $01,X                    ; 2E63: A7 01          
                LDAA    #$3C                     ; 2E65: 86 3C          
                STAA    $01,X                    ; 2E67: A7 01          
                CLR     M2EA2                    ; 2E69: 7F 2E A2       
                CLR     M2EA3                    ; 2E6C: 7F 2E A3       
Z2E6F           LDAA    $01,X                    ; 2E6F: A6 01          
                BMI     Z2E7E                    ; 2E71: 2B 0B          
                DEC     M2EA3                    ; 2E73: 7A 2E A3       
                BNE     Z2E6F                    ; 2E76: 26 F7          
                DEC     M2EA2                    ; 2E78: 7A 2E A2       
                BNE     Z2E6F                    ; 2E7B: 26 F2          
                SEC                              ; 2E7D: 0D             
Z2E7E           LDAA    ,X                       ; 2E7E: A6 00          
                BCS     Z2E94                    ; 2E80: 25 12          
                TSX                              ; 2E82: 30             
                LDX     $02,X                    ; 2E83: EE 02          
                LDX     ,X                       ; 2E85: EE 00          
                LDX     ,X                       ; 2E87: EE 00          
                LDAB    $17,X                    ; 2E89: E6 17          
                ANDB    #$07                     ; 2E8B: C4 07          
                CMPB    #$05                     ; 2E8D: C1 05          
                BNE     Z2E93                    ; 2E8F: 26 02          
                ANDA    #$7F                     ; 2E91: 84 7F          
Z2E93           CLC                              ; 2E93: 0C             
Z2E94           LDX     M2EA0                    ; 2E94: FE 2E A0       
                RTS                              ; 2E97: 39             
                FCB     $00,$00                  ; 2E98: 00 00          
                FCB     $2E,$23                  ; 2E9A: 2E 23          
M2E9C           FCB     $E4,$04,$B0,$84          ; 2E9C: E4 04 B0 84    
M2EA0           FCB     $00                      ; 2EA0: 00             


                END
