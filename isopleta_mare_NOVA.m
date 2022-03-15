%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                  ISOPLETAS DO FUNDEIO COM A VARIACAO DE MARE             %
%                        Desenvolvido - VINICIUS MACIEL                    % 
%                               editado por Hugo                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  Laboratorio de Hidrodinamica Costeira, Estuarina e Aguas Interiores     %
%        da Universidade Federal do Maranhao (LHiCEAI/UFMA).               %
%                        www.lhiceai.com                                   %                        
%                     facebook.com/lhiceai                                 %

%   NECESSARIOS                                                       %
%   Carregar os matriz dos dados do hidro_NOVA2.m e decomp_NOVA2.m    %
%   Colocar a variacao do nivel da coluna de agua                     %

    %% FUNDEIO (%%%%%%%)

    clear all
    close all
    clc

     %% barras de cores
    load color_anomalia2.dat
    load azul_encarnado.dat
    load MPS_Lhiceai.dat
    load color_temp.txt
    load color_sal.txt

    %% carregando os dados
    load dados_ADCP.mat  %componente longitudinal da velocidade
    load dados_hidro.mat % temperatura, salinidade e densidade
    
    %% OBS: CORRECAO DOS DADOS
%     MM=MM.*10; % OBS ARRUMANDO OS VALORES DE MPS DA TABELA DESTE FUNDEIO
    
%     O1=OO;
%     O=(O1./1.025); % conversao do umol/L to umol/kg
    %% Limites das matrizes
    [ym,xm]=size(SS);  % ym= numero de linha e xm= numero 
    
    ym1=ym+1; %aumento o valor do numero de linhas (Ex: 1) ou fix o valor (Ex: ym1 = 20;)

    %% Componente Longitudinal
    
   
         figure
         set(gcf,...
		 'Color',[1 1 1],...
		 'InvertHardcopy','on',...
		 'PaperUnits','inches',...
		 'Units','inches',...
		 'PaperOrientation','portrait',...
		 'PaperPosition',[0 0 18 10],...
		 'PaperPositionMode','manual',...
		 'PaperType','usletter',...
		 'Position',[.2 .2 17 10],...
		 'Clipping','on');     


        load zl_31.dat
        onda1 = zl_31(:,1);
%       onda=onda1';
        posicao_mare = .2;      % Add posicao da mare na figura (ajuste)
        onda2=onda1+posicao_mare;
        onda3=onda2';

        
        [c1,h1]=contourf(flipud(VN),[-1.6,-1.4,-1.2,-1.0,-0.8,-0.6,-0.2,0,0.2,0.4,0.6,0.8,1.0,1.2,1.4,1.6],'k-');colormap(color_anomalia2) % 'LineStyle','none'
%         [c1,h1] = contourf(flipud(VN),[min(min(VN)):.25:max(max(VN))]); colormap(color_anomalia2)
        colorbar; caxis([-1.5 1.5]);
        set(gca,'fontsize',24,'fontweight','bold');
        axis([1 xm 1 ym1])
    
        
        h1.LevelList=round(h1.LevelList,2)  % rounds levels to 3rd decimal place
        c=clabel(c1,h1,'manual','fontsize',24,'fontweight','bold')  %,'rotation',0)
        set(h1,'color',[.1 .1 .1]);
        set(c,'color',[.1 .1 .1]);
        H=colorbar;
        set(gca,'fontsize',24,'fontweight','bold');
        
        
        hold on
        plot(onda2,'k');
        a2=max(onda2)+2; % aumenta 4 metro do max z (Artificio)
        a3=[a2 onda3 a2];
        a1=[1 1:xm xm];
        fill(a1,a3,'w','LineStyle','none');
        
%       xlabel('Time (hours)','fontsize',25)
        ylabel('Dimensionless Depth (Z)','fontsize',25)
        ylabel(H,'U (m s{^{-1}})','fontsize',25,'fontweight','bold');

    % print (gcf, '-dtiff',['Isopleta_u']);
        
        asda
    %% Componente transversal
    
   
         figure
         set(gcf,...
		 'Color',[1 1 1],...
		 'InvertHardcopy','on',...
		 'PaperUnits','inches',...
		 'Units','inches',...
		 'PaperOrientation','portrait',...
		 'PaperPosition',[0 0 18 10],...
		 'PaperPositionMode','manual',...
		 'PaperType','usletter',...
		 'Position',[.2 .2 17 10],...
		 'Clipping','on');     


        load zl_31.dat
        onda1 = zl_31(:,1);
