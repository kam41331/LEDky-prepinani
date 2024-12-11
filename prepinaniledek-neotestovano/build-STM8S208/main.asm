;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.0 #14620 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _milis
	.globl _init_milis
	.globl _GPIO_ReadInputPin
	.globl _GPIO_WriteLow
	.globl _GPIO_WriteHigh
	.globl _GPIO_Init
	.globl _CLK_HSIPrescalerConfig
	.globl _init
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; Stack segment in internal ram
;--------------------------------------------------------
	.area SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)

; default segment ordering for linker
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area CONST
	.area INITIALIZER
	.area CODE

;--------------------------------------------------------
; interrupt vector
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ; reset
	int _TRAP_IRQHandler ; trap
	int _TLI_IRQHandler ; int0
	int _AWU_IRQHandler ; int1
	int _CLK_IRQHandler ; int2
	int _EXTI_PORTA_IRQHandler ; int3
	int _EXTI_PORTB_IRQHandler ; int4
	int _EXTI_PORTC_IRQHandler ; int5
	int _EXTI_PORTD_IRQHandler ; int6
	int _EXTI_PORTE_IRQHandler ; int7
	int _CAN_RX_IRQHandler ; int8
	int _CAN_TX_IRQHandler ; int9
	int _SPI_IRQHandler ; int10
	int _TIM1_UPD_OVF_TRG_BRK_IRQHandler ; int11
	int _TIM1_CAP_COM_IRQHandler ; int12
	int _TIM2_UPD_OVF_BRK_IRQHandler ; int13
	int _TIM2_CAP_COM_IRQHandler ; int14
	int _TIM3_UPD_OVF_BRK_IRQHandler ; int15
	int _TIM3_CAP_COM_IRQHandler ; int16
	int _UART1_TX_IRQHandler ; int17
	int _UART1_RX_IRQHandler ; int18
	int _I2C_IRQHandler ; int19
	int _UART3_TX_IRQHandler ; int20
	int _UART3_RX_IRQHandler ; int21
	int _ADC2_IRQHandler ; int22
	int _TIM4_UPD_OVF_IRQHandler ; int23
	int _EEPROM_EEC_IRQHandler ; int24
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
	call	___sdcc_external_startup
	tnz	a
	jreq	__sdcc_init_data
	jp	__sdcc_program_startup
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	./src/main.c: 6: void init(void) {
; genLabel
;	-----------------------------------------
;	 function init
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_init:
;	./src/main.c: 7: CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); // Nastaví taktování MCU na 16 MHz 
; genSend
	clr	a
; genCall
	call	_CLK_HSIPrescalerConfig
;	./src/main.c: 9: GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_SLOW); // Inicializuje PB.0 jako výstup s nízkou hodnotou a nízkou rychlostí.
; genIPush
	push	#0xc0
; genSend
	ld	a, #0x01
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_Init
;	./src/main.c: 10: GPIO_Init(GPIOB, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_SLOW); // Inicializuje PB.1 ...
; genIPush
	push	#0xc0
; genSend
	ld	a, #0x02
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_Init
;	./src/main.c: 11: GPIO_Init(GPIOB, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_SLOW); // Inicializuje PB.2 ...
; genIPush
	push	#0xc0
; genSend
	ld	a, #0x04
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_Init
;	./src/main.c: 12: GPIO_Init(GPIOB, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);     // Inicializuje PB.3 jako vstup s interním pull-up rezistorem(kvuli tlačítku), bez přerušení.
; genIPush
	push	#0x40
; genSend
	ld	a, #0x08
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_Init
;	./src/main.c: 14: init_milis(); 
; genCall
	jp	_init_milis
; genLabel
00101$:
;	./src/main.c: 15: }
; genEndFunction
	ret
