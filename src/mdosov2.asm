dasmfw: Disassembler Framework V0.35
Loaded: binary file "mdosov2.sy"
Loaded: Info file "mdosov2.info"

;****************************************************
; Used Labels
;****************************************************

M00E6   EQU     $00E6
Z0467   EQU     $0467
Z04CE   EQU     $04CE
Z11FC   EQU     $11FC
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
RAMBGN  EQU     $FF00

;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $189D

                JMP     Z18B0                    ; 189D: 7E 18 B0       
                JMP     Z18AC                    ; 18A0: 7E 18 AC       
                JSR     Z11FC                    ; 18A3: BD 11 FC       
                JSR     Z11FC                    ; 18A6: BD 11 FC       
                JSR     Z11FC                    ; 18A9: BD 11 FC       
Z18AC           LDAB    #$01                     ; 18AC: C6 01          
                BRA     Z18B1                    ; 18AE: 20 01          
Z18B0           CLRB                             ; 18B0: 5F             
Z18B1           STAB    M1BE7                    ; 18B1: F7 1B E7       
                STX     M1BE5                    ; 18B4: FF 1B E5       
                LDX     $08,X                    ; 18B7: EE 08          
                STX     M1BE3                    ; 18B9: FF 1B E3       
                LDX     M1BE5                    ; 18BC: FE 1B E5       
                LDAB    #$10                     ; 18BF: C6 10          
                BITB    $01,X                    ; 18C1: E5 01          
                BEQ     Z18C8                    ; 18C3: 27 03          
                JMP     Z1ACD                    ; 18C5: 7E 1A CD       
Z18C8           LDAA    #$03                     ; 18C8: 86 03          
                ANDA    $01,X                    ; 18CA: A4 01          
                CMPA    #$02                     ; 18CC: 81 02          
                BNE     Z18D3                    ; 18CE: 26 03          
Z18D0           JMP     Z1AD1                    ; 18D0: 7E 1A D1       
Z18D3           LDAA    #$20                     ; 18D3: 86 20          
                BITA    $01,X                    ; 18D5: A5 01          
                BNE     Z18D0                    ; 18D7: 26 F7          
                JSR     Z1B06                    ; 18D9: BD 1B 06       
                BCC     Z18E1                    ; 18DC: 24 03          
                JMP     Z1ADC                    ; 18DE: 7E 1A DC       
Z18E1           CLR     M1BE8                    ; 18E1: 7F 1B E8       
                CLR     M1BEE                    ; 18E4: 7F 1B EE       
                LDX     M1BE5                    ; 18E7: FE 1B E5       
                LDAB    $04,X                    ; 18EA: E6 04          
                LDAA    $05,X                    ; 18EC: A6 05          
                STAB    $02,X                    ; 18EE: E7 02          
                STAA    $03,X                    ; 18F0: A7 03          
                TST     M1BE7                    ; 18F2: 7D 1B E7       
                BNE     Z190A                    ; 18F5: 26 13          
                LDAA    #$07                     ; 18F7: 86 07          
                ANDA    $17,X                    ; 18F9: A4 17          
                CMPA    #$05                     ; 18FB: 81 05          
                BEQ     Z190D                    ; 18FD: 27 0E          
                CMPA    #$03                     ; 18FF: 81 03          
                BEQ     Z190A                    ; 1901: 27 07          
                CMPA    #$07                     ; 1903: 81 07          
                BEQ     Z190A                    ; 1905: 27 03          
                JMP     Z1AD8                    ; 1907: 7E 1A D8       
