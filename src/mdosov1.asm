dasmfw: Disassembler Framework V0.35
Loaded: binary file "mdosov1.sy"
Loaded: Info file "mdosov1.info"

;****************************************************
; Used Labels
;****************************************************

M0000   EQU     $0000
M0024   EQU     $0024
M0033   EQU     $0033
ENDOSs  EQU     $0106
M0107   EQU     $0107
ENDUSs  EQU     $0108
M0109   EQU     $0109
ENDSYs  EQU     $010A
M010B   EQU     $010B
GDBAs   EQU     $0112
SYIOCB  EQU     $0120
Z0358   EQU     $0358
Z0359   EQU     $0359
Z04CE   EQU     $04CE
Z11F2   EQU     $11F2
Z188B   EQU     $188B
M1892   EQU     $1892
IOCBTMP EQU     $1894
M1896   EQU     $1896
M1897   EQU     $1897
M1898   EQU     $1898
M1899   EQU     $1899
M189A   EQU     $189A
M189B   EQU     $189B
M189C   EQU     $189C
Z1F65   EQU     $1F65
Z1FFD   EQU     $1FFD
M444B   EQU     $444B
MC603   EQU     $C603
MC605   EQU     $C605
MC608   EQU     $C608
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
OUTCNSF EQU     $F9CF
ACIA_0  EQU     $FCF4
ACIA_1  EQU     $FCF5
PROM_1  EQU     $FCFD
RAMBGN  EQU     $FF00
MFF02   EQU     $FF02
MFF62   EQU     $FF62

;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $1273

                JSR     Z11F2                    ; 1273: BD 11 F2       
                JSR     Z11F2                    ; 1276: BD 11 F2       
PFNAM1          JMP     PFNAM2                   ; 1279: 7E 12 B7       
ALUSM1          JMP     ALUSM2                   ; 127C: 7E 13 C1       
RESRV1          JMP     RESRV2                   ; 127F: 7E 14 12       
RELES1          JMP     RELES2                   ; 1282: 7E 14 E2       
PUTRC1          JMP     PUTRC2                   ; 1285: 7E 15 0D       
PUTFD1          JMP     PUTFD2                   ; 1288: 7E 15 07       
PUTEF1          JMP     PUTEF2                   ; 128B: 7E 15 0A       
                RTS                              ; 128E: 39             
                NOP                              ; 128F: 01             
                NOP                              ; 1290: 01             
                JMP     Z17BD                    ; 1291: 7E 17 BD       
                JMP     Z17E5                    ; 1294: 7E 17 E5       
CRCHAR1         JMP     CRCHAR2                  ; 1297: 7E 17 82       
CRON1           JMP     CRON2                    ; 129A: 7E 18 17       
CROFF1          JMP     CROFF2                   ; 129D: 7E 18 31       
CRINIT1         JMP     CRINIT2                  ; 12A0: 7E 18 4E       
CRTERM1         JMP     CRINIT2                  ; 12A3: 7E 18 4E       
CPCHAR1         JMP     CPCHAR2                  ; 12A6: 7E 17 FF       
Z12A9           TSX                              ; 12A9: 30             
                LDX     $07,X                    ; 12AA: EE 07          
                LDX     ,X                       ; 12AC: EE 00          
                LDAA    ,X                       ; 12AE: A6 00          
                RTS                              ; 12B0: 39             
Z12B1           TSX                              ; 12B1: 30             
                ORAB    $05,X                    ; 12B2: EA 05          
                STAB    $05,X                    ; 12B4: E7 05          
                RTS                              ; 12B6: 39             
PFNAM2          JSR     Z0358                    ; 12B7: BD 03 58       
                TSX                              ; 12BA: 30             
                CLR     $03,X                    ; 12BB: 6F 03          
                LDAB    #$08                     ; 12BD: C6 08          
                JSR     Z1338                    ; 12BF: BD 13 38       
                TSTB                             ; 12C2: 5D             
                BEQ     Z12D3                    ; 12C3: 27 0E          
                CMPB    #$08                     ; 12C5: C1 08          
                BEQ     Z132D                    ; 12C7: 27 64          
Z12C9           CMPA    #$2A                     ; 12C9: 81 2A          
                BNE     Z12D3                    ; 12CB: 26 06          
                LDAB    #$01                     ; 12CD: C6 01          
                BSR     Z12B1                    ; 12CF: 8D E0          
                BSR     Z12A9                    ; 12D1: 8D D6          
Z12D3           CMPA    #$2E                     ; 12D3: 81 2E          
                BNE     Z1327                    ; 12D5: 26 50          
                LDAB    #$82                     ; 12D7: C6 82          
                JSR     Z1338                    ; 12D9: BD 13 38       
                TSTB                             ; 12DC: 5D             
                BEQ     Z12E9                    ; 12DD: 27 0A          
                CMPA    #$2A                     ; 12DF: 81 2A          
                BNE     Z12E9                    ; 12E1: 26 06          
                LDAB    #$02                     ; 12E3: C6 02          
                BSR     Z12B1                    ; 12E5: 8D CA          
                BSR     Z12A9                    ; 12E7: 8D C0          
Z12E9           CMPA    #$3A                     ; 12E9: 81 3A          
                BNE     Z1306                    ; 12EB: 26 19          
                LDAA    #$0B                     ; 12ED: 86 0B          
                TSX                              ; 12EF: 30             
                LDX     $05,X                    ; 12F0: EE 05          
                INX                              ; 12F2: 08             
                INX                              ; 12F3: 08             
                SWI                              ; 12F4: 3F             
                FCB     $17                      ; 12F5: 17             
                LDAB    #$C1                     ; 12F6: C6 C1          
                JSR     Z1338                    ; 12F8: BD 13 38       
                JMP     Z1F65                    ; 12FB: 7E 1F 65       
                LDX     $05,X                    ; 12FE: EE 05          
                INX                              ; 1300: 08             
                INX                              ; 1301: 08             
                SWI                              ; 1302: 3F             
                FCB     $16                      ; 1303: 16             
                BSR     Z12A9                    ; 1304: 8D A3          
