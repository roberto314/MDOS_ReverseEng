dasmfw: Disassembler Framework V0.35
Loaded: binary file "mdosov0.sy"
Loaded: Info file "mdosov0.info"

;****************************************************
; Used Labels
;****************************************************

M0000   EQU     $0000
M0001   EQU     $0001
M0006   EQU     $0006
M0020   EQU     $0020
RIBBAs  EQU     $010E
Z0467   EQU     $0467
Z04CE   EQU     $04CE
Z11F2   EQU     $11F2
M17E5   EQU     $17E5
M17E6   EQU     $17E6
M17E8   EQU     $17E8
M17E9   EQU     $17E9
M17EA   EQU     $17EA
M17EB   EQU     $17EB
M17EC   EQU     $17EC
M17ED   EQU     $17ED
M17EE   EQU     $17EE
M17EF   EQU     $17EF
M17F1   EQU     $17F1
M17F2   EQU     $17F2
M17F3   EQU     $17F3
M17F5   EQU     $17F5
M17F6   EQU     $17F6
M17F7   EQU     $17F7
M17F8   EQU     $17F8
M17F9   EQU     $17F9
M17FB   EQU     $17FB
M17FC   EQU     $17FC
M17FD   EQU     $17FD
M17FE   EQU     $17FE
M17FF   EQU     $17FF
M1801   EQU     $1801
M1803   EQU     $1803
Z1FFD   EQU     $1FFD
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
MFFFF   EQU     $FFFF

;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $1273

ALLOC1          JMP     ALLOC2                   ; 1273: 7E 12 A9       
DEALC1          JMP     DEALC2                   ; 1276: 7E 15 9D       
                JSR     Z11F2                    ; 1279: BD 11 F2       
                JSR     Z11F2                    ; 127C: BD 11 F2       
                JSR     Z11F2                    ; 127F: BD 11 F2       
                JSR     Z11F2                    ; 1282: BD 11 F2       
                JSR     Z11F2                    ; 1285: BD 11 F2       
                JSR     Z11F2                    ; 1288: BD 11 F2       
                JSR     Z11F2                    ; 128B: BD 11 F2       
                JSR     Z11F2                    ; 128E: BD 11 F2       
                JSR     Z11F2                    ; 1291: BD 11 F2       
                JSR     Z11F2                    ; 1294: BD 11 F2       
                JSR     Z11F2                    ; 1297: BD 11 F2       
                JSR     Z11F2                    ; 129A: BD 11 F2       
                JSR     Z11F2                    ; 129D: BD 11 F2       
                JSR     Z11F2                    ; 12A0: BD 11 F2       
                JSR     Z11F2                    ; 12A3: BD 11 F2       
                JSR     Z11F2                    ; 12A6: BD 11 F2       
ALLOC2          STX     M17E6                    ; 12A9: FF 17 E6       
                LDAB    ,X                       ; 12AC: E6 00          
                STAB    M17E5                    ; 12AE: F7 17 E5       
                LDX     $13,X                    ; 12B1: EE 13          
                BEQ     Z12C6                    ; 12B3: 27 11          
                DEX                              ; 12B5: 09             
                STX     M17E8                    ; 12B6: FF 17 E8       
                LDX     #M17E8                   ; 12B9: CE 17 E8       
                LDAA    #$02                     ; 12BC: 86 02          
                SWI                              ; 12BE: 3F             
                FCB     $19                      ; 12BF: 19             
                LDX     M17E8                    ; 12C0: FE 17 E8       
                INX                              ; 12C3: 08             
                BRA     Z12C9                    ; 12C4: 20 03          
Z12C6           LDX     #M0020                   ; 12C6: CE 00 20       
Z12C9           STX     M17E8                    ; 12C9: FF 17 E8       
                LDX     RIBBAs                   ; 12CC: FE 01 0E       
                STX     M17ED                    ; 12CF: FF 17 ED       
                LDX     M17E6                    ; 12D2: FE 17 E6       
                LDX     $0B,X                    ; 12D5: EE 0B          
                BEQ     Z1314                    ; 12D7: 27 3B          
                JSR     Z17C0                    ; 12D9: BD 17 C0       
                DEX                              ; 12DC: 09             
                DEX                              ; 12DD: 09             
                LDX     ,X                       ; 12DE: EE 00          
                STX     M17EF                    ; 12E0: FF 17 EF       
                DECB                             ; 12E3: 5A             
                LDAA    #$39                     ; 12E4: 86 39          
                SBA                              ; 12E6: 10             
                LDX     M17E8                    ; 12E7: FE 17 E8       
                DEX                              ; 12EA: 09             
                STX     M17F3                    ; 12EB: FF 17 F3       
                LDX     #M17F3                   ; 12EE: CE 17 F3       
                TAB                              ; 12F1: 16             
                LDAA    #$05                     ; 12F2: 86 05          
                SWI                              ; 12F4: 3F             
                FCB     $19                      ; 12F5: 19             
                TBA                              ; 12F6: 17             
                CLRB                             ; 12F7: 5F             
                LDX     M17F3                    ; 12F8: FE 17 F3       
                INX                              ; 12FB: 08             
                JSR     Z04CE                    ; 12FC: BD 04 CE       
                BCC     Z1304                    ; 12FF: 24 03          
                JMP     Z1591                    ; 1301: 7E 15 91       