Z190A           JMP     Z1A1B                    ; 190A: 7E 1A 1B       
Z190D           CLR     M1BEA                    ; 190D: 7F 1B EA       
                LDX     M1BE3                    ; 1910: FE 1B E3       
                LDAA    #$04                     ; 1913: 86 04          
                CLR     M1BE9                    ; 1915: 7F 1B E9       
                BITA    $06,X                    ; 1918: A5 06          
                BEQ     Z1934                    ; 191A: 27 18          
                INC     M1BE9                    ; 191C: 7C 1B E9       
                LDX     M1BE5                    ; 191F: FE 1B E5       
                LDAB    $13,X                    ; 1922: E6 13          
                CMPB    #$20                     ; 1924: C1 20          
                BLT     Z1934                    ; 1926: 2D 0C          
                CMPB    #$5A                     ; 1928: C1 5A          
                BGT     Z1934                    ; 192A: 2E 08          
Z192C           JSR     Z1B10                    ; 192C: BD 1B 10       
                BCC     Z1934                    ; 192F: 24 03          
                JMP     Z1ADC                    ; 1931: 7E 1A DC       
Z1934           JSR     Z1BA8                    ; 1934: BD 1B A8       
                BCS     Z193C                    ; 1937: 25 03          
                CLRB                             ; 1939: 5F             
                BRA     Z193E                    ; 193A: 20 02          
Z193C           LDAB    #$01                     ; 193C: C6 01          
Z193E           STAB    M1BEB                    ; 193E: F7 1B EB       
                JSR     Z1B25                    ; 1941: BD 1B 25       
                BCC     Z1949                    ; 1944: 24 03          
                JMP     Z1ADC                    ; 1946: 7E 1A DC       
Z1949           TST     M1BE9                    ; 1949: 7D 1B E9       
                BEQ     Z19A8                    ; 194C: 27 5A          
                CMPB    #$08                     ; 194E: C1 08          
                BEQ     Z195B                    ; 1950: 27 09          
                CMPB    #$7F                     ; 1952: C1 7F          
                BNE     Z1972                    ; 1954: 26 1C          
                LDAB    #$08                     ; 1956: C6 08          
                JSR     Z1B10                    ; 1958: BD 1B 10       
Z195B           JSR     Z1B9C                    ; 195B: BD 1B 9C       
                BEQ     Z190D                    ; 195E: 27 AD          
                SWI                              ; 1960: 3F             
                BCS     Z196C                    ; 1961: 25 09          
                JSR     Z1BC9                    ; 1963: BD 1B C9       
                CLR     M1BE8                    ; 1966: 7F 1B E8       
                JSR     XPSPAC                   ; 1969: BD F0 2A       
Z196C           LDAB    #$08                     ; 196C: C6 08          
                BRA     Z192C                    ; 196E: 20 BC          
                FCB     $00                      ; 1970: 00             
                FCB     $00                      ; 1971: 00             
Z1972           CMPB    #$18                     ; 1972: C1 18          
                BNE     Z197C                    ; 1974: 26 06          
                JSR     Z1B8F                    ; 1976: BD 1B 8F       
                JMP     Z18E1                    ; 1979: 7E 18 E1       
Z197C           CMPB    #$04                     ; 197C: C1 04          
                BNE     Z19A8                    ; 197E: 26 28          
                JSR     Z1B8F                    ; 1980: BD 1B 8F       
                BCS     Z19D6                    ; 1983: 25 51          
                LDX     M1BE5                    ; 1985: FE 1B E5       
                LDX     $04,X                    ; 1988: EE 04          
                STX     M1BEC                    ; 198A: FF 1B EC       
Z198D           LDX     M1BE5                    ; 198D: FE 1B E5       
                LDAB    $02,X                    ; 1990: E6 02          
                LDAA    $03,X                    ; 1992: A6 03          
                LDX     M1BEC                    ; 1994: FE 1B EC       
                SWI                              ; 1997: 3F             
                BLE     Z19C1                    ; 1998: 2F 27          
                ADCA    M00E6                    ; 199A: 99 E6          
                FCB     $00                      ; 199C: 00             
                INX                              ; 199D: 08             
                STX     M1BEC                    ; 199E: FF 1B EC       
                JSR     Z1B10                    ; 19A1: BD 1B 10       
                BCS     Z19D6                    ; 19A4: 25 30          
                BRA     Z198D                    ; 19A6: 20 E5          
