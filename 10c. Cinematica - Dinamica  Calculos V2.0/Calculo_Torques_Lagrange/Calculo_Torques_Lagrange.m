%% SCRIPT PARA O CALCULO DOS TORQUES DAS JUNTAS DO ROBO  
% FASES DE BALANCO 3 DoF E FASE DE APOIO 4 DoF

% Aluno: Luis Miguel Córdoba
% Orientador: Joao Maurício Rosário
% DOUTORADO EM ENGENHARIA MECANICA -  FEM UNICAMP 2021

close all;
clear all;
clc;
%% PROPRIEDADES MECANINCAS DOS LINKS DO ROBO

material = 5; % ABS
% = 1-> Aço -ASTM F 138      = 2-> Aço -ISO 5832-9    = 3-> Co-Cr -ASTM F75
% = 4-> Titânio Ti-6Al-4V    = 5-> ABS                = 6-> PLA
% = 7-> PMMA                 = 8-> Alumínio - 6061    = 9-> Aço - 1020
densidade = selecionar_material(material); % Densidade em [kg/m^3]

g = -9.81; % Aceleracao da gravidade na direcao de Y no Referencial Inercial

%Altura do robô
H = 1.72;       % [m]

% PARÂMETROS LINK HAT (Head - Arm - Trunk) - TRIÂNGULO FIXO, MATERIAL ABS

HAT.Altura       = 0.16*H;   % Altura do HAT
HAT.Largura      = 0.19*H;   % Largura do HAT - separação entre as pernas
HAT.Profundidade = 0.03*H;   % profundidade do HAT
HAT.Volume       = HAT.Altura*HAT.Largura*HAT.Profundidade;
HAT.Massa        = HAT.Volume*densidade;
HAT.CoM          = [0, 0.0917333, 0]; % [kg.m^2]
HAT.Inercia      =  2.*[0.0106887, 0, 0; 0, 0.0112737, 0; 0, 0, 0.0208916]; % [kg.m^2]
% Izz = (COXA.Massa/12)*(COXA.Largura^2+4*COXA.Comprimento^2)

% PARÂMETROS LINK COXA (BARRA HOMOGÊNEA QUE GIRA NO EXTREMO: MATERIAL ABS)
COXA.Comprimento    = 0.42; % Comprimento Coxa [m]
COXA.Comprimento_CM = 0.21; % Posicao Centro de Massa Coxa [m]
COXA.Largura        = 0.1; % Largura da Coxa [m] 
COXA.Profundidade   = 0.0057; % Profundidade da Coxa [m]  
COXA.Volume         = 239.4; % Volume da Coxa [cm^3];
COXA.Massa          = COXA.Comprimento*COXA.Largura*COXA.Profundidade*densidade; % [Kg]
COXA.CoM            = [0, 0.108933, 0];
COXA.Inercia        = [0.000208154 0 0; 0 0.00386743 0; 0 0 0.00366062]; % [kg.m^2]

% PARÂMETROS LINK PERNA (BARRA HOMOGÊNEA QUE GIRA NO EXTREMO: MATERIAL ABS)
PERNA.Comprimento      = 0.46;      % Comprimento Perna [m]
PERNA.Comprimento_CM   = 0.23;      % Posicao Centro de Massa Perna [m]
PERNA.Largura          = 0.1;       % Largura da Perna [m]  
PERNA.Profundidade     = 0.0059;    % Profundidade da Perna [m]  
PERNA.Volume           = 266.65066; % Volume da Perna [cm^3];
PERNA.Massa            = PERNA.Comprimento*PERNA.Largura*PERNA.Profundidade*densidade; % [kg.m^2]
PERNA.Inercia          = [0.000236032 0 0; 0 0.00521233 0; 0 0 0.00497793];

% PARÂMETROS LINK PE (BARRA HOMOGÊNEA QUE GIRA NO EXTREMO MATERIAL ABS)
PE.Comprimento    = 0.11;   % Comprimento Pe [m]
PE.Comprimento_CM = PE.Comprimento/2; % Posicao Centro de Massa Pe [m]
PE.Largura        = 0.08;  % Largura do Pe [m]  
PE.Profundidade   = 0.012; %  Profundidade do Pe [m]  
PE.Volume         = PE.Comprimento*PE.Largura*PE.Profundidade; % Volume do Pe [m^3];
PE.Massa          = PE.Volume*densidade; % [Kg]
PE.Inercia        = [5.98907e-05 0 0; 0 0.000169312 0; 0 0 0.000112057]; % [kg.m^2]