Z1304           LDX     M17EF                    ; 1304: FE 17 EF       
                JSR     Z1787                    ; 1307: BD 17 87       
                SWI                              ; 130A: 3F             
                FCB     $27                      ; 130B: 27             
                STX     M17F5                    ; 130C: FF 17 F5       
                STX     M17FD                    ; 130F: FF 17 FD       
                BRA     Z131E                    ; 1312: 20 0A          
Z1314           LDX     #M0000                   ; 1314: CE 00 00       
                STX     M17F5                    ; 1317: FF 17 F5       
                DEX                              ; 131A: 09             
                STX     M17FD                    ; 131B: FF 17 FD       
Z131E           LDX     #M0001                   ; 131E: CE 00 01       
                STX     M17EB                    ; 1321: FF 17 EB       
                LDAB    M17E5                    ; 1324: F6 17 E5       
                LDX     #M17EA                   ; 1327: CE 17 EA       
                SWI                              ; 132A: 3F             
                FCB     $0E                      ; 132B: 0E             
                LDX     M17F5                    ; 132C: FE 17 F5       
                BEQ     Z1334                    ; 132F: 27 03          
                JMP     Z1372                    ; 1331: 7E 13 72       
Z1334           STX     M17F7                    ; 1334: FF 17 F7       
Z1337           JSR     Z172E                    ; 1337: BD 17 2E       
                BNE     Z136A                    ; 133A: 26 2E          
                BCS     Z136A                    ; 133C: 25 2C          
                LDX     M17F5                    ; 133E: FE 17 F5       
                STX     M17FB                    ; 1341: FF 17 FB       
                LDX     #M0001                   ; 1344: CE 00 01       
                STX     M17F1                    ; 1347: FF 17 F1       
Z134A           JSR     Z175D                    ; 134A: BD 17 5D       
                BCS     Z1364                    ; 134D: 25 15          
                JSR     Z172E                    ; 134F: BD 17 2E       
                BNE     Z135F                    ; 1352: 26 0B          
                BCS     Z135F                    ; 1354: 25 09          
                LDX     M17F1                    ; 1356: FE 17 F1       
                INX                              ; 1359: 08             
                STX     M17F1                    ; 135A: FF 17 F1       
                BRA     Z134A                    ; 135D: 20 EB          
Z135F           JSR     Z176C                    ; 135F: BD 17 6C       
                BRA     Z136A                    ; 1362: 20 06          
Z1364           JSR     Z176C                    ; 1364: BD 17 6C       
                JMP     Z13A7                    ; 1367: 7E 13 A7       
Z136A           JSR     Z175D                    ; 136A: BD 17 5D       
                BCC     Z1337                    ; 136D: 24 C8          
                JMP     Z13A7                    ; 136F: 7E 13 A7       
Z1372           STX     M17F9                    ; 1372: FF 17 F9       
                CLR     M17F7                    ; 1375: 7F 17 F7       
                CLR     M17F8                    ; 1378: 7F 17 F8       
Z137B           JSR     Z172E                    ; 137B: BD 17 2E       
                BCS     Z1382                    ; 137E: 25 02          
                BEQ     Z1394                    ; 1380: 27 12          
Z1382           LDX     M17E6                    ; 1382: FE 17 E6       
                LDAB    #$10                     ; 1385: C6 10          
                BITB    $0D,X                    ; 1387: E5 0D          
                BNE     Z13A7                    ; 1389: 26 1C          
                LDX     #M0000                   ; 138B: CE 00 00       
                STX     M17F5                    ; 138E: FF 17 F5       
                JMP     Z1334                    ; 1391: 7E 13 34       
Z1394           LDX     M17F7                    ; 1394: FE 17 F7       
                INX                              ; 1397: 08             
                STX     M17F7                    ; 1398: FF 17 F7       
                CPX     M17E8                    ; 139B: BC 17 E8       
                BEQ     Z13A7                    ; 139E: 27 07          
                JSR     Z175D                    ; 13A0: BD 17 5D       
                BCC     Z137B                    ; 13A3: 24 D6          
                BRA     Z1382                    ; 13A5: 20 DB          
Z13A7           LDX     M17F7                    ; 13A7: FE 17 F7       
                BNE     Z13AF                    ; 13AA: 26 03          
