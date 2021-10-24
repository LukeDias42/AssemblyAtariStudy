    processor 6502

    include "vcs.h"
    include "macro.h"

    seg code
    org $F000

START:
    CLEAN_START

NEXT_FRAME:
    lda #2          ; Same as binary #%00000010
    sta VBLANK      ; Turn on VBLANK
    sta VSYNC       ; Turn on VSYNC

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Generate the three lines of VSYNC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    sta WSYNC       ; First Scanline
    sta WSYNC       ; Second Scanline
    sta WSYNC       ; Third Scanline

    lda #0
    sta VSYNC       ; turn off VSYNC

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Let the TIA  output the recommended 37 scanlines of VBLANK
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ldx #37         ; Count 37 Scanlines

LOOP_VBLANK:
    sta WSYNC       ; Hiy WSYNC to wait for the next scanline
    dex             ; Decrement X
    bne LOOP_VBLANK ; Loop while x!=0

    lda #0
    sta VBLANK      ; Turn off VBLANK

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Draw 192 Visible Scanlines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ldx #192

LOOP_SCANLINE:
    stx COLUBK          ; Set the background color           
    sta WSYNC           ; wait for the next scanline
    dex                 ; X--
    bne LOOP_SCANLINE   ; Loop while X!=0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Output 30 more VBLANK lines (Overscan) to complete our frame
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda #2
    sta VBLANK  ; Turn on VBLANK again

    ldx #30     ; Counter for 30 scanlines
LOOP_OVERSCAN:
    sta WSYNC   ; Wait until next scanline
    dex         ; X--
    bne LOOP_OVERSCAN ; Loop While X!=0

    jmp NEXT_FRAME

    org $FFFC
    .word START
    .word START