dasmfw: Disassembler Framework V0.35
Loaded: binary file "mdoser.sy"
Loaded: Info file "mdoser.info"

;****************************************************
; Used Labels
;****************************************************

Z268B   EQU     $268B
Z2691   EQU     $2691
Z269A   EQU     $269A
Z26A3   EQU     $26A3
Z26A4   EQU     $26A4
Z26A9   EQU     $26A9
Z26B2   EQU     $26B2
Z26BA   EQU     $26BA
Z26CB   EQU     $26CB
OSLOAD  EQU     $E800
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

Z1FFD           TSX                              ; 1FFD: 30             
                FCB     $42                      ; 1FFE: 42             
                BRA     Z2031                    ; 1FFF: 20 30          
                INS                              ; 2001: 31             
                BRA     Z2047                    ; 2002: 20 43          
                CLRA                             ; 2004: 4F             
                TSTA                             ; 2005: 4D             
                TSTA                             ; 2006: 4D             
                FCB     $41                      ; 2007: 41             
                FCB     $4E                      ; 2008: 4E             
                LSRA                             ; 2009: 44             
                BRA     Z205F                    ; 200A: 20 53          
                ROLB                             ; 200C: 59             
                FCB     $4E                      ; 200D: 4E             
                LSRB                             ; 200E: 54             
                FCB     $41                      ; 200F: 41             
                ASLB                             ; 2010: 58             
                BRA     Z2058                    ; 2011: 20 45          
                FCB     $52                      ; 2013: 52             
                FCB     $52                      ; 2014: 52             
                CLRA                             ; 2015: 4F             
                FCB     $52                      ; 2016: 52             
                SEC                              ; 2017: 0D             
                CLV                              ; 2018: 0A             
                TSX                              ; 2019: 30             
                TXS                              ; 201A: 35             
                BRA     Z204D                    ; 201B: 20 30          
                PULA                             ; 201D: 32             
                BRA     Z206E                    ; 201E: 20 4E          
                FCB     $41                      ; 2020: 41             
                TSTA                             ; 2021: 4D             
                FCB     $45                      ; 2022: 45             
                BRA     Z2077                    ; 2023: 20 52          
                FCB     $45                      ; 2025: 45             
                FCB     $51                      ; 2026: 51             
                FCB     $55                      ; 2027: 55             
                ROLA                             ; 2028: 49             
                FCB     $52                      ; 2029: 52             
                FCB     $45                      ; 202A: 45             
                LSRA                             ; 202B: 44             
                SEC                              ; 202C: 0D             
                CLV                              ; 202D: 0A             
                TSX                              ; 202E: 30             
                PSHA                             ; 202F: 36             
                BRA     Z2062                    ; 2030: 20 30          
                PULB                             ; 2032: 33             
                BRA     Z2091                    ; 2033: 20 5C          
                TSX                              ; 2035: 30             
                BRA     Z207C                    ; 2036: 20 44          
                CLRA                             ; 2038: 4F             
                FCB     $45                      ; 2039: 45             
                COMB                             ; 203A: 53             
                BRA     Z208B                    ; 203B: 20 4E          
                CLRA                             ; 203D: 4F             
                LSRB                             ; 203E: 54             
                BRA     Z2086                    ; 203F: 20 45          
                ASLD                             ; 2041: 58 49          
                COMB                             ; 2043: 53             
                LSRB                             ; 2044: 54             
                SEC                              ; 2045: 0D             
                CLV                              ; 2046: 0A             
Z2047           INS                              ; 2047: 31             
                FCB     $42                      ; 2048: 42             
                BRA     Z207B                    ; 2049: 20 30          
                DES                              ; 204B: 34             
                BRA     Z2094                    ; 204C: 20 46          
                ROLA                             ; 204E: 49             
                INCA                             ; 204F: 4C             
                FCB     $45                      ; 2050: 45             
                BRA     Z20A1                    ; 2051: 20 4E          
                FCB     $41                      ; 2053: 41             
                TSTA                             ; 2054: 4D             
                FCB     $45                      ; 2055: 45             
                BRA     Z20A6                    ; 2056: 20 4E          
Z2058           CLRA                             ; 2058: 4F             
                LSRB                             ; 2059: 54             
                BRA     Z20A2                    ; 205A: 20 46          
                CLRA                             ; 205C: 4F             
                FCB     $55                      ; 205D: 55             
                FCB     $4E                      ; 205E: 4E             
Z205F           LSRA                             ; 205F: 44             
                SEC                              ; 2060: 0D             
                CLV                              ; 2061: 0A             
Z2062           TSX                              ; 2062: 30             
                FCB     $38                      ; 2063: 38             
                BRA     Z2096                    ; 2064: 20 30          
                TXS                              ; 2066: 35             
                BRA     Z20C5                    ; 2067: 20 5C          
                TSX                              ; 2069: 30             
                BRA     Z20B0                    ; 206A: 20 44          
                FCB     $55                      ; 206C: 55             
                NEGB                             ; 206D: 50             
Z206E           INCA                             ; 206E: 4C             
                ROLA                             ; 206F: 49             
                COMA                             ; 2070: 43             
                FCB     $41                      ; 2071: 41             
                LSRB                             ; 2072: 54             
                FCB     $45                      ; 2073: 45             
                BRA     Z20BC                    ; 2074: 20 46          
                ROLA                             ; 2076: 49             
Z2077           INCA                             ; 2077: 4C             
                FCB     $45                      ; 2078: 45             
                BRA     Z20C9                    ; 2079: 20 4E          
Z207B           FCB     $41                      ; 207B: 41             
Z207C           TSTA                             ; 207C: 4D             
                FCB     $45                      ; 207D: 45             
                SEC                              ; 207E: 0D             
                CLV                              ; 207F: 0A             
                INS                              ; 2080: 31             
                FCB     $41                      ; 2081: 41             
                BRA     Z20B4                    ; 2082: 20 30          
                PSHA                             ; 2084: 36             
                BRA     Z20CB                    ; 2085: 20 44          
                FCB     $55                      ; 2087: 55             
                NEGB                             ; 2088: 50             
                INCA                             ; 2089: 4C             
                ROLA                             ; 208A: 49             
Z208B           COMA                             ; 208B: 43             
                FCB     $41                      ; 208C: 41             
                LSRB                             ; 208D: 54             
                FCB     $45                      ; 208E: 45             
                BRA     Z20D7                    ; 208F: 20 46          
Z2091           ROLA                             ; 2091: 49             
                INCA                             ; 2092: 4C             
                FCB     $45                      ; 2093: 45             
Z2094           BRA     Z20E4                    ; 2094: 20 4E          
Z2096           FCB     $41                      ; 2096: 41             
                TSTA                             ; 2097: 4D             
                FCB     $45                      ; 2098: 45             
                SEC                              ; 2099: 0D             
                CLV                              ; 209A: 0A             
                TSX                              ; 209B: 30             
                LSRA                             ; 209C: 44             
                BRA     Z20CF                    ; 209D: 20 30          
                PSHB                             ; 209F: 37             
                BRA     Z20F1                    ; 20A0: 20 4F          
Z20A2           NEGB                             ; 20A2: 50             
                LSRB                             ; 20A3: 54             
                ROLA                             ; 20A4: 49             
                CLRA                             ; 20A5: 4F             
Z20A6           FCB     $4E                      ; 20A6: 4E             
                BRA     Z20EC                    ; 20A7: 20 43          
                CLRA                             ; 20A9: 4F             
                FCB     $4E                      ; 20AA: 4E             
                RORA                             ; 20AB: 46             
                INCA                             ; 20AC: 4C             
                ROLA                             ; 20AD: 49             
                COMA                             ; 20AE: 43             
                LSRB                             ; 20AF: 54             
Z20B0           SEC                              ; 20B0: 0D             
                CLV                              ; 20B1: 0A             
                PULB                             ; 20B2: 33             
                TSX                              ; 20B3: 30             
Z20B4           BRA     Z20E6                    ; 20B4: 20 30          
                FCB     $38                      ; 20B6: 38             
                BRA     Z20FC                    ; 20B7: 20 43          
                ASLA                             ; 20B9: 48             
                FCB     $41                      ; 20BA: 41             
                ROLA                             ; 20BB: 49             
Z20BC           FCB     $4E                      ; 20BC: 4E             
                BRA     Z2100                    ; 20BD: 20 41          
                FCB     $42                      ; 20BF: 42             
                CLRA                             ; 20C0: 4F             
                FCB     $52                      ; 20C1: 52             
                LSRB                             ; 20C2: 54             
                FCB     $45                      ; 20C3: 45             
                LSRA                             ; 20C4: 44             
