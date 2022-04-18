%% Carrego datasets torques direitos modelagem Euler-Lagrange 4 velocidades de marcha
tauV1_EL = readmatrix('tauV1_reacEL.txt');
tauV2_EL = readmatrix('tauV2_reacEL.txt');
tauV3_EL = readmatrix('tauV3_reacEL.txt');
tauV4_EL = readmatrix('tauV4_reacEL.txt');

tEL1 = tauV1_EL(:,1);
tEL2 = tauV2_EL(:,1);
tEL3 = tauV3_EL(:,1);
tEL4 = tauV4_EL(:,1);

torqQV1_EL = tauV1_EL(:,2);
torqQV2_EL = tauV2_EL(:,2);
torqQV3_EL = tauV3_EL(:,2);
torqQV4_EL = tauV4_EL(:,2);

torqJV1_EL = tauV1_EL(:,3);
torqJV2_EL = tauV2_EL(:,3);
torqJV3_EL = tauV3_EL(:,3);
torqJV4_EL = tauV4_EL(:,3);

torqTV1_EL = tauV1_EL(:,4);
torqTV2_EL = tauV2_EL(:,4);
torqTV3_EL = tauV3_EL(:,4);
torqTV4_EL = tauV4_EL(:,4);

% Gráfico comparacao torques QUADRIL DIREITO para 4 velocidades de marcha
figure('Name','Comparacao torques quadril 4 velocidades marcha Euler-Lagrange')
hold on
plot(tEL1, torqQV1_EL, 'Color', [237 177 32]/255, 'LineWidth', 1.5,...
    'DisplayName', '\tau_{quadril} para V_1 = 0.5 m/s')
plot(tEL2, torqQV2_EL, 'b', 'LineWidth', 1.5,...
    'DisplayName', '\tau_{quadril} para V_2 = 1.0 m/s')
plot(tEL3, torqQV3_EL, 'm', 'LineWidth', 1.5,...
    'DisplayName', '\tau_{quadril} para V_3 = 1.2 m/s')
plot(tEL4, torqQV4_EL, 'k', 'LineWidth', 1.5,...
    'DisplayName', '\tau_{quadril} para V_4 = 1.5 m/s')
hold off
lgd = legend;
lgd.FontSize = 12;
lgd.Location = 'best';
ax = gca;
ax.FontSize = 12;
axis tight
xlabel('t_{ciclo} (s)')
ylabel('\tau_{quadril} (N.m)')
title('Torque quadril direito para as 4 velocidades de marcha')

% Gráfico comparacao torques JOELHO DIREITO para 4 velocidades de marcha
figure('Name', 'Comparacao torques joelho 4 velocidades marcha Euler-Lagrange')
hold on
plot(tEL1, torqJV1_EL, 'Color', [237 177 32]/255, 'LineWidth', 1.5, ...
    'DisplayName', '\tau_{joelho} para V_1 = 0.5 m/s')
plot(tEL2, torqJV2_EL, 'b', 'LineWidth', 1.5,...
    'DisplayName', '\tau_{joelho} para V_2 = 1.0 m/s')
plot(tEL3, torqJV3_EL, 'm', 'LineWidth', 1.5,...
    'DisplayName', '\tau_{joelho} para V_3 = 1.2 m/s')
plot(tEL4, torqJV4_EL, 'k', 'LineWidth', 1.5,...
    'DisplayName', '\tau_{joelho} para V_4 = 1.5 m/s')
lgd = legend;
lgd.FontSize = 12;
aix = gca;
aix.FontSize = 12;
axis tight
xlabel('t_{ciclo} (s)')
ylabel('\tau_{joelho} (N.m)')
title('Torque joelho direito para as 4 velocidades de marcha')

% Gráfico comparacao torques TORNOZELO DIREITO para 4 velocidades de marcha
figure('Name', 'Comparacao torques tornozelo 4 velocidades marcha Euler-Lagrange')
hold on
plot(tEL1, torqTV1_EL, 'Color', [237 177 32]/255, 'LineWidth', 1.5,...
    'DisplayName', '\tau_{tornozelo} para V_1 = 0.5 m/s')