Z19A8           LDX     #M1BF1                   ; 19A8: CE 1B F1       
Z19AB           CMPB    ,X                       ; 19AB: E1 00          
                BEQ     Z1934                    ; 19AD: 27 85          
                INX                              ; 19AF: 08             
                LDAA    M1BF8                    ; 19B0: B6 1B F8       
                CMPA    ,X                       ; 19B3: A1 00          
                BNE     Z19AB                    ; 19B5: 26 F4          
                CMPB    #$0D                     ; 19B7: C1 0D          
                BNE     Z19F3                    ; 19B9: 26 38          
                LDX     M1BE5                    ; 19BB: FE 1B E5       
                LDX     $02,X                    ; 19BE: EE 02          
                STAB    ,X                       ; 19C0: E7 00          
                TST     M1BE9                    ; 19C2: 7D 1B E9       
                BEQ     Z19D9                    ; 19C5: 27 12          
                TST     M1BEB                    ; 19C7: 7D 1B EB       
                BNE     Z19D1                    ; 19CA: 26 05          
                JSR     Z1B96                    ; 19CC: BD 1B 96       
                BRA     Z19D4                    ; 19CF: 20 03          
Z19D1           JSR     Z1B8F                    ; 19D1: BD 1B 8F       
Z19D4           BCC     Z19D9                    ; 19D4: 24 03          
Z19D6           JMP     Z1ADC                    ; 19D6: 7E 1A DC       
Z19D9           TST     M1BEE                    ; 19D9: 7D 1B EE       
                BEQ     Z19E1                    ; 19DC: 27 03          
                JMP     Z1AE5                    ; 19DE: 7E 1A E5       
Z19E1           TST     M1BE8                    ; 19E1: 7D 1B E8       
                BEQ     Z19E9                    ; 19E4: 27 03          
                JMP     Z1AEE                    ; 19E6: 7E 1A EE       
Z19E9           JSR     Z1AFA                    ; 19E9: BD 1A FA       
                LDX     M1BE5                    ; 19EC: FE 1B E5       
                CLR     ,X                       ; 19EF: 6F 00          
                CLRB                             ; 19F1: 5F             
                RTS                              ; 19F2: 39             
Z19F3           JSR     Z1BDB                    ; 19F3: BD 1B DB       
                BEQ     Z19FF                    ; 19F6: 27 07          
                CMPB    #$1A                     ; 19F8: C1 1A          
                BNE     Z19FF                    ; 19FA: 26 03          
                INC     M1BEE                    ; 19FC: 7C 1B EE       
Z19FF           TSTB                             ; 19FF: 5D             
                BPL     Z1A15                    ; 1A00: 2A 13          
                ANDB    #$7F                     ; 1A02: C4 7F          
                BEQ     Z1A18                    ; 1A04: 27 12          
                STAB    M1BEC                    ; 1A06: F7 1B EC       
Z1A09           LDAB    #$20                     ; 1A09: C6 20          
                JSR     Z1BBF                    ; 1A0B: BD 1B BF       
                DEC     M1BEC                    ; 1A0E: 7A 1B EC       
                BEQ     Z1A18                    ; 1A11: 27 05          
                BRA     Z1A09                    ; 1A13: 20 F4          
Z1A15           JSR     Z1BBF                    ; 1A15: BD 1B BF       
Z1A18           JMP     Z1934                    ; 1A18: 7E 19 34       
Z1A1B           JSR     Z1B25                    ; 1A1B: BD 1B 25       
                BCC     Z1A23                    ; 1A1E: 24 03          
Z1A20           JMP     Z1ADC                    ; 1A20: 7E 1A DC       
Z1A23           TST     M1BE7                    ; 1A23: 7D 1B E7       
                BEQ     Z1A2E                    ; 1A26: 27 06          
                CMPB    #$48                     ; 1A28: C1 48          
                BEQ     Z1A45                    ; 1A2A: 27 19          
                BRA     Z1A40                    ; 1A2C: 20 12          
