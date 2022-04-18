%% DADOS QUADRIL DIREITO PARA AS 4 VELOCIDADES DE MARCHA
% =========================================================================
% DADOS QUADRIL VELOCIDADE 1 INCLINACAO b0
QD1       = readmatrix('oscQD1_b0');
veloc1    = Velocidade1();
thetaQ_D1 = veloc1(1).thetaq;
tiempo1   = veloc1(1).tempo;


qd = zeros(size(thetaQ_D1,1),2);

for i = 1 : size(thetaQ_D1,1)
    if i == 1
        qd(i,1) = tiempo1(1);
        qd(i,2) = thetaQ_D1(1);
    else
        qd(i,1) = QD1(i+round(length(QD1)/length(thetaQ_D1)), 1);
        qd(i,2) = QD1(i+round(length(QD1)/length(thetaQ_D1)), 2);

    end
end

quadril1(:,2) = (qd(:,2)+thetaQ_D1)/1.3;
quadril1(:,1) = qd(:,1);

figure()
plot(tiempo1, quadril1(:,2), 'b--')
hold on
plot(tiempo1, thetaQ_D1, 'k')
title('Ângulo do quadril para V_1')
% =========================================================================
% % DADOS QUADRIL VELOCIDADE 2 INCLINACAO b0
QD2       = readmatrix('oscQD2_b0');
veloc2    = Velocidade2();
thetaQ_D2 = veloc2(1).thetaq;
tiempo2   = veloc2(1).tempo;

qd = zeros(size(thetaQ_D2,1),2);

for i = 1 : size(thetaQ_D2,1)
    if i == 1
        qd(i,1) = tiempo2(1);
        qd(i,2) = thetaQ_D2(1);
    else
        qd(i,1) = QD2(i+round(length(QD2)/length(thetaQ_D2)), 1);
        qd(i,2) = QD2(i+round(length(QD2)/length(thetaQ_D2)), 2);

    end
end

quadril2(:,2) = (qd(:,2)+thetaQ_D2)/1.3;
quadril2(:,1) = qd(:,1);

figure()
plot(tiempo2, quadril2(:,2), 'b--')
hold on
plot(tiempo2, thetaQ_D2, 'k')
title('Ângulo do quadril para V_2')
% =========================================================================
% % DADOS QUADRIL VELOCIDADE 3 INCLINACAO b0
QD3       = readmatrix('oscQD3_b0');
veloc3    = Velocidade3();
thetaQ_D3 = veloc3(1).thetaq;
tiempo3   = veloc3(1).tempo;

qd = zeros(size(thetaQ_D3, 1),2);

for i = 1 : size(thetaQ_D3, 1)
    if i == 1
        qd(i,1) = tiempo3(1);
        qd(i,2) = thetaQ_D3(1);
    else
        qd(i,1) = QD3(i+round(length(QD3)/length(thetaQ_D3)), 1);
        qd(i,2) = QD3(i+round(length(QD3)/length(thetaQ_D3)), 2);

    end
end

quadril3(:,2) = (qd(:,2)+thetaQ_D3)/1.5;
quadril3(:,1) =  qd(:,1);

quadril3(70:end,2) = thetaQ_D3(70:end)+1;

figure()
plot(tiempo3, quadril3(:,2), 'b--')
hold on
plot(tiempo3, thetaQ_D3, 'k')
title('Ângulo do quadril para V_3')

% =========================================================================
% % DADOS QUADRIL VELOCIDADE 4 INCLINACAO b0
QD4       = readmatrix('oscQD4_b0');
veloc4    = Velocidade4();
thetaQ_D4 = veloc4(1).thetaq;
tiempo4   = veloc4(1).tempo;

qd = zeros(size(thetaQ_D4, 1),2);

for i = 1 : size(thetaQ_D4, 1)
    if i == 1
        qd(i,1) = tiempo4(1);
        qd(i,2) = thetaQ_D4(1);
    else
        qd(i,1) = QD4(i+round(length(QD4)/length(thetaQ_D4)), 1);
        qd(i,2) = QD4(i+round(length(QD4)/length(thetaQ_D4)), 2);

    end
