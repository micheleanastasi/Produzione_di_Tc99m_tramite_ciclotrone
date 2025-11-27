% *************************************************************************
% ANALISI PROBLEMA DIVERGENZA DATI delle energie in uscita rispetto ai dati
% da pstar
% *************************************************************************

clear all; clc
format long

fluenza = []; %inizializzo array
int_energie = [10 12.5 15 17.5 20 22.5 25 27.5]; %MeV - energie usate in FLUKA
n = size(int_energie,2);

%% load dati intervallo
xx = load("intervallo.txt"); %array con "canali" energie considerate in FLUKA
inter = zeros(1,length(xx)-1); % inizializzo array
for i = 1:(length(xx)-1)
    inter(i) = (xx(i) + xx(i+1))/2; % ne considero il valor medio tra due punti (passo da 1001 a 1000 elementi così)
end

%% load dati fluenza
yy = sorter("./dati_fluenza/fluenze_uscita.xlsx");

%% max curve
% trovo il massimo delle curve di fluenza derivanti da FLUKA
max_flu = [];
index_max = [];
energie_max = [];

for i=1:8
    [max_flu(i,1),index_max(i,1)] = max( yy(:,i) );
    energie_max(i,1) = inter( index_max(i) );
end

%% plot curve con massimi
figure(1)
plot(inter,yy(:,:),energie_max,max_flu,'o')
title("Curve fluenza a varie energie di input, ottenute da USRBDX")
ylabel("Fluenza particelle [num/prim/energie]")
xlabel("Energie dei protoni del fascio in uscita [MeV]")
legend("10 MeV","12.5 MeV","15 MeV","17.5 MeV","20 MeV","22.5 MeV","25 MeV","27.5 MeV")

%% plot massimi delle curve precedenti con interpolazione che le unisce
poli = polyfit( int_energie,energie_max,2 );    %parabola piu' sensata poiché tende sempre a crescere
int = linspace( int_energie(1), int_energie(end),100 ); %ascisse grafici successivi

figure(2)
plot(int_energie,energie_max*1000,'o',int, polyval(poli,int)*1000)
title("Massimi delle fluenze in uscita in funzione dell'energia in entrata")
ylabel("Energia di picco dei protoni uscenti [MeV]")
xlabel("Energie dei protoni del fascio in entrata [MeV]")
% -> aumento in modo parabolico della divergenza
