%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%  Programa para vizualizacao dos dados de correntes      %%%%%%%%%
%%%%%%%%%      a partir de sinais Acusticos do ADCP - SONTEK      %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Laboratorio de Hidrodinamica Costeira, Estuarina e Aguas Interiores     %
%        da Universidade Federal do Maranhao (LHiCEAI/UFMA).              %
%                        www.lhiceai.com                                  %                        
%                     facebook.com/lhiceai                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%   DADOS DE COLETA DO COMPLEXO ESTUARINO DE SAO MARCOS  %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                  FUNDEIO DE 13H ININTERRUPTAS                     %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%       Criando uma tabela txt com o nome variado das variaveis     %%%% 
%%%%                       (Faz na 1 vez que rodar)                    %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
clc
% ls -rt FUND*.ve > lista.txt  

nest = 13;              %%%%% NUMERO DE AMOSTRAGEM
l = 30;                 %%%%% PULSOS  PARA CADA HORA
z = [13 11 9 9 9 10 12 13 14 15 14 14 13]; %%%%% PROFUNDIDADE DA COLUNA DA AGUA


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                        LEITURA DOS DADOS                          %%%%
%%%%    o "eval" e usado para usar variaveis-coringa para os nomes.    %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nome = textread('lista.txt','%s');  % % carrega a tabela criada

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%                      HORA - 01                         %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k = 1:nest,     
	nome_que_sera_o_da_vez = cell2mat(nome(k,1));                          % transforma de cell2mat
	nome_que_sera_o_da_vez = nome_que_sera_o_da_vez(1,1:end-3);            % retira a extensao

	nome_que_sera_o_da_vez_ve = [nome_que_sera_o_da_vez '.ve'];            % recoloca a externsao
	nome_que_sera_o_da_vez_vn = [nome_que_sera_o_da_vez '.vn'];
	nome_que_sera_o_da_vez_hdr = [nome_que_sera_o_da_vez '.hdr'];
%  	nome_que_sera_o_da_vez_gps = [nome_que_sera_o_da_vez '.gps'];
% 	nome_que_sera_o_da_vez_btk = [nome_que_sera_o_da_vez '.btk'];

	eval(['ve_' num2str(k) ' = load(nome_que_sera_o_da_vez_ve);']);        % carrega para cada peda??o da radial
	eval(['vn_' num2str(k) ' = load(nome_que_sera_o_da_vez_vn);']);
	eval(['hdr_' num2str(k) ' = load(nome_que_sera_o_da_vez_hdr);']);
%  	eval(['gps_' num2str(k) ' = load(nome_que_sera_o_da_vez_gps);']);
% 	eval(['btk_' num2str(k) ' = load(nome_que_sera_o_da_vez_btk);']);

	eval(['ve_' num2str(k) ' = ve_' num2str(k) '(:,2:end);']);             % retira o numero da coluna
	eval(['vn_' num2str(k) ' = vn_' num2str(k) '(:,2:end);']);
	eval(['ind = find(ve_' num2str(k) '(:)==3276.7);']);                   % retira os dados espurios
	eval(['ve_' num2str(k) '(ind) = NaN;']);
	eval(['vn_' num2str(k) '(ind) = NaN;']);

    eval([ 've_hora_' num2str(k)  '=[ve_' num2str(k) '];']);
    eval([ 'vn_hora_' num2str(k)  '=[vn_' num2str(k) '];']);
    eval([ 'hdr_hora_' num2str(k)  '= [hdr_' num2str(k) '];']);
    eval([ 'save hora_' num2str(k) '.mat ve_hora_' num2str(k) ' vn_hora_' num2str(k) ' hdr_hora_' num2str(k) ';']);
