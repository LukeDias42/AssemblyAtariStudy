    processor 6502

    include "vcs.h"
    include "macro.h"

    seg code
    org $F000

RESET:
    CLEAN_START

    ldx #$80
    stx COLUBK
    
    lda #$1C
    sta COLUPF

NEXT_FRAME:
    lda #2          ; Same as binary #%00000010
    sta VBLANK      ; Turn on VBLANK
    sta VSYNC       ; Turn on VSYNC

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Generate the three lines of VSYNC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    REPEAT 3
        sta WSYNC
    REPEND
    lda #0
    sta VSYNC       ; turn off VSYNC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Let the TIA  output the recommended 37 scanlines of VBLANK
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    REPEAT 37
        sta WSYNC
    REPEND
    lda #0
    sta VBLANK      ; Turn off VBLANK
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set the CTRPF register to allow playfield reflection
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ldx #%00000001
    stx CTRLPF

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Draw the 192 visible scanlines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ldx #%00000000
    stx PF0
    stx PF1
    stx PF2
    REPEAT 7
        sta WSYNC
    REPEND

    ldx #%11100000
    stx PF0
    ldx #%11111111
    stx PF1
    stx PF2

    REPEAT 7
        sta WSYNC
    REPEND

    ldx #%00100000
    stx PF0
    ldx #%00000000
    stx PF1
    stx PF2

    REPEAT 164
        STA WSYNC
    REPEND

    ldx #%11100000
    stx PF0
    ldx #%11111111
    stx PF1
    stx PF2

    REPEAT 7
        sta WSYNC
    REPEND

    ldx #%00000000
    stx PF0
    stx PF1
    stx PF2
    REPEAT 7
        sta WSYNC
    REPEND
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Output 30 more VBLANK lines (Overscan) to complete our frame
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda #2
    sta VBLANK  ; Turn on VBLANK again
    REPEAT 30
        sta WSYNC
    REPEND

    jmp NEXT_FRAME

    org $FFFC
    .word RESET
    .word RESET