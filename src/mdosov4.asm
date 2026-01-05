dasmfw: Disassembler Framework V0.35
Loaded: binary file "mdosov4.sy"
Loaded: Info file "mdosov4.info"

;****************************************************
; Used Labels
;****************************************************

Z1206   EQU     $1206
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

;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $1C0D

                JMP     Z1C13                    ; 1C0D: 7E 1C 13       
                JSR     Z1206                    ; 1C10: BD 12 06       
Z1C13           STX     M1F2E                    ; 1C13: FF 1F 2E       
                LDAB    #$10                     ; 1C16: C6 10          
                BITB    $01,X                    ; 1C18: E5 01          
                BNE     Z1C1F                    ; 1C1A: 26 03          
                JMP     Z1EC7                    ; 1C1C: 7E 1E C7       
Z1C1F           LDAA    #$40                     ; 1C1F: 86 40          
                BITA    $0A,X                    ; 1C21: A5 0A          
                BNE     Z1C28                    ; 1C23: 26 03          
                JMP     Z1ECB                    ; 1C25: 7E 1E CB       
Z1C28           CLR     M1F4F                    ; 1C28: 7F 1F 4F       
                LDX     $08,X                    ; 1C2B: EE 08          
                STX     M1F30                    ; 1C2D: FF 1F 30       
                LDX     M1F2E                    ; 1C30: FE 1F 2E       
                LDAA    #$04                     ; 1C33: 86 04          
                BITA    $01,X                    ; 1C35: A5 01          
                BEQ     Z1C57                    ; 1C37: 27 1E          
                LDAA    $17,X                    ; 1C39: A6 17          
                ANDA    #$07                     ; 1C3B: 84 07          
                CMPA    #$05                     ; 1C3D: 81 05          
                BEQ     Z1C44                    ; 1C3F: 27 03          
                JMP     Z1EEF                    ; 1C41: 7E 1E EF       
Z1C44           LDX     M1F30                    ; 1C44: FE 1F 30       
                LDAA    #$80                     ; 1C47: 86 80          
                BITA    $07,X                    ; 1C49: A5 07          
                BNE     Z1C7B                    ; 1C4B: 26 2E          
                JMP     Z1ECF                    ; 1C4D: 7E 1E CF       
Z1C50           JSR     Z1F13                    ; 1C50: BD 1F 13       
Z1C53           CLR     ,X                       ; 1C53: 6F 00          
                CLRB                             ; 1C55: 5F             
                RTS                              ; 1C56: 39             
Z1C57           LDX     M1F30                    ; 1C57: FE 1F 30       
                LDAA    #$10                     ; 1C5A: 86 10          
                BITA    $06,X                    ; 1C5C: A5 06          
                BEQ     Z1C7B                    ; 1C5E: 27 1B          
Z1C60           LDX     M1F2E                    ; 1C60: FE 1F 2E       
                LDAA    #$3F                     ; 1C63: 86 3F          
                ANDA    $01,X                    ; 1C65: A4 01          
                STAA    $01,X                    ; 1C67: A7 01          
                LDAA    #$03                     ; 1C69: 86 03          
                ANDA    $01,X                    ; 1C6B: A4 01          
                CMPA    #$01                     ; 1C6D: 81 01          
                BEQ     Z1C80                    ; 1C6F: 27 0F          
                CMPA    #$02                     ; 1C71: 81 02          
                BNE     Z1C78                    ; 1C73: 26 03          
                JMP     Z1DA6                    ; 1C75: 7E 1D A6       
Z1C78           JMP     Z1EA5                    ; 1C78: 7E 1E A5       
Z1C7B           INC     M1F4F                    ; 1C7B: 7C 1F 4F       
                BRA     Z1C60                    ; 1C7E: 20 E0          
Z1C80           LDX     M1F30                    ; 1C80: FE 1F 30       
                LDAA    #$20                     ; 1C83: 86 20          
                BITA    $06,X                    ; 1C85: A5 06          
                BNE     Z1C8C                    ; 1C87: 26 03          
                JMP     Z1ED3                    ; 1C89: 7E 1E D3       