plot(tEL2, torqTV2_EL, 'b', 'LineWidth', 1.5, ...
    'DisplayName', '\tau_{tornozelo} para V_2 = 1.0 m/s')
plot(tEL3, torqTV3_EL, 'm', 'LineWidth', 1.5, ...
    'DisplayName', '\tau_{tornozelo} para V_3 = 1.2 m/s')
plot(tEL4, torqTV4_EL, 'k', 'LineWidth', 1.5, ...
    'DisplayName', '\tau_{tornozelo} para V_4 = 1.5 m/s')
hold off
lgd = legend;
lgd.FontSize = 12;
lgd.Location = 'best';
aix = gca;
aix.FontSize = 12;
axis tight
xlabel('t_{ciclo} (s)')
ylabel('\tau_{tornozelo} (N.m)')
title('Torque tornozelo direito para as 4 velocidades de marcha')

%% Carrego datasets torques direitos modelagem SimScape 4 velocidades de marcha
tauV1_SM = readmatrix('tau_V1.txt');
tauV2_SM = readmatrix('tau_V2.txt');
tauV3_SM = readmatrix('tau_V3.txt');
tauV4_SM = readmatrix('tau_V4.txt');

tSM1 = tauV1_SM(:,1);
tSM2 = tauV2_SM(:,1);
tSM3 = tauV3_SM(:,1);
tSM4 = tauV4_SM(:,1);

% Torques QUADRIL DIREITO para as 4 Velocidades de Marcha - SMOOTH DATA
% =========================================================================
torqQV1_SM = tauV1_SM(:,2);
[torqQV1_SM_CD,outlierIndices,thresholdLow,thresholdHigh] = ...
    filloutliers(torqQV1_SM,'linear','movmean',0.078,'ThresholdFactor',2.5,...
    'SamplePoints',tSM1);
torqQV1_SM = -smoothdata(torqQV1_SM_CD,'movmean','SmoothingFactor',0.15,...
    'SamplePoints',tSM1);
% ----------------------------------------------------------------------------
torqQV2_SM = tauV2_SM(:,2);
[torqQV2_SM_CD,outlierIndices3,thresholdLow3,thresholdHigh3] = ...
    filloutliers(torqQV2_SM,'linear','movmean',1.05,'SamplePoints',tSM2);

torqQV2_SM = -smoothdata(torqQV2_SM_CD,'gaussian','SmoothingFactor',0.25,...
    'SamplePoints',tSM2);
% ----------------------------------------------------------------------------
torqQV3_SM = tauV3_SM(:,2);
[torqQV3_SM_CD,outlierIndices4,thresholdLow4,thresholdHigh4] = ...
    filloutliers(torqQV3_SM,'linear','movmean',1.011,'SamplePoints',tSM3);

torqQV3_SM = -smoothdata(torqQV3_SM_CD,'gaussian','SmoothingFactor',0.3,...
    'SamplePoints',tSM3);
% ----------------------------------------------------------------------------
torqQV4_SM = tauV4_SM(:,2);
[torqQV4_SM_CD,outlierIndices5,thresholdLow5,thresholdHigh5] = ...
    filloutliers(torqQV4_SM,'linear','movmean',3.004,'ThresholdFactor',2.9,...
    'SamplePoints',tSM4);

torqQV4_SM = -smoothdata(torqQV4_SM_CD,'gaussian','SmoothingFactor',0.4,...
    'SamplePoints',tSM4);
% ============================================================================
% Torques Joelho Direito para as 4 Velocidades de Marcha
torqJV1_SM = tauV1_SM(:,3);
[torqJV1_SM_CD,outlierIndices6,thresholdLow6,thresholdHigh6] = ...
    filloutliers(torqJV1_SM,'linear','movmedian',0.059,'SamplePoints',tSM1);
