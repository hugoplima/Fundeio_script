%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%			         ANEXO C                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Laboratorio de Hidrodinamica Costeira, Estuarina e Aguas Interiores %
%        da Universidade Federal do Maranhao (LHiCEAI/UFMA).          %
%                        www.lhiceai.com                              %                        
%                     facebook.com/lhiceai                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   decomp_NOVA2.m   %
%   Programa que converte a tabela.txt do estuario em uma matriz %
%      sem profundidade adimensional                             %

%   NECESSARIOS                                                       %
%   Carregar a tabela usada no decomp.m do progragra estuario.m       %
%   Fazer a correcao da declinacao(decl) e angulo do canal (angulo)   %
%   E colocar o numero de horas coletadas (nest)                      %                             

%   RESULTADO                                                    %
%   Arquivo dados_ADCP.mat                                       %
%   VN: componente longitudinal                                  %
%   VE: component transversal                                    %
%   VT: velocidade total                                         %
%   DIR: direcao do vetor                                        %
	

 		 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		 % reducao dos dados de corrente %
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
  clear all
  close all
  clc

   load corrente_matriz.mat         % carregar arquivo (hora,profundidade,vn,ve)
  
   
   prof=PCU1;           % essa e a profundidade real

   vn=VN1/100;     % A componente u em m/s (se tiver em cm/s dividir por 100 para passar para m/s.)
   ve=VE1/100;	   % A componente v em m/s


%    nest=13;                     % Horas do Fundeio (Ex: 13 ou 26 horas)
   angulo = -70;                % Angulo de inclinacao ao norte
   decl = -21;                  % Declinacao magnetica (Ex: -21 ou 45)
   
   [vel,dir]=uv2intdir(ve,vn,0,0);

	% Decomposicao do vetor velocidade nas componentes "u" e "v" %
	% levando em conta o ang. de declinacao magnetica ( D )      %
    % referente a regiao de Curimatau-RN no ano de 2001 e a      %
    % rotacao do eixo x (B) em 45 graus no sentido anti-horario  %
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	D=decl*pi/180;                   % Declinacao magnetica
	A=pi/2;
	rad= dir*pi/180;
    B=angulo*pi/180;

	  vel_u=vel.*cos(A-(rad+D)+B);      % sentido anti-horario ou horario

	  vel_v=vel.*sin(A-(rad+D)+B);      % sentido anti-horario ou horario
     
   
	 % encontra a posicao onde prof.=0
	 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   x = find(prof==0);  % acha onde as profundidades sao zero
	
   tam = length(x);    % cria uma variavel para ver quantos perfis foram realizados
   
   for i=1:tam
       
     if i~=tam       
     I=num2str(i);

 %   separa todas as estacoes de p,u,v   %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

     pi=['p',I]; % aqui e a pressao para cada perfil (profundidade que esta na tabela)
     profundidade=[pi,'=prof(x(',I,'):x(',I,'+1)-1);'];
     eval(profundidade);

     ui=['u',I]; % aqui e a componente _u para cada perfil
     vel_trans=[ui,'=vel_u(x(',I,'):x(',I,'+1)-1);'];
     eval(vel_trans);

     vi=['v',I]; % aqui e a componente _v para cada perfil
     vel_long=[vi,'=vel_v(x(',I,'):x(',I,'+1)-1);'];
     eval(vel_long);

     end
     
   end
   
%   numero linhas e smooth de u,v  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   C1(1:1,1:nest)=nan;         % matriz nan
   
for n=1:nest,
    
    eval(['[U' num2str(n)  '] = smooth(u' num2str(n) ',31);']);     % smooth u
    eval(['[V' num2str(n)  '] = smooth(v' num2str(n) ',31);']);     % smooth v
    
    eval(['[c' num2str(n)  '] = length(u' num2str(n) ');']);
    
      C2 = eval(['c' num2str(n)]);
      C1(1:length(C2),n)=C2(:,1);
     
end   

   mp1 = max(max(C1));
   mp = mp1 + 1;               % numero maximo de linhas + 1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  Velocidade total e direcao  %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  VE(1:mp,1:nest)=nan;
  VN(1:mp,1:nest)=nan;         % matriz nan
  VT(1:mp,1:nest)=nan;
  DIR(1:mp,1:nest)=nan;

for n=1:nest,
    
     uu = eval(['U' num2str(n)]);
     
       d1 = eval(['c' num2str(n)]);      % matriz da velocidae longitudinal
       d2 =(mp1-d1)+2;
       d3 = (length(uu)+d2)-1;
     
     VN(d2:d3,n)=uu(:,1);
       
     
     vv = eval(['V' num2str(n)]);
     VE(d2:d3,n)=vv(:,1);                % matriz da velocidae transversal
     

     eval(['[int2'  ',dir'  '] =uv2intdir2(U' num2str(n) ',V' num2str(n) ',angulo);']);  % composi??o da velocidade com sinal negativo
    
    VT(d2:d3,n)=int2(:,1);               % matriz da intensidade --- VT
    DIR(d2:d3,n)=dir(:,1);               % matriz da dire??o     --- DIR
     
     clear d1 d2 d3
end

    save dados_ADCP.mat VN VE VT DIR
%     save u.txt VN -ascii
%     save v.txt VE -ascii
%     save int.txt VT -ascii
%     save dir.txt DIR -ascii
    
%     save velocidade_total.txt int1 int2 int3 int4 int5 int6 int7 int8 int9 int10 int11 int12 int13 -ascii
%     save direcao.txt dir1 dir2 dir3 dir4 dir5 dir6 dir7 dir8 dir9 dir10 dir11 dir12 dir13 -ascii
