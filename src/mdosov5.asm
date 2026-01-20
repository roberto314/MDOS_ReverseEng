dasmfw: Disassembler Framework V0.35
Loaded: binary file "mdosov5.sy"
Loaded: Info file "mdosov5.info"

;****************************************************
; Used Labels
;****************************************************

M0000   EQU     $0000
M0006   EQU     $0006
M001C   EQU     $001C
M001D   EQU     $001D
SYERRs  EQU     $0114
M0115   EQU     $0115
CHFLGs  EQU     $011E
M0291   EQU     $0291
M097F   EQU     $097F
Z1206   EQU     $1206
Z1FFD   EQU     $1FFD
M290D   EQU     $290D
M404C   EQU     $404C
M40FF   EQU     $40FF
M6572   EQU     $6572
M696F   EQU     $696F
M6F20   EQU     $6F20
MB01C   EQU     $B01C
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
MFFFF   EQU     $FFFF

;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $1C0D

                JSR     Z1206                    ; 1C0D: BD 12 06       
                JMP     Z1C13                    ; 1C10: 7E 1C 13       
Z1C13           JMP     Z1D2B                    ; 1C13: 7E 1D 2B       
M1C16           FCB     $00                      ; 1C16: 00             
                BEQ     Z1C19                    ; 1C17: 27 00          
Z1C19           FCB     $00                      ; 1C19: 00             
M1C1A           FCB     $00                      ; 1C1A: 00             
                BITA    M0000                    ; 1C1B: 95 00          
M1C1D           FCB     $83                      ; 1C1D: 83             
                FCB     $1C                      ; 1C1E: 1C             
                TSTA                             ; 1C1F: 4D             
                FCB     $1C                      ; 1C20: 1C             
                FCB     $41                      ; 1C21: 41             
                FCB     $1C                      ; 1C22: 1C             
                SUBA    M0006                    ; 1C23: 90 06          
                COM     M40FF                    ; 1C25: 73 40 FF       
                STX     M097F                    ; 1C28: FF 09 7F       
                STX     RAMBGN                   ; 1C2B: FF FF 00       
                SEV                              ; 1C2E: 0B             
                FCB     $00                      ; 1C2F: 00             
                CLV                              ; 1C30: 0A             
                FCB     $05                      ; 1C31: 05             
                FCB     $FC                      ; 1C32: FC             
                FCB     $05                      ; 1C33: 05             
                FCB     $00                      ; 1C34: 00             
                FCB     $00                      ; 1C35: 00             
                FCB     $00                      ; 1C36: 00             
                CMPA    MB01C                    ; 1C37: B1 B0 1C       
                LDAA    M001C                    ; 1C3A: 96 1C          
                CMPA    M001D                    ; 1C3C: 91 1D          
                SBA                              ; 1C3E: 10             
                FCB     $1D                      ; 1C3F: 1D             
                SBA                              ; 1C40: 10             
M1C41           NEGA                             ; 1C41: 40             
                BPL     Z1C64                    ; 1C42: 2A 20          
                BPL     Z1C70                    ; 1C44: 2A 2A          
                BRA     Z1C8D                    ; 1C46: 20 45          
                CLRA                             ; 1C48: 4F             
                RORA                             ; 1C49: 46             
                BRA     Z1C76                    ; 1C4A: 20 2A          
                BPL     Z1C5B                    ; 1C4C: 2A 0D          
                TSX                              ; 1C4E: 30             
                SEC                              ; 1C4F: 0D             
                FCB     $72                      ; 1C50: 72             
                COM     M696F                    ; 1C51: 73 69 6F       
                JMP     $20,X                    ; 1C54: 6E 20          
                BLS     Z1C78                    ; 1C56: 23 20          
                LSR     M6F20                    ; 1C58: 74 6F 20       