% MASSA TOTAL DO ROBO
massa_robo = HAT.Massa + 2*COXA.Massa + 2*PERNA.Massa + 2*PE.Massa;

%% SELECIONO A VELOCIDADE PADRAO DA MARCHA
velocidade = 4; % 1 -> V1, 2 -> V2, 3 -> V3, 4 -> V4 

switch velocidade
    
    case 1
        veloc = Velocidade1();
        FcontD = readmatrix('Fcont_D_V1.txt');
        FcontE = readmatrix('Fcont_E_V1.txt');
    case 2
        veloc = Velocidade2();
        FcontD = readmatrix('Fcont_D_V2.txt');
        FcontE = readmatrix('Fcont_E_V2.txt');
    case 3
        veloc = Velocidade3();
        FcontD = readmatrix('Fcont_D_V3.txt');
        FcontE = readmatrix('Fcont_E_V3.txt');
    case 4
        veloc = Velocidade4();
        FcontD = readmatrix('Fcont_D_V4.txt');
        FcontE = readmatrix('Fcont_E_V4.txt');
end

% CALCULOS DOS COEFICIENTES DA MATRIZ DE INERCIA D(q), SIMBOLOS DE CHRISTOFFEL (C(q,q_p)) E
% COMPONENTES DA DERIVADA DA ENERGIA POTENCIAL (g(q)) PARA A FASE DE BALANCO
[Db, Cb, Gb] = coeficientes_balanco(COXA,PERNA,PE,veloc,g);

% CALCULOS DOS COEFICIENTES DA MATRIZ DE INERCIA D(q), SIMBOLOS DE CHRISTOFFEL (C(q,q_p)) E
% COMPONENTES DA DERIVADA DA ENERGIA POTENCIAL (g(q)) PARA A FASE DE APOIO COM 3 DoF
[Dap, Cap, Gap] = coeficientes_apoio_3GL(HAT,COXA,PERNA,PE,veloc,g);  %**

% CALCULOS DOS COEFICIENTES DA MATRIZ DE INERCIA D(q), SIMBOLOS DE CHRISTOFFEL (C(q,q_p)) E
% COMPONENTES DA DERIVADA DA ENERGIA POTENCIAL (g(q)) PARA A FASE DE APOIO COM 4 DoF
[Da, Ca, Ga] = coeficientes_apoio_4GL(HAT,COXA,PERNA,PE,veloc,g);


% VELOCIDADE E ACELERACAO DAS TRAJETORIAS DAS JUNTAS DO ROBO
[derivadas_Q, derivadas_J, derivadas_T] = Calcular_Vel_Acel(veloc);

% MATRIZ JACOBIANA PARA A FASE DE BALANCO
J_B =  Jacobiano_Balanco(HAT,COXA,PERNA,PE,veloc);

% MATRIZ JACOBIANA PARA A FASE DE APOIO COM 3 DoF (QUADRIL, JOELHO, TORNOZELO)
J_A3 =  Jacobiano_Apoio_3GL(HAT,COXA,PERNA,PE,veloc);

% MATRIZ JACOBIANA PARA A FASE DE APOIO COM 4 DoF (QUADRIL, JOELHO, TORNOZELO, DEDAO)
J_A4 =  Jacobiano_Apoio_4GL(HAT,COXA,PERNA,PE,veloc);

% % ------------------------------------------------------------------------
% FORCA DE REACAO TANGENCIAL E VERTICAL NORMALIZADAS PELA MASSA DO ROBO
forca_vert = xlsread('Forca_Reacao_1ms.xlsx', 'ForcaVertical', 'A1:B100');
forca_tang = xlsread('Forca_Reacao_1ms.xlsx', 'ForcaTangencial', 'A1:B100');

% COMPONENTES DAS FORCA DE REACAO DO SOLO - TEÓRICO

% Componente em X - Tangencial da Forca de Reacao 
frx_teo = 14*massa_robo.*forca_tang(:,2);
% Componente em Y - Vertical da Forca de Reacao 
fry_teo = 8*massa_robo.*forca_vert(:,2);
% Componente em Z - Tangencial da Forca de Reacao 
frz_teo = zeros(size(frx_teo));
% % -----------------------------------------------------------------------

