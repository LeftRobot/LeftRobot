%%%%%%%%%%%%%%%%%%  MODELO GEOMÉTRICO LUIS %%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clear all;
clc;

%% COMPRIMENTO DOS ELOS
Lc = 0.42;          % Comprimento coxa (m)
Lj = 0.46;          % Comprimento da perna (m)
Lp = 0.11;          % Comprimento do pé(m)

%% VELOCIDADE PADRÃO DE MARCHA V = 1 m/s

%Dados ÂNGULOS Velocidade 2 (sheet '1 ms') perna direita
Dados_AngV2_D = xlsread('DataBaseOffset.xlsx', '1ms', 'A3:D102');

%Dados ÂNGULOS Velocidade 2 (sheet '1 ms') perna esquerda
Dados_AngV2_E = xlsread('DataBaseOffset.xlsx', '1ms', 'E3:G102');

%Dados XY Velocidade 2 (sheet '1 ms') perna direita
Dados_XY2_D = xlsread('DataBaseXY.xlsx','1ms','A4:I403');

%Dados XY Velocidade 2 (sheet '1 ms') perna esquerda
Dados_XY2_E = xlsread('DataBaseXY.xlsx','1ms','J4:Q403');

%% CICLOS DE MARCHA 

% Dados do ciclo 1 da marcha 
cic1  = 1 : 100;
% Dados do ciclo 2 da marcha
cic2  = 101 : 200;
% Dados ciclo 3 da marcha
cic3  = 201 : 300;
% Dados ciclo 4 da marcha
cic4  = 301 : 400;

ciclo = [cic1];

% Base de tempo para Velocidade 2 
tempo2 = Dados_XY2_D(ciclo,1);

% Ângulos do Quadril da Perna Direita para V2
theta_q2D = Dados_AngV2_D(:,2);
% Ângulo do  Joelho da Perna Direita para V2
theta_j2D = Dados_AngV2_D(:,3);
% Ângulo do Tornozelo da Perna Direita para V2
theta_t2D = Dados_AngV2_D(:,4);

% Ângulos do Quadril da Perna Esquerda para V2
theta_q2E = Dados_AngV2_E(:,1);
% Ângulo do  Joelho da Perna Esquerda para V2
theta_j2E = Dados_AngV2_E(:,2);
% Ângulo do Tornozelo da Perna Esquerda para V2
theta_t2E = Dados_AngV2_E(:,3);


figure('Name','Ângulos das Juntas Perna Direita');
plot(tempo2, theta_q2D,'k','LineWidth',2);
hold on
plot(tempo2, theta_j2D,'b','LineWidth',2);
hold on
plot(tempo2, theta_t2D,'r','LineWidth',2);
hold on
plot(tempo2, theta_q2E,'k--','LineWidth',1);
hold off
title('Ângulos das juntas Perna Direita em funcao de t')
xlabel('tempo [s]')
y_ang = ylabel('$\theta_{q},\theta_{j},\theta_{t}$');
set(y_ang,'Interpreter','latex');
set(y_ang,'FontSize',15);

lgd = legend('\theta_q','\theta_j','\theta_t');
lgd.Title.FontSize = 9;
lgd.Location = 'northeast';


% O valor mínimo do ângulo do quadril \theta_q marca a transicao da fase de  
% apoio para a fase de balanco
thetaq_min = min(theta_q2D);

% encontra a linha e coluna onde está o valor mínimo de theta_q
[lin,col] = find(theta_q2D == thetaq_min);

%% MODELO GEOMÉTRICO DA PERNA DIREITA NA FASE DE APOIO

% Referencial fase de apoio no tornozelo (Xt_apoioR,Yt_apoioR)
Xt_apoioR = Dados_XY2_D(1:lin,6);
Yt_apoioR = Dados_XY2_D(1:lin,7);

% % Posição do joelho em relação ao referencial no tornozelo (Xt_apoioR,Yt_apoioR)
% Xj = Xt - Lj*sen(theta_q - theta_j);datapop8.VT8
% Yj = Yt + Lj*cos(theta_q - theta_j);
Xj_apoio = Xt_apoioR - Lj*sind( theta_q2D(1:lin) - theta_j2D(1:lin) );
Yj_apoio = Yt_apoioR + Lj*cosd( theta_q2D(1:lin) - theta_j2D(1:lin) );