end
% 
% ve_fun1 = [ve_1];    %(1:20,:)];
% vn_fun1 = [vn_1];	 %(1:20,:)];
% %  gps_rad1 = [gps_1];
% %  btk_fun1 = [btk_1];
% hdr_fun1 = [hdr_1];  %(1:20,:)];
% 
% save Fundeio.mat ve_fun1 vn_fun1  hdr_fun1 %gps_fun1 btk_fun1

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%            SEPARANDO OS DADOS EM 13 HORAS              %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   AQUI SEPARAMOS OS DADOS EM PULSOS POR HORA, POR EXEMPO SE A     %%%%
%%%%  AQUISICAO DOS DADOS FOI FEITA EM 120s SERIAM 30 PULSOS POR HORA  %%%%
%%%%         LOGO OS DADOS SERAO SEPARADOS EM 1 -> 29/ 30 -> 59        %%%%
%%%%                          E ASSIM POR DIANTE                       %%%%
%%%%         USANDO 30 PULSOS  PARA CADA HORA LOGO SERAM 390 PULSOS    %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for i=1:nest,
% %     l=30;
%     y=l+1;
%     j=(l.*i);
%     o=j-l+1;
% 
%     if i==1   
% eval([ 've_hora_' num2str(i)  '=[ve_fun1(1:l,:)];']);
% eval([ 'vn_hora_' num2str(i)  '=[vn_fun1(1:l,:)];']);
% eval([ 'hdr_hora_' num2str(i)  '= [hdr_fun1(1:l,:)];']);
% eval([ 'save hora_' num2str(i) '.mat ve_hora_' num2str(i) ' vn_hora_' num2str(i) ' hdr_hora_' num2str(i) ';']);
% 
%     elseif i==13
% eval([ 've_hora_' num2str(i)  '=[ve_fun1(o:end,:)];']);
% eval([ 'vn_hora_' num2str(i)  '=[vn_fun1(o:end,:)];']);
% eval([ 'hdr_hora_' num2str(i)  '= [hdr_fun1(o:end,:)];']);
% eval([ 'save hora_' num2str(i) '.mat ve_hora_' num2str(i) ' vn_hora_' num2str(i) ' hdr_hora_' num2str(i) ';']);
% 
%     else
% eval ([ 've_hora_' num2str(i)  '=[ve_fun1(o:j,:)];' ]);
% eval([ 'vn_hora_' num2str(i)  '=[vn_fun1(o:j,:)];']);
% eval([ 'hdr_hora_' num2str(i)  '= [hdr_fun1(o:j,:)];']);
% eval([ 'save hora_' num2str(i) '.mat ve_hora_' num2str(i) ' vn_hora_' num2str(i) ' hdr_hora_' num2str(i) ';']);
% 
% 
%     end
% end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%              SEPARANDO EM U(Vn) E V (Ve)               %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                                 HORA 01                           %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% z = [15 17 20 18 19 20 20 20 18 16 16 15 14]; %%%%% PROFUNDIDADE DA COLUNA DA AGUA