Z13AC           JMP     Z158D                    ; 13AC: 7E 15 8D       
Z13AF           LDAB    M17E8                    ; 13AF: F6 17 E8       
                LDAA    M17E9                    ; 13B2: B6 17 E9       
                SWI                              ; 13B5: 3F             
                FCB     $26                      ; 13B6: 26             
                JSR     Z04CE                    ; 13B7: BD 04 CE       
                BCC     Z13C9                    ; 13BA: 24 0D          
                LDX     M17E6                    ; 13BC: FE 17 E6       
                LDX     $13,X                    ; 13BF: EE 13          
                BNE     Z13AC                    ; 13C1: 26 E9          
                LDX     M17F7                    ; 13C3: FE 17 F7       
                STX     M17E8                    ; 13C6: FF 17 E8       
Z13C9           LDX     M17E6                    ; 13C9: FE 17 E6       
                TST     $0B,X                    ; 13CC: 6D 0B          
                BNE     Z13D4                    ; 13CE: 26 04          
                TST     $0C,X                    ; 13D0: 6D 0C          
                BEQ     Z13E5                    ; 13D2: 27 11          
Z13D4           LDAB    #$10                     ; 13D4: C6 10          
                BITB    $0D,X                    ; 13D6: E5 0D          
                BEQ     Z13E5                    ; 13D8: 27 0B          
                LDX     M17FD                    ; 13DA: FE 17 FD       
                CPX     M17F9                    ; 13DD: BC 17 F9       
                BEQ     Z13E5                    ; 13E0: 27 03          
                JMP     Z158D                    ; 13E2: 7E 15 8D       
Z13E5           LDX     M17F9                    ; 13E5: FE 17 F9       
                STX     M17F5                    ; 13E8: FF 17 F5       
                LDX     M17E8                    ; 13EB: FE 17 E8       
                STX     M17F1                    ; 13EE: FF 17 F1       
Z13F1           JSR     Z172E                    ; 13F1: BD 17 2E       
                ORAB    ,X                       ; 13F4: EA 00          
                STAB    ,X                       ; 13F6: E7 00          
                LDX     M17F5                    ; 13F8: FE 17 F5       
                INX                              ; 13FB: 08             
                STX     M17F5                    ; 13FC: FF 17 F5       
                LDX     M17F1                    ; 13FF: FE 17 F1       
                DEX                              ; 1402: 09             
                STX     M17F1                    ; 1403: FF 17 F1       
                BNE     Z13F1                    ; 1406: 26 E9          
                LDAB    M17E5                    ; 1408: F6 17 E5       
                LDX     #M17EA                   ; 140B: CE 17 EA       
                SWI                              ; 140E: 3F             
                FCB     $0F                      ; 140F: 0F             
                LDX     M17E6                    ; 1410: FE 17 E6       
                LDX     $0B,X                    ; 1413: EE 0B          
                BNE     Z1431                    ; 1415: 26 1A          
                LDX     M17ED                    ; 1417: FE 17 ED       
                LDAB    #$80                     ; 141A: C6 80          
                CLRA                             ; 141C: 4F             
                SWI                              ; 141D: 3F             
                FCB     $13                      ; 141E: 13             
                DECB                             ; 141F: 5A             
                LDX     M17ED                    ; 1420: FE 17 ED       
                STAB    ,X                       ; 1423: E7 00          
                LDX     M17F9                    ; 1425: FE 17 F9       
                SWI                              ; 1428: 3F             
                FCB     $31                      ; 1429: 31             
                SWI                              ; 142A: 3F             
                FCB     $31                      ; 142B: 31             
                STX     M17EB                    ; 142C: FF 17 EB       
                BRA     Z143C                    ; 142F: 20 0B          
Z1431           STX     M17EB                    ; 1431: FF 17 EB       
                LDAB    M17E5                    ; 1434: F6 17 E5       
                LDX     #M17EA                   ; 1437: CE 17 EA       
                SWI                              ; 143A: 3F             
                FCB     $0E                      ; 143B: 0E             
Z143C           LDX     M17ED                    ; 143C: FE 17 ED       
Z143F           TST     ,X                       ; 143F: 6D 00          
                BMI     Z1447                    ; 1441: 2B 04          
                INX                              ; 1443: 08             
                INX                              ; 1444: 08             
                BRA     Z143F                    ; 1445: 20 F8          
Z1447           STX     M17F3                    ; 1447: FF 17 F3       
                LDX     M17F9                    ; 144A: FE 17 F9       
                CPX     M17FD                    ; 144D: BC 17 FD       
                BEQ     Z149D                    ; 1450: 27 4B          
Z1452           LDX     M17E8                    ; 1452: FE 17 E8       
                STX     M17F1                    ; 1455: FF 17 F1       
                CLRB                             ; 1458: 5F             
                LDAA    #$20                     ; 1459: 86 20          
                JSR     Z04CE                    ; 145B: BD 04 CE       
                BCC     Z1466                    ; 145E: 24 06          
                STAB    M17F1                    ; 1460: F7 17 F1       
                STAA    M17F2                    ; 1463: B7 17 F2       