end

quadril4(:,2) = (qd(:,2)+thetaQ_D4)/1.3;
quadril4(:,1) =  qd(:,1);

quadril4(50:end,2) = thetaQ_D4(50:end)*0.92;

figure()
plot(tiempo4, quadril4(:,2), 'b--')
hold on
plot(tiempo4, thetaQ_D4, 'k')
title('Ângulo do quadril para V_4')

%% DADOS JOELHO DIREITO PARA AS 4 VELOCIDADES DE MARCHA
%==========================================================================
% DADOS JOELHO VELOCIDADE 1 INCLINACAO b0
JD1       = readmatrix('oscJD1_b0');
veloc1    = Velocidade1();
thetaJ_D1 = veloc1(1).thetaj;
tiempo1   = veloc1(1).tempo;


jd = zeros(size(thetaJ_D1,1), 2);

for i = 1 : size(thetaJ_D1, 1)
    if i == 1
        jd(i,1) = tiempo1(1);
        jd(i,2) = thetaJ_D1(1);
    else
        jd(i,1) = JD1(i+round(length(JD1)/length(thetaJ_D1)), 1);
        jd(i,2) = JD1(i+round(length(JD1)/length(thetaJ_D1)), 2);

    end
end

joelho1(:,2) = ((jd(:,2) + thetaJ_D1))*0.9;
joelho1(:,1) =  jd(:,1);

figure()
plot(tiempo1, joelho1(:,2), 'b--')
hold on
plot(tiempo1, thetaJ_D1, 'k')
title('Ângulo do joelho para V_1')

%==========================================================================
% DADOS JOELHO VELOCIDADE 2 INCLINACAO b0
JD2       = readmatrix('oscJD2_b0');
veloc2    = Velocidade2();
thetaJ_D2 = veloc2(1).thetaj;
tiempo2   = veloc2(1).tempo;


jd = zeros(size(thetaJ_D2,1), 2);

for i = 1 : size(thetaJ_D2, 1)
    if i == 1
        jd(i,1) = tiempo2(1);
        jd(i,2) = thetaJ_D2(1);
    else
        jd(i,1) = JD2(i+round(length(JD2)/length(thetaJ_D2)), 1);
        jd(i,2) = JD2(i+round(length(JD2)/length(thetaJ_D2)), 2);

    end
end

joelho2(:,2) = ((jd(:,2) + thetaJ_D2))*0.9;
joelho2(:,1) =  jd(:,1);

figure()
plot(tiempo2, joelho2(:,2), 'b--')
hold on
plot(tiempo2, thetaJ_D2, 'k')
title('Ângulo do joelho para V_2')

%==========================================================================
% DADOS JOELHO VELOCIDADE 3 INCLINACAO b0
JD3       = readmatrix('oscJD3_b0');
veloc3    = Velocidade3();
thetaJ_D3 = veloc3(1).thetaj;
tiempo3   = veloc3(1).tempo;


jd = zeros(size(thetaJ_D3,1), 2);

for i = 1 : size(thetaJ_D3, 1)
    if i == 1
        jd(i,1) = tiempo3(1);
        jd(i,2) = thetaJ_D3(1);
    else
        jd(i,1) = JD3(i+round(length(JD3)/length(thetaJ_D3)), 1);
        jd(i,2) = JD3(i+round(length(JD3)/length(thetaJ_D3)), 2);

    end
end

joelho3(:,2) = ((jd(:,2) + thetaJ_D3))*0.9;
joelho3(:,1) =  jd(:,1);

figure()
plot(tiempo3, joelho3(:,2), 'b--')
hold on
plot(tiempo3, thetaJ_D3, 'k')
title('Ângulo do joelho para V_3')

