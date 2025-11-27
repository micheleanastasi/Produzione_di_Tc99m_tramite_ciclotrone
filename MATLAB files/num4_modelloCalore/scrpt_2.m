clear all, format long, clc;

temp_mo = [];
temp_cu = [];
%raggio = [0.005 0.0075 0.010];
raggio = 0.0075
curr = [10 20 30 40 50];

for i = 1:length(raggio)
    for j = 1:length(curr)
        
        [temp_mo(i,j),temp_cu(i,j)] = calcTemp(curr(j),raggio(i));   

    end
end

plot(curr, temp_mo, curr, temp_cu)
xlabel("Intensità di corrente [uA]");
ylabel("Temperatura  [K]");
legend('Molibdeno','Rame');