Z1306           TSX                              ; 1306: 30             
                LDAB    $03,X                    ; 1307: E6 03          
                RTS                              ; 1309: 39             
Z130A           TSX                              ; 130A: 30             
                LDX     $0A,X                    ; 130B: EE 0A          
                LDX     ,X                       ; 130D: EE 00          
                LDAA    ,X                       ; 130F: A6 00          
                CMPA    #$3B                     ; 1311: 81 3B          
                BEQ     Z1326                    ; 1313: 27 11          
                CMPA    #$0D                     ; 1315: 81 0D          
                BEQ     Z1326                    ; 1317: 27 0D          
                TSX                              ; 1319: 30             
                LDX     $0A,X                    ; 131A: EE 0A          
                INC     $01,X                    ; 131C: 6C 01          
                BNE     Z1322                    ; 131E: 26 02          
                INC     ,X                       ; 1320: 6C 00          
Z1322           LDX     ,X                       ; 1322: EE 00          
                LDAA    ,X                       ; 1324: A6 00          
Z1326           RTS                              ; 1326: 39             
Z1327           LDAB    #$02                     ; 1327: C6 02          
                BSR     Z13A0                    ; 1329: 8D 75          
                BRA     Z12E9                    ; 132B: 20 BC          
Z132D           CMPA    #$23                     ; 132D: 81 23          
                BEQ     Z13AB                    ; 132F: 27 7A          
                LDAB    #$80                     ; 1331: C6 80          
                JSR     Z12B1                    ; 1333: BD 12 B1       
                BRA     Z12C9                    ; 1336: 20 91          
Z1338           TBA                              ; 1338: 17             
                ANDA    #$3F                     ; 1339: 84 3F          
                PSHA                             ; 133B: 36             
Z133C           JSR     Z130A                    ; 133C: BD 13 0A       
                BITB    #$80                     ; 133F: C5 80          
                BNE     Z1347                    ; 1341: 26 04          
                CMPA    #$20                     ; 1343: 81 20          
                BEQ     Z133C                    ; 1345: 27 F5          
Z1347           BITB    #$40                     ; 1347: C5 40          
                BEQ     Z1351                    ; 1349: 27 06          
                SWI                              ; 134B: 3F             
                FCB     $15                      ; 134C: 15             
                BCC     Z136D                    ; 134D: 24 1E          
                BRA     Z1391                    ; 134F: 20 40          
Z1351           SWI                              ; 1351: 3F             
                FCB     $14                      ; 1352: 14             
                BCS     Z1371                    ; 1353: 25 1C          
Z1355           ANDB    #$3F                     ; 1355: C4 3F          
                TSX                              ; 1357: 30             
                LDX     $08,X                    ; 1358: EE 08          
                LDX     $02,X                    ; 135A: EE 02          
                TSTB                             ; 135C: 5D             
                BEQ     Z1367                    ; 135D: 27 08          
                STAA    ,X                       ; 135F: A7 00          
                DECB                             ; 1361: 5A             
                TSX                              ; 1362: 30             
                INX                              ; 1363: 08             
                JSR     Z0359                    ; 1364: BD 03 59       
Z1367           BSR     Z130A                    ; 1367: 8D A1          
                SWI                              ; 1369: 3F             
                FCB     $15                      ; 136A: 15             
                BCS     Z1351                    ; 136B: 25 E4          
Z136D           ORAA    #$30                     ; 136D: 8A 30          
                BRA     Z1355                    ; 136F: 20 E4          
Z1371           ANDB    #$3F                     ; 1371: C4 3F          
                BEQ     Z139E                    ; 1373: 27 29          
                PSHB                             ; 1375: 37             
                PSHA                             ; 1376: 36             
                TSX                              ; 1377: 30             
                CMPB    $02,X                    ; 1378: E1 02          
                BEQ     Z1382                    ; 137A: 27 06          
                LDX     $0A,X                    ; 137C: EE 0A          
                LDX     $02,X                    ; 137E: EE 02          
                SWI                              ; 1380: 3F             
                FCB     $12                      ; 1381: 12             
Z1382           TSX                              ; 1382: 30             
                LDAA    $01,X                    ; 1383: A6 01          
                LDX     $0A,X                    ; 1385: EE 0A          
                INX                              ; 1387: 08             
                INX                              ; 1388: 08             
                SWI                              ; 1389: 3F             
                FCB     $16                      ; 138A: 16             
                PULA                             ; 138B: 32             
                PULB                             ; 138C: 33             
                CMPA    #$2A                     ; 138D: 81 2A          
                BNE     Z139E                    ; 138F: 26 0D          
Z1391           JSR     Z130A                    ; 1391: BD 13 0A       
                SWI                              ; 1394: 3F             
                FCB     $14                      ; 1395: 14             
                BCC     Z1391                    ; 1396: 24 F9          
                SWI                              ; 1398: 3F             
                FCB     $15                      ; 1399: 15             
                BCC     Z1391                    ; 139A: 24 F5          
                LDAA    #$2A                     ; 139C: 86 2A          
Z139E           INS                              ; 139E: 31             
                RTS                              ; 139F: 39             
Z13A0           TSX                              ; 13A0: 30             
                LDX     $07,X                    ; 13A1: EE 07          
                INX                              ; 13A3: 08             
                INX                              ; 13A4: 08             
                PSHA                             ; 13A5: 36             
                TBA                              ; 13A6: 17             
                SWI                              ; 13A7: 3F             
                FCB     $16                      ; 13A8: 16             
                PULA                             ; 13A9: 32             
                RTS                              ; 13AA: 39             