Z20C5           BRA     Z2109                    ; 20C5: 20 42          
                ROLB                             ; 20C7: 59             
                BRA     Z210C                    ; 20C8: 20 42          
                FCB     $52                      ; 20CA: 52             
Z20CB           FCB     $45                      ; 20CB: 45             
                FCB     $41                      ; 20CC: 41             
                FCB     $4B                      ; 20CD: 4B             
                BRA     Z211B                    ; 20CE: 20 4B          
                FCB     $45                      ; 20D0: 45             
                ROLB                             ; 20D1: 59             
                SEC                              ; 20D2: 0D             
                CLV                              ; 20D3: 0A             
                PULB                             ; 20D4: 33             
                INS                              ; 20D5: 31             
                BRA     Z2108                    ; 20D6: 20 30          
                RTS                              ; 20D8: 39             
                BRA     Z211E                    ; 20D9: 20 43          
                ASLA                             ; 20DB: 48             
                FCB     $41                      ; 20DC: 41             
                ROLA                             ; 20DD: 49             
                FCB     $4E                      ; 20DE: 4E             
                BRA     Z2122                    ; 20DF: 20 41          
                FCB     $42                      ; 20E1: 42             
                CLRA                             ; 20E2: 4F             
                FCB     $52                      ; 20E3: 52             
Z20E4           LSRB                             ; 20E4: 54             
                FCB     $45                      ; 20E5: 45             
Z20E6           LSRA                             ; 20E6: 44             
                BRA     Z212B                    ; 20E7: 20 42          
                ROLB                             ; 20E9: 59             
                BRA     Z213F                    ; 20EA: 20 53          
Z20EC           ROLB                             ; 20EC: 59             
                COMB                             ; 20ED: 53             
                LSRB                             ; 20EE: 54             
                FCB     $45                      ; 20EF: 45             
                TSTA                             ; 20F0: 4D             
Z20F1           BRA     Z2138                    ; 20F1: 20 45          
                FCB     $52                      ; 20F3: 52             
                FCB     $52                      ; 20F4: 52             
                CLRA                             ; 20F5: 4F             
                FCB     $52                      ; 20F6: 52             
                BRA     Z214C                    ; 20F7: 20 53          
                LSRB                             ; 20F9: 54             
                FCB     $41                      ; 20FA: 41             
                LSRB                             ; 20FB: 54             
Z20FC           FCB     $55                      ; 20FC: 55             
                COMB                             ; 20FD: 53             
                BRA     Z2157                    ; 20FE: 20 57          
Z2100           CLRA                             ; 2100: 4F             
                FCB     $52                      ; 2101: 52             
                LSRA                             ; 2102: 44             
                SEC                              ; 2103: 0D             
                CLV                              ; 2104: 0A             
                INS                              ; 2105: 31             
                COMA                             ; 2106: 43             
                BRA     Z213A                    ; 2107: 20 31          
Z2109           TSX                              ; 2109: 30             
                BRA     Z2152                    ; 210A: 20 46          
Z210C           ROLA                             ; 210C: 49             
                INCA                             ; 210D: 4C             
                FCB     $45                      ; 210E: 45             
                BRA     Z215A                    ; 210F: 20 49          
                COMB                             ; 2111: 53             
                BRA     Z2158                    ; 2112: 20 44          
                FCB     $45                      ; 2114: 45             
                INCA                             ; 2115: 4C             
                FCB     $45                      ; 2116: 45             
                LSRB                             ; 2117: 54             
                FCB     $45                      ; 2118: 45             
                BRA     Z216B                    ; 2119: 20 50          
Z211B           FCB     $52                      ; 211B: 52             
                CLRA                             ; 211C: 4F             
                LSRB                             ; 211D: 54             
Z211E           FCB     $45                      ; 211E: 45             
                COMA                             ; 211F: 43             
                LSRB                             ; 2120: 54             
                FCB     $45                      ; 2121: 45             
Z2122           LSRA                             ; 2122: 44             
                SEC                              ; 2123: 0D             
                CLV                              ; 2124: 0A             
                PULA                             ; 2125: 32             
                DES                              ; 2126: 34             
                BRA     Z215A                    ; 2127: 20 31          
                INS                              ; 2129: 31             
                BRA     Z2170                    ; 212A: 20 44          
                FCB     $45                      ; 212C: 45             
                RORB                             ; 212D: 56             
                ROLA                             ; 212E: 49             
                COMA                             ; 212F: 43             
                FCB     $45                      ; 2130: 45             
                BRA     Z2181                    ; 2131: 20 4E          
                CLRA                             ; 2133: 4F             
                LSRB                             ; 2134: 54             
                BRA     Z2189                    ; 2135: 20 52          
                FCB     $45                      ; 2137: 45             
Z2138           FCB     $41                      ; 2138: 41             
                LSRA                             ; 2139: 44             
Z213A           ROLB                             ; 213A: 59             
                SEC                              ; 213B: 0D             
                CLV                              ; 213C: 0A             
                TSX                              ; 213D: 30             
                FCB     $45                      ; 213E: 45             
Z213F           BRA     Z2172                    ; 213F: 20 31          
                PULA                             ; 2141: 32             
                BRA     Z218D                    ; 2142: 20 49          
                FCB     $4E                      ; 2144: 4E             
                RORB                             ; 2145: 56             
                FCB     $41                      ; 2146: 41             
                INCA                             ; 2147: 4C             
                ROLA                             ; 2148: 49             
                LSRA                             ; 2149: 44             
                BRA     Z21A0                    ; 214A: 20 54          
Z214C           ROLB                             ; 214C: 59             
                NEGB                             ; 214D: 50             
                FCB     $45                      ; 214E: 45             
                BRA     Z21A0                    ; 214F: 20 4F          
                RORA                             ; 2151: 46             
Z2152           BRA     Z21A3                    ; 2152: 20 4F          
                FCB     $42                      ; 2154: 42             
                DECA                             ; 2155: 4A             
                FCB     $45                      ; 2156: 45             
Z2157           COMA                             ; 2157: 43             
Z2158           LSRB                             ; 2158: 54             
                BRA     Z21A1                    ; 2159: 20 46          
                ROLA                             ; 215B: 49             
                INCA                             ; 215C: 4C             
                FCB     $45                      ; 215D: 45             
                SEC                              ; 215E: 0D             
                CLV                              ; 215F: 0A             
                TSX                              ; 2160: 30             
                RORA                             ; 2161: 46             
                BRA     Z2195                    ; 2162: 20 31          
                PULB                             ; 2164: 33             
                BRA     Z21B0                    ; 2165: 20 49          
                FCB     $4E                      ; 2167: 4E             
                RORB                             ; 2168: 56             
                FCB     $41                      ; 2169: 41             
                INCA                             ; 216A: 4C             
Z216B           ROLA                             ; 216B: 49             
                LSRA                             ; 216C: 44             
                BRA     Z21BB                    ; 216D: 20 4C          
                CLRA                             ; 216F: 4F             
Z2170           FCB     $41                      ; 2170: 41             
                LSRA                             ; 2171: 44             
Z2172           BRA     Z21B5                    ; 2172: 20 41          
                LSRA                             ; 2174: 44             
                LSRA                             ; 2175: 44             
                FCB     $52                      ; 2176: 52             
                FCB     $45                      ; 2177: 45             
                COMB                             ; 2178: 53             
                COMB                             ; 2179: 53             
                SEC                              ; 217A: 0D             
                CLV                              ; 217B: 0A             
                INS                              ; 217C: 31             
                PULB                             ; 217D: 33             
                BRA     Z21B1                    ; 217E: 20 31          
                DES                              ; 2180: 34             
Z2181           BRA     Z21CC                    ; 2181: 20 49          
                FCB     $4E                      ; 2183: 4E             
                RORB                             ; 2184: 56             
                FCB     $41                      ; 2185: 41             
                INCA                             ; 2186: 4C             
                ROLA                             ; 2187: 49             
                LSRA                             ; 2188: 44             
Z2189           BRA     Z21D1                    ; 2189: 20 46          
                ROLA                             ; 218B: 49             
                INCA                             ; 218C: 4C             
Z218D           FCB     $45                      ; 218D: 45             
                BRA     Z21E4                    ; 218E: 20 54          
                ROLB                             ; 2190: 59             
                NEGB                             ; 2191: 50             
                FCB     $45                      ; 2192: 45             
                SEC                              ; 2193: 0D             
                CLV                              ; 2194: 0A             
Z2195           INS                              ; 2195: 31             
                RORA                             ; 2196: 46             
                BRA     Z21CA                    ; 2197: 20 31          
                TXS                              ; 2199: 35             
                BRA     Z21F8                    ; 219A: 20 5C          
                TSX                              ; 219C: 30             
                BRA     Z21E7                    ; 219D: 20 48          
                FCB     $41                      ; 219F: 41             
