
clear all, clc
format long
Q = -0.76375; %MeV
conv = 931.4936148; % uma -> Mev

m_n = 1.008664916;
m_p = 1.007276466621;
B_3He = 2.572680;  %MeV per nucleone
B_3H = 2.827265 ; %idem

m_y = (2*m_p + (1)*m_n) - B_3He*3/conv;
my = m_y*conv;
ma = m_p*conv;
mb = m_n*conv;


% num_1 = @(x,t) sqrt(m_a*m_b.*x)*cos(t);
% num_2 = @(x,t) m_y*Q + (m_y - m_a).*x;
% num_3 = @(x,t) x.*m_a*m_b.*( cos(t) ).^2 + (m_y + m_b)*num_2(x,t);
% num_fin = @(x,t) num_1(x,t) - sqrt(num_3(x,t));
% den_fin = m_y + m_b;
% formula = @(x,t) num_fin(x,t)/den_fin;
% form_fin = @(x,t) power(formula(x,t),2);

%formula = @(x)  ( sqrt(ma*mb.*x) + sqrt( ma*mb.*x + (my+mb)*(my*Q + (my-ma).*x) ) )/(my+mb) 
formula = @(x,t)  ( sqrt(ma*mb.*x)*cos(t) + sqrt( ma*mb.*x.*(cos(t)).^2 + (my+mb)*(my*Q + (my-ma).*x) ) )/(my+mb) 

xx = linspace(0,10,100); 
plot( xx,formula(xx,0),xx,formula(xx,0.1) );