Z13AB           LDAB    #$04                     ; 13AB: C6 04          
                JSR     Z12B1                    ; 13AD: BD 12 B1       
                TSX                              ; 13B0: 30             
                LDX     $05,X                    ; 13B1: EE 05          
                INX                              ; 13B3: 08             
                INX                              ; 13B4: 08             
                LDAA    #$08                     ; 13B5: 86 08          
                SWI                              ; 13B7: 3F             
                FCB     $17                      ; 13B8: 17             
                LDAB    #$88                     ; 13B9: C6 88          
                JSR     Z1338                    ; 13BB: BD 13 38       
                JMP     Z1327                    ; 13BE: 7E 13 27       
ALUSM2          PSHA                             ; 13C1: 36             
                CMPB    #$01                     ; 13C2: C1 01          
                BEQ     Z13DB                    ; 13C4: 27 15          
                BLT     Z13E2                    ; 13C6: 2D 1A          
                LDX     ENDSYs                   ; 13C8: FE 01 0A       
                LDAA    M0109                    ; 13CB: B6 01 09       
                LDAB    ENDUSs                   ; 13CE: F6 01 08       
                STX     ENDUSs                   ; 13D1: FF 01 08       
                SWI                              ; 13D4: 3F             
                FCB     $2D                      ; 13D5: 2D             
                SWI                              ; 13D6: 3F             
                FCB     $26                      ; 13D7: 26             
                TSX                              ; 13D8: 30             
                BRA     Z1404                    ; 13D9: 20 29          
Z13DB           SWI                              ; 13DB: 3F             
                FCB     $26                      ; 13DC: 26             
                LDX     ENDUSs                   ; 13DD: FE 01 08       
                SWI                              ; 13E0: 3F             
                FCB     $29                      ; 13E1: 29             
Z13E2           LDAB    ENDSYs                   ; 13E2: F6 01 0A       
                LDAA    M010B                    ; 13E5: B6 01 0B       
                SWI                              ; 13E8: 3F             
                FCB     $2F                      ; 13E9: 2F             
                BCS     Z140A                    ; 13EA: 25 1E          
                LDAB    ENDOSs                   ; 13EC: F6 01 06       
                LDAA    M0107                    ; 13EF: B6 01 07       
                SWI                              ; 13F2: 3F             
                FCB     $2F                      ; 13F3: 2F             
                BCC     Z140D                    ; 13F4: 24 17          
                LDAA    M0109                    ; 13F6: B6 01 09       
                ADDA    #$01                     ; 13F9: 8B 01          
                LDAB    ENDUSs                   ; 13FB: F6 01 08       
                ADCB    #$00                     ; 13FE: C9 00          
                STX     ENDUSs                   ; 1400: FF 01 08       
                TSX                              ; 1403: 30             
Z1404           STAB    $06,X                    ; 1404: E7 06          
                STAA    $07,X                    ; 1406: A7 07          
                CLRB                             ; 1408: 5F             
                CPX     #MC603                   ; 1409: 8C C6 03       
                CPX     #MC605                   ; 140C: 8C C6 05       
                PULA                             ; 140F: 32             
                ASRB                             ; 1410: 57             
                RTS                              ; 1411: 39             
RESRV2          LDAA    $0A,X                    ; 1412: A6 0A           get LUN
                BITA    #$40                     ; 1414: 85 40           Reserved?
                BNE     Z1445                    ; 1416: 26 2D           yes
                ANDA    #$0F                     ; 1418: 84 0F          
                CMPA    #$0A                     ; 141A: 81 0A          
                BCC     Z1448                    ; 141C: 24 2A          
                LDAA    $08,X                    ; 141E: A6 08           get first char
                SWI                              ; 1420: 3F             
                FCB     $14                      ; 1421: 14              CHECK ALPHABETIC CHARACTER
                BCS     Z1448                    ; 1422: 25 24          
                TAB                              ; 1424: 16             
                LDAA    $09,X                    ; 1425: A6 09           get second char
                SWI                              ; 1427: 3F             
                FCB     $14                      ; 1428: 14              CHECK ALPHABETIC CHARACTER
                BCS     Z1448                    ; 1429: 25 1D          
                LDX     GDBAs                    ; 142B: FE 01 12       
Z142E           STX     GDBAsTMP                 ; 142E: FF 14 DD       
                LDX     ,X                       ; 1431: EE 00           get first GBD from 65c
                BEQ     Z1448                    ; 1433: 27 13          
                SWI                              ; 1435: 3F             
                FCB     $2F                      ; 1436: 2F              COMPARE B.A TO X
                BEQ     Z144B                    ; 1437: 27 12           found?
                LDX     GDBAsTMP                 ; 1439: FE 14 DD       
                INX                              ; 143C: 08             
                INX                              ; 143D: 08             
                INX                              ; 143E: 08             
                INX                              ; 143F: 08             
                BRA     Z142E                    ; 1440: 20 EC           no - continue
Z1442           JMP     Z14AD                    ; 1442: 7E 14 AD       
Z1445           JMP     Z14B0                    ; 1445: 7E 14 B0       
Z1448           JMP     Z14B3                    ; 1448: 7E 14 B3       
Z144B           LDX     GDBAsTMP                 ; 144B: FE 14 DD       
                LDX     $02,X                    ; 144E: EE 02           get start address of driver
                BEQ     Z1442                    ; 1450: 27 F0          
                STX     DRVSTART                 ; 1452: FF 14 DF       
                LDX     GDBAsTMP                 ; 1455: FE 14 DD       
                LDX     ,X                       ; 1458: EE 00          
                CPX     #M444B                   ; 145A: 8C 44 4B       
                BNE     Z1462                    ; 145D: 26 03          
                JMP     Z14B8                    ; 145F: 7E 14 B8       
Z1462           LDX     DRVSTART                 ; 1462: FE 14 DF       
                LDAA    ,X                       ; 1465: A6 00          
                DECA                             ; 1467: 4A             
                TSX                              ; 1468: 30             
                LDX     $05,X                    ; 1469: EE 05          
                LDAB    $0A,X                    ; 146B: E6 0A          
                ANDB    #$0F                     ; 146D: C4 0F          
                CBA                              ; 146F: 11             
                BCS     Z14B3                    ; 1470: 25 41          
                LDX     DRVSTART                 ; 1472: FE 14 DF       
                INX                              ; 1475: 08             
                TSTB                             ; 1476: 5D             
