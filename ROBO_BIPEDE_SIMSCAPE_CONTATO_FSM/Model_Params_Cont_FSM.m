%% ========== PARAMETROS DO ROBÔ BÍPEDE COM CONTATO - SIMSCAPE ==========%%

close all; clear all; clc;

data_atual = datetime('today','Format','eeee, dd-MMM-yyyy');
%% DESENHO LINK BINARIO PARA OS SEGMENTOS
% dimensions shown in the figure, length (l) and width (w).
l = 20;
w = 2;
d = 1.2;

% Direcao Counter ClockWise para preencher o sólido
A = linspace(-pi/2, pi/2, 50)';
B = linspace(pi/2, 3*pi/2, 50)';

% The holes are drawn in the same order and a single array suffices. 
% The array elements are ordered in a clockwise direction,
% Direcao Clockwise para representar um furo

C = linspace(3*pi/2, -pi/2, 100)';

csRight = [l/2 + w/2*cos(A) w/2*sin(A)];
csLeft = [-l/2 + w/2*cos(B) w/2*sin(B)];


csLeftHole = [-l/2 + d/2*cos(C) d/2*sin(C)];
csRightHole = [l/2 + d/2*cos(C) d/2*sin(C)];
csConnLine = [-l/2 -w/2; +l/2 -w/2];

cs = [csRight; csLeft; csLeftHole; csConnLine; csRightHole];

% figure
% hold on
% axis equal;
% plot(cs(:,1), cs(:,2), 'Color', [0.6 0.6 0.6], 'Marker', '.',...
%      'MarkerSize', 9, 'MarkerEdgecolor', [1 0 0]);


%% PARÂMETROS GEOMÉTRICOS DO SOLO
height_plane = 0.025; % [m]
plane_height = height_plane; % altura do plano do solo [m] --> Y
plane_width  = 3;     % largura do plano do solo [m] ---> Z
plane_length = 50;    % comprimento do plano do solo[m] ---> X
rho_solo     = 2340;  % densidade asfalto [kg/m^3]


%% PARÂMETROS GEOMÉTRICOS E MECÂNICOS DO HAT

% Densidade material do corpo ABS 
rho_ABS = 1040; % [Kg/m^3]

H = 1.72;       % [m] - Altura do robô

HAT.Altura       = 0.16*H;   % Altura do HAT
HAT.Largura      = 0.19*H;   % Largura do HAT - separação entre as pernas
HAT.Profundidade = 0.03*H;   % profundidade do HAT
HAT.Volume       = HAT.Altura*HAT.Largura*HAT.Profundidade;
HAT.Massa        = HAT.Volume*rho_ABS;

% Cross Section para a definir o Sólido Extrudado do HAT - Triângulo fixo
hat_cross_sec = [-HAT.Largura/2, 0; HAT.Largura/2, 0; 0, HAT.Altura];

%% PARÂMETROS GEOMÉTRICOS E MECÂNICOS DOS ELOS

% % ELO COXA (BARRA HOMOGÊNEA QUE GIRA NO EXTREMO: MATERIAL = ABS)
COXA.Comprimento = 0.42; %L_coxa     = 0.42;      % Comprimento Coxa [m]
COXA.Comprimento_CM = 0.21; %L_coxaCM   = 0.21;      % Posicao Centro de Massa Coxa [m]
COXA.Largura = 0.1; %A_coxa     = 0.1;       % Largura da Coxa [m] 
COXA.Profundidade = 0.0057; %P_coxa     = 0.0057;    % Profundidade da Coxa [m]  
COXA.Volume   = 239.4;  % Volume da Coxa [cm^3];
COXA.Massa = COXA.Comprimento*COXA.Largura*COXA.Profundidade*rho_ABS; %massa_coxa = Volume*Densidade
COXA.Inercia = [0.000208154 0 0; 0 0.00386743 0; 0 0 0.00366062];
%Inerc_coxa = 1/3*massa_coxa*L_coxa^2; % momento de inercia barra homogenea-eixo de rotacao no extremo
%===========================================================================================
% % ELO PERNA (BARRA HOMOGÊNEA QUE GIRA NO EXTREMO: MATERIAL = ABS)                                     
PERNA.Comprimento = 0.46;     % L_perna     = 0.46;      % Comprimento Perna [m]
PERNA.Comprimento_CM = 0.23;  % L_pernaCM   = 0.23;      % Posicao Centro de Massa Perna [m]
PERNA.Largura = 0.1;          % A_perna     = 0.1;       % Largura da Perna [m]  
PERNA.Profundidade = 0.0059; % P_perna     = 0.0059;    %  Profundidade da Perna [m]  
PERNA.Volume   = 266.65066;  % vol_perna   = 266.65066; % Volume da Perna [cm^3];
PERNA.Massa = PERNA.Comprimento*PERNA.Largura*PERNA.Profundidade*rho_ABS;% %massa_perna = Volume*Densidade
% Inerc_perna = 1/3*massa_perna*L_perna^2;
%======================================================================================
                                      
