clear all, clc, format long;

%% energia input
Ep_in = 19.2;
Ep_out = 7.8;
curr = 50; %% uA

%% caratteristiche materiali
c_cu = 385;
rho_cu = 8960;
k_cu = 398;

c_mo = 250;
rho_mo = 10220;
k_mo = 142;

thick_cu = 0.0015;
radius_cu = 0.020; % 2cm

thick_mo = 0.000574;
radius_mo = 0.0075; %%

%% termodinamica
h_he = 50; %W/mq/K
h_h2O = 1065;

%% calc
Q_cu = Ep_out*curr;
Q_mo = (Ep_in - Ep_out)*curr;

area_cu = pi*radius_cu*radius_cu;
area_mo = pi*radius_mo*radius_mo;

vol_cu = area_cu*thick_cu;
vol_mo = area_mo*thick_mo;

mass_cu = rho_cu*vol_cu;
mass_mo = rho_mo*vol_mo;

%% cond iniziali
T0_cu = 293.15;
T0_mo = 293.15;

T_wat = 293.15;
T_he = 293.15;

%% sistema

a = Q_mo/(mass_mo*c_mo);
b = (h_he*area_mo)/(mass_mo*c_mo);
c = (k_cu*area_mo)/(mass_mo*c_mo*thick_cu);

d = Q_cu/(mass_cu*c_cu);
e = (k_cu*area_mo)/(mass_cu*c_cu*thick_cu);
f = (h_h2O*area_cu)/(mass_cu*c_cu);

% f = @(x,y) [ a - b.*(x-T_he) - c.*(x-y) ;
%            d + e.*(x-y) - f.*(y-T_wat)  ];

f = @(t,y) [ a - b.*(y(1)-T_he) - c.*(y(1)-y(2)) ;
             d + e.*(y(1)-y(2)) - f.*(y(2)-T_wat)  ];

x0 = [T0_mo;T0_cu]
tspan = [0:0.1:100];
[t,x] = ode45(f,tspan,x0);

%% plot
plot(t,x)
xlabel('Tempo [s]')
ylabel('Temperature [K]')
legend('Molibdeno','Rame')

