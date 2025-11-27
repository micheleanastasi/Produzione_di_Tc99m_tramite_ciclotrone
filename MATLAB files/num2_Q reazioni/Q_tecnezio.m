% *************************************************************************
% Calcolo Q value e energia di soglia particella incidente
% *************************************************************************
close all; clc ; clear;
format long

%% DATA - Dati espressi in uma, tranne eccezioni specificate
conv = 931.4936148; % uma -> Mev

m_n = 1.008664916;
m_p = 1.007276466621;

B_tc = 8.61361;  %MeV per nucleone, nb Tc -> A=99
B_mo = 8.604663; %idem, nb Mo -> A=100

m_mo = (42*m_p + (100-42)*m_n) - B_mo*100/conv;
m_tc = (43*m_p + (99-43)*m_n) - B_tc*99/conv;

%% CALC Q Value e soglia
deltaM = m_mo + m_p - m_tc - 2*m_n;
Qvalue = deltaM * conv; %MeV

ratio = (m_tc + 2*m_n)/(m_tc + 2*m_n - m_p);
E_threshold = -Qvalue*ratio; %MeV

%% stampa
fprintf('Q value: %4.4f MeV\n',Qvalue)
fprintf('Energia di soglia: %4.4f MeV\n',E_threshold)