increm = round(size(FcontD,1)/100)+1;
window = 10;
tr   = FcontD(1:increm:end, 1);
frx  = FcontD(1:increm:end, 3);
frxE = FcontE(1:increm:end, 3);

% Elimina outliers frx Perna Direita
[frx_cleaned,outlierIndices,thresholdLow,thresholdHigh] = filloutliers(frx,...
    'linear','movmean',1.016,'SamplePoints',tr);

% Smooth input data frx_cleaned Perna Direita
frx_smooth = smoothdata(frx_cleaned,'gaussian','SmoothingFactor',0.2,...
    'SamplePoints',tr);

% Elimina outliers frx Perna Esquerda
[frxE_cleaned,outlierIndicesE,thresholdLowE,thresholdHighE] = filloutliers(frxE,...
    'linear','movmean',1.016,'SamplePoints',tr);

% Smooth input data frxE_cleaned Perna Esquerda
frxE_smooth = smoothdata(frxE_cleaned,'gaussian','SmoothingFactor',0.2,...
    'SamplePoints',tr);

window2 = 15;
fry  = FcontD(1:increm:end, 2);
fryE = FcontE(1:increm:end, 2);

% Elimina outliers Fry Perna Direita
[fry_cleaned,outlierIndices2,thresholdLow2,thresholdHigh2] = filloutliers(fry,...
    'linear','movmean',3.011,'SamplePoints',tr);

% % Smooth input data Perna Direita
fry_smooth = smoothdata(fry_cleaned,'gaussian','SmoothingFactor',0.2,...
    'SamplePoints',tr);

% Elimina outliers Fry Perna Esquerda
[fryE_cleaned,outlierIndices2E,thresholdLow2E,thresholdHigh2E] = filloutliers(fryE,...
    'linear','movmean',3.011,'SamplePoints',tr);

% % Smooth input data Perna Esquerda
fryE_smooth = smoothdata(fryE_cleaned,'gaussian','SmoothingFactor',0.2,...
    'SamplePoints',tr);

frz = zeros(size(frx));

% COMPONENTES DOS TORQUES DE REACAO APLICADOS NA PLANTA DO PE
nx = 0;
ny = 0;
nz = 0;

% VETOR DE FORCA/TORQUE DE REACAO DA PERNA DIREITA
 Fr = [frx_smooth; fry_smooth; frz; nx; ny; nz];
 
 t = veloc(1).tempo;
%------------------------------------------------------------------------
% GRÁFICO COMPARACAO FORCA DE REACAO TANGENCIAL SIMSCAPE, DADOS BIOMECANICA
figure('Name','Forca de Reacao em X')
plot(tr, frx_smooth,'Color',[237 177 32]/255,'LineWidth',1.5, 'DisplayName',...
    'Fr_x Modelagem SimScape')
hold on
plot(t, frx_teo, 'b-', 'Linewidth', 1.5, 'DisplayName', 'Fr_x Dados Biomecânica')
hold off
xlabel('t(s)')
ylabel('Força Tangencial (N)')
axis tight
ax = gca;
ax.FontSize = 12;
lgd = legend;
lgd.FontSize = 12;
% legend('Frx Modelagem SimScape','Frx modelagem Teórica', 'FontSize', 12)
title('Força de reação tangencial para V = 1 m/s', 'FontSize', 13)

% GRÁFICO COMPARACAO FORCA DE REACAO VERTICAL SIMSCAPE, DADOS BIOMECANICA
figure('Name', 'Forca de Reacao em Y')
plot(tr, fry_smooth, 'Color', [237 177 32]/255, 'LineWidth',1.5, 'DisplayName',...
    'Fr_y Modelagem SimScape')