% Posicao em X e Y do JOELHO DIREITO DADOS OBTIDOS NA FEF
Xj2_D = Dados_XY2_D(1:lin,4);
Yj2_D = Dados_XY2_D(1:lin,5);

comp_joel_Ap = table(Xj2_D, Xj_apoio,  Yj2_D, Yj_apoio);

% % Posicao do quadril em relacao ao referencial no tornozelo (Xt_apoioR,Yt_apoioR)
% Xq = Xj - Lc*sen(theta_q);
% Yq = Yj + Lc*cos(theta_q)
Xq_apoio = Xj_apoio - Lc*sind( theta_q2D(1:lin) );
Yq_apoio = Yj_apoio + Lc*cosd( theta_q2D(1:lin) );

% Posicao em X e Y do QUADRIL DIREITO DADOS OBTIDOS NA FEF
Xq2_D = Dados_XY2_D(1:lin,2);
Yq2_D = Dados_XY2_D(1:lin,3);

comp_quad_Ap = table(Xq2_D, Xq_apoio, Yq2_D, Yq_apoio);

% % Posicao do pé em relacao ao referencial no tornozelo (Xt_apoioR,Yt_apoioR)
% Xp = Xt + Lp*sen(theta_q - theta_j + theta_t + 90);
% Yp = Yt - Lp*cos(theta_q - theta_j + theta_t + 90);
Xp_apoio = Xt_apoioR + Lp*sind( theta_q2D(1:lin) - theta_j2D(1:lin) + theta_t2D(1:lin) + 90 );
Yp_apoio = Yt_apoioR - Lp*cosd( theta_q2D(1:lin) - theta_j2D(1:lin) + theta_t2D(1:lin) + 90);

% Posicao em X e Y do PÉ DIREITO DADOS OBTIDOS NA FEF
Xp2_D = Dados_XY2_D(1:lin, 8);
Yp2_D = Dados_XY2_D(1:lin, 9);

comp_pe_Ap = table(Xp2_D, Xp_apoio, Yp2_D, Yp_apoio);

figure('Name','Posicao X Y em funcao de t Juntas Fase Apoio Perna Direita')
plot(tempo2(1:lin),Xq_apoio,':k',tempo2(1:lin),Yq_apoio,'k','LineWidth',2);
hold on
plot(tempo2(1:lin),Xj_apoio,':b',tempo2(1:lin),Yj_apoio,'b','LineWidth',2);
hold on
plot(tempo2(1:lin),Xt_apoioR,':r',tempo2(1:lin),Yt_apoioR,'r','LineWidth',2);
hold on
plot(tempo2(1:lin),Xp_apoio,':y',tempo2(1:lin),Yp_apoio,'y','LineWidth',2);
hold off
title('Posicao X Y em funcao de t Fase Apoio juntas Perna Direita')
xlabel('tempo [s]')
posA=ylabel('$X_{pa},Y_{pa},X_{ta},Y_{ta},X_{ja},Y_{ja},X_{qa},Y_{qa}$');
set(posA,'Interpreter','latex');
set(posA,'FontSize',14);

figure('Name','Y funcao X Juntas Fase Apoio Perna Direita')
plot(Xq_apoio,Yq_apoio,'k','LineWidth',2);
hold on
plot(Xj_apoio,Yj_apoio,'b','LineWidth',2);
hold on
plot(Xt_apoioR,Yt_apoioR,'r','LineWidth',2);
hold on
plot(Xp_apoio,Yp_apoio,'y','LineWidth',2);
hold off
title('Y em funcao de X para cada junta Fase Apoio da Perna Direita')
xposA = xlabel('$X_{pa},X_{ta},X_{ja},X_{qa}$');
set(xposA,'Interpreter','latex');
set(xposA,'FontSize',14);
yposA = ylabel('$Y_{pa},Y_{ta},Y_{ja},Y_{qa}$');
set(yposA,'Interpreter','latex');
set(yposA,'FontSize',14);


%% MODELO GEOMÉTRICO DA PERNA DIREITA NA FASE DE BALANCO

% Referencial fase de balanco no quadril (Xq_balanR,Yq_balanR)
Xq_balanR = Dados_XY2_D(lin+1:100,2);
Yq_balanR = Dados_XY2_D(lin+1:100,3);

