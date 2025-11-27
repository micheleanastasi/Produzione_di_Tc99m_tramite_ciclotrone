% *************************************************************************
% VERSIONE CON SPESSORE CORRETTO!
% Plot yield, normalizzato a spessore, in funzione dell'energia dei protoni
% Considero come Yield quello in riferimento all'irraggiamento 1h x 1uA
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
data_stop(:,2) = data(:,2).*1.028;  %MeV*cm^2/g -> kev/uM

%% correzione (coefficienti parabola)
sec = 0.045568400248401;
pri = 1.029654320223587;
zer = -11.329318874222171;

pol = [sec,pri,zer];

%% Calcolo 
en = linspace(a,b,(b-a)/100);
th = zeros(1,length(en));

for ( i=1:1:length(en) )
    th(i) = thickCalc(en(i), En_thr, data_stop); %calcolo spessori
    th_ex(i) = th(i) + polyval(pol,en(i)./1000);  %correzione
    yi(i) = searchValue( en(i), data_yield ); %cerco yield ass. ad energie considerate
end
res = yi./th;   %yield norm
res_2 = yi./th_ex;  %yield normalizzato con spessore corretto

%% Plot
figure(1)
plot(en./1000,res,en./1000,res_2,"LineWidth",1.5);
title("Yield normalizzato sullo spessore")
ylabel('Yield normalizzato per lo spessore [MBq/uAh*um]')
xlabel('Energie protoni [MeV]')
legend("Non corretto","Corretto")
xlim([7.9 30]);

%% massimi e spessori
[m1,x1] = max(res);
res_2(1,1) = 0; %primo valore non valido per divisione, dava problemi
[m2,x2] = max(res_2); %Ricerca max - valore corretto
fprintf("Energia ottima: %4.2f MeV\n",en(x1)./1000)
fprintf("Spessore: %4.0f micron\n",th(x1))
fprintf("\nCORREZIONE:\nEnergia ottima: %4.2f MeV\n",en(x2)./1000)
fprintf("Spessore: %4.0f micron\n",th_ex(x2))
