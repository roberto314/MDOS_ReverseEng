dasmfw: Disassembler Framework V0.35
Loaded: binary file "mdosov6.sy"
Loaded: Info file "mdoser.info"

;****************************************************
; Used Labels
;****************************************************

M0008   EQU     $0008
M00AD   EQU     $00AD
M00AE   EQU     $00AE
M00FE   EQU     $00FE
M0100   EQU     $0100
M0102   EQU     $0102
M0114   EQU     $0114
M0115   EQU     $0115
M011E   EQU     $011E
M0120   EQU     $0120
M0133   EQU     $0133
M0145   EQU     $0145
M016A   EQU     $016A
M017B   EQU     $017B
M11C2   EQU     $11C2
Z1210   EQU     $1210
M434D   EQU     $434D
M5748   EQU     $5748
M8649   EQU     $8649
CHKERR  EQU     $E853
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

;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $1FFD

                JMP     Z2000                    ; 1FFD: 7E 20 00       
Z2000           LDX     #M216A                   ; 2000: CE 21 6A       
                LDAB    #$03                     ; 2003: C6 03          
                SWI                              ; 2005: 3F             
                SBA                              ; 2006: 10             
Z2007           LDX     #M00AD                   ; 2007: CE 00 AD       
                CLR     ,X                       ; 200A: 6F 00          
                STX     M00FE                    ; 200C: DF FE          
Z200E           CLRB                             ; 200E: 5F             
                LDX     #M2165                   ; 200F: CE 21 65       
                SWI                              ; 2012: 3F             
                CLI                              ; 2013: 0E             
                LDX     M2168                    ; 2014: FE 21 68       
                LDX     $08,X                    ; 2017: EE 08          
                STX     M213B                    ; 2019: FF 21 3B       
                CPX     M0100                    ; 201C: BC 01 00       
                BNE     Z2046                    ; 201F: 26 25          
                LDX     M2168                    ; 2021: FE 21 68       
                LDX     $0A,X                    ; 2024: EE 0A          
                STX     M213E                    ; 2026: FF 21 3E       
                CPX     M0102                    ; 2029: BC 01 02       
                BNE     Z2046                    ; 202C: 26 18          
                LDX     #M11C2                   ; 202E: CE 11 C2       
                STX     M216A                    ; 2031: FF 21 6A       
                LDX     #M2197                   ; 2034: CE 21 97       
                STX     M216C                    ; 2037: FF 21 6C       
                LDAB    #$0E                     ; 203A: C6 0E          
                LDX     #M216A                   ; 203C: CE 21 6A       
                SWI                              ; 203F: 3F             
                CBA                              ; 2040: 11             
                BEQ     Z2063                    ; 2041: 27 20          
                LDAA    #$52                     ; 2043: 86 52          
                CPX     #M8649                   ; 2045: 8C 86 49       
Z2048           STAA    M0008                    ; 2048: 97 08          
Z204A           SEC                              ; 204A: 0D             
                JSR     CHKERR                   ; 204B: BD E8 53       
                BRA     Z204A                    ; 204E: 20 FA          
Z2050           LDAB    #$00                     ; 2050: C6 00          
                SWI                              ; 2052: 3F             
                BRA     Z200B                    ; 2053: 20 B6          
                NOP                              ; 2055: 01             
                FCB     $15                      ; 2056: 15             
                CMPA    #$FF                     ; 2057: 81 FF          
                BEQ     Z205E                    ; 2059: 27 03          
                JMP     Z2007                    ; 205B: 7E 20 07       
Z205E           LDAA    #$55                     ; 205E: 86 55          
                JMP     Z2048                    ; 2060: 7E 20 48       
Z2063           LDX     #M0120                   ; 2063: CE 01 20       
                LDAA    $0A,X                    ; 2066: A6 0A          
                BITA    #$40                     ; 2068: 85 40          
                BEQ     Z2081                    ; 206A: 27 15          
                LDX     #M0145                   ; 206C: CE 01 45       
                LDAA    $0A,X                    ; 206F: A6 0A          
                BITA    #$40                     ; 2071: 85 40          
                BEQ     Z2081                    ; 2073: 27 0C          
                LDX     M017B                    ; 2075: FE 01 7B       
                BEQ     Z20AD                    ; 2078: 27 33          
                LDX     #M016A                   ; 207A: CE 01 6A       
                SWI                              ; 207D: 3F             
                TAP                              ; 207E: 06             
                BRA     Z20AD                    ; 207F: 20 2C          
