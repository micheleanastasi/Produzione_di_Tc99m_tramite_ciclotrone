% *************************************************************************
% spessore in um, E_th in KeV
% Interpolo dati FLUKA, e dai tali estraggo spessore tale per cui si ha
% energia dei protoni uscenti uguale a quella di soglia
% *************************************************************************
% Esempio: bombardando con protoni da 15 MeV su spessore di 322 micron esco
% però ad una energia superiore a 7.79 MeV circa, che sarebbe quella di
% soglia della nostra reazione, quindi su FLUKA ho impostato
% simulazioni a 312, 322, 332, 342 e cosi' via (per un totale di 8 per ogni
% energia); dunque interpolo le energie di picco dei protoni uscenti per
% ognuno di questi 8 spessori e infine dalla interpolazione estraggo il
% valore di spessore tale per cui i protoni escono a 7.79MeV.
% *************************************************************************
% Valori di input: spessore da correggere, energia soglia, excel contenente
% i dati derivanti dagli USRBDX di FLUKA, contenente le fluenze per una
% data energia di input MA a variare dello spessore; nota bene che i tali
% vengono riordinati (FLUKA mette i dati in modo strano) dalla funzione
% sorter() in modo uguale a come fatto in altri script
% *************************************************************************
% Valori output: nuovo spessore, percentuale differenza, polinomio
% interpolante i dati delle 8 simulazioni
% *************************************************************************

function [val,delta_perc,poli] = deltaCorrezione( spessore, E_th, excel )

%% dati spessore
spessori = []; %inizializzo array
for i = -1:1:6
    spessori(i+2,:) = spessore + 10*i; %array degli spessori simulati su FLUKA
end

%% load dati intervallo e fluenza
xx = load("intervallo.txt"); %intervallo energie USRBDX
for i = 1:(length(xx)-1)
    %ne considero valori medi, così passo da 1001 a 1000 elementi, meglio così per fare grafico
    inter(i) = (xx(i) + xx(i+1))/2; 
end

yy = sorter(excel); %riodino dati estraendoli dall'excel e li carico in matrice yy

%% estraggo massimi curve
max_flu = [];
index_max = [];
energie_max = [];

for i=1:8
    [max_flu(i,1),index_max(i,1)] = max( yy(:,i) ); %valore massima fluenza
    energie_max(i,1) = inter( index_max(i) ); % posizione (energia) del massimo di prima
end

%% plot e interp - lascia commentato pls
% figure(1)
% plot(inter,yy(:,:),energie_max,max_flu,'o')
% figure(2)
% plot(energie_max,spessori(:,1),'o')
% hold on

%% creazione polinomi interpolazione
poli = polyfit( energie_max,spessori(:,1),3 );
int = linspace( energie_max(1),energie_max(end),100 );
% plot(int, polyval(poli,int))

%% estraggo valore spessore da polinomio tale che uscita a Energia soglia
val = polyval( poli,E_th );
%calcolo delta percentuale errore rispetto allo spessore precedente
delta_perc = (val-spessore)/val*100;

end