Z1C8C           JSR     Z1F1D                    ; 1C8C: BD 1F 1D       
                LDX     M1F30                    ; 1C8F: FE 1F 30       
                LDAA    #$02                     ; 1C92: 86 02          
                BITA    $06,X                    ; 1C94: A5 06          
                BNE     Z1C9B                    ; 1C96: 26 03          
                JMP     Z1D42                    ; 1C98: 7E 1D 42       
Z1C9B           LDX     M1F2E                    ; 1C9B: FE 1F 2E       
                JSR     Z1EFF                    ; 1C9E: BD 1E FF       
                LDAB    #$0A                     ; 1CA1: C6 0A          
                SWI                              ; 1CA3: 3F             
                BEQ     Z1C6C                    ; 1CA4: 27 C6          
                FCB     $02                      ; 1CA6: 02             
                SWI                              ; 1CA7: 3F             
                FCB     $1C                      ; 1CA8: 1C             
                BCC     Z1CC6                    ; 1CA9: 24 1B          
                CMPB    #$01                     ; 1CAB: C1 01          
                BEQ     Z1CB5                    ; 1CAD: 27 06          
                LDAB    #$0C                     ; 1CAF: C6 0C          
                SWI                              ; 1CB1: 3F             
                BRA     Z1CF3                    ; 1CB2: 20 3F          
                FCB     $1A                      ; 1CB4: 1A             
Z1CB5           LDX     M1F2E                    ; 1CB5: FE 1F 2E       
                LDAA    #$03                     ; 1CB8: 86 03          
                ANDA    $01,X                    ; 1CBA: A4 01          
                CMPA    #$03                     ; 1CBC: 81 03          
                BNE     Z1CC3                    ; 1CBE: 26 03          
                JMP     Z1DB5                    ; 1CC0: 7E 1D B5       
Z1CC3           JMP     Z1ED7                    ; 1CC3: 7E 1E D7       
Z1CC6           LDX     M1F2E                    ; 1CC6: FE 1F 2E       
                LDAA    #$03                     ; 1CC9: 86 03          
                ANDA    $01,X                    ; 1CCB: A4 01          
                CMPA    #$01                     ; 1CCD: 81 01          
                BEQ     Z1CDA                    ; 1CCF: 27 09          
                LDAA    #$80                     ; 1CD1: 86 80          
                BITA    $17,X                    ; 1CD3: A5 17          
                BEQ     Z1CDA                    ; 1CD5: 27 03          
                JMP     Z1EEB                    ; 1CD7: 7E 1E EB       
Z1CDA           LDAA    #$F7                     ; 1CDA: 86 F7          
                ANDA    $01,X                    ; 1CDC: A4 01          
                STAA    $01,X                    ; 1CDE: A7 01          
Z1CE0           CLR     $1D,X                    ; 1CE0: 6F 1D          
                CLR     $1E,X                    ; 1CE2: 6F 1E          
                LDAA    #$FF                     ; 1CE4: 86 FF          
                STAA    $0B,X                    ; 1CE6: A7 0B          
                STAA    $0C,X                    ; 1CE8: A7 0C          
                STAA    $0F,X                    ; 1CEA: A7 0F          
                STAA    $10,X                    ; 1CEC: A7 10          
                CLR     $11,X                    ; 1CEE: 6F 11          
                CLR     $12,X                    ; 1CF0: 6F 12          
                LDAB    $21,X                    ; 1CF2: E6 21          
                LDAA    $22,X                    ; 1CF4: A6 22          
                STAB    $23,X                    ; 1CF6: E7 23          
                STAA    $24,X                    ; 1CF8: A7 24          
                LDX     $15,X                    ; 1CFA: EE 15          
                STX     M1F33                    ; 1CFC: FF 1F 33       
                LDX     M1F2E                    ; 1CFF: FE 1F 2E       
                LDAB    $0A,X                    ; 1D02: E6 0A          
                LDX     $1F,X                    ; 1D04: EE 1F          
                STX     M1F35                    ; 1D06: FF 1F 35       
                LDX     #M1F32                   ; 1D09: CE 1F 32       
                SWI                              ; 1D0C: 3F             
                CLI                              ; 1D0D: 0E             
                LDX     M1F35                    ; 1D0E: FE 1F 35       
                LDAB    ,X                       ; 1D11: E6 00          
                BPL     Z1D18                    ; 1D13: 2A 03          
                JMP     Z1EDB                    ; 1D15: 7E 1E DB       
