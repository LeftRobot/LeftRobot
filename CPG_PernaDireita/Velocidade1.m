function veloc1 = Velocidade1()


%Dados ÂNGULOS Velocidade 1 (sheet '0.5 ms') perna direita
Dados_AngV1_D = xlsread('DataBaseOffset.xlsx', '0.5ms', 'A3:D102');

%Dados ÂNGULOS Velocidade 1 (sheet '0.5 ms') perna esquerda
Dados_AngV1_E = xlsread('DataBaseOffset.xlsx', '0.5ms', 'E3:G102');


%Dados XY Velocidade 1 (sheet '0.5 ms') perna direita
Dados_XY1_D = xlsread('DataBaseXY.xlsx', '0.5ms', 'A4:I403');

%Dados XY Velocidade 1 (sheet '0.5 ms') perna esquerda
Dados_XY1_E = xlsread('DataBaseXY.xlsx', '0.5ms', 'J4:Q403');

% Dados do ciclo 1 da marcha 
% cic1 = 1:100;
cic1 = 1:100;
% Dados do ciclo 2 da marcha
cic2 = 101:200;
% Dados ciclo 3 da marcha
cic3 = 201:300;
% Dados ciclo 4 da marcha
cic4 = 301:400;

ciclo = [cic1];

% Base de tempo para Velocidade 1 
tempo1 = Dados_XY1_D(ciclo,1);

%%%%%%%%%%%%%%%%%%%%  VELOCIDADE 1 = 0.5 m/s PERNA DIREITA %%%%%%%%%%%%%%%%

% Posicao em X e Y do QUADRIL DIREITO no referencial inercial
Xq1_D = Dados_XY1_D(ciclo,2);
Yq1_D = Dados_XY1_D(ciclo,3);

% Posicao em X e Y do JOELHO DIREITO no referencial inercial
Xj1_D = Dados_XY1_D(ciclo,4);
Yj1_D = Dados_XY1_D(ciclo,5);

% Posicao em X e Y do TORNOZELO DIREITO no referencial inercial
Xt1_D = Dados_XY1_D(ciclo,6);
Yt1_D = Dados_XY1_D(ciclo,7);

% Posicao em X e Y do PÉ DIREITO no referencial inercial
Xp1_D = Dados_XY1_D(ciclo,8);
Yp1_D = Dados_XY1_D(ciclo,9);

% Ângulos do Quadril da Perna Direita para V1
theta_q1D = Dados_AngV1_D(:,2);

% Ângulo do  Joelho da Perna Direita para V1
theta_j1D = Dados_AngV1_D(:,3);

% Ângulo do Tornozelo da Perna Direita para V1
theta_t1D = Dados_AngV1_D(:,4);

% Estrutura para armazenar os dados XY e Theta da perna direita para V1
% Uma estrutura é um tipo de dados que agrupa dados relacionados usando 
% contêineres de dados chamados CAMPOS. Cada campo pode conter dados de 
% qualquer tipo ou tamanho.
% StructureName(indice).fieldName
veloc1_right.tempo   =  tempo1;
veloc1_right.Xq      =  Xq1_D;
veloc1_right.Yq      =  Yq1_D;
veloc1_right.Xj      =  Xj1_D;
veloc1_right.Yj      =  Yj1_D;
veloc1_right.Xt      =  Xt1_D;
veloc1_right.Yt      =  Yt1_D;
veloc1_right.Xp      =  Xp1_D;
veloc1_right.Yp      =  Yp1_D;
veloc1_right.thetaq  =  theta_q1D;
veloc1_right.thetaj  =  theta_j1D;
veloc1_right.thetat  =  theta_t1D;


%%%%%%%%%%%%%%%%%%%%  VELOCIDADE 1 = 0.5 m/s PERNA ESQUERDA %%%%%%%%%%%%%%%

% Posicao em X e Y do QUADRIL ESQUERDO no referencial inercial
Xq1_E = Dados_XY1_E(ciclo,1);
Yq1_E = Dados_XY1_E(ciclo,2);

% Posicao em X e Y do JOELHO ESQUERDO no referencial inercial
Xj1_E = Dados_XY1_E(ciclo,3);
Yj1_E = Dados_XY1_E(ciclo,4);

% Posicao em X e Y do TORNOZELO ESQUERDO no referencial inercial
Xt1_E = Dados_XY1_E(ciclo,5);
Yt1_E = Dados_XY1_E(ciclo,6);