%         onda=onda1';
        posicao_mare = .2;      % Add posicao da mare na figura (ajuste)
        onda2=onda1+posicao_mare;
        onda3=onda2';

        
        [c1,h1]=contourf(flipud(VE),[-1.6,-1.2,-1.0,-0.8,-0.6,-0.4,-0.2,0,0.2,0.4,0.6,0.8,1.0,1.2,1.4],'k-');colormap(color_anomalia2) % 'LineStyle','none'
%         [c1,h1] = contourf(flipud(VE),[min(min(VE)):.25:max(max(VE))]); colormap(color_anomalia2)
        colorbar; caxis([-1.0 1.0]);
        set(gca,'fontsize',24,'fontweight','bold');
        axis([1 xm 1 ym1])
    
        
        h1.LevelList=round(h1.LevelList,2)  % rounds levels to 3rd decimal place
        c=clabel(c1,h1,'manual','fontsize',24,'fontweight','bold')%,'rotation',0)
        set(h1,'color',[.1 .1 .1]);
        set(c,'color',[.1 .1 .1]);
        H=colorbar;
        set(H,'YTick',[-1:0.5:1]);
        set(gca,'fontsize',24,'fontweight','bold');
        
        
        hold on
        plot(onda2,'k');
        a2=max(onda2)+2;    % aumenta 4 metro do max z (Artificio)
        a3=[a2 onda3 a2];
        a1=[1 1:xm xm];
        fill(a1,a3,'w','LineStyle','none');
        
        xlabel('Time (hours)','fontsize',25)
        %ylabel('Dimensionless Depth (Z)','fontsize',25)
        ylabel(H,'V (m s{^{-1}})','fontsize',25,'fontweight','bold');

    % print (gcf, '-dtiff',['Isopleta_v']);
        
        asda
    %% Velocidade total
    
   
         figure
         set(gcf,...
		 'Color',[1 1 1],...
		 'InvertHardcopy','on',...
		 'PaperUnits','inches',...
		 'Units','inches',...
		 'PaperOrientation','portrait',...
		 'PaperPosition',[0 0 18 10],...
		 'PaperPositionMode','manual',...
		 'PaperType','usletter',...
		 'Position',[.2 .2 17 10],...
		 'Clipping','on');     


        load zl_31.dat
        onda1 = zl_31(:,1);
%         onda=onda1';
        posicao_mare = .2;      % Add posicao da mare na figura (ajuste)
        onda2=onda1+posicao_mare;
        onda3=onda2';

        
        [c1,h1]=contourf(flipud(VT),[-1.6,-1.4,-1.2,-1.0,-0.8,-0.6,-0.4,-0.2,0,0.2,0.4,0.6,0.8,1.0,1.4,1.6],'k-');colormap(color_anomalia2) % 'LineStyle','none'
%         [c1,h1] = contourf(flipud(VT),[min(min(VT)):.25:max(max(VT))]); colormap(color_anomalia2)
        colorbar; caxis([-1.6 1.6]);
        set(gca,'fontsize',24,'fontweight','bold');
        axis([1 xm 1 ym1])
    
        
        h1.LevelList=round(h1.LevelList,2)  %rounds levels to 3rd decimal place
        c=clabel(c1,h1,'manual','fontsize',24,'fontweight','bold')%,'rotation',0)
        set(h1,'color',[.1 .1 .1]);
        set(c,'color',[.1 .1 .1]);
        H=colorbar;
        set(H,'YTick',[-1.6:0.8:1.6]);
        set(gca,'fontsize',24,'fontweight','bold');
        
        
        hold on
        plot(onda2,'k');
        a2=max(onda2)+2; % aumenta 4 metro do max z (Artificio)
        a3=[a2 onda3 a2];
        a1=[1 1:xm xm];
        fill(a1,a3,'w','LineStyle','none');
        
