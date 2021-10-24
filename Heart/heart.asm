    processor 6502

    include "vcs.h"
    include "macro.h"

    seg code
    org #$F000

PFCOLOR equ $81

RESET:
    CLEAN_START

    ldx #$44
    stx COLUPF

    ldx #$82
    stx COLUBK

NEXT_FRAME:
    lda #2
    sta VSYNC
    sta VBLANK

    REPEAT 3
        sta WSYNC
    REPEND

    lda #0
    sta VSYNC

    REPEAT 37
        sta WSYNC
    REPEND
    
    sta VBLANK

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PLAYFIELD
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ldy PFCOLOR
    lda #%00000001
    sta CTRLPF

    REPEAT 21
        dey
        sty COLUPF
        sta WSYNC
    REPEND
                    ; 21 Scanlines
    ldx #%00000000
    stx PF0
    ldx #%00111111
    stx PF1
    ldx #%00111111
    stx PF2

    REPEAT 10
        dey
        sty COLUPF
        sta WSYNC
    REPEND
                    ; 36 Scanlines
    ldx #%00000000
    stx PF0
    ldx #%01111111
    stx PF1
    ldx #%01111111
    stx PF2

    REPEAT 15
        dey
        sty COLUPF
        sta WSYNC
    REPEND
                    ; 51 Scanlines
    ldx #%00000000
    stx PF0
    ldx #%01111111
    stx PF1
    ldx #%11111111
    stx PF2

    REPEAT 25
        dey
        sty COLUPF
        sta WSYNC
    REPEND
                    ; 81 Scanlines
    ldx #%00000000
    stx PF0
    ldx #%00011111
    stx PF1
    ldx #%11111111
    stx PF2

    REPEAT 10
        dey
        sty COLUPF
        sta WSYNC
    REPEND
                    ; 96 Scanlines
    ldx #%00000000
    stx PF0
    ldx #%00000111
    stx PF1
    ldx #%11111111
    stx PF2

    REPEAT 10
        dey
        sty COLUPF
        sta WSYNC
    REPEND
                    ; 111 Scanlines
        
    ldx #%00000000
    stx PF0
    ldx #%00000001
    stx PF1
    ldx #%11111111
    stx PF2

    REPEAT 15
        dey
        sty COLUPF
        sta WSYNC
    REPEND
                    ; 126 Scanlines
                    
    ldx #%00000000
    stx PF0
    ldx #%00000000
    stx PF1
    ldx #%11111110
    stx PF2

    REPEAT 15
        dey
        sty COLUPF
        sta WSYNC
    REPEND
                    ; 141 Scanlines
    ldx #%00000000
    stx PF0
    ldx #%00000000
    stx PF1
    ldx #%11111000
    stx PF2

    REPEAT 15
        dey
        sty COLUPF
        sta WSYNC
    REPEND
                    ; 156 Scanlines
    ldx #%00000000
    stx PF0
    ldx #%00000000
    stx PF1
    ldx #%11100000
    stx PF2

    REPEAT 10
        dey
        sty COLUPF
        sta WSYNC
    REPEND
                    ; 171 Scanlines

    ldx #%00000000
    stx PF0
    ldx #%00000000
    stx PF1
    ldx #%10000000
    stx PF2

    REPEAT 10
        dey
        sty COLUPF
        sta WSYNC
    REPEND
                    ; 171 Scanlines

    ldx #0
    stx PF0
    ldx #0
    stx PF1
    ldx #0
    stx PF2
    

    REPEAT 21
        dey
        sta WSYNC
    REPEND
                    ; 192 Scanline

    dec PFCOLOR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END PLAYFIELD
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    lda #2
    sta VBLANK
    REPEAT 30
        sta WSYNC
    REPEND
    jmp NEXT_FRAME


    org #$FFFC
    .word RESET
    .word RESET