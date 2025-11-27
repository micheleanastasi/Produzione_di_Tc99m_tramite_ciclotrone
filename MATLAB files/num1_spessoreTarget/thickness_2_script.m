% *************************************************************************
% Plot spessore target in funzione dell'energia dei protoni
% *************************************************************************
close all; clc ; clear;
format long

%% DATI
En_thr = 7796.7;  %KeV
% estremi energie del grafico
a = 7800; %KeV
b = 30000; %KeV

%% Carico dati
load data.txt
data_conv(:,1) = data(:,1).*1000;   %MeV to KeV
data_conv(:,2) = data(:,2).*1.022;  %MeV*cm^2/g to kev/uM

%% Calcolo 
en = linspace(a,b,(b-a)/100+1); %ascisse grafico (energie)
sp = zeros(1,length(en)); %inizializzo array

% per ogni valore di energia del linspace calcolo lo spessore associato del
% target, in modo tale da costruire il grafico
for ( i=1:1:length(en) )
    sp(i) = thickCalc(en(i), En_thr, data_conv); %calcolo spessore
end

%% plot
plot(en./1000,sp)
xlabel('Energie protoni fascio [MeV]')
ylabel('Spessore [micron]')
title('Andamento spessore con energia protoni')
