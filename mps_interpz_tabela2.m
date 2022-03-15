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
%   Arrumar o numero de linhas das matriz (mx)                       %

%   RESULTADO                                      %
%   Arquivo dados_matriz_MPS.mat                   %
%   MPS: mps                                       %

%% 1 CAMPANHA CEASJ - FUNDEIO 1
% as=10
% ab=100
% h1=10 
% a=(ab-as)/h1;
% b=as; 
% x=[0:1:h1];
% fz=a*x+b;
clear; clc

% nest = 13;
mx = 212;        % numero de linhas das matriz 

load mps_f1.txt  % carrega os dados de mps(sup e fun);
mps_sf=mps_f1;

mps_sup=mps_sf(:,2)';  % superficie
mps_fun=mps_sf(:,3)';  % fundo
h=mps_sf(:,4)'+1;      % profundidade (+1 para fit com os outros dados)

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
 
%   contourf(flipud(fz))
%   save mps_temporal.txt fz -ascii
% asdasd
nest1=length(mps_sf)+1;
      
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

pp=0;                 %%% matriz zero  
MM(1:mx,1) = nan;

for i=1:length(mps_sf),
 
    if i==1  
      U1 = eval(['h(:,' num2str(i) ');']);
      tt = eval(['mps' num2str(i)]);
     
      V1 = U1+1;
      
      MM(1:U1,1)=tt(:,1);
      
    elseif i==2
      U1 = eval(['h(:,' num2str(i) ');']);
      tt = eval(['mps' num2str(i)]);
 
      d4 = V1;
      d5 = U1+d4-1;
      d6 = d5+1;

      MM(d4:d5,1)=tt(:,1);
      
    else
      U2 = eval(['h(:,' num2str(i) ');']);
      tt = eval(['mps' num2str(i)]);
      
      V2 = d6;
      d4 = V2;
      d5 = U2+d4-1;
      d6 = d5+1;
      
      MM(d4:d5,1)=tt(:,1);
      
    U0=U1;V0=V1;U1=U2;V1=V2;  
   
   end
end   

MM((d6),1)=pp;
% 
% dadasdad

   MPS = MM;    %%% renomeando as variaveis
   
   save dados_matriz_MPS.mat MPS       %%% salvando matriz para o programa Estuario e isopleta
%     asdasd

