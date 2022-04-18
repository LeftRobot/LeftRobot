clc;

%% RESULTADOS PARA OS TORQUES DOS MEMBROS INFERIORES

% load patients
% T = table(Age,Gender,Height,Weight,SelfAssessedHealthStatus,Location,...
% 'RowNames',LastName);

%% GRÁFICOS DOS RESULTADOS DE TORQUE PARA A VELOCIDADE V1

flag_V1 = 0; flag_V2 = 0; flag_V3 = 0; flag_V4 = 0;

if exist ('torques_V1')==0    % exist: Check existence of variable, script, 
                              % function, folder, or class
   
    disp('Variável Torques_V1 nao existe no Workspace');
    
elseif (exist('torques_V1')==1 && velocidade==1)
    close all;
    
    timeV1    = torques_V1.time; % Vetor de tempo para os torques da Velocidade 1
    torqueV1  = torques_V1.signals.values; % Torques da perna direita e esquerda para V1
    [r,c,sh]  = size(torqueV1); 
    torqueV1  = reshape(torqueV1,[c,sh])'; % reshape da matriz 3D para uma matriz 2D (trasposta)

    % Torques das Juntas da Perna Direita para a Velocidade 1
    torQD_V1 = torqueV1(:,1); % Torque Quadril Direito 
    torJD_V1 = torqueV1(:,2); % Torque Joelho Direito
    torTD_V1 = torqueV1(:,3); % Torque Tornozelo Direito

    % Torques das Juntas da Perna Esquerda para a Velocidade 1
    torQE_V1 = torqueV1(:,4); % Torque Quadril Esquerdo
    torJE_V1 = torqueV1(:,5); % Torque Joelho Esquerdo
    torTE_V1 = torqueV1(:,6); % Torque Tornozelo Esquerdo

    % Figure 1 para comparar os torques do quadril e do joelho direito para V1
    figure()
    plot(timeV1,torQD_V1,'r','LineWidth',2)
    hold on
    plot(timeV1,torJD_V1,'b','LineWidth',2)
    hold off
    aex = gca;
    aex.FontSize = 13;
    leg = legend('Torque Quadril V1', 'Torque Joelho V1');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    xlabel('t [sec]'); 
    ylabel('Torque [N.m]');
    title('Torques do Quadril e do Joelho da Perna Direita para V_1')

    % Figure do torque do Tornozelo Direito para V1
    figure()
    plot(timeV1,torTD_V1,'m','LineWidth',2)
    title('Torque do Tornozelo da Perna Direita para V_1')
    xlabel('t [sec]')
    ylabel('Torque [N.m]')
    title('Torque do Tornozelo da perna direita para V_1')
    aex = gca; % access the current axis - get current axis
    aex.FontSize = 13;

    % Figure para comparar os torques do Quadril Direito e Esquerdo para V1
    figure()
    plot(timeV1,torQD_V1,'r','LineWidth',2)
    hold on
    plot(timeV1,torQE_V1,'r-.','LineWidth',2)
    hold off
    aex = gca; % get current axes
    aex.FontSize = 13;
    leg = legend('Torque Quadril Direito','Torque Quadril Esquerdo');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    xlabel('t [sec]'); 
    ylabel('Torque');
    title('Torques do Quadril Direito e do Quadril Esquerdo para V_1')

    % Figure para comparar os torques do Joelho Direito e Esquerdo para V1
    figure()
    plot(timeV1,torJD_V1,'b','LineWidth',2)
    hold on
    plot(timeV1,torJE_V1,'b-.','LineWidth',2)
    hold off
    aex = gca; % get current axes properties
    aex.FontSize = 13;
    leg = legend('Torque Joelho Direito','Torque Joelho Esquerdo');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    xlabel('t [sec]'); 
    ylabel('Torque');
    title('Torques do Joelho Direito e do Joelho Esquerdo para V_1')

    % Figure para comparar os torques do Tornozelo Direito e Esquerdo para V1
    figure()
    plot(timeV1,torTD_V1,'m','LineWidth',2)
    hold on
    plot(timeV1,torTE_V1,'m-.','LineWidth',2)
    hold off
    aex = gca;
    aex.FontSize = 13;
    leg = legend('Torque Tornozelo Direito','Torque Tornozelo Esquerdo');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    xlabel('t [sec]'); 
    ylabel('Torque');
    title('Torques do Tornozelo Direito e do Tornozelo Esquerdo para V_1')
    
    % SAlva no arquivo .MAT-FILE os torques das juntas para V1
    save('TORQUES_V1_ComCont.mat','timeV1','torqueV1');
    
    % Bandeira para ativar os gráficos de comparacao dos torques para as 4
    % velocidades
    flag_V1 = 1;end


