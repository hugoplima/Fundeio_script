%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%			             ANEXO B                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Laboratorio de Hidrodinamica Costeira, Estuarina e Aguas Interiores %
%        da Universidade Federal do Maranhao (LHiCEAI/UFMA).          %
%                        www.lhiceai.com                              %                        
%                     facebook.com/lhiceai                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   hidro_NOVA2.m   %
%   Programa que converte a tabela.txt do estuario em uma matriz %
%      sem profundidade adimensional                             %     

%   NECESSARIOS                                                       %
%   Carregar a tabela usada no hidro.m do programa estuario.m         %
%   Colocar o numero de horas coletadas (nest)                        %                             

%   RESULTADO                                      %
%   Arquivo dados_hidro.mat                        %
%   SS: salinidade                                 %
%   TT: temperatura                                %
%   OO: oxigenio                                   %
%   MM: mps                                        %

         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		 % reducao dos dados hidrograficos %
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Limpando o que esta no console do matlab para iniciar o programa
clear all
close all
clc
%%% CARREGANDO A TABELA COM OS DADOS HIDROGRAFICOS	

    load dados_matriz.mat           % esse arquivo e uma tabela que vc tem que construir na mao (Prof, temp, sal, dens),
%     hidro_dados =  dados_matriz;    % para cada hora

%     nest=13;                    %Horas do Fundeio (Ex: 13 ou 26 horas)
    
	 % separa as colunas de variaveis
	 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    prof=PP1;  % usou o sinal menos para transformar a prof em positiva
    temp=TT1;   % carrega temp
    salt=SS1;   % carrega salt
    oxi=OO1;    % carrega oxi
    spm=DD1;    % carrega mps
	
	 % encontra a posicao onde prof.=0
	 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    x=find(prof==0);  % cria um vetor com as posicoes de inicio (prof = zero)
	
    tam=length(x); % aqui mostra quantos perfis foram realizados
   
   for i=1:tam        
     if i~=tam       
	 I=num2str(i);
	
     % separa as medidas de P,T,S,ST para cada perfil %
	 % separa todas as estacoes de p, t, s, st        %   
	 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         
	 pi=['p',I];
	 profundidade=[pi,'=prof(x(',I,'):x(',I,'+1)-1);'];
	 eval(profundidade);
      
	 ti=['t',I];
	 temperatura=[ti,'=temp(x(',I,'):x(',I,'+1)-1);'];
	 eval(temperatura);  
        	
	 si=['s',I];
	 salinidade=[si,'=salt(x(',I,'):x(',I,'+1)-1);'];
	 eval(salinidade);
	
	 oxig=['ox',I];
	 oxigenio=[oxig,'=oxi(x(',I,'):x(',I,'+1)-1);'];% curva em vermelho e o dado real
	 eval(oxigenio);
    
     mps=['mpp',I];
	 materialps=[mps,'=spm(x(',I,'):x(',I,'+1)-1);'];% curva em vermelho e o dado real
	 eval(materialps);
    
    end
     
   end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
%  numero linhas e smooth         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   C1(1:1,1:nest)=nan;         % matriz nan
   
for n=1:nest,
    
    eval(['[T' num2str(n)  '] = smooth(t' num2str(n) ',31);']);     % smooth temp
    eval(['[S' num2str(n)  '] = smooth(s' num2str(n) ',31);']);     % smooth salt
    eval(['[OX' num2str(n)  '] = smooth(ox' num2str(n) ',31);']);   % smooth oxi
    eval(['[MPS' num2str(n)  '] = smooth(mpp' num2str(n) ',31);']);   % smooth mps
    
    eval(['[c' num2str(n)  '] = length(t' num2str(n) ');']);
    
      C2 = eval(['c' num2str(n)]);
      C1(1:length(C2),n)=C2(:,1);
     
end   

   mp1 = max(max(C1));
   mp = mp1 + 1;
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  criacao das matrizes        %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  TT(1:mp,1:nest)=nan;
  SS(1:mp,1:nest)=nan;         % matriz nan
  OO(1:mp,1:nest)=nan;
  MM(1:mp,1:nest)=nan;
  
  
  for n=1:nest,
    
     tt = eval(['T' num2str(n)]);
     
       d1 = eval(['c' num2str(n)]);      % matriz da temperatura
       d2 =(mp1-d1)+2;                   %limites da matriz           
       d3 = (length(tt)+d2)-1;
     
     TT(d2:d3,n)=tt(:,1);
       
     
     ss = eval(['S' num2str(n)]);
     SS(d2:d3,n)=ss(:,1);                % matriz da salinidade
     

     oo = eval(['OX' num2str(n)]);
     OO(d2:d3,n)=oo(:,1);                % matriz da oxigenio
     
     
     mm = eval(['MPS' num2str(n)]);
     MM(d2:d3,n)=mm(:,1);                % matriz da mps
     
     clear d1 d2 d3
  end
   
    save dados_hidro.mat SS TT OO MM
%     save salt.txt SS -ascii
%     save temp.txt TT -ascii
%     save oxi.txt OO -ascii
%     save mps.txt MM -ascii