% % Posição do joelho em relação ao referencial no quadril (Xq_balanR,Yq_balanR)
Xj_balan = Xq_balanR + Lc*sind( theta_q2D(lin+1:100) );
Yj_balan = Yq_balanR - Lc*cosd( theta_q2D(lin+1:100) );

% Posicao em X e Y do JOELHO DIREITO DADOS OBTIDOS NA FEF
Xj2_D = Dados_XY2_D(lin+1:100,4);
Yj2_D = Dados_XY2_D(lin+1:100,5);

comp_joel_Bal = table(Xj2_D, Xj_balan,  Yj2_D, Yj_balan);

% % Posição do tornozelo em relação ao referencial no quadril (Xq_balanR,Yq_balanR)
Xt_balan = Xj_balan + Lj*sind( theta_q2D(lin+1:100) - theta_j2D(lin+1:100) );
Yt_balan = Yj_balan - Lj*cosd( theta_q2D(lin+1:100) - theta_j2D(lin+1:100) );

% Referencial fase de apoio no tornozelo (Xt_apoioR,Yt_apoioR)
Xt2_D = Dados_XY2_D(lin+1:100,6);
Yt2_D = Dados_XY2_D(lin+1:100,7);

comp_torn_Bal = table(Xt2_D, Xt_balan,  Yt2_D, Yt_balan);

% % Posicao do pé em relação ao referencial no quadril (Xq_balanR,Yq_balanR)
Xp_balan = Xt_balan + Lp*sind( theta_q2D(lin+1:100) - theta_j2D(lin+1:100) + theta_t2D(lin+1:100) + 90);
Yp_balan = Yt_balan - Lp*cosd( theta_q2D(lin+1:100) - theta_j2D(lin+1:100) + theta_t2D(lin+1:100) + 90);

% Referencial fase de apoio no tornozelo (Xt_apoioR,Yt_apoioR)
Xp2_D = Dados_XY2_D(lin+1:100,8);
Yp2_D = Dados_XY2_D(lin+1:100,9);

comp_pe_Bal = table(Xp2_D, Xp_balan,  Yp2_D, Yp_balan);

figure('Name','Posicao X Y em funcao de t Juntas Fase Balanco Perna Direita')

plot(tempo2(lin+1:100),Xq_balanR,':k',tempo2(lin+1:100),Yq_balanR,'k','LineWidth',2);
hold on
plot(tempo2(lin+1:100),Xj_balan,':b',tempo2(lin+1:100),Yj_balan,'b','LineWidth',2);
hold on
plot(tempo2(lin+1:100),Xt_balan,':r',tempo2(lin+1:100),Yt_balan,'r','LineWidth',2);
hold on
plot(tempo2(lin+1:100),Xp_balan,':y',tempo2(lin+1:100),Yp_balan,'y','LineWidth',2);
hold off
title('Posicao X Y em funcao de t Fase Balanco juntas Perna Direita')
xlabel('tempo [s]')
posB=ylabel('$X_{pb},Y_{pb},X_{tb},Y_{tb},X_{jb},Y_{jb},X_{qb},Y_{qb}$');
set(posB,'Interpreter','latex');
set(posB,'FontSize',14);


figure('Name','Y funcao X Juntas Fase Balanco Perna Direita')

plot(Xq_balanR,Yq_balanR,'k','LineWidth',2);
hold on
plot(Xj_balan,Yj_balan,'b','LineWidth',2);
hold on
plot(Xt_balan,Yt_balan,'r','LineWidth',2);
hold on
plot(Xp_balan,Yp_balan,'y','LineWidth',2);
hold off
title('Y em funcao de X para cada junta Fase Balanco da Perna Direita')
xposB = xlabel('$X_{pb},X_{tb},X_{jb},X_{qb}$');
set(xposB,'Interpreter','latex');
set(xposB,'FontSize',14);
yposB = ylabel('$Y_{pb},Y_{tb},Y_{jb},Y_{qb}$');
set(yposB,'Interpreter','latex');
set(yposB,'FontSize',14);


%% MODELO GEOMÉTRICO DA PERNA ESQUERDA NA FASE DE BALANCO

thetaq_maxE = max(theta_q2E);
[linE,colE] = find(theta_q2E == thetaq_maxE);