%% GRÁFICOS DOS RESULTADOS DE TORQUE PARA A VELOCIDADE V2
if exist ('torques_V2')==0    % exist: Check existence of variable, script, 
                              % function, folder, or class
   
    disp('Variável Torques_V2 nao existe no Workspace');
    
    
elseif (exist('torques_V2')==1 && velocidade==2)
    close all;
    
    timeV2    = torques_V2.time; % Vetor de tempo para os torques da Velocidade 2
    torqueV2  = torques_V2.signals.values; % Torques da perna direita e esquerda para V2
    [r,c,sh]  = size(torqueV2); 
    torqueV2  = reshape(torqueV2,[c,sh])'; % reshape da matriz 3D para uma matriz 2D (trasposta)

    % Torques das Juntas da Perna Direita para a Velocidade 2
    torQD_V2 = torqueV2(:,1); % Torque Quadril Direito 
    torJD_V2 = torqueV2(:,2); % Torque Joelho Direito
    torTD_V2 = torqueV2(:,3); % Torque Tornozelo Direito

    % Torques das Juntas da Perna Esquerda para a Velocidade 2
    torQE_V2 = torqueV2(:,4); % Torque Quadril Esquerdo
    torJE_V2 = torqueV2(:,5); % Torque Joelho Esquerdo
    torTE_V2 = torqueV2(:,6); % Torque Tornozelo Esquerdo

    % Figure para comparar os torques do quadril e do joelho direito para
    % V2
    figure()
    plot(timeV2,torQD_V2,'r','LineWidth',2)
    hold on
    plot(timeV2,torJD_V2,'b','LineWidth',2)
    hold off
    aex = gca;
    aex.FontSize = 13;
    leg = legend('Torque Quadril V_2','Torque Joelho V_2');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    xlabel('t [sec]'); 
    ylabel('Torque [N.m]');
    title('Torques do Quadril e do Joelho da Perna Direita para V_2')

    % Figure do Torque do Tornozelo Direito para V2
    figure()
    plot(timeV2,torTD_V2,'m','LineWidth',2)
    title('Torque do Tornozelo da Perna Direita para V_2');
    xlabel('t [sec]'); 
    ylabel('Torque [N.m]');
    aex = gca;
    aex.FontSize = 13;

    % Figure para comparar os torques do Quadril Direito e Esquerdo para V2
    figure()
    plot(timeV2,torQD_V2,'r','LineWidth',2)
    hold on
    plot(timeV2,torQE_V2,'r-.','LineWidth',2)
    hold off
    aex = gca;
    aex.FontSize = 13;
    leg = legend('Torque Quadril Direito','Torque Quadril Esquerdo');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    xlabel('t [sec]'); 
    ylabel('Torque');
    title('Torques do Quadril Direito e do Quadril Esquerdo para V_2')

    % Figure para comparar os torques do Joelho Direito e Esquerdo para V2
    figure()
    plot(timeV2,torJD_V2,'b','LineWidth',2)
    hold on
    plot(timeV2,torJE_V2,'b-.','LineWidth',2)
    hold off
    aex = gca;
    aex.FontSize = 13;
    leg = legend('Torque Joelho Direito','Torque Joelho Esquerdo');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    xlabel('t [sec]'); 
    ylabel('Torque');
    title('Torques do Joelho Direito e do Joelho Esquerdo para V_2')

    % Figure para comparar os torques do Tornozelo Direito e Esquerdo para
    % V2
    figure()
    plot(timeV2,torTD_V2,'m','LineWidth',2)
    hold on
    plot(timeV2,torTE_V2,'m-.','LineWidth',2)
    hold off
    aex = gca;
    aex.FontSize = 13;
    leg = legend('Torque Tornozelo Direito','Torque Tornozelo Esquerdo');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    xlabel('t [sec]'); 
    ylabel('Torque');
    title('Torques do Tornozelo Direito e do Tornozelo Esquerdo para V_2')
    
    % Salva no arquivo .MAT-FILE os torques de cada junta para V2
    save('TORQUES_V2_ComCont.mat','timeV2','torqueV2');
    
    % Bandeira para ativar os gráficos de comparacao dos torques para as 4
    % velocidades
    flag_V2 = 1;