Z1D18           LDAA    $01,X                    ; 1D18: A6 01          
                LDX     M1F2E                    ; 1D1A: FE 1F 2E       
                STAB    $0D,X                    ; 1D1D: E7 0D          
                STAA    $0E,X                    ; 1D1F: A7 0E          
                LDX     M1F35                    ; 1D21: FE 1F 35       
                LDAB    #$3A                     ; 1D24: C6 3A          
Z1D26           TST     ,X                       ; 1D26: 6D 00          
                BMI     Z1D32                    ; 1D28: 2B 08          
                INX                              ; 1D2A: 08             
                INX                              ; 1D2B: 08             
                DECB                             ; 1D2C: 5A             
                BNE     Z1D26                    ; 1D2D: 26 F7          
                JMP     Z1EDB                    ; 1D2F: 7E 1E DB       
Z1D32           LDAB    ,X                       ; 1D32: E6 00          
                LDAA    $01,X                    ; 1D34: A6 01          
                ANDB    #$7F                     ; 1D36: C4 7F          
                LDX     M1F2E                    ; 1D38: FE 1F 2E       
                STAB    $13,X                    ; 1D3B: E7 13          
                STAA    $14,X                    ; 1D3D: A7 14          
                JMP     Z1C50                    ; 1D3F: 7E 1C 50       
Z1D42           TST     M1F4F                    ; 1D42: 7D 1F 4F       
                BEQ     Z1D4A                    ; 1D45: 27 03          
                JMP     Z1C50                    ; 1D47: 7E 1C 50       
Z1D4A           JSR     Z1F13                    ; 1D4A: BD 1F 13       
                SWI                              ; 1D4D: 3F             
                PSHA                             ; 1D4E: 36             
                BEQ     Z1D54                    ; 1D4F: 27 03          
Z1D51           JMP     Z1E9C                    ; 1D51: 7E 1E 9C       
Z1D54           TST     $0B,X                    ; 1D54: 6D 0B          
                BEQ     Z1D70                    ; 1D56: 27 18          
                LDAB    #$0B                     ; 1D58: C6 0B          
                SWI                              ; 1D5A: 3F             
                BEQ     Z1D5C                    ; 1D5B: 27 FF          
                FCB     $1F                      ; 1D5D: 1F             
                PULB                             ; 1D5E: 33             
                LDX     M1F2E                    ; 1D5F: FE 1F 2E       
                LDX     $04,X                    ; 1D62: EE 04          
                STX     M1F35                    ; 1D64: FF 1F 35       
                LDAB    #$0A                     ; 1D67: C6 0A          
                LDX     #M1F33                   ; 1D69: CE 1F 33       
                SWI                              ; 1D6C: 3F             
                CBA                              ; 1D6D: 11             
                BNE     Z1D8C                    ; 1D6E: 26 1C          
Z1D70           LDX     M1F2E                    ; 1D70: FE 1F 2E       
                LDX     $04,X                    ; 1D73: EE 04          
                STX     M1F33                    ; 1D75: FF 1F 33       
                LDX     M1F2E                    ; 1D78: FE 1F 2E       
                LDAB    #$0B                     ; 1D7B: C6 0B          
                SWI                              ; 1D7D: 3F             
                BEQ     Z1D7F                    ; 1D7E: 27 FF          
                FCB     $1F                      ; 1D80: 1F             
                TXS                              ; 1D81: 35             
                LDAB    #$10                     ; 1D82: C6 10          
                LDX     #M1F33                   ; 1D84: CE 1F 33       
                SWI                              ; 1D87: 3F             
                SBA                              ; 1D88: 10             
                JMP     Z1C50                    ; 1D89: 7E 1C 50       