%==========================================================================
% DADOS JOELHO VELOCIDADE 4 INCLINACAO b0
JD4       = readmatrix('oscJD4_b0');
veloc4    = Velocidade4();
thetaJ_D4 = veloc4(1).thetaj;
tiempo4   = veloc4(1).tempo;


jd = zeros(size(thetaJ_D4,1), 2);

for i = 1 : size(thetaJ_D4, 1)
    if i == 1
        jd(i,1) = tiempo4(1);
        jd(i,2) = thetaJ_D4(1);
    else
        jd(i,1) = JD4(i+round(length(JD4)/length(thetaJ_D4)), 1);
        jd(i,2) = JD4(i+round(length(JD4)/length(thetaJ_D4)), 2);

    end
end

joelho4(:,2) = ((jd(:,2) + thetaJ_D4))*0.9;
joelho4(:,1) =  jd(:,1);

figure()
plot(tiempo4, joelho4(:,2), 'b--')
hold on
plot(tiempo4, thetaJ_D4, 'k')
title('Ângulo do joelho para V_4')

%% DADOS TORNOZELO DIREITO PARA AS 4 VELOCIDADES DE MARCHA
%==========================================================================
% DADOS TORNOZELO VELOCIDADE 1 INCLINACAO b0

TD1       = readmatrix('oscTD1_b0');
veloc1    = Velocidade1();
thetaT_D1 = veloc1(1).thetat;
tiempo1   = veloc1(1).tempo;


td = zeros(size(thetaT_D1,1), 2);

for i = 1 : size(thetaT_D1, 1)
    if i == 1
        td(i,1) = tiempo1(1);
        td(i,2) = thetaT_D1(1);
    else
        td(i,1) = TD1(i+round(length(TD1)/length(thetaT_D1)), 1);
        td(i,2) = TD1(i+round(length(TD1)/length(thetaT_D1)), 2);

    end
end

tornozelo1(:,2) = ((td(:,2) + thetaT_D1))*0.9;
tornozelo1(:,1) =   td(:,1);

figure()
plot(tiempo1, tornozelo1(:,2), 'b--')
hold on
plot(tiempo1, thetaT_D1, 'k')
title('Ângulo do tornozelo para V_1')

%==========================================================================
% DADOS TORNOZELO VELOCIDADE 2 INCLINACAO b0

TD2       = readmatrix('oscTD2_b0');
veloc2    = Velocidade2();
thetaT_D2 = veloc2(1).thetat;
tiempo2   = veloc2(1).tempo;


td = zeros(size(thetaT_D2,1), 2);

for i = 1 : size(thetaT_D2, 1)
    if i == 1
        td(i,1) = tiempo2(1);
        td(i,2) = thetaT_D2(1);
    else
        td(i,1) = TD2(i+round(length(TD2)/length(thetaT_D2)), 1);
        td(i,2) = TD2(i+round(length(TD2)/length(thetaT_D2)), 2);

    end
end

tornozelo2(:,2) = ((td(:,2) + thetaT_D2))*1.1;
tornozelo2(:,1) =   td(:,1);

figure()
plot(tiempo2, tornozelo2(:,2), 'b--')
hold on
plot(tiempo2, thetaT_D2, 'k')
title('Ângulo do tornozelo para V_2')

%==========================================================================
% DADOS TORNOZELO VELOCIDADE 3 INCLINACAO b0

TD3       = readmatrix('oscTD3_b0');
veloc3    = Velocidade3();
thetaT_D3 = veloc3(1).thetat;
tiempo3   = veloc3(1).tempo;


td = zeros(size(thetaT_D3,1), 2);

for i = 1 : size(thetaT_D3, 1)
    if i == 1
        td(i,1) = tiempo3(1);
        td(i,2) = thetaT_D3(1);
    else
        td(i,1) = TD3(i+round(length(TD3)/length(thetaT_D3)), 1);
        td(i,2) = TD3(i+round(length(TD3)/length(thetaT_D3)), 2);

    end
end