end


%% GRÁFICOS DOS RESULTADOS DE TORQUE PARA A VELOCIDADE V3
if exist ('torques_V3')==0    % exist: Check existence of variable, script, 
                              % function, folder, or class
   
    disp('Variável Torques_V3 nao existe no Workspace');
    
elseif (exist('torques_V3')==1 && velocidade==3)
    close all;
    
    timeV3    = torques_V3.time; % Vetor de tempo para os torques da Velocidade 3
    torqueV3  = torques_V3.signals.values; % Torques da perna direita e esquerda para V3
    [r,c,sh]  = size(torqueV3); 
    torqueV3  = reshape(torqueV3,[c,sh])'; % reshape da matriz 3D para uma matriz 2D (trasposta)

    % Torques das Juntas da Perna Direita para a Velocidade 3
    torQD_V3 = torqueV3(:,1); % Torque Quadril Direito 
    torJD_V3 = torqueV3(:,2); % Torque Joelho Direito
    torTD_V3 = torqueV3(:,3); % Torque Tornozelo Direito

    % Torques das Juntas da Perna Esquerda para a Velocidade 3
    torQE_V3 = torqueV3(:,4); % Torque Quadril Esquerdo
    torJE_V3 = torqueV3(:,5); % Torque Joelho Esquerdo
    torTE_V3 = torqueV3(:,6); % Torque Tornozelo Esquerdo

    % Figure para comparar os torques do quadril e do joelho direito para
    % V3
    figure()
    plot(timeV3,torQD_V3,'r','LineWidth',2)
    hold on
    plot(timeV3,torJD_V3,'b','LineWidth',2)
    hold off
    aex = gca;
    aex.FontSize = 13;
    leg = legend('Torque Quadril V_3','Torque Joelho V_3');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    xlabel('t [sec]'); 
    ylabel('Torque [N.m]');
    title('Torques do Quadril e do Joelho da Perna Direita para V_3')

    % Figure do torque do Tornozelo Direito para V3
    figure()
    plot(timeV3,torTD_V3,'m','LineWidth',2)
    xlabel('t [sec]'); 
    ylabel('Torque [N.m]');
    title('Torque do Tornozelo da Perna Direita para V_3');
    aex = gca;
    aex.FontSize = 13;
    
    % Figure para comparar os torques do Quadril Direito e Esquerdo para V3
    figure()
    plot(timeV3,torQD_V3,'r','LineWidth',2)
    hold on
    plot(timeV3,torQE_V3,'r-.','LineWidth',2)
    hold off
    aex = gca;
    aex.FontSize = 13;
    leg = legend('Torque Quadril Direito','Torque quadril Esquerdo');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    xlabel('t [sec]'); 
    ylabel('Torque');
    title('Torques do Quadril Direito e do Quadril Esquerdo para V_3')

    % Figure para comparar os torques do Joelho Direito e Esquerdo para V3
    figure()
    plot(timeV3,torJD_V3,'b','LineWidth',2)
    hold on
    plot(timeV3,torJE_V3,'b-.','LineWidth',2)
    hold off
    aex = gca;
    aex.FontSize = 13;
    leg = legend('Torque Joelho Direito','Torque Joelho Esquerdo');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    xlabel('t [sec]'); 
    ylabel('Torque');
    title('Torques do Joelho Direito e do Joelho Esquerdo para V_3')

    % Figure para comparar os torques do Tornozelo Direito e Esquerdo para
    % V3
    figure()
    plot(timeV3,torTD_V3,'m','LineWidth',2)
    hold on
    plot(timeV3,torTE_V3,'m-.','LineWidth',2)
    hold off
    aex = gca;
    aex.FontSize = 13;
    leg = legend('Torque Tornozelo Direito','Torque Tornozelo Esquerdo');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    xlabel('t [sec]'); 
    ylabel('Torque');
    title('Torques do Tornozelo Direito e do Tornozelo Esquerdo para V_3')
    
    % Salva no arquivo MAT-FILE os torques das juntas para V3
    save('TORQUES_V3_ComCont.mat','timeV3','torqueV3');
    
    % Bandeira para ativar os gráficos de comparacao dos torques para as 4
    % velocidades
    flag_V3 = 1;
