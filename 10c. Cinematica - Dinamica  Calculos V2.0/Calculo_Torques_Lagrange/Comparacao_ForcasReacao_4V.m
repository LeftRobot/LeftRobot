
%% Carrego os datasets "Fcont_D_Vi.txt" e "Fcont_E_Vi.txt" 4 velocidades de marcha
FcontD1 = readmatrix('Fcont_D_V1.txt');
FcontE1 = readmatrix('Fcont_E_V1.txt');
 
FcontD2 = readmatrix('Fcont_D_V2.txt');
FcontE2 = readmatrix('Fcont_E_V2.txt');

FcontD3 = readmatrix('Fcont_D_V3.txt');
FcontE3 = readmatrix('Fcont_E_V3.txt');

FcontD4 = readmatrix('Fcont_D_V4.txt');
FcontE4 = readmatrix('Fcont_E_V4.txt');
% ------------------------------------------------------------------------------------------------------
% Fry1 e Frx1 Pé Direito V1
% ------------------------------------------------------------------------------------------------------
tr1D = FcontD1(:, 1);
[fry1D_cleaned,oi1Dy,tl1Dy,th1Dy] = filloutliers(FcontD1(:,2),'linear','movmean',1.016,'SamplePoints',tr1D);
fry1D_smooth = smoothdata(fry1D_cleaned,'gaussian','SmoothingFactor',0.2,'SamplePoints',tr1D);

[frx1D_cleaned,oi1Dx,tl1Dx,th1Dx] = filloutliers(FcontD1(:,3),'linear','movmean',1.016,'SamplePoints',tr1D);
frx1D_smooth = smoothdata(frx1D_cleaned,'gaussian','SmoothingFactor',0.2,'SamplePoints',tr1D);
% -------------------------------------------------------------------------------------------------------
% Fry1 e Frx1 Pé Esquerdo V1
%--------------------------------------------------------------------------------------------------------
tr1E = FcontE1(:, 1);
[fry1E_cleaned,oi1Ey,tl1Ey,th1Ey] = filloutliers(FcontE1(:,2),'linear','movmean',1.016,'SamplePoints',tr1E);
fry1E_smooth = smoothdata(fry1E_cleaned,'gaussian','SmoothingFactor',0.2,'SamplePoints',tr1E);

[frx1E_cleaned,oi1Ex,tl1Ex,th1Ex] = filloutliers(FcontE1(:,3),'linear','movmean',1.016,'SamplePoints',tr1E);
frx1E_smooth = smoothdata(frx1E_cleaned,'gaussian','SmoothingFactor',0.3,'SamplePoints',tr1E);
% --------------------------------------------------------------------------------------------------------

% ------------------------------------------------------------------------------------------------------
% Fry2 e Frx2 Pé Direito V2
% ------------------------------------------------------------------------------------------------------
tr2D = FcontD2(:, 1);
[fry2D_cleaned,oi2Dy,tl2Dy,th2Dy] = filloutliers(FcontD2(:,2),'linear','movmean',1.016,'SamplePoints',tr2D);
fry2D_smooth = smoothdata(fry2D_cleaned,'gaussian','SmoothingFactor',0.2,'SamplePoints',tr2D);

[frx2D_cleaned,oi2Dx,tl2Dx,th2Dx] = filloutliers(FcontD2(:,3),'linear','movmean',1.016,'SamplePoints',tr2D);
frx2D_smooth = smoothdata(frx2D_cleaned,'gaussian','SmoothingFactor',0.2,'SamplePoints',tr2D);
% -------------------------------------------------------------------------------------------------------
% Fry2 e Frx2 Pé Esquerdo V2
%--------------------------------------------------------------------------------------------------------
tr2E = FcontE2(:, 1);
[fry2E_cleaned,oi2Ey,tl2Ey,th2Ey] = filloutliers(FcontE2(:,2),'linear','movmean',3.016,'SamplePoints',tr2E);
fry2E_smooth = smoothdata(fry2E_cleaned,'gaussian','SmoothingFactor',0.3,'SamplePoints',tr2E);

[frx2E_cleaned,oi2Ex,tl2Ex,th2Ex] = filloutliers(FcontE2(:,3),'linear','movmean',3.0025,...
    'ThresholdFactor',3.25,'SamplePoints',tr2E);
frx2E_smooth = smoothdata(frx2E_cleaned,'gaussian','SmoothingFactor',0.5,'SamplePoints',tr2E);
% --------------------------------------------------------------------------------------------------------

% ------------------------------------------------------------------------------------------------------
% Fry3 e Frx3 Pé Direito V3
% ------------------------------------------------------------------------------------------------------
tr3D = FcontD3(:, 1);
[fry3D_cleaned,oi3Dy,tl3Dy,th3Dy] = filloutliers(FcontD3(:,2),'linear','movmean',1.016,'SamplePoints',tr3D);
fry3D_smooth = smoothdata(fry3D_cleaned,'gaussian','SmoothingFactor',0.4,'SamplePoints',tr3D);

