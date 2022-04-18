close all;
clc;

%% CPG BASED CONTROLLER WITH SIX OSCILLATORS AND 12 NEURONS
% neurônios de numeração ÍMPAR representam o FLEXOR (F)
% neurônios de numeração PAR representam o EXTENSOR (E)

S0 = 5;
b = 2.5;

y7 = 0;
y8 = 0;
y11 = 0;
y12 = 0;

%% OSCILADOR 2 (N3=FLEXOR     N4=EXTENSOR)

% Parâmetros NEURÔNIO 3
tr3 = 0.0005;
ta3 = 0.6;

w31 = -1;
w32 = 0;
w34 = -2;
w37 = 0;
w38 = 0;
w3_11 = 0;
w3_12 = 0;

ws3 = 1;
S2 = S0;
b2 = b;
feed3 = 0;

% Parâmetros NEURÔNIO 4
tr4 = 0.05;
ta4 = 0.6;

w42 = -1;
w43 = -2;
w47 = 0;
w48 = 0;
w4_11 = 0;
w4_12 = 0;

ws4 = 1;
% S02 = 1;
% b2 = 2.5;
feed4 = 0;

%% OSCILADOR 1 (N1=FLEXOR     N2=EXTENSOR)

% Parâmetros NEURÔNIO 1
% tr1 = 0.0005;
tr1 = 0.0004;
% ta1 = 0.6;
ta1 = 0.04;

% w12 = -2;
w12 = -2.64;
% w13 = -1;
w13 = -1.7585;
w15 = 0;
w16 = 0;
w19 = 0;
w1_10 = 0;

ws1 = 1;
% S1 = 5;
S1 = 50;
% b1 = 2.5;
b1 = 14.786;
feed1 = 0;


% Parâmetros NEURÔNIO 2
tr2 = 0.1;
ta2 = 20;

w21 = -2;
w24 = -1;
w25 = 0;
w26 = 0;
w29 = 0;
w2_10 = 0;

ws2 = 1;
% S1 = 1;
% b1 = 2.5;
feed2 = 0;


%% OSCILADOR 3 (N5=FLEXOR     N6=EXTENSOR)

% Parâmetros NEURÔNIO 5
tr5 = 0.025;
ta5 = 0.3;

w51 = 0;
w52 = 0;
w56 = -2;
w59 = 0;
w5_10 = 0;

ws5 = 1;
S3 = S0;
b3 = b;
feed5 = 0;

% Parâmetros NEURÔNIO 6
tr6 = 0.025;
ta6 = 0.3;

w61 = -1;
w62 = -1;
w65 = -2;
w69 = 0;
w6_10 = 0;

ws6 = 1;
% S3 = 1;
% b3 = 2.5;
feed6 = 0;



%% OSCILADOR 5 (N9 = FLEXOR     N10 = EXTENSOR)

% Parâmetros NEURÔNIO 9
tr9 = 0.025;
ta9 = 0.3;

w91 = 0;
w92 = 0;
w95 = -0.5;
w96 = -0.5;
w9_10 = -2;

ws9 = 1;
S5 = S0;
b5 = b;
feed9 = 0;

% Parâmetros NEURÔNIO 10
tr10 = 0.025;
ta10 = 0.3;

w10_1 = -1;
w10_2 = -1;
w10_5 = 0;
w10_6 = 0;
w10_9 = -2;

ws10 = 1;
% S5 = 1;
% b5 = 2.5;
feed10 = 0;


%%  %%%%%%% SELECIONAR VELOCIDADE DE MARCHA PARA SIMULACAO %%%%%%%%%%%
velocidade = 4; % 1 -> V1, 2 -> V2, 3 -> V3, 4 -> V4 

