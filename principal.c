#include "gassp72.h"
#include "etat.h"


type_etat notre_son ;
extern short Son[];
extern u32 PeriodeSonMicroSec ;
extern int  LongueurSon ; 
//extern u32  PeriodeSonMicroSec ; 


extern void Temporisation(void );
extern void jouer_le_son(void) ;
//u32 Periode_en_Tck=72*PeriodeSonMicroSec; //1s<-> 72MHZ donc 91micro prduit en croix
u32 Periode_PWM_en_Tck = 360;

int main(void)
{
	//initialisation variable 
	notre_son.son = Son ;// affectation à notre variable de type type_etat
	notre_son.taille =LongueurSon ;
	notre_son.periode_ticks = 72*PeriodeSonMicroSec ;
	//notre_son.resolution = 65536 ;
	
	// activation de la PLL qui multiplie la fréquence du quartz par 9
	CLOCK_Configure();
	// config port PB0 pour être utilisé par TIM3-CH3
GPIO_Configure(GPIOB, 0, OUTPUT, ALT_PPULL);
	
// initialisation du timer 4
// Periode_en_Tck doit fournir la durée entre interruptions,
// exprimée en périodes Tck de l'horloge principale du STM32 (72 MHz)
Timer_1234_Init_ff( TIM4, notre_son.periode_ticks );

	// config TIM3-CH3 en mode PWM
notre_son.resolution = PWM_Init_ff( TIM3, 3, Periode_PWM_en_Tck );
Active_IT_Debordement_Timer( TIM4, 2, jouer_le_son );
	while(1);
}