Z1466           LDAA    M17F2                    ; 1466: B6 17 F2       
                SWI                              ; 1469: 3F             
                FCB     $2C                      ; 146A: 2C             
                STX     M17E8                    ; 146B: FF 17 E8       
                LDX     M17F9                    ; 146E: FE 17 F9       
                STX     M17EF                    ; 1471: FF 17 EF       
                SWI                              ; 1474: 3F             
                FCB     $29                      ; 1475: 29             
                STX     M17F9                    ; 1476: FF 17 F9       
                LDAB    M17F2                    ; 1479: F6 17 F2       
                LDX     M17EF                    ; 147C: FE 17 EF       
                JSR     Z1799                    ; 147F: BD 17 99       
                LDX     M17F3                    ; 1482: FE 17 F3       
                STAB    ,X                       ; 1485: E7 00          
                STAA    $01,X                    ; 1487: A7 01          
Z1489           INX                              ; 1489: 08             
                INX                              ; 148A: 08             
                STX     M17F3                    ; 148B: FF 17 F3       
                DEX                              ; 148E: 09             
                DEX                              ; 148F: 09             
                LDX     ,X                       ; 1490: EE 00          
                STX     M17FD                    ; 1492: FF 17 FD       
                LDX     M17E8                    ; 1495: FE 17 E8       
                BNE     Z1452                    ; 1498: 26 B8          
                JMP     Z14F9                    ; 149A: 7E 14 F9       
Z149D           LDX     M17F3                    ; 149D: FE 17 F3       
                DEX                              ; 14A0: 09             
                DEX                              ; 14A1: 09             
                STX     M17F3                    ; 14A2: FF 17 F3       
                LDX     ,X                       ; 14A5: EE 00          
                JSR     Z1787                    ; 14A7: BD 17 87       
                STAB    M17F1                    ; 14AA: F7 17 F1       
                LDAA    #$20                     ; 14AD: 86 20          
                SBA                              ; 14AF: 10             
                BNE     Z14BC                    ; 14B0: 26 0A          
                LDX     M17F3                    ; 14B2: FE 17 F3       
                INX                              ; 14B5: 08             
                INX                              ; 14B6: 08             
                STX     M17F3                    ; 14B7: FF 17 F3       
                BRA     Z1452                    ; 14BA: 20 96          
Z14BC           STAA    M17F7                    ; 14BC: B7 17 F7       
                CLRB                             ; 14BF: 5F             
                LDX     M17E8                    ; 14C0: FE 17 E8       
                SWI                              ; 14C3: 3F             
                FCB     $26                      ; 14C4: 26             
                JSR     Z04CE                    ; 14C5: BD 04 CE       
                BCC     Z14D0                    ; 14C8: 24 06          
                LDAA    M17E9                    ; 14CA: B6 17 E9       
                STAA    M17F7                    ; 14CD: B7 17 F7       
Z14D0           LDAA    M17F7                    ; 14D0: B6 17 F7       
                LDX     M17E8                    ; 14D3: FE 17 E8       
                SWI                              ; 14D6: 3F             
                FCB     $2C                      ; 14D7: 2C             
                STX     M17E8                    ; 14D8: FF 17 E8       
                LDX     M17F9                    ; 14DB: FE 17 F9       
                SWI                              ; 14DE: 3F             
                FCB     $28                      ; 14DF: 28             
                STX     M17F9                    ; 14E0: FF 17 F9       
                LDAB    M17F1                    ; 14E3: F6 17 F1       
                ADDB    M17F7                    ; 14E6: FB 17 F7       
                LDX     M17EF                    ; 14E9: FE 17 EF       
                JSR     Z1799                    ; 14EC: BD 17 99       
                LDX     M17F3                    ; 14EF: FE 17 F3       
                STAB    ,X                       ; 14F2: E7 00          
                STAA    $01,X                    ; 14F4: A7 01          
                JMP     Z1489                    ; 14F6: 7E 14 89       
Z14F9           LDX     #MFFFF                   ; 14F9: CE FF FF       
                STX     M17FB                    ; 14FC: FF 17 FB       
                LDX     M17ED                    ; 14FF: FE 17 ED       
Z1502           STX     M17EF                    ; 1502: FF 17 EF       
                LDX     ,X                       ; 1505: EE 00          
                LDAB    M17FD                    ; 1507: F6 17 FD       
                LDAA    M17FE                    ; 150A: B6 17 FE       
                JSR     Z04CE                    ; 150D: BD 04 CE       
                BNE     Z1570                    ; 1510: 26 5E          
                LDX     M17FD                    ; 1512: FE 17 FD       
                JSR     Z1787                    ; 1515: BD 17 87       
                ASLB                             ; 1518: 58             
                ASLB                             ; 1519: 58             
                DECB                             ; 151A: 5A             
                LDX     M17FB                    ; 151B: FE 17 FB       
                SWI                              ; 151E: 3F             
                FCB     $27                      ; 151F: 27             
                STX     M17F5                    ; 1520: FF 17 F5       
                JSR     Z0467                    ; 1523: BD 04 67       
                ORAB    #$80                     ; 1526: CA 80          
                LDX     M17F3                    ; 1528: FE 17 F3       
                STAB    ,X                       ; 152B: E7 00          
                STAA    $01,X                    ; 152D: A7 01          
                LDAB    M17E5                    ; 152F: F6 17 E5       
                LDX     #M17EA                   ; 1532: CE 17 EA       
                SWI                              ; 1535: 3F             
                FCB     $0F                      ; 1536: 0F             
                LDX     M17E6                    ; 1537: FE 17 E6       
                LDX     $0B,X                    ; 153A: EE 0B          
                BNE     Z154D                    ; 153C: 26 0F          
                LDAB    M17EB                    ; 153E: F6 17 EB       
                LDAA    M17EC                    ; 1541: B6 17 EC       
                LDX     M17E6                    ; 1544: FE 17 E6       
                STAB    $0B,X                    ; 1547: E7 0B          
                STAA    $0C,X                    ; 1549: A7 0C          
