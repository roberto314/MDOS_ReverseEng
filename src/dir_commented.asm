
         include "mdoseq.inc"

PFNMSTAT EQU     $0020
OPTIONS EQU     $0021
EXADDRH EQU     $0022
ENTRYNUMEQU     $0023
M0024   EQU     $0024
M0025   EQU     $0025
M0026   EQU     $0026
M0027   EQU     $0027
M0028   EQU     $0028
M0029   EQU     $0029
M002B   EQU     $002B
M002C   EQU     $002C
M002D   EQU     $002D
M00FE   EQU     $00FE
M3030   EQU     $3030
M3537   EQU     $3537

;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $2000

                FCC     '0300'                   ; 2000: 30 33 30 30    ; Version
DIRSTART        CLI                              ; 2004: 0E             ; 
                CLRA                             ; 2005: 4F             ; |
                STAA    M0024                    ; 2006: 97 24          ; |
                STAA    M0025                    ; 2008: 97 25          ; |
                STAA    M0026                    ; 200A: 97 26          ; | Init some Variables
                STAA    ENTRYNUM                 ; 200C: 97 23          ; |
                INCA                             ; 200E: 4C             ; |
                STAA    M002D                    ; 200F: 97 2D          ; |
                LDAA    #CR                      ; 2011: 86 0D          ; 
                STAA    M24AA                    ; 2013: B7 24 AA       ; 
                STAA    M24C0                    ; 2016: B7 24 C0       ; 
                CLR     M2476                    ; 2019: 7F 24 76       ; 
                LDAA    #'0'                     ; 201C: 86 30          ; Use drive 0 as default
                STAA    FNAMREG                  ; 201E: B7 24 65       ; Store it to Filenameregion (11 bytes long!)
                LDX     #M2466                   ; 2021: CE 24 66       ; Clear Filenameregion
                LDAB    #$0A                     ; 2024: C6 0A          ; 10 Bytes left
                SCALL   STCHB1                                          ; STORE BLANKS
                LDX     CBUFPs                   ; 2028: DE FE          ; Command Buffer Scan Ptr.
                STX     INPBUF                   ; 202A: FF 25 E4       ; 
                LDX     #FNAMREG                 ; 202D: CE 24 65       ; |
                STX     FNAMPTR                  ; 2030: FF 25 E6       ; Build Filanamepacket for PFNAM
                LDX     #INPBUF                  ; 2033: CE 25 E4       ; |
                SCALL   PFNAM1                                          ; PROCESS FILE NAME
                STAB    PFNMSTAT                 ; 2038: D7 20          ; Save status of SCALL
                CLRB                             ; 203A: 5F             ; Clear for Flags
                LDX     INPBUF                   ; 203B: FE 25 E4       ; 
NOOPT           LDAA    ,X                       ; 203E: A6 00          ; 
                INX                              ; 2040: 08             ; 
                CMPA    #CR                      ; 2041: 81 0D          ; 
                BEQ     ENTRYDONE                ; 2043: 27 40          ; 
                CMPA    #OPTDLM                  ; 2045: 81 3B          ; Compare with ';'
                BNE     NOOPT                    ; 2047: 26 F5          ; 
NXTOPT          LDAA    ,X                       ; 2049: A6 00          ; We have Options
                INX                              ; 204B: 08             ; 
                CMPA    #CR                      ; 204C: 81 0D          ; 
                BEQ     ENTRYDONE                ; 204E: 27 35          ; 
                CMPA    #'E'                     ; 2050: 81 45          ; Displ. entire dir entry
                BNE     NOT_E                    ; 2052: 26 09          ; or not
                ORAB    #$01                     ; 2054: CA 01          ; Flags
                LDAA    #SPACE                   ; 2056: 86 20          ; 
                STAA    M24AA                    ; 2058: B7 24 AA       ; 
                BRA     NXTOPT                   ; 205B: 20 EC          ; 
;------------------------------------------------
NOT_E           CMPA    #'A'                     ; 205D: 81 41          ; Disp. allocation info
                BNE     NOT_A                    ; 205F: 26 0C          ; or not
                ORAB    #$02                     ; 2061: CA 02          ; Flags
                LDAA    #SPACE                   ; 2063: 86 20          ; 
                STAA    M24AA                    ; 2065: B7 24 AA       ; 
                STAA    M24C0                    ; 2068: B7 24 C0       ; 
                BRA     NXTOPT                   ; 206B: 20 DC          ; 
;------------------------------------------------
NOT_A           CMPA    #'L'                     ; 206D: 81 4C          ; 
                BNE     NOT_L                    ; 206F: 26 04          ; 
                ORAB    #$04                     ; 2071: CA 04          ; Flags
                BRA     NXTOPT                   ; 2073: 20 D4          ; 
;------------------------------------------------
NOT_L           CMPA    #'S'                     ; 2075: 81 53          ; include system files
                BNE     NOT_S                    ; 2077: 26 04          ; or not
                ORAB    #$08                     ; 2079: CA 08          ; Flags
                BRA     NXTOPT                   ; 207B: 20 CC          ; 
;------------------------------------------------
NOT_S           CMPA    #SPACE                   ; 207D: 81 20          ; 
                BEQ     NXTOPT                   ; 207F: 27 C8          ; 
                LDAB    #$0B                     ; 2081: C6 0B          ; Set Error '$0B' (COMMAND SYNTAX ERROR)
                BRA     ERR01                    ; 2083: 20 12          ; no options after ';'
;------------------------------------------------
ENTRYDONE       STAB    OPTIONS                  ; 2085: D7 21          ; Store options
                LDAB    FNAMREG                  ; 2087: F6 24 65       ; Here is the Drive# (as ASCII)
                STAB    HEADER1                  ; 208A: F7 24 86       ; Store Drivenr. into Header
                ANDB    #$0F                     ; 208D: C4 0F          ; convert from ASCII
                BEQ     Z209A                    ; 208F: 27 09          ; Drive 0 ?
                CMPB    #$03                     ; 2091: C1 03          ; 
                BLE     Z209A                    ; 2093: 2F 05          ; check for drive <= 3
                LDAB    #$04                     ; 2095: C6 04          ; Set Error '04' (INVALID LOGICAL UNIT NUMBER)