% % % ELO PÉ (BARRA HOMOGÊNEA QUE GIRA NO EXTREMO MATERIAL = ABS)
PE.Comprimento = 0.11;   % L_pe = 0.11;   % Comprmimento Pe [m]
PE.Comprimento_CM = PE.Comprimento/2; % L_peCM = L_pe/2; % Posicao Centro de Massa Pe [m]
PE.Largura = 0.08; % A_pe = 0.08;   % Largura do Pe [m]  
PE.Profundidade = 0.012; % P_pe     = 0.012;  %  Profundidade do Pe [m]  
PE.Volume = PE.Comprimento*PE.Largura*PE.Profundidade; % Volume do Pe [m^3];
PE.Massa = PE.Volume*rho_ABS; %Kg
% Inerc_pe = 1/3*massa_pe*L_pe^2;      
%===========================================================================
% COR DOS ELOS DA COXA, DA PERNA E DO PÉ - VETOR RGB
cor_coxa  = [0.5 0.5 0.5];
cor_perna = [0.2 0.2 1];
cor_pe    = [0.4 0.2 0];

%% PARÂMETROS MECÂNICOS DOS BLOCOS DAS JUNTAS
% Simulink PS-Converter Block -> Input filtering time constant (in seconds):

% motion_time_constant = 0.01150;  % Passo de tempo para a V1
% motion_time_constant = 0.006863;  % Passo de tempo para a V2
% motion_time_constant = 0.005952;  % Passo de tempo para a V3
motion_time_constant = 0.005398; % Passo de tempo para a V4

% Internal mechanics -> Joint Revolute Block
Spring_stif_junta = 0;
Damping_junta     = 0;

%% CONDICOES INICIAIS PARA SIMULACAO
              
%%%%%%%%% SELECIONAR VELOCIDADE DE MARCHA PARA SIMULACAO %%%%%%%%%%%
velocidade = 1; % 1 -> V1, 2 -> V2, 3 -> V3, 4 -> V4 

switch velocidade
    
    case 1
%         motion_time_constant = 0.01150;  % Passo de tempo para a V1
        veloc    = Velocidade1();
        % Carrego dados para a Perna Direita
        tempo    = veloc(1).tempo;
        thetaQ_D = veloc(1).thetaq;
        thetaJ_D = veloc(1).thetaj;
        thetaT_D = veloc(1).thetat;
        
        % Carregar vetor de angulos da Perna Direita como ARRAY WITH TIME
        angulos_dir = [tempo thetaQ_D thetaJ_D thetaT_D];
        
        % Condicoes iniciais dos angulos Perna Direita para os Joint Blocks
        thetaQ_D0 =  thetaQ_D(1,1)*(pi/180); % Angulo em Radianos
        thetaJ_D0 = -1*thetaJ_D(1,1)*(pi/180); % Angulo em Radianos
        thetaT_D0 =  thetaT_D(1,1)*(pi/180); % Angulo em Radianos
    
        % Carrego dados para a Perna Esquerda
        thetaQ_E = veloc(2).thetaq;
        thetaJ_E = veloc(2).thetaj;
        thetaT_E = veloc(2).thetat;
        
        % Carregar vetor de angulos da Perna Esquerda como ARRAY WITH TIME
        angulos_esq = [tempo thetaQ_E thetaJ_E thetaT_E];
        
        % Condicoes iniciais dos angulos Perna Esquerda para os Joint
        % blocks
        thetaQ_E0 =  thetaQ_E(1,1)*(pi/180); % Angulo em Radianos
        thetaJ_E0 = -1*thetaJ_E(1,1)*(pi/180); % Angulo em Radianos
        thetaT_E0 =  thetaT_E(1,1)*(pi/180); % Angulo em Radianos
        
        % Tempo de simulacao para simulink
        ts = tempo(end,1);
        
        case 2
%         motion_time_constant = 0.006863;  % Passo de tempo para a V2
%         motion_time_constant = 0.01150;
        veloc = Velocidade2();
        % Carrego dados para a Perna Direita
        tempo    = veloc(1).tempo;
        thetaQ_D = veloc(1).thetaq;
        thetaJ_D = veloc(1).thetaj;
        thetaT_D = veloc(1).thetat;
        
        % Carregar vetor de angulos da Perna Direita como ARRAY WITH TIME
        angulos_dir = [tempo thetaQ_D thetaJ_D thetaT_D];
        
        % Condicoes iniciais dos angulos Perna Direita para os Joint Blocks
        thetaQ_D0 =  thetaQ_D(1,1)*(pi/180); % Angulo em Radianos
        thetaJ_D0 = -1*thetaJ_D(1,1)*(pi/180); % Angulo em Radianos
        thetaT_D0 =  thetaT_D(1,1)*(pi/180); % Angulo em Radianos
    
        % Carrego dados para a Perna Esquerda
        thetaQ_E = veloc(2).thetaq;
        thetaJ_E = veloc(2).thetaj;
        thetaT_E = veloc(2).thetat;
        
        % Carregar vetor de angulos da Perna Esquerda como ARRAY WITH TIME
        angulos_esq = [tempo thetaQ_E thetaJ_E thetaT_E];
        
        % Condicoes iniciais dos angulos Perna Esquerda
        thetaQ_E0 =  thetaQ_E(1,1)*(pi/180); % Angulo em Radianos
        thetaJ_E0 = -1*thetaJ_E(1,1)*(pi/180); % Angulo em Radianos
        thetaT_E0 =  thetaT_E(1,1)*(pi/180); % Angulo em Radianos
        
        % Tempo de simulacao para simulink
        ts = tempo(end,1);
        
        case 3
