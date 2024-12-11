                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler 
                                      3 ; Version 4.4.0 #14620 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module milis
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _TIM4_ClearFlag
                                     12 	.globl _TIM4_ITConfig
                                     13 	.globl _TIM4_Cmd
                                     14 	.globl _TIM4_TimeBaseInit
                                     15 	.globl _ITC_SetSoftwarePriority
                                     16 	.globl _miliseconds
                                     17 	.globl _milis
                                     18 	.globl _init_milis
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area DATA
                                     23 ;--------------------------------------------------------
                                     24 ; ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area INITIALIZED
      000001                         27 _miliseconds::
      000001                         28 	.ds 4
                                     29 ;--------------------------------------------------------
                                     30 ; absolute external ram data
                                     31 ;--------------------------------------------------------
                                     32 	.area DABS (ABS)
                                     33 
                                     34 ; default segment ordering for linker
                                     35 	.area HOME
                                     36 	.area GSINIT
                                     37 	.area GSFINAL
                                     38 	.area CONST
                                     39 	.area INITIALIZER
                                     40 	.area CODE
                                     41 
                                     42 ;--------------------------------------------------------
                                     43 ; global & static initialisations
                                     44 ;--------------------------------------------------------
                                     45 	.area HOME
                                     46 	.area GSINIT
                                     47 	.area GSFINAL
                                     48 	.area GSINIT
                                     49 ;--------------------------------------------------------
                                     50 ; Home
                                     51 ;--------------------------------------------------------
                                     52 	.area HOME
                                     53 	.area HOME
                                     54 ;--------------------------------------------------------
                                     55 ; code
                                     56 ;--------------------------------------------------------
                                     57 	.area CODE
                                     58 ;	./src/milis.c: 13: MILIS_PROTOTYPE
                                     59 ; genLabel
                                     60 ;	-----------------------------------------
                                     61 ;	 function milis
                                     62 ;	-----------------------------------------
                                     63 ;	Register assignment is optimal.
                                     64 ;	Stack space usage: 4 bytes.
      008253                         65 _milis:
      008253 52 04            [ 2]   66 	sub	sp, #4
                                     67 ;	./src/milis.c: 20: TIM4_ITConfig(TIM4_IT_UPDATE, DISABLE);
                                     68 ; genIPush
      008255 4B 00            [ 1]   69 	push	#0x00
                                     70 ; genSend
      008257 A6 01            [ 1]   71 	ld	a, #0x01
                                     72 ; genCall
      008259 CD 83 51         [ 4]   73 	call	_TIM4_ITConfig
                                     74 ;	./src/milis.c: 21: tmp = miliseconds;
                                     75 ; genAssign
      00825C CE 00 03         [ 2]   76 	ldw	x, _miliseconds+2
      00825F 90 CE 00 01      [ 2]   77 	ldw	y, _miliseconds+0
      008263 17 01            [ 2]   78 	ldw	(0x01, sp), y
                                     79 ;	./src/milis.c: 22: TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
                                     80 ; genIPush
      008265 89               [ 2]   81 	pushw	x
      008266 4B 01            [ 1]   82 	push	#0x01
                                     83 ; genSend
      008268 A6 01            [ 1]   84 	ld	a, #0x01
                                     85 ; genCall
      00826A CD 83 51         [ 4]   86 	call	_TIM4_ITConfig
      00826D 85               [ 2]   87 	popw	x
                                     88 ;	./src/milis.c: 23: return tmp;
                                     89 ; genReturn
      00826E 16 01            [ 2]   90 	ldw	y, (0x01, sp)
                                     91 ; genLabel
      008270                         92 00101$:
                                     93 ;	./src/milis.c: 24: }
                                     94 ; genEndFunction
      008270 5B 04            [ 2]   95 	addw	sp, #4
      008272 81               [ 4]   96 	ret
                                     97 ;	./src/milis.c: 27: void init_milis(void)
                                     98 ; genLabel
                                     99 ;	-----------------------------------------
                                    100 ;	 function init_milis
                                    101 ;	-----------------------------------------
                                    102 ;	Register assignment is optimal.
                                    103 ;	Stack space usage: 0 bytes.
      008273                        104 _init_milis:
                                    105 ;	./src/milis.c: 29: TIM4_TimeBaseInit(PRESCALER, PERIOD);       // (16MHz / 128) / 125 = 1000Hz
                                    106 ; genIPush
      008273 4B 7C            [ 1]  107 	push	#0x7c
                                    108 ; genSend
      008275 A6 07            [ 1]  109 	ld	a, #0x07
                                    110 ; genCall
      008277 CD 85 0E         [ 4]  111 	call	_TIM4_TimeBaseInit
                                    112 ;	./src/milis.c: 30: TIM4_ClearFlag(TIM4_FLAG_UPDATE);
                                    113 ; genSend
      00827A A6 01            [ 1]  114 	ld	a, #0x01
                                    115 ; genCall
      00827C CD 85 96         [ 4]  116 	call	_TIM4_ClearFlag
                                    117 ;	./src/milis.c: 31: TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
                                    118 ; genIPush
      00827F 4B 01            [ 1]  119 	push	#0x01
                                    120 ; genSend
      008281 A6 01            [ 1]  121 	ld	a, #0x01
                                    122 ; genCall
      008283 CD 83 51         [ 4]  123 	call	_TIM4_ITConfig
                                    124 ;	./src/milis.c: 32: ITC_SetSoftwarePriority(ITC_IRQ_TIM4_OVF, ITC_PRIORITYLEVEL_1);     // n�zk� priorita p�eru�en�
                                    125 ; genIPush
      008286 4B 01            [ 1]  126 	push	#0x01
                                    127 ; genSend
      008288 A6 17            [ 1]  128 	ld	a, #0x17
                                    129 ; genCall
      00828A CD 84 18         [ 4]  130 	call	_ITC_SetSoftwarePriority
                                    131 ;	./src/milis.c: 33: enableInterrupts();
                                    132 ;	genInline
      00828D 9A               [ 1]  133 	rim
                                    134 ;	./src/milis.c: 34: TIM4_Cmd(ENABLE);
                                    135 ; genSend
      00828E A6 01            [ 1]  136 	ld	a, #0x01
                                    137 ; genCall
      008290 CC 83 E7         [ 2]  138 	jp	_TIM4_Cmd
                                    139 ; genLabel
      008293                        140 00101$:
                                    141 ;	./src/milis.c: 35: }
                                    142 ; genEndFunction
      008293 81               [ 4]  143 	ret
                                    144 	.area CODE
                                    145 	.area CONST
                                    146 	.area INITIALIZER
      008095                        147 __xinit__miliseconds:
      008095 00 00 00 00            148 	.byte #0x00, #0x00, #0x00, #0x00	; 0
                                    149 	.area CABS (ABS)
