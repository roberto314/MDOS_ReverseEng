
;****************************************************
; Program's Code Areas
;****************************************************


                ORG     $1FFD

         FCC '0B '                                                        ; Index for SCALL MDERR
         FCC '01 '                                                        ; Error Number Displayed
         FCC 'COMMAND SYNTAX ERROR'                                       ; Text
         FCB  $0d,$0a                                                     ; Terminator
         FCC '05 '                                                        ; 
         FCC '02 '                                                        ; 
         FCC 'NAME REQUIRED'                                              ; 
         FCB  $0d,$0a                                                     ; 
         FCC '06 '                                                        ; 
         FCC '03 '                                                        ; 
         FCC '\\0 DOES NOT EXIST'                                         ; 
         FCB  $0d,$0a                                                     ; 
         FCC '1B '                                                        ; 
         FCC '04 '                                                        ; 
         FCC 'FILE NAME NOT FOUND'                                        ; 
         FCB  $0d,$0a                                                     ; 
         FCC '08 '                                                        ; 
         FCC '05 '                                                        ; 
         FCC '\\0 DUPLICATE FILE NAME'                                    ; 
         FCB  $0d,$0a                                                     ; 
         FCC '1A '                                                        ; 
         FCC '06 '                                                        ; 
         FCC 'DUPLICATE FILE NAME'                                        ; 
         FCB  $0d,$0a                                                     ; 
         FCC '0D '                                                        ; 
         FCC '07 '                                                        ; 
         FCC 'OPTION CONFLICT'                                            ; 
         FCB  $0d,$0a                                                     ; 
         FCC '30 '                                                        ; 
         FCC '08 '                                                        ; 
         FCC 'CHAIN ABORTED BY BREAK KEY'                                 ; 
         FCB  $0d,$0a                                                     ; 
         FCC '31 '                                                        ; 
         FCC '09 '                                                        ; 
         FCC 'CHAIN ABORTED BY SYSTEM ERROR STATUS WORD'                  ; 
         FCB  $0d,$0a                                                     ; 
         FCC '1C '                                                        ; 
         FCC '10 '                                                        ; 
         FCC 'FILE IS DELETE PROTECTED'                                   ; 
         FCB  $0d,$0a                                                     ; 
         FCC '24 '                                                        ; 
         FCC '11 '                                                        ; 
         FCC 'DEVICE NOT READY'                                           ; 
         FCB  $0d,$0a                                                     ; 
         FCC '0E '                                                        ; 
         FCC '12 '                                                        ; 
         FCC 'INVALID TYPE OF OBJECT FILE'                                ; 
         FCB  $0d,$0a                                                     ; 
         FCC '0F '                                                        ; 
         FCC '13 '                                                        ; 
         FCC 'INVALID LOAD ADDRESS'                                       ; 
         FCB  $0d,$0a                                                     ; 
         FCC '13 '                                                        ; 
         FCC '14 '                                                        ; 
         FCC 'INVALID FILE TYPE'                                          ; 
         FCB  $0d,$0a                                                     ; 
         FCC '1F '                                                        ; 
         FCC '15 '                                                        ; 
         FCC '\\0 HAS INVALID FILE TYPE'                                  ; 
         FCB  $0d,$0a                                                     ; 
         FCC '1E '                                                        ; 
         FCC '16 '                                                        ; 
         FCC 'CONFLICTING FILE TYPES'                                     ; 
         FCB  $0d,$0a                                                     ; 
         FCC '27 '                                                        ; 
         FCC '17 '                                                        ; 
         FCC 'INVALID DATA TRANSFER TYPE'                                 ; 
         FCB  $0d,$0a                                                     ; 
         FCC '22 '                                                        ; 
         FCC '18 '                                                        ; 
         FCC 'DEVICE ALREADY RESERVED'                                    ; 
         FCB  $0d,$0a                                                     ; 
         FCC '23 '                                                        ; 
         FCC '19 '                                                        ; 
         FCC 'DEVICE NOT RESERVED'                                        ; 
         FCB  $0d,$0a                                                     ; 
         FCC '25 '                                                        ; 
         FCC '20 '                                                        ; 
         FCC 'INVALID OPEN/CLOSED FLAG'                                   ; 
         FCB  $0d,$0a                                                     ; 
         FCC '26 '                                                        ; 
         FCC '21 '                                                        ; 
         FCC 'END OF FILE'                                                ; 
         FCB  $0d,$0a                                                     ; 
         FCC '29 '                                                        ; 
         FCC '22 '                                                        ; 
         FCC 'BUFFER OVERFLOW'                                            ; 
         FCB  $0d,$0a                                                     ; 
         FCC '2A '                                                        ; 
         FCC '23 '                                                        ; 
         FCC 'CHECKSUM ERROR'                                             ; 
         FCB  $0d,$0a                                                     ; 
         FCC '15 '                                                        ; 
         FCC '24 '                                                        ; 
         FCC 'LOGICAL SECTOR NUMBER OUT OF RANGE'                         ; 
         FCB  $0d,$0a                                                     ; 
         FCC '07 '                                                        ; 
         FCC '25 '                                                        ; 
         FCC 'INVALID FILE NAME'                                          ; 
         FCB  $0d,$0a                                                     ; 
         FCC '2B '                                                        ; 
         FCC '26 '                                                        ; 
         FCC 'FILE IS WRITE PROTECTED'                                    ; 
         FCB  $0d,$0a                                                     ; 
         FCC '20 '                                                        ; 
         FCC '27 '                                                        ; 
         FCC '\\0 IS WRITE PROTECTED'                                     ; 
         FCB  $0d,$0a                                                     ; 
         FCC '09 '                                                        ; 
         FCC '28 '                                                        ; 
         FCC 'DEVICE NAME NOT FOUND'                                      ; 
         FCB  $0d,$0a                                                     ; 
         FCC '04 '                                                        ; 
         FCC '29 '                                                        ; 
         FCC 'INVALID LOGICAL UNIT NUMBER'                                ; 
         FCB  $0d,$0a                                                     ; 
         FCC '12 '                                                        ; 
         FCC '30 '                                                        ; 
         FCC 'INVALID EXECUTION ADDRESS'                                  ; 
         FCB  $0d,$0a                                                     ; 
         FCC '0A '                                                        ; 
         FCC '31 '                                                        ; 
         FCC 'INVALID DEVICE'                                             ; 
         FCB  $0d,$0a                                                     ; 
         FCC '11 '                                                        ; 
         FCC '32 '                                                        ; 
         FCC 'INVALID RIB'                                                ; 
         FCB  $0d,$0a                                                     ; 
         FCC '1D '                                                        ; 
         FCC '33 '                                                        ; 
         FCC 'TOO MANY SOURCE FILES'                                      ; 
         FCB  $0d,$0a                                                     ; 
         FCC '16 '                                                        ; 
         FCC '34 '                                                        ; 
         FCC 'INVALID START/END SPECIFICATIONS'                           ; 
         FCB  $0d,$0a                                                     ; 
         FCC '17 '                                                        ; 
         FCC '35 '                                                        ; 
         FCC 'INVALID PAGE FORMAT'                                        ; 
         FCB  $0d,$0a                                                     ; 
         FCC '14 '                                                        ; 
         FCC '36 '                                                        ; 
         FCC 'FILE EXHAUSTED BEFORE LINE FOUND'                           ; 
         FCB  $0d,$0a                                                     ; 
         FCC '28 '                                                        ; 
         FCC '37 '                                                        ; 
         FCC 'END OF MEDIA'                                               ; 
         FCB  $0d,$0a                                                     ; 
         FCC '18 '                                                        ; 
         FCC '38 '                                                        ; 
         FCC 'INVALID LINE NUMBER OR RANGE'                               ; 
         FCB  $0d,$0a                                                     ; 
         FCC '19 '                                                        ; 
         FCC '39 '                                                        ; 
         FCC 'LINE NUMBER ENTERED BEFORE SOURCE FILE'                     ; 
         FCB  $0d,$0a                                                     ; 
         FCC '02 '                                                        ; 
         FCC '40 '                                                        ; 
         FCC 'DIRECTORY SPACE FULL'                                       ; 
         FCB  $0d,$0a                                                     ; 
         FCC '03 '                                                        ; 
         FCC '41 '                                                        ; 
         FCC 'INSUFFICIENT DISK SPACE'                                    ; 
         FCB  $0d,$0a                                                     ; 
         FCC '10 '                                                        ; 
         FCC '42 '                                                        ; 
         FCC 'SEGMENT DESCRIPTOR SPACE FULL'                              ; 
         FCB  $0d,$0a                                                     ; 
         FCC '2C '                                                        ; 
         FCC '43 '                                                        ; 
         FCC 'INVALID DIRECTORY ENTRY NO. AT \\8'                         ; 
         FCB  $0d,$0a                                                     ; 
         FCC '2D '                                                        ; 
         FCC '44 '                                                        ; 
         FCC 'CANNOT DEALLOCATE ALL SPACE, DIRECTORY ENTRY EXISTS AT \\8' ; 
         FCB  $0d,$0a                                                     ; 
         FCC '2E '                                                        ; 
         FCC '45 '                                                        ; 
         FCC 'RECORD LENGTH TOO LARGE'                                    ; 
         FCB  $0d,$0a                                                     ; 
         FCC '0C '                                                        ; 
         FCC '46 '                                                        ; 
         FCC 'INTERNAL SYSTEM ERROR AT \\8'                               ; 
         FCB  $0d,$0a                                                     ; 
         FCC '21 '                                                        ; 
         FCC '47 '                                                        ; 
         FCC 'INVALID SCALL'                                              ; 
         FCB  $0d,$0a                                                     ; 
         FCC '2F '                                                        ; 
         FCC '48 '                                                        ; 
         FCC 'CHAIN OVERLAY DOES NOT EXIST'                               ; 
         FCB  $0d,$0a                                                     ; 
         FCC '32 '                                                        ; 
         FCC '49 '                                                        ; 
         FCC 'CHAIN ABORTED BY ILLEGAL OPERATOR'                          ; 
         FCB  $0d,$0a                                                     ; 
         FCC '33 '                                                        ; 
         FCC '50 '                                                        ; 
         FCC 'CHAIN ABORTED BY UNDEFINED LABEL'                           ; 
         FCB  $0d,$0a                                                     ; 
         FCC '34 '                                                        ; 
         FCC '51 '                                                        ; 
         FCC 'CHAIN ABORTED BY PREMATURE END OF FILE'                     ; 
         FCB  $0d,$0a                                                     ; 
         FCC '35 '                                                        ; 
         FCC '52 '                                                        ; 
         FCC 'SECTOR BUFFER SIZE ERROR'                                   ; 
         FCB  $0d,$0a                                                     ; 
         FCC '36 '                                                        ; 
         FCC '53 '                                                        ; 
         FCC 'INSUFFICIENT MEMORY'                                        ; 
         FCB  $0d,$0a                                                     ; 