% Posicao em X e Y do PÉ ESQUERDO no referencial inercial
Xp1_E = Dados_XY1_E(ciclo,7);
Yp1_E = Dados_XY1_E(ciclo,8);

% Ângulos do Quadril da Perna Esquerda para V1
theta_q1E = Dados_AngV1_E(:,1);

% Ângulo do  Joelho da Perna Esquerda para V1
theta_j1E = Dados_AngV1_E(:,2);

% Ângulo do Tornozelo da Perna Esquerda para V1
theta_t1E = Dados_AngV1_E(:,3);

% Estrutura para armazenar os dados XY e Theta da perna esquerda para V1
veloc1_left.tempo   =  tempo1;
veloc1_left.Xq      =  Xq1_E;
veloc1_left.Yq      =  Yq1_E;
veloc1_left.Xj      =  Xj1_E;
veloc1_left.Yj      =  Yj1_E;
veloc1_left.Xt      =  Xt1_E;
veloc1_left.Yt      =  Yt1_E;
veloc1_left.Xp      =  Xp1_E;
veloc1_left.Yp      =  Yp1_E;
veloc1_left.thetaq  =  theta_q1E;
veloc1_left.thetaj  =  theta_j1E;
veloc1_left.thetat  =  theta_t1E;

% CONCATENACAO DAS DUAS ESTRUTURAS veloc1_right e veloc1_left que contem os
% mesmos campos (fields) na estrutura veloc1
% concatenating struct1 and struct2 creates a 1-by-2 structure array
% combined = [struct1, struct2]

veloc1 = [veloc1_right, veloc1_left];

%% GRÁFICOS V1: POSICAO X, Y E ÂNGULOS DAS JUNTAS EM FUNÇÃO DE t 

%**
% sub1 = subplot(2,2,1);
% a = animatedline('Color','k','LineStyle','-','Linewidth',1.5);
% b = animatedline('Color','b','LineStyle','--','Linewidth',1.5);
% c = animatedline('Color','r','LineStyle',':','Linewidth',1.5);
% d = animatedline('Color','g','LineStyle','-.','Linewidth',1.5);
% xlabel('t [s]');
% ylabel('Y [m]')
% title('Posiçao em Y das juntas')
% 
% 
% sub2 = subplot(2,2,2);
% k = animatedline('Color','k','LineStyle','-','Linewidth',1.5);
% l = animatedline('Color','b','LineStyle','--','Linewidth',1.5);
% m = animatedline('Color','r','LineStyle',':','Linewidth',1.5);
% n = animatedline('Color','g','LineStyle','-.','Linewidth',1.5);
% xlabel('t [s]');
% ylabel('X [m]')
% title('Posiçao em x das juntas')
% lgd = legend('XY_{quadril}','XY_{joelho}','XY_{tornozelo}','XY_{pe}');
% lgd.Title.FontSize = 13;
% lgd.Location = 'best';
% 
% sub3 = subplot(2,2,[3 4]);
% p = animatedline('Color','k','LineStyle','-','Linewidth',1.5);
% q = animatedline('Color','b','LineStyle','--','Linewidth',1.5);
% r = animatedline('Color','r','LineStyle',':','Linewidth',1.5);
% xlabel('t [s]');
% ylabel('\theta [°]')
% title('Ângulos das juntas')
% lgd = legend('\theta_{quadril}','\theta_{joelho}','\theta_{tornozelo}');
% lgd.Title.FontSize = 13;
% lgd.Location = 'best';
% 
%      for i = K : length(tempo1)
%     
%         addpoints(a,tempo1(i),Yq1_D(i));
%         addpoints(b,tempo1(i),Yj1_D(i));
%         addpoints(c,tempo1(i),Yt1_D(i));
%         addpoints(d,tempo1(i),Yp1_D(i));
%        
%         addpoints(k,tempo1(i),Xq1_D(i));
%         addpoints(l,tempo1(i),Xj1_D(i));
%         addpoints(m,tempo1(i),Xt1_D(i));
%         addpoints(n,tempo1(i),Xp1_D(i));
%     
%         addpoints(p,tempo1(i),theta_q1D(i));
%         addpoints(q,tempo1(i),theta_j1D(i));
%         addpoints(r,tempo1(i),theta_t1D(i));
%         
%         drawnow
%         pause(tempo1(end)*0.2)
%         K = K+1;
%      end
%     
%   hold off;
%**
end