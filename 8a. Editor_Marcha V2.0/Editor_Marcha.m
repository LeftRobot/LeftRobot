close all
clear all
clc

%% COMPRIMENTOS DOS ELOS

Lc = 0.42;    % Comprimento coxa [m]
Lj = 0.46;    % Comprimento da perna [m]
Lp = 0.11;    % Comprimento do pé[m]

global K;
K = 1;

global velT1
velT1 = [];

global velT2;
velT2 = [];

global velT3;
velT3 = [];

global velT4;
velT4 = [];

global velT5;
velT5 = [];

global velT6;
velT6 = [];

global velT7;
velT7 = [];

global velT8;
velT8 = [];

global ciclos_T1;
ciclos_T1 = 1;

global ciclos_T2;
ciclos_T2 = 1;

global ciclos_T3;
ciclos_T3 = 1;

global ciclos_T4;
ciclos_T4 = 1;

global ciclos_T5;
ciclos_T5 = 1;

global ciclos_T6;
ciclos_T6 = 1;

global ciclos_T7;
ciclos_T7 = 1;

global ciclos_T8;
ciclos_T8 = 1;

global inc_T1;
inc_T1 = 0;

global inc_T2;
inc_T2 = 0;

global inc_T3;
inc_T3 = 0;

global inc_T4;
inc_T4 = 0;

global inc_T5;
inc_T5 = 0;

global inc_T6;
inc_T6 = 0;

global inc_T7;
inc_T7 = 0;

global inc_T8;
inc_T8 = 0;

global vel_marcha;
vel_marcha = [];

%% FIGURA 1: EDITOR DOS PARÂMETROS DA TRAJETÓRIA DE MARCHA
% Figure Container para o Editor de Trajetória de Marcha
fgait1 = figure('Position',[70 70 500 580],'Toolbar','none',...
                'MenuBar','none');

% Painel pai que contém os paineis filhos
h_panel = uipanel(fgait1,'Units','pixels','Position',[5,5,495,575]);

h_panel.BackgroundColor = 'white';    % Cor do fundo do painel
h_panel.Title = 'EDITOR DE TRAJETÓRIA DE MARCHA'; % Título do painel
h_panel.ForegroundColor = 'blue';     % cor da letra do título do painel
h_panel.FontSize = 12;                % tamanho da letra do título do painel
h_panel.TitlePosition = 'centertop';  % Posicao do título no painel


% %% EDITOR DE MARCHA

% You can specify a unique 'Tag' value to serve as an identifier for an object. 
% When you need access to the object elsewhere in your code, you can use 
% the 'findobj' function to search for the object based on the Tag value.

% 8 UIPANEL - paineis para colocaras seccoes de tempo Ti com os botoes e os 
% campos editáveis
panel1 = uipanel('Parent',h_panel,'Title','T1','FontSize',10,'Units','pixels',...
         'ForegroundColor',[0.6350 0.0780 0.1840],'Position',[10,420,220,130],...
         'Tag','Panel1');

panel2 = uipanel('Parent',h_panel,'Title','T2','FontSize',10,'Units','pixels',...
         'ForegroundColor',[0.6350 0.0780 0.1840],'Position',[260,420,220,130]);

panel3 = uipanel('Parent',h_panel,'Title','T3','FontSize',10,'Units','pixels',...
         'ForegroundColor',[0.6350 0.0780 0.1840],'Position',[10,285,220,130]);

panel4 = uipanel('Parent',h_panel,'Title','T4','FontSize',10,'Units','pixels',...
         'ForegroundColor',[0.6350 0.0780 0.1840],'Position',[260,285,220,130]);
             
panel5 = uipanel('Parent',h_panel,'Title','T5','FontSize',10,'Units','pixels',...
         'ForegroundColor',[0.6350 0.0780 0.1840],'Position',[10,150,220,130]);

panel6 = uipanel('Parent',h_panel,'Title','T6','FontSize',10,'Units','pixels',...
         'ForegroundColor',[0.6350 0.0780 0.1840],'Position',[260,150,220,130]);