Z21A0           COMB                             ; 21A0: 53             
Z21A1           BRA     Z21EC                    ; 21A1: 20 49          
Z21A3           FCB     $4E                      ; 21A3: 4E             
                RORB                             ; 21A4: 56             
                FCB     $41                      ; 21A5: 41             
                INCA                             ; 21A6: 4C             
                ROLA                             ; 21A7: 49             
                LSRA                             ; 21A8: 44             
                BRA     Z21F1                    ; 21A9: 20 46          
                ROLA                             ; 21AB: 49             
                INCA                             ; 21AC: 4C             
                FCB     $45                      ; 21AD: 45             
                BRA     Z2204                    ; 21AE: 20 54          
Z21B0           ROLB                             ; 21B0: 59             
Z21B1           NEGB                             ; 21B1: 50             
                FCB     $45                      ; 21B2: 45             
                SEC                              ; 21B3: 0D             
                CLV                              ; 21B4: 0A             
Z21B5           INS                              ; 21B5: 31             
                FCB     $45                      ; 21B6: 45             
                BRA     Z21EA                    ; 21B7: 20 31          
                PSHA                             ; 21B9: 36             
                BRA     Z21FF                    ; 21BA: 20 43          
                CLRA                             ; 21BC: 4F             
                FCB     $4E                      ; 21BD: 4E             
                RORA                             ; 21BE: 46             
                INCA                             ; 21BF: 4C             
                ROLA                             ; 21C0: 49             
                COMA                             ; 21C1: 43             
                LSRB                             ; 21C2: 54             
                ROLA                             ; 21C3: 49             
                FCB     $4E                      ; 21C4: 4E             
                ASRA                             ; 21C5: 47             
                BRA     Z220E                    ; 21C6: 20 46          
                ROLA                             ; 21C8: 49             
                INCA                             ; 21C9: 4C             
Z21CA           FCB     $45                      ; 21CA: 45             
                BRA     Z2221                    ; 21CB: 20 54          
                ROLB                             ; 21CD: 59             
                NEGB                             ; 21CE: 50             
                FCB     $45                      ; 21CF: 45             
                COMB                             ; 21D0: 53             
Z21D1           SEC                              ; 21D1: 0D             
                CLV                              ; 21D2: 0A             
                PULA                             ; 21D3: 32             
                PSHB                             ; 21D4: 37             
                BRA     Z2208                    ; 21D5: 20 31          
                PSHB                             ; 21D7: 37             
                BRA     Z2223                    ; 21D8: 20 49          
                FCB     $4E                      ; 21DA: 4E             
                RORB                             ; 21DB: 56             
                FCB     $41                      ; 21DC: 41             
                INCA                             ; 21DD: 4C             
                ROLA                             ; 21DE: 49             
                LSRA                             ; 21DF: 44             
                BRA     Z2226                    ; 21E0: 20 44          
                FCB     $41                      ; 21E2: 41             
                LSRB                             ; 21E3: 54             
Z21E4           FCB     $41                      ; 21E4: 41             
                BRA     Z223B                    ; 21E5: 20 54          
Z21E7           FCB     $52                      ; 21E7: 52             
                FCB     $41                      ; 21E8: 41             
                FCB     $4E                      ; 21E9: 4E             
Z21EA           COMB                             ; 21EA: 53             
                RORA                             ; 21EB: 46             
Z21EC           FCB     $45                      ; 21EC: 45             
                FCB     $52                      ; 21ED: 52             
                BRA     Z2244                    ; 21EE: 20 54          
                ROLB                             ; 21F0: 59             
Z21F1           NEGB                             ; 21F1: 50             
                FCB     $45                      ; 21F2: 45             
                SEC                              ; 21F3: 0D             
                CLV                              ; 21F4: 0A             
                PULA                             ; 21F5: 32             
                PULA                             ; 21F6: 32             
                BRA     Z222A                    ; 21F7: 20 31          
                FCB     $38                      ; 21F9: 38             
                BRA     Z2240                    ; 21FA: 20 44          
                FCB     $45                      ; 21FC: 45             
                RORB                             ; 21FD: 56             
                ROLA                             ; 21FE: 49             
Z21FF           COMA                             ; 21FF: 43             
                FCB     $45                      ; 2200: 45             
                BRA     Z2244                    ; 2201: 20 41          
                INCA                             ; 2203: 4C             
Z2204           FCB     $52                      ; 2204: 52             
                FCB     $45                      ; 2205: 45             
                FCB     $41                      ; 2206: 41             
                LSRA                             ; 2207: 44             
Z2208           ROLB                             ; 2208: 59             
                BRA     Z225D                    ; 2209: 20 52          
                FCB     $45                      ; 220B: 45             
                COMB                             ; 220C: 53             
                FCB     $45                      ; 220D: 45             
Z220E           FCB     $52                      ; 220E: 52             
                RORB                             ; 220F: 56             
                FCB     $45                      ; 2210: 45             
                LSRA                             ; 2211: 44             
                SEC                              ; 2212: 0D             
                CLV                              ; 2213: 0A             
                PULA                             ; 2214: 32             
                PULB                             ; 2215: 33             
                BRA     Z2249                    ; 2216: 20 31          
                RTS                              ; 2218: 39             
                BRA     Z225F                    ; 2219: 20 44          
                FCB     $45                      ; 221B: 45             
                RORB                             ; 221C: 56             
                ROLA                             ; 221D: 49             
                COMA                             ; 221E: 43             
                FCB     $45                      ; 221F: 45             
                BRA     Z2270                    ; 2220: 20 4E          
                CLRA                             ; 2222: 4F             
Z2223           LSRB                             ; 2223: 54             
                BRA     Z2278                    ; 2224: 20 52          
Z2226           FCB     $45                      ; 2226: 45             
                COMB                             ; 2227: 53             
                FCB     $45                      ; 2228: 45             
                FCB     $52                      ; 2229: 52             
Z222A           RORB                             ; 222A: 56             
                FCB     $45                      ; 222B: 45             
                LSRA                             ; 222C: 44             
                SEC                              ; 222D: 0D             
                CLV                              ; 222E: 0A             
                PULA                             ; 222F: 32             
                TXS                              ; 2230: 35             
                BRA     Z2265                    ; 2231: 20 32          
                TSX                              ; 2233: 30             
                BRA     Z227F                    ; 2234: 20 49          
                FCB     $4E                      ; 2236: 4E             
                RORB                             ; 2237: 56             
                FCB     $41                      ; 2238: 41             
                INCA                             ; 2239: 4C             
                ROLA                             ; 223A: 49             
Z223B           LSRA                             ; 223B: 44             
                BRA     Z228D                    ; 223C: 20 4F          
                NEGB                             ; 223E: 50             
                FCB     $45                      ; 223F: 45             
Z2240           FCB     $4E                      ; 2240: 4E             
                BLE     Z2286                    ; 2241: 2F 43          
                INCA                             ; 2243: 4C             
Z2244           CLRA                             ; 2244: 4F             
                COMB                             ; 2245: 53             
                FCB     $45                      ; 2246: 45             
                LSRA                             ; 2247: 44             
                BRA     Z2290                    ; 2248: 20 46          
                INCA                             ; 224A: 4C             
                FCB     $41                      ; 224B: 41             
                ASRA                             ; 224C: 47             
                SEC                              ; 224D: 0D             
                CLV                              ; 224E: 0A             
                PULA                             ; 224F: 32             
                PSHA                             ; 2250: 36             
                BRA     Z2285                    ; 2251: 20 32          
                INS                              ; 2253: 31             
                BRA     Z229B                    ; 2254: 20 45          
                FCB     $4E                      ; 2256: 4E             
                LSRA                             ; 2257: 44             
                BRA     Z22A9                    ; 2258: 20 4F          
                RORA                             ; 225A: 46             
                BRA     Z22A3                    ; 225B: 20 46          
Z225D           ROLA                             ; 225D: 49             
                INCA                             ; 225E: 4C             
Z225F           FCB     $45                      ; 225F: 45             
                SEC                              ; 2260: 0D             
                CLV                              ; 2261: 0A             
                PULA                             ; 2262: 32             
                RTS                              ; 2263: 39             
                BRA     Z2298                    ; 2264: 20 32          
                PULA                             ; 2266: 32             
                BRA     Z22AB                    ; 2267: 20 42          
                FCB     $55                      ; 2269: 55             
                RORA                             ; 226A: 46             
                RORA                             ; 226B: 46             
                FCB     $45                      ; 226C: 45             
                FCB     $52                      ; 226D: 52             
                BRA     Z22BF                    ; 226E: 20 4F          