Z154B           CLRB                             ; 154B: 5F             
                RTS                              ; 154C: 39             
Z154D           LDX     M17E6                    ; 154D: FE 17 E6       
                LDAB    M17FD                    ; 1550: F6 17 FD       
                LDAA    M17FE                    ; 1553: B6 17 FE       
                STAB    $03,X                    ; 1556: E7 03          
                STAA    $04,X                    ; 1558: A7 04          
                LDAB    M17FB                    ; 155A: F6 17 FB       
                LDAA    M17FC                    ; 155D: B6 17 FC       
                STAB    $05,X                    ; 1560: E7 05          
                STAA    $06,X                    ; 1562: A7 06          
                LDAB    M17F5                    ; 1564: F6 17 F5       
                LDAA    M17F6                    ; 1567: B6 17 F6       
                STAB    $09,X                    ; 156A: E7 09          
                STAA    $0A,X                    ; 156C: A7 0A          
                BRA     Z154B                    ; 156E: 20 DB          
Z1570           JSR     Z1787                    ; 1570: BD 17 87       
                ASLB                             ; 1573: 58             
                ASLB                             ; 1574: 58             
                LDX     M17FB                    ; 1575: FE 17 FB       
                SWI                              ; 1578: 3F             
                FCB     $27                      ; 1579: 27             
                STX     M17FB                    ; 157A: FF 17 FB       
                LDX     M17EF                    ; 157D: FE 17 EF       
                INX                              ; 1580: 08             
                INX                              ; 1581: 08             
                JMP     Z1502                    ; 1582: 7E 15 02       
Z1585           LDAB    #$16                     ; 1585: C6 16          
Z1587           SEC                              ; 1587: 0D             
                RTS                              ; 1588: 39             
Z1589           LDAB    #$11                     ; 1589: C6 11          
                BRA     Z1587                    ; 158B: 20 FA          
Z158D           LDAB    #$12                     ; 158D: C6 12          
                BRA     Z1587                    ; 158F: 20 F6          
Z1591           LDAB    #$14                     ; 1591: C6 14          
                BRA     Z1587                    ; 1593: 20 F2          
Z1595           LDAB    #$15                     ; 1595: C6 15          
                BRA     Z1587                    ; 1597: 20 EE          
Z1599           LDAB    #$17                     ; 1599: C6 17          
                BRA     Z1587                    ; 159B: 20 EA          
DEALC2          STX     M17E6                    ; 159D: FF 17 E6       
                LDAB    ,X                       ; 15A0: E6 00          
                STAB    M17E5                    ; 15A2: F7 17 E5       
                LDX     RIBBAs                   ; 15A5: FE 01 0E       
                STX     M17ED                    ; 15A8: FF 17 ED       
                LDX     M17E6                    ; 15AB: FE 17 E6       
                LDX     $0B,X                    ; 15AE: EE 0B          
                BNE     Z15B5                    ; 15B0: 26 03          
                JMP     Z1585                    ; 15B2: 7E 15 85       
Z15B5           JSR     Z17C0                    ; 15B5: BD 17 C0       
                LDAB    #$74                     ; 15B8: C6 74          
                LDX     #M1803                   ; 15BA: CE 18 03       
                STX     M1801                    ; 15BD: FF 18 01       
                LDX     M17ED                    ; 15C0: FE 17 ED       
                STX     M17FF                    ; 15C3: FF 17 FF       
                LDX     #M17FF                   ; 15C6: CE 17 FF       
                SWI                              ; 15C9: 3F             
                FCB     $10                      ; 15CA: 10             
                LDX     M17E6                    ; 15CB: FE 17 E6       
                LDX     $01,X                    ; 15CE: EE 01          
                CPX     #MFFFF                   ; 15D0: 8C FF FF       
                BEQ     Z15D8                    ; 15D3: 27 03          
                JMP     Z1676                    ; 15D5: 7E 16 76       