Z2081           LDX     #M0120                   ; 2081: CE 01 20       
                SWI                              ; 2084: 3F             
                FCB     $00                      ; 2085: 00             
                BCS     Z2050                    ; 2086: 25 C8          
                SWI                              ; 2088: 3F             
                FCB     $02                      ; 2089: 02             
                BCS     Z2050                    ; 208A: 25 C4          
                LDAB    #$02                     ; 208C: C6 02          
                ORAB    $01,X                    ; 208E: EA 01          
                STAB    $01,X                    ; 2090: E7 01          
                LDX     #M0145                   ; 2092: CE 01 45       
                SWI                              ; 2095: 3F             
                FCB     $00                      ; 2096: 00             
                BCS     Z2050                    ; 2097: 25 B7          
                SWI                              ; 2099: 3F             
                FCB     $02                      ; 209A: 02             
                BCS     Z2050                    ; 209B: 25 B3          
                LDX     #M016A                   ; 209D: CE 01 6A       
                SWI                              ; 20A0: 3F             
                FCB     $00                      ; 20A1: 00             
                BCS     Z2050                    ; 20A2: 25 AC          
                SWI                              ; 20A4: 3F             
                FCB     $02                      ; 20A5: 02             
                BCS     Z2050                    ; 20A6: 25 A8          
                LDX     #M2135                   ; 20A8: CE 21 35       
                SWI                              ; 20AB: 3F             
                SEV                              ; 20AC: 0B             
Z20AD           LDAA    #$3D                     ; 20AD: 86 3D          
                STAA    M0133                    ; 20AF: B7 01 33       
                LDX     #M00AE                   ; 20B2: CE 00 AE       
                LDAB    #$4F                     ; 20B5: C6 4F          
                SWI                              ; 20B7: 3F             
                SEC                              ; 20B8: 0D             
                SWI                              ; 20B9: 3F             
                DEX                              ; 20BA: 09             
                CLRB                             ; 20BB: 5F             
                STAB    M0133                    ; 20BC: F7 01 33       
                STAB    M0115                    ; 20BF: F7 01 15       
                LDAA    M0114                    ; 20C2: B6 01 14       
                ANDA    #$0F                     ; 20C5: 84 0F          
                STAA    M0114                    ; 20C7: B7 01 14       
                LDX     #M00AD                   ; 20CA: CE 00 AD       
                STX     M00FE                    ; 20CD: DF FE          
                STX     M2141                    ; 20CF: FF 21 41       
                LDX     #M2145                   ; 20D2: CE 21 45       
                STX     M2143                    ; 20D5: FF 21 43       
                LDAA    #$30                     ; 20D8: 86 30          
                STAA    ,X                       ; 20DA: A7 00          
                STAA    $01,X                    ; 20DC: A7 01          
                LDX     #M434D                   ; 20DE: CE 43 4D       
Z20E1           STX     M214E                    ; 20E1: FF 21 4E       
                LDX     #M2141                   ; 20E4: CE 21 41       
                SWI                              ; 20E7: 3F             
                FCB     $1D                      ; 20E8: 1D             
                TSTB                             ; 20E9: 5D             
                BNE     Z2121                    ; 20EA: 26 35          
                LDAB    M2145                    ; 20EC: F6 21 45       
                CMPB    #$30                     ; 20EF: C1 30          
                BLT     Z2121                    ; 20F1: 2D 2E          
                CMPB    #$33                     ; 20F3: C1 33          
                BGT     Z2121                    ; 20F5: 2E 2A          
                LDX     M2141                    ; 20F7: FE 21 41       
                STX     M00FE                    ; 20FA: DF FE          
                LDAB    #$11                     ; 20FC: C6 11          
                LDX     #M2145                   ; 20FE: CE 21 45       
                SWI                              ; 2101: 3F             
                ABA                              ; 2102: 1B             
                CMPB    #$03                     ; 2103: C1 03          
                BEQ     Z2121                    ; 2105: 27 1A          
                LDAA    #$0E                     ; 2107: 86 0E          
                CMPB    #$04                     ; 2109: C1 04          
                BEQ     Z211B                    ; 210B: 27 0E          
                LDAA    #$0F                     ; 210D: 86 0F          
                CMPB    #$05                     ; 210F: C1 05          
                BEQ     Z211B                    ; 2111: 27 08          
                LDAA    #$12                     ; 2113: 86 12          
                CMPB    #$06                     ; 2115: C1 06          
                BEQ     Z211B                    ; 2117: 27 02          
                LDAA    #$0C                     ; 2119: 86 0C          
Z211B           TAB                              ; 211B: 16             
                SWI                              ; 211C: 3F             
                BRA     Z219D                    ; 211D: 20 7E          
                BRA     Z2128                    ; 211F: 20 07          
Z2121           LDX     #M215E                   ; 2121: CE 21 5E       
                SWI                              ; 2124: 3F             
                SEV                              ; 2125: 0B             
                LDAB    #$80                     ; 2126: C6 80          