Z1477           BEQ     Z1480                    ; 1477: 27 07          
                LDAA    #$0C                     ; 1479: 86 0C          
                SWI                              ; 147B: 3F             
                FCB     $28                      ; 147C: 28             
                DECB                             ; 147D: 5A             
                BRA     Z1477                    ; 147E: 20 F7          
Z1480           STX     DRVSTART                 ; 1480: FF 14 DF       
                LDX     $02,X                    ; 1483: EE 02          
                BEQ     Z1442                    ; 1485: 27 BB          
                LDAA    M14E0                    ; 1487: B6 14 E0       
                LDAB    DRVSTART                 ; 148A: F6 14 DF       
                TSX                              ; 148D: 30             
                LDX     $05,X                    ; 148E: EE 05          
                STAA    $09,X                    ; 1490: A7 09          
                STAB    $08,X                    ; 1492: E7 08          
                LDAA    $0A,X                    ; 1494: A6 0A          
                ORAA    #$40                     ; 1496: 8A 40          
                STAA    $0A,X                    ; 1498: A7 0A          
                LDAA    $01,X                    ; 149A: A6 01          
                ANDA    #$3F                     ; 149C: 84 3F          
                ORAA    #$10                     ; 149E: 8A 10          
                STAA    $01,X                    ; 14A0: A7 01          
                CLC                              ; 14A2: 0C             
                LDAB    #$00                     ; 14A3: C6 00          
Z14A5           TSX                              ; 14A5: 30             
                LDAA    $04,X                    ; 14A6: A6 04          
                LDX     $05,X                    ; 14A8: EE 05          
                STAB    ,X                       ; 14AA: E7 00          
                RTS                              ; 14AC: 39             
Z14AD           LDAB    #$05                     ; 14AD: C6 05          
                FCB     $8C                      ; 14AF: 8C             
Z14B0           LDAB    #$02                     ; 14B0: C6 02          
                FCB     $8C                      ; 14B2: 8C             
Z14B3           LDAB    #$01                     ; 14B3: C6 01          
                SEC                              ; 14B5: 0D             
                BRA     Z14A5                    ; 14B6: 20 ED          
Z14B8           TSX                              ; 14B8: 30             
                LDX     $05,X                    ; 14B9: EE 05          
                LDAB    $0A,X                    ; 14BB: E6 0A          
                ANDB    #$0F                     ; 14BD: C4 0F          
                LDX     DRVSTART                 ; 14BF: FE 14 DF       
                LDAA    ,X                       ; 14C2: A6 00          
                STAA    M14E1                    ; 14C4: B7 14 E1       
                INX                              ; 14C7: 08             
Z14C8           LDAA    $09,X                    ; 14C8: A6 09          
                CBA                              ; 14CA: 11             
                BCC     Z14DA                    ; 14CB: 24 0D          
                SUBB    $09,X                    ; 14CD: E0 09          
                LDAA    #$0C                     ; 14CF: 86 0C          
                SWI                              ; 14D1: 3F             
                FCB     $28                      ; 14D2: 28             
                DEC     M14E1                    ; 14D3: 7A 14 E1       
                BNE     Z14C8                    ; 14D6: 26 F0          
                BRA     Z14B3                    ; 14D8: 20 D9          
Z14DA           JMP     Z1480                    ; 14DA: 7E 14 80       
GDBAsTMP        FCB     $00                      ; 14DD: 00             
                FCB     $00                      ; 14DE: 00             
DRVSTART        FCB     $00                      ; 14DF: 00             
M14E0           FCB     $00                      ; 14E0: 00             
M14E1           FCB     $00                      ; 14E1: 00             
RELES2          PSHA                             ; 14E2: 36             
                LDAA    $0A,X                    ; 14E3: A6 0A          
                BITA    #$40                     ; 14E5: 85 40          
                BEQ     Z14FD                    ; 14E7: 27 14          
                LDAA    $01,X                    ; 14E9: A6 01          
                BITA    #$10                     ; 14EB: 85 10          
                BEQ     Z1500                    ; 14ED: 27 11          
                LDAA    $0A,X                    ; 14EF: A6 0A          
                ANDA    #$BF                     ; 14F1: 84 BF          
                STAA    $0A,X                    ; 14F3: A7 0A          
                CLR     $08,X                    ; 14F5: 6F 08          
                CLR     $09,X                    ; 14F7: 6F 09          
                LDAB    #$00                     ; 14F9: C6 00          
                BRA     Z1503                    ; 14FB: 20 06          
Z14FD           LDAB    #$03                     ; 14FD: C6 03          
                CPX     #MC608                   ; 14FF: 8C C6 08       
                SEC                              ; 1502: 0D             
Z1503           PULA                             ; 1503: 32             
                STAB    ,X                       ; 1504: E7 00          
                RTS                              ; 1506: 39             
PUTFD2          LDAB    #$00                     ; 1507: C6 00          
                FCB     $8C                      ; 1509: 8C             
PUTEF2          LDAB    #$FF                     ; 150A: C6 FF          
                FCB     $8C                      ; 150C: 8C             
PUTRC2          LDAB    #$01                     ; 150D: C6 01          
                STX     IOCBTMP                  ; 150F: FF 18 94       
                STAB    M1896                    ; 1512: F7 18 96       
                LDAA    $01,X                    ; 1515: A6 01           load IOCDTT
                BITA    #$10                     ; 1517: 85 10           check file open
                BEQ     Z151E                    ; 1519: 27 03           yes
                JMP     Z175A                    ; 151B: 7E 17 5A        no
Z151E           BITA    #$20                     ; 151E: 85 20           check sector/record
                BEQ     Z1525                    ; 1520: 27 03           Record IO
                JMP     Z175D                    ; 1522: 7E 17 5D        Sector IO
