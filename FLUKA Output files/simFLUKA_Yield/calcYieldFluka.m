clear all; close all; clc;
format long;

% geometria
spessore = 0.0083; %cm
raggio = 0.75;
vol = pi*raggio*raggio*spessore;

% fascio
carica = 1.6e-19;
current = 1e-6; %
time = 1*3600; %

%pri = (current/carica)*time;
area = raggio*raggio*pi;

%isotopo
t = 6 * 3600;
lambda = log(2)/t;

%% calc
load 'dati_YTB _ready.txt';
data(:,1) = dati_YTB__ready(:,1);
data(:,2) = dati_YTB__ready(:,2).*dati_YTB__ready(:,6).*lambda; %energia, yield Bq/pri
data(:,2) = data(:,2)./(dati_YTB__ready(:,6)/area); %Bq/pri norm su spessore

x = data(:,1);
y = data(:,2);
xx = linspace(x(1),x(end),100);
yy = spline(x,y,xx);
plot(xx,yy,x,y,'o')






