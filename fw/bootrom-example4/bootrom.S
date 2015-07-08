.set    SP_BASE,        0x00000000
.set    PRGM_BASE,      0x00000400

.set    PERIPH_BASE,    0xa0000000
.set    GPIO_BTN,       (PERIPH_BASE + 0x0)
.set    GPIO_LED,       (PERIPH_BASE + 0x2)

        .long   (SP_BASE)       | スタックポインター
        .long   (PRGM_BASE)     | プログラムカウンター

.org    (PRGM_BASE)

start:
        move.l  (GPIO_BTN),(GPIO_LED)
        jmp     start