ERR01           JMP     HNDLERR                  ; 2097: 7E 23 35       ; 
;------------------------------------------------
Z209A           STAB    FNAMREG                  ; 209A: F7 24 65       ; Here is the Drive# (as Number)
                LDAA    PFNMSTAT                 ; 209D: 96 20          ; Get status of SCALL PFNAM
                BITA    #$04                     ; 209F: 85 04          ; Bit 2 (Device specification found) ?
                BEQ     Z20A7                    ; 20A1: 27 04          ; yes
                LDAB    #$05                     ; 20A3: C6 05          ; Set Error '05' (NAME REQUIRED)
                BRA     ERR01                    ; 20A5: 20 F0          ; 
;------------------------------------------------
Z20A7           LDX     #$0000                   ; 20A7: CE 00 00       ; | Build 5 Byte I/O Parameter Packet
                STX     M25D2                    ; 20AA: FF 25 D2       ; | Sector # to read
                LDX     #BUF128_1                ; 20AD: CE 24 D1       ; |
                STX     M25D4                    ; 20B0: FF 25 D4       ; | Address of 128 byte buffer
                PSHB                             ; 20B3: 37             ; Push Drivenr.
                STAB    CURDRV                   ; 20B4: D7 00          ; 
                JSR     RESTOR      ;EXORDISK    ; 20B6: BD E8 75       ; 
                PULB                             ; 20B9: 33             ; Pull Drivenr.
                LDX     #IOPCKT                  ; 20BA: CE 25 D1       ; 5 Byte I/O Parameter Packet
                SCALL   DREAD1                                          ; EROM DISK READ
                BCC     Z20C6                    ; 20BF: 24 05          ; 
                LDAB    #$01                     ; 20C1: C6 01          ; Set Error 1 (COMMAND SYNTAX ERROR)
                JMP     HNDLERR                  ; 20C3: 7E 23 35       ; 
;------------------------------------------------
Z20C6           LDX     #BUF128_1                ; 20C6: CE 24 D1       ; Build Packet (Here is the first Sector)
                STX     BUFPTR01                 ; 20C9: FF 25 D6       ; Source Address
                LDX     #DSKID                   ; 20CC: CE 24 96       ; |
                STX     M25D8                    ; 20CF: FF 25 D8       ; Destination Address
                LDX     #BUFPTR01                ; 20D2: CE 25 D6       ; 4 byte parameter packet
                LDAB    #$08                     ; 20D5: C6 08          ; Number of bytes to move (first 8 Byte on Disk = ID)
                SCALL   MOVE1                                           ; MOVE A STRING
                LDX     #HEADER0                 ; 20D9: CE 24 7E       ; |
                JSR     OUTPUTTXT                ; 20DC: BD 24 31       ; Output Header
                LDAB    #SPACE                   ; 20DF: C6 20          ; 
                LDX     #FNAMREG                 ; 20E1: CE 24 65       ; 
                LDAA    $01,X                    ; 20E4: A6 01          ; Get Start of Filename
                CBA                              ; 20E6: 11             ; is it SPACE
                BNE     VALIDFN                  ; 20E7: 26 08          ; no
                LDAA    $09,X                    ; 20E9: A6 09          ; check end of string
                CBA                              ; 20EB: 11             ; 
                BEQ     CHKBRKKY                 ; 20EC: 27 13          ; only space, check Break
ALLOK           JMP     FNAMGIVEN                ; 20EE: 7E 22 B1       ; Filename given in command
;------------------------------------------------
VALIDFN         LDAB    PFNMSTAT                 ; 20F1: D6 20          ; (PFNAM: pg. 381)
                BITB    #$01                     ; 20F3: C5 01          ; family indicator in filename found ?
                BNE     ALLOK                    ; 20F5: 26 F7          ; 
                BITB    #$02                     ; 20F7: C5 02          ; family indicator in suffix found ?
                BNE     ALLOK                    ; 20F9: 26 F3          ; 
                LDAB    #$02                     ; 20FB: C6 02          ; filename given
                STAB    DIRSMFLAG                ; 20FD: D7 22          ; 
                BRA     Z2105                    ; 20FF: 20 04          ; 
;------------------------------------------------
CHKBRKKY        LDAB    #$01                     ; 2101: C6 01          ; Bit 0 - Search for Next Direntry
                STAB    DIRSMFLAG                ; 2103: D7 22          ; 
Z2105           SCALL   CKBRK1                                          ; CHECK CONSOLE FOR BREAK KEY
                BCC     NOBRK                    ; 2107: 24 03          ; 
                JMP     BRKDET                   ; 2109: 7E 23 A2       ; 
;------------------------------------------------
NOBRK           LDAB    DIRSMFLAG                ; 210C: D6 22          ; 
                LDX     #FNAMREG                 ; 210E: CE 24 65       ; 
                SCALL   DIRSM1                                          ; DIRECTORY SEARCH AND MODIFY (pg. 360)
                BCC     Z2118                    ; 2113: 24 03          ; no Errors, no end, no deleted entry
                JMP     DIRSMERR                 ; 2115: 7E 23 1D       ; 
;------------------------------------------------
Z2118           LDAA    ENTRYNUM                 ; 2118: 96 23          ; 
                BEQ     Z2121                    ; 211A: 27 05          ; 
                JSR     Z23D1                    ; 211C: BD 23 D1       ; 
                BNE     Z2105                    ; 211F: 26 E4          ; 
Z2121           LDAA    DIRSMFLAG                ; 2121: 96 22          ; 
                DECA                             ; 2123: 4A             ; 
                BNE     Z2133                    ; 2124: 26 0D          ; 
                LDAA    OPTIONS                  ; 2126: 96 21          ; 
                BITA    #$08                     ; 2128: 85 08          ; include system files ?
                BNE     Z2133                    ; 212A: 26 07          ; 
                LDAA    M2472                    ; 212C: B6 24 72       ; 
                BITA    #$20                     ; 212F: 85 20          ; 
                BNE     Z2105                    ; 2131: 26 D2          ; 
Z2133           INC     M0026                    ; 2133: 7C 00 26       ; 
                JSR     Z23B2                    ; 2136: BD 23 B2       ; 
                LDAA    OPTIONS                  ; 2139: 96 21          ; 
                ANDA    #$03                     ; 213B: 84 03          ; 
                BNE     Z2142                    ; 213D: 26 03          ; 
                JMP     Z229F                    ; 213F: 7E 22 9F       ; 