% Referencial fase de balanco no quadril (XqE_balanR,YqE_balanR)
XqE_balanR = Dados_XY2_E(1:linE,1);
YqE_balanR = Dados_XY2_E(1:linE,2);

% % Posição do joelho em relação ao referencial no quadril (XqE_balanR,YqE_balanR)
XjE_balan = XqE_balanR + Lc*sind( theta_q2E(1:linE) );
YjE_balan = YqE_balanR - Lc*cosd( theta_q2E(1:linE) );

% Posicao em X e Y do JOELHO ESQUERDO DADOS OBTIDOS NA FEF
Xj2_E = Dados_XY2_E(1:linE,3);
Yj2_E = Dados_XY2_E(1:linE,4);

comp_joel_BalE = table(Xj2_E, XjE_balan,  Yj2_E, YjE_balan);

% % Posição do tornozelo em relação ao referencial no quadril (XqE_balanR,YqE_balanR)
XtE_balan = XjE_balan + Lj*sind( theta_q2E(1:linE) - theta_j2E(1:linE) );
YtE_balan = YjE_balan - Lj*cosd( theta_q2E(1:linE) - theta_j2E(1:linE) );

% Referencial fase de apoio no tornozelo (XtE_apoioR,YtE_apoioR)
Xt2_E = Dados_XY2_E(1:linE,5);
Yt2_E = Dados_XY2_E(1:linE,6);

comp_torn_BalE = table(Xt2_E, XtE_balan,  Yt2_E, YtE_balan);

% % Posicao do pé em relação ao referencial no quadril (XqE_balanR,YqE_balanR)
XpE_balan = XtE_balan + Lp*sind( theta_q2E(1:linE) - theta_j2E(1:linE) + theta_t2E(1:linE) + 90);
YpE_balan = YtE_balan - Lp*cosd( theta_q2E(1:linE) - theta_j2E(1:linE) + theta_t2E(1:linE) + 90);

% Referencial fase de apoio no tornozelo (XtE_apoioR,YtE_apoioR)
Xp2_E = Dados_XY2_E(1:linE,7);
Yp2_E = Dados_XY2_E(1:linE,8);

comp_pe_BalE = table(Xp2_E, XpE_balan,  Yp2_E, YpE_balan);

%% MODELO GEOMÉTRICO DA PERNA ESQUERDA NA FASE DE APOIO

% Referencial fase de apoio no tornozelo (XtE_apoioR,YtE_apoioR)
XtE_apoioR = Dados_XY2_E(linE+1:100,5);
YtE_apoioR = Dados_XY2_E(linE+1:100,6);

% % Posição do joelho em relação ao referencial no tornozelo (XtE_apoioR,YtE_apoioR)
% Xj = Xt - Lj*sen(theta_q - theta_j);
% Yj = Yt + Lj*cos(theta_q - theta_j);
XjE_apoio = XtE_apoioR - Lj*sind( theta_q2E(linE+1:100) - theta_j2E(linE+1:100) );
YjE_apoio = YtE_apoioR + Lj*cosd( theta_q2E(linE+1:100) - theta_j2E(linE+1:100) );

% Posicao em X e Y do JOELHO ESQUERDO DADOS OBTIDOS NA FEF
Xj2_E = Dados_XY2_E(linE+1:100,3);
Yj2_E = Dados_XY2_E(linE+1:100,4);

comp_joel_ApE = table(Xj2_E, XjE_apoio,  Yj2_E, YjE_apoio);

% % Posicao do quadril em relacao ao referencial no tornozelo (XtE_apoioR,YtE_apoioR)
% Xq = Xj - Lc*sen(theta_q);
% Yq = Yj + Lc*cos(theta_q)
XqE_apoio = XjE_apoio - Lc*sind( theta_q2E(linE+1:100) );
YqE_apoio = YjE_apoio + Lc*cosd( theta_q2E(linE+1:100) );

% Posicao em X e Y do QUADRIL ESQUERDO DADOS OBTIDOS NA FEF
Xq2_E = Dados_XY2_E(linE+1:100,1);
Yq2_E = Dados_XY2_E(linE+1:100,2);

comp_quad_ApE = table(Xq2_E, XqE_apoio, Yq2_E, YqE_apoio);