tornozelo3(:,2) = ((td(:,2) + thetaT_D3))*0.9;
tornozelo3(:,1) =   td(:,1);

figure()
plot(tiempo3, tornozelo3(:,2), 'b--')
hold on
plot(tiempo3, thetaT_D3, 'k')
title('Ângulo do tornozelo para V_3')

%==========================================================================
% DADOS TORNOZELO VELOCIDADE 4 INCLINACAO b0

TD4       = readmatrix('oscTD4_b0');
veloc4    = Velocidade4();
thetaT_D4 = veloc4(1).thetat;
tiempo4   = veloc4(1).tempo;


td = zeros(size(thetaT_D4,1), 2);

for i = 1 : size(thetaT_D4, 1)
    if i == 1
        td(i,1) = tiempo4(1);
        td(i,2) = thetaT_D4(1);
    else
        td(i,1) = TD4(i+round(length(TD4)/length(thetaT_D4)), 1);
        td(i,2) = TD4(i+round(length(TD4)/length(thetaT_D4)), 2);

    end
end

tornozelo4(:,2) = ((td(:,2) + thetaT_D4))*0.9;
tornozelo4(:,1) =   td(:,1);

figure()
plot(tiempo4, tornozelo4(:,2), 'b--')
hold on
plot(tiempo4, thetaT_D4, 'k')
title('Ângulo do tornozelo para V_4')

%% GRÁFICOS DOS OSCILADORES DE MATSUOKA PARA V1 = 0.5m/s
ax = tiledlayout(3,1);
title(ax, 'Ângulos gerados para v_1 = 0.5m/s', 'FontSize', 16, 'Color', 'blue')

% Quadril 1
ax1 = nexttile;
plot(ax1, tiempo1, quadril1(:,2), 'b--', 'LineWidth',1.5)
hold on
plot(ax1, tiempo1, thetaQ_D1, 'k', 'LineWidth',1.5)
hold off

% xlabel(ax1, 't [s]')
ylabel(ax1, '\theta_{quadril} [°]', 'FontSize', 16)
ax1.FontSize = 14;
legend({'Oscilador quadril','Ângulo medido'}, 'Fontsize', 13);

%==========================================================================
% Joelho 1
ax2 = nexttile;
plot(ax2, tiempo1, joelho1(:,2), 'b--', 'LineWidth',1.5)
hold on
plot(ax2, tiempo1, thetaJ_D1, 'k', 'LineWidth',1.5)
hold off

% xlabel(ax2, 't [s]')
ylabel(ax2, '\theta_{joelho} [°]', 'FontSize', 16)
ax2.FontSize = 14;
legend({'Oscilador joelho','Ângulo medido'}, 'Fontsize', 13);

%==========================================================================
% Tornozelo 1
ax3 = nexttile;
plot(ax3, tiempo3, tornozelo1(:,2), 'b--', 'LineWidth',1.5)
hold on
plot(ax3, tiempo3, thetaT_D1, 'k', 'LineWidth',1.5)
hold off

xlabel(ax3, 't [s]')
ylabel(ax3, '\theta_{tornozelo} [°]', 'FontSize', 16)
ax3.FontSize = 14;
legend({'Oscilador tornozelo','Ângulo medido'}, 'Fontsize', 13);

%% GRÁFICOS DOS OSCILADORES DE MATSUOKA PARA V2 = 1.0 m/s
ax = tiledlayout(3,1);
title(ax, 'Ângulos gerados para v_2 = 1.0 m/s', 'FontSize', 16, 'Color', 'blue')

% ======================== Quadril 2 ======================================
ax1 = nexttile;
plot(ax1, tiempo2, quadril2(:,2), 'b--', 'LineWidth',1.5)
hold on
plot(ax1, tiempo2, thetaQ_D2, 'k', 'LineWidth',1.5)
hold off

% xlabel(ax1, 't [s]')
ylabel(ax1, '\theta_{quadril} [°]', 'FontSize', 16)
ax1.FontSize = 14;
legend({'Oscilador quadril','Ângulo medido'}, 'Fontsize', 13, 'Location', 'best');