Z1C5B           ASLB                             ; 1C5B: 58             
                ASLB                             ; 1C5C: 58             
                FCB     $3A                      ; 1C5D: 3A             
                ASLB                             ; 1C5E: 58             
                ASLB                             ; 1C5F: 58             
                SEC                              ; 1C60: 0D             
                BGT     Z1C91                    ; 1C61: 2E 2E          
                BGT     Z1C72                    ; 1C63: 2E 0D          
                BRA     Z1CAC                    ; 1C65: 20 45          
                BGT     Z1CAC                    ; 1C67: 2E 43          
                TSTA                             ; 1C69: 4D             
                BRA     Z1CE2                    ; 1C6A: 20 76          
                FCB     $65                      ; 1C6C: 65             
                FCB     $72                      ; 1C6D: 72             
                COM     M696F                    ; 1C6E: 73 69 6F       
                JMP     $20,X                    ; 1C71: 6E 20          
                PULB                             ; 1C73: 33             
                BGT     Z1CA7                    ; 1C74: 2E 31          
Z1C76           DES                              ; 1C76: 34             
                BRA     Z1CE8                    ; 1C77: 20 6F          
                FCB     $72                      ; 1C79: 72             
                BRA     Z1CE8                    ; 1C7A: 20 6C          
                FCB     $61                      ; 1C7C: 61             
                LSR     M6572                    ; 1C7D: 74 65 72       
                FCB     $21                      ; 1C80: 21             
                SEC                              ; 1C81: 0D             
                BRA     Z1CF2                    ; 1C82: 20 6E          
                FCB     $75                      ; 1C84: 75             
                TST     $62,X                    ; 1C85: 6D 62          
                FCB     $65                      ; 1C87: 65             
                FCB     $72                      ; 1C88: 72             
                COM     M290D                    ; 1C89: 73 29 0D       
                BVS     Z1C8E                    ; 1C8C: 29 00          
Z1C8E           FCB     $00                      ; 1C8E: 00             
                FCB     $00                      ; 1C8F: 00             
                FCB     $00                      ; 1C90: 00             
Z1C91           FCB     $00                      ; 1C91: 00             
                FCB     $00                      ; 1C92: 00             
                FCB     $00                      ; 1C93: 00             
                FCB     $00                      ; 1C94: 00             
                FCB     $00                      ; 1C95: 00             
                FCB     $00                      ; 1C96: 00             
                FCB     $00                      ; 1C97: 00             
                FCB     $00                      ; 1C98: 00             
                FCB     $00                      ; 1C99: 00             
                FCB     $00                      ; 1C9A: 00             
                FCB     $00                      ; 1C9B: 00             
                FCB     $00                      ; 1C9C: 00             
                FCB     $00                      ; 1C9D: 00             
                FCB     $00                      ; 1C9E: 00             
                FCB     $00                      ; 1C9F: 00             
                FCB     $00                      ; 1CA0: 00             
                FCB     $00                      ; 1CA1: 00             
                FCB     $00                      ; 1CA2: 00             
                FCB     $00                      ; 1CA3: 00             
                FCB     $00                      ; 1CA4: 00             
                FCB     $00                      ; 1CA5: 00             
                FCB     $00                      ; 1CA6: 00             
Z1CA7           FCB     $00                      ; 1CA7: 00             
                FCB     $00                      ; 1CA8: 00             
                FCB     $00                      ; 1CA9: 00             
                FCB     $00                      ; 1CAA: 00             
                FCB     $00                      ; 1CAB: 00             