end


%% GRÁFICOS DOS RESULTADOS DE TORQUE PARA A VELOCIDADE V4
if exist ('torques_V4')==0    % exist: Check existence of variable, script, 
                              % function, folder, or class
   
    disp('Variável Torques_V4 nao existe no Workspace');
    
elseif (exist('torques_V4')==1 && velocidade==4)
    close all;
    
    timeV4    = torques_V4.time; % Vetor de tempo para os torques da Velocidade 4
    torqueV4  = torques_V4.signals.values; % Torques da perna direita e esquerda para V4
    [r,c,sh]  = size(torqueV4); 
    torqueV4  = reshape(torqueV4,[c,sh])'; % reshape da matriz 3D para uma matriz 2D (trasposta)

    % Torques das Juntas da Perna Direita para a Velocidade 4
    torQD_V4 = torqueV4(:,1); % Torque Quadril Direito 
    torJD_V4 = torqueV4(:,2); % Torque Joelho Direito
    torTD_V4 = torqueV4(:,3); % Torque Tornozelo Direito

    % Torques das Juntas da Perna Esquerda para a Velocidade 4
    torQE_V4 = torqueV4(:,4); % Torque Quadril Esquerdo
    torJE_V4 = torqueV4(:,5); % Torque Joelho Esquerdo
    torTE_V4 = torqueV4(:,6); % Torque Tornozelo Esquerdo

    % Figure para comparar os torques do quadril e do joelho direito para
    % V4
    figure()
    plot(timeV4,torQD_V4,'r','LineWidth',2)
    hold on
    plot(timeV4,torJD_V4,'b','LineWidth',2)
    hold off
    aex = gca; % get current axes properties
    aex.FontSize = 13;
    leg = legend('Torque Quadril V4','Torque Joelho V4');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    xlabel('t [sec]'); 
    ylabel('Torque [N.m]');
    title('Torques do Quadril e do Joelho da Perna Direita para V_4')

    % Figure do torque do Tornozelo Direito para V4
    figure()
    plot(timeV4,torTD_V4,'m','LineWidth',2)
    xlabel('t [sec]'); ylabel('Torque [N.m]');
    title('Torque do Tornozelo da Perna Direita para V_4');
    aex = gca; % get current axes properties
    aex.FontSize = 13;

    % Figure para comparar os torques do Quadril Direito e Esquerdo para V4
    figure()
    plot(timeV4,torQD_V4,'r','LineWidth',2)
    hold on
    plot(timeV4,torQE_V4,'r-.','LineWidth',2)
    hold off
    aex = gca; % get current axes properties
    aex.FontSize = 13;
    leg = legend('Torque Quadril Direito','Torque Quadril Esquerdo');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    xlabel('t [sec]'); 
    ylabel('Torque');
    title('Torques do Quadril Direito e do Quadril Esquerdo para V_4')

    % Figure para comparar os torques do Joelho Direito e Esquerdo para V4
    figure()
    plot(timeV4,torJD_V4,'b','LineWidth',2)
    hold on
    plot(timeV4,torJE_V4,'b-.','LineWidth',2)
    hold off
    aex = gca; % Get current axes
    aex.FontSize = 13;
    leg = legend('Torque Joelho Direito','Torque Joelho Esquerdo');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    xlabel('t [sec]'); 
    ylabel('Torque');
    title('Torques do Joelho Direito e do Joelho Esquerdo para V_4')

    % Figure para comparar os torques do Tornozelo Direito e Esquerdo para
    % V4
    figure()
    plot(timeV4,torTD_V4,'m','LineWidth',2)
    hold on
    plot(timeV4,torTE_V4,'m-.','LineWidth',2)
    hold off
    aex = gca; % Get current axes properties
    aex.FontSize = 13;
    leg = legend('Torque Tornozelo Direito','Torque Tornozelo Esquerdo');
    leg.Location = 'northeastoutside';
    leg.FontSize = 12;
    xlabel('t [sec]'); 
    ylabel('Torque');
    title('Torques do Tornozelo Direito e do Tornozelo Esquerdo para V_4')
    
    % Salva no arquivo . MAT-FILE os torques das juntas para V4
    save('TORQUES_V4_ComCont.mat','timeV4','torqueV4');
    
    % Bandeira para ativar os gráficos de comparacao dos torques para as 4
    % velocidades
    flag_V4 = 1;