Z2270           RORB                             ; 2270: 56             
                FCB     $45                      ; 2271: 45             
                FCB     $52                      ; 2272: 52             
                RORA                             ; 2273: 46             
                INCA                             ; 2274: 4C             
                CLRA                             ; 2275: 4F             
                ASRB                             ; 2276: 57             
                SEC                              ; 2277: 0D             
Z2278           CLV                              ; 2278: 0A             
                PULA                             ; 2279: 32             
                FCB     $41                      ; 227A: 41             
                BRA     Z22AF                    ; 227B: 20 32          
                PULB                             ; 227D: 33             
                BRA     Z22C3                    ; 227E: 20 43          
                ASLA                             ; 2280: 48             
                FCB     $45                      ; 2281: 45             
                COMA                             ; 2282: 43             
                FCB     $4B                      ; 2283: 4B             
                COMB                             ; 2284: 53             
Z2285           FCB     $55                      ; 2285: 55             
Z2286           TSTA                             ; 2286: 4D             
                BRA     Z22CE                    ; 2287: 20 45          
                FCB     $52                      ; 2289: 52             
                FCB     $52                      ; 228A: 52             
                CLRA                             ; 228B: 4F             
                FCB     $52                      ; 228C: 52             
Z228D           SEC                              ; 228D: 0D             
                CLV                              ; 228E: 0A             
                INS                              ; 228F: 31             
Z2290           TXS                              ; 2290: 35             
                BRA     Z22C5                    ; 2291: 20 32          
                DES                              ; 2293: 34             
                BRA     Z22E2                    ; 2294: 20 4C          
                CLRA                             ; 2296: 4F             
                ASRA                             ; 2297: 47             
Z2298           ROLA                             ; 2298: 49             
                COMA                             ; 2299: 43             
                FCB     $41                      ; 229A: 41             
Z229B           INCA                             ; 229B: 4C             
                BRA     Z22F1                    ; 229C: 20 53          
                FCB     $45                      ; 229E: 45             
                COMA                             ; 229F: 43             
                LSRB                             ; 22A0: 54             
                CLRA                             ; 22A1: 4F             
                FCB     $52                      ; 22A2: 52             
Z22A3           BRA     Z22F3                    ; 22A3: 20 4E          
                FCB     $55                      ; 22A5: 55             
                TSTA                             ; 22A6: 4D             
                FCB     $42                      ; 22A7: 42             
                FCB     $45                      ; 22A8: 45             
Z22A9           FCB     $52                      ; 22A9: 52             
                BRA     Z22FB                    ; 22AA: 20 4F          
                FCB     $55                      ; 22AC: 55             
                LSRB                             ; 22AD: 54             
                BRA     Z22FF                    ; 22AE: 20 4F          
                RORA                             ; 22B0: 46             
                BRA     Z2305                    ; 22B1: 20 52          
                FCB     $41                      ; 22B3: 41             
                FCB     $4E                      ; 22B4: 4E             
                ASRA                             ; 22B5: 47             
                FCB     $45                      ; 22B6: 45             
                SEC                              ; 22B7: 0D             
                CLV                              ; 22B8: 0A             
                TSX                              ; 22B9: 30             
                PSHB                             ; 22BA: 37             
                BRA     Z22EF                    ; 22BB: 20 32          
                TXS                              ; 22BD: 35             
                BRA     Z2309                    ; 22BE: 20 49          
                FCB     $4E                      ; 22C0: 4E             
                RORB                             ; 22C1: 56             
                FCB     $41                      ; 22C2: 41             
Z22C3           INCA                             ; 22C3: 4C             
                ROLA                             ; 22C4: 49             
Z22C5           LSRA                             ; 22C5: 44             
                BRA     Z230E                    ; 22C6: 20 46          
                ROLA                             ; 22C8: 49             
                INCA                             ; 22C9: 4C             
                FCB     $45                      ; 22CA: 45             
                BRA     Z231B                    ; 22CB: 20 4E          
                FCB     $41                      ; 22CD: 41             
Z22CE           TSTA                             ; 22CE: 4D             
                FCB     $45                      ; 22CF: 45             
                SEC                              ; 22D0: 0D             
                CLV                              ; 22D1: 0A             
                PULA                             ; 22D2: 32             
                FCB     $42                      ; 22D3: 42             
                BRA     Z2308                    ; 22D4: 20 32          
                PSHA                             ; 22D6: 36             
                BRA     Z231F                    ; 22D7: 20 46          
                ROLA                             ; 22D9: 49             
                INCA                             ; 22DA: 4C             
                FCB     $45                      ; 22DB: 45             
                BRA     Z2327                    ; 22DC: 20 49          
                COMB                             ; 22DE: 53             
                BRA     Z2338                    ; 22DF: 20 57          
                FCB     $52                      ; 22E1: 52             
Z22E2           ROLA                             ; 22E2: 49             
                LSRB                             ; 22E3: 54             
                FCB     $45                      ; 22E4: 45             
                BRA     Z2337                    ; 22E5: 20 50          
                FCB     $52                      ; 22E7: 52             
                CLRA                             ; 22E8: 4F             
                LSRB                             ; 22E9: 54             
                FCB     $45                      ; 22EA: 45             
                COMA                             ; 22EB: 43             
                LSRB                             ; 22EC: 54             
                FCB     $45                      ; 22ED: 45             
                LSRA                             ; 22EE: 44             
Z22EF           SEC                              ; 22EF: 0D             
                CLV                              ; 22F0: 0A             
Z22F1           PULA                             ; 22F1: 32             
                TSX                              ; 22F2: 30             
Z22F3           BRA     Z2327                    ; 22F3: 20 32          
                PSHB                             ; 22F5: 37             
                BRA     Z2354                    ; 22F6: 20 5C          
                TSX                              ; 22F8: 30             
                BRA     Z2344                    ; 22F9: 20 49          
Z22FB           COMB                             ; 22FB: 53             
                BRA     Z2355                    ; 22FC: 20 57          
                FCB     $52                      ; 22FE: 52             
Z22FF           ROLA                             ; 22FF: 49             
                LSRB                             ; 2300: 54             
                FCB     $45                      ; 2301: 45             
                BRA     Z2354                    ; 2302: 20 50          
                FCB     $52                      ; 2304: 52             
Z2305           CLRA                             ; 2305: 4F             
                LSRB                             ; 2306: 54             
                FCB     $45                      ; 2307: 45             
Z2308           COMA                             ; 2308: 43             
Z2309           LSRB                             ; 2309: 54             
                FCB     $45                      ; 230A: 45             
                LSRA                             ; 230B: 44             
                SEC                              ; 230C: 0D             
                CLV                              ; 230D: 0A             
Z230E           TSX                              ; 230E: 30             
                RTS                              ; 230F: 39             
                BRA     Z2344                    ; 2310: 20 32          
                FCB     $38                      ; 2312: 38             
                BRA     Z2359                    ; 2313: 20 44          
                FCB     $45                      ; 2315: 45             
                RORB                             ; 2316: 56             
                ROLA                             ; 2317: 49             
                COMA                             ; 2318: 43             
                FCB     $45                      ; 2319: 45             
                BRA     Z236A                    ; 231A: 20 4E          
                FCB     $41                      ; 231C: 41             
                TSTA                             ; 231D: 4D             
                FCB     $45                      ; 231E: 45             
Z231F           BRA     Z236F                    ; 231F: 20 4E          
                CLRA                             ; 2321: 4F             
                LSRB                             ; 2322: 54             
                BRA     Z236B                    ; 2323: 20 46          
                CLRA                             ; 2325: 4F             
                FCB     $55                      ; 2326: 55             
Z2327           FCB     $4E                      ; 2327: 4E             
                LSRA                             ; 2328: 44             
                SEC                              ; 2329: 0D             
                CLV                              ; 232A: 0A             
                TSX                              ; 232B: 30             
                DES                              ; 232C: 34             
                BRA     Z2361                    ; 232D: 20 32          
                RTS                              ; 232F: 39             
                BRA     Z237B                    ; 2330: 20 49          
                FCB     $4E                      ; 2332: 4E             
                RORB                             ; 2333: 56             
                FCB     $41                      ; 2334: 41             
                INCA                             ; 2335: 4C             
                ROLA                             ; 2336: 49             
Z2337           LSRA                             ; 2337: 44             
Z2338           BRA     Z2386                    ; 2338: 20 4C          
                CLRA                             ; 233A: 4F             
                ASRA                             ; 233B: 47             
                ROLA                             ; 233C: 49             
                COMA                             ; 233D: 43             
                FCB     $41                      ; 233E: 41             
                INCA                             ; 233F: 4C             
                BRA     Z2397                    ; 2340: 20 55          
                FCB     $4E                      ; 2342: 4E             
                ROLA                             ; 2343: 49             