Z2128           SWI                              ; 2128: 3F             
                BLS     Z20E1                    ; 2129: 23 B6          
                NOP                              ; 212B: 01             
                FCB     $1E                      ; 212C: 1E             
                ORAA    #$80                     ; 212D: 8A 80          
                STAA    M011E                    ; 212F: B7 01 1E       
                JMP     Z200E                    ; 2132: 7E 20 0E       
M2135           SEC                              ; 2135: 0D             
                TSTA                             ; 2136: 4D             
                LSRA                             ; 2137: 44             
                CLRA                             ; 2138: 4F             
                COMB                             ; 2139: 53             
                BRA     Z215C                    ; 213A: 20 20          
                BRA     M216C                    ; 213C: 20 2E          
M213E           BRA     Z2160                    ; 213E: 20 20          
                FCB     $04                      ; 2140: 04             
M2141           FCB     $00                      ; 2141: 00             
                FCB     $00                      ; 2142: 00             
M2143           FCB     $00                      ; 2143: 00             
                FCB     $00                      ; 2144: 00             
M2145           FCB     $00                      ; 2145: 00             
                FCB     $00                      ; 2146: 00             
                FCB     $00                      ; 2147: 00             
                FCB     $00                      ; 2148: 00             
                FCB     $00                      ; 2149: 00             
                FCB     $00                      ; 214A: 00             
                FCB     $00                      ; 214B: 00             
                FCB     $00                      ; 214C: 00             
                FCB     $00                      ; 214D: 00             
M214E           FCB     $00                      ; 214E: 00             
                FCB     $00                      ; 214F: 00             
                FCB     $00                      ; 2150: 00             
                FCB     $00                      ; 2151: 00             
                FCB     $00                      ; 2152: 00             
                FCB     $00                      ; 2153: 00             
                FCB     $00                      ; 2154: 00             
                FCB     $00                      ; 2155: 00             
                FCB     $00                      ; 2156: 00             
                FCB     $00                      ; 2157: 00             
                FCB     $00                      ; 2158: 00             
                FCB     $00                      ; 2159: 00             
                FCB     $21                      ; 215A: 21             
                FCB     $71                      ; 215B: 71             
Z215C           FCB     $21                      ; 215C: 21             
                SUBB    M5748                    ; 215D: F0 57 48       
Z2160           FCB     $41                      ; 2160: 41             
                LSRB                             ; 2161: 54             
                SWI                              ; 2162: 3F             
                TPA                              ; 2163: 07             
                FCB     $04                      ; 2164: 04             
M2165           FCB     $00                      ; 2165: 00             
                FCB     $00                      ; 2166: 00             
                FCB     $00                      ; 2167: 00             
M2168           FCB     $21                      ; 2168: 21             
                FCB     $71                      ; 2169: 71             
M216A           FCB     $21                      ; 216A: 21             
                JMP     $1F,X                    ; 216B: 6E 1F          
                FCB     $FD                      ; 216D: FD             
                JSR     Z1210                    ; 216E: BD 12 10       
                FCB     $00                      ; 2171: 00             
                FCB     $00                      ; 2172: 00             
                FCB     $00                      ; 2173: 00             
                FCB     $00                      ; 2174: 00             
                FCB     $00                      ; 2175: 00             
                FCB     $00                      ; 2176: 00             
                FCB     $00                      ; 2177: 00             
                FCB     $00                      ; 2178: 00             
                FCB     $00                      ; 2179: 00             
                FCB     $00                      ; 217A: 00             
                FCB     $00                      ; 217B: 00             
                FCB     $00                      ; 217C: 00             
                FCB     $00                      ; 217D: 00             
                FCB     $00                      ; 217E: 00             
                FCB     $00                      ; 217F: 00             
                FCB     $00                      ; 2180: 00             
                FCB     $00                      ; 2181: 00             
                FCB     $00                      ; 2182: 00             
                FCB     $00                      ; 2183: 00             
                FCB     $00                      ; 2184: 00             
                FCB     $00                      ; 2185: 00             
                FCB     $00                      ; 2186: 00             
                FCB     $00                      ; 2187: 00             
                FCB     $00                      ; 2188: 00             
                FCB     $00                      ; 2189: 00             
                FCB     $00                      ; 218A: 00             
                FCB     $00                      ; 218B: 00             
                FCB     $00                      ; 218C: 00             
                FCB     $00                      ; 218D: 00             
                FCB     $00                      ; 218E: 00             
                FCB     $00                      ; 218F: 00             
                FCB     $00                      ; 2190: 00             
                FCB     $00                      ; 2191: 00             
                FCB     $00                      ; 2192: 00             
                FCB     $00                      ; 2193: 00             
                FCB     $00                      ; 2194: 00             
                FCB     $00                      ; 2195: 00             
                FCB     $00                      ; 2196: 00             