%         motion_time_constant = 0.005952;  % Passo de tempo para a V3
        veloc    = Velocidade3();
        % Carrego dados para a Perna Direita
        tempo    = veloc(1).tempo;
        thetaQ_D = veloc(1).thetaq;
        thetaJ_D = veloc(1).thetaj;
        thetaT_D = veloc(1).thetat;
        
        % Carregar vetor de angulos da Perna Direita como ARRAY WITH TIME
        angulos_dir = [tempo thetaQ_D thetaJ_D thetaT_D];
        
        % Condicoes iniciais dos angulos Perna Direita para os joint Blocks
        thetaQ_D0 =  thetaQ_D(1,1)*(pi/180); % Angulo em Radianos
        thetaJ_D0 = -1*thetaJ_D(1,1)*(pi/180); % Angulo em Radianos
        thetaT_D0 =  thetaT_D(1,1)*(pi/180); % Angulo em Radianos
    
        % Carrego dados para a Perna Esquerda
        thetaQ_E = veloc(2).thetaq;
        thetaJ_E = veloc(2).thetaj;
        thetaT_E = veloc(2).thetat;
        
        % Carregar vetor de angulos da Perna Esquerda como ARRAY WITH TIME
        angulos_esq = [tempo thetaQ_E thetaJ_E thetaT_E];
        
        % Condicoes iniciais dos angulos Perna Esquerda para os Joint
        % Blocks
        thetaQ_E0 =  thetaQ_E(1,1)*(pi/180); % Angulo em Radianos
        thetaJ_E0 = -1*thetaJ_E(1,1)*(pi/180); % Angulo em Radianos
        thetaT_E0 =  thetaT_E(1,1)*(pi/180); % Angulo em Radianos
        
        % Tempo de simulacao para simulink
        ts = tempo(end,1);
        
        case 4
%         motion_time_constant = 0.005398; % Passo de tempo para a V4
%         motion_time_constant = 0.01150;  % Passo de tempo para a V1
        veloc    = Velocidade4();
        % Carrego dados para a Perna Direita
        tempo    = veloc(1).tempo;
        thetaQ_D = veloc(1).thetaq;
        thetaJ_D = veloc(1).thetaj;
        thetaT_D = veloc(1).thetat;
        
        % Carregar vetor de angulos da Perna Direita como ARRAY WITH TIME
        angulos_dir = [tempo thetaQ_D thetaJ_D thetaT_D];
        
        % Condicoes iniciais dos angulos Perna Direita par aos Joint Blocks
        thetaQ_D0 =  thetaQ_D(1,1)*(pi/180); % Angulo em Radianos
        thetaJ_D0 = -1*thetaJ_D(1,1)*(pi/180); % Angulo em Radianos
        thetaT_D0 =  thetaT_D(1,1)*(pi/180); % Angulo em Radianos
    
        % Carrego dados para a Perna Esquerda
        thetaQ_E = veloc(2).thetaq;
        thetaJ_E = veloc(2).thetaj;
        thetaT_E = veloc(2).thetat;
        
        % Carregar vetor de angulos da Perna Esquerda como ARRAY WITH TIME
        angulos_esq = [tempo thetaQ_E thetaJ_E thetaT_E];
        
        % Condicoes iniciais dos angulos Perna Esquerda para os Joint
        % Blocks
        thetaQ_E0 =  thetaQ_E(1,1)*(pi/180); % Angulo em Radianos
        thetaJ_E0 = -1*thetaJ_E(1,1)*(pi/180); % Angulo em Radianos
        thetaT_E0 =  thetaT_E(1,1)*(pi/180); % Angulo em Radianos
        
        % Tempo de simulacao para simulink
        ts = tempo(end,1);
    
end

% ========== ALTURA INICIAL DO SISTEMA DE REFERÊNCIA DO HAT  ==============
% Altura inicial do Sistema de referência CoG HAT sobre o HAT do robô em Y
% como o sistema de referência é o CoG do HAT, a altura inicial deve
% acrescentar o termo (a_CoG = CoG_y)  em (+Y)
% NOTA: Como o ângulo thetaJ_D0 é considerado sempre (-), por isso no 
% colchete é (+ thetaJ_D0)
CoG_y = 0.091733; % [m] posicao Y do CoG do HAT 

hat_alt_ini = COXA.Comprimento*cos(thetaQ_D0) + PERNA.Comprimento*cos(thetaQ_D0 + thetaJ_D0) +...
    PE.Profundidade + CoG_y;