Z1CAC           FCB     $00                      ; 1CAC: 00             
                FCB     $00                      ; 1CAD: 00             
                FCB     $00                      ; 1CAE: 00             
                FCB     $00                      ; 1CAF: 00             
                FCB     $00                      ; 1CB0: 00             
                FCB     $00                      ; 1CB1: 00             
                FCB     $00                      ; 1CB2: 00             
                FCB     $00                      ; 1CB3: 00             
                FCB     $00                      ; 1CB4: 00             
                FCB     $00                      ; 1CB5: 00             
                FCB     $00                      ; 1CB6: 00             
                FCB     $00                      ; 1CB7: 00             
                FCB     $00                      ; 1CB8: 00             
                FCB     $00                      ; 1CB9: 00             
                FCB     $00                      ; 1CBA: 00             
                FCB     $00                      ; 1CBB: 00             
                FCB     $00                      ; 1CBC: 00             
                FCB     $00                      ; 1CBD: 00             
                FCB     $00                      ; 1CBE: 00             
                FCB     $00                      ; 1CBF: 00             
                FCB     $00                      ; 1CC0: 00             
                FCB     $00                      ; 1CC1: 00             
                FCB     $00                      ; 1CC2: 00             
                FCB     $00                      ; 1CC3: 00             
                FCB     $00                      ; 1CC4: 00             
                FCB     $00                      ; 1CC5: 00             
                FCB     $00                      ; 1CC6: 00             
                FCB     $00                      ; 1CC7: 00             
                FCB     $00                      ; 1CC8: 00             
                FCB     $00                      ; 1CC9: 00             
                FCB     $00                      ; 1CCA: 00             
                FCB     $00                      ; 1CCB: 00             
                FCB     $00                      ; 1CCC: 00             
                FCB     $00                      ; 1CCD: 00             
                FCB     $00                      ; 1CCE: 00             
                FCB     $00                      ; 1CCF: 00             
                FCB     $00                      ; 1CD0: 00             
                FCB     $00                      ; 1CD1: 00             
                FCB     $00                      ; 1CD2: 00             
                FCB     $00                      ; 1CD3: 00             
                FCB     $00                      ; 1CD4: 00             
                FCB     $00                      ; 1CD5: 00             
                FCB     $00                      ; 1CD6: 00             
                FCB     $00                      ; 1CD7: 00             
                FCB     $00                      ; 1CD8: 00             
                FCB     $00                      ; 1CD9: 00             
                FCB     $00                      ; 1CDA: 00             
                FCB     $00                      ; 1CDB: 00             
                FCB     $00                      ; 1CDC: 00             
                FCB     $00                      ; 1CDD: 00             
                FCB     $00                      ; 1CDE: 00             
                FCB     $00                      ; 1CDF: 00             
                FCB     $00                      ; 1CE0: 00             
                FCB     $00                      ; 1CE1: 00             
Z1CE2           FCB     $00                      ; 1CE2: 00             
                FCB     $00                      ; 1CE3: 00             
                FCB     $00                      ; 1CE4: 00             
                FCB     $00                      ; 1CE5: 00             
                FCB     $00                      ; 1CE6: 00             
                FCB     $00                      ; 1CE7: 00             
Z1CE8           FCB     $00                      ; 1CE8: 00             
                FCB     $00                      ; 1CE9: 00             
                FCB     $00                      ; 1CEA: 00             
                FCB     $00                      ; 1CEB: 00             
                FCB     $00                      ; 1CEC: 00             
                FCB     $00                      ; 1CED: 00             
                FCB     $00                      ; 1CEE: 00             
                FCB     $00                      ; 1CEF: 00             
                FCB     $00                      ; 1CF0: 00             
                FCB     $00                      ; 1CF1: 00             
Z1CF2           FCB     $00                      ; 1CF2: 00             
                FCB     $00                      ; 1CF3: 00             
                FCB     $00                      ; 1CF4: 00             
                FCB     $00                      ; 1CF5: 00             
                FCB     $00                      ; 1CF6: 00             
                FCB     $00                      ; 1CF7: 00             
                FCB     $00                      ; 1CF8: 00             
                FCB     $00                      ; 1CF9: 00             
                FCB     $00                      ; 1CFA: 00             
                FCB     $00                      ; 1CFB: 00             
                FCB     $00                      ; 1CFC: 00             
                FCB     $00                      ; 1CFD: 00             
                FCB     $00                      ; 1CFE: 00             
                FCB     $00                      ; 1CFF: 00             
                FCB     $00                      ; 1D00: 00             
                FCB     $00                      ; 1D01: 00             
                FCB     $00                      ; 1D02: 00             
                FCB     $00                      ; 1D03: 00             
                FCB     $00                      ; 1D04: 00             
                FCB     $00                      ; 1D05: 00             
                FCB     $00                      ; 1D06: 00             
                FCB     $00                      ; 1D07: 00             
                FCB     $00                      ; 1D08: 00             
                FCB     $00                      ; 1D09: 00             
                FCB     $00                      ; 1D0A: 00             
                FCB     $00                      ; 1D0B: 00             
                FCB     $00                      ; 1D0C: 00             
                FCB     $00                      ; 1D0D: 00             
                FCB     $00                      ; 1D0E: 00             
                FCB     $00                      ; 1D0F: 00             
                FCB     $00                      ; 1D10: 00             