Z1A2E           JSR     Z1BDB                    ; 1A2E: BD 1B DB       
                BEQ     Z1A3C                    ; 1A31: 27 09          
                CMPB    #$45                     ; 1A33: C1 45          
                BNE     Z1A3C                    ; 1A35: 26 05          
                INC     M1BEE                    ; 1A37: 7C 1B EE       
                BRA     Z1A45                    ; 1A3A: 20 09          
Z1A3C           CMPB    #$44                     ; 1A3C: C1 44          
                BEQ     Z1A45                    ; 1A3E: 27 05          
Z1A40           JSR     Z1B85                    ; 1A40: BD 1B 85       
                BRA     Z1A1B                    ; 1A43: 20 D6          
Z1A45           CLR     M1BEF                    ; 1A45: 7F 1B EF       
                TST     M1BE7                    ; 1A48: 7D 1B E7       
                BNE     Z1AC1                    ; 1A4B: 26 74          
                LDX     M1BE5                    ; 1A4D: FE 1B E5       
                LDAA    #$07                     ; 1A50: 86 07          
                ANDA    $17,X                    ; 1A52: A4 17          
                CMPA    #$03                     ; 1A54: 81 03          
                BNE     Z1AC1                    ; 1A56: 26 69          
                LDAA    #$01                     ; 1A58: 86 01          
Z1A5A           STAA    M1BEA                    ; 1A5A: B7 1B EA       
                JSR     Z1B70                    ; 1A5D: BD 1B 70       
                BCS     Z1A20                    ; 1A60: 25 BE          
                JSR     Z1B7D                    ; 1A62: BD 1B 7D       
                STAB    M1BF0                    ; 1A65: F7 1B F0       
                BNE     Z1A6D                    ; 1A68: 26 03          
Z1A6A           JMP     Z1AF6                    ; 1A6A: 7E 1A F6       
Z1A6D           TST     M1BEE                    ; 1A6D: 7D 1B EE       
                BEQ     Z1A76                    ; 1A70: 27 04          
                CMPB    #$01                     ; 1A72: C1 01          
                BNE     Z1A6A                    ; 1A74: 26 F4          
Z1A76           TST     M1BE7                    ; 1A76: 7D 1B E7       
                BEQ     Z1A7F                    ; 1A79: 27 04          
                CMPB    #$11                     ; 1A7B: C1 11          
                BNE     Z1A6A                    ; 1A7D: 26 EB          
Z1A7F           DEC     M1BF0                    ; 1A7F: 7A 1B F0       
                BEQ     Z1A91                    ; 1A82: 27 0D          
                JSR     Z1B70                    ; 1A84: BD 1B 70       
Z1A87           BCS     Z1A20                    ; 1A87: 25 97          
                JSR     Z1B7D                    ; 1A89: BD 1B 7D       
                JSR     Z1BBF                    ; 1A8C: BD 1B BF       
                BRA     Z1A7F                    ; 1A8F: 20 EE          
Z1A91           JSR     Z1B70                    ; 1A91: BD 1B 70       
                BCS     Z1A20                    ; 1A94: 25 8A          
                JSR     Z1B7D                    ; 1A96: BD 1B 7D       
                TST     M1BEF                    ; 1A99: 7D 1B EF       
                BNE     Z1A6A                    ; 1A9C: 26 CC          
Z1A9E           JSR     Z1B25                    ; 1A9E: BD 1B 25       
                BCS     Z1A87                    ; 1AA1: 25 E4          
                CMPB    #$0D                     ; 1AA3: C1 0D          
                BNE     Z1A9E                    ; 1AA5: 26 F7          
                LDX     M1BE5                    ; 1AA7: FE 1B E5       
                LDAB    $04,X                    ; 1AAA: E6 04          
                LDAA    $05,X                    ; 1AAC: A6 05          
                CMPB    $02,X                    ; 1AAE: E1 02          
                BNE     Z1AB6                    ; 1AB0: 26 04          
                CMPA    $03,X                    ; 1AB2: A1 03          
                BEQ     Z1ABE                    ; 1AB4: 27 08          