% hat_alt_ini = COXA.Comprimento*cos(thetaQ_D0) + PERNA.Comprimento*cos(thetaQ_D0 + thetaJ_D0) +...
%     PE.Profundidade*cos(thetaQ_D0 + thetaJ_D0 + thetaT_D0) + CoG_y;
%% PARÂMETROS PARA CALCULAR A FORCA DE CONTATO

% massa total do robô
massa_robo = HAT.Massa + 2*COXA.Massa + 2*PERNA.Massa + 2*PE.Massa;

massa_suporte_apoio = massa_robo;
g = 9.81; %[m/s^2] - aceleracao da gravidade
% transition_width = regiao de transicao - maxima distância penetração
transition_width = 1e-3; 
% contact_stiffness = peso total repouso(N)/maxima distância penetração(m)
contact_stiffness = (massa_suporte_apoio*g)/transition_width;  
% contact_stiffness2 = (massa_suporte_apoio*g)/transition_width;  

% Fator de amortecimento -sistema super amortecido
qsi = 1.5; 
% contact_damping = Comportamento sistema massa-mola-amortecedor
contact_damping = 2*qsi*sqrt(contact_stiffness*massa_suporte_apoio); 
% mu_s = Coeficiente de atrito estático: Interacao asfalto-borracha
mu_s   = 0.8;   
% mu_s = Coeficiente de atrito cinético: menor que o coeficiente estático
mu_k   = 0.6;    
mu_vth = 0.001;   

m_esfera = 1; %[g]
contact_point_radius = 0.0001; %m

%%%%%%%%Here I added Datos maquina de estados%%%%%%%

% ================ VELOCIDADES PERNA DIREITA ==============================

%Dados Velocidade 1 (sheet '0.5 ms') perna direita
% Dados_XY1_D = xlsread('DataBaseXY.xlsx', '0.5ms', 'A4:I403');
  
%Dados Velocidade 2 (sheet '1 ms') perna direita
% Dados_XY2_D = xlsread('DataBaseXY.xlsx','1ms','A4:I403');

%--------------------------------------------------------------------------
%**NOTA: TROQUEI Dados_XY1_D para '0.5 ms' com Dados_XY2_D para '1 ms'

% xlsread('nome_do_arquivo','nome_folha','dado_inicial:dado_final')
%Dados Velocidade 1 (sheet '0.5 ms') perna direita
Dados_XY1_D = xlsread('DataBaseXY.xlsx', '0.5ms', 'A4:I403');
  
%Dados Velocidade 2 (sheet '1 ms') perna direita
Dados_XY2_D = xlsread('DataBaseXY.xlsx','1ms','A4:I403');
%--------------------------------------------------------------------------

%Dados Velocidade 3 (sheet '1.2 ms') perna direita
Dados_XY3_D = xlsread('DataBaseXY.xlsx','1.2ms','A4:I403');

%Dados Velocidade 4 (sheet '1.5 ms') perna direita
Dados_XY4_D = xlsread('DataBaseXY.xlsx','1.5ms','A4:I403');
% ================ VELOCIDADES PERNA ESQUERDA =============================

%Dados Velocidade 1 (sheet '0.5 ms') perna esquerda
%Dados_XY1_E = xlsread('DataBaseXY.xlsx', '0.5ms', 'J4:Q403');

%Dados Velocidade 2 (sheet '1 ms') perna esquerda
%Dados_XY2_E = xlsread('DataBaseXY.xlsx','1ms','J4:Q403');

%--------------------------------------------------------------------------
%**NOTA: TROQUEI Dados_XY1_E para '0.5 ms' com Dados_XY2_E para '1 ms' 
%Dados Velocidade 1 (sheet '0.5 ms') perna esquerda
Dados_XY1_E = xlsread('DataBaseXY.xlsx', '0.5ms', 'J4:Q403');

%Dados Velocidade 2 (sheet '1 ms') perna esquerda
Dados_XY2_E = xlsread('DataBaseXY.xlsx','1ms','J4:Q403');
%--------------------------------------------------------------------------

%Dados Velocidade 3 (sheet '1.2 ms') perna direita
Dados_XY3_E = xlsread('DataBaseXY.xlsx','1.2ms','J4:Q403');

%Dados Velocidade 4 (sheet '1.5 ms') perna direita
Dados_XY4_E = xlsread('DataBaseXY.xlsx','1.5ms','J4:Q403');


% Os dados do arquivo 'DataBaseXY.xlsx' contém os valores para 4 ciclos
% (1 ciclo-> 100 valores) do padrao de marcha para 3 velocidades da perna

% Dados do ciclo 1 da marcha 
cic1 = 1:100;
% Dados do ciclo 2 da marcha
cic2 = 101:200;
% Dados ciclo 3 da marcha
cic3 = 201:300;
% Dados ciclo 4 da marcha
cic4 = 301:400;

ciclo = cic1;

%Tempo de 1 ciclo de marcha
temp = Dados_XY1_D(ciclo,1);