M1D11           FCB     $00                      ; 1D11: 00             
M1D12           FCB     $00                      ; 1D12: 00             
                FCB     $00                      ; 1D13: 00             
                FCB     $1C                      ; 1D14: 1C             
                SEC                              ; 1D15: 0D             
M1D16           FCB     $00                      ; 1D16: 00             
                FCB     $00                      ; 1D17: 00             
M1D18           FCB     $00                      ; 1D18: 00             
M1D19           FCB     $00                      ; 1D19: 00             
M1D1A           FCB     $00                      ; 1D1A: 00             
M1D1B           FCB     $00                      ; 1D1B: 00             
M1D1C           FCB     $00                      ; 1D1C: 00             
                FCB     $00                      ; 1D1D: 00             
M1D1E           FCB     $45                      ; 1D1E: 45             
                FCB     $4E                      ; 1D1F: 4E             
                LSRA                             ; 1D20: 44             
                BRA     Z1D66                    ; 1D21: 20 43          
                ASLA                             ; 1D23: 48             
                FCB     $41                      ; 1D24: 41             
                ROLA                             ; 1D25: 49             
                FCB     $4E                      ; 1D26: 4E             
                FCB     $04                      ; 1D27: 04             
M1D28           TPA                              ; 1D28: 07             
                TPA                              ; 1D29: 07             
                FCB     $04                      ; 1D2A: 04             
Z1D2B           LDAA    SYERRs                   ; 1D2B: B6 01 14       
                ASLA                             ; 1D2E: 48             
                ASLA                             ; 1D2F: 48             
                ASLA                             ; 1D30: 48             
                ASLA                             ; 1D31: 48             
                COMA                             ; 1D32: 43             
                ANDA    #$F0                     ; 1D33: 84 F0          
                ANDA    SYERRs                   ; 1D35: B4 01 14       
                BEQ     Z1D3F                    ; 1D38: 27 05          
                LDAB    #$31                     ; 1D3A: C6 31          
Z1D3C           JMP     Z1F11                    ; 1D3C: 7E 1F 11       
Z1D3F           SWI                              ; 1D3F: 3F             
                SEC                              ; 1D40: 0D             
                BCC     Z1D47                    ; 1D41: 24 04          
Z1D43           LDAB    #$30                     ; 1D43: C6 30          
                BRA     Z1D3C                    ; 1D45: 20 F5          
Z1D47           LDX     M1C39                    ; 1D47: FE 1C 39       
                STX     M1D16                    ; 1D4A: FF 1D 16       
                LDX     M1C2D                    ; 1D4D: FE 1C 2D       
                DEX                              ; 1D50: 09             
                STX     M1C2D                    ; 1D51: FF 1C 2D       
                LDX     #M1C1C                   ; 1D54: CE 1C 1C       
                LDAB    $01,X                    ; 1D57: E6 01          
                ORAB    #$20                     ; 1D59: CA 20          
                STAB    $01,X                    ; 1D5B: E7 01          
                SWI                              ; 1D5D: 3F             
                TPA                              ; 1D5E: 07             
                BEQ     Z1D65                    ; 1D5F: 27 04          
Z1D61           LDAB    #$00                     ; 1D61: C6 00          
                BRA     Z1D3C                    ; 1D63: 20 D7          
Z1D65           LDX     M1D16                    ; 1D65: FE 1D 16       
                STX     M1C39                    ; 1D68: FF 1C 39       