torqJV1_SM = - smoothdata(torqJV1_SM_CD,'gaussian','SmoothingFactor',0.25,...
    'SamplePoints',tSM1);
% ----------------------------------------------------------------------------
torqJV2_SM = tauV2_SM(:,3);
[torqJV2_SM_CD,outlierIndices7,thresholdLow7,thresholdHigh7] = ...
    filloutliers(torqJV2_SM,'linear','movmean',0.034,'ThresholdFactor',2.5,...
    'SamplePoints',tSM2);
% Smooth input data
torqJV2_SM = - smoothdata(torqJV2_SM_CD,'movmean','SmoothingFactor',0.2);
% ---------------------------------------------------------------------------
torqJV3_SM = tauV3_SM(:,3);
[torqJV3_SM_CD,outlierIndices8,thresholdLow8,thresholdHigh8] = ...
    filloutliers(torqJV3_SM,'linear','movmean',0.5,'SamplePoints',tSM3);
torqJV3_SM = - smoothdata(torqJV3_SM_CD,'gaussian','SmoothingFactor',0.35);
% ---------------------------------------------------------------------------
torqJV4_SM = tauV4_SM(:,3);
[torqJV4_SM_CD,outlierIndices9,thresholdLow9,thresholdHigh9] = ...
    filloutliers(torqJV4_SM,'linear','movmean',2.004,'ThresholdFactor',2.9,...
    'SamplePoints',tSM4);
% Smooth input data
torqJV4_SM = - smoothdata(torqJV4_SM_CD,'gaussian','SmoothingFactor',0.4,...
    'SamplePoints',tSM4);
% ===========================================================================

% Torques TORNOZELO DIREITO para as 4 Velocidades de Marcha - SMOOTH DATA
% ===========================================================================
torqTV1_SM = tauV1_SM(:,4);
[torqTV1_SM_CD,outlierIndices10,thresholdLow10,thresholdHigh10] = ...
    filloutliers(torqTV1_SM,'linear','movmean',0.17,'SamplePoints',tSM1);

torqTV1_SM = - smoothdata(torqTV1_SM_CD,...
    'gaussian','SmoothingFactor',0.09999999999999998,'SamplePoints',tSM1);
% ---------------------------------------------------------------------------

torqTV2_SM = tauV2_SM(:,4);
[torqTV2_SM_CD,outlierIndices11,thresholdLow11,thresholdHigh11] = ...
    filloutliers(torqTV2_SM,'linear','movmean',1.043,'ThresholdFactor',2.75,...
    'SamplePoints',tSM2);

torqTV2_SM = - smoothdata(torqTV2_SM_CD,'gaussian','SmoothingFactor',0.15,...
    'SamplePoints',tSM2);
% ---------------------------------------------------------------------------

torqTV3_SM = tauV3_SM(:,4);
[torqTV3_SM_CD,outlierIndices12,thresholdLow12,thresholdHigh12] = ...
    filloutliers(torqTV3_SM,'linear','movmean',2.005,'ThresholdFactor',2.5,...
    'SamplePoints',tSM3);

% Smooth input data
torqTV3_SM = - smoothdata(torqTV3_SM_CD,'gaussian','SmoothingFactor',0.35);

% ---------------------------------------------------------------------------

torqTV4_SM = tauV4_SM(:,4);
% Fill outliers
[torqTV4_SM_CD,outlierIndices13,thresholdLow13,thresholdHigh13] = ...
    filloutliers(torqTV4_SM,'linear','movmean',2.0033,'ThresholdFactor',2.75,...
    'SamplePoints',tSM4);
% Smooth input data

torqTV4_SM = - smoothdata(torqTV4_SM_CD,'gaussian','SmoothingFactor',0.5,...
    'SamplePoints',tSM4);
% ===========================================================================

%% COMPARACAO TORQUES PARA V1 = 0.5m/s MODELAGEM EULER-LAGRANGE E SIMSCAPE

% Comparacao Torques QUADRIL DIREITO V1
figure()
tl = tiledlayout(2,1); %Defino um layout de 2X1 para os gráficos