hold on
plot(t, fry_teo, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Fr_y Dados Biomecânica')
hold off
xlabel('t(s)')
ylabel('Força Vertical (N)')
ax = gca;
ax.FontSize = 12;
axis tight
lgd = legend;
lgd.FontSize = 12;
title('Força de reação vertical para V = 1 m/s', 'Fontsize', 13)

for i = 1:size(frx_smooth,1)
    mu(i,1) = frx_smooth(i)/fry_smooth(i);
    if (frx_smooth(i) == 0 && fry_smooth(i) == 0) 
        mu(i,1) = 0/0;
    end
end

% GRÁFICO COEFICIENTE DE ATRITO DISPONÍVEL \mu_availabe
figure('Name', 'Coeficiente de atrito disponível \mu')

tiledlayout(2,1) % Comando para criar um array de figures
ax1 = nexttile;
plot(ax1, tr, fry_smooth, 'Color', [237 177 32]/255,'LineStyle', '-.', 'LineWidth',1.5,...
    'DisplayName','Fr_y')
hold on
plot(ax1, tr, frx_smooth,'b-.','LineWidth',1.5, 'DisplayName', 'Fr_x')
hold off
ax1.FontSize = 12;
lgd = legend;
lgd.FontSize = 12;
lgd.Location = 'best';
title(ax1,'Força de Contato Vertical e Tangencial')
ylabel(ax1, 'F(N)')
xlabel(ax1, 't_{ciclo}(s)')

ax2 = nexttile;
plot(ax2, tr, mu, 'k-', 'Linewidth', 1.5)
ax2.FontSize = 12;
title(ax2, 'Coeficiente de atrito disponível \mu_a')
ylabel(ax2, '\mu_a', 'FontSize', 13)
xlabel(ax2, 't_{apoio}(s)')
%% TORQUES NA FASE DE BALANCO E APOIO COM 3DoF E 4 DoF SEM FORCA DE REACAO
% TORQUES DAS JUNTAS PARA A FASE DE BALANCO 3 DoF (TORNOZELO, JOELHO E QUADRIL)
[torque_Qb, torque_Jb, torque_Tb] = torques_balanco(Db,Cb,Gb,derivadas_Q,derivadas_J,derivadas_T);

% TORQUES DAS JUNTAS PARA A FASE DE APOIO COM 3 DoF (TORNOZELO, JOELHO E QUADRIL)
[torque_Qap, torque_Jap, torque_Tap] = torques_apoio_3GL(Dap,Cap,Gap,derivadas_Q,derivadas_J, derivadas_T);

% TORQUES DAS JUNTAS PARA A FASE DE APOIO COM 4 DoF (DEDAO, TORNOZELO, JOELHO, QUADRIL)
[torque_Qa,torque_Ja,torque_Ta,torque_Da] = torques_apoio_4GL(Da,Ca,Ga,derivadas_Q,derivadas_J, derivadas_T);


%% TORQUES NA FASE DE BALANCO E APOIO COM 3DoF E 4 DoF CONSIDERANDO FORCA DE REACAO

% TORQUES DAS JUNTAS PARA A FASE DE BALANCO CONSIDERANDO FORCA DE REACAO
[tor_Qbr, tor_Jbr, tor_Tbr] = torques_balanco_reacao(Db,Cb,Gb,derivadas_Q,...
    derivadas_J,derivadas_T,J_B,Fr);


% TORQUES DAS JUNTAS PARA A FASE DE APOIO COM 3 DoF CONSIDERANDO FORCA DE REACAO
[tor3_Qar,tor3_Jar,tor3_Tar] = torques_apoio_reacao_3GL(Dap,Cap,Gap,derivadas_Q,...
    derivadas_J, derivadas_T,J_A3,Fr);


% TORQUES DAS JUNTAS PARA A FASE DE APOIO COM 4 DoF CONSIDERANDO FORCA DE REACAO
[tor4_Qar,tor4_Jar,tor4_Tar,tor4_Dar] = torques_apoio_reacao_4GL(Da,Ca,Ga,derivadas_Q,...
    derivadas_J, derivadas_T,J_A4,Fr);

% Tempo do ciclo de marcha da Velocidade Padrao da marcha selecionada

switch velocidade
    case 1
        tauV1_reacEL = [t, tor_Qbr, tor_Jbr, tor_Tbr]; 
        writematrix(tauV1_reacEL, 'tauV1_reacEL.txt', 'Delimiter', '\t');
    case 2
        tauV2_reacEL = [t, tor_Qbr, tor_Jbr, tor_Tbr];
        writematrix(tauV2_reacEL,'tauV2_reacEL.txt', 'Delimiter', '\t');
    case 3
        tauV3_reacEL = [t, tor_Qbr, tor_Jbr, tor_Tbr];
        writematrix(tauV3_reacEL, 'tauV3_reacEL.txt', 'Delimiter', '\t');
    case 4
        tauV4_reacEL = [t, tor_Qbr, tor_Jbr, tor_Tbr];
        writematrix(tauV4_reacEL,'tauV4_reacEL.txt', 'Delimiter', '\t');
end
% ----------------------------------------------------------------------- %    
% GRÁFICOS DOS TORQUES DAS JUNTAS PARA A FASE DE BALANCO (SEM REACAO)
graficos_torques = 1;

if graficos_torques == 1
    
figure('Name', 'TORQUES FASE DE BALANCO')
    subplot(3,1,1)
    plot(t, torque_Qb,'r','LineWidth',1.5)
    aex = gca;
    aex.FontSize = 13;
    leg = legend('Torque Quadril Balanco');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    ylabel('Torque [N.m]');
    
    subplot(3,1,2)
    plot(t, torque_Jb,'b','LineWidth',1.5)
    aex = gca;
    aex.FontSize = 13;
    leg = legend('Torque Joelho Balanco');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    ylabel('Torque [N.m]');

    subplot(3,1,3)
    plot(t, torque_Tb,'m','LineWidth',1.5)
    aex = gca;
    aex.FontSize = 13;
    leg = legend('Torque Tornozelo Balanco');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    xlabel('t [sec]'); 
    ylabel('Torque [N.m]');

    t2 = suptitle('Torques da Perna Direita na Fase de Balanco');
    t2.Color = 'blue';
   
% GRÁFICOS DOS TORQUES DAS JUNTAS PARA A FASE DE BALANCO CONSIDERANDO FORCA DE REACAO
figure('Name', 'TORQUES FASE DE BALANCO COM REACAO')
    subplot(3,1,1)
    plot(t, tor_Qbr,'r','LineWidth',1.5)
    aex = gca;
    aex.FontSize = 13;
%     leg = legend('Torque Quadril Balanco Reacao');
%     leg.Location = 'northeastoutside';
%     leg.FontSize = 12;
   ylabel('Torque Quadril  [N.m]', 'FontSize', 9);
    
    subplot(3,1,2)
    plot(t, tor_Jbr,'b','LineWidth',1.5)
    aex = gca;
    aex.FontSize = 13;
    ylabel('Torque Joelho  [N.m]', 'FontSize', 9);

    subplot(3,1,3)
    plot(t, tor_Tbr,'m','LineWidth',1.5)
    aex = gca;
    aex.FontSize = 13;
    xlabel('t [s]', 'FontSize', 10); 
    ylabel('Torque Tornozelo  [N.m]', 'FontSize', 9);

    t2_1 = suptitle('Torques da Perna Direita na Fase de Balanco com Reacao');
    t2_1.Color = 'blue';
% ----------------------------------------------------------------------- %    
    
% GRÁFICOS DOS TORQUES DAS JUNTAS PARA A FASE DE APOIO 3 DoF (SEM REACAO)
figure('Name', 'TORQUES FASE DE APOIO 3DoF')
    subplot(3,1,1)
    plot(t, torque_Qap,'r','LineWidth',1.5)
    grid on
    aex = gca;
    aex.FontSize = 13;
    leg = legend('Torque Quadril Apoio 3 DoF');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    ylabel('Torque [N.m]');
    
    subplot(3,1,2)
    plot(t, torque_Jap,'b','LineWidth',1.5)
    grid on
    aex = gca;
    aex.FontSize = 13;
    leg = legend('Torque Joelho Apoio 3 DoF');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    ylabel('Torque [N.m]');
 
    subplot(3,1,3)
    plot(t, torque_Tap,'m','LineWidth',1.5)
    aex = gca;
    aex.FontSize = 13;
    leg = legend('Torque Tornozelo Apoio 3 DoF');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    ylabel('Torque [N.m]');
    
    t3 = suptitle('Torques da Perna Direita na Fase de Apoio com 3 DoF');
    t3.Color = 'blue'; 
    
% GRÁFICOS DOS TORQUES DAS JUNTAS PARA A FASE DE APOIO 3 DoF COM FORCA DE REACAO
figure('Name', 'TORQUES FASE DE APOIO 3DoF COM REACAO')
    subplot(3,1,1)
    plot(t, tor3_Qar,'r','LineWidth',1.5)
    grid on
    aex = gca;
    aex.FontSize = 13;
    leg = legend('Torque Quadril Apoio 3 DoF Reacao');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    ylabel('Torque [N.m]');
    
    subplot(3,1,2)
    plot(t, tor3_Jar,'b','LineWidth',1.5)
    grid on
    aex = gca;
    aex.FontSize = 13;
    leg = legend('Torque Joelho Apoio 3 DoF Reacao');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    ylabel('Torque [N.m]');
 
    subplot(3,1,3)
    plot(t, tor3_Tar,'m','LineWidth',1.5)
    aex = gca;
    aex.FontSize = 13;
    leg = legend('Torque Tornozelo Apoio 3 DoF Reacao');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    ylabel('Torque [N.m]');
    
    t3r = suptitle('Torques da Perna Direita na Fase de Apoio com 3 DoF com Reacao');
    t3r.Color = 'blue';
% % ----------------------------------------------------------------------- %    
% 
% % GRÁFICOS DOS TORQUES DAS JUNTAS PARA A FASE DE APOIO 4 DoF (SEM REACAO)
figure('Name', 'TORQUES FASE DE APOIO 4 DoF')
    subplot(3,1,1)
    plot(t, torque_Qa,'r','LineWidth',1.5)
    grid on
    aex = gca;
    aex.FontSize = 13;
    leg = legend('Torque Quadril Apoio');
    leg.Location = 'northeastoutside';
    leg.FontSize = 9;
    ylabel('Torque [N.m]');

    subplot(3,1,2)
    plot(t, torque_Ja,'b','LineWidth',1.5)
    grid on
    aex = gca;
    aex.FontSize = 13;
    leg = legend('Torque Joelho Apoio');
    leg.Location = 'northeastoutside';
    leg.FontSize = 9;
    ylabel('Torque [N.m]');

    subplot(3,1,3)
    plot(t, torque_Ta,'m','LineWidth',1.5)
    hold on
    plot(t, torque_Da,'g--','LineWidth',1.5)
    hold off
    grid on
    aex = gca;
    aex.FontSize = 13;
    leg = legend('Torque Tornozelo Apoio','Torque Dedao Apoio');
    leg.Location = 'northeastoutside';
    leg.FontSize = 9;
    ylabel('Torque [N.m]');
    
    t4 = suptitle('Torques da Perna Direita na Fase de Apoio com 4 DoF');
    t4.Color = 'blue';
% 
% % GRÁFICOS DOS TORQUES DAS JUNTAS PARA A FASE DE APOIO 4 DoF COM A FORCA DE REACAO
figure('Name', 'TORQUES FASE DE APOIO 4 DoF COM REACAO')
    subplot(3,1,1)
    plot(t, tor4_Qar,'r','LineWidth',1.5)
    grid on
    aex = gca;
    aex.FontSize = 10;
    leg = legend('Torque Quadril Apoio Reacao');
    leg.Location = 'northeastoutside';
    leg.FontSize = 9;
    ylabel('Torque [N.m]');
    
    subplot(3,1,2)
    plot(t, tor4_Jar,'b','LineWidth',1.5)
    grid on
    aex = gca;
    aex.FontSize = 10;
    leg = legend('Torque Joelho Apoio Reacao');
    leg.Location = 'northeastoutside';
    leg.FontSize = 9;
    ylabel('Torque [N.m]');
 
    subplot(3,1,3)
    plot(t, tor4_Tar,'m','LineWidth',1.5)
%     hold on
%     plot(t, tor4_Dar,'g--','LineWidth',1.8)
%     hold off
    aex = gca;
    aex.FontSize = 10;
    leg = legend('Torque Tornozelo Apoio Reacao', 'Torque Dedao Apoio Reacao');
    leg.Location = 'northeastoutside';
    leg.FontSize = 9;
    ylabel('Torque [N.m]');
    
    t5 = suptitle('Torques da Perna Direita na Fase de Apoio com 4 DoF com Reacao');
    t5.Color = 'blue';
    
end

graficos_Angulos = 0;

    if graficos_Angulos == 1
    
        graficos_angulos_velocidades;
   
    end