Z1D6B           JSR     Z1E81                    ; 1D6B: BD 1E 81       
                SWI                              ; 1D6E: 3F             
                SEC                              ; 1D6F: 0D             
                BCS     Z1D43                    ; 1D70: 25 D1          
                LDX     #M1C41                   ; 1D72: CE 1C 41       
                LDAA    ,X                       ; 1D75: A6 00          
                CMPA    #$40                     ; 1D77: 81 40          
                BEQ     Z1DBE                    ; 1D79: 27 43          
                CMPA    #$5C                     ; 1D7B: 81 5C          
                BNE     Z1D80                    ; 1D7D: 26 01          
                INX                              ; 1D7F: 08             
Z1D80           STX     M1D16                    ; 1D80: FF 1D 16       
                TSX                              ; 1D83: 30             
                LDAB    $03,X                    ; 1D84: E6 03          
                LDX     $05,X                    ; 1D86: EE 05          
Z1D88           BSR     Z1DAE                    ; 1D88: 8D 24          
                STAA    ,X                       ; 1D8A: A7 00          
                CMPA    #$0D                     ; 1D8C: 81 0D          
                BEQ     Z1D97                    ; 1D8E: 27 07          
                TSTB                             ; 1D90: 5D             
                BEQ     Z1DA9                    ; 1D91: 27 16          
                INX                              ; 1D93: 08             
                DECB                             ; 1D94: 5A             
                BRA     Z1D88                    ; 1D95: 20 F1          
Z1D97           LDAA    CHFLGs                   ; 1D97: B6 01 1E       
                ANDA    #$7F                     ; 1D9A: 84 7F          
                STAA    CHFLGs                   ; 1D9C: B7 01 1E       
                TSX                              ; 1D9F: 30             
                LDAA    $03,X                    ; 1DA0: A6 03          
                SBA                              ; 1DA2: 10             
                TAB                              ; 1DA3: 16             
                LDAA    $04,X                    ; 1DA4: A6 04          
                LDX     $05,X                    ; 1DA6: EE 05          
                RTS                              ; 1DA8: 39             
Z1DA9           LDAB    #$29                     ; 1DA9: C6 29          
Z1DAB           JMP     Z1F11                    ; 1DAB: 7E 1F 11       
Z1DAE           STX     M1D18                    ; 1DAE: FF 1D 18       
                LDX     M1D16                    ; 1DB1: FE 1D 16       
                LDAA    ,X                       ; 1DB4: A6 00          
                INX                              ; 1DB6: 08             
                STX     M1D16                    ; 1DB7: FF 1D 16       
                LDX     M1D18                    ; 1DBA: FE 1D 18       
                RTS                              ; 1DBD: 39             
Z1DBE           LDAA    $01,X                    ; 1DBE: A6 01          
                CMPA    #$2A                     ; 1DC0: 81 2A          
                BEQ     Z1DF2                    ; 1DC2: 27 2E          
                CMPA    #$2E                     ; 1DC4: 81 2E          
                BEQ     Z1DF2                    ; 1DC6: 27 2A          
                JSR     Z1EF1                    ; 1DC8: BD 1E F1       
                CMPA    #$4A                     ; 1DCB: 81 4A          
                BEQ     Z1E43                    ; 1DCD: 27 74          
                CMPA    #$43                     ; 1DCF: 81 43          
                BEQ     Z1E39                    ; 1DD1: 27 66          
                CMPA    #$4C                     ; 1DD3: 81 4C          
                BEQ     Z1E36                    ; 1DD5: 27 5F          
                STX     M1D1A                    ; 1DD7: FF 1D 1A       
                JSR     Z1EF8                    ; 1DDA: BD 1E F8       
                CMPA    #$53                     ; 1DDD: 81 53          
                BNE     Z1DE4                    ; 1DDF: 26 03          
                JMP     Z1E64                    ; 1DE1: 7E 1E 64       
