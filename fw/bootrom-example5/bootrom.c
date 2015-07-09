#define DEV_GPIO_BTN_ADDR 0xA0000000
#define DEV_GPIO_LED_ADDR 0xA0000002

const volatile unsigned short *DEV_GPIO_BTN = (unsigned short *)DEV_GPIO_BTN_ADDR;
volatile unsigned short *DEV_GPIO_LED = (unsigned short *)DEV_GPIO_LED_ADDR;

void delay_ms(void)
{
    for (unsigned long i = 0; i < 131071; i++)
        __asm__("nop");
}

int main(void)
{
    unsigned char i = 0;
    for (;;) {
        *DEV_GPIO_LED = i;
        i++;
        delay_ms();
    }

    return 0;
}

