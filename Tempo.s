
; ce programme est pour l'assembleur RealView (Keil)
	thumb
	
	area msdata, data, readwrite
flag dcb 0x1 	
	area  moncode, code, readonly
	export Temporisation
	export jouer_le_son ;fonction qui joue le son appelée à chaque interruption
	extern notre_son
	
;
GPIOB_BSRR	equ	0x40010C10 ; Bit Set/Reset register
TIM3_CCR3	equ	0x4000043C	; adresse registre PWM

;pour les déplacements
E_POS	equ	0
E_TAI	equ	4
E_SON	equ	8
E_RES	equ	12
E_PER	equ	16
 

; allumer et eteindre le pin 
Temporisation	proc
	; mise a 1 de PB1
	LDR R0, =flag
	LDR R2,[R0]  
	CMP R2,#0x1
	BEQ eteindre
	ldr	r3, =GPIOB_BSRR
	movs	r1, #0x00000002
	str	r1, [r3]
	movs R2,#0x1 
	ldr R0, =flag ;@flag dans r0
	str R2,[R0]
	b fin 
	
	; mise a zero de PB1
eteindre
	ldr	r3, =GPIOB_BSRR
		movs	r1, #0x00020000
		str	r1, [r3]
		movs R2,#0x0 
		ldr R0, =flag ;@flag dans r0
		str R2,[R0]
		
fin 
	bx	lr	; dernière instruction de la fonction
		endp
		
	;---------------------------------------------------------------------------------------	
		;jouer le son 
jouer_le_son proc 
	LDR R0 , =notre_son
	LDR R4 ,=TIM3_CCR3 
	LDRSH R1,[R0,#E_TAI] ; on recupere le nombre d'echantillons 
	LDRSH R2,[R0,#E_POS] ; on recupere la position courante 
	CMP R2,R1
	BMI traiter_son ; si position< taille on saute au traitement du son sinon on saute à la fin 

	b fin_i 

traiter_son
	LDRSH R3,[R0,#E_SON]; on recupere la base 
	LDRSH R3,[R3,R2 ,LSL #1]
	;ADD R3,R2 ; pour acceder à chaque echantillons de notre tabkeau 
	ADD R3,#32768 ;traitement du son , ajout composante continue 
	LDR R5, [R0,#E_RES]
	MUL R3, R3,R5 ; on multiplie par la résolution 
	MOV R6,#65535
	SDIV R3,R3,R6;on divise par le facteur d'echelle  
	ADD R2,#1 
	STR R2,[R0,#E_POS] 
	STRH R3,[R4] 
	
fin_i
	bx lr 
	endp
	end