Z1525           ANDA    #$03                     ; 1525: 84 03          
                CMPA    #$01                     ; 1527: 81 01           check Mode Flags
                BNE     Z152E                    ; 1529: 26 03          
                JMP     Z175D                    ; 152B: 7E 17 5D       
Z152E           CLR     M1899                    ; 152E: 7F 18 99       
                INC     M1899                    ; 1531: 7C 18 99       
                LDAA    $17,X                    ; 1534: A6 17          
                ANDA    #$07                     ; 1536: 84 07          
                STAA    M1897                    ; 1538: B7 18 97       
                CMPA    #$03                     ; 153B: 81 03          
                BEQ     Z1553                    ; 153D: 27 14          
                CMPA    #$07                     ; 153F: 81 07          
                BEQ     Z1553                    ; 1541: 27 10          
                CMPA    #$05                     ; 1543: 81 05          
                BEQ     Z154A                    ; 1545: 27 03          
                JMP     Z1760                    ; 1547: 7E 17 60       
Z154A           LDAA    $17,X                    ; 154A: A6 17          
                BITA    #$08                     ; 154C: 85 08          
                BNE     Z1553                    ; 154E: 26 03          
                CLR     M1899                    ; 1550: 7F 18 99       
Z1553           LDAB    $04,X                    ; 1553: E6 04          
                LDAA    $05,X                    ; 1555: A6 05          
                STAA    $03,X                    ; 1557: A7 03          
                STAB    $02,X                    ; 1559: E7 02          
                LDX     $08,X                    ; 155B: EE 08          
                CLR     M189C                    ; 155D: 7F 18 9C       
                LDAA    $06,X                    ; 1560: A6 06          
                BITA    #$02                     ; 1562: 85 02          
                BEQ     Z1580                    ; 1564: 27 1A          
                INC     M189C                    ; 1566: 7C 18 9C       
                LDX     IOCBTMP                  ; 1569: FE 18 94       
                LDAB    $0B,X                    ; 156C: E6 0B          
                LDAA    $0C,X                    ; 156E: A6 0C          
                CMPB    #$FF                     ; 1570: C1 FF          
                BNE     Z157C                    ; 1572: 26 08          
                CMPA    #$FF                     ; 1574: 81 FF          
                BNE     Z157C                    ; 1576: 26 04          
                CLR     $0B,X                    ; 1578: 6F 0B          
                CLR     $0C,X                    ; 157A: 6F 0C          
Z157C           LDX     $08,X                    ; 157C: EE 08          
                BRA     Z1587                    ; 157E: 20 07          
Z1580           BITA    #$04                     ; 1580: 85 04          
                BEQ     Z1587                    ; 1582: 27 03          
                COM     M189C                    ; 1584: 73 18 9C       
Z1587           LDX     $02,X                    ; 1587: EE 02          
                STX     M1892                    ; 1589: FF 18 92       
                JSR     ,X                       ; 158C: AD 00          
                FCB     $18                      ; 158E: 18             
                ANDA    M0024                    ; 158F: 94 24          
                FCB     $03                      ; 1591: 03             
                JMP     Z1763                    ; 1592: 7E 17 63       
                LDX     IOCBTMP                  ; 1595: FE 18 94       
                LDAA    $01,X                    ; 1598: A6 01          
                ANDA    #$3F                     ; 159A: 84 3F          
                ORAA    #$40                     ; 159C: 8A 40          
                STAA    $01,X                    ; 159E: A7 01          
                TST     M1896                    ; 15A0: 7D 18 96       
                BNE     Z15A8                    ; 15A3: 26 03          
                JMP     Z16B6                    ; 15A5: 7E 16 B6       
Z15A8           LDAA    M1897                    ; 15A8: B6 18 97       
                CMPA    #$05                     ; 15AB: 81 05          
                BEQ     Z15B2                    ; 15AD: 27 03          
                JMP     Z16B6                    ; 15AF: 7E 16 B6       
Z15B2           CLR     M189B                    ; 15B2: 7F 18 9B       
Z15B5           TST     M1896                    ; 15B5: 7D 18 96       
                BPL     Z15BD                    ; 15B8: 2A 03          
                JMP     Z1639                    ; 15BA: 7E 16 39       
Z15BD           CLR     M1898                    ; 15BD: 7F 18 98       
Z15C0           LDX     IOCBTMP                  ; 15C0: FE 18 94       
                LDAA    $07,X                    ; 15C3: A6 07          
                LDAB    $06,X                    ; 15C5: E6 06          
                LDX     $02,X                    ; 15C7: EE 02          
                JSR     Z04CE                    ; 15C9: BD 04 CE       
                BCS     Z1646                    ; 15CC: 25 78          
                LDAB    ,X                       ; 15CE: E6 00          
                LDX     IOCBTMP                  ; 15D0: FE 18 94       
                INC     $03,X                    ; 15D3: 6C 03          
                BNE     Z15D9                    ; 15D5: 26 02          
                INC     $02,X                    ; 15D7: 6C 02          
Z15D9           LDAA    M1897                    ; 15D9: B6 18 97       
                CMPA    #$05                     ; 15DC: 81 05          
                BNE     Z15E4                    ; 15DE: 26 04          
                CMPB    #$04                     ; 15E0: C1 04          
                BEQ     Z15C0                    ; 15E2: 27 DC          
Z15E4           CMPB    #$20                     ; 15E4: C1 20          
                BNE     Z1601                    ; 15E6: 26 19          
                TST     M189C                    ; 15E8: 7D 18 9C       
                BLE     Z1612                    ; 15EB: 2F 25          
                TST     M1899                    ; 15ED: 7D 18 99       
                BNE     Z1612                    ; 15F0: 26 20          
                INC     M1898                    ; 15F2: 7C 18 98       
                LDAA    #$7F                     ; 15F5: 86 7F          
                CMPA    M1898                    ; 15F7: B1 18 98       
                BNE     Z15C0                    ; 15FA: 26 C4          
                JSR     Z1747                    ; 15FC: BD 17 47       
                BRA     Z1631                    ; 15FF: 20 30          