Z1AB6           TST     $03,X                    ; 1AB6: 6D 03          
                BNE     Z1ABC                    ; 1AB8: 26 02          
                DEC     $02,X                    ; 1ABA: 6A 02          
Z1ABC           DEC     $03,X                    ; 1ABC: 6A 03          
Z1ABE           JMP     Z19D9                    ; 1ABE: 7E 19 D9       
Z1AC1           LDAA    #$FF                     ; 1AC1: 86 FF          
                BRA     Z1A5A                    ; 1AC3: 20 95          
Z1AC5           TSX                              ; 1AC5: 30             
                LDX     $05,X                    ; 1AC6: EE 05          
                STAB    ,X                       ; 1AC8: E7 00          
                TSTB                             ; 1ACA: 5D             
                SEC                              ; 1ACB: 0D             
                RTS                              ; 1ACC: 39             
Z1ACD           LDAB    #$08                     ; 1ACD: C6 08          
                BRA     Z1AC5                    ; 1ACF: 20 F4          
Z1AD1           LDAB    #$0B                     ; 1AD1: C6 0B          
Z1AD3           JSR     Z1AFA                    ; 1AD3: BD 1A FA       
                BRA     Z1AC5                    ; 1AD6: 20 ED          
Z1AD8           LDAB    #$0A                     ; 1AD8: C6 0A          
                BRA     Z1AD3                    ; 1ADA: 20 F7          
Z1ADC           TSX                              ; 1ADC: 30             
                LDX     $05,X                    ; 1ADD: EE 05          
                LDAB    ,X                       ; 1ADF: E6 00          
                CMPB    #$09                     ; 1AE1: C1 09          
                BNE     Z1AD3                    ; 1AE3: 26 EE          
Z1AE5           TST     M1BE7                    ; 1AE5: 7D 1B E7       
                BNE     Z1AF2                    ; 1AE8: 26 08          
                LDAB    #$09                     ; 1AEA: C6 09          
                BRA     Z1AD3                    ; 1AEC: 20 E5          
Z1AEE           LDAB    #$0D                     ; 1AEE: C6 0D          
                BRA     Z1AD3                    ; 1AF0: 20 E1          
Z1AF2           LDAB    #$07                     ; 1AF2: C6 07          
                BRA     Z1AD3                    ; 1AF4: 20 DD          
Z1AF6           LDAB    #$0E                     ; 1AF6: C6 0E          
                BRA     Z1AD3                    ; 1AF8: 20 D9          
Z1AFA           PSHB                             ; 1AFA: 37             
                LDX     M1BE3                    ; 1AFB: FE 1B E3       
                LDX     $02,X                    ; 1AFE: EE 02          
                JSR     $03,X                    ; 1B00: AD 03          
                ABA                              ; 1B02: 1B             
                BITB    $33,X                    ; 1B03: E5 33          
                RTS                              ; 1B05: 39             
Z1B06           LDX     M1BE3                    ; 1B06: FE 1B E3       
                LDX     $02,X                    ; 1B09: EE 02          
                JSR     ,X                       ; 1B0B: AD 00          
                ABA                              ; 1B0D: 1B             
                BITB    $39,X                    ; 1B0E: E5 39          
Z1B10           LDX     M1BE5                    ; 1B10: FE 1B E5       
                LDAA    #$40                     ; 1B13: 86 40          
                ORAA    $01,X                    ; 1B15: AA 01          
                ANDA    #$7F                     ; 1B17: 84 7F          
Z1B19           STAA    $01,X                    ; 1B19: A7 01          
                LDX     M1BE3                    ; 1B1B: FE 1B E3       
                LDX     $02,X                    ; 1B1E: EE 02          
                JSR     $0C,X                    ; 1B20: AD 0C          
                ABA                              ; 1B22: 1B             
                BITB    $39,X                    ; 1B23: E5 39          