%       xlabel('Time (hours)','fontsize',25)
        %ylabel('Dimensionless Depth (Z)','fontsize',25)
        ylabel(H,'Velocity (m s{^{-1}})','fontsize',25,'fontweight','bold');

    % print (gcf, '-dtiff',['Isopleta_velocidade']);
        
        asda
        %% salinity

    
         figure
         set(gcf,...
		 'Color',[1 1 1],...
		 'InvertHardcopy','on',...
		 'PaperUnits','inches',...
		 'Units','inches',...
		 'PaperOrientation','portrait',...
		 'PaperPosition',[0 0 18 10],...
		 'PaperPositionMode','manual',...
		 'PaperType','usletter',...
		 'Position',[.2 .2 17 10],...
		 'Clipping','on');     


        load zl_31.dat
        onda1 = zl_31(:,1);
%         onda=onda1';
        posicao_mare = 5;      % Add posicao da mare na figura (ajuste)
        onda2=onda1+posicao_mare;
        onda3=onda2';
        
        [c1,h1] = contourf(flipud(SS),[min(min(SS))-1:0.3:max(max(SS))+1]); colormap(color_sal)
%         [c1,h1] = contourf(flipud(SS),[33.5 34 34.2 34.4 34.6 34.8 35 35.2 35.4 35.6 35.8 36]); colormap(color_sal)
        colorbar; caxis([0 40]);
        set(gca,'fontsize',24,'fontweight','bold');
        axis([1 xm 1 ym1])
    
        h1.LevelList=round(h1.LevelList,2)  %rounds levels to 3rd decimal place
        c=clabel(c1,h1,'manual','fontsize',24,'fontweight','bold')%,'rotation',0)
        set(h1,'color',[.1 .1 .1]);
        set(c,'color',[.1 .1 .1]);
        H=colorbar;
        set(gca,'fontsize',24,'fontweight','bold');
        
        ax = gca;
        ax.XTick = [1 2 3 4 5 6 7 8 9];
        ax.XTickLabel = {'1', '2.5', '4', '5.5', '7', '8.5', '10', '11.5', '13'};
        
        
        hold on
        plot(onda2,'k');
        a2=max(onda2)+2; % aumenta 4 metro do max z (Artificio)
        a3=[a2 onda3 a2];
        a1=[1 1:xm xm];
        fill(a1,a3,'w','LineStyle','none');
        
%       xlabel('Tempo (horas)','fontsize',25)
        %ylabel('Dimensionless Depth (Z)','fontsize',24)
        ylabel(H,'Salinity (gkg{^{-1}})','fontsize',25,'fontweight','bold');

    % print (gcf, '-dtiff',['Isopleta_Salinidade1']);
    
    
    %% Temperatura
    

         figure
         set(gcf,...
		 'Color',[1 1 1],...
		 'InvertHardcopy','on',...
		 'PaperUnits','inches',...
		 'Units','inches',...
		 'PaperOrientation','portrait',...
		 'PaperPosition',[0 0 18 10],...
		 'PaperPositionMode','manual',...
		 'PaperType','usletter',...
		 'Position',[.2 .2 17 10],...
		 'Clipping','on');     


        load zl_31.dat
        onda1 = zl_31(:,1);
%         onda=onda1';
        posicao_mare = .2;      % Add posicao da mare na figura (ajuste)
        onda2=onda1+posicao_mare;
        onda3=onda2';
    
        
        [c1,h1]=contourf(flipud(TT),[min(min(TT)):0.09:max(max(TT))]); colormap(color_temp)
        colorbar; caxis([25 35]);
        set(gca,'fontsize',24,'fontweight','bold');
        axis([1 xm 1 ym1])

        
        h1.LevelList=round(h1.LevelList,2)  %rounds levels to 3rd decimal place
        c=clabel(c1,h1,'manual','fontsize',24,'fontweight','bold')%,'rotation',0)
        set(h1,'color',[.1 .1 .1]);
        set(c,'color',[.1 .1 .1]);
        H=colorbar;
        set(gca,'fontsize',24,'fontweight','bold');

        
        hold on
        plot(onda2,'k');
        a2=max(onda2)+4; % aumenta 4 metro do max z (Artificio)
        a3=[a2 onda3 a2];
        a1=[1 1:xm xm];
        fill(a1,a3,'w','LineStyle','none');
        