Z2344           LSRB                             ; 2344: 54             
                BRA     Z2395                    ; 2345: 20 4E          
                FCB     $55                      ; 2347: 55             
                TSTA                             ; 2348: 4D             
                FCB     $42                      ; 2349: 42             
                FCB     $45                      ; 234A: 45             
                FCB     $52                      ; 234B: 52             
                SEC                              ; 234C: 0D             
                CLV                              ; 234D: 0A             
                INS                              ; 234E: 31             
                PULA                             ; 234F: 32             
                BRA     Z2385                    ; 2350: 20 33          
                TSX                              ; 2352: 30             
                BRA     Z239E                    ; 2353: 20 49          
Z2355           FCB     $4E                      ; 2355: 4E             
                RORB                             ; 2356: 56             
                FCB     $41                      ; 2357: 41             
                INCA                             ; 2358: 4C             
Z2359           ROLA                             ; 2359: 49             
                LSRA                             ; 235A: 44             
                BRA     Z23A2                    ; 235B: 20 45          
                ASLB                             ; 235D: 58             
                FCB     $45                      ; 235E: 45             
                COMA                             ; 235F: 43             
                FCB     $55                      ; 2360: 55             
Z2361           LSRB                             ; 2361: 54             
                ROLA                             ; 2362: 49             
                CLRA                             ; 2363: 4F             
                FCB     $4E                      ; 2364: 4E             
                BRA     Z23A8                    ; 2365: 20 41          
                LSRA                             ; 2367: 44             
                LSRA                             ; 2368: 44             
                FCB     $52                      ; 2369: 52             
Z236A           FCB     $45                      ; 236A: 45             
Z236B           COMB                             ; 236B: 53             
                COMB                             ; 236C: 53             
                SEC                              ; 236D: 0D             
                CLV                              ; 236E: 0A             
Z236F           TSX                              ; 236F: 30             
                FCB     $41                      ; 2370: 41             
                BRA     Z23A6                    ; 2371: 20 33          
                INS                              ; 2373: 31             
                BRA     Z23BF                    ; 2374: 20 49          
                FCB     $4E                      ; 2376: 4E             
                RORB                             ; 2377: 56             
                FCB     $41                      ; 2378: 41             
                INCA                             ; 2379: 4C             
                ROLA                             ; 237A: 49             
Z237B           LSRA                             ; 237B: 44             
                BRA     Z23C2                    ; 237C: 20 44          
                FCB     $45                      ; 237E: 45             
                RORB                             ; 237F: 56             
                ROLA                             ; 2380: 49             
                COMA                             ; 2381: 43             
                FCB     $45                      ; 2382: 45             
                SEC                              ; 2383: 0D             
                CLV                              ; 2384: 0A             
Z2385           INS                              ; 2385: 31             
Z2386           INS                              ; 2386: 31             
                BRA     Z23BC                    ; 2387: 20 33          
                PULA                             ; 2389: 32             
                BRA     Z23D5                    ; 238A: 20 49          
                FCB     $4E                      ; 238C: 4E             
                RORB                             ; 238D: 56             
                FCB     $41                      ; 238E: 41             
                INCA                             ; 238F: 4C             
                ROLA                             ; 2390: 49             
                LSRA                             ; 2391: 44             
                BRA     Z23E6                    ; 2392: 20 52          
                ROLA                             ; 2394: 49             
Z2395           FCB     $42                      ; 2395: 42             
                SEC                              ; 2396: 0D             
Z2397           CLV                              ; 2397: 0A             
                INS                              ; 2398: 31             
                LSRA                             ; 2399: 44             
                BRA     Z23CF                    ; 239A: 20 33          
                PULB                             ; 239C: 33             
                BRA     Z23F3                    ; 239D: 20 54          
                CLRA                             ; 239F: 4F             
                CLRA                             ; 23A0: 4F             
                BRA     Z23F0                    ; 23A1: 20 4D          
                FCB     $41                      ; 23A3: 41             
                FCB     $4E                      ; 23A4: 4E             
                ROLB                             ; 23A5: 59             
Z23A6           BRA     Z23FB                    ; 23A6: 20 53          
Z23A8           CLRA                             ; 23A8: 4F             
                FCB     $55                      ; 23A9: 55             
                FCB     $52                      ; 23AA: 52             
                COMA                             ; 23AB: 43             
                FCB     $45                      ; 23AC: 45             
                BRA     Z23F5                    ; 23AD: 20 46          
                ROLA                             ; 23AF: 49             
                INCA                             ; 23B0: 4C             
                FCB     $45                      ; 23B1: 45             
                COMB                             ; 23B2: 53             
                SEC                              ; 23B3: 0D             
                CLV                              ; 23B4: 0A             
                INS                              ; 23B5: 31             
                PSHA                             ; 23B6: 36             
                BRA     Z23EC                    ; 23B7: 20 33          
                DES                              ; 23B9: 34             
                BRA     Z2405                    ; 23BA: 20 49          
Z23BC           FCB     $4E                      ; 23BC: 4E             
                RORB                             ; 23BD: 56             
                FCB     $41                      ; 23BE: 41             
Z23BF           INCA                             ; 23BF: 4C             
                ROLA                             ; 23C0: 49             
                LSRA                             ; 23C1: 44             
Z23C2           BRA     Z2417                    ; 23C2: 20 53          
                LSRB                             ; 23C4: 54             
                FCB     $41                      ; 23C5: 41             
                FCB     $52                      ; 23C6: 52             
                LSRB                             ; 23C7: 54             
                BLE     Z240F                    ; 23C8: 2F 45          
                FCB     $4E                      ; 23CA: 4E             
                LSRA                             ; 23CB: 44             
                BRA     Z2421                    ; 23CC: 20 53          
                NEGB                             ; 23CE: 50             
Z23CF           FCB     $45                      ; 23CF: 45             
                COMA                             ; 23D0: 43             
                ROLA                             ; 23D1: 49             
                RORA                             ; 23D2: 46             
                ROLA                             ; 23D3: 49             
                COMA                             ; 23D4: 43             
Z23D5           FCB     $41                      ; 23D5: 41             
                LSRB                             ; 23D6: 54             
                ROLA                             ; 23D7: 49             
                CLRA                             ; 23D8: 4F             
                FCB     $4E                      ; 23D9: 4E             
                COMB                             ; 23DA: 53             
                SEC                              ; 23DB: 0D             
                CLV                              ; 23DC: 0A             
                INS                              ; 23DD: 31             
                PSHB                             ; 23DE: 37             
                BRA     Z2414                    ; 23DF: 20 33          
                TXS                              ; 23E1: 35             
                BRA     Z242D                    ; 23E2: 20 49          
                FCB     $4E                      ; 23E4: 4E             
                RORB                             ; 23E5: 56             
Z23E6           FCB     $41                      ; 23E6: 41             
                INCA                             ; 23E7: 4C             
                ROLA                             ; 23E8: 49             
                LSRA                             ; 23E9: 44             
                BRA     Z243C                    ; 23EA: 20 50          
Z23EC           FCB     $41                      ; 23EC: 41             
                ASRA                             ; 23ED: 47             
                FCB     $45                      ; 23EE: 45             
                BRA     Z2437                    ; 23EF: 20 46          
                CLRA                             ; 23F1: 4F             
                FCB     $52                      ; 23F2: 52             
Z23F3           TSTA                             ; 23F3: 4D             
                FCB     $41                      ; 23F4: 41             
Z23F5           LSRB                             ; 23F5: 54             
                SEC                              ; 23F6: 0D             
                CLV                              ; 23F7: 0A             
                INS                              ; 23F8: 31             
                DES                              ; 23F9: 34             
                BRA     Z242F                    ; 23FA: 20 33          
                PSHA                             ; 23FC: 36             
                BRA     Z2445                    ; 23FD: 20 46          
                ROLA                             ; 23FF: 49             
                INCA                             ; 2400: 4C             
                FCB     $45                      ; 2401: 45             
                BRA     Z2449                    ; 2402: 20 45          
                ASLB                             ; 2404: 58             
Z2405           ASLA                             ; 2405: 48             
                FCB     $41                      ; 2406: 41             
                FCB     $55                      ; 2407: 55             
                COMB                             ; 2408: 53             
                LSRB                             ; 2409: 54             
                FCB     $45                      ; 240A: 45             
                LSRA                             ; 240B: 44             
                BRA     Z2450                    ; 240C: 20 42          
                FCB     $45                      ; 240E: 45             
