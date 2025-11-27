% *************************************************************************
% Legge file excel e riordina i dati contenuti (FLUKA scrive i dati in tale
% ordine:
% 1 2
% 3 4
% Quindi sorter() crea una colonna per ogni energia, passando da 16 a 8 quindi
% *************************************************************************

function [out] = sorter(excel)

mat = readmatrix(excel);
[x,y] = size(mat);
n = y/2;
mat_2 = [];

%% PARTE USATA PER ELAB DATI
for i = 1:n   
    for j = 1:x
        temp = [mat(j,i*2-1);mat(j,i*2)];
        mat_2([j*2-1,j*2],i) = temp;
    end
end
out = mat_2;
end