;	./src/main.c: 17: int main(void) {
; genLabel
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 11 bytes.
_main:
	sub	sp, #11
;	./src/main.c: 18: uint8_t led_out = 1;   // uložení stavu LED (která LED má svítit).
; genAssign
	ld	a, #0x01
	ld	(0x01, sp), a
;	./src/main.c: 19: uint32_t time = 0;     // čas posledního stisknutí tlačítka 
; genAssign
	clrw	x
	ldw	(0x04, sp), x
	ldw	(0x02, sp), x
;	./src/main.c: 20: uint8_t lasttlac = 0;  // předchozí stav tlačítka pro detekci změny.
; genAssign
	clr	(0x06, sp)
;	./src/main.c: 23: init(); // nastaví GPIO piny a časovač.
; genCall
	call	_init
;	./src/main.c: 24: GPIO_WriteHigh(GPIOB, GPIO_PIN_0);
; genSend
	ld	a, #0x01
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_WriteHigh
;	./src/main.c: 25: while (1) { 
; genLabel
00114$:
;	./src/main.c: 26: tlac = GPIO_ReadInputPin(GPIOB, GPIO_PIN_3); //stav tlačítka na pinu PB.3
; genSend
	ld	a, #0x08
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_ReadInputPin
; genCast
; genAssign
	ld	(0x07, sp), a
;	./src/main.c: 29: if ((milis() - time > 200) && !tlac && lasttlac) {
; genCall
	call	_milis
	exgw	x, y
; genMinus
	subw	y, (0x04, sp)
	ldw	(0x0a, sp), y
	ld	a, xl
	sbc	a, (0x03, sp)
	ld	(0x09, sp), a
	ld	a, xh
	sbc	a, (0x02, sp)
	ld	(0x08, sp), a
; genCmp
; genCmpTnz
	ldw	x, #0x00c8
	cpw	x, (0x0a, sp)
	clr	a
	sbc	a, (0x09, sp)
	clr	a
	sbc	a, (0x08, sp)
	jrc	00167$
	jp	00110$
00167$:
; skipping generated iCode
; genIfx
	tnz	(0x07, sp)
	jreq	00168$
	jp	00110$
00168$:
; genIfx
	tnz	(0x06, sp)
	jrne	00169$
	jp	00110$
00169$:
;	./src/main.c: 30: led_out += 1;   // Zvýší proměnnou led_out o 1, což změní stav LED
; genCast
; genAssign
	ld	a, (0x01, sp)
; genPlus
	inc	a
	ld	(0x01, sp), a
;	./src/main.c: 31: time = milis(); // aktuální čas pro další kontrolu intervalu 200 ms
; genCall
	call	_milis
	ldw	(0x04, sp), x
	ldw	(0x02, sp), y
;	./src/main.c: 34: if (led_out > 3) {
; genCmp
; genCmpTnz
	ld	a, (0x01, sp)
	cp	a, #0x03
	jrugt	00170$
	jp	00102$
00170$:
; skipping generated iCode
;	./src/main.c: 35: led_out = 1;
; genAssign
	ld	a, #0x01
	ld	(0x01, sp), a
; genLabel
00102$:
;	./src/main.c: 39: if (led_out == 1) {
; genCmpEQorNE
	ld	a, (0x01, sp)
	dec	a
	jrne	00172$
	jp	00173$
00172$:
	jp	00107$
00173$:
; skipping generated iCode
;	./src/main.c: 40: GPIO_WriteHigh(GPIOB, GPIO_PIN_0); // Zapne LED na pinu PB.0
; genSend
	ld	a, #0x01
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_WriteHigh
;	./src/main.c: 41: GPIO_WriteLow(GPIOB, GPIO_PIN_2);  // Vypne LED na pinu PB.2
; genSend
	ld	a, #0x04
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_WriteLow
; genGoto
	jp	00110$
; genLabel
00107$:
;	./src/main.c: 42: } else if (led_out == 2) {
; genCmpEQorNE
	ld	a, (0x01, sp)
	cp	a, #0x02
	jrne	00175$
	jp	00176$
00175$:
	jp	00104$
00176$:
; skipping generated iCode
;	./src/main.c: 43: GPIO_WriteHigh(GPIOB, GPIO_PIN_1); // Zapne LED na pinu PB.1
; genSend
	ld	a, #0x02
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_WriteHigh
;	./src/main.c: 44: GPIO_WriteLow(GPIOB, GPIO_PIN_0);  // Vypne LED na pinu PB.0
; genSend
	ld	a, #0x01
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_WriteLow
; genGoto
	jp	00110$
; genLabel
00104$:
;	./src/main.c: 46: GPIO_WriteHigh(GPIOB, GPIO_PIN_2); // Zapne LED na pinu PB.2
; genSend
	ld	a, #0x04
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_WriteHigh
;	./src/main.c: 47: GPIO_WriteLow(GPIOB, GPIO_PIN_1);  // Vypne LED na pinu PB.1
; genSend
	ld	a, #0x02
; genSend
	ldw	x, #0x5005
; genCall
	call	_GPIO_WriteLow
; genLabel
00110$:
;	./src/main.c: 51: lasttlac = tlac; // Uloží aktuální stav tlačítka do `lasttlac` pro příští iteraci.
; genAssign
	ld	a, (0x07, sp)
	ld	(0x06, sp), a
; genGoto
	jp	00114$
; genLabel
00116$:
;	./src/main.c: 53: }
; genEndFunction
	addw	sp, #11
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
