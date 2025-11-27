clear all, close all, clc, format long;


load mod99tct.txt; %dati valori yields in base all'energia dei protoni
deu(:,1) = mod99tct(:,1)*1000; %MeV -> KeV
deu(:,2) = mod99tct(:,6); %MBq/uA:, prendo yield riferito a 1h*1uA

load mop99tct.txt; %dati valori yields in base all'energia dei protoni
pro(:,1) = mop99tct(:,1)*1000; %MeV -> KeV
pro(:,2) = mop99tct(:,6); %MBq/uA:, prendo yield riferito a 1h*1uA

a = 12000;
b = 40000;

xx = linspace(a,b,1000);

%%
plot( pro(:,1)/1000,pro(:,2),deu(:,1)/1000,deu(:,2) )
xlabel("Energia particelle in MeV")
ylabel("Yield in MBq/uA")
legend("Protoni","Deutoni")