Z15D8           LDX     M17E6                    ; 15D8: FE 17 E6       
                LDAB    $11,X                    ; 15DB: E6 11          
                STAB    M17F3                    ; 15DD: F7 17 F3       
                ANDB    #$F8                     ; 15E0: C4 F8          
                LSRB                             ; 15E2: 54             
                LSRB                             ; 15E3: 54             
                LSRB                             ; 15E4: 54             
                CMPB    #$03                     ; 15E5: C1 03          
                BLT     Z15ED                    ; 15E7: 2D 04          
                CMPB    #$16                     ; 15E9: C1 16          
                BLS     Z15F0                    ; 15EB: 23 03          
Z15ED           JMP     Z1595                    ; 15ED: 7E 15 95       
Z15F0           CLR     M17EB                    ; 15F0: 7F 17 EB       
                STAB    M17EC                    ; 15F3: F7 17 EC       
                LDAB    M17E5                    ; 15F6: F6 17 E5       
                LDX     #M17EA                   ; 15F9: CE 17 EA       
                SWI                              ; 15FC: 3F             
                FCB     $0E                      ; 15FD: 0E             
                LDAB    M17F3                    ; 15FE: F6 17 F3       
                ANDB    #$07                     ; 1601: C4 07          
                ASLB                             ; 1603: 58             
                ASLB                             ; 1604: 58             
                ASLB                             ; 1605: 58             
                ASLB                             ; 1606: 58             
                LDX     M17ED                    ; 1607: FE 17 ED       
                SWI                              ; 160A: 3F             
                FCB     $27                      ; 160B: 27             
                LDAA    ,X                       ; 160C: A6 00          
                CMPA    #$FF                     ; 160E: 81 FF          
                BEQ     Z1615                    ; 1610: 27 03          
                JMP     Z1599                    ; 1612: 7E 15 99       
Z1615           LDX     M17E6                    ; 1615: FE 17 E6       
                CLR     $0B,X                    ; 1618: 6F 0B          
                CLR     $0C,X                    ; 161A: 6F 0C          
                LDX     #M1803                   ; 161C: CE 18 03       
Z161F           TST     ,X                       ; 161F: 6D 00          
                BPL     Z1626                    ; 1621: 2A 03          
                JMP     Z154B                    ; 1623: 7E 15 4B       
Z1626           STX     M17F3                    ; 1626: FF 17 F3       
                LDX     #M0001                   ; 1629: CE 00 01       
                STX     M17EB                    ; 162C: FF 17 EB       
                LDAB    M17E5                    ; 162F: F6 17 E5       
                LDX     #M17EA                   ; 1632: CE 17 EA       
                SWI                              ; 1635: 3F             
                FCB     $0E                      ; 1636: 0E             
Z1637           LDX     M17F3                    ; 1637: FE 17 F3       
                LDX     ,X                       ; 163A: EE 00          
                BPL     Z1649                    ; 163C: 2A 0B          
                LDAB    M17E5                    ; 163E: F6 17 E5       
                LDX     #M17EA                   ; 1641: CE 17 EA       
                SWI                              ; 1644: 3F             
                FCB     $0F                      ; 1645: 0F             
                JMP     Z154B                    ; 1646: 7E 15 4B       
Z1649           JSR     Z1787                    ; 1649: BD 17 87       
                STAB    M17E8                    ; 164C: F7 17 E8       
                STX     M17F5                    ; 164F: FF 17 F5       
Z1652           JSR     Z172E                    ; 1652: BD 17 2E       
                BCS     Z165C                    ; 1655: 25 05          
                COMB                             ; 1657: 53             
                ANDB    ,X                       ; 1658: E4 00          
                STAB    ,X                       ; 165A: E7 00          
Z165C           LDX     M17F5                    ; 165C: FE 17 F5       
                INX                              ; 165F: 08             
                STX     M17F5                    ; 1660: FF 17 F5       
                LDAB    M17E8                    ; 1663: F6 17 E8       
                DECB                             ; 1666: 5A             
                STAB    M17E8                    ; 1667: F7 17 E8       
                BNE     Z1652                    ; 166A: 26 E6          
                LDX     M17F3                    ; 166C: FE 17 F3       
                INX                              ; 166F: 08             
                INX                              ; 1670: 08             
                STX     M17F3                    ; 1671: FF 17 F3       
                BRA     Z1637                    ; 1674: 20 C1          
Z1676           INX                              ; 1676: 08             
                SWI                              ; 1677: 3F             
                FCB     $30                      ; 1678: 30             
                SWI                              ; 1679: 3F             
                FCB     $30                      ; 167A: 30             
                INX                              ; 167B: 08             
                STX     M17F1                    ; 167C: FF 17 F1       
                LDX     M17ED                    ; 167F: FE 17 ED       
                STX     M17F3                    ; 1682: FF 17 F3       
Z1685           LDX     M17F3                    ; 1685: FE 17 F3       
                LDX     ,X                       ; 1688: EE 00          
                BPL     Z168F                    ; 168A: 2A 03          
                JMP     Z1589                    ; 168C: 7E 15 89       