Z1DE4           STX     M1D1C                    ; 1DE4: FF 1D 1C       
                JSR     Z1EF8                    ; 1DE7: BD 1E F8       
                CMPA    #$54                     ; 1DEA: 81 54          
                BEQ     Z1E13                    ; 1DEC: 27 25          
                LDAB    #$32                     ; 1DEE: C6 32          
                BRA     Z1DAB                    ; 1DF0: 20 B9          
Z1DF2           PSHA                             ; 1DF2: 36             
                LDAB    M1C18                    ; 1DF3: F6 1C 18       
                BEQ     Z1DFD                    ; 1DF6: 27 05          
                LDX     #M1C41                   ; 1DF8: CE 1C 41       
                SWI                              ; 1DFB: 3F             
                CLV                              ; 1DFC: 0A             
Z1DFD           PULA                             ; 1DFD: 32             
                CMPA    #$2E                     ; 1DFE: 81 2E          
                BNE     Z1E36                    ; 1E00: 26 34          
                LDX     #M1D28                   ; 1E02: CE 1D 28       
                SWI                              ; 1E05: 3F             
                SEV                              ; 1E06: 0B             
                SWI                              ; 1E07: 3F             
                SEC                              ; 1E08: 0D             
                BCC     Z1E0E                    ; 1E09: 24 03          
                JMP     Z1D43                    ; 1E0B: 7E 1D 43       
Z1E0E           JSR     XINCHN                   ; 1E0E: BD F0 15       
                BRA     Z1E36                    ; 1E11: 20 23          
Z1E13           TPA                              ; 1E13: 07             
                PSHA                             ; 1E14: 36             
                SEI                              ; 1E15: 0F             
                LDAA    M1D19                    ; 1E16: B6 1D 19       
                STAA    M1E2D                    ; 1E19: B7 1E 2D       
                LDAB    SYERRs                   ; 1E1C: F6 01 14       
                LDAA    M0115                    ; 1E1F: B6 01 15       
                ANDB    M1D1A                    ; 1E22: F4 1D 1A       
                ANDA    M1D1B                    ; 1E25: B4 1D 1B       
                LDX     M1D1C                    ; 1E28: FE 1D 1C       
                SWI                              ; 1E2B: 3F             
                BLE     Z1E4E                    ; 1E2C: 2F 20          
                FCB     $02                      ; 1E2E: 02             
                BRA     Z1E34                    ; 1E2F: 20 03          
                JSR     Z1E7E                    ; 1E31: BD 1E 7E       
Z1E34           PULA                             ; 1E34: 32             
                TAP                              ; 1E35: 06             
Z1E36           JMP     Z1D6B                    ; 1E36: 7E 1D 6B       
Z1E39           LDAA    M1D19                    ; 1E39: B6 1D 19       
                ANDA    #$01                     ; 1E3C: 84 01          
                STAA    M1C18                    ; 1E3E: B7 1C 18       
                BRA     Z1E36                    ; 1E41: 20 F3          
Z1E43           STX     M1D1C                    ; 1E43: FF 1D 1C       
                INC     Z1C19                    ; 1E46: 7C 1C 19       
Z1E49           JSR     Z1E7E                    ; 1E49: BD 1E 7E       
                LDX     M1C41                    ; 1E4C: FE 1C 41       
                CPX     #M404C                   ; 1E4F: 8C 40 4C       
                BNE     Z1E49                    ; 1E52: 26 F5          
                LDX     #M1C41                   ; 1E54: CE 1C 41       
                JSR     Z1EF1                    ; 1E57: BD 1E F1       
                CPX     M1D1C                    ; 1E5A: BC 1D 1C       
                BNE     Z1E49                    ; 1E5D: 26 EA          
                CLR     Z1C19                    ; 1E5F: 7F 1C 19       
                BRA     Z1E36                    ; 1E62: 20 D2          