Z1B25           LDX     M1BE5                    ; 1B25: FE 1B E5       
                LDAA    #$80                     ; 1B28: 86 80          
                ORAA    $01,X                    ; 1B2A: AA 01          
                ANDA    #$BF                     ; 1B2C: 84 BF          
                BRA     Z1B19                    ; 1B2E: 20 E9          
Z1B30           JSR     Z1B25                    ; 1B30: BD 1B 25       
                BCS     Z1B5A                    ; 1B33: 25 25          
                JSR     Z1B85                    ; 1B35: BD 1B 85       
                BSR     Z1B5C                    ; 1B38: 8D 22          
                BCC     Z1B43                    ; 1B3A: 24 07          
Z1B3C           INS                              ; 1B3C: 31             
                INS                              ; 1B3D: 31             
                INS                              ; 1B3E: 31             
                INS                              ; 1B3F: 31             
                JMP     Z1AF6                    ; 1B40: 7E 1A F6       
Z1B43           ASLB                             ; 1B43: 58             
                ASLB                             ; 1B44: 58             
                ASLB                             ; 1B45: 58             
                ASLB                             ; 1B46: 58             
                STAB    M1B5B                    ; 1B47: F7 1B 5B       
                JSR     Z1B25                    ; 1B4A: BD 1B 25       
                BCS     Z1B5A                    ; 1B4D: 25 0B          
                JSR     Z1B85                    ; 1B4F: BD 1B 85       
                BSR     Z1B5C                    ; 1B52: 8D 08          
                BCS     Z1B3C                    ; 1B54: 25 E6          
                ADDB    M1B5B                    ; 1B56: FB 1B 5B       
                CLC                              ; 1B59: 0C             
Z1B5A           RTS                              ; 1B5A: 39             
M1B5B           FCB     $00                      ; 1B5B: 00             
Z1B5C           SUBB    #$30                     ; 1B5C: C0 30          
                BCS     Z1B6F                    ; 1B5E: 25 0F          
                ADDB    #$E9                     ; 1B60: CB E9          
                BCS     Z1B6F                    ; 1B62: 25 0B          
                ADDB    #$06                     ; 1B64: CB 06          
                BPL     Z1B6C                    ; 1B66: 2A 04          
                ADDB    #$07                     ; 1B68: CB 07          
                BCS     Z1B6F                    ; 1B6A: 25 03          
Z1B6C           ADDB    #$0A                     ; 1B6C: CB 0A          
                CLC                              ; 1B6E: 0C             
Z1B6F           RTS                              ; 1B6F: 39             
Z1B70           TST     M1BEA                    ; 1B70: 7D 1B EA       
                BMI     Z1B79                    ; 1B73: 2B 04          
                JSR     Z1B25                    ; 1B75: BD 1B 25       
                RTS                              ; 1B78: 39             
Z1B79           JSR     Z1B30                    ; 1B79: BD 1B 30       
                RTS                              ; 1B7C: 39             
Z1B7D           LDAA    M1BEF                    ; 1B7D: B6 1B EF       
                ABA                              ; 1B80: 1B             
                STAA    M1BEF                    ; 1B81: B7 1B EF       
                RTS                              ; 1B84: 39             
Z1B85           PSHB                             ; 1B85: 37             
                CMPB    #$0D                     ; 1B86: C1 0D          
                BNE     Z1B8D                    ; 1B88: 26 03          
                JSR     Z1B06                    ; 1B8A: BD 1B 06       
Z1B8D           PULB                             ; 1B8D: 33             
                RTS                              ; 1B8E: 39             
Z1B8F           LDAB    #$0D                     ; 1B8F: C6 0D          
                JSR     Z1B10                    ; 1B91: BD 1B 10       
                BCS     Z1B9B                    ; 1B94: 25 05          