ax1 = nexttile;       %Defino o primeiro subplot
hold on
plot(ax1, tEL1, torqQV1_EL, 'Color', [237 177 32]/255, 'LineWidth', 1.5,...
    'DisplayName', 'Torque quadril modelagem Euler-Lagrange')
plot(ax1, tSM1, torqQV1_SM, 'Color', [237 177 32]/255, 'LineStyle', '-.', 'LineWidth',1.8,...
    'DisplayName', 'Torque quadril modelagem Simscape')
hold off
leg = legend;
leg.Location = 'best';
leg.FontSize = 13;
aex = gca;
aex.FontSize = 13;
axis tight
ylabel(ax1, 'Torque (N.m)');
title(ax1, 'Comparação do Torque do Quadril Direito para V_1 = 0.5 m/s')

% Erro Torques QUADRIL V1
ax2 = nexttile;
errorbar(ax2, tEL1, torqQV1_EL, torqQV1_EL - torqQV1_SM(1:round(size(torqQV1_SM)/100):end,1),...
    'LineWidth',1.5)
ax = gca;
ax.FontSize = 13;
axis tight
ylabel(ax2, 'Erro (N.m)')
xlabel(tl,'t (s)','FontSize', 13)
% -------------------------------------------------------------------------    
% Comparacao Torques JOELHO DIREITO V1
figure()
% Torques J V1
tl = tiledlayout(2,1);

ax1 = nexttile;
hold on
plot(ax1, tEL1, torqJV1_EL,'m','LineWidth',1.5,'DisplayName','Torque joelho modelagem Euler-Lagrange')
plot(ax1, tSM1, torqJV1_SM,'m-.','LineWidth',1.8,'DisplayName','Torque joelho modelagem Simscape')
hold off
aex = gca;
aex.FontSize = 13;
axis tight
leg = legend;
leg.Location = 'best';
leg.FontSize = 13;
ylabel('Torque (N.m)');
title('Comparação do Torque do Joelho Direito para V_1 = 0.5 m/s')

% Erros Torques JOELHO V1
ax2 = nexttile;
errorbar(ax2, tEL1, torqJV1_EL, torqJV1_EL-torqJV1_SM(1:round(size(torqJV1_SM)/100):end,1), 'LineWidth',1.5)
ax = gca;
ax.FontSize = 13;
axis tight
ylabel(ax2, 'Erro (N.m)')

xlabel(tl, 't (s)', 'FontSize', 13)

%--------------------------------------------------------------------------    
% Comparacao Torques TORNOZELO DIREITO V1
figure()
tl = tiledlayout(2,1);

ax1 = nexttile;
hold on
plot(ax1, tEL1, torqTV1_EL,'k', 'LineWidth',1.5,'DisplayName','Torque tornozelo modelagem Euler-Lagrange')
plot(ax1, tSM1, torqTV1_SM,'k-.', 'LineWidth',1.8,'DisplayName','Torque tornozelo modelagem Simscape')
hold off
aex = gca;
aex.FontSize = 13;
axis tight
leg = legend;
leg.Location = 'best';
leg.FontSize = 13;
ylabel(ax1, 'Torque (N.m)');
title(ax1, 'Comparação do Torque do tornozelo Direito para V_1 = 0.5 m/s')

% Erros Torques TORNOZELO V1
ax2 = nexttile;
errorbar(ax2, tEL1, torqTV1_EL, torqTV1_EL - torqTV1_SM(1:round(size(torqTV1_SM)/100):end,1),...
    'LineWidth',1.5)
ax = gca;
ax.FontSize = 13;
axis tight
ylabel(ax2, 'Erro (N.m)')
xlabel(tl, 't (s)', 'FontSize', 13)

    
%% COMPARACAO TORQUES PARA V2 = 1.0m/s MODELAGEM EULER-LAGRANGE E SIMSCAPE

% Comparacao torques QUADRIL DIREITO V2
figure()
tl = tiledlayout(2,1);

