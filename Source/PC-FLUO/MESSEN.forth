( MESSEN                                      KD 12:10 07/21/87)
( Last changed screen # 000                   KD 12:10 07/21/87)

( Grundroutinen für das MESS-Programm auf PC-Seite             )
( ...wird zu COMZ2.COM mit 1 LOAD dazugeladen                  )                                                                
( COMZ2.COM ist das Terminalprogramm für SLAVE                 )
(           und benutzt COM2                                   )                                                                
( Start auf DOS-Ebene durch Batch-Datei : MESS.BAT             )                                                                
( MESSDAT.SCR  : Rohdatei für Messwerte                        )
( MESSDATF.SCR : Messwertedatei für FLUO-Werte                 )                                                                
( Grafiktreiber in der Datei :  GR.SCR                         )                                                                                                                                
( DUP-Screen                                  KD 18:11 07/16/87)
DECIMAL                                                                                                                         
CREATE TEMP 1024 ALLOT       ( temp. Bereich reservieren )      
0     VARIABLE  #SCR         ( Screenzähler )                   
11    CONSTANT  1.DATSCREEN  ( 1. Fluodatenscreen ab 11. Scr )                                                                  
: LS_DUP  10 BLOCK TEMP 1024 CMOVE                                        
  TEMP #SCR @ BLOCK 1024 CMOVE UPDATE FLUSH ;                                                                           
: #SCR+   #SCR @ 1+ #SCR ! ;    ( Screenbuffer incrementieren ) 
: 1.SCR   1.DATSCREEN #SCR ! ;  ( Initialisiere Screenzähler  )                                                                 
: LSDUP   LS_DUP #SCR+ ;     ( Kopiere Screen 10 & incr. #SCR )                                                                                                                                 
(                                          TF  16:57 07/16/87 ) 
                                                                                                                                                                                                                                                                                         

(                                          TF  16:57 07/16/87 )  
                                                                                                                                                                                                           
( DUP-Screen                                  KD 18:11 07/16/87)
DECIMAL                                                                                                                         
CREATE TEMP 1024 ALLOT       ( temp. Bereich reservieren )      
0     VARIABLE  #SCR         ( Screenzähler )                   
11    CONSTANT  1.DATSCREEN  ( 1. Fluodatenscreen ab 11. Scr )                                                                                                                                                                                                                                                                     
                                                                                                                                                                                                                 
( DUP-Screen                                  KD 18:11 07/16/87)
DECIMAL                                                                                                                        
CREATE TEMP 1024 ALLOT       ( temp. Bereich reservieren )      
0     VARIABLE  #SCR         ( Screenzähler )                   
11    CONSTANT  1.DATSCREEN  ( 1. Fluodatenscreen ab 11. Scr )     
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             