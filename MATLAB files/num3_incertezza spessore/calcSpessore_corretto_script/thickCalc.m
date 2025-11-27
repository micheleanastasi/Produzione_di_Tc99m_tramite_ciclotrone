% *************************************************************************
% Calcolo spessore target
% Simulo la perdita di energia del protone nel target fino a quando esso
% non scenderà energeticamente sotto la soglia di E_threshold
% CALCOLO DISCRETO: sottraggo alla particella, ad ogni micron di percorso,
% il dE/dx associato alla sua energia al momento;
% infatti ottengo lo spessore finale aggiungendo al tale un micron per ogni
% volta che esegue un percorso di, appunto, un micron. Quindi alla fine
% otteniamo così lo spessore, con particella uscente ad energie inferiori a
% quelle di soglia della reazione
% *************************************************************************

function val= thickCalc(En_pro, En_thr,data)
thickness = 0; %micron - inizializzo variabile

while( En_pro > En_thr ) % eseguo fino a quando non scendo sotto soglia
    s_p = searchValue(En_pro,data); %cerco valore dE/dx corrispondente all'ATTUALE energia del protone
    En_pro = En_pro - s_p;  %ottengo nuova energia del protone dopo 1 micron di percorso
    thickness = thickness + 1;  %micron
end
val = thickness; %output funzione

end