         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		 % reducao dos dados hidrograficos %
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         
%   decomp_tabela.m   %
%   Programa gera a  tabela.txt do estuario.m ou para a decomp_NOVA2.m %
     

%   NECESSARIOS                                                       %
%   Carregar os arquivos do adcp_matriz_fun_13h.m                     %
%   Colocar o numero de horas coletadas (nest)                        %
%   Arrumar a GAMBIARRA em caso do nest>26h                           %

%   RESULTADO                                                    %
%   Arquivo corrente_matriz.m                                    %
%   PCU1: profundidade                                           %
%   VE1: component transversal                                   %
%   VN1: componente longitudinal                                 %
%   HOR: hora de coleta                                          %

%%%% Limpando o que esta no console do matlab para iniciar o programa
clear all
close all
clc
%%% CARREGANDO A TABELA COM OS DADOS HIDROGRAFICOS	

nest=13;                    %Horas do Fundeio (Ex: 13 ou 26 horas)

for n=1:nest,
    
      eval(['load(''ve_prof_hora' num2str(n) '.dat'');']); % mudar o caminho em cada comp
      eval(['load(''vn_prof_hora' num2str(n) '.dat'');']);
 
      eval(['ve' num2str(n)  ' = (ve_prof_hora' num2str(n) '(:,1));']);
      eval(['vn' num2str(n)  ' = (vn_prof_hora' num2str(n) '(:,1));']);
      
      eval(['[x' num2str(n)  ']=(length(ve_prof_hora' num2str(n) '));']);  % cria um vetor com as posicoes de inicio (prof = zero)
           
      eval(['[p' num2str(n)  '] = [transpose(0:(x' num2str(n) '))];']);
      
      eval(['h' num2str(n) '(1:x' num2str(n) '+1,1:1)=' num2str(n) ';']);
%       eval(['[vef' num2str(n)  '] = [ve' num2str(n) '((max(p' num2str(n) ')-2),:)];']);   %Comando usado para pegar valores do fundo (VE)
%       eval(['[vnf' num2str(n)  '] = [vn' num2str(n) '((max(p' num2str(n) ')-2),:)];']);   %Comando usado para pegar valores do fundo (VN)  
end

	 % separa as colunas de variaveis
	 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   %% criando as matrizes S, T, O, D  %%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
   p0=0; %matriz zero
   
   %%% GANBIARRA 
    
   if nest ==13
    save pcu.txt p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p0 -ascii         %%% se fundeios com duracao maiores colocar(Ex: p0 p1 p0 p2 ... p26 p0)   
    save vve.txt ve1 p0 ve2 p0 ve3 p0 ve4 p0 ve5 p0 ve6 p0 ve7 p0 ve8 p0 ve9 p0 ve10 p0 ve11 p0 ve12 p0 ve13 p0 p0 -ascii    %%% (Ex: ts1 t1 ts2 t2 ... ts26 t26 p0) 
    save vvn.txt vn1 p0 vn2 p0 vn3 p0 vn4 p0 vn5 p0 vn6 p0 vn7 p0 vn8 p0 vn9 p0 vn10 p0 vn11 p0 vn12 p0 vn13 p0 p0 -ascii
    save hora.txt h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12 h13 p0 -ascii
    
   elseif nest ==26
    save pcu.txt p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25 p26 p0 -ascii
    save vve.txt ve1 p0 ve2 p0 ve3 p0 ve4 p0 ve5 p0 ve6 p0 ve7 p0 ve8 p0 ve9 p0 ve10 p0 ve11 p0 ve12 p0 ve13 p0 ...
        ve14 p0 ve15 p0 ve16 p0 ve17 p0 ve18 p0 ve19 p0 ve20 p0 ve21 p0 ve22 p0 ve23 p0 ve24 p0 ve25 p0 ve26 p0 p0 -ascii
    save vvn.txt vn1 p0 vn2 p0 vn3 p0 vn4 p0 vn5 p0 vn6 p0 vn7 p0 vn8 p0 vn9 p0 vn10 p0 vn11 p0 vn12 p0 vn13 p0 ...
        vn14 p0 vn15 p0 vn16 p0 vn17 p0 vn18 p0 vn19 p0 vn20 p0 vn21 p0 vn22 p0 vn23 p0 vn24 p0 vn25 p0 vn26 p0 p0 -ascii
    save hora.txt h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12 h13 h14 h15 h16 h17 h18 h19 h20 h21 h22 h23 h24 h25 26 p0 -ascii
    
   else
    disp('Arrumar Gambiarra linha 54')
   end
   
% clear all
   
   load pcu.txt    %%% Carregado a ganbiarra
   load vvn.txt
   load vve.txt
   load hora.txt
   
   PCU1 = pcu(:,1); VE1 = vve(:,1); VN1 = vvn(:,1); HOR = hora(:,1);  %%% renomeando as variaveis
   
   
   save corrente_matriz.mat PCU1 VE1 VN1 HOR nest      %%% salvando matriz para o programa Estuario e isopleta
   
   
   delete pcu.txt; delete vve.txt; delete vvn.txt; delete hora.txt;   %%% deletando dados da ganbiarra  
   
     asdasd
   run decomp_NOVA2.m        %%% RODANDO PROGRAMA PARA GERAR MATRIZ PARA ISOPLETA SEM PROFUNDIDADE ADIMENSIONAL
  
%    contourf(flipud(VN))
   
  