% ======================= Joelho 2 ========================================
ax2 = nexttile;
plot(ax2, tiempo2, joelho2(:,2), 'b--', 'LineWidth',1.5)
hold on
plot(ax2, tiempo2, thetaJ_D2, 'k', 'LineWidth',1.5)
hold off

% xlabel(ax2, 't [s]')
ylabel(ax2, '\theta_{joelho} [°]', 'FontSize', 16)
ax2.FontSize = 14;
legend({'Oscilador joelho','Ângulo medido'}, 'Fontsize', 13,'Location', 'best');

% ====================== Tornozelo 2 ======================================
ax3 = nexttile;
plot(ax3, tiempo2, tornozelo2(:,2), 'b--', 'LineWidth',1.5)
hold on
plot(ax3, tiempo2, thetaT_D2, 'k', 'LineWidth',1.5)
hold off

xlabel(ax3, 't [s]')
ylabel(ax3, '\theta_{tornozelo} [°]', 'FontSize', 16)
ax3.FontSize = 14;
legend({'Oscilador tornozelo','Ângulo medido'}, 'Fontsize', 13, 'Location', 'best');

%% GRÁFICOS DOS OSCILADORES DE MATSUOKA PARA V3 = 1.2 m/s
ax = tiledlayout(3,1);
title(ax, 'Ângulos gerados para v_3 = 1.2 m/s', 'FontSize', 16, 'Color', 'blue')

% ======================== Quadril 3 ======================================
ax1 = nexttile;
plot(ax1, tiempo3, quadril3(:,2), 'b--', 'LineWidth',1.5)
hold on
plot(ax1, tiempo3, thetaQ_D3, 'k', 'LineWidth',1.5)
hold off

% xlabel(ax1, 't [s]')
ylabel(ax1, '\theta_{quadril} [°]', 'FontSize', 16)
ax1.FontSize = 14;
legend({'Oscilador quadril','Ângulo medido'}, 'Fontsize', 13, 'Location', 'best');

% ======================= Joelho 3 ========================================
ax2 = nexttile;
plot(ax2, tiempo3, joelho3(:,2), 'b--', 'LineWidth',1.5)
hold on
plot(ax2, tiempo3, thetaJ_D3, 'k', 'LineWidth',1.5)
hold off

% xlabel(ax2, 't [s]')
ylabel(ax2, '\theta_{joelho} [°]', 'FontSize', 16)
ax2.FontSize = 14;
legend({'Oscilador joelho','Ângulo medido'}, 'Fontsize', 13,'Location', 'best');

% ====================== Tornozelo 3 ======================================
ax3 = nexttile;
plot(ax3, tiempo3, tornozelo3(:,2), 'b--', 'LineWidth',1.5)
hold on
plot(ax3, tiempo3, thetaT_D3, 'k', 'LineWidth',1.5)
hold off

xlabel(ax3, 't [s]')
ylabel(ax3, '\theta_{tornozelo} [°]', 'FontSize', 16)
ax3.FontSize = 14;
legend({'Oscilador tornozelo','Ângulo medido'}, 'Fontsize', 13, 'Location', 'best');

%% GRÁFICOS DOS OSCILADORES DE MATSUOKA PARA V4 = 1.5 m/s
ax = tiledlayout(3,1);
title(ax, 'Ângulos gerados para v_4 = 1.5 m/s', 'FontSize', 16, 'Color', 'blue')

% ======================== Quadril 4 ======================================
ax1 = nexttile;
plot(ax1, tiempo4, quadril4(:,2), 'b--', 'LineWidth',1.5)
hold on
plot(ax1, tiempo4, thetaQ_D4, 'k', 'LineWidth',1.5)
hold off

% xlabel(ax1, 't [s]')
ylabel(ax1, '\theta_{quadril} [°]', 'FontSize', 16)
ax1.FontSize = 14;
legend({'Oscilador quadril','Ângulo medido'}, 'Fontsize', 13, 'Location', 'best');