panel7 = uipanel('Parent',h_panel,'Title','T7','FontSize',10,'Units','pixels',...
         'ForegroundColor',[0.6350 0.0780 0.1840],'Position',[10,15,220,130]);
             
panel8 = uipanel('Parent',h_panel,'Title','T8','FontSize',10,'Units','pixels',...
         'ForegroundColor',[0.6350 0.0780 0.1840],'Position',[260,15,220,130]);

% % alinhar os paineis
 align([panel1,panel3,panel5,panel7],'Center','None');
 align([panel2,panel4,panel6,panel8],'Center','None');


% % 8 STATIC TEX PARA ESPECIFICAR VELOCIDADE E No. DE CICLOS - uicontrol

% Painel 1
text1_p1 = uicontrol('Parent',panel1,'Style','text','String','Velocidade',...
                    'FontSize',9,'Position',[4,90,60,15]);
text2_p1 = uicontrol('Parent',panel1,'Style','text','String','No. Ciclos',...
                    'FontSize',9,'Position',[4,52,60,15]);
text3_p1 = uicontrol('Parent',panel1,'Style','text','String','Inclinacao',...
                     'FontSize',9,'Position',[4,14,60,15]);
% Painel 2
text1_p2 = uicontrol('Parent',panel2,'Style','text','String','Velocidade',...
                    'FontSize',9,'Position',[4,90,60,15]);
text2_p2 = uicontrol('Parent',panel2,'Style','text','String','No. Ciclos',...
                    'FontSize',9,'Position',[4,52,60,15]);
text3_p2 = uicontrol('Parent',panel2,'Style','text','String','Inclinacao',...
                     'FontSize',9,'Position',[4,14,60,15]);

% Painel 3
text1_p3 = uicontrol('Parent',panel3,'Style','text','String','Velocidade',...
                    'FontSize',9,'Position',[4,90,60,15]);
text2_p3 = uicontrol('Parent',panel3,'Style','text','String','No. Ciclos',...
                    'FontSize',9,'Position',[4,52,60,15]);
text3_p3 = uicontrol('Parent',panel3,'Style','text','String','Inclinacao',...
                     'FontSize',9,'Position',[4,14,60,15]);

% Painel 4
text1_p4 = uicontrol('Parent',panel4,'Style','text','String','Velocidade',...
                    'FontSize',9,'Position',[4,90,60,15]);
text2_p4 = uicontrol('Parent',panel4,'Style','text','String','No. Ciclos',...
                    'FontSize',9,'Position',[4,52,60,15]);
text3_p4 = uicontrol('Parent',panel4,'Style','text','String','Inclinacao',...
                     'FontSize',9,'Position',[4,14,60,15]);

% Painel 5
text1_p5 = uicontrol('Parent',panel5,'Style','text','String','Velocidade',...
                    'FontSize',9,'Position',[4,90,60,15]);
text2_p5 = uicontrol('Parent',panel5,'Style','text','String','No. Ciclos',...
                    'FontSize',9,'Position',[4,52,60,15]);
text3_p5 = uicontrol('Parent',panel5,'Style','text','String','Inclinacao',...
                     'FontSize',9,'Position',[4,14,60,15]);

% Painel 6
text1_p6 = uicontrol('Parent',panel6,'Style','text','String','Velocidade',...
                    'FontSize',9,'Position',[4,90,60,15]);
text2_p6 = uicontrol('Parent',panel6,'Style','text','String','No. Ciclos',...
                    'FontSize',9,'Position',[4,52,60,15]);
text3_p6 = uicontrol('Parent',panel6,'Style','text','String','Inclinacao',...
                     'FontSize',9,'Position',[4,14,60,15]);
                 
% Painel 7
text1_p7 = uicontrol('Parent',panel7,'Style','text','String','Velocidade',...
                    'FontSize',9,'Position',[4,90,60,15]);
