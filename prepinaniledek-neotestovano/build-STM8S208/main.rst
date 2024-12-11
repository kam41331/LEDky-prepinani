                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler 
                                      3 ; Version 4.4.0 #14620 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl _milis
                                     13 	.globl _init_milis
                                     14 	.globl _GPIO_ReadInputPin
                                     15 	.globl _GPIO_WriteLow
                                     16 	.globl _GPIO_WriteHigh
                                     17 	.globl _GPIO_Init
                                     18 	.globl _CLK_HSIPrescalerConfig
                                     19 	.globl _init
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area DATA
                                     24 ;--------------------------------------------------------
                                     25 ; ram data
                                     26 ;--------------------------------------------------------
                                     27 	.area INITIALIZED
                                     28 ;--------------------------------------------------------
                                     29 ; Stack segment in internal ram
                                     30 ;--------------------------------------------------------
                                     31 	.area SSEG
      00859B                         32 __start__stack:
      00859B                         33 	.ds	1
                                     34 
                                     35 ;--------------------------------------------------------
                                     36 ; absolute external ram data
                                     37 ;--------------------------------------------------------
                                     38 	.area DABS (ABS)
                                     39 
                                     40 ; default segment ordering for linker
                                     41 	.area HOME
                                     42 	.area GSINIT
                                     43 	.area GSFINAL
                                     44 	.area CONST
                                     45 	.area INITIALIZER
                                     46 	.area CODE
                                     47 
                                     48 ;--------------------------------------------------------
                                     49 ; interrupt vector
                                     50 ;--------------------------------------------------------
                                     51 	.area HOME
      008000                         52 __interrupt_vect:
      008000 82 00 80 6F             53 	int s_GSINIT ; reset
      008004 82 00 82 94             54 	int _TRAP_IRQHandler ; trap
      008008 82 00 82 95             55 	int _TLI_IRQHandler ; int0
      00800C 82 00 82 96             56 	int _AWU_IRQHandler ; int1
      008010 82 00 82 97             57 	int _CLK_IRQHandler ; int2
      008014 82 00 82 98             58 	int _EXTI_PORTA_IRQHandler ; int3
      008018 82 00 82 99             59 	int _EXTI_PORTB_IRQHandler ; int4
      00801C 82 00 82 9A             60 	int _EXTI_PORTC_IRQHandler ; int5
      008020 82 00 82 9B             61 	int _EXTI_PORTD_IRQHandler ; int6
      008024 82 00 82 9C             62 	int _EXTI_PORTE_IRQHandler ; int7
      008028 82 00 82 9D             63 	int _CAN_RX_IRQHandler ; int8
      00802C 82 00 82 9E             64 	int _CAN_TX_IRQHandler ; int9
      008030 82 00 82 9F             65 	int _SPI_IRQHandler ; int10
      008034 82 00 82 A0             66 	int _TIM1_UPD_OVF_TRG_BRK_IRQHandler ; int11
      008038 82 00 82 A1             67 	int _TIM1_CAP_COM_IRQHandler ; int12
      00803C 82 00 82 A2             68 	int _TIM2_UPD_OVF_BRK_IRQHandler ; int13
      008040 82 00 82 A3             69 	int _TIM2_CAP_COM_IRQHandler ; int14
      008044 82 00 82 A4             70 	int _TIM3_UPD_OVF_BRK_IRQHandler ; int15
      008048 82 00 82 A5             71 	int _TIM3_CAP_COM_IRQHandler ; int16
      00804C 82 00 82 A6             72 	int _UART1_TX_IRQHandler ; int17
      008050 82 00 82 A7             73 	int _UART1_RX_IRQHandler ; int18
      008054 82 00 82 A8             74 	int _I2C_IRQHandler ; int19
      008058 82 00 82 A9             75 	int _UART3_TX_IRQHandler ; int20
      00805C 82 00 82 AA             76 	int _UART3_RX_IRQHandler ; int21
      008060 82 00 82 AB             77 	int _ADC2_IRQHandler ; int22
      008064 82 00 82 AC             78 	int _TIM4_UPD_OVF_IRQHandler ; int23
      008068 82 00 82 C6             79 	int _EEPROM_EEC_IRQHandler ; int24
                                     80 ;--------------------------------------------------------
                                     81 ; global & static initialisations
                                     82 ;--------------------------------------------------------
                                     83 	.area HOME
                                     84 	.area GSINIT
                                     85 	.area GSFINAL
                                     86 	.area GSINIT
      00806F CD 83 E5         [ 4]   87 	call	___sdcc_external_startup
      008072 4D               [ 1]   88 	tnz	a
      008073 27 03            [ 1]   89 	jreq	__sdcc_init_data
      008075 CC 80 6C         [ 2]   90 	jp	__sdcc_program_startup
      008078                         91 __sdcc_init_data:
                                     92 ; stm8_genXINIT() start
      008078 AE 00 00         [ 2]   93 	ldw x, #l_DATA
      00807B 27 07            [ 1]   94 	jreq	00002$
      00807D                         95 00001$:
      00807D 72 4F 00 00      [ 1]   96 	clr (s_DATA - 1, x)
      008081 5A               [ 2]   97 	decw x
      008082 26 F9            [ 1]   98 	jrne	00001$
      008084                         99 00002$:
      008084 AE 00 04         [ 2]  100 	ldw	x, #l_INITIALIZER
      008087 27 09            [ 1]  101 	jreq	00004$
      008089                        102 00003$:
      008089 D6 80 94         [ 1]  103 	ld	a, (s_INITIALIZER - 1, x)
      00808C D7 00 00         [ 1]  104 	ld	(s_INITIALIZED - 1, x), a
      00808F 5A               [ 2]  105 	decw	x
      008090 26 F7            [ 1]  106 	jrne	00003$
      008092                        107 00004$:
                                    108 ; stm8_genXINIT() end
                                    109 	.area GSFINAL
      008092 CC 80 6C         [ 2]  110 	jp	__sdcc_program_startup
                                    111 ;--------------------------------------------------------
                                    112 ; Home
                                    113 ;--------------------------------------------------------
                                    114 	.area HOME
                                    115 	.area HOME
      00806C                        116 __sdcc_program_startup:
      00806C CC 81 90         [ 2]  117 	jp	_main
                                    118 ;	return from main will return to caller
                                    119 ;--------------------------------------------------------
                                    120 ; code
                                    121 ;--------------------------------------------------------
                                    122 	.area CODE
                                    123 ;	./src/main.c: 6: void init(void) {
                                    124 ; genLabel
                                    125 ;	-----------------------------------------
                                    126 ;	 function init
                                    127 ;	-----------------------------------------
                                    128 ;	Register assignment is optimal.
                                    129 ;	Stack space usage: 0 bytes.
      008160                        130 _init:
                                    131 ;	./src/main.c: 7: CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); // Nastaví taktování MCU na 16 MHz 
                                    132 ; genSend
      008160 4F               [ 1]  133 	clr	a
                                    134 ; genCall
      008161 CD 84 03         [ 4]  135 	call	_CLK_HSIPrescalerConfig
                                    136 ;	./src/main.c: 9: GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_SLOW); // Inicializuje PB.0 jako výstup s nízkou hodnotou a nízkou rychlostí.
                                    137 ; genIPush
      008164 4B C0            [ 1]  138 	push	#0xc0
                                    139 ; genSend
      008166 A6 01            [ 1]  140 	ld	a, #0x01
                                    141 ; genSend
      008168 AE 50 05         [ 2]  142 	ldw	x, #0x5005
                                    143 ; genCall
      00816B CD 82 C7         [ 4]  144 	call	_GPIO_Init
                                    145 ;	./src/main.c: 10: GPIO_Init(GPIOB, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_SLOW); // Inicializuje PB.1 ...
                                    146 ; genIPush
      00816E 4B C0            [ 1]  147 	push	#0xc0
                                    148 ; genSend
      008170 A6 02            [ 1]  149 	ld	a, #0x02
                                    150 ; genSend
      008172 AE 50 05         [ 2]  151 	ldw	x, #0x5005
                                    152 ; genCall
      008175 CD 82 C7         [ 4]  153 	call	_GPIO_Init
                                    154 ;	./src/main.c: 11: GPIO_Init(GPIOB, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_SLOW); // Inicializuje PB.2 ...
                                    155 ; genIPush
      008178 4B C0            [ 1]  156 	push	#0xc0
                                    157 ; genSend
      00817A A6 04            [ 1]  158 	ld	a, #0x04
                                    159 ; genSend
      00817C AE 50 05         [ 2]  160 	ldw	x, #0x5005
                                    161 ; genCall
      00817F CD 82 C7         [ 4]  162 	call	_GPIO_Init
                                    163 ;	./src/main.c: 12: GPIO_Init(GPIOB, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);     // Inicializuje PB.3 jako vstup s interním pull-up rezistorem(kvuli tlačítku), bez přerušení.
                                    164 ; genIPush
      008182 4B 40            [ 1]  165 	push	#0x40
                                    166 ; genSend
      008184 A6 08            [ 1]  167 	ld	a, #0x08
                                    168 ; genSend
      008186 AE 50 05         [ 2]  169 	ldw	x, #0x5005
                                    170 ; genCall
      008189 CD 82 C7         [ 4]  171 	call	_GPIO_Init
                                    172 ;	./src/main.c: 14: init_milis(); 
                                    173 ; genCall
      00818C CC 82 73         [ 2]  174 	jp	_init_milis
                                    175 ; genLabel
      00818F                        176 00101$:
                                    177 ;	./src/main.c: 15: }
                                    178 ; genEndFunction
      00818F 81               [ 4]  179 	ret
                                    180 ;	./src/main.c: 17: int main(void) {
                                    181 ; genLabel
                                    182 ;	-----------------------------------------
                                    183 ;	 function main
                                    184 ;	-----------------------------------------
                                    185 ;	Register assignment might be sub-optimal.
                                    186 ;	Stack space usage: 11 bytes.
      008190                        187 _main:
      008190 52 0B            [ 2]  188 	sub	sp, #11
                                    189 ;	./src/main.c: 18: uint8_t led_out = 1;   // uložení stavu LED (která LED má svítit).
                                    190 ; genAssign
      008192 A6 01            [ 1]  191 	ld	a, #0x01
      008194 6B 01            [ 1]  192 	ld	(0x01, sp), a
                                    193 ;	./src/main.c: 19: uint32_t time = 0;     // čas posledního stisknutí tlačítka 
                                    194 ; genAssign
      008196 5F               [ 1]  195 	clrw	x
      008197 1F 04            [ 2]  196 	ldw	(0x04, sp), x
      008199 1F 02            [ 2]  197 	ldw	(0x02, sp), x
                                    198 ;	./src/main.c: 20: uint8_t lasttlac = 0;  // předchozí stav tlačítka pro detekci změny.
                                    199 ; genAssign
      00819B 0F 06            [ 1]  200 	clr	(0x06, sp)
                                    201 ;	./src/main.c: 23: init(); // nastaví GPIO piny a časovač.
                                    202 ; genCall
      00819D CD 81 60         [ 4]  203 	call	_init
                                    204 ;	./src/main.c: 24: GPIO_WriteHigh(GPIOB, GPIO_PIN_0);
                                    205 ; genSend
      0081A0 A6 01            [ 1]  206 	ld	a, #0x01
                                    207 ; genSend
      0081A2 AE 50 05         [ 2]  208 	ldw	x, #0x5005
                                    209 ; genCall
      0081A5 CD 85 05         [ 4]  210 	call	_GPIO_WriteHigh
                                    211 ;	./src/main.c: 25: while (1) { 
                                    212 ; genLabel
      0081A8                        213 00114$:
                                    214 ;	./src/main.c: 26: tlac = GPIO_ReadInputPin(GPIOB, GPIO_PIN_3); //stav tlačítka na pinu PB.3
                                    215 ; genSend
      0081A8 A6 08            [ 1]  216 	ld	a, #0x08
                                    217 ; genSend
      0081AA AE 50 05         [ 2]  218 	ldw	x, #0x5005
                                    219 ; genCall
      0081AD CD 83 73         [ 4]  220 	call	_GPIO_ReadInputPin
                                    221 ; genCast
                                    222 ; genAssign
      0081B0 6B 07            [ 1]  223 	ld	(0x07, sp), a
                                    224 ;	./src/main.c: 29: if ((milis() - time > 200) && !tlac && lasttlac) {
                                    225 ; genCall
      0081B2 CD 82 53         [ 4]  226 	call	_milis
      0081B5 51               [ 1]  227 	exgw	x, y
                                    228 ; genMinus
      0081B6 72 F2 04         [ 2]  229 	subw	y, (0x04, sp)
      0081B9 17 0A            [ 2]  230 	ldw	(0x0a, sp), y
      0081BB 9F               [ 1]  231 	ld	a, xl
      0081BC 12 03            [ 1]  232 	sbc	a, (0x03, sp)
      0081BE 6B 09            [ 1]  233 	ld	(0x09, sp), a
      0081C0 9E               [ 1]  234 	ld	a, xh
      0081C1 12 02            [ 1]  235 	sbc	a, (0x02, sp)
      0081C3 6B 08            [ 1]  236 	ld	(0x08, sp), a
                                    237 ; genCmp
                                    238 ; genCmpTnz
      0081C5 AE 00 C8         [ 2]  239 	ldw	x, #0x00c8
      0081C8 13 0A            [ 2]  240 	cpw	x, (0x0a, sp)
      0081CA 4F               [ 1]  241 	clr	a
      0081CB 12 09            [ 1]  242 	sbc	a, (0x09, sp)
      0081CD 4F               [ 1]  243 	clr	a
      0081CE 12 08            [ 1]  244 	sbc	a, (0x08, sp)
      0081D0 25 03            [ 1]  245 	jrc	00167$
      0081D2 CC 82 49         [ 2]  246 	jp	00110$
      0081D5                        247 00167$:
                                    248 ; skipping generated iCode
                                    249 ; genIfx
      0081D5 0D 07            [ 1]  250 	tnz	(0x07, sp)
      0081D7 27 03            [ 1]  251 	jreq	00168$
      0081D9 CC 82 49         [ 2]  252 	jp	00110$
      0081DC                        253 00168$:
                                    254 ; genIfx
      0081DC 0D 06            [ 1]  255 	tnz	(0x06, sp)
      0081DE 26 03            [ 1]  256 	jrne	00169$
      0081E0 CC 82 49         [ 2]  257 	jp	00110$
      0081E3                        258 00169$:
                                    259 ;	./src/main.c: 30: led_out += 1;   // Zvýší proměnnou led_out o 1, což změní stav LED
                                    260 ; genCast
                                    261 ; genAssign
      0081E3 7B 01            [ 1]  262 	ld	a, (0x01, sp)
                                    263 ; genPlus
      0081E5 4C               [ 1]  264 	inc	a
      0081E6 6B 01            [ 1]  265 	ld	(0x01, sp), a
                                    266 ;	./src/main.c: 31: time = milis(); // aktuální čas pro další kontrolu intervalu 200 ms
                                    267 ; genCall
      0081E8 CD 82 53         [ 4]  268 	call	_milis
      0081EB 1F 04            [ 2]  269 	ldw	(0x04, sp), x
      0081ED 17 02            [ 2]  270 	ldw	(0x02, sp), y
                                    271 ;	./src/main.c: 34: if (led_out > 3) {
                                    272 ; genCmp
                                    273 ; genCmpTnz
      0081EF 7B 01            [ 1]  274 	ld	a, (0x01, sp)
      0081F1 A1 03            [ 1]  275 	cp	a, #0x03
      0081F3 22 03            [ 1]  276 	jrugt	00170$
      0081F5 CC 81 FC         [ 2]  277 	jp	00102$
      0081F8                        278 00170$:
                                    279 ; skipping generated iCode
                                    280 ;	./src/main.c: 35: led_out = 1;
                                    281 ; genAssign
      0081F8 A6 01            [ 1]  282 	ld	a, #0x01
      0081FA 6B 01            [ 1]  283 	ld	(0x01, sp), a
                                    284 ; genLabel
      0081FC                        285 00102$:
                                    286 ;	./src/main.c: 39: if (led_out == 1) {
                                    287 ; genCmpEQorNE
      0081FC 7B 01            [ 1]  288 	ld	a, (0x01, sp)
      0081FE 4A               [ 1]  289 	dec	a
      0081FF 26 03            [ 1]  290 	jrne	00172$
      008201 CC 82 07         [ 2]  291 	jp	00173$
      008204                        292 00172$:
      008204 CC 82 1A         [ 2]  293 	jp	00107$
      008207                        294 00173$:
                                    295 ; skipping generated iCode
                                    296 ;	./src/main.c: 40: GPIO_WriteHigh(GPIOB, GPIO_PIN_0); // Zapne LED na pinu PB.0
                                    297 ; genSend
      008207 A6 01            [ 1]  298 	ld	a, #0x01
                                    299 ; genSend
      008209 AE 50 05         [ 2]  300 	ldw	x, #0x5005
                                    301 ; genCall
      00820C CD 85 05         [ 4]  302 	call	_GPIO_WriteHigh
                                    303 ;	./src/main.c: 41: GPIO_WriteLow(GPIOB, GPIO_PIN_2);  // Vypne LED na pinu PB.2
                                    304 ; genSend
      00820F A6 04            [ 1]  305 	ld	a, #0x04
                                    306 ; genSend
      008211 AE 50 05         [ 2]  307 	ldw	x, #0x5005
                                    308 ; genCall
      008214 CD 83 D9         [ 4]  309 	call	_GPIO_WriteLow
                                    310 ; genGoto
      008217 CC 82 49         [ 2]  311 	jp	00110$
                                    312 ; genLabel
      00821A                        313 00107$:
                                    314 ;	./src/main.c: 42: } else if (led_out == 2) {
                                    315 ; genCmpEQorNE
      00821A 7B 01            [ 1]  316 	ld	a, (0x01, sp)
      00821C A1 02            [ 1]  317 	cp	a, #0x02
      00821E 26 03            [ 1]  318 	jrne	00175$
      008220 CC 82 26         [ 2]  319 	jp	00176$
      008223                        320 00175$:
      008223 CC 82 39         [ 2]  321 	jp	00104$
      008226                        322 00176$:
                                    323 ; skipping generated iCode
                                    324 ;	./src/main.c: 43: GPIO_WriteHigh(GPIOB, GPIO_PIN_1); // Zapne LED na pinu PB.1
                                    325 ; genSend
      008226 A6 02            [ 1]  326 	ld	a, #0x02
                                    327 ; genSend
      008228 AE 50 05         [ 2]  328 	ldw	x, #0x5005
                                    329 ; genCall
      00822B CD 85 05         [ 4]  330 	call	_GPIO_WriteHigh
                                    331 ;	./src/main.c: 44: GPIO_WriteLow(GPIOB, GPIO_PIN_0);  // Vypne LED na pinu PB.0
                                    332 ; genSend
      00822E A6 01            [ 1]  333 	ld	a, #0x01
                                    334 ; genSend
      008230 AE 50 05         [ 2]  335 	ldw	x, #0x5005
                                    336 ; genCall
      008233 CD 83 D9         [ 4]  337 	call	_GPIO_WriteLow
                                    338 ; genGoto
      008236 CC 82 49         [ 2]  339 	jp	00110$
                                    340 ; genLabel
      008239                        341 00104$:
                                    342 ;	./src/main.c: 46: GPIO_WriteHigh(GPIOB, GPIO_PIN_2); // Zapne LED na pinu PB.2
                                    343 ; genSend
      008239 A6 04            [ 1]  344 	ld	a, #0x04
                                    345 ; genSend
      00823B AE 50 05         [ 2]  346 	ldw	x, #0x5005
                                    347 ; genCall
      00823E CD 85 05         [ 4]  348 	call	_GPIO_WriteHigh
                                    349 ;	./src/main.c: 47: GPIO_WriteLow(GPIOB, GPIO_PIN_1);  // Vypne LED na pinu PB.1
                                    350 ; genSend
      008241 A6 02            [ 1]  351 	ld	a, #0x02
                                    352 ; genSend
      008243 AE 50 05         [ 2]  353 	ldw	x, #0x5005
                                    354 ; genCall
      008246 CD 83 D9         [ 4]  355 	call	_GPIO_WriteLow
                                    356 ; genLabel
      008249                        357 00110$:
                                    358 ;	./src/main.c: 51: lasttlac = tlac; // Uloží aktuální stav tlačítka do `lasttlac` pro příští iteraci.
                                    359 ; genAssign
      008249 7B 07            [ 1]  360 	ld	a, (0x07, sp)
      00824B 6B 06            [ 1]  361 	ld	(0x06, sp), a
                                    362 ; genGoto
      00824D CC 81 A8         [ 2]  363 	jp	00114$
                                    364 ; genLabel
      008250                        365 00116$:
                                    366 ;	./src/main.c: 53: }
                                    367 ; genEndFunction
      008250 5B 0B            [ 2]  368 	addw	sp, #11
      008252 81               [ 4]  369 	ret
                                    370 	.area CODE
                                    371 	.area CONST
                                    372 	.area INITIALIZER
                                    373 	.area CABS (ABS)
