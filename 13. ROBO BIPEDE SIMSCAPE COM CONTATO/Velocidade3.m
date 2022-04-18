function veloc3 = Velocidade3()

% global K;

%Dados ÂNGULOS Velocidade 3 (sheet '1.2 ms') perna direita
Dados_AngV3_D = xlsread('DataBaseOffset.xlsx', '1.2ms', 'A3:D102');

%Dados ÂNGULOS Velocidade 3 (sheet '1.2 ms') perna esquerda
Dados_AngV3_E = xlsread('DataBaseOffset.xlsx', '1.2ms', 'E3:G102');

%Dados Velocidade 3 (sheet '1.2 ms') perna direita
Dados_XY3_D = xlsread('DataBaseXY.xlsx','1.2ms','A4:I403');

%Dados Velocidade 3 (sheet '1.2 ms') perna direita
Dados_XY3_E = xlsread('DataBaseXY.xlsx','1.2ms','J4:Q403');

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

% Base de tempo para Velocidade 3 
tempo3 = Dados_XY3_D(ciclo,1);

%%%%%%%%%%%%%%%%%%%  VELOCIDADE 3 = 1.2 m/s PERNA DIREITA %%%%%%%%%%%%%%%%%

% Posicao em X e Y do QUADRIL DIREITO no referencial inercial
Xq3_D = Dados_XY3_D(ciclo,2);
Yq3_D = Dados_XY3_D(ciclo,3);

% Posicao em X e Y do JOELHO DIREITO no referencial inercial
Xj3_D = Dados_XY3_D(ciclo,4);
Yj3_D = Dados_XY3_D(ciclo,5);

% Posicao em X e Y do TORNOZELO DIREITO no referencial inercial
Xt3_D = Dados_XY3_D(ciclo,6);
Yt3_D = Dados_XY3_D(ciclo,7);

% Posicao em X e Y do PÉ DIREITO no referencial inercial
Xp3_D = Dados_XY3_D(ciclo,8);
Yp3_D = Dados_XY3_D(ciclo,9);

% Ângulos do Quadril da Perna Direita para V3
theta_q3D = Dados_AngV3_D(:,2);

% Ângulo do  Joelho da Perna Direita para V3
theta_j3D = Dados_AngV3_D(:,3);

% Ângulo do Tornozelo da Perna Direita para V3
theta_t3D = Dados_AngV3_D(:,4);

% Uma estrutura é um tipo de dados que agrupa dados relacionados usando 
% contêineres de dados chamados CAMPOS. Cada campo pode conter dados de 
% qualquer tipo ou tamanho.
veloc3_right.tempo   =  tempo3;
veloc3_right.Xq      =  Xq3_D;
veloc3_right.Yq      =  Yq3_D;
veloc3_right.Xj      =  Xj3_D;
veloc3_right.Yj      =  Yj3_D;
veloc3_right.Xt      =  Xt3_D;
veloc3_right.Yt      =  Yt3_D;
veloc3_right.Xp      =  Xp3_D;
veloc3_right.Yp      =  Yp3_D;
veloc3_right.thetaq  =  theta_q3D;
veloc3_right.thetaj  =  theta_j3D;
veloc3_right.thetat  =  theta_t3D;

%%%%%%%%%%%%%%%%%%%  VELOCIDADE 3 = 1.2 m/s PERNA ESQUERDA %%%%%%%%%%%%%%%%

% Posicao em X e Y do QUADRIL ESQUERDO no referencial inercial
Xq3_E = Dados_XY3_E(ciclo,1);
Yq3_E = Dados_XY3_E(ciclo,2);

% Posicao em X e Y do JOELHO ESQUERDO no referencial inercial
Xj3_E = Dados_XY3_E(ciclo,3);
Yj3_E = Dados_XY3_E(ciclo,4);

% Posicao em X e Y do TORNOZELO ESQUERDO no referencial inercial
Xt3_E = Dados_XY3_E(ciclo,5);
Yt3_E = Dados_XY3_E(ciclo,6);

% Posicao em X e Y do PÉ ESQUERDO no referencial inercial
Xp3_E = Dados_XY3_E(ciclo,7);
Yp3_E = Dados_XY3_E(ciclo,8);

% Ângulo do Quadril da Perna Esquerda para V3
theta_q3E = Dados_AngV3_E(:,1);

% Ângulo do  Joelho da Perna Esquerda para V3
theta_j3E = Dados_AngV3_E(:,2);

% Ângulo do Tornozelo da Perna Esquerda para V3
theta_t3E = Dados_AngV3_E(:,3);

% Estrutura para armazenar os dados XY e Theta da perna esquerda para V3
veloc3_left.tempo   =  tempo3;
veloc3_left.Xq      =  Xq3_E;
veloc3_left.Yq      =  Yq3_E;
veloc3_left.Xj      =  Xj3_E;
veloc3_left.Yj      =  Yj3_E;
veloc3_left.Xt      =  Xt3_E;
veloc3_left.Yt      =  Yt3_E;
veloc3_left.Xp      =  Xp3_E;
veloc3_left.Yp      =  Yp3_E;
veloc3_left.thetaq  =  theta_q3E;
veloc3_left.thetaj  =  theta_j3E;
veloc3_left.thetat  =  theta_t3E;

% Concatenacao das duas estruturas [veloc3_right, veloc3_left]
veloc3 = [veloc3_right, veloc3_left];

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
%      for i = K : length(tempo3)
%     
%         addpoints(a,tempo3(i),Yq3_D(i));
%         addpoints(b,tempo3(i),Yj3_D(i));
%         addpoints(c,tempo3(i),Yt3_D(i));
%         addpoints(d,tempo3(i),Yp3_D(i));
%        
%         addpoints(k,tempo3(i),Xq3_D(i));
%         addpoints(l,tempo3(i),Xj3_D(i));
%         addpoints(m,tempo3(i),Xt3_D(i));
%         addpoints(n,tempo3(i),Xp3_D(i));
%     
%         addpoints(p,tempo3(i),theta_q3D(i));
%         addpoints(q,tempo3(i),theta_j3D(i));
%         addpoints(r,tempo3(i),theta_t3D(i));
%         
%         drawnow
%         pause(tempo3(end)*0.2)
%         K = K+1;
%      end
%     
%   hold off;
%**
end