% % Posicao do pé em relacao ao referencial no tornozelo (Xt_apoioR,Yt_apoioR)
% Xp = Xt + Lp*sen(theta_q - theta_j + theta_t + 90);
% Yp = Yt - Lp*cos(theta_q - theta_j + theta_t + 90);
XpE_apoio = XtE_apoioR + Lp*sind( theta_q2E(linE+1:100) - theta_j2E(linE+1:100) + theta_t2E(linE+1:100) + 90 );
YpE_apoio = YtE_apoioR - Lp*cosd( theta_q2E(linE+1:100) - theta_j2E(linE+1:100) + theta_t2E(linE+1:100) + 90);

% Posicao em X e Y do PÉ DIREITO DADOS OBTIDOS NA FEF
Xp2_E = Dados_XY2_E(linE+1:100, 7);
Yp2_E = Dados_XY2_E(linE+1:100, 8);

comp_pe_ApE = table(Xp2_E, XpE_apoio, Yp2_E, YpE_apoio);

%% VETORES POSICAO DE CADA JUNTA PARA AS FASES DE BALANCO E APOIO


Xq = [Xq_apoio; Xq_balanR];
Yq = [Yq_apoio; Yq_balanR];

Xj = [Xj_apoio; Xj_balan];
Yj = [Yj_apoio; Yj_balan];

Xt = [Xt_apoioR; Xt_balan];
Yt = [Yt_apoioR; Yt_balan];

Xp = [Xp_apoio; Xp_balan];
Yp = [Yp_apoio; Yp_balan];

posLc = [Xq, Yq, Xj, Yj];
posLj = [Xj, Yj, Xt, Yt];
posLp = [Xt, Yt, Xp, Yp];

XqE = [XqE_balanR; XqE_apoio];
YqE = [YqE_balanR; YqE_apoio];

XjE = [XjE_balan; XjE_apoio];
YjE = [YjE_balan; YjE_apoio];

XtE = [XtE_balan; XtE_apoioR];
YtE = [YtE_balan; YtE_apoioR];

XpE = [XpE_balan; XpE_apoio];
YpE = [YpE_balan; YpE_apoio];

posLcE = [XqE, YqE, XjE, YjE];
posLjE = [XjE, YjE, XtE, YtE];
posLpE = [XtE, YtE, XpE, YpE];

figure('Name','Animacao Movimento Perna Direita');
pbaspect([4 1 1])
a_mov = 0;

n = length(tempo2);

for i = 1:n
    cla
    Xqdk = posLc(i,1); Yqdk = posLc(i,2);
    Xjdk = posLj(i,1); Yjdk = posLj(i,2);
    Xtdk = posLp(i,1); Ytdk = posLp(i,2);
    Xpdk = posLp(i,3); Ypdk = posLp(i,4);
    
    Xqek = posLcE(i,1); Yqek = posLcE(i,2);
    Xjek = posLjE(i,1); Yjek = posLjE(i,2);
    Xtek = posLpE(i,1); Ytek = posLpE(i,2);
    Xpek = posLpE(i,3); Ypek = posLpE(i,4);
    
    plot(Xqdk,Yqdk,'ko',Xjdk,Yjdk,'ko',Xtdk,Ytdk,'ko',Xpdk,Ypdk,'ko',...
         'LineWidth',2,'MarkerSize',10);
    hold on
    plot(Xqek,Yqek,'ro',Xjek,Yjek,'ro',Xtek,Ytek,'ro',Xpek,Ypek,'ro',...
         'LineWidth',3,'MarkerSize',10);
    hold on
    plot(posLc(i,1:2:3),  posLc(i,2:2:4), 'Color','k','Linewidth',1.5)
    plot(posLj(i,1:2:3),  posLj(i,2:2:4), 'Color','k','Linewidth',1.5)
    plot(posLp(i,1:2:3),  posLp(i,2:2:4), 'Color','k','Linewidth',1.5)
    plot(posLcE(i,1:2:3), posLcE(i,2:2:4), 'Color','r','Linewidth',1.5)
    plot(posLjE(i,1:2:3), posLjE(i,2:2:4), 'Color','r','Linewidth',1.5)
    plot(posLpE(i,1:2:3), posLpE(i,2:2:4), 'Color','r','Linewidth',1.5)
    
    if posLc(i,1)<2.5
        a = 0;
    else
        a = posLc(i,1)-2.5;
    end
    axis([-0.5+a, 3.5+a, 0, 1])
    pause(0.1)
    hold off
end