end


%% COMPARACAO ENTRE OS TORQUES DAS JUNTAS PARA AS 4 VELOCIDADES DE MARCHA

% Se já tiver rodados as simulacoes para todas as velocidades, podem se
% gerar os gráficos para comparar os torques para as 4 velocidades de marcha
if (flag_V1==1 && flag_V2==1 && flag_V3==1 && flag_V4==1)
    
% Carrego os torques salvos nos arquivos .MAT-FILE
V1_torques = load('TORQUES_V1_ComCont.mat');
V2_torques = load('TORQUES_V2_ComCont.mat');
V3_torques = load('TORQUES_V3_ComCont.mat');
V4_torques = load('TORQUES_V4_ComCont.mat');


% Comparacao dos Torques do Quadril direito para as 4 velocidades de marcha
figure
graf1 = plot(V1_torques.timeV1, V1_torques.torqueV1(:,1));
graf1.LineWidth = 2;
hold on
graf2 = plot(V2_torques.timeV2, V2_torques.torqueV2(:,1));
graf2.LineWidth = 2;
hold on
graf3 = plot(V3_torques.timeV3, V3_torques.torqueV3(:,1));
graf3.LineWidth = 2;
hold on
graf4 = plot(V4_torques.timeV4, V4_torques.torqueV4(:,1));
graf4.LineWidth = 2;
hold off
ax = gca; % Get current axes properties
ax.FontSize = 13;
leg1 = legend('\tau_{quadril} direito para V_1','\tau_{quadril} direito para V_2',...
              '\tau_{quadril} direito para V_3','\tau_{quadril} direito para V_4');
leg1.Location = 'northeastoutside';
leg1.FontSize = 12;
xlabel('t [sec]'); 
ylabel('Torque [N.m]');
title('Comparacao dos Torques do Quadril Direito Para as 4 Velocidades de Marcha')          

% Comparaco dos Torques do Joelho direito para as 4 velocidades de marcha

figure
graf1 = plot(V1_torques.timeV1, V1_torques.torqueV1(:,2));
graf1.LineWidth = 2;
hold on
graf2 = plot(V2_torques.timeV2, V2_torques.torqueV2(:,2));
graf2.LineWidth = 2;
hold on
graf3 = plot(V3_torques.timeV3, V3_torques.torqueV3(:,2));
graf3.LineWidth = 2;
hold on
graf4 = plot(V4_torques.timeV4, V4_torques.torqueV4(:,2));
graf4.LineWidth = 2;
hold off
ax = gca; % Get current axes properties
ax.FontSize = 13;
leg2 = legend('\tau_{joelho} direito para V_1','\tau_{joelho} direito para V_2',...
              '\tau_{joelho} direito para V_3','\tau_{joelho} direito para V_4');
leg2.Location = 'northeastoutside';
leg2.FontSize = 12;
xlabel('t [sec]'); 
ylabel('Torque [N.m]');
title('Comparacao dos Torques do Joelho Direito Para as 4 Velocidades de Marcha')

% Comparacao dos Torques do Tornozelo direito para as 4 Velocidades de
% Marcha
figure
graf1 = plot(V1_torques.timeV1, V1_torques.torqueV1(:,3));
graf1.LineWidth = 2;
hold on
graf2 = plot(V2_torques.timeV2, V2_torques.torqueV2(:,3));
graf2.LineWidth = 2;
hold on
graf3 = plot(V3_torques.timeV3, V3_torques.torqueV3(:,3));
graf3.LineWidth = 2;
hold on
graf4 = plot(V4_torques.timeV4, V4_torques.torqueV4(:,3));
graf4.LineWidth = 2;
hold off
ax = gca; % Get current axes properties (gca)
ax.FontSize = 13;
leg3 = legend('\tau_{tornozelo} direito para V_1','\tau_{tornozelo} direito para V_2',...
              '\tau_{tornozelo} direito para V_3','\tau_{tornozelo} direito para V_4');
leg3.Location = 'northeastoutside';
leg3.FontSize = 12;
xlabel('t [sec]'); 
ylabel('Torque [N.m]');
title('Comparacao dos Torques do Tornozelo Direito Para as 4 Velocidades de Marcha')

end