%%% VE
all1(1:(z(:,1)),1)=nan;
for n=1:(z(:,1)),  
a = ve_hora_1;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((a(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end


%%%--> SALVA O ARQUIVO EM .dat 
save ve_prof_hora1.dat all1 -ascii
%%%--> LIMPA OS ARQUIVOS PARA TRATAR OS PROXIMOS
clear n all1


%%%% VN
all1(1:(z(:,1)),1)=nan;
for n=1:(z(:,1)),  
b = vn_hora_1;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((b(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end

save vn_prof_hora1.dat all1 -ascii
clear prof* n all1

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                                 HORA 02                           %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear all
clc
load hora_2.mat
%%% VE

all1(1:(z(:,2)),1)=nan;
for n=1:(z(:,2)),  
a = ve_hora_2;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((a(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end


%%%--> SALVA O ARQUIVO EM .dat 
save ve_prof_hora2.dat all1 -ascii
%%%--> LIMPA OS ARQUIVOS PARA TRATAR OS PROXIMOS
clear prof* n all1 a


%%%% VN
all1(1:(z(:,2)),1)=nan;
for n=1:(z(:,2)),  
b = vn_hora_2;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((b(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end

save vn_prof_hora2.dat all1 -ascii
clear prof* n all1 b

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                                 HORA 03                           %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear all 
clc
load hora_3.mat
%%% VE
all1(1:(z(:,3)),1)=nan;
for n=1:(z(:,3)),  
a = ve_hora_3;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((a(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end


%%%--> SALVA O ARQUIVO EM .dat 
save ve_prof_hora3.dat all1 -ascii
%%%--> LIMPA OS ARQUIVOS PARA TRATAR OS PROXIMOS
clear prof* n all1 a


%%%% VN
all1(1:(z(:,3)),1)=nan;
for n=1:(z(:,3)),  
b = vn_hora_3;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((b(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end

save vn_prof_hora3.dat all1 -ascii
clear prof* n all1 b

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                                 HORA 04                           %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear all 
clc
load hora_4.mat
%%% VE
all1(1:(z(:,4)),1)=nan;
for n=1:(z(:,4)),  
a = ve_hora_4;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((a(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end


%%%--> SALVA O ARQUIVO EM .dat 
save ve_prof_hora4.dat all1 -ascii
%%%--> LIMPA OS ARQUIVOS PARA TRATAR OS PROXIMOS
clear prof* n all1 a


%%%% VN
all1(1:(z(:,4)),1)=nan;
for n=1:(z(:,4)),  
b = vn_hora_4;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((b(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end

save vn_prof_hora4.dat all1 -ascii
clear prof* n all1 b

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                                 HORA 05                           %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear all 
clc
load hora_5.mat
%%% VE
all1(1:(z(:,5)),1)=nan;
for n=1:(z(:,5)),  
a = ve_hora_5;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((a(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end


%%%--> SALVA O ARQUIVO EM .dat 
save ve_prof_hora5.dat all1 -ascii
%%%--> LIMPA OS ARQUIVOS PARA TRATAR OS PROXIMOS
clear prof* n all1 a


%%%% VN
all1(1:(z(:,5)),1)=nan;
for n=1:(z(:,5)),  
b = vn_hora_5;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((b(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end

save vn_prof_hora5.dat all1 -ascii
clear prof* n all1 b

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                                 HORA 06                           %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear all 
clc
load hora_6.mat
%%% VE
all1(1:(z(:,6)),1)=nan;
for n=1:(z(:,6)),  
a = ve_hora_6;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((a(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end


%%%--> SALVA O ARQUIVO EM .dat 
save ve_prof_hora6.dat all1 -ascii
%%%--> LIMPA OS ARQUIVOS PARA TRATAR OS PROXIMOS
clear prof* n all1 a


%%%% VN
all1(1:(z(:,6)),1)=nan;
for n=1:(z(:,6)),  
b = vn_hora_6;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((b(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end

save vn_prof_hora6.dat all1 -ascii
clear prof* n all1 b

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                                 HORA 07                           %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear all 
clc
load hora_7.mat
%%% VE
all1(1:(z(:,7)),1)=nan;
for n=1:(z(:,7)),  
a = ve_hora_7;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((a(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end


%%%--> SALVA O ARQUIVO EM .dat 
save ve_prof_hora7.dat all1 -ascii
%%%--> LIMPA OS ARQUIVOS PARA TRATAR OS PROXIMOS
clear prof* n all1 a


%%%% VN
all1(1:(z(:,7)),1)=nan;
for n=1:(z(:,7)),  
b = vn_hora_7;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((b(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end

save vn_prof_hora7.dat all1 -ascii
clear prof* n all1 b

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                                 HORA 08                           %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear all 
clc
load hora_8.mat
%%% VE
all1(1:(z(:,8)),1)=nan;
for n=1:(z(:,8)),  
a = ve_hora_8;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((a(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end


%%%--> SALVA O ARQUIVO EM .dat 
save ve_prof_hora8.dat all1 -ascii
%%%--> LIMPA OS ARQUIVOS PARA TRATAR OS PROXIMOS
clear prof* n all1 a


%%%% VN
all1(1:(z(:,8)),1)=nan;
for n=1:(z(:,8)),  
b = vn_hora_8;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((b(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end

save vn_prof_hora8.dat all1 -ascii
clear prof* n all1 b

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                                 HORA 09                           %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear all 
clc
load hora_9.mat
%%% VE
all1(1:(z(:,9)),1)=nan;
for n=1:(z(:,9)),  
a = ve_hora_9;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((a(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end


%%%--> SALVA O ARQUIVO EM .dat 
save ve_prof_hora9.dat all1 -ascii
%%%--> LIMPA OS ARQUIVOS PARA TRATAR OS PROXIMOS
clear prof* n all1 a


%%%% VN
all1(1:(z(:,9)),1)=nan;
for n=1:(z(:,9)),  
b = vn_hora_9;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((b(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end

save vn_prof_hora9.dat all1 -ascii
clear prof* n all1 b

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                                 HORA 10                           %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear all 
clc
load hora_10.mat
%%% VE
all1(1:(z(:,10)),1)=nan;
for n=1:(z(:,10)),  
a = ve_hora_10;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((a(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end


%%%--> SALVA O ARQUIVO EM .dat 
save ve_prof_hora10.dat all1 -ascii
%%%--> LIMPA OS ARQUIVOS PARA TRATAR OS PROXIMOS
clear prof* n all1 a


%%%% VN
all1(1:(z(:,10)),1)=nan;
for n=1:(z(:,10)),  
b = vn_hora_10;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((b(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end

save vn_prof_hora10.dat all1 -ascii
clear prof* n all1 b

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                                 HORA 11                           %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear all 
clc
load hora_11.mat
%%% VE
all1(1:(z(:,11)),1)=nan;
for n=1:(z(:,11)),  
a = ve_hora_11;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((a(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end


%%%--> SALVA O ARQUIVO EM .dat 
save ve_prof_hora11.dat all1 -ascii
%%%--> LIMPA OS ARQUIVOS PARA TRATAR OS PROXIMOS
clear prof* n all1 a


%%%% VN
all1(1:(z(:,11)),1)=nan;
for n=1:(z(:,11)),  
b = vn_hora_11;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((b(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end

save vn_prof_hora11.dat all1 -ascii
clear prof* n all1 b

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                                 HORA 12                           %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear all 
clc
load hora_12.mat
%%% VE
all1(1:(z(:,12)),1)=nan;
for n=1:(z(:,12)),  
a = ve_hora_12;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((a(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end


%%%--> SALVA O ARQUIVO EM .dat 
save ve_prof_hora12.dat all1 -ascii
%%%--> LIMPA OS ARQUIVOS PARA TRATAR OS PROXIMOS
clear prof* n all1 a


%%%% VN
all1(1:(z(:,12)),1)=nan;
for n=1:(z(:,12)),  
b = vn_hora_12;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((b(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end

save vn_prof_hora12.dat all1 -ascii
clear prof* n all1 b

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                                 HORA 13                           %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear all 
clc
load hora_13.mat
%%%% VE
all1(1:(z(:,13)),1)=nan;
for n=1:(z(:,13)),  
a = ve_hora_13;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((a(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end


%%%--> SALVA O ARQUIVO EM .dat 
save ve_prof_hora13.dat all1 -ascii
%%%--> LIMPA OS ARQUIVOS PARA TRATAR OS PROXIMOS
clear prof* n all1 a


%%%% VN
all1(1:(z(:,13)),1)=nan;
for n=1:(z(:,13)),  
b = vn_hora_13;                                                          % TIRA A MEDIA DA PROFUNDIDADE E DIVIDE
eval ([ 'prof=nanmean ((b(:,' num2str(n) ')));' ]);    %     EM JANELAS HORA E PROFUNDIDADE
all1(n,1) = prof(:,1);
clear prof
end

save vn_prof_hora13.dat all1 -ascii
clear prof* n all1 b




