dasmfw: Disassembler Framework V0.35
Loaded: binary file "EXBUG"
Loaded: Info file "exbug.info"

;****************************************************
; Used Labels
;****************************************************

MF448   EQU     $F448
ZF5C2   EQU     $F5C2

;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $2000

                LDX     #MF448                   ; 2000: CE F4 48       
                STX     SWIsVC                   ; 2003: FF FF FA       
                JMP     ZF5C2                    ; 2006: 7E F5 C2       
                FCB     $00                      ; 2009: 00             
                FCB     $00                      ; 200A: 00             
                FCB     $00                      ; 200B: 00             
                FCB     $00                      ; 200C: 00             
                FCB     $00                      ; 200D: 00             
                FCB     $00                      ; 200E: 00             
                FCB     $00                      ; 200F: 00             


                END