Z1E64           LDAA    SYERRs                   ; 1E64: B6 01 14       
                LDAB    M0115                    ; 1E67: F6 01 15       
                ANDA    M1D1A                    ; 1E6A: B4 1D 1A       
                ANDB    M1D1B                    ; 1E6D: F4 1D 1B       
                ORAA    M1D18                    ; 1E70: BA 1D 18       
                ORAB    M1D19                    ; 1E73: FA 1D 19       
                STAA    SYERRs                   ; 1E76: B7 01 14       
                STAB    M0115                    ; 1E79: F7 01 15       
                BRA     Z1E36                    ; 1E7C: 20 B8          
Z1E7E           CLRA                             ; 1E7E: 4F             
                BRA     Z1E83                    ; 1E7F: 20 02          
Z1E81           LDAA    #$01                     ; 1E81: 86 01          
Z1E83           PSHA                             ; 1E83: 36             
                LDX     #M1C1C                   ; 1E84: CE 1C 1C       
                LDAB    $01,X                    ; 1E87: E6 01          
                ANDB    #$DF                     ; 1E89: C4 DF          
                STAB    $01,X                    ; 1E8B: E7 01          
                SWI                              ; 1E8D: 3F             
                FCB     $04                      ; 1E8E: 04             
                BNE     Z1EB6                    ; 1E8F: 26 25          
                PULA                             ; 1E91: 32             
                TSTA                             ; 1E92: 4D             
                BEQ     Z1E9F                    ; 1E93: 27 0A          
                LDAA    M1C18                    ; 1E95: B6 1C 18       
                BNE     Z1E9F                    ; 1E98: 26 05          
                LDX     #M1C41                   ; 1E9A: CE 1C 41       
                SWI                              ; 1E9D: 3F             
                CLV                              ; 1E9E: 0A             
Z1E9F           LDX     M1C16                    ; 1E9F: FE 1C 16       
                INX                              ; 1EA2: 08             
                STX     M1C16                    ; 1EA3: FF 1C 16       
                LDX     M1C1A                    ; 1EA6: FE 1C 1A       
                STX     M1D12                    ; 1EA9: FF 1D 12       
                LDX     #M1D11                   ; 1EAC: CE 1D 11       
                CLRB                             ; 1EAF: 5F             
                SWI                              ; 1EB0: 3F             
                SEI                              ; 1EB1: 0F             
                LDX     #M1C41                   ; 1EB2: CE 1C 41       
                RTS                              ; 1EB5: 39             
Z1EB6           CMPB    #$09                     ; 1EB6: C1 09          
                BNE     Z1EEE                    ; 1EB8: 26 34          
                LDAA    Z1C19                    ; 1EBA: B6 1C 19       
                BEQ     Z1EC4                    ; 1EBD: 27 05          
                LDAB    #$33                     ; 1EBF: C6 33          
Z1EC1           JMP     Z1F11                    ; 1EC1: 7E 1F 11       
Z1EC4           LDAA    CHFLGs                   ; 1EC4: B6 01 1E       
                BMI     Z1ECD                    ; 1EC7: 2B 04          
                LDAB    #$34                     ; 1EC9: C6 34          
                BRA     Z1EC1                    ; 1ECB: 20 F4          
Z1ECD           LDAA    M1C1D                    ; 1ECD: B6 1C 1D       
                ORAA    #$08                     ; 1ED0: 8A 08          
                STAA    M1C1D                    ; 1ED2: B7 1C 1D       
                LDX     #MFFFF                   ; 1ED5: CE FF FF       
                STX     M1C27                    ; 1ED8: FF 1C 27       
                LDX     #M1C1C                   ; 1EDB: CE 1C 1C       
                SWI                              ; 1EDE: 3F             
                FCB     $03                      ; 1EDF: 03             
                BNE     Z1EEE                    ; 1EE0: 26 0C          
                SWI                              ; 1EE2: 3F             
                NOP                              ; 1EE3: 01             
                BNE     Z1EEE                    ; 1EE4: 26 08          
                LDX     #M1D1E                   ; 1EE6: CE 1D 1E       
                SWI                              ; 1EE9: 3F             
                SEV                              ; 1EEA: 0B             
                JMP     Z1F13                    ; 1EEB: 7E 1F 13       