;------------------------------------------------
Z2142           JSR     Z2401                    ; 2142: BD 24 01       ; 
                LDX     M2470                    ; 2145: FE 24 70       ; 
                STX     M25DA                    ; 2148: FF 25 DA       ; 
                LDX     #M24B7                   ; 214B: CE 24 B7       ; 
                STX     M25DC                    ; 214E: FF 25 DC       ; 
                LDAB    #$04                     ; 2151: C6 04          ; 
                LDX     #M25DA                   ; 2153: CE 25 DA       ; 
                JSR     Z26C3                    ; 2156: BD 26 C3       ; 
                CLRA                             ; 2159: 4F             ; 
                LDAB    M2476                    ; 215A: F6 24 76       ; 
                STAA    M0027                    ; 215D: 97 27          ; 
                STAB    M0028                    ; 215F: D7 28          ; 
                LDX     M0027                    ; 2161: DE 27          ; 
                STX     M25DA                    ; 2163: FF 25 DA       ; 
                LDX     #M24BF                   ; 2166: CE 24 BF       ; 
                STX     M25DC                    ; 2169: FF 25 DC       ; 
                LDAB    #$02                     ; 216C: C6 02          ; 
                LDX     #M25DA                   ; 216E: CE 25 DA       ; 
                JSR     Z26C3                    ; 2171: BD 26 C3       ; 
                LDAB    FNAMREG                  ; 2174: F6 24 65       ; Here is the Drive#
                LDX     M2470                    ; 2177: FE 24 70       ; 
                STX     M25D2                    ; 217A: FF 25 D2       ; 
                LDX     #BUF128_2                ; 217D: CE 25 51       ; 
                STX     M25D4                    ; 2180: FF 25 D4       ; 
                LDX     #IOPCKT                  ; 2183: CE 25 D1       ; 
                SCALL   DREAD1                                          ; EROM DISK READ
                BCC     Z218F                    ; 2188: 24 05          ; 
                LDAB    #$01                     ; 218A: C6 01          ; Set Error 1 (COMMAND SYNTAX ERROR)
                JMP     HNDLERR                  ; 218C: 7E 23 35       ; 
;------------------------------------------------
Z218F           LDX     #CURDRV                  ; 218F: CE 00 00       ; 
                STX     M24B9                    ; 2192: FF 24 B9       ; 
                LDX     #BUF128_2                ; 2195: CE 25 51       ; 
                STX     M0027                    ; 2198: DF 27          ; 
                LDAA    ,X                       ; 219A: A6 00          ; 
                BMI     Z21BC                    ; 219C: 2B 1E          ; 
Z219E           ANDA    #$7C                     ; 219E: 84 7C          ; 
                ADDA    #$04                     ; 21A0: 8B 04          ; 
                LDX     #M24B9                   ; 21A2: CE 24 B9       ; 
                SCALL   ADDAM1                                          ; INCREMENT MEMORY (DOUBLE BYTE) BY A
                LDX     M0027                    ; 21A7: DE 27          ; 
                INX                              ; 21A9: 08             ; 
                INX                              ; 21AA: 08             ; 
                STX     M0027                    ; 21AB: DF 27          ; 
                LDAA    ,X                       ; 21AD: A6 00          ; 
                BPL     Z219E                    ; 21AF: 2A ED          ; 
                LDX     M24B9                    ; 21B1: FE 24 B9       ; 
                LDAA    M0025                    ; 21B4: 96 25          ; 
                LDAB    M0024                    ; 21B6: D6 24          ; 
                SCALL   ADDAX1                                          ; ADD B,A TO X
                STX     M0024                    ; 21BA: DF 24          ; 
Z21BC           LDX     M24B9                    ; 21BC: FE 24 B9       ; 
                STX     M25DA                    ; 21BF: FF 25 DA       ; 
                LDX     #M24BC                   ; 21C2: CE 24 BC       ; 
                STX     M25DC                    ; 21C5: FF 25 DC       ; 
                LDAB    #$04                     ; 21C8: C6 04          ; 
                LDX     #M25DA                   ; 21CA: CE 25 DA       ; 
                JSR     Z26C3                    ; 21CD: BD 26 C3       ; 
                LDAA    OPTIONS                  ; 21D0: 96 21          ; 
                BITA    #$02                     ; 21D2: 85 02          ; 
                BNE     Z21D9                    ; 21D4: 26 03          ; 
                JMP     Z229F                    ; 21D6: 7E 22 9F       ; 
;------------------------------------------------
Z21D9           LDAA    BUF128_2                 ; 21D9: B6 25 51       ; 
                BPL     Z21FA                    ; 21DC: 2A 1C          ; 
                LDAA    #$40                     ; 21DE: 86 40          ; 
                LDAB    #$82                     ; 21E0: C6 82          ; 
                SCALL   EWORD1                                          ; SET ERROR STATUS WORD FOR CHAIN
                LDX     #M262E                   ; 21E4: CE 26 2E       ; 
                STX     BUFPTR01                 ; 21E7: FF 25 D6       ; 
                LDX     #M24C3                   ; 21EA: CE 24 C3       ; 
                STX     M25D8                    ; 21ED: FF 25 D8       ; 
                LDAB    #$0B                     ; 21F0: C6 0B          ; 
                LDX     #BUFPTR01                ; 21F2: CE 25 D6       ; 
                SCALL   MOVE1                                           ; MOVE A STRING
                JMP     Z229F                    ; 21F7: 7E 22 9F       ; 
;------------------------------------------------
Z21FA           LDX     #M3030                   ; 21FA: CE 30 30       ; 
                STX     M24C3                    ; 21FD: FF 24 C3       ; 
                LDAB    #$09                     ; 2200: C6 09          ; 
                LDX     #M24C5                   ; 2202: CE 24 C5       ; 
                SCALL   STCHB1                                          ; STORE BLANKS
                LDX     #BUF128_2                ; 2207: CE 25 51       ; 
                STX     M0029                    ; 220A: DF 29          ; 