switch velocidade
    
    case 1
        veloc    = Velocidade1();
        % Carrego dados para a Perna Direita
        tempo    = veloc(1).tempo;
        thetaQ_D = veloc(1).thetaq;
        thetaJ_D = veloc(1).thetaj;
        thetaT_D = veloc(1).thetat;
              
        % Condicoes iniciais dos angulos Perna Direita para os Joint Blocks
        thetaQ_D0 =  thetaQ_D(1,1)*(pi/180); % Angulo em Radianos
        thetaJ_D0 = -1*thetaJ_D(1,1)*(pi/180); % Angulo em Radianos
        thetaT_D0 =  thetaT_D(1,1)*(pi/180); % Angulo em Radianos
    
        % Carrego dados para a Perna Esquerda
        thetaQ_E = veloc(2).thetaq;
        thetaJ_E = veloc(2).thetaj;
        thetaT_E = veloc(2).thetat;
        
        % Condicoes iniciais dos angulos Perna Esquerda para os Joint
        % blocks
        thetaQ_E0 =  thetaQ_E(1,1)*(pi/180); % Angulo em Radianos
        thetaJ_E0 = -1*thetaJ_E(1,1)*(pi/180); % Angulo em Radianos
        thetaT_E0 =  thetaT_E(1,1)*(pi/180); % Angulo em Radianos
        
        % Tempo de simulacao para simulink
        ts = tempo(end,1);
        
        case 2
        veloc = Velocidade2();
        % Carrego dados para a Perna Direita
        tempo    = veloc(1).tempo;
        thetaQ_D = veloc(1).thetaq;
        thetaJ_D = veloc(1).thetaj;
        thetaT_D = veloc(1).thetat;
        
        % Condicoes iniciais dos angulos Perna Direita para os Joint Blocks
        thetaQ_D0 =  thetaQ_D(1,1)*(pi/180); % Angulo em Radianos
        thetaJ_D0 = -1*thetaJ_D(1,1)*(pi/180); % Angulo em Radianos
        thetaT_D0 =  thetaT_D(1,1)*(pi/180); % Angulo em Radianos
    
        % Carrego dados para a Perna Esquerda
        thetaQ_E = veloc(2).thetaq;
        thetaJ_E = veloc(2).thetaj;
        thetaT_E = veloc(2).thetat;
        
        % Condicoes iniciais dos angulos Perna Esquerda
        thetaQ_E0 =  thetaQ_E(1,1)*(pi/180); % Angulo em Radianos
        thetaJ_E0 = -1*thetaJ_E(1,1)*(pi/180); % Angulo em Radianos
        thetaT_E0 =  thetaT_E(1,1)*(pi/180); % Angulo em Radianos
        
        case 3
        veloc    = Velocidade3();
        % Carrego dados para a Perna Direita
        tempo    = veloc(1).tempo;
        thetaQ_D = veloc(1).thetaq;
        thetaJ_D = veloc(1).thetaj;
        thetaT_D = veloc(1).thetat;
        
        % Condicoes iniciais dos angulos Perna Direita para os joint Blocks
        thetaQ_D0 =  thetaQ_D(1,1)*(pi/180); % Angulo em Radianos
        thetaJ_D0 = -1*thetaJ_D(1,1)*(pi/180); % Angulo em Radianos
        thetaT_D0 =  thetaT_D(1,1)*(pi/180); % Angulo em Radianos
    
        % Carrego dados para a Perna Esquerda
        thetaQ_E = veloc(2).thetaq;
        thetaJ_E = veloc(2).thetaj;
        thetaT_E = veloc(2).thetat;
        
        % Condicoes iniciais dos angulos Perna Esquerda para os Joint
        % Blocks
        thetaQ_E0 =  thetaQ_E(1,1)*(pi/180); % Angulo em Radianos
        thetaJ_E0 = -1*thetaJ_E(1,1)*(pi/180); % Angulo em Radianos
        thetaT_E0 =  thetaT_E(1,1)*(pi/180); % Angulo em Radianos
        
        case 4
        veloc    = Velocidade4();
        % Carrego dados para a Perna Direita
        tempo    = veloc(1).tempo;
        thetaQ_D = veloc(1).thetaq;
        thetaJ_D = veloc(1).thetaj;
        thetaT_D = veloc(1).thetat;
        
        % Condicoes iniciais dos angulos Perna Direita par aos Joint Blocks
        thetaQ_D0 =  thetaQ_D(1,1)*(pi/180); % Angulo em Radianos
        thetaJ_D0 = -1*thetaJ_D(1,1)*(pi/180); % Angulo em Radianos
        thetaT_D0 =  thetaT_D(1,1)*(pi/180); % Angulo em Radianos
    
        % Carrego dados para a Perna Esquerda
        thetaQ_E = veloc(2).thetaq;
        thetaJ_E = veloc(2).thetaj;
        thetaT_E = veloc(2).thetat;
        
        % Condicoes iniciais dos angulos Perna Esquerda para os Joint
        % Blocks
        thetaQ_E0 =  thetaQ_E(1,1)*(pi/180); % Angulo em Radianos
        thetaJ_E0 = -1*thetaJ_E(1,1)*(pi/180); % Angulo em Radianos
        thetaT_E0 =  thetaT_E(1,1)*(pi/180); % Angulo em Radianos
    
end

thetaQD = timeseries(thetaQ_D, tempo);
thetaJD = timeseries(thetaJ_D, tempo);
thetaTD = timeseries(thetaT_D, tempo);
thetaQE = timeseries(thetaQ_E, tempo);

%% Oscilador Quadril Esquerdo
oscQE4(:,1) = SDOSimTest_Log.oscQE.Time;
oscQE4(:,2) = SDOSimTest_Log.oscQE.Data;
writematrix(oscQE4, 'oscQE4_b0.txt', 'Delimiter', '\t');