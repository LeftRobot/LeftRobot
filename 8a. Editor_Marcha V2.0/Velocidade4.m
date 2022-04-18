function veloc4 = Velocidade4()

global K;

%Dados ÂNGULOS Velocidade 4 (sheet '1.5 ms') perna direita
Dados_AngV4_D = xlsread('DataBaseOffset.xlsx', '1.5ms', 'A3:D102');

%Dados ÂNGULOS Velocidade 4 (sheet '1.5 ms') perna esquerda
Dados_AngV4_E = xlsread('DataBaseOffset.xlsx', '1.5ms', 'E3:G102');

%Dados XY Velocidade 4 (sheet '1.5 ms') perna direita
Dados_XY4_D = xlsread('DataBaseXY.xlsx','1.5ms','A4:I403');

%Dados XY Velocidade 4 (sheet '1.5 ms') perna esquerda
Dados_XY4_E = xlsread('DataBaseXY.xlsx','1.5ms','J4:Q403');

%% CICLOS DE MARCHA 

% Dados do ciclo 1 da marcha 
cic1 = 1:100;
% Dados do ciclo 2 da marcha
cic2 = 101:200;
% Dados ciclo 3 da marcha
cic3 = 201:300;
% Dados ciclo 4 da marcha
cic4 = 301:400;

ciclo = [cic1];

% Base de tempo para Velocidade 4
tempo4 = Dados_XY4_D(ciclo,1);

%%%%%%%%%%%%%%%%%%%% VELOCIDADE 4 = 1.5 m/s  PERNA DIREITA %%%%%%%%%%%%%%%%

% Posicao em X e Y do QUADRIL DIREITO no referencial inercial
Xq4_D = Dados_XY4_D(ciclo,2);
Yq4_D = Dados_XY4_D(ciclo,3);

% Posicao em X e Y do JOELHO DIREITO no referencial inercial
Xj4_D = Dados_XY4_D(ciclo,4);
Yj4_D = Dados_XY4_D(ciclo,5);

% Posicao em X e Y do TORNOZELO DIREITO no referencial inercial
Xt4_D = Dados_XY4_D(ciclo,6);
Yt4_D = Dados_XY4_D(ciclo,7);

% Posicao em X e Y do PÉ DIREITO no referencial inercial
Xp4_D = Dados_XY4_D(ciclo,8);
Yp4_D = Dados_XY4_D(ciclo,9);

% Ângulos do Quadril da Perna Direita para V4
theta_q4D = Dados_AngV4_D(:,2);

% Ângulo do  Joelho da Perna Direita para V4
theta_j4D = Dados_AngV4_D(:,3);

% Ângulo do Tornozelo da Perna Direita para V4
theta_t4D = Dados_AngV4_D(:,4);

% Uma estrutura é um tipo de dados que agrupa dados relacionados usando 
% contêineres de dados chamados CAMPOS. Cada campo pode conter dados de 
% qualquer tipo ou tamanho.
veloc4_right.tempo   =  tempo4;
veloc4_right.Xq      =  Xq4_D;
veloc4_right.Yq      =  Yq4_D;
veloc4_right.Xj      =  Xj4_D;
veloc4_right.Yj      =  Yj4_D;
veloc4_right.Xt      =  Xt4_D;
veloc4_right.Yt      =  Yt4_D;
veloc4_right.Xp      =  Xp4_D;
veloc4_right.Yp      =  Yp4_D;
veloc4_right.thetaq  =  theta_q4D;
veloc4_right.thetaj  =  theta_j4D;
veloc4_right.thetat  =  theta_t4D;

%%%%%%%%%%%%%%%%%%%  VELOCIDADE 4 = 1.5 m/s PERNA ESQUERDA %%%%%%%%%%%%%%%%

% Posicao em X e Y do QUADRIL ESQUERDO no referencial inercial
Xq4_E = Dados_XY4_E(ciclo,1);
Yq4_E = Dados_XY4_E(ciclo,2);

% Posicao em X e Y do JOELHO ESQUERDO no referencial inercial
Xj4_E = Dados_XY4_E(ciclo,3);
Yj4_E = Dados_XY4_E(ciclo,4);

% Posicao em X e Y do TORNOZELO ESQUERDO no referencial inercial
Xt4_E = Dados_XY4_E(ciclo,5);
Yt4_E = Dados_XY4_E(ciclo,6);

% Posicao em X e Y do PÉ ESQUERDO no referencial inercial
Xp4_E = Dados_XY4_E(ciclo,7);
Yp4_E = Dados_XY4_E(ciclo,8);

% Ângulo do Quadril da Perna Esquerda para V4
theta_q4E = Dados_AngV4_E(:,1);

% Ângulo do  Joelho da Perna Esquerda para V4
theta_j4E = Dados_AngV4_E(:,2);

% Ângulo do Tornozelo da Perna Esquerda para V4
theta_t4E = Dados_AngV4_E(:,3);

% Estrutura para armazenar os dados XY e Theta da perna esquerda para V4
veloc4_left.tempo   =  tempo4;
veloc4_left.Xq      =  Xq4_E;
veloc4_left.Yq      =  Yq4_E;
veloc4_left.Xj      =  Xj4_E;
veloc4_left.Yj      =  Yj4_E;
veloc4_left.Xt      =  Xt4_E;
veloc4_left.Yt      =  Yt4_E;
veloc4_left.Xp      =  Xp4_E;
veloc4_left.Yp      =  Yp4_E;
veloc4_left.thetaq  =  theta_q4E;
veloc4_left.thetaj  =  theta_j4E;
veloc4_left.thetat  =  theta_t4E;

% Concatenacao das duas estruturas [veloc4_right, veloc4_left]
veloc4 = [veloc4_right, veloc4_left];

%% GRÁFICOS V2: POSICAO X, Y E ÂNGULOS EM FUNÇÃO DE t 

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
%      for i = K : length(tempo4)
%     
%         addpoints(a,tempo4(i),Yq4_D(i));
%         addpoints(b,tempo4(i),Yj4_D(i));
%         addpoints(c,tempo4(i),Yt4_D(i));
%         addpoints(d,tempo4(i),Yp4_D(i));
%        
%         addpoints(k,tempo4(i),Xq4_D(i));
%         addpoints(l,tempo4(i),Xj4_D(i));
%         addpoints(m,tempo4(i),Xt4_D(i));
%         addpoints(n,tempo4(i),Xp4_D(i));
%     
%         addpoints(p,tempo4(i),theta_q4D(i));
%         addpoints(q,tempo4(i),theta_j4D(i));
%         addpoints(r,tempo4(i),theta_t4D(i));
%         
%         drawnow
%         pause(tempo4(end)*0.2)
%         K = K+1;
%      end
%     
%   hold off;
%**
end