Z240F           RORA                             ; 240F: 46             
                CLRA                             ; 2410: 4F             
                FCB     $52                      ; 2411: 52             
                FCB     $45                      ; 2412: 45             
                BRA     Z2461                    ; 2413: 20 4C          
                ROLA                             ; 2415: 49             
                FCB     $4E                      ; 2416: 4E             
Z2417           FCB     $45                      ; 2417: 45             
                BRA     Z2460                    ; 2418: 20 46          
                CLRA                             ; 241A: 4F             
                FCB     $55                      ; 241B: 55             
                FCB     $4E                      ; 241C: 4E             
                LSRA                             ; 241D: 44             
                SEC                              ; 241E: 0D             
                CLV                              ; 241F: 0A             
                PULA                             ; 2420: 32             
Z2421           FCB     $38                      ; 2421: 38             
                BRA     Z2457                    ; 2422: 20 33          
                PSHB                             ; 2424: 37             
                BRA     Z246C                    ; 2425: 20 45          
                FCB     $4E                      ; 2427: 4E             
                LSRA                             ; 2428: 44             
                BRA     Z247A                    ; 2429: 20 4F          
                RORA                             ; 242B: 46             
                BRA     Z247B                    ; 242C: 20 4D          
                FCB     $45                      ; 242E: 45             
Z242F           LSRA                             ; 242F: 44             
                ROLA                             ; 2430: 49             
                FCB     $41                      ; 2431: 41             
                SEC                              ; 2432: 0D             
                CLV                              ; 2433: 0A             
                INS                              ; 2434: 31             
                FCB     $38                      ; 2435: 38             
                BRA     Z246B                    ; 2436: 20 33          
                FCB     $38                      ; 2438: 38             
                BRA     Z2484                    ; 2439: 20 49          
                FCB     $4E                      ; 243B: 4E             
Z243C           RORB                             ; 243C: 56             
                FCB     $41                      ; 243D: 41             
                INCA                             ; 243E: 4C             
                ROLA                             ; 243F: 49             
                LSRA                             ; 2440: 44             
                BRA     Z248F                    ; 2441: 20 4C          
                ROLA                             ; 2443: 49             
                FCB     $4E                      ; 2444: 4E             
Z2445           FCB     $45                      ; 2445: 45             
                BRA     Z2496                    ; 2446: 20 4E          
                FCB     $55                      ; 2448: 55             
Z2449           TSTA                             ; 2449: 4D             
                FCB     $42                      ; 244A: 42             
                FCB     $45                      ; 244B: 45             
                FCB     $52                      ; 244C: 52             
                BRA     Z249E                    ; 244D: 20 4F          
                FCB     $52                      ; 244F: 52             
Z2450           BRA     Z24A4                    ; 2450: 20 52          
                FCB     $41                      ; 2452: 41             
                FCB     $4E                      ; 2453: 4E             
                ASRA                             ; 2454: 47             
                FCB     $45                      ; 2455: 45             
                SEC                              ; 2456: 0D             
Z2457           CLV                              ; 2457: 0A             
                INS                              ; 2458: 31             
                RTS                              ; 2459: 39             
                BRA     Z248F                    ; 245A: 20 33          
                RTS                              ; 245C: 39             
                BRA     Z24AB                    ; 245D: 20 4C          
                ROLA                             ; 245F: 49             
Z2460           FCB     $4E                      ; 2460: 4E             
Z2461           FCB     $45                      ; 2461: 45             
                BRA     Z24B2                    ; 2462: 20 4E          
                FCB     $55                      ; 2464: 55             
                TSTA                             ; 2465: 4D             
                FCB     $42                      ; 2466: 42             
                FCB     $45                      ; 2467: 45             
                FCB     $52                      ; 2468: 52             
                BRA     Z24B0                    ; 2469: 20 45          
Z246B           FCB     $4E                      ; 246B: 4E             
Z246C           LSRB                             ; 246C: 54             
                FCB     $45                      ; 246D: 45             
                FCB     $52                      ; 246E: 52             
                FCB     $45                      ; 246F: 45             
                LSRA                             ; 2470: 44             
                BRA     Z24B5                    ; 2471: 20 42          
                FCB     $45                      ; 2473: 45             
                RORA                             ; 2474: 46             
                CLRA                             ; 2475: 4F             
                FCB     $52                      ; 2476: 52             
                FCB     $45                      ; 2477: 45             
                BRA     Z24CD                    ; 2478: 20 53          
Z247A           CLRA                             ; 247A: 4F             
Z247B           FCB     $55                      ; 247B: 55             
                FCB     $52                      ; 247C: 52             
                COMA                             ; 247D: 43             
                FCB     $45                      ; 247E: 45             
                BRA     Z24C7                    ; 247F: 20 46          
                ROLA                             ; 2481: 49             
                INCA                             ; 2482: 4C             
                FCB     $45                      ; 2483: 45             
Z2484           SEC                              ; 2484: 0D             
                CLV                              ; 2485: 0A             
                TSX                              ; 2486: 30             
                PULA                             ; 2487: 32             
                BRA     Z24BE                    ; 2488: 20 34          
                TSX                              ; 248A: 30             
                BRA     Z24D1                    ; 248B: 20 44          
                ROLA                             ; 248D: 49             
                FCB     $52                      ; 248E: 52             
Z248F           FCB     $45                      ; 248F: 45             
                COMA                             ; 2490: 43             
                LSRB                             ; 2491: 54             
                CLRA                             ; 2492: 4F             
                FCB     $52                      ; 2493: 52             
                ROLB                             ; 2494: 59             
                BRA     Z24EA                    ; 2495: 20 53          
                NEGB                             ; 2497: 50             
                FCB     $41                      ; 2498: 41             
                COMA                             ; 2499: 43             
                FCB     $45                      ; 249A: 45             
                BRA     Z24E3                    ; 249B: 20 46          
                FCB     $55                      ; 249D: 55             
Z249E           INCA                             ; 249E: 4C             
                INCA                             ; 249F: 4C             
                SEC                              ; 24A0: 0D             
                CLV                              ; 24A1: 0A             
                TSX                              ; 24A2: 30             
                PULB                             ; 24A3: 33             
Z24A4           BRA     Z24DA                    ; 24A4: 20 34          
                INS                              ; 24A6: 31             
                BRA     Z24F2                    ; 24A7: 20 49          
                FCB     $4E                      ; 24A9: 4E             
                COMB                             ; 24AA: 53             
Z24AB           FCB     $55                      ; 24AB: 55             
                RORA                             ; 24AC: 46             
                RORA                             ; 24AD: 46             
                ROLA                             ; 24AE: 49             
                COMA                             ; 24AF: 43             
Z24B0           ROLA                             ; 24B0: 49             
                FCB     $45                      ; 24B1: 45             
Z24B2           FCB     $4E                      ; 24B2: 4E             
                LSRB                             ; 24B3: 54             
                BRA     Z24FA                    ; 24B4: 20 44          
                ROLA                             ; 24B6: 49             
                COMB                             ; 24B7: 53             
                FCB     $4B                      ; 24B8: 4B             
                BRA     Z250E                    ; 24B9: 20 53          
                NEGB                             ; 24BB: 50             
                FCB     $41                      ; 24BC: 41             
                COMA                             ; 24BD: 43             
Z24BE           FCB     $45                      ; 24BE: 45             
                SEC                              ; 24BF: 0D             
                CLV                              ; 24C0: 0A             
                INS                              ; 24C1: 31             
                TSX                              ; 24C2: 30             
                BRA     Z24F9                    ; 24C3: 20 34          
                PULA                             ; 24C5: 32             
                BRA     Z251B                    ; 24C6: 20 53          
                FCB     $45                      ; 24C8: 45             
                ASRA                             ; 24C9: 47             
                TSTA                             ; 24CA: 4D             
                FCB     $45                      ; 24CB: 45             
                FCB     $4E                      ; 24CC: 4E             
Z24CD           LSRB                             ; 24CD: 54             
                BRA     Z2514                    ; 24CE: 20 44          
                FCB     $45                      ; 24D0: 45             
Z24D1           COMB                             ; 24D1: 53             
                COMA                             ; 24D2: 43             
                FCB     $52                      ; 24D3: 52             
                ROLA                             ; 24D4: 49             
                NEGB                             ; 24D5: 50             
                LSRB                             ; 24D6: 54             
                CLRA                             ; 24D7: 4F             
                FCB     $52                      ; 24D8: 52             
                BRA     Z252E                    ; 24D9: 20 53          
                NEGB                             ; 24DB: 50             
                FCB     $41                      ; 24DC: 41             
                COMA                             ; 24DD: 43             
                FCB     $45                      ; 24DE: 45             
                BRA     Z2527                    ; 24DF: 20 46          
                FCB     $55                      ; 24E1: 55             
                INCA                             ; 24E2: 4C             