Z1B96           LDAB    #$0A                     ; 1B96: C6 0A          
                JSR     Z1B10                    ; 1B98: BD 1B 10       
Z1B9B           RTS                              ; 1B9B: 39             
Z1B9C           LDX     M1BE5                    ; 1B9C: FE 1B E5       
                LDAB    $02,X                    ; 1B9F: E6 02          
                LDAA    $03,X                    ; 1BA1: A6 03          
                LDX     $04,X                    ; 1BA3: EE 04          
                SWI                              ; 1BA5: 3F             
                BLE     Z1BE1                    ; 1BA6: 2F 39          
Z1BA8           LDX     M1BE5                    ; 1BA8: FE 1B E5       
                LDAB    $06,X                    ; 1BAB: E6 06          
                LDAA    $07,X                    ; 1BAD: A6 07          
                LDX     $02,X                    ; 1BAF: EE 02          
                TST     M1BEA                    ; 1BB1: 7D 1B EA       
                BNE     Z1BBB                    ; 1BB4: 26 05          
                TSTA                             ; 1BB6: 4D             
                BNE     Z1BBA                    ; 1BB7: 26 01          
                DECB                             ; 1BB9: 5A             
Z1BBA           DECA                             ; 1BBA: 4A             
Z1BBB           JSR     Z04CE                    ; 1BBB: BD 04 CE       
                RTS                              ; 1BBE: 39             
Z1BBF           PSHB                             ; 1BBF: 37             
                JSR     Z1BA8                    ; 1BC0: BD 1B A8       
                BCS     Z1BD4                    ; 1BC3: 25 0F          
                PULB                             ; 1BC5: 33             
                STAB    ,X                       ; 1BC6: E7 00          
                INX                              ; 1BC8: 08             
Z1BC9           JSR     Z0467                    ; 1BC9: BD 04 67       
                LDX     M1BE5                    ; 1BCC: FE 1B E5       
                STAB    $02,X                    ; 1BCF: E7 02          
                STAA    $03,X                    ; 1BD1: A7 03          
                RTS                              ; 1BD3: 39             
Z1BD4           LDAA    #$01                     ; 1BD4: 86 01          
                STAA    M1BE8                    ; 1BD6: B7 1B E8       
                PULB                             ; 1BD9: 33             
                RTS                              ; 1BDA: 39             
Z1BDB           LDX     M1BE3                    ; 1BDB: FE 1B E3       
                LDAA    #$10                     ; 1BDE: 86 10          
                BITA    $06,X                    ; 1BE0: A5 06          
                RTS                              ; 1BE2: 39             
M1BE3           FCB     $00                      ; 1BE3: 00             
                FCB     $00                      ; 1BE4: 00             
M1BE5           FCB     $00                      ; 1BE5: 00             
                FCB     $00                      ; 1BE6: 00             
M1BE7           FCB     $00                      ; 1BE7: 00             
M1BE8           FCB     $00                      ; 1BE8: 00             
M1BE9           FCB     $00                      ; 1BE9: 00             
M1BEA           FCB     $00                      ; 1BEA: 00             
M1BEB           FCB     $00                      ; 1BEB: 00             
M1BEC           FCB     $00                      ; 1BEC: 00             
                FCB     $00                      ; 1BED: 00             
M1BEE           FCB     $00                      ; 1BEE: 00             
M1BEF           FCB     $00                      ; 1BEF: 00             
M1BF0           FCB     $00                      ; 1BF0: 00             
M1BF1           FCB     $00                      ; 1BF1: 00             
                CLV                              ; 1BF2: 0A             
                CBA                              ; 1BF3: 11             
                FCB     $12                      ; 1BF4: 12             
                FCB     $13                      ; 1BF5: 13             
                FCB     $14                      ; 1BF6: 14             
                CLR     RAMBGN                   ; 1BF7: 7F FF 00       
                FCB     $00                      ; 1BFA: 00             
                FCB     $00                      ; 1BFB: 00             
                FCB     $00                      ; 1BFC: 00             


                END
