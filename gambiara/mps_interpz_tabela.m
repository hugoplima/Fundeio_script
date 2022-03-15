%%%%%%%   INTERPOLANDO OS DADOS DE MPS NA COLUNA DE AGUA     %%%%%%%%%
%%%%%%%    PROGRAMA DESENVOLVIDO POR VINICIUS E JULIO        %%%%%%%%%
%%%%%%%              DISSERTACAO VINICIUS                    %%%%%%%%%
%%%%%%%              editado por Hugo                        %%%%%%%%%

% Laboratorio de Hidrodinamica Costeira, Estuarina e Aguas Interiores%
%        da Universidade Federal do Maranhao (LHiCEAI/UFMA).         %
%                        www.lhiceai.com                             %                        
%                     facebook.com/lhiceai                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   hidro_NOVA2.m                                                    %
%   Programa que interpola os dados de mps na coluna dagua           %
%      para gerar um arquivo txt                                     %     

%   NECESSARIOS                                                      %
%   Carregar os dados de mps da superficie, fundo e de profundidade  %
%   Colocar o numero de horas coletadas (nest)                       %
%   Arrumar a GAMBIARRA em funcao das horas usadas caso nest>26 h    %

%   RESULTADO                                      %
%   Arquivo dados_hidro.mat                        %
%   SS: salinidade                                 %
%   TT: temperatura                                %
%   OO: oxigenio                                   %
%   MM: mps                                        %

%% 1 CAMPANHA CEASJ - FUNDEIO 1
% as=10
% ab=100
% h1=10 
% a=(ab-as)/h1;
% b=as; 
% x=[0:1:h1];
% fz=a*x+b;
clear; clc

nest=13;

load mps_f2.txt  % carrega os dados de mps(sup e fun);
mps_sf=mps_f2;

mps_sup=mps_sf(:,2)'; % superficie
mps_fun=mps_sf(:,3)'; % fundo
h=mps_sf(:,4)';       % profundidade

for i=1:length(mps_sf)
    if mps_sup(i)<mps_fun(i)
      a(i)=(mps_sup(i)-mps_fun(i))/(1-h(i));
      b(i)=mps_sup(i)-a(i);
    else
      a(i)=(mps_sup(i)-mps_fun(i))/(1-h(i));
      b(i)=mps_fun(i)-a(i);
    end
end


for t=1:length(mps_sf)   
    for i=1:max(h);
       
    fz(i,t)=a(t)*(i)+b(t);
    
    end
end

for t=1:length(mps_sf)
    for i=1:max(h);
        
        if (fz(i,t)>(mps_fun(t)+0.01)); fz(i,t)=NaN; end
    end
end
 
  contourf(flipud(fz))
  save mps_temporal.txt fz -ascii

nest1=nest+1;
      
   for i=1:nest1        
     if i~=nest1       
	 I=num2str(i);
	
     % separa as medidas de MPS para cada perfil %
	 % separa todas as estacoes de mps           %   
	 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         
     eval(['[mps' num2str(i)  '] = [fz(1:h(:,' num2str(i) '),i)];']);
	
     end
   end

%% criando as matrizes MPS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

p0=0;                 %%% matriz zero  

%%% GANBIARRA
if nest==13
    save mps.txt mps1 mps2 mps3 mps4 mps5 mps6 mps7 mps8 ... 
        mps9 mps10 mps11 mps12 mps13 p0 -ascii     %%% se fundeios com duracao maiores colocar(Ex: p0 p1 p0 p2 ... p26 p0)
elseif nest==26
    save mps.txt mps1 mps2 mps3 mps4 mps5 mps6 mps7 mps8 mps9 mps10 mps11 mps12 mps13 mps14 mps15 mps16 mps17... 
        mps18 mps19 mps20 mps21 mps22 mps23 mps24 mps25 mps26 p0 -ascii     %%% se fundeios com duracao maiores colocar(Ex: p0 p1 p0 p2 ... p26 p0) 
else
    disp('Arrumar Gambiarra linha 91')
end    

clear all

   load mps.txt       %%% Carregado a ganbiarra
   MPS = mps(:,1);    %%% renomeando as variaveis
   delete mps.txt;    %%% deletando dados da ganbiarra
   
   save dados_matriz_MPS.mat MPS       %%% salvando matriz para o programa Estuario e isopleta
%     asdasd

