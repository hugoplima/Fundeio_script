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

    nest = 13;            % Horas do Fundeio (Ex: 13 ou 26 horas)
    mx = 272;             % numero de linhas das matriz 
    oxii = 0;              % Tem dados de oxi troca (sim =1; nao = 0)
    
	 % separa as colunas de variaveis
	 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    prof=P2;  % usou o sinal menos para transformar a prof em positiva
    temp=TC1;   % carrega temp
    salt=SA1;   % carrega salt
    den=D2;     % carrega den
    if oxii == 1
       oxi=OD1;    % carrega oxi
    end

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
     
        if oxii==1
        eval(['[o' num2str(i)  '] = [oxi(1:x' num2str(i) ',i)];']);
        eval(['[os' num2str(i)  '] = [oxi(1,i)];']);
        end
     end
   end
   
   %% criando as matrizes S, T, O, D  %%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   pp=0; %matriz zero
   
   TT(1:mx,1) = nan;
   SS(1:mx,1) = nan;         % matriz nan
   DD(1:mx,1) = nan;
   PP(1:mx,1) = nan;
   OO(1:mx,1) = nan;
   
for n=1:nest,
 
    if n==1  
      U1 = eval(['x' num2str(n)]);
      tt = eval(['t' num2str(n)]);
      ts = eval(['ts' num2str(n)]);
      s = eval(['s' num2str(n)]);
      ss = eval(['ss' num2str(n)]);
      d = eval(['d' num2str(n)]);
      ds = eval(['ds' num2str(n)]);
      p = eval(['p' num2str(n)]);
      
      V1 = U1+1;
      
      TT(1,1)=ts(:,1);
      TT(2:V1,1)=tt(:,1);
      SS(1,1)=ss(:,1);
      SS(2:V1,1)=s(:,1);
      DD(1,1)=ds(:,1);
      DD(2:V1,1)=d(:,1);
      PP(1,1)=pp;
      PP(2:V1,1)=p(:,1);
      
              if oxii==1
                   o = eval(['o' num2str(n)]);
                   os = eval(['os' num2str(n)]);
                   OO(1,1)=os(:,1);
                   OO(2:V1,1)=o(:,1);
              end
      
    elseif n==2
      U1 = eval(['x' num2str(n)]);
      tt = eval(['t' num2str(n)]);
      ts = eval(['ts' num2str(n)]);
      s = eval(['s' num2str(n)]);
      ss = eval(['ss' num2str(n)]);
      d = eval(['d' num2str(n)]);
      ds = eval(['ds' num2str(n)]);
      p = eval(['p' num2str(n)]);
      
      d4 = V1+1;
      d5 = d4+1;
      d6 = U1+d5-1;

      TT(d4,1)=ts(:,1);
      TT(d5:d6,1)=tt(:,1);
      SS(d4,1)=ss(:,1);
      SS(d5:d6,1)=s(:,1);
      DD(d4,1)=ds(:,1);
      DD(d5:d6,1)=d(:,1);
      PP(d4,1)=pp;
      PP(d5:d6,1)=p(:,1);
      
               if oxii==1
                    o = eval(['o' num2str(n)]);
                    os = eval(['os' num2str(n)]);
                    OO(d4,1)=os(:,1);
                    OO(d5:d6,1)=o(:,1);
               end
      
    else
      U2 = eval(['x' num2str(n)]);
      tt = eval(['t' num2str(n)]);
      ts = eval(['ts' num2str(n)]);
      s = eval(['s' num2str(n)]);
      ss = eval(['ss' num2str(n)]);
      d = eval(['d' num2str(n)]);
      ds = eval(['ds' num2str(n)]);
      p = eval(['p' num2str(n)]);
      
      V2 = d6+1;
      d4 = V2;
      d5 = d4+1;
      d6 = U2+d5-1;
      
      TT(d4,1)=ts(:,1);
      TT(d5:d6,1)=tt(:,1);
      SS(d4,1)=ss(:,1);
      SS(d5:d6,1)=s(:,1);
      DD(d4,1)=ds(:,1);
      DD(d5:d6,1)=d(:,1);
      PP(d4,1)=pp;
      PP(d5:d6,1)=p(:,1);
      
               if oxii==1
                    o = eval(['o' num2str(n)]);
                    os = eval(['os' num2str(n)]);
                    OO(d4,1)=os(:,1);
                    OO(d5:d6,1)=o(:,1);
               end      
         
   U0=U1;V0=V1;U1=U2;V1=V2;  
 
   
   end
end   

   TT((d6+1),1)=pp;
   SS((d6+1),1)=pp;
   DD((d6+1),1)=pp;         % add o valor zero no final de cada coluna
   PP((d6+1),1)=pp;
 
 if oxii==1
     OO((d6+1),1)=pp;
 end
 
 if oxii==0
   PP1 = PP; TT1 = TT; SS1 = SS; DD1 = DD;  %%% renomeando as variaveis   
   
   save dados_matriz.mat PP1 TT1 SS1 DD1 nest z      %%% salvando matriz para o programa Estuario e isopleta
 
 else
   PP1 = PP; TT1 = TT; SS1 = SS; DD1 = DD; OO1 = OO;  %%% renomeando as variaveis   
   
   save dados_matriz.mat PP1 TT1 SS1 DD1 OO1 nest z        %%% salvando matriz para o programa Estuario e isopleta
 end
 
%     asdasd
   run hidro_NOVA2.m        %%% RODANDO PROGRAMA PARA GERAR MATRIZ PARA ISOPLETA SEM PROFUNDIDADE ADIMENSIONAL
  
%    contourf(flipud(SS))
   
  