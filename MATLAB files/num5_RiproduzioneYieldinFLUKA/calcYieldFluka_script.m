% *************************************************************************
% Considero volumi con diametro fisso di 1.5 cm ma var in spessore
% *************************************************************************

clear all; close all; clc;
format long;

%% dati geometria
raggio = 0.75;  %cm
area = raggio*raggio*pi;

%% calc
load 'dati_YTB _ready.txt'; %dati yield in nuclei/cmc/prim
data(:,1) = dati_YTB__ready(:,1);
%data(:,2) = dati_YTB__ready(:,2).*dati_YTB__ready(:,6).*lambda; %yield*volume*lambda = Bq/prim
data(:,2) = 10e-6*dati_YTB__ready(:,4).*dati_YTB__ready(:,6);
thickness = 10000*dati_YTB__ready(:,6)/area;
y = data(:,2)./thickness; %Bq/pri normalizzato su spessore


%% plot dati
x = data(:,1);
xx = linspace(x(1),x(end),100);
yy = spline(x,y,xx);
plot(xx,yy,x,y,'o','Color','blue')
xlabel("Energie protoni del fascio [MeV]")
ylabel("Yield normalizzato [MBq/uA*um]")
title('Yield "normalizzato" basato su dati FLUKA')






