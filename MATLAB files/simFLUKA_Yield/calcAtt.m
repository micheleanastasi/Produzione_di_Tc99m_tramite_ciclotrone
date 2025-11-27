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

pri = (current/carica)*time;

%isotopo
res = 3.9e-3;
t = 6 * 3600;
lambda = log(2)/t;

%calc
nuclei = res*pri*vol
att = nuclei*lambda