Z24E3           INCA                             ; 24E3: 4C             
                SEC                              ; 24E4: 0D             
                CLV                              ; 24E5: 0A             
                PULA                             ; 24E6: 32             
                COMA                             ; 24E7: 43             
                BRA     Z251E                    ; 24E8: 20 34          
Z24EA           PULB                             ; 24EA: 33             
                BRA     Z2536                    ; 24EB: 20 49          
                FCB     $4E                      ; 24ED: 4E             
                RORB                             ; 24EE: 56             
                FCB     $41                      ; 24EF: 41             
                INCA                             ; 24F0: 4C             
                ROLA                             ; 24F1: 49             
Z24F2           LSRA                             ; 24F2: 44             
                BRA     Z2539                    ; 24F3: 20 44          
                ROLA                             ; 24F5: 49             
                FCB     $52                      ; 24F6: 52             
                FCB     $45                      ; 24F7: 45             
                COMA                             ; 24F8: 43             
Z24F9           LSRB                             ; 24F9: 54             
Z24FA           CLRA                             ; 24FA: 4F             
                FCB     $52                      ; 24FB: 52             
                ROLB                             ; 24FC: 59             
                BRA     Z2544                    ; 24FD: 20 45          
                FCB     $4E                      ; 24FF: 4E             
                LSRB                             ; 2500: 54             
                FCB     $52                      ; 2501: 52             
                ROLB                             ; 2502: 59             
                BRA     Z2553                    ; 2503: 20 4E          
                CLRA                             ; 2505: 4F             
                BGT     Z2528                    ; 2506: 2E 20          
                FCB     $41                      ; 2508: 41             
                LSRB                             ; 2509: 54             
                BRA     Z2568                    ; 250A: 20 5C          
                FCB     $38                      ; 250C: 38             
                SEC                              ; 250D: 0D             
Z250E           CLV                              ; 250E: 0A             
                PULA                             ; 250F: 32             
                LSRA                             ; 2510: 44             
                BRA     Z2547                    ; 2511: 20 34          
                DES                              ; 2513: 34             
Z2514           BRA     Z2559                    ; 2514: 20 43          
                FCB     $41                      ; 2516: 41             
                FCB     $4E                      ; 2517: 4E             
                FCB     $4E                      ; 2518: 4E             
                CLRA                             ; 2519: 4F             
                LSRB                             ; 251A: 54             
Z251B           BRA     Z2561                    ; 251B: 20 44          
                FCB     $45                      ; 251D: 45             
Z251E           FCB     $41                      ; 251E: 41             
                INCA                             ; 251F: 4C             
                INCA                             ; 2520: 4C             
                CLRA                             ; 2521: 4F             
                COMA                             ; 2522: 43             
                FCB     $41                      ; 2523: 41             
                LSRB                             ; 2524: 54             
                FCB     $45                      ; 2525: 45             
                BRA     Z2569                    ; 2526: 20 41          
Z2528           INCA                             ; 2528: 4C             
                INCA                             ; 2529: 4C             
                BRA     Z257F                    ; 252A: 20 53          
                NEGB                             ; 252C: 50             
                FCB     $41                      ; 252D: 41             
Z252E           COMA                             ; 252E: 43             
                FCB     $45                      ; 252F: 45             
                BGE     Z2552                    ; 2530: 2C 20          
                LSRA                             ; 2532: 44             
                ROLA                             ; 2533: 49             
                FCB     $52                      ; 2534: 52             
                FCB     $45                      ; 2535: 45             
Z2536           COMA                             ; 2536: 43             
                LSRB                             ; 2537: 54             
                CLRA                             ; 2538: 4F             
Z2539           FCB     $52                      ; 2539: 52             
                ROLB                             ; 253A: 59             
                BRA     Z2582                    ; 253B: 20 45          
                FCB     $4E                      ; 253D: 4E             
                LSRB                             ; 253E: 54             
                FCB     $52                      ; 253F: 52             
                ROLB                             ; 2540: 59             
                BRA     Z2588                    ; 2541: 20 45          
                ASLB                             ; 2543: 58             
Z2544           ROLA                             ; 2544: 49             
                COMB                             ; 2545: 53             
                LSRB                             ; 2546: 54             
Z2547           COMB                             ; 2547: 53             
                BRA     Z258B                    ; 2548: 20 41          
                LSRB                             ; 254A: 54             
                BRA     Z25A9                    ; 254B: 20 5C          
                FCB     $38                      ; 254D: 38             
                SEC                              ; 254E: 0D             
                CLV                              ; 254F: 0A             
                PULA                             ; 2550: 32             
                FCB     $45                      ; 2551: 45             
Z2552           BRA     Z2588                    ; 2552: 20 34          
                TXS                              ; 2554: 35             
                BRA     Z25A9                    ; 2555: 20 52          
                FCB     $45                      ; 2557: 45             
                COMA                             ; 2558: 43             
Z2559           CLRA                             ; 2559: 4F             
                FCB     $52                      ; 255A: 52             
                LSRA                             ; 255B: 44             
                BRA     Z25AA                    ; 255C: 20 4C          
                FCB     $45                      ; 255E: 45             
                FCB     $4E                      ; 255F: 4E             
                ASRA                             ; 2560: 47             
Z2561           LSRB                             ; 2561: 54             
                ASLA                             ; 2562: 48             
                BRA     Z25B9                    ; 2563: 20 54          
                CLRA                             ; 2565: 4F             
                CLRA                             ; 2566: 4F             
                BRA     Z25B5                    ; 2567: 20 4C          
Z2569           FCB     $41                      ; 2569: 41             
                FCB     $52                      ; 256A: 52             
                ASRA                             ; 256B: 47             
                FCB     $45                      ; 256C: 45             
                SEC                              ; 256D: 0D             
                CLV                              ; 256E: 0A             
                TSX                              ; 256F: 30             
                COMA                             ; 2570: 43             
                BRA     Z25A7                    ; 2571: 20 34          
                PSHA                             ; 2573: 36             
                BRA     Z25BF                    ; 2574: 20 49          
                FCB     $4E                      ; 2576: 4E             
                LSRB                             ; 2577: 54             
                FCB     $45                      ; 2578: 45             
                FCB     $52                      ; 2579: 52             
                FCB     $4E                      ; 257A: 4E             
                FCB     $41                      ; 257B: 41             
                INCA                             ; 257C: 4C             
                BRA     Z25D2                    ; 257D: 20 53          
Z257F           ROLB                             ; 257F: 59             
                COMB                             ; 2580: 53             
                LSRB                             ; 2581: 54             
Z2582           FCB     $45                      ; 2582: 45             
                TSTA                             ; 2583: 4D             
                BRA     Z25CB                    ; 2584: 20 45          
                FCB     $52                      ; 2586: 52             
                FCB     $52                      ; 2587: 52             
Z2588           CLRA                             ; 2588: 4F             
                FCB     $52                      ; 2589: 52             
                BRA     Z25CD                    ; 258A: 20 41          
                LSRB                             ; 258C: 54             
                BRA     Z25EB                    ; 258D: 20 5C          
                FCB     $38                      ; 258F: 38             
                SEC                              ; 2590: 0D             
                CLV                              ; 2591: 0A             
                PULA                             ; 2592: 32             
                INS                              ; 2593: 31             
                BRA     Z25CA                    ; 2594: 20 34          
                PSHB                             ; 2596: 37             
                BRA     Z25E2                    ; 2597: 20 49          
                FCB     $4E                      ; 2599: 4E             
                RORB                             ; 259A: 56             
                FCB     $41                      ; 259B: 41             
                INCA                             ; 259C: 4C             
                ROLA                             ; 259D: 49             
                LSRA                             ; 259E: 44             
                BRA     Z25F4                    ; 259F: 20 53          
                COMA                             ; 25A1: 43             
                FCB     $41                      ; 25A2: 41             
                INCA                             ; 25A3: 4C             
                INCA                             ; 25A4: 4C             
                SEC                              ; 25A5: 0D             
                CLV                              ; 25A6: 0A             
Z25A7           PULA                             ; 25A7: 32             
                RORA                             ; 25A8: 46             
Z25A9           BRA     Z25DF                    ; 25A9: 20 34          
                FCB     $38                      ; 25AB: 38             
                BRA     Z25F1                    ; 25AC: 20 43          
                ASLA                             ; 25AE: 48             
                FCB     $41                      ; 25AF: 41             
                ROLA                             ; 25B0: 49             
                FCB     $4E                      ; 25B1: 4E             
                BRA     Z2603                    ; 25B2: 20 4F          
                RORB                             ; 25B4: 56             