%         xlabel('Tempo (horas)','fontsize',25)
        ylabel('Dimensionless Depth (Z)','fontsize',25,'fontweight','bold')
        ylabel(H,'Temperature ({^{o}C})','fontsize',25,'fontweight','bold');
        
        
        % print (gcf, '-dtiff',['Isopleta_Temperatura1']);
        
        
        %% SPM
        
         figure
         set(gcf,...
		 'Color',[1 1 1],...
		 'InvertHardcopy','on',...
		 'PaperUnits','inches',...
		 'Units','inches',...
		 'PaperOrientation','portrait',...
		 'PaperPosition',[0 0 18 10],...
		 'PaperPositionMode','manual',...
		 'PaperType','usletter',...
		 'Position',[.2 .2 17 10],...
		 'Clipping','on');     


        load zl_31.dat
        onda1 = zl_31(:,1);
%         onda=onda1';
        posicao_mare = .2;      % Add posicao da mare na figura (ajuste)
        onda2=onda1+posicao_mare;
        onda3=onda2';

        
        [c1,h1]=contourf(flipud(MM),[0,100,200,300,400,500,600,700,800]); colormap(MPS_Lhiceai) % 'LineStyle','none'
        colorbar; caxis([0 1200]);
        axis([1 xm 1 ym1])
%         set(gca,'YTickLabel',[0 5 10 15 20 25]);
%         set(gca, 'YDir','reverse')
        set(gca,'fontsize',24,'fontweight','bold');

        h1.LevelList=round(h1.LevelList,2)  %rounds levels to 3rd decimal place
        c=clabel(c1,h1,'manual','fontsize',24,'fontweight','bold')%,'rotation',0)
        set(h1,'color',[.1 .1 .1]);
        set(c,'color',[.1 .1 .1]);
        H=colorbar;
        set(gca,'fontsize',24,'fontweight','bold');
        
        hold on
        plot(onda2,'k');
        a2=max(onda2)+4; % aumenta 4 metro do max z (Artificio)
        a3=[a2 onda3 a2];
        a1=[1 1:xm xm];
        fill(a1,a3,'w','LineStyle','none');

        xlabel('Tempo (horas)','fontsize',25,'fontweight','bold')
        %ylabel('Dimensionless Depth (Z)','fontsize',25,'fontweight','bold')
        ylabel(H,'MPS (mgL{^{-1}})','fontsize',25,'fontweight','bold');
        
        % print (gcf, '-dtiff',['Isopleta_MPS']);
        
        %% Oxigenio CTD

    
         figure
         set(gcf,...
		 'Color',[1 1 1],...
		 'InvertHardcopy','on',...
		 'PaperUnits','inches',...
		 'Units','inches',...
		 'PaperOrientation','portrait',...
		 'PaperPosition',[0 0 18 10],...
		 'PaperPositionMode','manual',...
		 'PaperType','usletter',...
		 'Position',[.2 .2 17 10],...
		 'Clipping','on');     

     
        load zl_31.dat
        onda1 = zl_31(:,1);
%         onda=onda1';
        posicao_mare = .2;      % Add posicao da mare na figura (ajuste)
        onda2=onda1+posicao_mare;
        onda3=onda2';

        
        [c1,h1] = contourf(flipud(O),[min(min(O)):2:max(max(O))]); colormap(azul_encarnado)
%         [c1,h1] = contourf(flipud(O),[190,200,203.11,204.11,205.11,210.11,220.11,230.11,240]); colormap(azul_encarnado)
        colorbar; caxis([190 240]);
        set(gca,'fontsize',24,'fontweight','bold');
        axis([1 xm 1 ym1])
    
        h1.LevelList=round(h1.LevelList,2)  %rounds levels to 3rd decimal place
        c=clabel(c1,h1,'manual','fontsize',24,'fontweight','bold')%,'rotation',0)
        set(h1,'color',[.1 .1 .1]);
        set(c,'color',[.1 .1 .1]);
        H=colorbar;
        set(gca,'fontsize',24,'fontweight','bold');
        
        hold on
        plot(onda2,'k');
        a2=max(onda2)+4; % aumenta 4 metro do max z (Artificio)
        a3=[a2 onda3 a2];
        a1=[1 1:xm xm];
        fill(a1,a3,'w','LineStyle','none');
    
        xlabel('Tempo (horas)','fontsize',25,'fontweight','bold')
        %ylabel('Dimensionless Depth (Z)','fontsize',24)
        ylabel(H,'OD (\mumolKg{^{-1}})','fontsize',25,'fontweight','bold'); %\mu ? o micromol/L

        % print (gcf, '-dtiff',['Isopleta_OD']);