Z168F           JSR     Z1787                    ; 168F: BD 17 87       
                CLR     M17E8                    ; 1692: 7F 17 E8       
                STAB    M17E9                    ; 1695: F7 17 E9       
                STX     M17F5                    ; 1698: FF 17 F5       
                LDX     M17E8                    ; 169B: FE 17 E8       
                LDAB    M17F1                    ; 169E: F6 17 F1       
                LDAA    M17F2                    ; 16A1: B6 17 F2       
                JSR     Z04CE                    ; 16A4: BD 04 CE       
                BCS     Z16FB                    ; 16A7: 25 52          
                SWI                              ; 16A9: 3F             
                FCB     $2E                      ; 16AA: 2E             
                STAB    M17F1                    ; 16AB: F7 17 F1       
                STAA    M17F2                    ; 16AE: B7 17 F2       
                LDX     M17F3                    ; 16B1: FE 17 F3       
                INX                              ; 16B4: 08             
                INX                              ; 16B5: 08             
                STX     M17F3                    ; 16B6: FF 17 F3       
                LDX     M17F1                    ; 16B9: FE 17 F1       
                BNE     Z1685                    ; 16BC: 26 C7          
                JSR     Z17A9                    ; 16BE: BD 17 A9       
Z16C1           LDX     M17E6                    ; 16C1: FE 17 E6       
                LDAB    $01,X                    ; 16C4: E6 01          
                LDAA    $02,X                    ; 16C6: A6 02          
                ORAB    #$80                     ; 16C8: CA 80          
                LDX     M17F3                    ; 16CA: FE 17 F3       
                STAB    ,X                       ; 16CD: E7 00          
                STAA    $01,X                    ; 16CF: A7 01          
Z16D1           INX                              ; 16D1: 08             
                INX                              ; 16D2: 08             
                STX     M17F3                    ; 16D3: FF 17 F3       
                LDX     M17ED                    ; 16D6: FE 17 ED       
                LDAB    #$00                     ; 16D9: C6 00          
                LDAA    #$74                     ; 16DB: 86 74          
                SWI                              ; 16DD: 3F             
                FCB     $29                      ; 16DE: 29             
                CPX     M17F3                    ; 16DF: BC 17 F3       
                BEQ     Z16ED                    ; 16E2: 27 09          
                LDX     M17F3                    ; 16E4: FE 17 F3       
                CLR     ,X                       ; 16E7: 6F 00          
                CLR     $01,X                    ; 16E9: 6F 01          
                BRA     Z16D1                    ; 16EB: 20 E4          
Z16ED           LDAB    M17E5                    ; 16ED: F6 17 E5       
                LDX     #M17EA                   ; 16F0: CE 17 EA       
                SWI                              ; 16F3: 3F             
                FCB     $0F                      ; 16F4: 0F             
                LDX     M17EF                    ; 16F5: FE 17 EF       
                JMP     Z161F                    ; 16F8: 7E 16 1F       
Z16FB           JSR     Z17A9                    ; 16FB: BD 17 A9       
                LDAB    M17E9                    ; 16FE: F6 17 E9       
                SUBB    M17F2                    ; 1701: F0 17 F2       
                LDAA    M17F2                    ; 1704: B6 17 F2       
                LDX     M17F5                    ; 1707: FE 17 F5       
                SWI                              ; 170A: 3F             
                FCB     $28                      ; 170B: 28             
                JSR     Z1799                    ; 170C: BD 17 99       
                LDX     M17EF                    ; 170F: FE 17 EF       
                STAB    ,X                       ; 1712: E7 00          
                STAA    $01,X                    ; 1714: A7 01          
                LDX     M17F5                    ; 1716: FE 17 F5       
                LDAB    M17F2                    ; 1719: F6 17 F2       
                JSR     Z1799                    ; 171C: BD 17 99       
                LDX     M17F3                    ; 171F: FE 17 F3       
                STAB    ,X                       ; 1722: E7 00          
                STAA    $01,X                    ; 1724: A7 01          
                INX                              ; 1726: 08             
                INX                              ; 1727: 08             
                STX     M17F3                    ; 1728: FF 17 F3       
                JMP     Z16C1                    ; 172B: 7E 16 C1       
Z172E           LDAB    M17F5                    ; 172E: F6 17 F5       
                LDAA    M17F6                    ; 1731: B6 17 F6       
                LDX     #M0006                   ; 1734: CE 00 06       
                JSR     Z04CE                    ; 1737: BD 04 CE       
                BCC     Z173D                    ; 173A: 24 01          
                RTS                              ; 173C: 39             
Z173D           BSR     Z1748                    ; 173D: 8D 09          
                LDX     M17ED                    ; 173F: FE 17 ED       
                SWI                              ; 1742: 3F             
                FCB     $28                      ; 1743: 28             
                CLC                              ; 1744: 0C             
                BITB    ,X                       ; 1745: E5 00          
                RTS                              ; 1747: 39             
