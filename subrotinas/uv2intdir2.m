function [int2,dir]=uv2intdir2(U,V,angulo)
% Laboratorio de Hidrodinamica Costeira, Estuarina e Aguas Interiores     %
%        da Universidade Federal do Maranhao (LHiCEAI/UFMA).              %
%                        www.lhiceai.com                                  %                        
%                     facebook.com/lhiceai                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INVERSO DA
% FUNCAO INTDIR2UV2.M Decompoem o vetor corrente definido pela intensidade
%                    e direcao (ref. Norte -> Este)  
% 
%Programa editado para gerar matriz da velicidade total com sinais
%positivos(mare vazante) e negativos(mare enchente).

%   NECESSARIOS
%   U:      componente longitudinal; 
%   V:      componente transversal; 
%   angulo: inclinacao do canal com o norte verdadeiro.
 
%   RESULTADO 
%   int2: intensidade totais com sinais
%   dir:  direcao dos vetores

 if nargin < 3,
   ang_rot=0;
 if nargin == 2,
 angulo=0;
 end 
 end
 angulo=abs(angulo);
for x=1:length(U)

   vt(x,1) = U(x,1)+i*V(x,1);
   int=abs(vt);

   dir(x,1)=angle(vt(x,1));
   dir(x,1)=dir(x,1)*180/pi;
   dir(x,1)=mod(90-dir(x,1),360);

   dir1=90+angulo;
   dir2=270+angulo;
   
   if dir(x,1) > dir1,
      int1(x,1)=sqrt((U(x,1).^2)+(V(x,1).^2));
      int2(x,1) = int1(x,1).*(-1);
      
   elseif dir(x,1) > dir2,
      int1(x,1)=sqrt((U(x,1).^2)+(V(x,1).^2));
      int2(x,1) = int1(x,1).*(-1);
      
   else 
      int3(x,1)=sqrt((U(x,1).^2)+(V(x,1).^2));
      int2(x,1) = int3(x,1);
       
   end
end    
        