Z1D8C           LDX     M1F2E                    ; 1D8C: FE 1F 2E       
                LDX     $04,X                    ; 1D8F: EE 04          
                LDAA    $0C,X                    ; 1D91: A6 0C          
                LDX     M1F2E                    ; 1D93: FE 1F 2E       
                STAA    $17,X                    ; 1D96: A7 17          
Z1D98           SWI                              ; 1D98: 3F             
                FCB     $04                      ; 1D99: 04             
                BEQ     Z1D98                    ; 1D9A: 27 FC          
                CMPB    #$0D                     ; 1D9C: C1 0D          
                BEQ     Z1D98                    ; 1D9E: 27 F8          
                CMPB    #$09                     ; 1DA0: C1 09          
                BEQ     Z1D4A                    ; 1DA2: 27 A6          
                BRA     Z1D51                    ; 1DA4: 20 AB          
Z1DA6           LDX     M1F30                    ; 1DA6: FE 1F 30       
                LDAA    #$40                     ; 1DA9: 86 40          
                BITA    $06,X                    ; 1DAB: A5 06          
                BNE     Z1DB2                    ; 1DAD: 26 03          
                JMP     Z1ED3                    ; 1DAF: 7E 1E D3       
Z1DB2           JSR     Z1F1D                    ; 1DB2: BD 1F 1D       
Z1DB5           LDX     M1F2E                    ; 1DB5: FE 1F 2E       
                LDAA    $17,X                    ; 1DB8: A6 17          
                ANDA    #$7F                     ; 1DBA: 84 7F          
                STAA    $17,X                    ; 1DBC: A7 17          
                ANDA    #$07                     ; 1DBE: 84 07          
                CMPA    #$01                     ; 1DC0: 81 01          
                BNE     Z1DDF                    ; 1DC2: 26 1B          
                LDX     M1F30                    ; 1DC4: FE 1F 30       
                LDAA    #$01                     ; 1DC7: 86 01          
                BITA    $06,X                    ; 1DC9: A5 06          
                BNE     Z1DD1                    ; 1DCB: 26 04          
                LDAA    #$03                     ; 1DCD: 86 03          
                BRA     Z1DD3                    ; 1DCF: 20 02          
Z1DD1           LDAA    #$07                     ; 1DD1: 86 07          
Z1DD3           LDX     M1F2E                    ; 1DD3: FE 1F 2E       
                LDAB    $17,X                    ; 1DD6: E6 17          
                ANDB    #$F8                     ; 1DD8: C4 F8          
                PSHA                             ; 1DDA: 36             
                ABA                              ; 1DDB: 1B             
                STAA    $17,X                    ; 1DDC: A7 17          
                PULA                             ; 1DDE: 32             
Z1DDF           CMPA    #$02                     ; 1DDF: 81 02          
                BEQ     Z1DE7                    ; 1DE1: 27 04          
                CMPA    #$03                     ; 1DE3: 81 03          
                BNE     Z1DF3                    ; 1DE5: 26 0C          
Z1DE7           LDX     M1F30                    ; 1DE7: FE 1F 30       
                LDAB    #$04                     ; 1DEA: C6 04          
                BITB    $07,X                    ; 1DEC: E5 07          
                BNE     Z1DF3                    ; 1DEE: 26 03          
                JMP     Z1EEF                    ; 1DF0: 7E 1E EF       
Z1DF3           LDX     M1F30                    ; 1DF3: FE 1F 30       
                LDAB    #$02                     ; 1DF6: C6 02          
                BITB    $06,X                    ; 1DF8: E5 06          
                BNE     Z1DFF                    ; 1DFA: 26 03          
                JMP     Z1E36                    ; 1DFC: 7E 1E 36       