Z1601           TST     M1899                    ; 1601: 7D 18 99       
                BNE     Z1612                    ; 1604: 26 0C          
                TST     M1898                    ; 1606: 7D 18 98       
                BEQ     Z1612                    ; 1609: 27 07          
                PSHB                             ; 160B: 37             
                JSR     Z1747                    ; 160C: BD 17 47       
                PULB                             ; 160F: 33             
                BCS     Z1633                    ; 1610: 25 21          
Z1612           LDAA    M1897                    ; 1612: B6 18 97       
                CMPA    #$05                     ; 1615: 81 05          
                BNE     Z1627                    ; 1617: 26 0E          
                LDAA    M1896                    ; 1619: B6 18 96       
                BEQ     Z1627                    ; 161C: 27 09          
                CMPB    #$0D                     ; 161E: C1 0D          
                BNE     Z162E                    ; 1620: 26 0C          
                JSR     Z169A                    ; 1622: BD 16 9A       
                BRA     Z1631                    ; 1625: 20 0A          
Z1627           LDAA    M189A                    ; 1627: B6 18 9A       
                ABA                              ; 162A: 1B             
                STAA    M189A                    ; 162B: B7 18 9A       
Z162E           JSR     Z171C                    ; 162E: BD 17 1C       
Z1631           BCC     Z1636                    ; 1631: 24 03          
Z1633           JMP     Z1754                    ; 1633: 7E 17 54       
Z1636           JMP     Z15C0                    ; 1636: 7E 15 C0       
Z1639           CLR     M189B                    ; 1639: 7F 18 9B       
                LDAB    #$1A                     ; 163C: C6 1A          
                JSR     Z171C                    ; 163E: BD 17 1C       
                BCC     Z1679                    ; 1641: 24 36          
                JMP     Z1754                    ; 1643: 7E 17 54       
Z1646           LDAA    M1897                    ; 1646: B6 18 97       
                CMPA    #$05                     ; 1649: 81 05          
                BNE     Z1672                    ; 164B: 26 25          
                TST     M1896                    ; 164D: 7D 18 96       
                BEQ     Z1672                    ; 1650: 27 20          
                LDX     IOCBTMP                  ; 1652: FE 18 94       
                LDX     $06,X                    ; 1655: EE 06          
                LDAB    ,X                       ; 1657: E6 00          
                CMPB    #$0D                     ; 1659: C1 0D          
                BEQ     Z167E                    ; 165B: 27 21          
                TST     M189C                    ; 165D: 7D 18 9C       
                BGE     Z1679                    ; 1660: 2C 17          
                LDX     IOCBTMP                  ; 1662: FE 18 94       
                CPX     #SYIOCB                  ; 1665: 8C 01 20       
                BNE     Z1679                    ; 1668: 26 0F          
                LDAB    $0A,X                    ; 166A: E6 0A          
                BITB    #$20                     ; 166C: C5 20          
                BEQ     Z167E                    ; 166E: 27 0E          
                BRA     Z1679                    ; 1670: 20 07          
Z1672           BSR     Z1681                    ; 1672: 8D 0D          
                BCC     Z1679                    ; 1674: 24 03          
Z1676           JMP     Z1754                    ; 1676: 7E 17 54       
Z1679           JSR     Z169A                    ; 1679: BD 16 9A       
                BCS     Z1676                    ; 167C: 25 F8          
Z167E           JMP     Z1769                    ; 167E: 7E 17 69       
Z1681           TST     M1896                    ; 1681: 7D 18 96       
                BNE     Z168B                    ; 1684: 26 05          
Z1686           INC     M189B                    ; 1686: 7C 18 9B       
                BRA     Z1692                    ; 1689: 20 07          
Z168B           LDAA    M1897                    ; 168B: B6 18 97       
                CMPA    #$03                     ; 168E: 81 03          
                BNE     Z1686                    ; 1690: 26 F4          
Z1692           LDAB    M189A                    ; 1692: F6 18 9A       
                NEGB                             ; 1695: 50             
                JSR     Z171C                    ; 1696: BD 17 1C       
                RTS                              ; 1699: 39             
Z169A           CLR     M189B                    ; 169A: 7F 18 9B       
                LDAB    #$0D                     ; 169D: C6 0D          
                JSR     Z171C                    ; 169F: BD 17 1C       
                BCS     Z16B5                    ; 16A2: 25 11          
                TST     M189C                    ; 16A4: 7D 18 9C       
                BGT     Z16B5                    ; 16A7: 2E 0C          
                LDAB    #$0A                     ; 16A9: C6 0A          
                JSR     Z171C                    ; 16AB: BD 17 1C       
                BCS     Z16B5                    ; 16AE: 25 05          
                LDAB    #$00                     ; 16B0: C6 00          
                JSR     Z171C                    ; 16B2: BD 17 1C       
Z16B5           RTS                              ; 16B5: 39             
Z16B6           LDAB    #$45                     ; 16B6: C6 45          
                TST     M1896                    ; 16B8: 7D 18 96       
                BMI     Z16C6                    ; 16BB: 2B 09          
                LDAB    #$48                     ; 16BD: C6 48          
                TST     M1896                    ; 16BF: 7D 18 96       
                BEQ     Z16C6                    ; 16C2: 27 02          
                LDAB    #$44                     ; 16C4: C6 44          
Z16C6           CLR     M189B                    ; 16C6: 7F 18 9B       
                JSR     Z171C                    ; 16C9: BD 17 1C       
                BCC     Z16D1                    ; 16CC: 24 03          
                JMP     Z1754                    ; 16CE: 7E 17 54       