text2_p7 = uicontrol('Parent',panel7,'Style','text','String','No. Ciclos',...
                    'FontSize',9,'Position',[4,52,60,15]);
text3_p7 = uicontrol('Parent',panel7,'Style','text','String','Inclinacao',...
                     'FontSize',9,'Position',[4,14,60,15]);

% Painel 8
text1_p8 = uicontrol('Parent',panel8,'Style','text','String','Velocidade',...
                    'FontSize',9,'Position',[4,90,60,15]);
text2_p8 = uicontrol('Parent',panel8,'Style','text','String','No. Ciclos',...
                    'FontSize',9,'Position',[4,52,60,15]);
text3_p8 = uicontrol('Parent',panel8,'Style','text','String','Inclinacao',...
                     'FontSize',9,'Position',[4,14,60,15]);

% % 8 POP UP MENUS para determinar a velocidade selecionada em cada seccao 
% de tempo Ti, i=1:8
hpopup1 = uicontrol('Parent',panel1,'Style','popupmenu','String',...
         {'0.5 m/s','1 m/s','1.2 m/s','1.5 m/s'},'HorizontalAlignment','left',...
         'Position',[85,78,120,30],'Tag','popvelT1','UserData',struct('VT1',0));
hpopup1.Callback = {@pop1_callback};

hpopup2 = uicontrol('Parent',panel2,'Style','popupmenu','String',...
         {'0.5 m/s','1 m/s','1.2 m/s','1.5 m/s'},'HorizontalAlignment','left',...
         'Position',[85,78,120,30],'Tag','popvelT2','UserData',struct('VT2',0));
hpopup2.Callback = {@pop2_callback};
     
hpopup3 = uicontrol('Parent',panel3,'Style','popupmenu','String',...
         {'0.5 m/s','1 m/s','1.2 m/s','1.5 m/s'},'HorizontalAlignment','left',...
         'Position',[85,78,120,30],'Tag','popvelT3','UserData',struct('VT3',0));
hpopup3.Callback = {@pop3_callback};
     
hpopup4 = uicontrol('Parent',panel4,'Style','popupmenu','String',...
         {'0.5 m/s','1 m/s','1.2 m/s','1.5 m/s'},'HorizontalAlignment','left',...
         'Position',[85,78,120,30],'Tag','popvelT4','UserData',struct('VT4',0));
hpopup4.Callback = {@pop4_callback};

hpopup5 = uicontrol('Parent',panel5,'Style','popupmenu','String',...
         {'0.5 m/s','1 m/s','1.2 m/s','1.5 m/s'},'HorizontalAlignment','left',...
         'Position',[85,78,120,30],'Tag','popvelT5','UserData',struct('VT5',0));
hpopup5.Callback = {@pop5_callback};

hpopup6 = uicontrol('Parent',panel6,'Style','popupmenu','String',...
         {'0.5 m/s','1 m/s','1.2 m/s','1.5 m/s'},'HorizontalAlignment','left',...
         'Position',[85,78,120,30],'Tag','popvelT6','UserData',struct('VT6',0));
hpopup6.Callback = {@pop6_callback};
     
hpopup7 = uicontrol('Parent',panel7,'Style','popupmenu','String',...
         {'0.5 m/s','1 m/s','1.2 m/s','1.5 m/s'},'HorizontalAlignment','left',...
         'Position',[85,78,120,30],'Tag','popvelT7','UserData',struct('VT7',0));
hpopup7.Callback = {@pop7_callback};
     
hpopup8 = uicontrol('Parent',panel8,'Style','popupmenu','String',...
         {'0.5 m/s','1 m/s','1.2 m/s','1.5 m/s'},'HorizontalAlignment','left',...
         'Position',[85,78,120,30],'Tag','popvelT8','UserData',struct('VT8',0)); 
hpopup8.Callback = {@pop8_callback};


% 8 EDIT TEXT PAINEL PARA INSERIR O NÚMERO DE CICLOS E 8 EDIT TEXT PARA 
% INSERIR A INCLINACAO EM CADA  SECCAO DE TEMPO Ti
% % valor inserido tem de ser numérico, caso contrário mensagem de erro

