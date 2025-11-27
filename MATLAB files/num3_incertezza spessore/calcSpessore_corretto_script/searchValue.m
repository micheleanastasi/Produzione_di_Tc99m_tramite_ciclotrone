% *************************************************************************
% Ricerca valori in array dati
% Usato per associare a una data energia un dato valore di dE/dx, quindi
% vado a cercare in data.txt dove sono presenti le due colonne
% *************************************************************************

function s_p = searchValue(energy,data)

size = length( data(:,2) ); %dimensioni colonna

% Data la colonna di dE/dx e dato un valore di energia in input (energy)
% cerco lungo tutto la colonna (il for svolge ciò)
% L'if identifica le righe tra cui sta il valore "energy": esempio, se ho
% 1020 allora successivamente eseguirà l'interpolazione lineare tra 1000 e
% 1050, interpolando quindi il dE/dx associato a 1020
for i=1:1:size-1
    if( energy >= data(i,1) && energy <= data(i+1,1) )  %cerco valore intermedio
       s_p = interp1(data(:,1),data(:,2),energy); %interpolazione lineare
        break
    end
end
    
end