[frx3D_cleaned,oi3Dx,tl3Dx,th3Dx] = filloutliers(FcontD3(:,3),'linear','movmean',1.016,'SamplePoints',tr3D);
frx3D_smooth = smoothdata(frx3D_cleaned,'gaussian','SmoothingFactor',0.4,'SamplePoints',tr3D);
% -------------------------------------------------------------------------------------------------------
% Fry3 e Frx3 Pé Esquerdo V3
%--------------------------------------------------------------------------------------------------------
tr3E = FcontE3(:, 1);
[fry3E_cleaned,oi3Ey,tl3Ey,th3Ey] = filloutliers(FcontE3(:,2),'linear','movmean',3.016,'SamplePoints',tr3E);
fry3E_smooth = smoothdata(fry3E_cleaned,'gaussian','SmoothingFactor',0.3,'SamplePoints',tr3E);

[frx3E_cleaned,oi3Ex,tl3Ex,th3Ex] = filloutliers(FcontE3(:,3),'linear','movmean',3.0025,...
    'ThresholdFactor',3.25,'SamplePoints',tr3E);
frx3E_smooth = smoothdata(frx3E_cleaned,'gaussian','SmoothingFactor',0.5,'SamplePoints',tr3E);
% --------------------------------------------------------------------------------------------------------

% ------------------------------------------------------------------------------------------------------
% Fry4 e Frx4 Pé Direito V4
% ------------------------------------------------------------------------------------------------------
tr4D = FcontD4(:, 1);
[fry4D_cleaned,oi4Dy,tl4Dy,th4Dy] = filloutliers(FcontD4(:,2),'linear','movmean',1.016,'SamplePoints',tr4D);
fry4D_smooth = smoothdata(fry4D_cleaned,'gaussian','SmoothingFactor',0.4,'SamplePoints',tr4D);

[frx4D_cleaned,oi4Dx,tl4Dx,th4Dx] = filloutliers(FcontD4(:,3),'linear','movmean',1.016,'SamplePoints',tr4D);
frx4D_smooth = smoothdata(frx4D_cleaned,'gaussian','SmoothingFactor',0.4,'SamplePoints',tr4D);
% -------------------------------------------------------------------------------------------------------
% Fry3 e Frx3 Pé Esquerdo V3
%--------------------------------------------------------------------------------------------------------
tr4E = FcontE4(:, 1);
[fry4E_cleaned,oi4Ey,tl4Ey,th4Ey] = filloutliers(FcontE4(:,2),'linear','movmean',3.016,'SamplePoints',tr4E);
fry4E_smooth = smoothdata(fry4E_cleaned,'gaussian','SmoothingFactor',0.4,'SamplePoints',tr4E);

[frx4E_cleaned,oi4Ex,tl4Ex,th4Ex] = filloutliers(FcontE4(:,3),'linear','movmean',3.0025,...
    'ThresholdFactor',3.25,'SamplePoints',tr4E);
frx4E_smooth = smoothdata(frx4E_cleaned,'gaussian','SmoothingFactor',0.5,'SamplePoints',tr4E);
% --------------------------------------------------------------------------------------------------------

%% Comparacao forca de reacao tangencial Fry para 4 velocidades de marcha
figure('Name', 'Gráfico Comparacao Forca Reacao Vertical 2 pernas')
tiledlayout(2,1)

ax1 = nexttile;
plot(ax1, tr1D,fry1D_smooth,'Color', [237 177 32]/255, 'LineWidth',1.5, 'DisplayName',...
    'Fr_y para V_1 = 0.5 m/s')
hold on
plot(ax1, tr2D,fry2D_smooth,'b', 'LineWidth',1.5, 'DisplayName',...
    'Fr_y para V_2 = 1.0 m/s')
plot(ax1, tr3D,fry3D_smooth,'m', 'LineWidth',1.5, 'DisplayName',...
    'Fr_y para V_3 = 1.2 m/s')
plot(ax1, tr4D,fry4D_smooth,'k', 'LineWidth',1.5, 'DisplayName',...
    'Fr_y para V_4 = 1.5 m/s')
hold off
lgd = legend;
lgd.FontSize = 10;
lgd.Location = 'best';
aix = gca;
aix.FontSize = 12;
axis tight
xlabel(ax1, 't_{ciclo}(s)')
ylabel(ax1, 'Fr_y(N)')
title(ax1, 'Força de reação vertical da perna direita para 4 velocidades de marcha')

ax2 = nexttile;
plot(ax2, tr1E, fry1E_smooth,'Color', [237 177 32]/255, 'LineWidth',1.5, 'DisplayName',...
    'Fr_y para V_1 = 0.5 m/s')
hold on
plot(ax2, tr2E, fry2E_smooth,'b', 'LineWidth',1.5, 'DisplayName',...
    'Fr_y para V_2 = 1.0 m/s')
plot(ax2, tr3E, fry3E_smooth,'m', 'LineWidth',1.5, 'DisplayName',...
    'Fr_y para V_3 = 1.2 m/s')
plot(ax2, tr4E, fry4E_smooth,'k', 'LineWidth',1.5, 'DisplayName',...
    'Fr_y para V_4 = 1.5 m/s')