Z220C           LDAA    $01,X                    ; 220C: A6 01          ; 
                LDAB    ,X                       ; 220E: E6 00          ; 
                ANDB    #$03                     ; 2210: C4 03          ; 
                STAA    M0028                    ; 2212: 97 28          ; 
                STAB    M0027                    ; 2214: D7 27          ; 
                LDX     #M0027                   ; 2216: CE 00 27       ; 
                LDAA    #$02                     ; 2219: 86 02          ; 
                SCALL   MMA1                                            ; MULTIPLY (SHIFT LEFT) MEMORY BY A
                LDX     M0027                    ; 221D: DE 27          ; 
                STX     M25DA                    ; 221F: FF 25 DA       ; 
                LDX     #M24C9                   ; 2222: CE 24 C9       ; 
                STX     M25DC                    ; 2225: FF 25 DC       ; 
                LDAB    #$04                     ; 2228: C6 04          ; 
                LDX     #M25DA                   ; 222A: CE 25 DA       ; 
                JSR     Z26C3                    ; 222D: BD 26 C3       ; 
                LDX     M0029                    ; 2230: DE 29          ; 
                LDAA    ,X                       ; 2232: A6 00          ; 
                ANDA    #$FC                     ; 2234: 84 FC          ; 
                ADDA    #$04                     ; 2236: 8B 04          ; 
                STAA    M0028                    ; 2238: 97 28          ; 
                CLR     M0027                    ; 223A: 7F 00 27       ; 
                LDX     M0027                    ; 223D: DE 27          ; 
                STX     M25DA                    ; 223F: FF 25 DA       ; 
                LDX     #M24CD                   ; 2242: CE 24 CD       ; 
                STX     M25DC                    ; 2245: FF 25 DC       ; 
                LDAB    #$03                     ; 2248: C6 03          ; 
                LDX     #M25DA                   ; 224A: CE 25 DA       ; 
                JSR     Z26C3                    ; 224D: BD 26 C3       ; 
                LDX     #M249F                   ; 2250: CE 24 9F       ; 
                JSR     OUTPUTTXT                ; 2253: BD 24 31       ; 
                LDAB    M249F                    ; 2256: F6 24 9F       ; 
                CMPB    #$20                     ; 2259: C1 20          ; 
                BEQ     Z2265                    ; 225B: 27 08          ; 
                LDX     #M249F                   ; 225D: CE 24 9F       ; 
                LDAB    M24D0                    ; 2260: F6 24 D0       ; 
                SCALL   STCHB1                                          ; STORE BLANKS
Z2265           LDX     #M24C4                   ; 2265: CE 24 C4       ; 
                LDAB    #$02                     ; 2268: C6 02          ; 
                JSR     Z27A7                    ; 226A: BD 27 A7       ; 
                LDX     M24C3                    ; 226D: FE 24 C3       ; 
                CPX     #M3537                   ; 2270: 8C 35 37       ; 
                BNE     Z2289                    ; 2273: 26 14          ; 
                LDX     M0029                    ; 2275: DE 29          ; 
                LDAA    $02,X                    ; 2277: A6 02          ; 
                BMI     Z22A5                    ; 2279: 2B 2A          ; 
                LDAA    #$40                     ; 227B: 86 40          ; 
                LDAB    #$81                     ; 227D: C6 81          ; 
                SCALL   EWORD1                                          ; SET ERROR STATUS WORD FOR CHAIN
                LDX     #NOTRMFND                ; 2281: CE 26 9E       ; Msg. No Terminator fnd in RIB
                JSR     OUTPUTTXT                ; 2284: BD 24 31       ; 
                BRA     Z22A5                    ; 2287: 20 1C          ; 
;------------------------------------------------
Z2289           LDX     M0029                    ; 2289: DE 29          ; 
                INX                              ; 228B: 08             ; 
                INX                              ; 228C: 08             ; 
                STX     M0029                    ; 228D: DF 29          ; 
                LDAA    $01,X                    ; 228F: A6 01          ; 
                LDAB    ,X                       ; 2291: E6 00          ; 
                BMI     Z22A5                    ; 2293: 2B 10          ; 
                SCALL   CKBRK1                                          ; CHECK CONSOLE FOR BREAK KEY
                BCC     Z229C                    ; 2297: 24 03          ; 
                JMP     BRKDET                   ; 2299: 7E 23 A2       ; 
;------------------------------------------------
Z229C           JMP     Z220C                    ; 229C: 7E 22 0C       ; 
;------------------------------------------------
Z229F           LDX     #M249F                   ; 229F: CE 24 9F       ; 
                JSR     OUTPUTTXT                ; 22A2: BD 24 31       ; 
Z22A5           LDAA    DIRSMFLAG                ; 22A5: 96 22          ; 
                BITA    #$02                     ; 22A7: 85 02          ; 
                BEQ     Z22AE                    ; 22A9: 27 03          ; 
                JMP     Z2339                    ; 22AB: 7E 23 39       ; 