Z1748           ANDB    #$03                     ; 1748: C4 03          
                LSRB                             ; 174A: 54             
                RORA                             ; 174B: 46             
                RORB                             ; 174C: 56             
                RORA                             ; 174D: 46             
                RORB                             ; 174E: 56             
                LSRA                             ; 174F: 44             
                PSHA                             ; 1750: 36             
                ROLB                             ; 1751: 59             
                ROLB                             ; 1752: 59             
                ROLB                             ; 1753: 59             
                CLRA                             ; 1754: 4F             
                SEC                              ; 1755: 0D             
Z1756           RORA                             ; 1756: 46             
                DECB                             ; 1757: 5A             
                BGE     Z1756                    ; 1758: 2C FC          
                TAB                              ; 175A: 16             
                PULA                             ; 175B: 32             
                RTS                              ; 175C: 39             
Z175D           LDX     M17F5                    ; 175D: FE 17 F5       
                INX                              ; 1760: 08             
                STX     M17F5                    ; 1761: FF 17 F5       
                LDAB    #$03                     ; 1764: C6 03          
                LDAA    #$FF                     ; 1766: 86 FF          
                JSR     Z04CE                    ; 1768: BD 04 CE       
                RTS                              ; 176B: 39             
Z176C           LDX     M17F1                    ; 176C: FE 17 F1       
                LDAB    M17F7                    ; 176F: F6 17 F7       
                LDAA    M17F8                    ; 1772: B6 17 F8       
                JSR     Z04CE                    ; 1775: BD 04 CE       
                BCC     Z1786                    ; 1778: 24 0C          
                LDX     M17F1                    ; 177A: FE 17 F1       
                STX     M17F7                    ; 177D: FF 17 F7       
                LDX     M17FB                    ; 1780: FE 17 FB       
                STX     M17F9                    ; 1783: FF 17 F9       
Z1786           RTS                              ; 1786: 39             
Z1787           JSR     Z0467                    ; 1787: BD 04 67       
                ANDB    #$7C                     ; 178A: C4 7C          
                ASRB                             ; 178C: 57             
                ASRB                             ; 178D: 57             
                INCB                             ; 178E: 5C             
                PSHB                             ; 178F: 37             
                JSR     Z0467                    ; 1790: BD 04 67       
                ANDB    #$03                     ; 1793: C4 03          
                SWI                              ; 1795: 3F             
                FCB     $25                      ; 1796: 25             
                PULB                             ; 1797: 33             
                RTS                              ; 1798: 39             
Z1799           DECB                             ; 1799: 5A             
                ASLB                             ; 179A: 58             
                ASLB                             ; 179B: 58             
                PSHB                             ; 179C: 37             
                JSR     Z0467                    ; 179D: BD 04 67       
                ANDB    #$03                     ; 17A0: C4 03          
                SWI                              ; 17A2: 3F             
                FCB     $25                      ; 17A3: 25             
                PULB                             ; 17A4: 33             
                CLRA                             ; 17A5: 4F             
                SWI                              ; 17A6: 3F             
                FCB     $2A                      ; 17A7: 2A             
                RTS                              ; 17A8: 39             
Z17A9           LDX     M17F3                    ; 17A9: FE 17 F3       
                LDAB    M17ED                    ; 17AC: F6 17 ED       
                LDAA    M17EE                    ; 17AF: B6 17 EE       
                SWI                              ; 17B2: 3F             
                FCB     $2D                      ; 17B3: 2D             
                JSR     Z0467                    ; 17B4: BD 04 67       
                LDX     #M1803                   ; 17B7: CE 18 03       
                SWI                              ; 17BA: 3F             
                FCB     $29                      ; 17BB: 29             
                STX     M17EF                    ; 17BC: FF 17 EF       
                RTS                              ; 17BF: 39             
Z17C0           STX     M17EB                    ; 17C0: FF 17 EB       
                LDAB    M17E5                    ; 17C3: F6 17 E5       
                LDX     #M17EA                   ; 17C6: CE 17 EA       
                SWI                              ; 17C9: 3F             
                FCB     $0E                      ; 17CA: 0E             
                LDX     M17ED                    ; 17CB: FE 17 ED       
                LDAB    #$01                     ; 17CE: C6 01          
Z17D0           TST     ,X                       ; 17D0: 6D 00          
                BMI     Z17E0                    ; 17D2: 2B 0C          
                INX                              ; 17D4: 08             
                INX                              ; 17D5: 08             
                INCB                             ; 17D6: 5C             
                CMPB    #$3A                     ; 17D7: C1 3A          
                BLE     Z17D0                    ; 17D9: 2F F5          
Z17DB           INS                              ; 17DB: 31             
                INS                              ; 17DC: 31             
                JMP     Z1585                    ; 17DD: 7E 15 85       
Z17E0           CMPB    #$01                     ; 17E0: C1 01          
                BEQ     Z17DB                    ; 17E2: 27 F7          
                RTS                              ; 17E4: 39             


                END
