% *************************************************************************
% Correzione spessori in uscita in modo da avere protoni in uscita con
% energia coincidente a quella di soglia della reazione
% *************************************************************************

clear all, clc, format long

%% load dati
E_th = 7.7967e-3; %KeV - energia soglia
spes_iso = [84 322 627 993 1419]; %micron - Spessori ottenuti da calcoli precedenti...
en_iso = 10:5:30;%MeV - intervallo energie simulazioni FLUKA
val = []; % array che conterrà valori nuovi spessori
delta_perc = []; %differenza percentuale tra spessori prima e dopo correzione

%calcolo correzione (vedi commenti in deltaCorrezione)
[val(1),delta_perc(1)] = deltaCorrezione( spes_iso(1), E_th, "./dati_correzione/energia_10.xlsx" );
[val(2),delta_perc(2)] = deltaCorrezione( spes_iso(2), E_th, "./dati_correzione/energia_15.xlsx" );
[val(3),delta_perc(3)] = deltaCorrezione( spes_iso(3), E_th, "./dati_correzione/energia_20.xlsx" );
[val(4),delta_perc(4)] = deltaCorrezione( spes_iso(4), E_th, "./dati_correzione/energia_25.xlsx" );
[val(5),delta_perc(5)] = deltaCorrezione( spes_iso(5), E_th, "./dati_correzione/energia_30.xlsx" );

differenza = val-spes_iso; %delta micron da aggiungere

%% interpolazione differenze e plot
pol_1 = polyfit(spes_iso,differenza,2); %parabolico - interp. differenze spessore rispetto spessori originali

figure(1)
xx = linspace( spes_iso(1),spes_iso(end),100 );
plot( spes_iso,differenza,'o',xx,polyval(pol_1,xx) )
hold on
title("Differenza spessore rispetto a dati estrapolati da PSTAR")
xlabel("Spessore PSTAR [micron]")
ylabel("Differenza di spessore [micron]")

%% plot 2 - spessore da aggiungere vs energie in input
xx_2 = linspace(en_iso(1),en_iso(end),100);
pol_2 = polyfit( en_iso,differenza,2); % interp. rispetto energie simulazione

fprintf("Parabola interpolante i delta spessori:\n");
fprintf("%.4fx^2 + %.4fx + %.4f\n\n",pol_2(1),pol_2(2),pol_2(3))

figure(2)
plot( 10:5:30, differenza, 'o', xx_2, polyval(pol_2,xx_2) )
hold on
title("Differenza spessore in funzione delle energie in input")
xlabel("Energie del fascio in ingresso [MeV]")
ylabel("Differenza di spessore [micron]")

%% plot 3 - spessore finale, iniziale vs energie in input
pol_3 = polyfit( en_iso,val,2 );
pol_4 = polyfit( en_iso,spes_iso,2 );

figure(3)
plot( xx_2, polyval(pol_3,xx_2), xx_2, polyval(pol_4,xx_2))
%legend('FLUKA','PSTAR')
hold on
plot( 10:5:30, val, '*', 10:5:30, spes_iso, '*' )
title("Spessore FLUKA e PSTAR in funzione delle energie dei protoni in input")
xlabel("Energie del fascio in ingresso [MeV]")
ylabel("Spessori [micron]")

%% plot 4 - percentuali e loro valor medio
mean_perc = mean(delta_perc);
fprintf("Valor medio differenza percentuale: %.2f %%\n",mean_perc)
figure(4)
plot(10:5:30,delta_perc,'*',"LineWidth",2)
hold on, grid on
title("Percentuale di incertezza rispetto l'energia dei protoni in input")
xlabel("Energie del fascio in ingresso [MeV]")
ylabel("%")
xlim( [8 32] )
ylim( [0 5] )