Z16D1           CLR     M189A                    ; 16D1: 7F 18 9A       
                CLRA                             ; 16D4: 4F             
                TST     M1896                    ; 16D5: 7D 18 96       
                BMI     Z16F0                    ; 16D8: 2B 16          
                LDX     IOCBTMP                  ; 16DA: FE 18 94       
                LDAB    $06,X                    ; 16DD: E6 06          
                LDAA    $07,X                    ; 16DF: A6 07          
                LDX     $04,X                    ; 16E1: EE 04          
                DEX                              ; 16E3: 09             
                SWI                              ; 16E4: 3F             
                FCB     $2E                      ; 16E5: 2E             
                TSTB                             ; 16E6: 5D             
                BEQ     Z16EC                    ; 16E7: 27 03          
Z16E9           JMP     Z1766                    ; 16E9: 7E 17 66       
Z16EC           CMPA    #$FF                     ; 16EC: 81 FF          
                BCC     Z16E9                    ; 16EE: 24 F9          
Z16F0           INCA                             ; 16F0: 4C             
                TAB                              ; 16F1: 16             
                ADDA    M189A                    ; 16F2: BB 18 9A       
                STAA    M189A                    ; 16F5: B7 18 9A       
                CLR     M189B                    ; 16F8: 7F 18 9B       
                TST     M1896                    ; 16FB: 7D 18 96       
                BNE     Z1705                    ; 16FE: 26 05          
Z1700           INC     M189B                    ; 1700: 7C 18 9B       
                BRA     Z170C                    ; 1703: 20 07          
Z1705           LDAA    M1897                    ; 1705: B6 18 97       
                CMPA    #$07                     ; 1708: 81 07          
                BEQ     Z1700                    ; 170A: 27 F4          
Z170C           JSR     Z171C                    ; 170C: BD 17 1C       
                BCS     Z1754                    ; 170F: 25 43          
                TST     M1896                    ; 1711: 7D 18 96       
                BPL     Z1719                    ; 1714: 2A 03          
                JMP     Z1672                    ; 1716: 7E 16 72       
Z1719           JMP     Z15B5                    ; 1719: 7E 15 B5       
Z171C           TST     M189B                    ; 171C: 7D 18 9B       
                BEQ     Z1737                    ; 171F: 27 16          
                PSHB                             ; 1721: 37             
                ANDB    #$F0                     ; 1722: C4 F0          
                LSRB                             ; 1724: 54             
                LSRB                             ; 1725: 54             
                LSRB                             ; 1726: 54             
                LSRB                             ; 1727: 54             
                BSR     Z173E                    ; 1728: 8D 14          
                LDX     M1892                    ; 172A: FE 18 92       
                JSR     Z188B                    ; 172D: BD 18 8B       
                PULB                             ; 1730: 33             
                BCS     Z173D                    ; 1731: 25 0A          
                ANDB    #$0F                     ; 1733: C4 0F          
                BSR     Z173E                    ; 1735: 8D 07          
Z1737           LDX     M1892                    ; 1737: FE 18 92       
                JSR     Z188B                    ; 173A: BD 18 8B       
Z173D           RTS                              ; 173D: 39             
Z173E           ORAB    #$30                     ; 173E: CA 30          
                CMPB    #$3A                     ; 1740: C1 3A          
                BCS     Z1746                    ; 1742: 25 02          
                ADDB    #$07                     ; 1744: CB 07          
Z1746           RTS                              ; 1746: 39             
Z1747           LDAB    M1898                    ; 1747: F6 18 98       
                CLR     M1898                    ; 174A: 7F 18 98       
                ORAB    #$80                     ; 174D: CA 80          
                CLR     M189B                    ; 174F: 7F 18 9B       
                BRA     Z171C                    ; 1752: 20 C8          
Z1754           LDX     IOCBTMP                  ; 1754: FE 18 94       
                LDAB    ,X                       ; 1757: E6 00          
                FCB     $8C                      ; 1759: 8C             
Z175A           LDAB    #$08                     ; 175A: C6 08           file open
                FCB     $8C                      ; 175C: 8C             
Z175D           LDAB    #$0B                     ; 175D: C6 0B          
                FCB     $8C                      ; 175F: 8C             
Z1760           LDAB    #$0A                     ; 1760: C6 0A          
                FCB     $8C                      ; 1762: 8C             
Z1763           LDAB    #$04                     ; 1763: C6 04          
                FCB     $8C                      ; 1765: 8C             
Z1766           LDAB    #$18                     ; 1766: C6 18          
                FCB     $8C                      ; 1768: 8C             
Z1769           LDAB    #$00                     ; 1769: C6 00          
                CMPB    #$08                     ; 176B: C1 08          
                BEQ     Z1778                    ; 176D: 27 09          
                PSHB                             ; 176F: 37             
                LDX     M1892                    ; 1770: FE 18 92       
                JSR     $03,X                    ; 1773: AD 03          
                FCB     $18                      ; 1775: 18             
                ANDA    M0033                    ; 1776: 94 33          
Z1778           LDX     IOCBTMP                  ; 1778: FE 18 94        file open
                STAB    ,X                       ; 177B: E7 00           set error flag
                TSTB                             ; 177D: 5D             
                BEQ     Z1781                    ; 177E: 27 01          
                SEC                              ; 1780: 0D             
Z1781           RTS                              ; 1781: 39             
CRCHAR2         DEC     M17FE                    ; 1782: 7A 17 FE       
                BNE     Z1797                    ; 1785: 26 10          
                TST     MFF02                    ; 1787: 7D FF 02       
                BPL     Z1797                    ; 178A: 2A 0B          
                LDAA    #$56                     ; 178C: 86 56          
                STAA    M17FE                    ; 178E: B7 17 FE       
                BSR     Z17E0                    ; 1791: 8D 4D          
                LDAA    #$37                     ; 1793: 86 37          
                BSR     Z17E2                    ; 1795: 8D 4B          
Z1797           BSR     Z17A8                    ; 1797: 8D 0F          
                BCC     Z17D9                    ; 1799: 24 3E          
                TSX                              ; 179B: 30             
                LDX     ,X                       ; 179C: EE 00          
                LDX     ,X                       ; 179E: EE 00          
                LDX     ,X                       ; 17A0: EE 00          
                LDAA    #$0C                     ; 17A2: 86 0C          
                STAA    ,X                       ; 17A4: A7 00          
                BRA     Z17D9                    ; 17A6: 20 31          