ax1 = nexttile;
hold on
plot(ax1, tEL2, torqQV2_EL,'Color', [237 177 32]/255,'LineWidth',1.5,...
    'DisplayName', 'Torque quadril modelagem Euler-Lagrange')
plot(ax1, tSM2, torqQV2_SM,'Color', [237 177 32]/255,'LineWidth',1.5,'LineStyle','-.',...
    'DisplayName', 'Torque quadril modelagem Simscape')
hold off
aex = gca;
aex.FontSize = 13;
axis tight
leg = legend;
leg.FontSize = 13;
leg.Location = 'best'; 
ylabel(ax1, 'Torque (N.m)');
title(ax1, 'Comparação do Torque do Quadril Direito para V_2 = 1.0 m/s')

% Erro QUADRIL V2
ax2 = nexttile;
errorbar(ax2, tEL2, torqQV2_EL, torqQV2_EL - torqQV2_SM(1:round(size(torqQV2_SM)/100):end,1),...
    'LineWidth',1.5)
ax = gca;
ax.FontSize = 12;
axis tight
ylabel('Erro (N.m)')
xlabel(tl, 't (s)', 'FontSize', 13)
%--------------------------------------------------------------------------    
% Comparacao Torques JOELHO DIREITO V2
figure
tl = tiledlayout(2,1);

ax1 = nexttile;
hold on
plot(ax1, tEL2, torqJV2_EL,'m','LineWidth',1.5,...
    'DisplayName', 'Torque joelho modelagem Euler-Lagrange')
plot(ax1, tSM2, torqJV2_SM,'m-.','LineWidth',1.8,...
    'DisplayName', 'Torque joelho modelagem Simscape')
hold off
aex = gca;
aex.FontSize = 13;
axis tight
leg = legend;
leg.FontSize = 13;
leg.Location = 'best'; 
ylabel(ax1, 'Torque (N.m)');
title(ax1, 'Comparação do Torque do joelho Direito para V_2 = 1.0 m/s')

% Erro JOELHO V2
ax2 = nexttile;
errorbar(ax2, tEL2, torqJV2_EL, torqJV2_EL - torqJV2_SM(1:round(size(torqJV2_SM)/100):end,1),...
    'LineWidth',1.5)
aix = gca;
aix.FontSize = 13;
axis tight
ylabel(ax2, 'Erro (N.m)')
xlabel(tl, 't (s)', 'FontSize', 13)

%--------------------------------------------------------------------------    
% Comparacao Torques TORNOZELO DIREITO V2
figure()
tl = tiledlayout(2,1);

ax1 = nexttile;
hold on
plot(ax1, tEL2, torqTV2_EL,'k', 'LineWidth', 1.5,...
    'DisplayName', 'Torque tornozelo modelagem Euler-Lagrange')
plot(ax1, tSM2, torqTV2_SM,'k-.', 'LineWidth', 1.8,...
    'DisplayName', 'Torque tornozelo modelagem Simscape')
hold off
aex = gca;
aex.FontSize = 13;
axis tight
leg = legend;
leg.FontSize = 13;
leg.Location = 'best'; 
ylabel(ax1, 'Torque (N.m)');
title(ax1, 'Comparação do Torque do tornozelo Direito para V_2 = 1.0 m/s')

% Erro TORNOZELO V2
ax2 = nexttile;
errorbar(ax2, tEL2, torqTV2_EL, torqTV2_EL - torqTV2_SM(1:round(size(torqTV2_SM)/100):end,1),...
    'LineWidth',1.5)
aix = gca;
aix.FontSize = 13;
axis tight
ylabel(ax2, 'Erro (N.m)')
xlabel(tl, 't (s)', 'FontSize', 13)

    
%% COMPARACAO TORQUES PARA V3 = 1.2m/s MODELAGEM EULER-LAGRANGE E SIMSCAPE

% Comparacao Torques QUADRIL DIREITO V3
%--------------------------------------------------------------------------    
figure()
tl = tiledlayout(2,1);