%%%%%%%%%%%%%%%%%%%%%%%  VELOCIDADE 1  DIREITA 0.5 m/s %%%%%%%%%%%%%%%%%%%%

% Posicao em X e Y do QUADRIL DIREITO no referencial inercial
Xq1_D = Dados_XY1_D(ciclo,2);
Yq1_D = Dados_XY1_D(ciclo,3);

% Posicao em X e Y do JOELHO DIREITO no referencial inercial
Xj1_D = Dados_XY1_D(ciclo,4);
Yj1_D = Dados_XY1_D(ciclo,5);

% Posicao em X e Y do TORNOZELO DIREITO no referencial inercial
Xt1_D = Dados_XY1_D(ciclo,6);
Yt1_D = Dados_XY1_D(ciclo,7);

% Velocid, Aceler e Jerk em X e Y TORNOZELO DIREITO no referencial inercial
Vx_t1D  = Calc_Vel(temp,Xt1_D);
Vy_t1D  = Calc_Vel(temp,Yt1_D);
ax_t1D  = Calc_Aceler(temp,Xt1_D);
ay_t1D  = Calc_Aceler(temp,Yt1_D);
jkx_t1D = Calc_Jerk(temp,Xt1_D);
jky_t1D = Calc_Jerk(temp,Yt1_D);

% Posicao em X e Y do PÉ DIREITO no referencial inercial
Xp1_D = Dados_XY1_D(ciclo,8);
Yp1_D = Dados_XY1_D(ciclo,9);

% Velocid, Aceler e Jerk em X e Y DEDAO DIREITO referencial inercial
Vx_p1D  = Calc_Vel(temp,Xp1_D);
Vy_p1D  = Calc_Vel(temp,Yp1_D);
ax_p1D  = Calc_Aceler(temp,Xp1_D);
ay_p1D  = Calc_Aceler(temp,Yp1_D);
jkx_p1D = Calc_Jerk(temp,Xp1_D);
jky_p1D = Calc_Jerk(temp,Yp1_D);


% Posicao em X e Y do DEDAO DIREITO em relacao à referência no QUADRIL
Xpq1_D = Xp1_D - Xq1_D;
Ypq1_D = Yp1_D - Yq1_D;
Xpq1_D = Xpq1_D';
Ypq1_D = Ypq1_D';
    
%%%%%%%%%%%%%%%%%%%%%%%%  VELOCIDADE 2 DIREITA 1 m/s %%%%%%%%%%%%%%%%%%%%%%
% Posicao em X e Y do QUADRIL DIREITO no referencial inercial
Xq2_D = Dados_XY2_D(ciclo,2);
Yq2_D = Dados_XY2_D(ciclo,3);

% Posicao em X e Y do JOELHO DIREITO no referencial inercial
Xj2_D = Dados_XY2_D(ciclo,4);
Yj2_D = Dados_XY2_D(ciclo,5);

% Posicao em X e Y do TORNOZELO DIREITO no referencial inercial
Xt2_D = Dados_XY2_D(ciclo,6);
Yt2_D = Dados_XY2_D(ciclo,7);
% Velocid, Aceler e Jerk em X e Y TORNOZELO DIREITO no referencial inercial
Vx_t2D  = Calc_Vel(temp,Xt2_D);
Vy_t2D  = Calc_Vel(temp,Yt2_D);
ax_t2D  = Calc_Aceler(temp,Xt2_D);
ay_t2D  = Calc_Aceler(temp,Yt2_D);
jkx_t2D = Calc_Jerk(temp,Xt2_D);
jky_t2D = Calc_Jerk(temp,Yt2_D);

% Posicao em X e Y do PÉ DIREITO no referencial inercial
Xp2_D = Dados_XY2_D(ciclo,8);
Yp2_D = Dados_XY2_D(ciclo,9);
% Velocid, Aceler e Jerk em X e Y PÉ DIREITO referencial inercial
Vx_p2D  = Calc_Vel(temp,Xp2_D);
Vy_p2D  = Calc_Vel(temp,Yp2_D);
ax_p2D  = Calc_Aceler(temp,Xp2_D);
ay_p2D  = Calc_Aceler(temp,Yp2_D);
jkx_p2D = Calc_Jerk(temp,Xp2_D);
jky_p2D = Calc_Jerk(temp,Yp2_D);

% Posicao em X e Y do DEDAO DIREITO em relacao à referência no QUADRIL
Xpq2_D = Xp2_D - Xq2_D;
Ypq2_D = Yp2_D - Yq2_D;
Xpq2_D = Xpq2_D';
Ypq2_D = Ypq2_D';

%%%%%%%%%%%%%%%%%%%%%%%  VELOCIDADE 3  DIREITA 1.2 m/s %%%%%%%%%%%%%%%%%%%%
% Posicao em X e Y do QUADRIL DIREITO no referencial inercial
Xq3_D = Dados_XY3_D(ciclo,2);
Yq3_D = Dados_XY3_D(ciclo,3);

% Posicao em X e Y do JOELHO DIREITO no referencial inercial
Xj3_D = Dados_XY3_D(ciclo,4);
Yj3_D = Dados_XY3_D(ciclo,5);