% EDIT TEXT PAINEL T1
% Número de ciclos T1
edit1_p1 = uicontrol(panel1,'Style','edit','String','','BackgroundColor','white',...
            'HorizontalAlignment','left','Position',[85,50,100,20]);
edit1_p1.Callback = {@NciclosT1};

% Inclinacao T1
edit2_p1 = uicontrol(panel1,'Style','edit','String','','BackgroundColor','white',...
            'HorizontalAlignment','left','Position',[85,10,100,20]);
edit2_p1.Callback = {@inclinaT1};

        
text_ed2p1 = uicontrol('Parent',panel1,'Style','text','String','%',...
                    'FontSize',10,'Position',[190,8,30,20]);

% EDIT TEXT PAINEL T2
% número de ciclos T2
edit1_p2 = uicontrol(panel2,'Style','edit','String','1','BackgroundColor','white',...
            'HorizontalAlignment','left','Position',[85,50,100,20]);
edit1_p2.Callback = {@NciclosT2};

% Inclinacao T2
edit2_p2 = uicontrol(panel2,'Style','edit','String','0','BackgroundColor','white',...
            'HorizontalAlignment','left','Position',[85,10,100,20]);
edit2_p2.Callback = {@inclinaT2};

        
text_ed2p2 = uicontrol('Parent',panel2,'Style','text','String','%',...
                    'FontSize',10,'Position',[190,8,30,20]);

% EDIT TEXT PAINEL 3
% número de ciclos T3
edit1_p3 = uicontrol(panel3,'Style','edit','String','1','BackgroundColor','white',...
            'HorizontalAlignment','left','Position',[85,50,100,20]);
edit1_p3.Callback = {@NciclosT3};

% Inclinacao T3
edit2_p3 = uicontrol(panel3,'Style','edit','String','0','BackgroundColor','white',...
            'HorizontalAlignment','left','Position',[85,10,100,20]);
edit2_p3.Callback = {@inclinaT3};

        
text_ed2p3 = uicontrol('Parent',panel3,'Style','text','String','%',...
                    'FontSize',10,'Position',[190,8,30,20]);                

% EDIT TEXT PAINEL 4
% Número de ciclos T4
edit1_p4 = uicontrol(panel4,'Style','edit','String','1','BackgroundColor','white',...
            'HorizontalAlignment','left','Position',[85,50,100,20]);
edit1_p4.Callback = {@NciclosT4};

% Inclinacao T4
edit2_p4 = uicontrol(panel4,'Style','edit','String','0','BackgroundColor','white',...
            'HorizontalAlignment','left','Position',[85,10,100,20]);
edit2_p4.Callback = {@inclinaT4};
        
text_ed2p4 = uicontrol('Parent',panel4,'Style','text','String','%',...
                    'FontSize',10,'Position',[190,8,30,20]);
                
% EDIT TEXT PAINEL 5
% número de ciclos T5
edit1_p5 = uicontrol(panel5,'Style','edit','String','1','BackgroundColor','white',...
            'HorizontalAlignment','left','Position',[85,50,100,20]);
edit1_p5.Callback = {@NciclosT5};

% Inclinacao T5
edit2_p5 = uicontrol(panel5,'Style','edit','String','0','BackgroundColor','white',...
            'HorizontalAlignment','left','Position',[85,10,100,20]);
edit2_p5.Callback = {@inclinaT5};
        
text_ed2p5 = uicontrol('Parent',panel5,'Style','text','String','%',...
                    'FontSize',10,'Position',[190,8,30,20]);
                
% EDIT TEXT PAINEL 6
% Número de ciclos T6
edit1_p6 = uicontrol(panel6,'Style','edit','String','1','BackgroundColor','white',...
            'HorizontalAlignment','left','Position',[85,50,100,20]);
edit1_p6.Callback = {@NciclosT6};

