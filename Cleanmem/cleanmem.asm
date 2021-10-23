    processor 6502

    seg code
    org $F000       ; Define the code origin at $F000

Start:
    sei             ; Disables interrupts
    cld             ; Disables the BCD (Binary Coded Decimal) Math Mode
    ldx #$FF        ; Loads the X register with #$FF
    txs             ; Transfer the X register to the stack pointer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Clear the Page Zero region ($00 to $FF)
; Meaning the entire RAM and also the entire TIA registers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda #0          ; A = 0
    ldx #$FF        ; X = #$FF
    sta $FF         ; Make sure $FF is zeroed before the loop starts

MemLoop:
    dex             ; X--
    sta $0,X        ; Store the value of A inside memory address $0 + X
    bne MemLoop     ; Branch back to MemLoop if X is not equal to zero
                    ; Until z-flag is set
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fill the ROM size to exactly 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    org $FFFC
    .word Start     ; Reset vector at $FFFC (where the program Starts)
    .word Start     ; Interrupt vector at $FFFE (unused in the VCS)
