         include "mdoseq.inc"

         ORG  $2000
START    LDX  #PROMPT
         SCALL DSPLY1 ; SHOW INPUT PROMPT
;
; INPUT THE STRING FROM CONSOLE
;
INPUT    LDAB #10      ; MAX 10 CHAR
         LDX  #IBUFF
         SCALL KEYIN1 ; GET INPUT STRING
         TSTB          ; CHECK FOR ZERO INPUT
         BNE  SWAP
         SCALL MDENT1 ; EXIT IF NO INPUT
;
; INVERT STRING INTO OBUFF
;
SWAP     LDX  #OBUFF
         SCALL ADBX1 ; POINT TO END OF OBUFF
         LDAA #$0D    ; STORE TERMINATOR
         STAA ,X
         DEX
         STS  STKSAV  ; SAVE STACK POINTER
         LDS  #IBUFF-1
LOOP     PULA         ; GET CHAR
         STAA ,X      ; STORE CHAR
         DEX          ; BUMP POINTER
         DECB
         BNE  LOOP    ; LOOP UNTIL ZERO
         LDS  STKSAV  ; RESTORE STACK
         LDX  #OBUFF
         SCALL DSPLY1 ; SHOW INVERTED STRING
         BRA  INPUT
;
; WORKING STORAGE
;                 

IBUFF    RMB  10+1         ; INPUT BUFFER
OBUFF    RMB  10+1         ; OUTPUT BUFFER
PROMPT   FCC  'ENTER STRINGS < 11 CHARACTERS'
         FCB  $0D          ; CR
STKSAV   FDB  0            ; SAVE AREA
         RMB  80           ; STACK SET HERE BY LOAD

         END  START        ; BEGIN EXECUTION AT THIS LABEL