;Z1FFD           FCB     '0,'B,' ,'0,'1,' ,'C,'O  ; 1FFD: 30 42 20 30 31 20 43 4F              
;                FCB     'M,'M,'A,'N,'D,' ,'S,'Y  ; 2005: 4D 4D 41 4E 44 20 53 59 
;                FCB     'N,'T,'A,'X,' ,'E,'R,'R  ; 200D: 4E 54 41 58 20 45 52 52 
;                FCB     'O,'R                    ; 2015: 4F 52          
;                FCB     $0d,$0a                  ; 2017: 0D 0A          
;                FCB     '0,'5,' ,'0,'2,' ,'N,'A  ; 2019: 30 35 20 30 32 20 4E 41 
;                FCB     'M,'E,' ,'R,'E,'Q,'U,'I  ; 2021: 4D 45 20 52 45 51 55 49 
;                FCB     'R,'E,'D                 ; 2029: 52 45 44       
;                FCB     $0d,$0a                  ; 202C: 0D 0A          
;                FCB     '0,'6,' ,'0,'3,' ,'\,'0  ; 202E: 30 36 20 30 33 20 5C 30 
;                FCB     ' ,'D,'O,'E,'S,' ,'N,'O  ; 2036: 20 44 4F 45 53 20 4E 4F 
;                FCB     'T,' ,'E,'X,'I,'S,'T     ; 203E: 54 20 45 58 49 53 54 
;                FCB     $0d,$0a                  ; 2045: 0D 0A          
;                FCB     '1,'B,' ,'0,'4,' ,'F,'I  ; 2047: 31 42 20 30 34 20 46 49 
;                FCB     'L,'E,' ,'N,'A,'M,'E,'   ; 204F: 4C 45 20 4E 41 4D 45 20 
;                FCB     'N,'O,'T,' ,'F,'O,'U,'N  ; 2057: 4E 4F 54 20 46 4F 55 4E 
;                FCB     'D                       ; 205F: 44             
;                FCB     $0d,$0a                  ; 2060: 0D 0A          
;                FCB     '0,'8,' ,'0,'5,' ,'\,'0  ; 2062: 30 38 20 30 35 20 5C 30 
;                FCB     ' ,'D,'U,'P,'L,'I,'C,'A  ; 206A: 20 44 55 50 4C 49 43 41 
;                FCB     'T,'E,' ,'F,'I,'L,'E,'   ; 2072: 54 45 20 46 49 4C 45 20 
;                FCB     'N,'A,'M,'E              ; 207A: 4E 41 4D 45    
;                FCB     $0d,$0a                  ; 207E: 0D 0A          
;                FCB     '1,'A,' ,'0,'6,' ,'D,'U  ; 2080: 31 41 20 30 36 20 44 55 
;                FCB     'P,'L,'I,'C,'A,'T,'E,'   ; 2088: 50 4C 49 43 41 54 45 20 
;                FCB     'F,'I,'L,'E,' ,'N,'A,'M  ; 2090: 46 49 4C 45 20 4E 41 4D 
;                FCB     'E                       ; 2098: 45             
;                FCB     $0d,$0a                  ; 2099: 0D 0A          
;                FCB     '0,'D,' ,'0,'7,' ,'O,'P  ; 209B: 30 44 20 30 37 20 4F 50 
;                FCB     'T,'I,'O,'N,' ,'C,'O,'N  ; 20A3: 54 49 4F 4E 20 43 4F 4E 
;                FCB     'F,'L,'I,'C,'T           ; 20AB: 46 4C 49 43 54 
;                FCB     $0d,$0a                  ; 20B0: 0D 0A          
;                FCB     '3,'0,' ,'0,'8,' ,'C,'H  ; 20B2: 33 30 20 30 38 20 43 48 
;                FCB     'A,'I,'N,' ,'A,'B,'O,'R  ; 20BA: 41 49 4E 20 41 42 4F 52 
;                FCB     'T,'E,'D,' ,'B,'Y,' ,'B  ; 20C2: 54 45 44 20 42 59 20 42 
;                FCB     'R,'E,'A,'K,' ,'K,'E,'Y  ; 20CA: 52 45 41 4B 20 4B 45 59 
;                FCB     $0d,$0a                  ; 20D2: 0D 0A          
;                FCB     '3,'1,' ,'0,'9,' ,'C,'H  ; 20D4: 33 31 20 30 39 20 43 48 
;                FCB     'A,'I,'N,' ,'A,'B,'O,'R  ; 20DC: 41 49 4E 20 41 42 4F 52 
;                FCB     'T,'E,'D,' ,'B,'Y,' ,'S  ; 20E4: 54 45 44 20 42 59 20 53 
;                FCB     'Y,'S,'T,'E,'M,' ,'E,'R  ; 20EC: 59 53 54 45 4D 20 45 52 
;                FCB     'R,'O,'R,' ,'S,'T,'A,'T  ; 20F4: 52 4F 52 20 53 54 41 54 
;                FCB     'U,'S,' ,'W,'O,'R,'D     ; 20FC: 55 53 20 57 4F 52 44 
;                FCB     $0d,$0a                  ; 2103: 0D 0A          
;                FCB     '1,'C,' ,'1,'0,' ,'F,'I  ; 2105: 31 43 20 31 30 20 46 49 
;                FCB     'L,'E,' ,'I,'S,' ,'D,'E  ; 210D: 4C 45 20 49 53 20 44 45 
;                FCB     'L,'E,'T,'E,' ,'P,'R,'O  ; 2115: 4C 45 54 45 20 50 52 4F 
;                FCB     'T,'E,'C,'T,'E,'D        ; 211D: 54 45 43 54 45 44 
;                FCB     $0d,$0a                  ; 2123: 0D 0A          
;                FCB     '2,'4,' ,'1,'1,' ,'D,'E  ; 2125: 32 34 20 31 31 20 44 45 
;                FCB     'V,'I,'C,'E,' ,'N,'O,'T  ; 212D: 56 49 43 45 20 4E 4F 54 
;                FCB     ' ,'R,'E,'A,'D,'Y        ; 2135: 20 52 45 41 44 59 
;                FCB     $0d,$0a                  ; 213B: 0D 0A          
;                FCB     '0,'E,' ,'1,'2,' ,'I,'N  ; 213D: 30 45 20 31 32 20 49 4E 
;                FCB     'V,'A,'L,'I,'D,' ,'T,'Y  ; 2145: 56 41 4C 49 44 20 54 59 
;                FCB     'P,'E,' ,'O,'F,' ,'O,'B  ; 214D: 50 45 20 4F 46 20 4F 42 
;                FCB     'J,'E,'C,'T,' ,'F,'I,'L  ; 2155: 4A 45 43 54 20 46 49 4C 
;                FCB     'E                       ; 215D: 45             
;                FCB     $0d,$0a                  ; 215E: 0D 0A          
;                FCB     '0,'F,' ,'1,'3,' ,'I,'N  ; 2160: 30 46 20 31 33 20 49 4E 
;                FCB     'V,'A,'L,'I,'D,' ,'L,'O  ; 2168: 56 41 4C 49 44 20 4C 4F 
;                FCB     'A,'D,' ,'A,'D,'D,'R,'E  ; 2170: 41 44 20 41 44 44 52 45 
;                FCB     'S,'S                    ; 2178: 53 53          
;                FCB     $0d,$0a                  ; 217A: 0D 0A          
;                FCB     '1,'3,' ,'1,'4,' ,'I,'N  ; 217C: 31 33 20 31 34 20 49 4E 
;                FCB     'V,'A,'L,'I,'D,' ,'F,'I  ; 2184: 56 41 4C 49 44 20 46 49 
;                FCB     'L,'E,' ,'T,'Y,'P,'E     ; 218C: 4C 45 20 54 59 50 45 
;                FCB     $0d,$0a                  ; 2193: 0D 0A          
;                FCB     '1,'F,' ,'1,'5,' ,'\,'0  ; 2195: 31 46 20 31 35 20 5C 30 
;                FCB     ' ,'H,'A,'S,' ,'I,'N,'V  ; 219D: 20 48 41 53 20 49 4E 56 
;                FCB     'A,'L,'I,'D,' ,'F,'I,'L  ; 21A5: 41 4C 49 44 20 46 49 4C 
;                FCB     'E,' ,'T,'Y,'P,'E        ; 21AD: 45 20 54 59 50 45 
;                FCB     $0d,$0a                  ; 21B3: 0D 0A          
;                FCB     '1,'E,' ,'1,'6,' ,'C,'O  ; 21B5: 31 45 20 31 36 20 43 4F 
;                FCB     'N,'F,'L,'I,'C,'T,'I,'N  ; 21BD: 4E 46 4C 49 43 54 49 4E 
;                FCB     'G,' ,'F,'I,'L,'E,' ,'T  ; 21C5: 47 20 46 49 4C 45 20 54 
;                FCB     'Y,'P,'E,'S              ; 21CD: 59 50 45 53    
;                FCB     $0d,$0a                  ; 21D1: 0D 0A          
;                FCB     '2,'7,' ,'1,'7,' ,'I,'N  ; 21D3: 32 37 20 31 37 20 49 4E 
;                FCB     'V,'A,'L,'I,'D,' ,'D,'A  ; 21DB: 56 41 4C 49 44 20 44 41 
;                FCB     'T,'A,' ,'T,'R,'A,'N,'S  ; 21E3: 54 41 20 54 52 41 4E 53 
;                FCB     'F,'E,'R,' ,'T,'Y,'P,'E  ; 21EB: 46 45 52 20 54 59 50 45 
;                FCB     $0d,$0a                  ; 21F3: 0D 0A          
;                FCB     '2,'2,' ,'1,'8,' ,'D,'E  ; 21F5: 32 32 20 31 38 20 44 45 
;                FCB     'V,'I,'C,'E,' ,'A,'L,'R  ; 21FD: 56 49 43 45 20 41 4C 52 
;                FCB     'E,'A,'D,'Y,' ,'R,'E,'S  ; 2205: 45 41 44 59 20 52 45 53 
;                FCB     'E,'R,'V,'E,'D           ; 220D: 45 52 56 45 44 
;                FCB     $0d,$0a                  ; 2212: 0D 0A          
;                FCB     '2,'3,' ,'1,'9,' ,'D,'E  ; 2214: 32 33 20 31 39 20 44 45 
;                FCB     'V,'I,'C,'E,' ,'N,'O,'T  ; 221C: 56 49 43 45 20 4E 4F 54 
;                FCB     ' ,'R,'E,'S,'E,'R,'V,'E  ; 2224: 20 52 45 53 45 52 56 45 
;                FCB     'D                       ; 222C: 44             
;                FCB     $0d,$0a                  ; 222D: 0D 0A          
;                FCB     '2,'5,' ,'2,'0,' ,'I,'N  ; 222F: 32 35 20 32 30 20 49 4E 
;                FCB     'V,'A,'L,'I,'D,' ,'O,'P  ; 2237: 56 41 4C 49 44 20 4F 50 
;                FCB     'E,'N,'/,'C,'L,'O,'S,'E  ; 223F: 45 4E 2F 43 4C 4F 53 45 
;                FCB     'D,' ,'F,'L,'A,'G        ; 2247: 44 20 46 4C 41 47 
;                FCB     $0d,$0a                  ; 224D: 0D 0A          
;                FCB     '2,'6,' ,'2,'1,' ,'E,'N  ; 224F: 32 36 20 32 31 20 45 4E 
;                FCB     'D,' ,'O,'F,' ,'F,'I,'L  ; 2257: 44 20 4F 46 20 46 49 4C 
;                FCB     'E                       ; 225F: 45             
;                FCB     $0d,$0a                  ; 2260: 0D 0A          
;                FCB     '2,'9,' ,'2,'2,' ,'B,'U  ; 2262: 32 39 20 32 32 20 42 55 
;                FCB     'F,'F,'E,'R,' ,'O,'V,'E  ; 226A: 46 46 45 52 20 4F 56 45 
;                FCB     'R,'F,'L,'O,'W           ; 2272: 52 46 4C 4F 57 
;                FCB     $0d,$0a                  ; 2277: 0D 0A          
;                FCB     '2,'A,' ,'2,'3,' ,'C,'H  ; 2279: 32 41 20 32 33 20 43 48 
;                FCB     'E,'C,'K,'S,'U,'M,' ,'E  ; 2281: 45 43 4B 53 55 4D 20 45 
;                FCB     'R,'R,'O,'R              ; 2289: 52 52 4F 52    
;                FCB     $0d,$0a                  ; 228D: 0D 0A          
;                FCB     '1,'5,' ,'2,'4,' ,'L,'O  ; 228F: 31 35 20 32 34 20 4C 4F 
;                FCB     'G,'I,'C,'A,'L,' ,'S,'E  ; 2297: 47 49 43 41 4C 20 53 45 
;                FCB     'C,'T,'O,'R,' ,'N,'U,'M  ; 229F: 43 54 4F 52 20 4E 55 4D 
;                FCB     'B,'E,'R,' ,'O,'U,'T,'   ; 22A7: 42 45 52 20 4F 55 54 20 
;                FCB     'O,'F,' ,'R,'A,'N,'G,'E  ; 22AF: 4F 46 20 52 41 4E 47 45 
;                FCB     $0d,$0a                  ; 22B7: 0D 0A          
;                FCB     '0,'7,' ,'2,'5,' ,'I,'N  ; 22B9: 30 37 20 32 35 20 49 4E 
;                FCB     'V,'A,'L,'I,'D,' ,'F,'I  ; 22C1: 56 41 4C 49 44 20 46 49 
;                FCB     'L,'E,' ,'N,'A,'M,'E     ; 22C9: 4C 45 20 4E 41 4D 45 
;                FCB     $0d,$0a                  ; 22D0: 0D 0A          
;                FCB     '2,'B,' ,'2,'6,' ,'F,'I  ; 22D2: 32 42 20 32 36 20 46 49 
;                FCB     'L,'E,' ,'I,'S,' ,'W,'R  ; 22DA: 4C 45 20 49 53 20 57 52 
;                FCB     'I,'T,'E,' ,'P,'R,'O,'T  ; 22E2: 49 54 45 20 50 52 4F 54 
;                FCB     'E,'C,'T,'E,'D           ; 22EA: 45 43 54 45 44 
;                FCB     $0d,$0a                  ; 22EF: 0D 0A          
;                FCB     '2,'0,' ,'2,'7,' ,'\,'0  ; 22F1: 32 30 20 32 37 20 5C 30 
;                FCB     ' ,'I,'S,' ,'W,'R,'I,'T  ; 22F9: 20 49 53 20 57 52 49 54 
;                FCB     'E,' ,'P,'R,'O,'T,'E,'C  ; 2301: 45 20 50 52 4F 54 45 43 
;                FCB     'T,'E,'D                 ; 2309: 54 45 44       
;                FCB     $0d,$0a                  ; 230C: 0D 0A          
;                FCB     '0,'9,' ,'2,'8,' ,'D,'E  ; 230E: 30 39 20 32 38 20 44 45 
;                FCB     'V,'I,'C,'E,' ,'N,'A,'M  ; 2316: 56 49 43 45 20 4E 41 4D 
;                FCB     'E,' ,'N,'O,'T,' ,'F,'O  ; 231E: 45 20 4E 4F 54 20 46 4F 
;                FCB     'U,'N,'D                 ; 2326: 55 4E 44       
;                FCB     $0d,$0a                  ; 2329: 0D 0A          
;                FCB     '0,'4,' ,'2,'9,' ,'I,'N  ; 232B: 30 34 20 32 39 20 49 4E 
;                FCB     'V,'A,'L,'I,'D,' ,'L,'O  ; 2333: 56 41 4C 49 44 20 4C 4F 
;                FCB     'G,'I,'C,'A,'L,' ,'U,'N  ; 233B: 47 49 43 41 4C 20 55 4E 
;                FCB     'I,'T,' ,'N,'U,'M,'B,'E  ; 2343: 49 54 20 4E 55 4D 42 45 
;                FCB     'R                       ; 234B: 52             
;                FCB     $0d,$0a                  ; 234C: 0D 0A          
;                FCB     '1,'2,' ,'3,'0,' ,'I,'N  ; 234E: 31 32 20 33 30 20 49 4E 
;                FCB     'V,'A,'L,'I,'D,' ,'E,'X  ; 2356: 56 41 4C 49 44 20 45 58 
;                FCB     'E,'C,'U,'T,'I,'O,'N,'   ; 235E: 45 43 55 54 49 4F 4E 20 
;                FCB     'A,'D,'D,'R,'E,'S,'S     ; 2366: 41 44 44 52 45 53 53 
;                FCB     $0d,$0a                  ; 236D: 0D 0A          
;                FCB     '0,'A,' ,'3,'1,' ,'I,'N  ; 236F: 30 41 20 33 31 20 49 4E 
;                FCB     'V,'A,'L,'I,'D,' ,'D,'E  ; 2377: 56 41 4C 49 44 20 44 45 
;                FCB     'V,'I,'C,'E              ; 237F: 56 49 43 45    
;                FCB     $0d,$0a                  ; 2383: 0D 0A          
;                FCB     '1,'1,' ,'3,'2,' ,'I,'N  ; 2385: 31 31 20 33 32 20 49 4E 
;                FCB     'V,'A,'L,'I,'D,' ,'R,'I  ; 238D: 56 41 4C 49 44 20 52 49 
;                FCB     'B                       ; 2395: 42             
;                FCB     $0d,$0a                  ; 2396: 0D 0A          
;                FCB     '1,'D,' ,'3,'3,' ,'T,'O  ; 2398: 31 44 20 33 33 20 54 4F 
;                FCB     'O,' ,'M,'A,'N,'Y,' ,'S  ; 23A0: 4F 20 4D 41 4E 59 20 53 
;                FCB     'O,'U,'R,'C,'E,' ,'F,'I  ; 23A8: 4F 55 52 43 45 20 46 49 
;                FCB     'L,'E,'S                 ; 23B0: 4C 45 53       
;                FCB     $0d,$0a                  ; 23B3: 0D 0A          
;                FCB     '1,'6,' ,'3,'4,' ,'I,'N  ; 23B5: 31 36 20 33 34 20 49 4E 
;                FCB     'V,'A,'L,'I,'D,' ,'S,'T  ; 23BD: 56 41 4C 49 44 20 53 54 
;                FCB     'A,'R,'T,'/,'E,'N,'D,'   ; 23C5: 41 52 54 2F 45 4E 44 20 
;                FCB     'S,'P,'E,'C,'I,'F,'I,'C  ; 23CD: 53 50 45 43 49 46 49 43 
;                FCB     'A,'T,'I,'O,'N,'S        ; 23D5: 41 54 49 4F 4E 53 
;                FCB     $0d,$0a                  ; 23DB: 0D 0A          
;                FCB     '1,'7,' ,'3,'5,' ,'I,'N  ; 23DD: 31 37 20 33 35 20 49 4E 
;                FCB     'V,'A,'L,'I,'D,' ,'P,'A  ; 23E5: 56 41 4C 49 44 20 50 41 
;                FCB     'G,'E,' ,'F,'O,'R,'M,'A  ; 23ED: 47 45 20 46 4F 52 4D 41 
;                FCB     'T                       ; 23F5: 54             
;                FCB     $0d,$0a                  ; 23F6: 0D 0A          
;                FCB     '1,'4,' ,'3,'6,' ,'F,'I  ; 23F8: 31 34 20 33 36 20 46 49 
;                FCB     'L,'E,' ,'E,'X,'H,'A,'U  ; 2400: 4C 45 20 45 58 48 41 55 
;                FCB     'S,'T,'E,'D,' ,'B,'E,'F  ; 2408: 53 54 45 44 20 42 45 46 
;                FCB     'O,'R,'E,' ,'L,'I,'N,'E  ; 2410: 4F 52 45 20 4C 49 4E 45 
;                FCB     ' ,'F,'O,'U,'N,'D        ; 2418: 20 46 4F 55 4E 44 
;                FCB     $0d,$0a                  ; 241E: 0D 0A          
;                FCB     '2,'8,' ,'3,'7,' ,'E,'N  ; 2420: 32 38 20 33 37 20 45 4E 
;                FCB     'D,' ,'O,'F,' ,'M,'E,'D  ; 2428: 44 20 4F 46 20 4D 45 44 
;                FCB     'I,'A                    ; 2430: 49 41          
;                FCB     $0d,$0a                  ; 2432: 0D 0A          
;                FCB     '1,'8,' ,'3,'8,' ,'I,'N  ; 2434: 31 38 20 33 38 20 49 4E 
;                FCB     'V,'A,'L,'I,'D,' ,'L,'I  ; 243C: 56 41 4C 49 44 20 4C 49 
;                FCB     'N,'E,' ,'N,'U,'M,'B,'E  ; 2444: 4E 45 20 4E 55 4D 42 45 
;                FCB     'R,' ,'O,'R,' ,'R,'A,'N  ; 244C: 52 20 4F 52 20 52 41 4E 
;                FCB     'G,'E                    ; 2454: 47 45          
;                FCB     $0d,$0a                  ; 2456: 0D 0A          
;                FCB     '1,'9,' ,'3,'9,' ,'L,'I  ; 2458: 31 39 20 33 39 20 4C 49 
;                FCB     'N,'E,' ,'N,'U,'M,'B,'E  ; 2460: 4E 45 20 4E 55 4D 42 45 
;                FCB     'R,' ,'E,'N,'T,'E,'R,'E  ; 2468: 52 20 45 4E 54 45 52 45 
;                FCB     'D,' ,'B,'E,'F,'O,'R,'E  ; 2470: 44 20 42 45 46 4F 52 45 
;                FCB     ' ,'S,'O,'U,'R,'C,'E,'   ; 2478: 20 53 4F 55 52 43 45 20 
;                FCB     'F,'I,'L,'E              ; 2480: 46 49 4C 45    
;                FCB     $0d,$0a                  ; 2484: 0D 0A          
;                FCB     '0,'2,' ,'4,'0,' ,'D,'I  ; 2486: 30 32 20 34 30 20 44 49 
;                FCB     'R,'E,'C,'T,'O,'R,'Y,'   ; 248E: 52 45 43 54 4F 52 59 20 
;                FCB     'S,'P,'A,'C,'E,' ,'F,'U  ; 2496: 53 50 41 43 45 20 46 55 
;                FCB     'L,'L                    ; 249E: 4C 4C          
;                FCB     $0d,$0a                  ; 24A0: 0D 0A          
;                FCB     '0,'3,' ,'4,'1,' ,'I,'N  ; 24A2: 30 33 20 34 31 20 49 4E 
;                FCB     'S,'U,'F,'F,'I,'C,'I,'E  ; 24AA: 53 55 46 46 49 43 49 45 
;                FCB     'N,'T,' ,'D,'I,'S,'K,'   ; 24B2: 4E 54 20 44 49 53 4B 20 
;                FCB     'S,'P,'A,'C,'E           ; 24BA: 53 50 41 43 45 
;                FCB     $0d,$0a                  ; 24BF: 0D 0A          
;                FCB     '1,'0,' ,'4,'2,' ,'S,'E  ; 24C1: 31 30 20 34 32 20 53 45 
;                FCB     'G,'M,'E,'N,'T,' ,'D,'E  ; 24C9: 47 4D 45 4E 54 20 44 45 
;                FCB     'S,'C,'R,'I,'P,'T,'O,'R  ; 24D1: 53 43 52 49 50 54 4F 52 
;                FCB     ' ,'S,'P,'A,'C,'E,' ,'F  ; 24D9: 20 53 50 41 43 45 20 46 
;                FCB     'U,'L,'L                 ; 24E1: 55 4C 4C       
;                FCB     $0d,$0a                  ; 24E4: 0D 0A          
;                FCB     '2,'C,' ,'4,'3,' ,'I,'N  ; 24E6: 32 43 20 34 33 20 49 4E 
;                FCB     'V,'A,'L,'I,'D,' ,'D,'I  ; 24EE: 56 41 4C 49 44 20 44 49 
;                FCB     'R,'E,'C,'T,'O,'R,'Y,'   ; 24F6: 52 45 43 54 4F 52 59 20 
;                FCB     'E,'N,'T,'R,'Y,' ,'N,'O  ; 24FE: 45 4E 54 52 59 20 4E 4F 
;                FCB     '.,' ,'A,'T,' ,'\,'8     ; 2506: 2E 20 41 54 20 5C 38 
;                FCB     $0d,$0a                  ; 250D: 0D 0A          
;                FCB     '2,'D,' ,'4,'4,' ,'C,'A  ; 250F: 32 44 20 34 34 20 43 41 
;                FCB     'N,'N,'O,'T,' ,'D,'E,'A  ; 2517: 4E 4E 4F 54 20 44 45 41 
;                FCB     'L,'L,'O,'C,'A,'T,'E,'   ; 251F: 4C 4C 4F 43 41 54 45 20 
;                FCB     'A,'L,'L,' ,'S,'P,'A,'C  ; 2527: 41 4C 4C 20 53 50 41 43 
;                FCB     'E,',,' ,'D,'I,'R,'E,'C  ; 252F: 45 2C 20 44 49 52 45 43 
;                FCB     'T,'O,'R,'Y,' ,'E,'N,'T  ; 2537: 54 4F 52 59 20 45 4E 54 
;                FCB     'R,'Y,' ,'E,'X,'I,'S,'T  ; 253F: 52 59 20 45 58 49 53 54 
;                FCB     'S,' ,'A,'T,' ,'\,'8     ; 2547: 53 20 41 54 20 5C 38 
;                FCB     $0d,$0a                  ; 254E: 0D 0A          
;                FCB     '2,'E,' ,'4,'5,' ,'R,'E  ; 2550: 32 45 20 34 35 20 52 45 
;                FCB     'C,'O,'R,'D,' ,'L,'E,'N  ; 2558: 43 4F 52 44 20 4C 45 4E 
;                FCB     'G,'T,'H,' ,'T,'O,'O,'   ; 2560: 47 54 48 20 54 4F 4F 20 
;                FCB     'L,'A,'R,'G,'E           ; 2568: 4C 41 52 47 45 
;                FCB     $0d,$0a                  ; 256D: 0D 0A          
;                FCB     '0,'C,' ,'4,'6,' ,'I,'N  ; 256F: 30 43 20 34 36 20 49 4E 
;                FCB     'T,'E,'R,'N,'A,'L,' ,'S  ; 2577: 54 45 52 4E 41 4C 20 53 
;                FCB     'Y,'S,'T,'E,'M,' ,'E,'R  ; 257F: 59 53 54 45 4D 20 45 52 
;                FCB     'R,'O,'R,' ,'A,'T,' ,'\  ; 2587: 52 4F 52 20 41 54 20 5C 
;                FCB     '8                       ; 258F: 38             
;                FCB     $0d,$0a                  ; 2590: 0D 0A          
;                FCB     '2,'1,' ,'4,'7,' ,'I,'N  ; 2592: 32 31 20 34 37 20 49 4E 
;                FCB     'V,'A,'L,'I,'D,' ,'S,'C  ; 259A: 56 41 4C 49 44 20 53 43 
;                FCB     'A,'L,'L                 ; 25A2: 41 4C 4C       
;                FCB     $0d,$0a                  ; 25A5: 0D 0A          
;                FCB     '2,'F,' ,'4,'8,' ,'C,'H  ; 25A7: 32 46 20 34 38 20 43 48 
;                FCB     'A,'I,'N,' ,'O,'V,'E,'R  ; 25AF: 41 49 4E 20 4F 56 45 52 
;                FCB     'L,'A,'Y,' ,'D,'O,'E,'S  ; 25B7: 4C 41 59 20 44 4F 45 53 
;                FCB     ' ,'N,'O,'T,' ,'E,'X,'I  ; 25BF: 20 4E 4F 54 20 45 58 49 
;                FCB     'S,'T                    ; 25C7: 53 54          
;                FCB     $0d,$0a                  ; 25C9: 0D 0A          
;                FCB     '3,'2,' ,'4,'9,' ,'C,'H  ; 25CB: 33 32 20 34 39 20 43 48 
;                FCB     'A,'I,'N,' ,'A,'B,'O,'R  ; 25D3: 41 49 4E 20 41 42 4F 52 
;                FCB     'T,'E,'D,' ,'B,'Y,' ,'I  ; 25DB: 54 45 44 20 42 59 20 49 
;                FCB     'L,'L,'E,'G,'A,'L,' ,'O  ; 25E3: 4C 4C 45 47 41 4C 20 4F 
;                FCB     'P,'E,'R,'A,'T,'O,'R     ; 25EB: 50 45 52 41 54 4F 52 
;                FCB     $0d,$0a                  ; 25F2: 0D 0A          
;                FCB     '3,'3,' ,'5,'0,' ,'C,'H  ; 25F4: 33 33 20 35 30 20 43 48 
;                FCB     'A,'I,'N,' ,'A,'B,'O,'R  ; 25FC: 41 49 4E 20 41 42 4F 52 
;                FCB     'T,'E,'D,' ,'B,'Y,' ,'U  ; 2604: 54 45 44 20 42 59 20 55 
;                FCB     'N,'D,'E,'F,'I,'N,'E,'D  ; 260C: 4E 44 45 46 49 4E 45 44 
;                FCB     ' ,'L,'A,'B,'E,'L        ; 2614: 20 4C 41 42 45 4C 
;                FCB     $0d,$0a                  ; 261A: 0D 0A          
;                FCB     '3,'4,' ,'5,'1,' ,'C,'H  ; 261C: 33 34 20 35 31 20 43 48 
;                FCB     'A,'I,'N,' ,'A,'B,'O,'R  ; 2624: 41 49 4E 20 41 42 4F 52 
;                FCB     'T,'E,'D,' ,'B,'Y,' ,'P  ; 262C: 54 45 44 20 42 59 20 50 
;                FCB     'R,'E,'M,'A,'T,'U,'R,'E  ; 2634: 52 45 4D 41 54 55 52 45 
;                FCB     ' ,'E,'N,'D,' ,'O,'F,'   ; 263C: 20 45 4E 44 20 4F 46 20 
;                FCB     'F,'I,'L,'E              ; 2644: 46 49 4C 45    
;                FCB     $0d,$0a                  ; 2648: 0D 0A          
;                FCB     '3,'5,' ,'5,'2,' ,'S,'E  ; 264A: 33 35 20 35 32 20 53 45 
;                FCB     'C,'T,'O,'R,' ,'B,'U,'F  ; 2652: 43 54 4F 52 20 42 55 46 
;                FCB     'F,'E,'R,' ,'S,'I,'Z,'E  ; 265A: 46 45 52 20 53 49 5A 45 
;                FCB     ' ,'E,'R,'R,'O,'R        ; 2662: 20 45 52 52 4F 52 
;                FCB     $0d,$0a                  ; 2668: 0D 0A          
;                FCB     '3,'6,' ,'5,'3,' ,'I,'N  ; 266A: 33 36 20 35 33 20 49 4E 
;                FCB     'S,'U,'F,'F,'I,'C,'I,'E  ; 2672: 53 55 46 46 49 43 49 45 
;                FCB     'N,'T,' ,'M,'E,'M,'O,'R  ; 267A: 4E 54 20 4D 45 4D 4F 52 
;                FCB     'Y                       ; 2682: 59             
;                FCB     $0d,$0a                  ; 2683: 0D 0A          
;
;
                END
