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
% motion_time_constant = 0.005398; % Passo de tempo para a V4

% Internal mechanics -> Joint Revolute Block
Spring_stif_junta = 0;
Damping_junta     = 0;

%% CONDICOES INICIAIS PARA SIMULACAO
              
%%%%%%%%% SELECIONAR VELOCIDADE DE MARCHA PARA SIMULACAO %%%%%%%%%%%
velocidade = 3; % 1 -> V1, 2 -> V2, 3 -> V3, 4 -> V4 

switch velocidade
    
    case 1
        motion_time_constant = 0.01150;  % Passo de tempo para a V1
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
        motion_time_constant = 0.006863;  % Passo de tempo para a V2
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
        motion_time_constant = 0.005952;  % Passo de tempo para a V3
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
        motion_time_constant = 0.005398; % Passo de tempo para a V4
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

%% CARREGAR O MODELO DO SIMSCAPE "Robo_Bipede.slx"
robo_bipede_contato = load_system('Robo_Bipede_Contato.slx');
open_system(robo_bipede_contato);