Z17A8           LDX     #RAMBGN                  ; 17A8: CE FF 00       
Z17AB           DEX                              ; 17AB: 09             
                BEQ     Z17BB                    ; 17AC: 27 0D          
                LDAA    ACIA_0                   ; 17AE: B6 FC F4       
                ASRA                             ; 17B1: 47             
                BCC     Z17AB                    ; 17B2: 24 F7          
                LDAB    ACIA_1                   ; 17B4: F6 FC F5       
                ANDB    #$7F                     ; 17B7: C4 7F          
                CLC                              ; 17B9: 0C             
                RTS                              ; 17BA: 39             
Z17BB           SEC                              ; 17BB: 0D             
                RTS                              ; 17BC: 39             
Z17BD           LDAA    #$57                     ; 17BD: 86 57          
                STAA    M17FE                    ; 17BF: B7 17 FE       
                TST     MFF02                    ; 17C2: 7D FF 02       
                BPL     Z17CD                    ; 17C5: 2A 06          
                BSR     Z17E0                    ; 17C7: 8D 17          
                LDAA    #$37                     ; 17C9: 86 37          
                BRA     Z17D7                    ; 17CB: 20 0A          
Z17CD           LDAA    PROM_1                   ; 17CD: B6 FC FD       
                ANDA    #$5F                     ; 17D0: 84 5F          
                STAA    ACIA_0                   ; 17D2: B7 FC F4       
                LDAA    #$11                     ; 17D5: 86 11          
Z17D7           BSR     Z17E2                    ; 17D7: 8D 09          
Z17D9           TSX                              ; 17D9: 30             
                LDX     ,X                       ; 17DA: EE 00          
                INS                              ; 17DC: 31             
                INS                              ; 17DD: 31             
                JMP     $02,X                    ; 17DE: 6E 02          
Z17E0           LDAA    #$10                     ; 17E0: 86 10          
Z17E2           JMP     OUTCNSF                  ; 17E2: 7E F9 CF       
Z17E5           LDAA    PROM_1                   ; 17E5: B6 FC FD       
                ANDA    #$3F                     ; 17E8: 84 3F          
                STAA    ACIA_0                   ; 17EA: B7 FC F4       
                LDAA    #$13                     ; 17ED: 86 13          
                JSR     XOUTCH                   ; 17EF: BD F0 18       
                TST     MFF02                    ; 17F2: 7D FF 02       
                BNE     Z17FC                    ; 17F5: 26 05          
                BSR     Z17A8                    ; 17F7: 8D AF          
                BSR     Z17A8                    ; 17F9: 8D AD          
                CLC                              ; 17FB: 0C             
Z17FC           BRA     Z17D9                    ; 17FC: 20 DB          
M17FE           ASRB                             ; 17FE: 57             
CPCHAR2         BSR     Z1807                    ; 17FF: 8D 06          
                TBA                              ; 1801: 17             
                JSR     XOUTCH                   ; 1802: BD F0 18       
                BRA     Z17D9                    ; 1805: 20 D2          
Z1807           CMPB    #$0D                     ; 1807: C1 0D          
                BNE     Z1816                    ; 1809: 26 0B          
                TST     MFF02                    ; 180B: 7D FF 02       
                BPL     Z1816                    ; 180E: 2A 06          
                LDX     #M0000                   ; 1810: CE 00 00       
Z1813           DEX                              ; 1813: 09             
                BNE     Z1813                    ; 1814: 26 FD          
Z1816           RTS                              ; 1816: 39             
CRON2           BSR     Z181B                    ; 1817: 8D 02          
                BRA     Z17D9                    ; 1819: 20 BE          
Z181B           INC     MFF62                    ; 181B: 7C FF 62       
                TST     MFF02                    ; 181E: 7D FF 02       
                BPL     Z1829                    ; 1821: 2A 06          
                BSR     Z17E0                    ; 1823: 8D BB          
                LDAA    #$30                     ; 1825: 86 30          
                BSR     Z17E2                    ; 1827: 8D B9          
Z1829           LDAA    #$7F                     ; 1829: 86 7F          
                BSR     Z17E2                    ; 182B: 8D B5          
                LDAA    #$12                     ; 182D: 86 12          
                BRA     Z17E2                    ; 182F: 20 B1          
CROFF2          LDAA    #$14                     ; 1831: 86 14          
                BSR     Z17E2                    ; 1833: 8D AD          
                CLR     MFF62                    ; 1835: 7F FF 62       
                TST     MFF02                    ; 1838: 7D FF 02       
                BPL     Z17D9                    ; 183B: 2A 9C          
                BSR     Z17E0                    ; 183D: 8D A1          
                LDAA    #$39                     ; 183F: 86 39          
                JSR     XOUTCH                   ; 1841: BD F0 18       
                LDAB    #$06                     ; 1844: C6 06          
                CLRA                             ; 1846: 4F             
Z1847           BSR     Z17E2                    ; 1847: 8D 99          
                DECB                             ; 1849: 5A             
                BNE     Z1847                    ; 184A: 26 FB          
                BRA     Z17D9                    ; 184C: 20 8B          
CRINIT2         BSR     Z181B                    ; 184E: 8D CB          
                LDAB    #$32                     ; 1850: C6 32          
                CLRA                             ; 1852: 4F             
Z1853           BSR     Z17E2                    ; 1853: 8D 8D          
                DECB                             ; 1855: 5A             
                BNE     Z1853                    ; 1856: 26 FB          
                LDAA    #$0D                     ; 1858: 86 0D          
                JSR     XOUTCH                   ; 185A: BD F0 18       
                TAB                              ; 185D: 16             
                BSR     Z1807                    ; 185E: 8D A7          
                BRA     CROFF2                   ; 1860: 20 CF          
                FCB     $00                      ; 1862: 00             


                END