M2197           FCB     $00                      ; 2197: 00             
                FCB     $00                      ; 2198: 00             
                FCB     $00                      ; 2199: 00             
                FCB     $00                      ; 219A: 00             
                FCB     $00                      ; 219B: 00             
                FCB     $00                      ; 219C: 00             
Z219D           FCB     $00                      ; 219D: 00             
                FCB     $00                      ; 219E: 00             
                FCB     $00                      ; 219F: 00             
                FCB     $00                      ; 21A0: 00             
                FCB     $00                      ; 21A1: 00             
                FCB     $00                      ; 21A2: 00             
                FCB     $00                      ; 21A3: 00             
                FCB     $00                      ; 21A4: 00             
                FCB     $00                      ; 21A5: 00             
                FCB     $00                      ; 21A6: 00             
                FCB     $00                      ; 21A7: 00             
                FCB     $00                      ; 21A8: 00             
                FCB     $00                      ; 21A9: 00             
                FCB     $00                      ; 21AA: 00             
                FCB     $00                      ; 21AB: 00             
                FCB     $00                      ; 21AC: 00             
                FCB     $00                      ; 21AD: 00             
                FCB     $00                      ; 21AE: 00             
                FCB     $00                      ; 21AF: 00             
                FCB     $00                      ; 21B0: 00             
                FCB     $00                      ; 21B1: 00             
                FCB     $00                      ; 21B2: 00             
                FCB     $00                      ; 21B3: 00             
                FCB     $00                      ; 21B4: 00             
                FCB     $00                      ; 21B5: 00             
                FCB     $00                      ; 21B6: 00             
                FCB     $00                      ; 21B7: 00             
                FCB     $00                      ; 21B8: 00             
                FCB     $00                      ; 21B9: 00             
                FCB     $00                      ; 21BA: 00             
                FCB     $00                      ; 21BB: 00             
                FCB     $00                      ; 21BC: 00             
                FCB     $00                      ; 21BD: 00             
                FCB     $00                      ; 21BE: 00             
                FCB     $00                      ; 21BF: 00             
                FCB     $00                      ; 21C0: 00             
                FCB     $00                      ; 21C1: 00             
                FCB     $00                      ; 21C2: 00             
                FCB     $00                      ; 21C3: 00             
                FCB     $00                      ; 21C4: 00             
                FCB     $00                      ; 21C5: 00             
                FCB     $00                      ; 21C6: 00             
                FCB     $00                      ; 21C7: 00             
                FCB     $00                      ; 21C8: 00             
                FCB     $00                      ; 21C9: 00             
                FCB     $00                      ; 21CA: 00             
                FCB     $00                      ; 21CB: 00             
                FCB     $00                      ; 21CC: 00             
                FCB     $00                      ; 21CD: 00             
                FCB     $00                      ; 21CE: 00             
                FCB     $00                      ; 21CF: 00             
                FCB     $00                      ; 21D0: 00             
                FCB     $00                      ; 21D1: 00             
                FCB     $00                      ; 21D2: 00             
                FCB     $00                      ; 21D3: 00             
                FCB     $00                      ; 21D4: 00             
                FCB     $00                      ; 21D5: 00             
                FCB     $00                      ; 21D6: 00             
                FCB     $00                      ; 21D7: 00             
                FCB     $00                      ; 21D8: 00             
                FCB     $00                      ; 21D9: 00             
                FCB     $00                      ; 21DA: 00             
                FCB     $00                      ; 21DB: 00             
                FCB     $00                      ; 21DC: 00             
                FCB     $00                      ; 21DD: 00             
                FCB     $00                      ; 21DE: 00             
                FCB     $00                      ; 21DF: 00             
                FCB     $00                      ; 21E0: 00             
                FCB     $00                      ; 21E1: 00             
                FCB     $00                      ; 21E2: 00             
                FCB     $00                      ; 21E3: 00             
                FCB     $00                      ; 21E4: 00             
                FCB     $00                      ; 21E5: 00             
                FCB     $00                      ; 21E6: 00             
                FCB     $00                      ; 21E7: 00             
                FCB     $00                      ; 21E8: 00             
                FCB     $00                      ; 21E9: 00             
                FCB     $00                      ; 21EA: 00             
                FCB     $00                      ; 21EB: 00             
                FCB     $00                      ; 21EC: 00             
                FCB     $00                      ; 21ED: 00             
                FCB     $00                      ; 21EE: 00             
                FCB     $00                      ; 21EF: 00             
                FCB     $00                      ; 21F0: 00             
                FCB     $00                      ; 21F1: 00             
                FCB     $00                      ; 21F2: 00             
                FCB     $00                      ; 21F3: 00             
                FCB     $00                      ; 21F4: 00             


                END