Z1DFF           LDX     M1F2E                    ; 1DFF: FE 1F 2E       
                JSR     Z1EFF                    ; 1E02: BD 1E FF       
                LDAB    #$0A                     ; 1E05: C6 0A          
                SWI                              ; 1E07: 3F             
                BEQ     Z1DD0                    ; 1E08: 27 C6          
                FCB     $04                      ; 1E0A: 04             
                SWI                              ; 1E0B: 3F             
                FCB     $1C                      ; 1E0C: 1C             
                BCC     Z1E2A                    ; 1E0D: 24 1B          
                CMPB    #$04                     ; 1E0F: C1 04          
                BNE     Z1E16                    ; 1E11: 26 03          
                JMP     Z1EDF                    ; 1E13: 7E 1E DF       
Z1E16           CMPB    #$05                     ; 1E16: C1 05          
                BNE     Z1E1D                    ; 1E18: 26 03          
                JMP     Z1EE3                    ; 1E1A: 7E 1E E3       
Z1E1D           CMPB    #$07                     ; 1E1D: C1 07          
                BNE     Z1E24                    ; 1E1F: 26 03          
                JMP     Z1EE7                    ; 1E21: 7E 1E E7       
Z1E24           LDAB    #$0C                     ; 1E24: C6 0C          
                SWI                              ; 1E26: 3F             
                BRA     Z1E68                    ; 1E27: 20 3F          
                FCB     $1A                      ; 1E29: 1A             
Z1E2A           LDX     M1F2E                    ; 1E2A: FE 1F 2E       
                LDAA    #$08                     ; 1E2D: 86 08          
                ORAA    $01,X                    ; 1E2F: AA 01          
                STAA    $01,X                    ; 1E31: A7 01          
                JMP     Z1CE0                    ; 1E33: 7E 1C E0       
Z1E36           CMPA    #$03                     ; 1E36: 81 03          
                BEQ     Z1E45                    ; 1E38: 27 0B          
                CMPA    #$05                     ; 1E3A: 81 05          
                BEQ     Z1E45                    ; 1E3C: 27 07          
                CMPA    #$07                     ; 1E3E: 81 07          
                BEQ     Z1E45                    ; 1E40: 27 03          
                JMP     Z1EEF                    ; 1E42: 7E 1E EF       
Z1E45           TST     M1F4F                    ; 1E45: 7D 1F 4F       
                BEQ     Z1E4D                    ; 1E48: 27 03          
                JMP     Z1C50                    ; 1E4A: 7E 1C 50       
Z1E4D           LDX     M1F2E                    ; 1E4D: FE 1F 2E       
                LDX     $04,X                    ; 1E50: EE 04          
                STX     M1F4B                    ; 1E52: FF 1F 4B       
                LDX     M1F2E                    ; 1E55: FE 1F 2E       
                LDX     $06,X                    ; 1E58: EE 06          
                STX     M1F4D                    ; 1E5A: FF 1F 4D       
                LDX     M1F2E                    ; 1E5D: FE 1F 2E       
Z1E60           LDAB    #$0B                     ; 1E60: C6 0B          
                SWI                              ; 1E62: 3F             
                BEQ     Z1EA4                    ; 1E63: 27 3F          
Z1E65           BCC     Z1E65                    ; 1E65: 24 FE          
                FCB     $1F                      ; 1E67: 1F             
Z1E68           BGT     Z1E51                    ; 1E68: 2E E7          
                FCB     $04                      ; 1E6A: 04             
                STAA    $05,X                    ; 1E6B: A7 05          
                SWI                              ; 1E6D: 3F             
                BCS     Z1E36                    ; 1E6E: 25 C6          
                SEI                              ; 1E70: 0F             
                SWI                              ; 1E71: 3F             
                BEQ     Z1EB3                    ; 1E72: 27 3F          