Z1EEE           JMP     Z1D61                    ; 1EEE: 7E 1D 61       
Z1EF1           LDAB    #$04                     ; 1EF1: C6 04          
                SWI                              ; 1EF3: 3F             
                BEQ     Z1EF5                    ; 1EF4: 27 FF          
                FCB     $1D                      ; 1EF6: 1D             
                TAB                              ; 1EF7: 16             
Z1EF8           LDX     M1D16                    ; 1EF8: FE 1D 16       
                INX                              ; 1EFB: 08             
                STX     M1D16                    ; 1EFC: FF 1D 16       
                LDX     #M1D16                   ; 1EFF: CE 1D 16       
                PSHA                             ; 1F02: 36             
                JSR     Z1F28                    ; 1F03: BD 1F 28       
                PULA                             ; 1F06: 32             
                BNE     Z1F0D                    ; 1F07: 26 04          
                LDX     M1D18                    ; 1F09: FE 1D 18       
                RTS                              ; 1F0C: 39             
Z1F0D           LDAB    #$0B                     ; 1F0D: C6 0B          
                BRA     Z1F11                    ; 1F0F: 20 00          
Z1F11           SWI                              ; 1F11: 3F             
Z1F12           BRA     Z1F12                    ; 1F12: 20 FE          
                NOP                              ; 1F14: 01             
                FCB     $04                      ; 1F15: 04             
                STX     M0291                    ; 1F16: FF 02 91       
                CLR     CHFLGs                   ; 1F19: 7F 01 1E       
                CLR     SYERRs                   ; 1F1C: 7F 01 14       
                LDX     #M1C1C                   ; 1F1F: CE 1C 1C       
                SWI                              ; 1F22: 3F             
                FCB     $03                      ; 1F23: 03             
                SWI                              ; 1F24: 3F             
                NOP                              ; 1F25: 01             
                SWI                              ; 1F26: 3F             
                FCB     $1A                      ; 1F27: 1A             
Z1F28           CLR     $02,X                    ; 1F28: 6F 02          
                CLR     $03,X                    ; 1F2A: 6F 03          
                LDAB    #$04                     ; 1F2C: C6 04          
                LDX     ,X                       ; 1F2E: EE 00          
Z1F30           LDAA    ,X                       ; 1F30: A6 00          
                SUBA    #$30                     ; 1F32: 80 30          
                BMI     Z1F5E                    ; 1F34: 2B 28          
                CMPA    #$09                     ; 1F36: 81 09          
                BLS     Z1F44                    ; 1F38: 23 0A          
                SUBA    #$11                     ; 1F3A: 80 11          
                BMI     Z1F5E                    ; 1F3C: 2B 20          
                CMPA    #$05                     ; 1F3E: 81 05          
                BGT     Z1F5E                    ; 1F40: 2E 1C          
                ADDA    #$0A                     ; 1F42: 8B 0A          
Z1F44           INX                              ; 1F44: 08             
                STX     M1D16                    ; 1F45: FF 1D 16       
                PSHB                             ; 1F48: 37             
                LDAB    #$04                     ; 1F49: C6 04          
Z1F4B           ASL     M1D19                    ; 1F4B: 78 1D 19       
                ROL     M1D18                    ; 1F4E: 79 1D 18       
                DECB                             ; 1F51: 5A             
                BNE     Z1F4B                    ; 1F52: 26 F7          
                ADDA    M1D19                    ; 1F54: BB 1D 19       
                STAA    M1D19                    ; 1F57: B7 1D 19       
                PULB                             ; 1F5A: 33             
                DECB                             ; 1F5B: 5A             
                BNE     Z1F30                    ; 1F5C: 26 D2          
Z1F5E           RTS                              ; 1F5E: 39             
                FCB     $00                      ; 1F5F: 00             
                FCB     $00                      ; 1F60: 00             
                FCB     $00                      ; 1F61: 00             
                FCB     $00                      ; 1F62: 00             
                FCB     $00                      ; 1F63: 00             
                FCB     $00                      ; 1F64: 00             


                END
