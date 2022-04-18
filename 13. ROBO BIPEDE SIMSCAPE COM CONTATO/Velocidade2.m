function veloc2 = Velocidade2()

% global K;

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
cic1 = 1:100;
% Dados do ciclo 2 da marcha
cic2 = 101:200;
% Dados ciclo 3 da marcha
cic3 = 201:300;
% Dados ciclo 4 da marcha
cic4 = 301:400;

ciclo = [cic1];

% Base de tempo para Velocidade 2 
tempo2 = Dados_XY2_D(ciclo,1);

%%%%%%%%%%%%%%%%%%%% VELOCIDADE 2 = 1 m/s PERNA DIREITA  %%%%%%%%%%%%%%%%%%

% Posicao em X e Y do QUADRIL DIREITO no referencial inercial
Xq2_D = Dados_XY2_D(ciclo,2);
Yq2_D = Dados_XY2_D(ciclo,3);

% Posicao em X e Y do JOELHO DIREITO no referencial inercial
Xj2_D = Dados_XY2_D(ciclo,4);
Yj2_D = Dados_XY2_D(ciclo,5);

% Posicao em X e Y do TORNOZELO DIREITO no referencial inercial
Xt2_D = Dados_XY2_D(ciclo,6);
Yt2_D = Dados_XY2_D(ciclo,7);

% Posicao em X e Y do PÉ DIREITO no referencial inercial
Xp2_D = Dados_XY2_D(ciclo,8);
Yp2_D = Dados_XY2_D(ciclo,9);

% Ângulos do Quadril da Perna Direita para V2
theta_q2D = Dados_AngV2_D(:,2);
% Ângulo do  Joelho da Perna Direita para V2
theta_j2D = Dados_AngV2_D(:,3);
% Ângulo do Tornozelo da Perna Direita para V2
theta_t2D = Dados_AngV2_D(:,4);

% Uma estrutura é um tipo de dados que agrupa dados relacionados usando 
% contêineres de dados chamados CAMPOS. Cada campo pode conter dados de 
% qualquer tipo ou tamanho.
% StructureName(No.structure).fieldName
veloc2_right.tempo   =  tempo2;
veloc2_right.Xq      =  Xq2_D;
veloc2_right.Yq      =  Yq2_D;
veloc2_right.Xj      =  Xj2_D;
veloc2_right.Yj      =  Yj2_D;
veloc2_right.Xt      =  Xt2_D;
veloc2_right.Yt      =  Yt2_D;
veloc2_right.Xp      =  Xp2_D;
veloc2_right.Yp      =  Yp2_D;
veloc2_right.thetaq  =  theta_q2D;
veloc2_right.thetaj  =  theta_j2D;
veloc2_right.thetat  =  theta_t2D;

%%%%%%%%%%%%%%%%%%% VELOCIDADE 2 = 1 m/s PERNA ESQUERDA  %%%%%%%%%%%%%%%%%%

% Posicao em X e Y do QUADRIL ESQUERDO no referencial inercial
Xq2_E = Dados_XY2_E(ciclo,1);
Yq2_E = Dados_XY2_E(ciclo,2);

% Posicao em X e Y do JOELHO ESQUERDO no referencial inercial
Xj2_E = Dados_XY2_E(ciclo,3);
Yj2_E = Dados_XY2_E(ciclo,4);

% Posicao em X e Y do TORNOZELO ESQUERDO no referencial inercial
Xt2_E = Dados_XY2_E(ciclo,5);
Yt2_E = Dados_XY2_E(ciclo,6);

% Posicao em X e Y do PÉ ESQUERDO no referencial inercial
Xp2_E = Dados_XY2_E(ciclo,7);
Yp2_E = Dados_XY2_E(ciclo,8);

% Ângulos do Quadril da Perna Esquerda para V2
theta_q2E = Dados_AngV2_E(:,1);
% Ângulo do  Joelho da Perna Esquerda para V2
theta_j2E = Dados_AngV2_E(:,2);
% Ângulo do Tornozelo da Perna Esquerda para V2
theta_t2E = Dados_AngV2_E(:,3);

% Estrutura para armazenar os dados XY e Theta da perna esquerda para V2
veloc2_left.tempo   =  tempo2;
veloc2_left.Xq      =  Xq2_E;
veloc2_left.Yq      =  Yq2_E;
veloc2_left.Xj      =  Xj2_E;
veloc2_left.Yj      =  Yj2_E;
veloc2_left.Xt      =  Xt2_E;
veloc2_left.Yt      =  Yt2_E;
veloc2_left.Xp      =  Xp2_E;
veloc2_left.Yp      =  Yp2_E;
veloc2_left.thetaq  =  theta_q2E;
veloc2_left.thetaj  =  theta_j2E;
veloc2_left.thetat  =  theta_t2E;

% Concatenacao das duas estruturas veloc2_right e veloc2_left
veloc2 = [veloc2_right, veloc2_left];

%% GRÁFICOS V2: POSICAO X, Y E ÂNGULOS EM FUNÇÃO DE t 


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
%      for i = K : length(tempo2)
%     
%         addpoints(a,tempo2(i),Yq2_D(i));
%         addpoints(b,tempo2(i),Yj2_D(i));
%         addpoints(c,tempo2(i),Yt2_D(i));
%         addpoints(d,tempo2(i),Yp2_D(i));
%        
%         addpoints(k,tempo2(i),Xq2_D(i));
%         addpoints(l,tempo2(i),Xj2_D(i));
%         addpoints(m,tempo2(i),Xt2_D(i));
%         addpoints(n,tempo2(i),Xp2_D(i));
%     
%         addpoints(p,tempo2(i),theta_q2D(i));
%         addpoints(q,tempo2(i),theta_j2D(i));
%         addpoints(r,tempo2(i),theta_t2D(i));
%         
%         drawnow
%         pause(tempo2(end)*0.2)
%         K = K+1;
%      end
%     
%   hold off;
%**

end