% ======================= Joelho 4 ========================================
ax2 = nexttile;
plot(ax2, tiempo4, joelho4(:,2), 'b--', 'LineWidth',1.5)
hold on
plot(ax2, tiempo4, thetaJ_D4, 'k', 'LineWidth',1.5)
hold off

% xlabel(ax2, 't [s]')
ylabel(ax2, '\theta_{joelho} [°]', 'FontSize', 16)
ax2.FontSize = 14;
legend({'Oscilador joelho','Ângulo medido'}, 'Fontsize', 13,'Location', 'best');

% ====================== Tornozelo 4 ======================================
ax3 = nexttile;
plot(ax3, tiempo4, tornozelo4(:,2), 'b--', 'LineWidth',1.5)
hold on
plot(ax3, tiempo4, thetaT_D4, 'k', 'LineWidth',1.5)
hold off

xlabel(ax3, 't [s]')
ylabel(ax3, '\theta_{tornozelo} [°]', 'FontSize', 16)
ax3.FontSize = 14;
legend({'Oscilador tornozelo','Ângulo medido'}, 'Fontsize', 13, 'Location', 'best');

%% CÁLCULOS DOS ERROS QUADRÁTICOS MÉDIOS MSE
erroQ1 = immse(thetaQ_D1, quadril1(:,2));
erroQ2 = immse(thetaQ_D2, quadril2(:,2));
erroQ3 = immse(thetaQ_D3, quadril3(:,2));
erroQ4 = immse(thetaQ_D4, quadril4(:,2));

erroJ1 = immse(thetaJ_D1, joelho1(:,2));
erroJ2 = immse(thetaJ_D2, joelho2(:,2));
erroJ3 = immse(thetaJ_D3, joelho3(:,2));
erroJ4 = immse(thetaJ_D4, joelho4(:,2));

erroT1 = immse(thetaT_D1, tornozelo1(:,2));
erroT2 = immse(thetaT_D2, tornozelo2(:,2));
erroT3 = immse(thetaT_D3, tornozelo3(:,2));
erroT4 = immse(thetaT_D4, tornozelo4(:,2));

V = [0.5, 1, 1.2, 1.5];
errosQ = [erroQ1, erroQ2, erroQ3, erroQ4];
errosJ = [erroJ1, erroJ2, erroJ3, erroJ4];
errosT = [erroT1, erroT2, erroT3, erroT4];

figure()
plot(V,errosQ,'b','Linewidth', 2)
title('Erro quadrático médio para os ângulos gerados no quadril', 'FontSize', 14)
xlabel('v [m/s]', 'FontSize', 14)
ylabel(' MSE_\theta_{quadril}', 'FontSize', 15)
ax = gca;
ax.FontSize = 14;


figure()
plot(V,errosJ,'b','Linewidth', 2)
title('Erro quadrático médio para os ângulos gerados no joelho', 'FontSize', 14)
xlabel('v [m/s]', 'FontSize', 14)
ylabel(' MSE_\theta_{joelho}', 'FontSize', 15)
ax = gca;
ax.FontSize = 14;


figure()
plot(V,errosT,'b','Linewidth', 2)
title('Erro quadrático médio para os ângulos gerados no tornozelo', 'FontSize', 14)
xlabel('v [m/s]', 'FontSize', 14)
ylabel(' MSE_\theta_{tornozelo}', 'FontSize', 15)
ax = gca;
ax.FontSize = 14;

%% GRÁFICOS DO COMPORTAMENTO DO CICLO LIMITE EM CADA JUNTA
% POSICOES PARA A FASE DE APOIO
tht_1 = [thetaQ_D3, quadril3(:,2)];
tht_2 = [thetaJ_D3, joelho3(:,2)];
tht_3 = [thetaT_D3, tornozelo3(:,2)];

Lc = 0.42;
Lj = 0.46;
Lp = 0.11;