hold off
lgd = legend;
lgd.FontSize = 10;
lgd.Location = 'best';
aix = gca;
aix.FontSize = 12;
axis tight
xlabel(ax2, 't_{ciclo}(s)')
ylabel(ax2, 'Fr_y(N)')
title(ax2, 'Força de reação vertical da perna esquerda para 4 velocidades de marcha')

%% Comparacao forca de reacao tangencial Frx 4 velocidades de marcha

figure('Name', 'Gráfico Comparacao Forca Reacao Tangencial 2 pernas')
tiledlayout(2,1)
ax3 = nexttile;
plot(ax3, tr1D, frx1D_smooth,'Color', [237 177 32]/255, 'LineWidth',1.5, 'DisplayName',...
    'Fr_x para V_1 = 0.5 m/s')
hold on
plot(ax3, tr2D, frx2D_smooth,'b', 'LineWidth',1.5, 'DisplayName',...
    'Fr_x para V_2 = 1.0 m/s')
plot(ax3, tr3D, frx3D_smooth,'m', 'LineWidth',1.5, 'DisplayName',...
    'Fr_x para V_3 = 1.2 m/s')
plot(ax3, tr4D, frx4D_smooth,'k', 'LineWidth',1.5, 'DisplayName',...
    'Fr_x para V_4 = 1.5 m/s')
hold off
lgd = legend;
lgd.FontSize = 10;
lgd.Location = 'best';
aix = gca;
aix.FontSize = 12;
axis tight
xlabel(ax3, 't_{ciclo}(s)')
ylabel(ax3, 'Fr_x(N)')
title(ax3, 'Força de reação tangencial da perna direita para 4 velocidades de marcha')

ax4 = nexttile;
plot(ax4, tr1E, frx1E_smooth,'Color', [237 177 32]/255, 'LineWidth',1.5, 'DisplayName',...
    'Fr_x para V_1 = 0.5 m/s')
hold on
plot(ax4, tr2E, frx2E_smooth,'b', 'LineWidth',1.5, 'DisplayName',...
    'Fr_x para V_2 = 1.0 m/s')
plot(ax4, tr3E, frx3E_smooth,'m', 'LineWidth',1.5, 'DisplayName',...
    'Fr_x para V_3 = 1.2 m/s')
plot(ax4, tr4E, frx4E_smooth,'k', 'LineWidth',1.5, 'DisplayName',...
    'Fr_x para V_4 = 1.5 m/s')
hold off
lgd = legend;
lgd.FontSize = 10;
lgd.Location = 'best';
aix = gca;
aix.FontSize = 12;
axis tight
xlabel(ax4, 't_{ciclo}(s)')
ylabel(ax4, 'Fr_x(N)')
title(ax4, 'Força de reação tangencial da perna esquerda para 4 velocidades de marcha')

%% Comparacao da distancia de separacao \delta 4 velocidades de marcha
figure('Name', 'Comparacao Distância Separacao 4 velocidades')
tiledlayout(2,1)
ax5 = nexttile;
hold on
plot(ax5, tr1D, FcontD1(:,4),'Color', [237 177 32]/255, 'LineWidth',1.5, 'DisplayName',...
    '\delta para V_1 = 0.5 m/s')

plot(ax5, tr2D, FcontD2(:,4),'b', 'LineWidth',1.5, 'DisplayName',...
    '\delta para V_2 = 1.0 m/s')
plot(ax5, tr3D, FcontD3(:,4),'m', 'LineWidth',1.5, 'DisplayName',...
    '\delta para V_3 = 1.2 m/s')
plot(ax5, tr4D, FcontD4(:,4),'k', 'LineWidth',1.5, 'DisplayName',...
    '\delta para V_4 = 1.5 m/s')
hold off
lgd = legend;
lgd.FontSize = 12;
lgd.Location = 'best';
aix = gca;
aix.FontSize = 12;
axis tight
xlabel(ax5, 't_{ciclo}(s)')
ylabel(ax5, '\delta (m)')
title(ax5, 'Distância de separação do pé direito para 4 velocidades de marcha')

ax6 = nexttile;
hold on
plot(ax6, tr1E, FcontE1(:,4),'Color', [237 177 32]/255, 'LineWidth',1.5, 'DisplayName',...
    '\delta para V_1 = 0.5 m/s')

plot(ax6, tr2E, FcontE2(:,4),'b', 'LineWidth',1.5, 'DisplayName',...
    '\delta para V_2 = 1.0 m/s')
plot(ax6, tr3E, FcontE3(:,4),'m', 'LineWidth',1.5, 'DisplayName',...
    '\delta para V_3 = 1.2 m/s')
plot(ax6, tr4E, FcontE4(:,4),'k', 'LineWidth',1.5, 'DisplayName',...
    '\delta para V_4 = 1.5 m/s')
hold off
lgd = legend;
lgd.FontSize = 12;
lgd.Location = 'best';
aix = gca;
aix.FontSize = 12;
axis tight
xlabel(ax6, 't_{ciclo}(s)')
ylabel(ax6, '\delta (m)')
title(ax6, 'Distância de separação do pé esquerdo para 4 velocidades de marcha')
