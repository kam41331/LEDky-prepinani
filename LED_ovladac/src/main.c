#include <stdbool.h>
#include <stm8s.h>
#include "main.h"
#include "milis.h"

#define BTN

void init(void) {
    CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); // Taktování MCU na 16MHz

    GPIO_Init(BTN_PORT, BTN_PIN, GPIO_MODE_IN_FL_NO_IT);

    GPIO_Init(LED1_PORT, LED1_PIN, GPIO_MODE_OUT_PP_LOW_SLOW);
    GPIO_Init(LED2_PORT, LED2_PIN, GPIO_MODE_OUT_PP_LOW_SLOW);
    GPIO_Init(LED3_PORT, LED3_PIN, GPIO_MODE_OUT_PP_LOW_SLOW);

    init_milis();
}

int main(void) {
    uint8_t BTNstate = 1;
    uint8_t lastBTNstate = 1;
    uint8_t led_out = 1;

    init();

    while (1) {
        BTNstate = GPIO_ReadInputPin(BTN_PORT, BTN_PIN);

        if (lastBTNstate == 0 && BTNstate == 1) {
            led_out += 1;
        }

        if (led_out > 3) {
            led_out = 1;
        }

        // Nastavení výstupů pro LED
        if (led_out == 1) {
            GPIO_WriteHigh(LED1_PORT, LED1_PIN);
            GPIO_WriteLow(LED3_PORT, LED3_PIN);
        } else if (led_out == 2) {
            GPIO_WriteHigh(LED2_PORT, LED2_PIN);
            GPIO_WriteLow(LED1_PORT, LED1_PIN);
        } else if (led_out == 3) {
            GPIO_WriteHigh(LED3_PORT, LED3_PIN);
            GPIO_WriteLow(LED2_PORT,LED2_PIN);
        }
        lastBTNstate = BTNstate;
    }
}