ax1 = nexttile;
plot(ax1, tEL3, torqQV3_EL,'Color', [237 177 32]/255,'LineWidth',1.5,...
    'DisplayName', 'Torque quadril modelagem Euler-Lagrange')
hold on
plot(ax1, tSM3, torqQV3_SM,'Color', [237 177 32]/255,'LineWidth',1.5,'LineStyle','-.',...
    'DisplayName', 'Torque quadril modelagem Simscape')
hold off
aex = gca;
aex.FontSize = 13;
axis tight
leg = legend;
leg.Location = 'best';
leg.FontSize = 13;
ylabel(ax1, 'Torque (N.m)');
title(ax1, 'Comparação do Torque do Quadril Direito para V_3 = 1.2 m/s')

% Erro QUADRIL V3
ax2 = nexttile;
errorbar(tEL3, torqQV3_EL, torqQV3_EL - torqQV3_SM(1:round(size(torqQV3_SM)/100):end,1),...
    'LineWidth',1.5)
aex = gca;
aex.FontSize = 13;
axis tight
ylabel(ax2, 'Erro (N.m)')
xlabel(tl, 't (s)', 'FontSize', 13)
% -------------------------------------------------------------------------   
% Comparacao torques JOELHO DIREITO V3
figure
tl = tiledlayout(2,1);

ax1 = nexttile;
hold on
plot(ax1, tEL3, torqJV3_EL,'m','LineWidth',1.5,...
    'DisplayName', 'Torque joelho modelagem Euler-Lagrange')
plot(ax1, tSM3, torqJV3_SM,'m-.','LineWidth',1.8,...
    'DisplayName', 'Torque joelho modelagem Simscape')
hold off
aex = gca;
aex.FontSize = 13;
axis tight
leg = legend;
leg.Location = 'best';
leg.FontSize = 13; 
ylabel(ax1, 'Torque (N.m)');
title(ax1, 'Comparação do Torque do Joelho Direito para V_3 = 1.2 m/s')

% Erro JOELHO V3
ax2 = nexttile;
errorbar(tEL3, torqJV3_EL, torqJV3_EL - torqJV3_SM(1:round(size(torqJV3_SM)/100):end,1),...
    'LineWidth',1.5)
aex = gca;
aex.FontSize = 13;
axis tight
ylabel(ax2, 'Erro (N.m)')
xlabel(tl, 't (s)', 'FontSize', 13)
% -------------------------------------------------------------------------   
% Comparacao Torques TORNOZELO DIREITO V3
figure
tl = tiledlayout(2,1);

ax1 = nexttile;
hold on
plot(ax1, tEL3, torqTV3_EL,'k', 'LineWidth',1.5,...
    'DisplayName', 'Torque tornozelo modelagem Euler-Lagrange')
plot(ax1, tSM3, torqTV3_SM,'k-.', 'LineWidth',1.8,...
    'DisplayName','Torque tornozelo modelagem Simscape')
hold off
aex = gca;
aex.FontSize = 13;
axis tight
leg = legend;
leg.Location = 'best';
leg.FontSize = 13;
ylabel(ax1, 'Torque (N.m)');
title(ax1, 'Comparação do Torque do Tornozelo Direito para V_3 = 1.2 m/s')

% Erro TORNOZELO V3
ax2 = nexttile;
errorbar(ax2, tEL3, torqTV3_EL, torqTV3_EL - torqTV3_SM(1:round(size(torqTV3_SM)/100):end,1),...
    'LineWidth',1.5)
aex = gca;
aex.FontSize = 13;
axis tight
ylabel(ax2, 'Erro (N.m)')
xlabel(tl, 't (s)', 'FontSize', 13)
    
%% COMPARACAO TORQUES PARA V4 = 1.5m/s MODELAGEM EULER-LAGRANGE E SIMSCAPE

% Comparacao Torque QUADRIL DIREITO V4
figure()
tl = tiledlayout(2,1);

