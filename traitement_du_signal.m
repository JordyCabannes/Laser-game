%projet traitement du signal 

clc;
close all;
clear all;

T=0.2*10^-3;
M=64;
Te=T/M;
Tsim=T-Te;
F1=85*10^3;
F2=90*10^3;
F3=95*10^3;
F4=100*10^3; 
F5=115*10^3;
F6=120*10^3;
sim('simulation_projet_ana_signal');

figure(1);
for i=1:32
   Sin_Ech(i)=0;
end
plot(linspace(0,1/Te-1/T,M),abs(fft(Sin_Ech)), 'r');
%fonc_transfert=tf(1,[1 3.0332*10^-6 1.162*10^-11 7.6663*10^-18 1.7483*10^-23]);
%fonc_transfert=tf(1,[1.7483*10^-23 7.6663*10^-18 1.162*10^-11 3.0332*10^-6 1]);
%bode(fonc_transfert);
figure(2);
plot(linspace(0,1/Te-1/T,M),Sin_Ech,'b');
%figure(2)
%plot(linspace(0,1/Te-1/T,M),abs(fft(Sin_Ech)),'+');

f1=tf(1,[8.976*10^-12 2.783*10^-6 1]);
f2=tf(1,[1.948*10^-12 2.502*10^-7 1]);

%figure(3)
%bode(f1,'r',f2,'b');

