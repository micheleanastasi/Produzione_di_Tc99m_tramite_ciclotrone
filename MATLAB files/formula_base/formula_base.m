
clear all, clc
format long
Q = -8;

conv = 931.4936148; % uma -> Mev

m_n = 1.008664916;
m_p = 1.007276466621;
B_tc = 8.61361;  %MeV per nucleone, nb Tc -> A=99
B_mo = 8.604663; %idem, nb Mo -> A=100

m_y = (43*m_p + (99-43)*m_n) - B_tc*99/conv;
my = m_y*conv;
ma = m_p*conv;
mb = 2*m_n*conv;


% num_1 = @(x,t) sqrt(m_a*m_b.*x)*cos(t);
% num_2 = @(x,t) m_y*Q + (m_y - m_a).*x;
% num_3 = @(x,t) x.*m_a*m_b.*( cos(t) ).^2 + (m_y + m_b)*num_2(x,t);
% num_fin = @(x,t) num_1(x,t) - sqrt(num_3(x,t));
% den_fin = m_y + m_b;
% formula = @(x,t) num_fin(x,t)/den_fin;
% form_fin = @(x,t) power(formula(x,t),2);

%formula = @(x)  ( sqrt(ma*mb.*x) + sqrt( ma*mb.*x + (my+mb)*(my*Q + (my-ma).*x) ) )/(my+mb) 
formula = @(x,t)  ( sqrt(ma*mb.*x)*cos(t) + sqrt( ma*mb.*x.*(cos(t)).^2 + (my+mb)*(my*Q + (my-ma).*x) ) )/(my+mb) 

xx = linspace(0,30,100); 
plot( xx,formula(xx,0),xx,formula(xx,1) );