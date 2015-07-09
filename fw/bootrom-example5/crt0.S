.set    PRGM_BASE,      0x00000400

.set    BRAM_BASE,      0x10000000
.set    BRAM_SIZE,      0x00001000

.set    SP_BASE,        (BRAM_BASE + BRAM_SIZE)

        .long   (SP_BASE)       | Initial stack pointer
        .long   (PRGM_BASE)     | Initial program counter
        .long   0x00000000      | Bus error
        .long   0x00000000      | Address error
        .long   0x00000000      | Illegal instruction
        .long   0x00000000      | Zero divide
        .long   0x00000000      | CHK instruction
        .long   0x00000000      | TRAPV instruction
        .long   0x00000000      | Privilege violation
        .long   0x00000000      | Trace
        .long   0x00000000      | Line 1010 emulator
        .long   0x00000000      | Line 1111 emulator
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved
        .long   0x00000000      | Uninitialized interrupt vector
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved
        .long   0x00000000      | Spurious interrupt
        .long   0x00000000      | Level 1 interrupt autovector
        .long   0x00000000      | Level 2 interrupt autovector
        .long   0x00000000      | Level 3 interrupt autovector
        .long   0x00000000      | Level 4 interrupt autovector
        .long   0x00000000      | Level 5 interrupt autovector
        .long   0x00000000      | Level 6 interrupt autovector
        .long   0x00000000      | Level 7 interrupt autovector
        .long   0x00000000      | Trap #00 instruction vector
        .long   0x00000000      | Trap #01 instruction vector
        .long   0x00000000      | Trap #02 instruction vector
        .long   0x00000000      | Trap #03 instruction vector
        .long   0x00000000      | Trap #04 instruction vector
        .long   0x00000000      | Trap #05 instruction vector
        .long   0x00000000      | Trap #06 instruction vector
        .long   0x00000000      | Trap #07 instruction vector
        .long   0x00000000      | Trap #08 instruction vector
        .long   0x00000000      | Trap #09 instruction vector
        .long   0x00000000      | Trap #10 instruction vector
        .long   0x00000000      | Trap #11 instruction vector
        .long   0x00000000      | Trap #12 instruction vector
        .long   0x00000000      | Trap #13 instruction vector
        .long   0x00000000      | Trap #14 instruction vector
        .long   0x00000000      | Trap #15 instruction vector
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved
        .long   0x00000000      | Reserved

.org    (PRGM_BASE)

.globl _start
_start:
        jmp     main