% Posicao em X e Y do TORNOZELO DIREITO no referencial inercial
Xt3_D = Dados_XY3_D(ciclo,6);
Yt3_D = Dados_XY3_D(ciclo,7);
% Velocid, Aceler e Jerk em X e Y TORNOZELO DIREITO no referencial inercial
Vx_t3D  = Calc_Vel(temp,Xt3_D);
Vy_t3D  = Calc_Vel(temp,Yt3_D);
ax_t3D  = Calc_Aceler(temp,Xt3_D);
ay_t3D  = Calc_Aceler(temp,Yt3_D);
jkx_t3D = Calc_Jerk(temp,Xt3_D);
jky_t3D = Calc_Jerk(temp,Yt3_D);

% Posicao em X e Y do PÉ DIREITO no referencial inercial
Xp3_D = Dados_XY3_D(ciclo,8);
Yp3_D = Dados_XY3_D(ciclo,9);
% Velocid, Aceler e Jerk em X e Y PÉ DIREITO referencial inercial
Vx_p3D  = Calc_Vel(temp,Xp3_D);
Vy_p3D  = Calc_Vel(temp,Yp3_D);
ax_p3D  = Calc_Aceler(temp,Xp3_D);
ay_p3D  = Calc_Aceler(temp,Yp3_D);
jkx_p3D = Calc_Jerk(temp,Xp3_D);
jky_p3D = Calc_Jerk(temp,Yp3_D);


% Posicao em X e Y do tornozelo em relacao à referência no quadril
Xpq3_D = Xp3_D - Xq3_D;
Ypq3_D = Yp3_D - Yq3_D;
Xpq3_D = Xpq3_D';
Ypq3_D = Ypq3_D';

%%%%%%%%%%%%%%%%%%%%%%%  VELOCIDADE 4  DIREITA 1.5 m/s %%%%%%%%%%%%%%%%%%%%
% Posicao em X e Y do QUADRIL DIREITO no referencial inercial
Xq4_D = Dados_XY4_D(ciclo,2);
Yq4_D = Dados_XY4_D(ciclo,3);

% Posicao em X e Y do JOELHO DIREITO no referencial inercial
Xj4_D = Dados_XY4_D(ciclo,4);
Yj4_D = Dados_XY4_D(ciclo,5);

% Posicao em X e Y do TORNOZELO DIREITO no referencial inercial
Xt4_D = Dados_XY4_D(ciclo,6);
Yt4_D = Dados_XY4_D(ciclo,7);
% Velocid, Aceler e Jerk em X e Y TORNOZELO DIREITO no referencial inercial
Vx_t4D  = Calc_Vel(temp,Xt4_D);
Vy_t4D  = Calc_Vel(temp,Yt4_D);
ax_t4D  = Calc_Aceler(temp,Xt4_D);
ay_t4D  = Calc_Aceler(temp,Yt4_D);
jkx_t4D = Calc_Jerk(temp,Xt4_D);
jky_t4D = Calc_Jerk(temp,Yt4_D);

% Posicao em X e Y do PÉ DIREITO no referencial inercial
Xp4_D = Dados_XY4_D(ciclo,8);
Yp4_D = Dados_XY4_D(ciclo,9);
% Velocid, Aceler e Jerk em X e Y PÉ DIREITO referencial inercial
Vx_p4D  = Calc_Vel(temp,Xp4_D);
Vy_p4D  = Calc_Vel(temp,Yp4_D);
ax_p4D  = Calc_Aceler(temp,Xp4_D);
ay_p4D  = Calc_Aceler(temp,Yp4_D);
jkx_p4D = Calc_Jerk(temp,Xp4_D);
jky_p4D = Calc_Jerk(temp,Yp4_D);

% Posicao em X e Y do DEDAO em relacao à referência no quadril
Xpq4_D = Xp4_D - Xq4_D;
Ypq4_D = Yp4_D - Yq4_D;
Xpq4_D = Xpq4_D';
Ypq4_D = Ypq4_D';

%%%%%%%%%%%%%%%%%%%%%%%  VELOCIDADE 1  ESQUERDA 0.5 m/s %%%%%%%%%%%%%%%%%%%
% Posicao em X e Y do QUADRIL ESQUERDO no referencial inercial
Xq1_E = Dados_XY1_E(ciclo,1);
Yq1_E = Dados_XY1_E(ciclo,2);

% Posicao em X e Y do JOELHO ESQUERDO no referencial inercial
Xj1_E = Dados_XY1_E(ciclo,3);
Yj1_E = Dados_XY1_E(ciclo,4);

% Posicao em X e Y do TORNOZELO ESQUERDO no referencial inercial
Xt1_E = Dados_XY1_E(ciclo,5);
Yt1_E = Dados_XY1_E(ciclo,6);
% Velocid, Aceler e Jerk em X e Y TORNOZELO ESQUERDO no referencial inercial
Vx_t1E  = Calc_Vel(temp,Xt1_E);
Vy_t1E  = Calc_Vel(temp,Yt1_E);
ax_t1E  = Calc_Aceler(temp,Xt1_E);
ay_t1E  = Calc_Aceler(temp,Yt1_E);
jkx_t1E = Calc_Jerk(temp,Xt1_E);
jky_t1E = Calc_Jerk(temp,Yt1_E);

