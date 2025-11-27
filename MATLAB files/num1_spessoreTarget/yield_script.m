% *************************************************************************
% Plot yield, normalizzato a spessore, in funzione dell'energia dei protoni
% Considero come Yield quello in riferimento all'irraggiamento 1h x 1uA
% Prima estraggo yield, poi calcolo spessori
% *************************************************************************
close all; clc ; clear all;
format long

%% DATI
En_thr = 7796.7;
% estremi grafico intervallo
a = 7800;   %KeV
b = 30000;  %KeV

%% CARICO DATI yield e stopping power
% due colonne: prima energie, seconda yield
load mop99tct.txt; %dati valori yields in base all'energia dei protoni
data_yield(:,1) = mop99tct(:,1)*1000; %MeV -> KeV
data_yield(:,2) = mop99tct(:,6); %MBq/uA:, prendo yield riferito a 1h*1uA

load data.txt; %dati stopping power (identico agli altri script)
data_stop(:,1) = data(:,1).*1000;   %MeV -> KeV
data_stop(:,2) = data(:,2).*1.022;  %MeV*cm^2/g -> kev/uM

%% Calcolo 
en = linspace(a,b,(b-a)/100+1); %linspace valori energia per costruire grafico
th = zeros(1,length(en)); %inizializzo variabile

for ( i=1:1:length(en) )
    th(i) = thickCalc(en(i), En_thr, data_stop); %calcolo spessori
    yi(i) = searchValue( en(i), data_yield ); %cerco yield associato ad energie considerate
end
res = yi./th;

%% Plot
plot(en./1000,res);
ylabel('Yield normalizzato per lo spessore [MBq/(uAh*micron)]')
xlabel('Energie protoni [MeV]')
xlim([8 30]);

%% massimi e spessori
[m1,x1] = max(res);
fprintf("Valore ottimo di energia: %2.1f MeV\n",en(x1)./1000)
fprintf("Spessore ottimale: %3.0f micron\n",th(x1))
