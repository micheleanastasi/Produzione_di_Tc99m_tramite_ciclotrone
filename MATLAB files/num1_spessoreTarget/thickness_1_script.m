% *************************************************************************
% Calcolo spessore a partire da energia protoni fascio e soglia reazione
% Basato su dati stopping power
% *************************************************************************
close all; clc ; clear all;
format long

%% DATI
En_pro = 30000; %KeV - energia scelta
En_thr = 7796.7; %KeV - energia soglia reazione 100Mo->99mTc

%% Carico dati
load data.txt %prima colonna: energie; seconda:stopping power in MeV*cm^2/g
data_conv(:,1) = data(:,1).*1000;   %conversione MeV -> KeV
data_conv(:,2) = data(:,2).*1.022;  %conv MeV*cm^2/g -> kev/uM
loglog(data_conv(:,1),data_conv(:,2)) %grafico loglog stopping power
xlabel('Energie protoni [KeV]')
ylabel('dE/dx [KeV/micron]')
title('Stopping power protoni in molibdeno (abbondanza isotopica naturale)')

%% Calcolo spessore
t = thickCalc(En_pro,En_thr,data_conv);

%% Display result
fprintf('Energia protoni scelta: %.1f MeV\n',En_pro/1000)
fprintf('Target thickness: %d micron\n',t)
