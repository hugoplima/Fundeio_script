         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		 % reducao dos dados hidrograficos %
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         
% Laboratorio de Hidrodinamica Costeira, Estuarina e Aguas Interiores %
%        da Universidade Federal do Maranhao (LHiCEAI/UFMA).          %
%                        www.lhiceai.com                              %                        
%                     facebook.com/lhiceai                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Limpando o que esta no console do matlab para iniciar o programa
clear all
close all
clc
%%% CARREGANDO A TABELA COM OS DADOS HIDROGRAFICOS	

    load ctd_FUN_1.mat          % esse arquivo e uma tabela que vc tem que construir na mao (Prof, temp, sal, dens)

    nest=13;                    %Horas do Fundeio (Ex: 13 ou 26 horas)
    
	 % separa as colunas de variaveis
	 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    prof=P2;  % usou o sinal menos para transformar a prof em positiva
    temp=TC1;   % carrega temp
    salt=SA1;   % carrega salt
    den=D2;     % carrega den
    oxi=OD1;    % carrega oxi
%     spm=hidro_dados(:,5);    % carrega mps
	
	 % encontra a posicao onde prof.=0
	 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
    ache=find(isnan(prof)==1); 
    prof(ache)=0; clear ache
    z(1:1,1:nest)=nan;         % matriz nan
     
for j=1:nest
    
    eval(['[x' num2str(j)  ']=(max(prof(:,' num2str(j) ')));']);  % cria um vetor com as posicoes de inicio (prof = zero)
    C2 = eval(['x' num2str(j)]);
    z(1:length(C2),j)=C2(:,1);  %matriz com as profundidades para z    
end


   nest1=nest+1;
   
   
   for i=1:nest1        
     if i~=nest1       
	 I=num2str(i);
	
     % separa as medidas de P,T,S,ST para cada perfil %
	 % separa todas as estacoes de p, t, s, st        %   
	 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         
     eval(['[p' num2str(i)  '] = [prof(1:x' num2str(i) ',i)];']);
     
     eval(['[t' num2str(i)  '] = [temp(1:x' num2str(i) ',i)];']);
     eval(['[ts' num2str(i)  '] = [temp(1,i)];']);
     
     eval(['[s' num2str(i)  '] = [salt(1:x' num2str(i) ',i)];']);    
     eval(['[ss' num2str(i)  '] = [salt(1,i)];']);
     
     eval(['[d' num2str(i)  '] = [den(1:x' num2str(i) ',i)];']);
     eval(['[ds' num2str(i)  '] = [den(1,i)];']);
     
     eval(['[o' num2str(i)  '] = [oxi(1:x' num2str(i) ',i)];']);
     eval(['[os' num2str(i)  '] = [oxi(1,i)];']);
	
     end
   end
   
   %% criando as matrizes S, T, O, D  %%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   p0=0; %matriz zero
   
   %%% GANBIARRA 
  
   save p.txt p0 p1 p0 p2 p0 p3 p0 p4 p0 p5 p0 p6 p0 p7 p0 p8 p0 p9 p0 p10 p0 p11 p0 p12 p0 p13 p0 -ascii         %%% se fundeios com duracao maiores colocar(Ex: p0 p1 p0 p2 ... p26 p0)   
   save t.txt ts1 t1 ts2 t2 ts3 t3 ts4 t4 ts5 t5 ts6 t6 ts7 t7 ts8 t8 ts9 t9 ts10 t10 ts11 t11 ts12 t12 ts13 t13 p0 -ascii    %%% (Ex: ts1 t1 ts2 t2 ... ts26 t26 p0) 
   save s.txt ss1 s1 ss2 s2 ss3 s3 ss4 s4 ss5 s5 ss6 s6 ss7 s7 ss8 s8 ss9 s9 ss10 s10 ss11 s11 ss12 s12 ss13 s13 p0 -ascii
   save d.txt ds1 d1 ds2 d2 ds3 d3 ds4 d4 ds5 d5 ds6 d6 ds7 d7 ds8 d8 ds9 d9 ds10 d10 ds11 d11 ds12 d12 ds13 d13 p0 -ascii
   save o.txt os1 o1 os2 o2 os3 o3 os4 o4 os5 o5 os6 o6 os7 o7 os8 o8 os9 o9 os10 o10 os11 o11 os12 o12 os13 o13 p0 -ascii 
   
% clear all
   
   load p.txt    %%% Carregado a ganbiarra
   load t.txt
   load s.txt
   load d.txt
   load o.txt
   
   PP1 = p(:,1); TT1 = t(:,1); SS1 = s(:,1); DD1 = d(:,1); OO1 = o(:,1);  %%% renomeando as variaveis
   
   
   save dados_matriz.mat PP1 TT1 SS1 DD1 OO1 nest      %%% salvando matriz para o programa Estuario e isopleta
   
   
   delete p.txt; delete t.txt; delete s.txt; delete d.txt; delete o.txt   %%% deletando dados da ganbiarra  
   
%    asdasd
   run hidro_NOVA2.m        %%% RODANDO PROGRAMA PARA GERAR MATRIZ PARA ISOPLETA SEM PROFUNDIDADE ADIMENSIONAL
  
%    contourf(flipud(SS))
   
  