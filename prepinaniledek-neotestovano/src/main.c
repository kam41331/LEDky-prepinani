#include "main.h"         
#include "milis.h"        
#include <stdbool.h>       
#include <stm8s.h>       

void init(void) {
    CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); //Nastaví taktování MCU na 16 MHz 

    GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_SLOW); //Inicializuje PB.0 jako výstup s nízkou hodnotou a nízkou rychlostí.
    GPIO_Init(GPIOB, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_SLOW); //Inicializuje PB.1 ...
    GPIO_Init(GPIOB, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_SLOW); //Inicializuje PB.2 ...
    GPIO_Init(GPIOB, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);     //Inicializuje PB.3 jako vstup s interním pull-up rezistorem(kvuli tlačítku), bez přerušení.
    
    init_milis(); 
}

int main(void) {
    uint8_t led_out = 1;   //uložení stavu LED (která LED má svítit)
    uint32_t time = 0;     //čas posledního stisknutí tlačítka 
    uint8_t lasttlac = 0;  //předchozí stav tlačítka pro detekci změny
    uint8_t tlac = 0;      //aktuální stav tlačítka
    
    init(); //nastaví GPIO piny a časovač.
GPIO_WriteHigh(GPIOB, GPIO_PIN_0);
    while (1) { 
        tlac = GPIO_ReadInputPin(GPIOB, GPIO_PIN_3); //stav tlačítka na pinu PB.3

        //pokud uplynulo více než 200 ms od posledního stisknutí a tlačítko je nyní stisknuté  tak:
        if ((milis() - time > 200) && !tlac && lasttlac) {
            led_out += 1;   // Zvýší proměnnou led_out o 1, což změní stav LED
            time = milis(); // aktuální čas pro další kontrolu intervalu 200 ms

            //Pokud `led_out` překročí hodnotu 3, resetuje ji zpět na 1 (aby cyklicky procházela LED)
            if (led_out > 3) {
                led_out = 1;
            }

            //řízení LED podle hodnoty led_out
            if (led_out == 1) {
                GPIO_WriteHigh(GPIOB, GPIO_PIN_0); //Zapne LED na pinu PB.0
                GPIO_WriteLow(GPIOB, GPIO_PIN_2);  //Vypne LED na pinu PB.2
            } else if (led_out == 2) {
                GPIO_WriteHigh(GPIOB, GPIO_PIN_1); //Zapne LED na pinu PB.1
                GPIO_WriteLow(GPIOB, GPIO_PIN_0);  //Vypne LED na pinu PB.0
            } else {
                GPIO_WriteHigh(GPIOB, GPIO_PIN_2); //Zapne LED na pinu PB.2
                GPIO_WriteLow(GPIOB, GPIO_PIN_1);  //Vypne LED na pinu PB.1
            }
        }

        lasttlac = tlac; // uloží aktuální stav tlačítka do lasttlac 
    }
}



#include "__assert__.h"