% Posicao em X e Y do PÉ ESQUERDO no referencial inercial
Xp1_E = Dados_XY1_E(ciclo,7);
Yp1_E = Dados_XY1_E(ciclo,8);
% Velocid, Aceler e Jerk em X e Y PÉ ESQUERDO referencial inercial
Vx_p1E  = Calc_Vel(temp,Xp1_E);
Vy_p1E  = Calc_Vel(temp,Yp1_E);
ax_p1E  = Calc_Aceler(temp,Xp1_E);
ay_p1E  = Calc_Aceler(temp,Yp1_E);
jkx_p1E = Calc_Jerk(temp,Xp1_E);
jky_p1E = Calc_Jerk(temp,Yp1_E);

% Posicao em X e Y do DEDAO ESQUERDO em relacao à referência no QUADRIL
Xpq1_E = Xp1_E - Xq1_E;
Ypq1_E = Yp1_E - Yq1_E;
Xpq1_E = Xpq1_E';
Ypq1_E = Ypq1_E';

%%%%%%%%%%%%%%%%%%%%%%%  VELOCIDADE 2 ESQUERDA 1 m/s %%%%%%%%%%%%%%%%%%%%%%
% Posicao em X e Y do QUADRIL ESQUERDO no referencial inercial
Xq2_E = Dados_XY2_E(ciclo,1);
Yq2_E = Dados_XY2_E(ciclo,2);

% Posicao em X e Y do JOELHO ESQUERDO no referencial inercial
Xj2_E = Dados_XY2_E(ciclo,3);
Yj2_E = Dados_XY2_E(ciclo,4);

% Posicao em X e Y do TORNOZELO ESQUERDO no referencial inercial
Xt2_E = Dados_XY2_E(ciclo,5);
Yt2_E = Dados_XY2_E(ciclo,6);
% Velocid, Aceler e Jerk em X e Y TORNOZELO ESQUERDO no referencial inercial
Vx_t2E  = Calc_Vel(temp,Xt2_E);
Vy_t2E  = Calc_Vel(temp,Yt2_E);
ax_t2E  = Calc_Aceler(temp,Xt2_E);
ay_t2E  = Calc_Aceler(temp,Yt2_E);
jkx_t2E = Calc_Jerk(temp,Xt2_E);
jky_t2E = Calc_Jerk(temp,Yt2_E);

% Posicao em X e Y do PÉ ESQUERDO no referencial inercial
Xp2_E = Dados_XY2_E(ciclo,7);
Yp2_E = Dados_XY2_E(ciclo,8);

% Velocid, Aceler e Jerk em X e Y PÉ ESQUERDO referencial inercial
Vx_p2E  = Calc_Vel(temp,Xp2_E);
Vy_p2E  = Calc_Vel(temp,Yp2_E);
ax_p2E  = Calc_Aceler(temp,Xp2_E);
ay_p2E  = Calc_Aceler(temp,Yp2_E);
jkx_p2E = Calc_Jerk(temp,Xp2_E);
jky_p2E = Calc_Jerk(temp,Yp2_E);

% Posicao em X e Y do DEDAO ESQUERDO em relacao à referência no QUADRIL
Xpq2_E = Xp2_E - Xq2_E;
Ypq2_E = Yp2_E - Yq2_E;
Xpq2_E = Xpq2_E';
Ypq2_E = Ypq2_E';

%%%%%%%%%%%%%%%%%%%%%%%  VELOCIDADE 3 ESQUERDA 1.2 m/s %%%%%%%%%%%%%%%%%%%%
% Posicao em X e Y do QUADRIL ESQUERDO no referencial inercial
Xq3_E = Dados_XY3_E(ciclo,1);
Yq3_E = Dados_XY3_E(ciclo,2);

% Posicao em X e Y do JOELHO ESQUERDO no referencial inercial
Xj3_E = Dados_XY3_E(ciclo,3);
Yj3_E = Dados_XY3_E(ciclo,4);

% Posicao em X e Y do TORNOZELO ESQUERDO no referencial inercial
Xt3_E = Dados_XY3_E(ciclo,5);
Yt3_E = Dados_XY3_E(ciclo,6);
% Velocid, Aceler e Jerk em X e Y TORNOZELO ESQUERDO no referencial inercial
Vx_t3E  = Calc_Vel(temp,Xt3_E);
Vy_t3E  = Calc_Vel(temp,Yt3_E);
ax_t3E  = Calc_Aceler(temp,Xt3_E);
ay_t3E  = Calc_Aceler(temp,Yt3_E);
jkx_t3E = Calc_Jerk(temp,Xt3_E);
jky_t3E = Calc_Jerk(temp,Yt3_E);