% inclinacao T6
edit2_p6 = uicontrol(panel6,'Style','edit','String','0','BackgroundColor','white',...
            'HorizontalAlignment','left','Position',[85,10,100,20]);
edit2_p6.Callback = {@inclinaT6};

        
text_ed2p6 = uicontrol('Parent',panel6,'Style','text','String','%',...
                    'FontSize',10,'Position',[190,8,30,20]);
                
% EDIT PAINEL 7
% Número de ciclos T7
edit1_p7 = uicontrol(panel7,'Style','edit','String','1','BackgroundColor','white',...
            'HorizontalAlignment','left','Position',[85,50,100,20]);
edit1_p7.Callback = {@NciclosT7};

% Inclinacao T7
edit2_p7 = uicontrol(panel7,'Style','edit','String','0','BackgroundColor','white',...
            'HorizontalAlignment','left','Position',[85,10,100,20]);
edit2_p7.Callback = {@inclinaT7};

        
text_ed2p7 = uicontrol('Parent',panel7,'Style','text','String','%',...
                    'FontSize',10,'Position',[190,8,30,20]);
                
% EDIT TEXT PAINEL 8
% Número de ciclos T8
edit1_p8 = uicontrol(panel8,'Style','edit','String','1','BackgroundColor','white',...
            'HorizontalAlignment','left','Position',[85,50,100,20]);
edit1_p8.Callback = {@NciclosT8};

% inclinacao T8
edit2_p8 = uicontrol(panel8,'Style','edit','String','0','BackgroundColor','white',...
            'HorizontalAlignment','left','Position',[85,10,100,20]);
edit2_p8.Callback = {@inclinaT8};
        
text_ed2p8 = uicontrol('Parent',panel8,'Style','text','String','%',...
                    'FontSize',10,'Position',[190,8,30,20]);


%% FIGURA 2: RESULTADOS GRÁFICOS DA TRAJETÓRIA DE MARCHA

% Figure Container para o Editor de Trajetória de Marcha                
fgait2 = figure('Position',[580 40 680 640],'Toolbar','none',...
                'MenuBar','none');

% Painel pai que contém os paineis filhos
f2_panel = uipanel(fgait2,'Units','pixels','Position',[5,5,673,640]);

f2_panel.BackgroundColor = 'white';  % cor de fundo do painel
f2_panel.Title = 'RESULTADOS TRAJETÓRIA DE MARCHA'; % Título do painel
f2_panel.ForegroundColor = 'blue';                % cor do título do painel
f2_panel.FontSize = 12;               % tamanho da letra da fonte do título
f2_panel.TitlePosition = 'centertop'; % posicao do título do painel

graph_button = uicontrol(f2_panel,'Style','pushbutton','Position',[10,320,100,50],...
                         'String','<html>Gerar <br>Gráficos','FontSize',10,...
                         'Interruptible','on');
graph_button.Callback = {@graf_trajet};

save_button = uicontrol(f2_panel,'Style','pushbutton','Position',[10,200,100,50],...
                         'String','<html>Salvar <br>Trajetória','FontSize',10,...
                         'Interruptible','on');
save_button.Callback = {@save_traj}; 

% clear_button = uicontrol(f2_panel,'Style','pushbutton','Position',[10,50,100,50],...
%                          'String','<html>Limpar <br>dados','FontSize',10,...
%                          'Interruptible','on');
% clear_button.Callback = {@clear_data};

% % eixos para gerar as figuras
% Gráfico de ângulos das juntas em funcao do tempo
global ha1;
ha1 = axes('Parent',f2_panel,'Units','pixels','Position',[170,415,400,185]);
% Gráfico da posicao vertical Y de cada junta em funcao do tempo
global ha2;
ha2 = axes('Parent', f2_panel,'Units','pixels','Position',[170,190,400,185]);
% Animacao de Y em funcao do tempo em cada junta
global ha3;
ha3 = axes('Parent',f2_panel,'Units','pixels','Position',[170,20,400,125]);


% velT4 = Velocidade4();