ax1 = nexttile;
hold on
plot(ax1, tEL4, torqQV4_EL,'Color', [237 177 32]/255,'LineWidth',1.5,...
    'DisplayName', 'Torque quadril modelagem Euler-Lagrange')
plot(ax1, tSM4, torqQV4_SM,'Color', [237 177 32]/255,'LineWidth',1.8,'LineStyle','-.',...
    'DisplayName', 'Torque quadril modelagem Simscape')
hold off
aex = gca;
aex.FontSize = 13;
axis tight
leg = legend;
% leg.Location = 'best';
leg.FontSize = 13;
ylabel(ax1, 'Torque (N.m)');
title(ax1, 'Comparação do Torque do Quadril Direito para V_4 = 1.5 m/s')

% Erro QUADRIL V4
increm = round(size(torqQV4_SM,1)/100);
ax2 = nexttile;
errorbar(ax2, tEL4, torqQV4_EL, torqQV4_EL - torqQV4_SM(1:increm:end-mod(size(torqQV4_SM,1),100),1),...
    'LineWidth',1.5)
aex = gca;
aex.FontSize = 13;
axis tight
ylabel(ax2, 'Erro (N.m)')
xlabel(tl, 't (s)', 'FontSize', 13)
% -------------------------------------------------------------------------
% Comparacao Torque JOELHO DIREITO V4
figure()
tl = tiledlayout(2,1);

ax1 = nexttile;
hold on
plot(ax1, tEL4, torqJV4_EL, 'm', 'LineWidth', 1.5,...
    'DisplayName', 'Torque joelho modelagem Euler-Lagrange')
plot(ax1, tSM4, torqJV4_SM, 'm-.', 'LineWidth', 1.8,...
    'DisplayName', 'Torque joelho modelagem Simscape')
hold off
lgd = legend;
lgd.FontSize = 13;
% lgd.Location = 'best';
aex = gca;
aex.FontSize = 13;
axis tight
ylabel(ax1, 'Torque (N.m)')
title(ax1, 'Comparação do Torque do Joelho Direito para V_4 = 1.5 m/s')

% Erro JOELHO V4
ax2 = nexttile;
increm = round(size(torqJV4_SM,1)/100);
errorbar(ax2, tEL4, torqJV4_EL, torqJV4_EL - torqJV4_SM(1 : increm : end - mod(size(torqJV4_SM,1),100), 1),...
    'LineWidth',1.5)
aex = gca;
aex.FontSize = 13;
% axis tight
ylabel(ax2, 'Erro (N.m)')
xlabel(tl, 't (s)', 'FontSize', 13)
%--------------------------------------------------------------------------    
% Comparacao Torque TORNOZELO DIREITO V4
figure()
tl = tiledlayout(2,1);

ax1 = nexttile;
hold on
plot(ax1, tEL4, torqTV4_EL, 'k', 'LineWidth', 1.5, ...
    'DisplayName', 'Torque tornozelo modelagem Euler-Lagrange')
plot(ax1, tSM4, torqTV4_SM, 'k-.', 'LineWidth', 1.8,...
    'DisplayName', 'Torque tornozelo modelagem Simscape')
hold off
lgd = legend;
lgd.FontSize = 13;
% lgd.Location = 'best';
aex = gca;
aex.FontSize = 13;
% axis tight
ylabel(ax1, 'Torque (N.m)')
title(ax1,'Comparação do Torque do Tornozelo Direito para V_4 = 1.5 m/s')

% Erro TORNOZELO V4
ax2 = nexttile;
increm = round(size(torqTV4_SM,1)/100);
errorbar(ax2, tEL4, torqTV4_EL, torqTV4_EL - torqTV4_SM(1 : increm : end - mod(size(torqTV4_SM,1),100), 1),...
    'LineWidth',1.5)
aex = gca;
aex.FontSize = 13;
axis tight
ylabel(ax2, 'Erro (N.m)')
xlabel(tl, 't (s)', 'FontSize', 13)