Z25B5           FCB     $45                      ; 25B5: 45             
                FCB     $52                      ; 25B6: 52             
                INCA                             ; 25B7: 4C             
                FCB     $41                      ; 25B8: 41             
Z25B9           ROLB                             ; 25B9: 59             
                BRA     Z2600                    ; 25BA: 20 44          
                CLRA                             ; 25BC: 4F             
                FCB     $45                      ; 25BD: 45             
                COMB                             ; 25BE: 53             
Z25BF           BRA     Z260F                    ; 25BF: 20 4E          
                CLRA                             ; 25C1: 4F             
                LSRB                             ; 25C2: 54             
                BRA     Z260A                    ; 25C3: 20 45          
                ASLD                             ; 25C5: 58 49          
                COMB                             ; 25C7: 53             
                LSRB                             ; 25C8: 54             
                SEC                              ; 25C9: 0D             
Z25CA           CLV                              ; 25CA: 0A             
Z25CB           PULB                             ; 25CB: 33             
                PULA                             ; 25CC: 32             
Z25CD           BRA     Z2603                    ; 25CD: 20 34          
                RTS                              ; 25CF: 39             
                BRA     Z2615                    ; 25D0: 20 43          
Z25D2           ASLA                             ; 25D2: 48             
                FCB     $41                      ; 25D3: 41             
                ROLA                             ; 25D4: 49             
                FCB     $4E                      ; 25D5: 4E             
                BRA     Z2619                    ; 25D6: 20 41          
                FCB     $42                      ; 25D8: 42             
                CLRA                             ; 25D9: 4F             
                FCB     $52                      ; 25DA: 52             
                LSRB                             ; 25DB: 54             
                FCB     $45                      ; 25DC: 45             
                LSRA                             ; 25DD: 44             
                BRA     Z2622                    ; 25DE: 20 42          
                ROLB                             ; 25E0: 59             
                BRA     Z262C                    ; 25E1: 20 49          
                INCA                             ; 25E3: 4C             
                INCA                             ; 25E4: 4C             
                FCB     $45                      ; 25E5: 45             
                ASRA                             ; 25E6: 47             
                FCB     $41                      ; 25E7: 41             
                INCA                             ; 25E8: 4C             
                BRA     Z263A                    ; 25E9: 20 4F          
Z25EB           NEGB                             ; 25EB: 50             
                FCB     $45                      ; 25EC: 45             
                FCB     $52                      ; 25ED: 52             
                FCB     $41                      ; 25EE: 41             
                LSRB                             ; 25EF: 54             
                CLRA                             ; 25F0: 4F             
Z25F1           FCB     $52                      ; 25F1: 52             
                SEC                              ; 25F2: 0D             
                CLV                              ; 25F3: 0A             
Z25F4           PULB                             ; 25F4: 33             
                PULB                             ; 25F5: 33             
                BRA     Z262D                    ; 25F6: 20 35          
                TSX                              ; 25F8: 30             
                BRA     Z263E                    ; 25F9: 20 43          
                ASLA                             ; 25FB: 48             
                FCB     $41                      ; 25FC: 41             
                ROLA                             ; 25FD: 49             
                FCB     $4E                      ; 25FE: 4E             
                BRA     Z2642                    ; 25FF: 20 41          
                FCB     $42                      ; 2601: 42             
                CLRA                             ; 2602: 4F             
Z2603           FCB     $52                      ; 2603: 52             
                LSRB                             ; 2604: 54             
                FCB     $45                      ; 2605: 45             
                LSRA                             ; 2606: 44             
                BRA     Z264B                    ; 2607: 20 42          
                ROLB                             ; 2609: 59             
Z260A           BRA     Z2661                    ; 260A: 20 55          
                FCB     $4E                      ; 260C: 4E             
                LSRA                             ; 260D: 44             
                FCB     $45                      ; 260E: 45             
Z260F           RORA                             ; 260F: 46             
                ROLA                             ; 2610: 49             
                FCB     $4E                      ; 2611: 4E             
                FCB     $45                      ; 2612: 45             
                LSRA                             ; 2613: 44             
                BRA     Z2662                    ; 2614: 20 4C          
                FCB     $41                      ; 2616: 41             
                FCB     $42                      ; 2617: 42             
                FCB     $45                      ; 2618: 45             
Z2619           INCA                             ; 2619: 4C             
                SEC                              ; 261A: 0D             
                CLV                              ; 261B: 0A             
                PULB                             ; 261C: 33             
                DES                              ; 261D: 34             
                BRA     Z2655                    ; 261E: 20 35          
                INS                              ; 2620: 31             
                BRA     Z2666                    ; 2621: 20 43          
                ASLA                             ; 2623: 48             
                FCB     $41                      ; 2624: 41             
                ROLA                             ; 2625: 49             
                FCB     $4E                      ; 2626: 4E             
                BRA     Z266A                    ; 2627: 20 41          
                FCB     $42                      ; 2629: 42             
                CLRA                             ; 262A: 4F             
                FCB     $52                      ; 262B: 52             
Z262C           LSRB                             ; 262C: 54             
Z262D           FCB     $45                      ; 262D: 45             
                LSRA                             ; 262E: 44             
                BRA     Z2673                    ; 262F: 20 42          
                ROLB                             ; 2631: 59             
                BRA     Z2684                    ; 2632: 20 50          
                FCB     $52                      ; 2634: 52             
                FCB     $45                      ; 2635: 45             
                TSTA                             ; 2636: 4D             
                FCB     $41                      ; 2637: 41             
                LSRB                             ; 2638: 54             
                FCB     $55                      ; 2639: 55             
Z263A           FCB     $52                      ; 263A: 52             
                FCB     $45                      ; 263B: 45             
                BRA     Z2683                    ; 263C: 20 45          
Z263E           FCB     $4E                      ; 263E: 4E             
                LSRA                             ; 263F: 44             
                BRA     Z2691                    ; 2640: 20 4F          
Z2642           RORA                             ; 2642: 46             
                BRA     Z268B                    ; 2643: 20 46          
                ROLA                             ; 2645: 49             
                INCA                             ; 2646: 4C             
                FCB     $45                      ; 2647: 45             
                SEC                              ; 2648: 0D             
                CLV                              ; 2649: 0A             
                PULB                             ; 264A: 33             
Z264B           TXS                              ; 264B: 35             
                BRA     Z2683                    ; 264C: 20 35          
                PULA                             ; 264E: 32             
                BRA     Z26A4                    ; 264F: 20 53          
                FCB     $45                      ; 2651: 45             
                COMA                             ; 2652: 43             
                LSRB                             ; 2653: 54             
                CLRA                             ; 2654: 4F             
Z2655           FCB     $52                      ; 2655: 52             
                BRA     Z269A                    ; 2656: 20 42          
                FCB     $55                      ; 2658: 55             
                RORA                             ; 2659: 46             
                RORA                             ; 265A: 46             
                FCB     $45                      ; 265B: 45             
                FCB     $52                      ; 265C: 52             
                BRA     Z26B2                    ; 265D: 20 53          
                ROLA                             ; 265F: 49             
                DECB                             ; 2660: 5A             
Z2661           FCB     $45                      ; 2661: 45             
Z2662           BRA     Z26A9                    ; 2662: 20 45          
                FCB     $52                      ; 2664: 52             
                FCB     $52                      ; 2665: 52             
Z2666           CLRA                             ; 2666: 4F             
                FCB     $52                      ; 2667: 52             
                SEC                              ; 2668: 0D             
                CLV                              ; 2669: 0A             
Z266A           PULB                             ; 266A: 33             
                PSHA                             ; 266B: 36             
                BRA     Z26A3                    ; 266C: 20 35          
                PULB                             ; 266E: 33             
                BRA     Z26BA                    ; 266F: 20 49          
                FCB     $4E                      ; 2671: 4E             
                COMB                             ; 2672: 53             
Z2673           FCB     $55                      ; 2673: 55             
                RORA                             ; 2674: 46             
                RORA                             ; 2675: 46             
                ROLA                             ; 2676: 49             
                COMA                             ; 2677: 43             
                ROLA                             ; 2678: 49             
                FCB     $45                      ; 2679: 45             
                FCB     $4E                      ; 267A: 4E             
                LSRB                             ; 267B: 54             
                BRA     Z26CB                    ; 267C: 20 4D          
                FCB     $45                      ; 267E: 45             
                TSTA                             ; 267F: 4D             
                CLRA                             ; 2680: 4F             
                FCB     $52                      ; 2681: 52             
                ROLB                             ; 2682: 59             
Z2683           SEC                              ; 2683: 0D             
Z2684           CLV                              ; 2684: 0A             


                END
