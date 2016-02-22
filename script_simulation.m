clc;
close all;
clear all;

T=2;
M=32;
Te=T/M;
Tsim=T-Te;
Fsin=5.5; %il faut que le frequence soit un multiple de 1/t pour que la fft puisse distinguer que cette frequence ,ici 5.5 n'est pas un multipe de 1,
%d'ou la figure4 
sim('simulation');

figure(1);
plot(Tps_Cont,Sin_Cont,'r');

figure(2);
plot(Tps_ech,Sin_Ech,'b');
fft(Sin_Cont);


figure(3);
VEC_fre=linspace(0,1/Te-1/T,M)';
plot(VEC_fre,abs(fft(Sin_Ech)),'r'); %il faut eviter d'avoir fsin>fe/2 car la fft va avoir du mal  à distinguer les differentes frequences(th de shannon)

%8)pour obtneir la bonne fft pour la frequence 5.5 , il faut choisir t=2 ,en
%effet F0=coef*F=coef*(1/t) or f0=5.5 d'ou t=2,de facon generale ,à
%frequence donné ,il faut jour le temps d'echantillonage t pour obtenir la
%bonne fft


%10)à f=16 ,on est à la moitié des points donc on devrait voir une fft nulle ,mais à cause des erreur de matlab ,on obtient une courbe donc les valeurs ont proche de zero
%on ne respecte plus le critere de shannon en effet fsin =16 fe=32 on fsin=fe/2 donc le critere de shannon n'est plus respecté.

%11)à f=25 , les courbes se  sont interchangés ,c'est pas bien 
