Here is a clean, well-commented assembly include file for the F2 Forth Z80 CP/M system:

;***********************************************************************
;*
;*  F2 Forth - Z80 CP/M Memory Map
;*  (C) 1983-1984 Institut für Angewandte Physik, Universität Bonn
;*
;*  File:  FORTHMEM.INC
;*  Last updated: June 2026 (reconstructed from original source)
;*
;***********************************************************************

;=====================================================================
;                     OVERALL MEMORY LAYOUT
;=====================================================================

HOESPE  EQU     8000H           ; Highest memory address + 1

;---------------------------------------------------------------------
; High memory downwards
;---------------------------------------------------------------------

BUFFG   EQU     100H            ; Size of disk/line buffer
BUFF    EQU     (HOESPE - BUFFG); Start of disk buffer          ~7F00H

USS     EQU     100H            ; User area size
US      EQU     (BUFF - USS)    ; Start of User Variable Area     ~7E00H

RTS     EQU     100H            ; Return stack size
TIBE    EQU     (US - RTS)      ; Terminal Input Buffer (TIB)     ~7D00H

INITR0  EQU     (US - 1)        ; Initial Return Stack pointer    ~7CFFH
INITS0  EQU     (TIBE - 1)      ; Initial Data Stack pointer      ~7BFFH

;=====================================================================
;                     USER AREA LAYOUT (US = 7E00H)
;=====================================================================

                ; Offset    Name              Description
;---------------------------------------------------------------------
S0      EQU     00H     ; S0          Initial data stack pointer
R0      EQU     06H     ; R0          Initial return stack pointer
TIB     EQU     0AH     ; TIB         Address of Terminal Input Buffer
WIDTH   EQU     0CH     ; WIDTH       Maximum word name length (default 31)
WARNING EQU     0EH     ; WARNING     Error handling mode
FENCE   EQU     10H     ; FENCE       Dictionary protection pointer
DP      EQU     12H     ; DP          Dictionary Pointer (HERE)
VOCL    EQU     14H     ; VOC-LINK    Vocabulary link
BLK     EQU     16H     ; BLK         Current block/screen number
INN     EQU     18H     ; IN          Input buffer offset
OUTT    EQU     1AH     ; OUT         Output character counter
SCR     EQU     1CH     ; SCR         Current screen
OFFSET  EQU     1EH     ; OFFSET      Mass storage offset
CONT    EQU     20H     ; CONTEXT     Current search vocabulary
CURR    EQU     22H     ; CURRENT     Vocabulary being extended
STATE   EQU     24H     ; STATE       0=Interpret, C0H=Compile
BASE    EQU     26H     ; BASE        Numeric base (A=10, 10H=16)
DPL     EQU     28H     ; DPL         Decimal point location
FLD     EQU     2AH     ; FLD         Output field width
CSPP    EQU     2CH     ; CSP         Stack check pointer
RNUM    EQU     2EH     ; R#          File/text pointer (used in KEYSIMUL)
HLD     EQU     30H     ; HLD         Hold pointer for numeric output
SNUM    EQU     32H     ; S#
TNUM    EQU     34H     ; T#          Text length counter
DR      EQU     36H     ; DR          Printer on/off flag
ZEI     EQU     38H     ; ZEI         Current line number (printer)
MZEI    EQU     3AH     ; MZEI        Max lines per page
EZEI    EQU     3CH     ; EZEI        First allowed line
LZEI    EQU     3EH     ; LZEI        Last allowed line
LRA     EQU     40H     ; LRA         Left margin
RRA     EQU     42H     ; RRA         Right margin
VAZ     EQU     44H     ; VAZ         Next free user variable slot
MIST    EQU     46H     ; MIST        Error message handler address

; I/O and startup vectors
KEY$    EQU     48H     ; KEY$        Vector for KEY
LOAD$   EQU     4AH     ; LOAD$       Vector for LOAD
ERROR$  EQU     4CH     ; ERROR$      Vector for ERROR
ABORT$  EQU     4EH     ; ABORT$      Vector for ABORT
EMIT$   EQU     50H     ; EMIT$       Vector for EMIT
CR$     EQU     52H     ; CR$         Vector for CR
QTERM$  EQU     54H     ; ?TERMINAL$  Vector for ?TERMINAL
COLD$   EQU     56H     ; COLD$       Cold start extension
WARM$   EQU     58H     ; WARM$       Warm start extension

;=====================================================================
;                     CP/M SYSTEM ADDRESSES
;=====================================================================

BOOT    EQU     0000H
BDOS    EQU     BOOT + 5        ; BDOS entry point

DFCBE   EQU     BOOT + 5CH      ; Default File Control Block (FCB)
DDMAE   EQU     BOOT + 80H      ; Default DMA address

;=====================================================================
;                     IMPORTANT CONSTANTS
;=====================================================================

; File I/O
OPENF   EQU     15              ; BDOS: Open file
READF   EQU     20              ; BDOS: Read sequential
SEDMA   EQU     26              ; BDOS: Set DMA address

DLFILE  EQU     80H             ; Default file sector length

; Terminal
ESC     EQU     1BH
POSIT   EQU     3DH             ; Cursor position ESC sequence
ACLS    EQU     01H             ; Clear screen sequence length

; Stack and buffer sizes
BUFFG   EQU     100H
USS     EQU     100H
RTS     EQU     100H

;=====================================================================
;                     COLD START PARAMETER BLOCK
;=====================================================================

KAPA    EQU     ORIG + 40H      ; Cold start parameters start here
                                ; (see original source for layout)

;=====================================================================
;                     ORIGIN / PROGRAM START
;=====================================================================

ORIG    EQU     0100H           ; Typical CP/M TPA start

;***********************************************************************
; End of memory map include
;***********************************************************************

How to use it:
--------------
In your assembly files, simply add:

        INCLUDE FORTHMEM.INC