Z1E74           BCC     Z1E74                    ; 1E74: 24 FE          
                FCB     $1F                      ; 1E76: 1F             
                BGT     Z1E60                    ; 1E77: 2E E7          
                TAP                              ; 1E79: 06             
                STAA    $07,X                    ; 1E7A: A7 07          
                JSR     Z1F13                    ; 1E7C: BD 1F 13       
                SWI                              ; 1E7F: 3F             
                PSHB                             ; 1E80: 37             
                LDAB    M1F4B                    ; 1E81: F6 1F 4B       
                LDAA    M1F4C                    ; 1E84: B6 1F 4C       
                STAB    $04,X                    ; 1E87: E7 04          
                STAA    $05,X                    ; 1E89: A7 05          
                LDAB    M1F4D                    ; 1E8B: F6 1F 4D       
                LDAA    M1F4E                    ; 1E8E: B6 1F 4E       
                STAB    $06,X                    ; 1E91: E7 06          
                STAA    $07,X                    ; 1E93: A7 07          
                TST     ,X                       ; 1E95: 6D 00          
                BNE     Z1E9C                    ; 1E97: 26 03          
                JMP     Z1C53                    ; 1E99: 7E 1C 53       
Z1E9C           LDAA    #$10                     ; 1E9C: 86 10          
                ORAA    $01,X                    ; 1E9E: AA 01          
                STAA    $01,X                    ; 1EA0: A7 01          
                JMP     Z1EBF                    ; 1EA2: 7E 1E BF       
Z1EA5           LDX     M1F30                    ; 1EA5: FE 1F 30       
                LDAA    #$02                     ; 1EA8: 86 02          
                BITA    $06,X                    ; 1EAA: A5 06          
                BNE     Z1EB1                    ; 1EAC: 26 03          
                JMP     Z1ECF                    ; 1EAE: 7E 1E CF       
Z1EB1           LDAA    #$60                     ; 1EB1: 86 60          
Z1EB3           ANDA    $06,X                    ; 1EB3: A4 06          
                CMPA    #$60                     ; 1EB5: 81 60          
                BNE     Z1ED3                    ; 1EB7: 26 1A          
                JSR     Z1F1D                    ; 1EB9: BD 1F 1D       
                JMP     Z1C9B                    ; 1EBC: 7E 1C 9B       
Z1EBF           TSX                              ; 1EBF: 30             
                LDX     $05,X                    ; 1EC0: EE 05          
                STAB    ,X                       ; 1EC2: E7 00          
                TSTB                             ; 1EC4: 5D             
                SEC                              ; 1EC5: 0D             
                RTS                              ; 1EC6: 39             
Z1EC7           LDAB    #$08                     ; 1EC7: C6 08          
                BRA     Z1EBF                    ; 1EC9: 20 F4          
Z1ECB           LDAB    #$03                     ; 1ECB: C6 03          
                BRA     Z1EBF                    ; 1ECD: 20 F0          
Z1ECF           LDAB    #$05                     ; 1ECF: C6 05          
                BRA     Z1EBF                    ; 1ED1: 20 EC          
Z1ED3           LDAB    #$0B                     ; 1ED3: C6 0B          
                BRA     Z1EBF                    ; 1ED5: 20 E8          
Z1ED7           LDAB    #$07                     ; 1ED7: C6 07          
                BRA     Z1EBF                    ; 1ED9: 20 E4          
Z1EDB           LDAB    #$16                     ; 1EDB: C6 16          
                BRA     Z1EBF                    ; 1EDD: 20 E0          
Z1EDF           LDAB    #$13                     ; 1EDF: C6 13          
                BRA     Z1EBF                    ; 1EE1: 20 DC          
Z1EE3           LDAB    #$12                     ; 1EE3: C6 12          
                BRA     Z1EBF                    ; 1EE5: 20 D8          
Z1EE7           LDAB    #$06                     ; 1EE7: C6 06          
                BRA     Z1EBF                    ; 1EE9: 20 D4          
Z1EEB           LDAB    #$0F                     ; 1EEB: C6 0F          
                BRA     Z1EBF                    ; 1EED: 20 D0          
Z1EEF           LDAB    #$0A                     ; 1EEF: C6 0A          
                BRA     Z1EBF                    ; 1EF1: 20 CC          
Z1EF3           LDAB    #$04                     ; 1EF3: C6 04          
                BRA     Z1EBF                    ; 1EF5: 20 C8          
                LDAB    #$0E                     ; 1EF7: C6 0E          
                BRA     Z1EBF                    ; 1EF9: 20 C4          
