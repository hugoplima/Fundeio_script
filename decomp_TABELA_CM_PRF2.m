         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		 % reducao dos dados hidrograficos %
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         
%  decomp_tabela.m   %
%  Programa gera a  tabela.txt do estuario.m ou para a decomp_NOVA2.m %
     

%   NECESSARIOS                                                       %
%   Carregar os arquivos do adcp_matriz_fun_13h.m                     %
%   Colocar o numero de horas coletadas (nest)                        %
%   Colocar numero de linhas das matriz (mx)                          %
%   Arrumar a GAMBIARRA em caso do nest>26h                           %

%   RESULTADO                                                         %
%   Arquivo corrente_matriz.m                                         %
%   PCU1: profundidade                                                %
%   VE1: component transversal                                        %
%   VN1: componente longitudinal                                      %
%   HOR: hora de coleta                                               %

%% Limpando o que esta no console do matlab para iniciar o programa  %%
clear all
close all
clc
%%% CARREGANDO A TABELA COM OS DADOS HIDROGRAFICOS	

nest=13;    % Horas do Fundeio (Ex: 13 ou 26 horas)
mx=232;     % numero de linhas das matriz 

% angulo = -70;          % Angulo de inclinacao ao norte
% decl = -21;            % Declinacao magnetica (Ex: -21 ou 45)

VE(1:mx,1) = nan;
VN(1:mx,1) = nan;         % matriz nan
HO(1:mx,1) = nan;
PCU(1:mx,1) = nan;
p = 0;        % matriz zero (nao pode mudar)
for n=1:nest,
    
      eval(['load(''ve_prof_hora' num2str(n) '.dat'');']); % mudar o caminho em cada comp
      eval(['load(''vn_prof_hora' num2str(n) '.dat'');']);
 
      eval(['ve' num2str(n)  ' = (ve_prof_hora' num2str(n) '(:,1));']);
      eval(['vn' num2str(n)  ' = (vn_prof_hora' num2str(n) '(:,1));']);
      
      eval(['[x' num2str(n)  '] = (length(ve_prof_hora' num2str(n) '));']);  % cria um vetor com as posicoes de inicio (prof = zero)
           
      eval(['[p' num2str(n)  '] = [transpose(0:(x' num2str(n) '))];']);
      
      eval(['h' num2str(n) '(1:x' num2str(n) '+1,1:1)=' num2str(n) ';']);

   %% criando as matrizes U, V, H e prof %%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
   
    if n==1  
      U1 = eval(['x' num2str(n)]);
      vee = eval(['ve' num2str(n)]);
      vnn = eval(['vn' num2str(n)]);
      hr = eval(['h' num2str(n)]);
      pr = eval(['p' num2str(n)]);
      
      V1 = U1+1;
      
      VE(1:U1,1)=vee(:,1);
      VE(V1,1)=p;
      VN(1:U1,1)=vnn(:,1);
      VN(V1,1)=p;
      HO(1:(U1+1),1)=hr(:,1); 
      PCU(1:(U1+1),1)=pr(:,1);
 
    elseif n==2
      U1 = eval(['x' num2str(n)]);
      vee = eval(['ve' num2str(n)]);
      vnn = eval(['vn' num2str(n)]);
      hr = eval(['h' num2str(n)]);
      pr = eval(['p' num2str(n)]);
      
      d4 = V1+1;
      d5 = U1+d4-1;
      d6 = d5+1;
      
      VE(d4:d5,1)=vee(:,1);
      VE(d6,1)=p; 
      VN(d4:d5,1)=vnn(:,1);
      VN(d6,1)=p; 
      HO(d4:(d5+1),1)=hr(:,1); 
      PCU(d4:(d5+1),1)=pr(:,1);
   
    else
      U2 = eval(['x' num2str(n)]);
      vee = eval(['ve' num2str(n)]);
      vnn = eval(['vn' num2str(n)]);
      hr = eval(['h' num2str(n)]);
      pr = eval(['p' num2str(n)]);
      
      V2 = d6+1;
      d4 = V2;
      d5 = U2+d4-1;
      d6 = d5+1;
      
      VE(d4:d5,1)=vee(:,1);
      VE(d6,1)=p;     
      VN(d4:d5,1)=vnn(:,1);
      VN(d6,1)=p;
      HO(d4:(d5+1),1)=hr(:,1); 
      PCU(d4:(d5+1),1)=pr(:,1);
      
U0=U1;V0=V1;U1=U2;V1=V2;  
   
   end
end

   VE((d6+1),1)=p;
   VN((d6+1),1)=p;
   HO((d6+1),1)=p;
   PCU((d6+1),1)=p;
   
   
   PCU1 = PCU; VE1 = VE; VN1 = VN; HOR = HO;    %%% renomeando as variaveis
   
  
   save corrente_matriz.mat PCU1 VE1 VN1 HOR nest  %%% salvando matriz para o programa Estuario e isopleta
   
  
   run decomp_NOVA2.m  %%% RODANDO PROGRAMA PARA GERAR MATRIZ PARA ISOPLETA SEM PROFUNDIDADE ADIMENSIONAL
  
%    contourf(flipud(VN))
   
  