    processor 6502

    include "vcs.h"
    include "macro.h"

    seg code
    org $F000

START:
    CLEAN_START         ; Macro to safely clear the memory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set Background Luminosity Color to Yellow
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    lda $1E             ; Load color into A ($1E is NTSC yellow)
    sta COLUBK
    
;    jmp START           ; Repeats from START

    org $FFFC
    .word START
    .word START