;------------------------------------------------
Z22AE           JMP     Z2105                    ; 22AE: 7E 21 05       ; 
;------------------------------------------------
FNAMGIVEN       CLRB                             ; 22B1: 5F             ; 
                STAB    M002B                    ; 22B2: D7 2B          ; 
                STAB    M002C                    ; 22B4: D7 2C          ; 
                LDAB    #SPACE                   ; 22B6: C6 20          ; 
                LDX     #M2466                   ; 22B8: CE 24 66       ; |
                LDAA    ,X                       ; 22BB: A6 00          ; Get data from Filenameregion (without drive#)
                CBA                              ; 22BD: 11             ; is it space ?
                BNE     Z22C5                    ; 22BE: 26 05          ; no
                DEC     M002B                    ; 22C0: 7A 00 2B       ; 
                BRA     Z22DF                    ; 22C3: 20 1A          ; 
;------------------------------------------------
Z22C5           LDAA    PFNMSTAT                 ; 22C5: 96 20          ; 
                BITA    #$01                     ; 22C7: 85 01          ; 
                BNE     Z22D1                    ; 22C9: 26 06          ; 
                LDAA    #$08                     ; 22CB: 86 08          ; 
                STAA    M002B                    ; 22CD: 97 2B          ; 
                BRA     Z22DF                    ; 22CF: 20 0E          ; 
;------------------------------------------------
Z22D1           INC     M002B                    ; 22D1: 7C 00 2B       ; 
                INX                              ; 22D4: 08             ; 
                CPX     #M246E                   ; 22D5: 8C 24 6E       ; 
                BEQ     Z22E2                    ; 22D8: 27 08          ; 
                LDAA    ,X                       ; 22DA: A6 00          ; 
                CBA                              ; 22DC: 11             ; 
                BNE     Z22D1                    ; 22DD: 26 F2          ; 
Z22DF           LDX     #M246E                   ; 22DF: CE 24 6E       ; 
Z22E2           LDAA    ,X                       ; 22E2: A6 00          ; 
                CBA                              ; 22E4: 11             ; 
                BNE     Z22EC                    ; 22E5: 26 05          ; 
                DEC     M002C                    ; 22E7: 7A 00 2C       ; 
                BRA     Z2304                    ; 22EA: 20 18          ; 
;------------------------------------------------
Z22EC           LDAA    PFNMSTAT                 ; 22EC: 96 20          ; 
                BITA    #$02                     ; 22EE: 85 02          ; 
                BNE     Z22F6                    ; 22F0: 26 04          ; 
                LDAA    #$02                     ; 22F2: 86 02          ; 
                BRA     Z2304                    ; 22F4: 20 0E          ; 
;------------------------------------------------
Z22F6           INC     M002C                    ; 22F6: 7C 00 2C       ; 
                INX                              ; 22F9: 08             ; 
                CPX     #M2470                   ; 22FA: 8C 24 70       ; 
                BEQ     Z2304                    ; 22FD: 27 05          ; 
                LDAA    ,X                       ; 22FF: A6 00          ; 
                CBA                              ; 2301: 11             ; 
                BNE     Z22F6                    ; 2302: 26 F2          ; 
Z2304           INC     ENTRYNUM                 ; 2304: 7C 00 23       ; 
                LDX     #M2466                   ; 2307: CE 24 66       ; 
                STX     BUFPTR01                 ; 230A: FF 25 D6       ; 
                LDX     #M25E8                   ; 230D: CE 25 E8       ; 
                STX     M25D8                    ; 2310: FF 25 D8       ; 
                LDX     #BUFPTR01                ; 2313: CE 25 D6       ; 
                LDAB    #$0A                     ; 2316: C6 0A          ; 
                SCALL   MOVE1                                           ; 
                JMP     CHKBRKKY                 ; 231A: 7E 21 01       ; 
;------------------------------------------------
DIRSMERR        CMPB    #$01                     ; 231D: C1 01          ; Direntry found ?
                BNE     Z232F                    ; 231F: 26 0E          ; yes
Z2321           LDAB    #$80                     ; 2321: C6 80          ; no
                LDAA    #$40                     ; 2323: 86 40          ; 
                SCALL   EWORD1                                          ; SET ERROR STATUS WORD FOR CHAIN
                LDX     #NODIRFND                ; 2327: CE 26 39       ; Msg.: No Directory found
                JSR     OUTPUTTXT                ; 232A: BD 24 31       ; 
                BRA     BRKDET                   ; 232D: 20 73          ; 
;------------------------------------------------
Z232F           CMPB    #$03                     ; 232F: C1 03          ; DFT ?
                BEQ     Z2339                    ; 2331: 27 06          ; yes
                LDAB    #$0C                     ; 2333: C6 0C          ; Error (INTERNAL SYSTEM ERROR AT ...)
HNDLERR         SCALL   MDERR1                                          ; MDOS ERROR MESSAGE HANDLER
                BRA     BRKDET                   ; 2337: 20 69          ; 
;------------------------------------------------
Z2339           LDAA    M0026                    ; 2339: 96 26          ; 
                BEQ     Z2321                    ; 233B: 27 E4          ; 
                LDAA    OPTIONS                  ; 233D: 96 21          ; 
                ANDA    #$03                     ; 233F: 84 03          ; 
                BEQ     Z236F                    ; 2341: 27 2C          ; 
                LDX     M0024                    ; 2343: DE 24          ; 
                STX     M25DA                    ; 2345: FF 25 DA       ; 
                LDX     #M266F                   ; 2348: CE 26 6F       ; 
                STX     M25DC                    ; 234B: FF 25 DC       ; 
                LDAB    #$04                     ; 234E: C6 04          ; 
                LDX     #M25DA                   ; 2350: CE 25 DA       ; 
                JSR     Z2704                    ; 2353: BD 27 04       ; 
                LDX     M0024                    ; 2356: DE 24          ; 
                STX     M25DA                    ; 2358: FF 25 DA       ; 
                LDX     #M2674                   ; 235B: CE 26 74       ; 
                STX     M25DC                    ; 235E: FF 25 DC       ; 
                LDAB    #$03                     ; 2361: C6 03          ; 
                LDX     #M25DA                   ; 2363: CE 25 DA       ; 
                JSR     Z26C3                    ; 2366: BD 26 C3       ; 
                LDX     #TTLNROFSEC              ; 2369: CE 26 52       ; Msg.: Total Nr. of Sectors
                JSR     OUTPUTTXT                ; 236C: BD 24 31       ; 
Z236F           LDAA    M0026                    ; 236F: 96 26          ; 
                STAA    M0028                    ; 2371: 97 28          ; 
                CLR     M0027                    ; 2373: 7F 00 27       ; 
                LDX     M0027                    ; 2376: DE 27          ; 
                STX     M25DA                    ; 2378: FF 25 DA       ; 
                LDX     #M2698                   ; 237B: CE 26 98       ; 
                STX     M25DC                    ; 237E: FF 25 DC       ; 
                LDAB    #$03                     ; 2381: C6 03          ; 
                LDX     #M25DA                   ; 2383: CE 25 DA       ; 
                JSR     Z2704                    ; 2386: BD 27 04       ; 
                LDX     M0027                    ; 2389: DE 27          ; 
                STX     M25DA                    ; 238B: FF 25 DA       ; 
                LDX     #M269C                   ; 238E: CE 26 9C       ; 
                STX     M25DC                    ; 2391: FF 25 DC       ; 
                LDAB    #$02                     ; 2394: C6 02          ; 
                LDX     #M25DA                   ; 2396: CE 25 DA       ; 
                JSR     Z26C3                    ; 2399: BD 26 C3       ; 
                LDX     #M2676                   ; 239C: CE 26 76       ; 
                JSR     OUTPUTTXT                ; 239F: BD 24 31       ; 
BRKDET          LDAA    OPTIONS                  ; 23A2: 96 21          ; 
                BITA    #$04                     ; 23A4: 85 04          ; Output to Printer ?
                BEQ     Z23B0                    ; 23A6: 27 08          ; 
                LDAB    M002D                    ; 23A8: D6 2D          ; 
                DECB                             ; 23AA: 5A             ; 
                BEQ     Z23B0                    ; 23AB: 27 03          ; 
                JSR     Z244A                    ; 23AD: BD 24 4A       ; 
Z23B0           SCALL   MDENT1                                          ; 
Z23B2           LDX     #M2466                   ; 23B2: CE 24 66       ; Filenameregion (without drive#)
                STX     BUFPTR01                 ; 23B5: FF 25 D6       ; 
                LDX     #M249F                   ; 23B8: CE 24 9F       ; 
                STX     M25D8                    ; 23BB: FF 25 D8       ; 
                LDX     #BUFPTR01                ; 23BE: CE 25 D6       ; 
                LDAB    #$08                     ; 23C1: C6 08          ; 
                SCALL   MOVE1                                           ; MOVE A STRING
                LDAA    #$2E                     ; 23C5: 86 2E          ; 
                STAA    M24A7                    ; 23C7: B7 24 A7       ; 
                LDX     M246E                    ; 23CA: FE 24 6E       ; 
                STX     M24A8                    ; 23CD: FF 24 A8       ; 
                RTS                              ; 23D0: 39             ; 
;------------------------------------------------
Z23D1           LDAB    M002B                    ; 23D1: D6 2B          ; 
                BMI     Z23E8                    ; 23D3: 2B 13          ; 
                LDX     #M2466                   ; 23D5: CE 24 66       ; Filenameregion (without drive#)
                STX     BUFPTR01                 ; 23D8: FF 25 D6       ; 
                LDX     #M25E8                   ; 23DB: CE 25 E8       ; 
                STX     M25D8                    ; 23DE: FF 25 D8       ; 
                LDX     #BUFPTR01                ; 23E1: CE 25 D6       ; 
                SCALL   CMPAR1                                          ; 
                BNE     Z2400                    ; 23E6: 26 18          ; 
Z23E8           LDAA    M002C                    ; 23E8: 96 2C          ; 
                BPL     Z23EF                    ; 23EA: 2A 03          ; 
                CLRA                             ; 23EC: 4F             ; 
                BRA     Z2400                    ; 23ED: 20 11          ; 
;------------------------------------------------
Z23EF           DECA                             ; 23EF: 4A             ; 
                BEQ     Z23FA                    ; 23F0: 27 08          ; 
                LDX     M246E                    ; 23F2: FE 24 6E       ; 
                CPX     M25F0                    ; 23F5: BC 25 F0       ; 
                BRA     Z2400                    ; 23F8: 20 06          ; 
;------------------------------------------------
Z23FA           LDAA    M246E                    ; 23FA: B6 24 6E       ; 
                CMPA    M25F0                    ; 23FD: B1 25 F0       ; 
Z2400           RTS                              ; 2400: 39             ; 
;------------------------------------------------
Z2401           LDX     #M25DE                   ; 2401: CE 25 DE       ; 
                STX     BUFPTR01                 ; 2404: FF 25 D6       ; 
                LDX     #M24AD                   ; 2407: CE 24 AD       ; 
                STX     M25D8                    ; 240A: FF 25 D8       ; 
                LDX     #BUFPTR01                ; 240D: CE 25 D6       ; 
                LDAB    #$06                     ; 2410: C6 06          ; 
                SCALL   MOVE1                                           ; 
                LDAB    #$2E                     ; 2414: C6 2E          ; 
                LDAA    M2472                    ; 2416: B6 24 72       ; 
                LDX     #M24AD                   ; 2419: CE 24 AD       ; 
Z241C           ASLA                             ; 241C: 48             ; 
                BCS     Z2421                    ; 241D: 25 02          ; 
                STAB    ,X                       ; 241F: E7 00          ; 
Z2421           INX                              ; 2421: 08             ; 
                CPX     #M24B2                   ; 2422: 8C 24 B2       ; 
                BNE     Z241C                    ; 2425: 26 F5          ; 
                LDAA    M2472                    ; 2427: B6 24 72       ; 
                ANDA    #$07                     ; 242A: 84 07          ; 
                ORAA    ,X                       ; 242C: AA 00          ; 
                STAA    ,X                       ; 242E: A7 00          ; 
                RTS                              ; 2430: 39             ; 
;------------------------------------------------
OUTPUTTXT       LDAA    OPTIONS                  ; 2431: 96 21          ; Get Options
                BITA    #$04                     ; 2433: 85 04          ; Output to Printer ?
                BNE     Z243A                    ; 2435: 26 03          ; yes
                SCALL   DSPLY1                                          ; no, display Text from X
                RTS                              ; 2439: 39             ; 
;------------------------------------------------
Z243A           DEC     M002D                    ; 243A: 7A 00 2D       ; 
                BNE     Z2447                    ; 243D: 26 08          ; 
                LDAA    #$3C                     ; 243F: 86 3C          ; 
                STAA    M002D                    ; 2441: 97 2D          ; 
                LDAB    #$06                     ; 2443: C6 06          ; 
                BSR     Z244A                    ; 2445: 8D 03          ; 
Z2447           SCALL   PRINT1                                          ; 
                RTS                              ; 2449: 39             ; 
;------------------------------------------------
Z244A           SCALL   PSHX1                                           ; 
                LDX     #M25F2                   ; 244C: CE 25 F2       ; 
                LDAA    #CR                      ; 244F: 86 0D          ; 
Z2451           DECB                             ; 2451: 5A             ; 
                BEQ     Z2459                    ; 2452: 27 05          ; 
                STAA    ,X                       ; 2454: A7 00          ; 
                INX                              ; 2456: 08             ; 
                BRA     Z2451                    ; 2457: 20 F8          ; 
;------------------------------------------------
Z2459           LDAA    #$04                     ; 2459: 86 04          ; 
                STAA    ,X                       ; 245B: A7 00          ; 
                LDX     #M25F2                   ; 245D: CE 25 F2       ; 
                SCALL   PRINX1                                          ; 
                SCALL   PULX1                                           ; 
                RTS                              ; 2464: 39             ; 
;------------------------------------------------
FNAMREG         FCB     '0'                      ; 2465: 30             
M2466           FCC     '        '               ; 2466: 20 20 20 20 20 20 20 20 
M246E           FCC     '  '                     ; 246E: 20 20          
M2470           FCB     $00,$00                  ; 2470: 00 00          
M2472           FCB     $00,$00,$00,$00          ; 2472: 00 00 00 00    
M2476           FCB     $00,$00,$00,$00          ; 2476: 00 00 00 00    
                FCB     '$'                      ; 247A: 24             
                FCB     $d1                      ; 247B: D1             
                FCC     '%P'                     ; 247C: 25 50          
HEADER0         FCC     'DRIVE : '
HEADER1         FCC     '    DISK I.D. : '
DSKID           FCC     '        '
                FCB     CR                       ; 249E: 0D             
M249F           FCC     '        '
M24A7           FCB     '.'                      ; 24A7: 2E             
M24A8           FCC     '  '                     ; 24A8: 20 20          
M24AA           FCB     CR                       ; 24AA: 0D             
                FCC     '  '                     ; 24AB: 20 20          
M24AD           FCC     '     '                  ; 24AD: 20 20 20 20 20 
M24B2           FCC     '     '                  ; 24B2: 20 20 20 20 20 
M24B7           FCC     '  '                     ; 24B7: 20 20          
M24B9           FCC     '   '                    ; 24B9: 20 20 20       
M24BC           FCC     '   '                    ; 24BC: 20 20 20       
M24BF           FCB     ' '                      ; 24BF: 20             
M24C0           FCB     CR                       ; 24C0: 0D             
                FCC     '  '                     ; 24C1: 20 20          
M24C3           FCB     ' '                      ; 24C3: 20             
M24C4           FCB     ' '                      ; 24C4: 20             
M24C5           FCC     '    '                   ; 24C5: 20 20 20 20    
M24C9           FCC     '    '                   ; 24C9: 20 20 20 20    
M24CD           FCB     ' '                      ; 24CD: 20             
                FCB     CR                       ; 24CE: 0D             
                FCB     $00                      ; 24CF: 00             
M24D0           FCB     $21                      ; 24D0: 21             
BUF128_1        FCB     $00,$00,$00,$00,$00,$00  ; 24D1: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 24D7: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 24DD: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 24E3: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 24E9: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 24EF: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 24F5: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 24FB: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2501: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2507: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 250D: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2513: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2519: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 251F: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2525: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 252B: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2531: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2537: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 253D: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2543: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2549: 00 00 00 00 00 00 
                FCB     $00,$00                  ; 254F: 00 00          
BUF128_2        FCB     $00,$00,$00,$00,$00,$00  ; 2551: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2557: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 255D: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2563: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2569: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 256F: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2575: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 257B: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2581: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2587: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 258D: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2593: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2599: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 259F: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 25A5: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 25AB: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 25B1: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 25B7: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 25BD: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 25C3: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 25C9: 00 00 00 00 00 00 
                FCB     $00,$00                  ; 25CF: 00 00          
IOPCKT          FCB     $00                      ; 25D1: 00             
M25D2           FDB     $0000                    ; 25D2: 00 00          
M25D4           FDB     $0000                    ; 25D4: 00 00          
BUFPTR01        FDB     $0000                    ; 25D6: 00 00          
M25D8           FCB     $00,$00                  ; 25D8: 00 00          
M25DA           FCB     $00,$00                  ; 25DA: 00 00          
M25DC           FCB     $00,$00                  ; 25DC: 00 00          
M25DE           FCC     'WDSCN0'                 ; 25DE: 57 44 53 43 4E 30 
INPBUF          FCB     $00,$00                  ; 25E4: 00 00          
FNAMPTR         FDB     $0000                    ; 25E6: 00 00          
M25E8           FCB     $20,$20,$20,$20,$20,$20  ; 25E8: 20 20 20 20 20 20 
                FCB     $20,$20                  ; 25EE: 20 20          
M25F0           FCB     $20,$20                  ; 25F0: 20 20          
M25F2           FCB     $00,$00,$00,$00,$00,$00  ; 25F2: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 25F8: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 25FE: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2604: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 260A: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2610: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2616: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 261C: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2622: 00 00 00 00 00 00 
                FCB     $00,$00,$00,$00,$00,$00  ; 2628: 00 00 00 00 00 00 
M262E           FCC     '*NO SDW\'S* '
NODIRFND        FCC     'NO DIRECTORY ENTRY FOUND'
                FCB     CR                       ; 2651: 0D             
TTLNROFSEC      FCC     'TOTAL NUMBER OF SECTORS :    '
M266F           FCC     ' /$  '
M2674           FCB     ' '
                FCB     CR                       ; 2675: 0D             
M2676           FCC     'TOTAL DIRECTORY ENTRIES SHOWN :   '
M2698           FCC     ' /$ '
M269C           FCB     ' '
                FCB     CR                       ; 269D: 0D             
NOTRMFND        FCC     'NO TERMINATOR FOUND IN FILE\'S R.I.B.'
                FCB     CR                       ; 26C2: 0D             ; 
Z26C3           TSTB                             ; 26C3: 5D             ; 
                BEQ     Z26F5                    ; 26C4: 27 2F          ; 
                INC     $03,X                    ; 26C6: 6C 03          ; 
                BNE     Z26CC                    ; 26C8: 26 02          ; 
                INC     $02,X                    ; 26CA: 6C 02          ; 
Z26CC           STX     M26F6                    ; 26CC: FF 26 F6       ; 
Z26CF           LDX     M26F6                    ; 26CF: FE 26 F6       ; 
                LDAA    $01,X                    ; 26D2: A6 01          ; 
                ANDA    #$0F                     ; 26D4: 84 0F          ; 
                CMPA    #$09                     ; 26D6: 81 09          ; 
                BLS     Z26DC                    ; 26D8: 23 02          ; 
                ADDA    #$07                     ; 26DA: 8B 07          ; 
Z26DC           ADDA    #$30                     ; 26DC: 8B 30          ; 
                TST     $03,X                    ; 26DE: 6D 03          ; 
                BNE     Z26E4                    ; 26E0: 26 02          ; 
                DEC     $02,X                    ; 26E2: 6A 02          ; 
Z26E4           DEC     $03,X                    ; 26E4: 6A 03          ; 
                LDX     $02,X                    ; 26E6: EE 02          ; 
                STAA    ,X                       ; 26E8: A7 00          ; 
                LDX     M26F6                    ; 26EA: FE 26 F6       ; 
                BSR     Z26F8                    ; 26ED: 8D 09          ; 
                DECB                             ; 26EF: 5A             ; 
                BNE     Z26CF                    ; 26F0: 26 DD          ; 
                LDX     M26F6                    ; 26F2: FE 26 F6       ; 
Z26F5           RTS                              ; 26F5: 39             ; 
;------------------------------------------------
M26F6           FDB     $0000
Z26F8           PSHA                             ; 26F8: 36             ; 
                LDAA    #$04                     ; 26F9: 86 04          ; 
Z26FB           LSR     ,X                       ; 26FB: 64 00          ; 
                ROR     $01,X                    ; 26FD: 66 01          ; 
                DECA                             ; 26FF: 4A             ; 
                BNE     Z26FB                    ; 2700: 26 F9          ; 
                PULA                             ; 2702: 32             ; 
                RTS                              ; 2703: 39             ; 
;------------------------------------------------
Z2704           TSTB                             ; 2704: 5D             ; 
                BNE     Z270A                    ; 2705: 26 03          ; 
                JMP     Z2790                    ; 2707: 7E 27 90       ; 
;------------------------------------------------
Z270A           INC     $03,X                    ; 270A: 6C 03          ; 
                BNE     Z2710                    ; 270C: 26 02          ; 
                INC     $02,X                    ; 270E: 6C 02          ; 
Z2710           STAB    M27A3                    ; 2710: F7 27 A3       ; 
                STX     M27A5                    ; 2713: FF 27 A5       ; 
                LDX     #M2791                   ; 2716: CE 27 91       ; 
                STX     M27A0                    ; 2719: FF 27 A0       ; 
                LDAA    #$04                     ; 271C: 86 04          ; 
                STAA    M27A4                    ; 271E: B7 27 A4       ; 
                LDX     M27A5                    ; 2721: FE 27 A5       ; 
                LDAA    ,X                       ; 2724: A6 00          ; 
                LDAB    $01,X                    ; 2726: E6 01          ; 
                LDX     #M279B                   ; 2728: CE 27 9B       ; 
Z272B           CLR     $07,X                    ; 272B: 6F 07          ; 
Z272D           LDX     $05,X                    ; 272D: EE 05          ; 
                SUBB    $01,X                    ; 272F: E0 01          ; 
                SBCA    ,X                       ; 2731: A2 00          ; 
                BCS     Z273C                    ; 2733: 25 07          ; 
                LDX     #M279B                   ; 2735: CE 27 9B       ; 
                INC     $07,X                    ; 2738: 6C 07          ; 
                BRA     Z272D                    ; 273A: 20 F1          ; 
;------------------------------------------------
Z273C           ADDB    $01,X                    ; 273C: EB 01          ; 
                ADCA    ,X                       ; 273E: A9 00          ; 
                LDX     #M279B                   ; 2740: CE 27 9B       ; 
                PSHA                             ; 2743: 36             ; 
                PSHB                             ; 2744: 37             ; 
                LDAA    $07,X                    ; 2745: A6 07          ; 
                ADDA    #$30                     ; 2747: 8B 30          ; 
                LDAB    $09,X                    ; 2749: E6 09          ; 
                BEQ     Z2751                    ; 274B: 27 04          ; 
Z274D           INX                              ; 274D: 08             ; 
                DECB                             ; 274E: 5A             ; 
                BNE     Z274D                    ; 274F: 26 FC          ; 
Z2751           STAA    ,X                       ; 2751: A7 00          ; 
                PULB                             ; 2753: 33             ; 
                PULA                             ; 2754: 32             ; 
                LDX     #M279B                   ; 2755: CE 27 9B       ; 
                INC     $06,X                    ; 2758: 6C 06          ; 
                BNE     Z275E                    ; 275A: 26 02          ; 
                INC     $05,X                    ; 275C: 6C 05          ; 
Z275E           INC     $06,X                    ; 275E: 6C 06          ; 
                BNE     Z2764                    ; 2760: 26 02          ; 
                INC     $05,X                    ; 2762: 6C 05          ; 
Z2764           DEC     $09,X                    ; 2764: 6A 09          ; 
                BGE     Z272B                    ; 2766: 2C C3          ; 
                STX     $05,X                    ; 2768: EF 05          ; 
Z276A           LDX     $05,X                    ; 276A: EE 05          ; 
                LDAA    ,X                       ; 276C: A6 00          ; 
                LDX     #M279B                   ; 276E: CE 27 9B       ; 
                LDX     $0A,X                    ; 2771: EE 0A          ; 
                TST     $03,X                    ; 2773: 6D 03          ; 
                BNE     Z2779                    ; 2775: 26 02          ; 
                DEC     $02,X                    ; 2777: 6A 02          ; 
Z2779           DEC     $03,X                    ; 2779: 6A 03          ; 
                LDX     $02,X                    ; 277B: EE 02          ; 
                STAA    ,X                       ; 277D: A7 00          ; 
                LDX     #M279B                   ; 277F: CE 27 9B       ; 
                INC     $06,X                    ; 2782: 6C 06          ; 
                BNE     Z2788                    ; 2784: 26 02          ; 
                INC     $05,X                    ; 2786: 6C 05          ; 
Z2788           DEC     $08,X                    ; 2788: 6A 08          ; 
                BNE     Z276A                    ; 278A: 26 DE          ; 
                LDX     M27A5                    ; 278C: FE 27 A5       ; 
                CLRA                             ; 278F: 4F             ; 
Z2790           RTS                              ; 2790: 39             ; 
;------------------------------------------------
M2791           FCB     $27                      ; 2791: 27             ; 
                FCB     $10,$03,$E8,$00          ; 2792: 10 03 E8 00    ; 
                FCB     $64                      ; 2796: 64             ; 
                FCB     $00,$0A,$00,$01          ; 2797: 00 0A 00 01    ; 
M279B           FCB     $00,$00,$00,$00,$00      ; 279B: 00 00 00 00 00 ; 
M27A0           FCB     $00,$00,$00              ; 27A0: 00 00 00       ; 
M27A3           FCB     $00                      ; 27A3: 00             ; 
M27A4           FCB     $00                      ; 27A4: 00             ; 
M27A5           FDB     CURDRV                   ; 27A5: 00 00          ; 
Z27A7           LDAA    #$01                     ; 27A7: 86 01          ; 
                ADDA    ,X                       ; 27A9: AB 00          ; 
                ORAA    #$10                     ; 27AB: 8A 10          ; 
                STAA    ,X                       ; 27AD: A7 00          ; 
                ADDA    #$C6                     ; 27AF: 8B C6          ; 
                BCC     Z27BB                    ; 27B1: 24 08          ; 
                LDAA    #$30                     ; 27B3: 86 30          ; 
                STAA    ,X                       ; 27B5: A7 00          ; 
                DEX                              ; 27B7: 09             ; 
                DECB                             ; 27B8: 5A             ; 
                BNE     Z27A7                    ; 27B9: 26 EC          ; 
Z27BB           RTS                              ; 27BB: 39             ; 
;------------------------------------------------

                REPT    $C4                      ; Filler
                FCB     $00
                ENDM
                END