% Posicao em X e Y do PÉ ESQUERDO no referencial inercial
Xp3_E = Dados_XY3_E(ciclo,7);
Yp3_E = Dados_XY3_E(ciclo,8);
% Velocid, Aceler e Jerk em X e Y PÉ ESQUERDO referencial inercial
Vx_p3E  = Calc_Vel(temp,Xp3_E);
Vy_p3E  = Calc_Vel(temp,Yp3_E);
ax_p3E  = Calc_Aceler(temp,Xp3_E);
ay_p3E  = Calc_Aceler(temp,Yp3_E);
jkx_p3E = Calc_Jerk(temp,Xp3_E);
jky_p3E = Calc_Jerk(temp,Yp3_E);

% Posicao em X e Y do PONTO CENTRAL DO PÉ ESQUERDO no referencial inercial
Xpc3_E =(Xt3_E + Xp3_E)/2;
Ypc3_E =(Yt3_E + Yp3_E)/2;

% Posicao em X e Y do DEDAO em relacao à referência no QUADRIL
Xpq3_E = Xp3_E - Xq3_E;
Ypq3_E = Yp3_E - Yq3_E;
Xpq3_E = Xpq3_E';
Ypq3_E = Ypq3_E';

%%%%%%%%%%%%%%%%%%%%%%%  VELOCIDADE 4 ESQUERDA 1.5 m/s %%%%%%%%%%%%%%%%%%%%
% Posicao em X e Y do QUADRIL ESQUERDO no referencial inercial
Xq4_E = Dados_XY4_E(ciclo,1);
Yq4_E = Dados_XY4_E(ciclo,2);

% Posicao em X e Y do JOELHO ESQUERDO no referencial inercial
Xj4_E = Dados_XY4_E(ciclo,3);
Yj4_E = Dados_XY4_E(ciclo,4);

% Posicao em X e Y do TORNOZELO ESQUERDO no referencial inercial
Xt4_E = Dados_XY4_E(ciclo,5);
Yt4_E = Dados_XY4_E(ciclo,6);
% Velocid, Aceler e Jerk em X e Y TORNOZELO ESQUERDO no referencial inercial
Vx_t4E  = Calc_Vel(temp,Xt4_E);
Vy_t4E  = Calc_Vel(temp,Yt4_E);
ax_t4E  = Calc_Aceler(temp,Xt4_E);
ay_t4E  = Calc_Aceler(temp,Yt4_E);
jkx_t4E = Calc_Jerk(temp,Xt4_E);
jky_t4E = Calc_Jerk(temp,Yt4_E);

% Posicao em X e Y do PÉ ESQUERDO no referencial inercial
Xp4_E = Dados_XY4_E(ciclo,7);
Yp4_E = Dados_XY4_E(ciclo,8);
% Velocid, Aceler e Jerk em X e Y PÉ ESQUERDO referencial inercial
Vx_p4E  = Calc_Vel(temp,Xp4_E);
Vy_p4E  = Calc_Vel(temp,Yp4_E);
ax_p4E  = Calc_Aceler(temp,Xp4_E);
ay_p4E  = Calc_Aceler(temp,Yp4_E);
jkx_p4E = Calc_Jerk(temp,Xp4_E);
jky_p4E = Calc_Jerk(temp,Yp4_E);

% Posicao em X e Y do DEDAO em relacao à referência no QUADRIL
Xpq4_E = Xp4_E - Xq4_E;
Ypq4_E = Yp4_E - Yq4_E;
Xpq4_E = Xpq4_E';
Ypq4_E = Ypq4_E';

%% CONDICOES INICIAIS PARA AS MALHAS CINEMÁTICAS INVERSAS (APOIO E BALANCO)

% Condicao inicial para a malha cinemática inversa de apoio 1 perna direita
%IC1_ST1 = [deg2rad(25.6131); deg2rad(14.72863)];
IC1_ST1 = [deg2rad(25.6131); deg2rad(14.72863); deg2rad(0.0003041)];

% Condicao inicial malha cinemática inversa de balanco perna esquerda
IC1_SW1 = [deg2rad(-9.8611); deg2rad(25.8751); deg2rad(12.745)];

% Condicao inicial malha cinematica inversa de apoio 2 perna esquerda
IC1_ST2 = [deg2rad(28.3166); deg2rad(21.8674); deg2rad(4.4308)];

% % IC1_D = [deg2rad(25.63780647); deg2rad(14.67898676)];
% % IC1_E = [deg2rad(-9.932508258); deg2rad(24.23145449)];
% % 
% % PtrajD = [0.942200084; 0.831190391] - [1.21137356250691; 0.000929087];
% % 
% % PtrajE = [0.611436117; 0.036865897] - [0.942200084; 0.831190391];
% % 
% % theta_stance = rad2deg(Inv_Kinem_Stance(PtrajD,IC1_D));
% % 


%%%%end of here I added Datos maquina de estados

%% CARREGAR O MODELO DO SIMSCAPE "Robo_Bipede.slx"
robo_bipede_contato = load_system('Robo_Bipede_Contato.slx');
open_system(robo_bipede_contato);