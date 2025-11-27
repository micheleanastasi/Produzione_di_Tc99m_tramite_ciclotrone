% *************************************************************************
% 100Mo + p -> 97mNb + 4He
% *************************************************************************
close all; clc ; clear;
format long

%% DATA - Dati espressi in uma, tranne eccezioni specificate
conv = 931.4936148; % uma -> Mev/c^2

m_n = 1.008664916;
m_p = 1.007276466621;

B_nb = 8.62314;  %MeV per nucleone, nb Tc -> A=99
B_mo = 8.604663; %idem, nb Mo -> A=100
B_alfa = 7.073916;

m_mo = (42*m_p + (100-42)*m_n) - B_mo*100/conv;
m_nb = (41*m_p + (97-41)*m_n) - B_nb*97/conv;
m_alfa = (2*m_p + 2*m_n) - B_alfa*4/conv;

%% CALC Q Value e soglia
deltaM = m_mo + m_p - m_nb - m_alfa;
Qvalue = deltaM * conv; %MeV

%% stampa
fprintf('Q value: %4.4f MeV\n',Qvalue)