Z1EFB           LDAB    #$19                     ; 1EFB: C6 19          
                BRA     Z1EBF                    ; 1EFD: 20 C0          
Z1EFF           LDAB    $21,X                    ; 1EFF: E6 21          
                LDAA    $22,X                    ; 1F01: A6 22          
                SUBA    $20,X                    ; 1F03: A0 20          
                SBCB    $1F,X                    ; 1F05: E2 1F          
                ADDA    #$01                     ; 1F07: 8B 01          
                ADCB    #$00                     ; 1F09: C9 00          
                ASLA                             ; 1F0B: 48             
                BNE     Z1F0F                    ; 1F0C: 26 01          
                RTS                              ; 1F0E: 39             
Z1F0F           INS                              ; 1F0F: 31             
                INS                              ; 1F10: 31             
                BRA     Z1EFB                    ; 1F11: 20 E8          
Z1F13           LDX     M1F2E                    ; 1F13: FE 1F 2E       
                LDAA    #$EF                     ; 1F16: 86 EF          
                ANDA    $01,X                    ; 1F18: A4 01          
                STAA    $01,X                    ; 1F1A: A7 01          
                RTS                              ; 1F1C: 39             
Z1F1D           LDX     M1F30                    ; 1F1D: FE 1F 30       
                LDX     $02,X                    ; 1F20: EE 02          
                JSR     $06,X                    ; 1F22: AD 06          
                FCB     $1F                      ; 1F24: 1F             
                BGT     M1F4B                    ; 1F25: 2E 24          
                FCB     $05                      ; 1F27: 05             
                INS                              ; 1F28: 31             
                INS                              ; 1F29: 31             
                JMP     Z1EF3                    ; 1F2A: 7E 1E F3       
                RTS                              ; 1F2D: 39             
M1F2E           FCB     $00                      ; 1F2E: 00             
                FCB     $00                      ; 1F2F: 00             
M1F30           FCB     $00                      ; 1F30: 00             
                FCB     $00                      ; 1F31: 00             
M1F32           FCB     $00                      ; 1F32: 00             
M1F33           FCB     $00                      ; 1F33: 00             
                FCB     $00                      ; 1F34: 00             
M1F35           FCB     $00                      ; 1F35: 00             
                FCB     $00                      ; 1F36: 00             
                FCB     $00                      ; 1F37: 00             
                FCB     $00                      ; 1F38: 00             
                FCB     $00                      ; 1F39: 00             
                FCB     $00                      ; 1F3A: 00             
                FCB     $00                      ; 1F3B: 00             
                FCB     $00                      ; 1F3C: 00             
                FCB     $00                      ; 1F3D: 00             
                FCB     $00                      ; 1F3E: 00             
                FCB     $00                      ; 1F3F: 00             
                FCB     $00                      ; 1F40: 00             
                FCB     $00                      ; 1F41: 00             
                FCB     $00                      ; 1F42: 00             
                FCB     $00                      ; 1F43: 00             
                FCB     $00                      ; 1F44: 00             
                FCB     $00                      ; 1F45: 00             
                FCB     $00                      ; 1F46: 00             
                FCB     $00                      ; 1F47: 00             
                FCB     $00                      ; 1F48: 00             
                FCB     $00                      ; 1F49: 00             
                FCB     $00                      ; 1F4A: 00             
M1F4B           FCB     $00                      ; 1F4B: 00             
M1F4C           FCB     $00                      ; 1F4C: 00             
M1F4D           FCB     $00                      ; 1F4D: 00             
M1F4E           FCB     $00                      ; 1F4E: 00             
M1F4F           FCB     $00                      ; 1F4F: 00             
                FCB     $00                      ; 1F50: 00             
                FCB     $00                      ; 1F51: 00             
                FCB     $00                      ; 1F52: 00             
                FCB     $00                      ; 1F53: 00             
                FCB     $00                      ; 1F54: 00             


                END