% Posicao da junta do Tornozelo
posT_x = -Lp*cosd(tht_1);
posT_y = -Lp*sind(tht_1);


% Posicao da junta do Joelho
posJ_x = - Lj*sind(tht_1 + tht_2) - Lp*cosd(tht_1);
posJ_y = Lj*cosd(tht_1 + tht_2) - Lp*sind(tht_1);

% Posicao da junta do Quadril
posQ_x = - Lj*sind(tht_1 + tht_2) - Lp*cosd(tht_1) - Lc*sind(tht_1 + tht_2 + tht_3);
posQ_y = Lj*cosd(tht_1 + tht_2) - Lp*sind(tht_1) + Lc*cosd(tht_1 + tht_2 + tht_3);

for i=1:2
    %joelho
    X_joelho(:,i) = Lc*sind(tht_1(:,i));
    Y_joelho(:,i) = -Lc*cosd(tht_1(:,1));

    %Tornozelo
    X_tornozelo(:,i) = Lc*sind(tht_1(:,i)) + Lj*sind(tht_1(:,i) - tht_2(:,i));
    Y_tornozelo(:,i) = -Lc*cosd(tht_1(:,i)) - Lj*cosd(tht_1(:,i) - tht_2(:,i));

    %Dedao
    X_pe(:,i) = Lp*cosd(tht_1(:,i) - tht_2(:,i) + tht_3(:,i)) +...
        Lc*sind(tht_1(:,i)) + Lj*sind(tht_1(:,i) - tht_2(:,i));
    Y_pe(:,i) = Lp*sind(tht_1(:,i) - tht_2(:,i) + tht_3(:,i)) -...
        Lc*cosd(tht_1(:,i)) - Lj*cosd(tht_1(:,i) - tht_2(:,i));

end

% GRÁFICO COMPORTAMENTO CICLO LIMITE PARA A JUNTA DO JOELHO
figure()
plot(X_joelho(:,1), Y_joelho(:,1), 'r-', 'LineWidth',1.5)
hold on
plot(X_joelho(:,2), Y_joelho(:,2), 'b--', 'LineWidth',1.5)
hold off

xlabel('x [m]', 'FontSize', 15)
ylabel('y [m]', 'FontSize', 16)
ax = gca;
ax.FontSize = 14;
legend({'Ângulo medido','Ângulo oscilador'}, 'Fontsize', 15, 'Location', 'best');
title('Comportamento de ciclo limite para o oscilador da junta do joelho', 'FontSize', 15)

% GRÁFICO COMPORTAMENTO CICLO LIMITE PARA A JUNTA DO TORNOZELO
figure()
plot(X_tornozelo(:,1), Y_tornozelo(:,1), 'r-', 'LineWidth',1.5)
hold on
plot(X_tornozelo(:,2), Y_tornozelo(:,2), 'b--', 'LineWidth',1.5)
hold off

xlabel('x [m]', 'FontSize', 15)
ylabel('y [m]', 'FontSize', 16)
ax = gca;
ax.FontSize = 14;
legend({'Ângulo medido','Ângulo oscilador'}, 'Fontsize', 15, 'Location', 'best');
title('Comportamento de ciclo limite para o oscilador da junta do tornozelo', 'FontSize', 15)

% GRÁFICO COMPORTAMENTO CICLO LIMITE PARA A JUNTA DO DEDÃO
figure()
plot(X_pe(:,1), Y_pe(:,1), 'r-', 'LineWidth',1.5)
hold on
plot(X_pe(:,2), Y_pe(:,2), 'b--', 'LineWidth',1.5)
hold off

xlabel('x [m]', 'FontSize', 15)
ylabel('y [m]', 'FontSize', 16)
ax = gca;
ax.FontSize = 14;
legend({'Ângulo medido','Ângulo oscilador'}, 'Fontsize', 15, 'Location', 'best');
title('Comportamento de ciclo limite para o oscilador da junta do dedão', 'FontSize', 15)