function J =  Jacobiano_Apoio_3GL(HAT,COXA,PERNA,PE,V)

% %%%%% ANGULOS DAS JUNTAS DA PERNA DIREITA EM APOIO (2 test) %%%%%%%%%%%%
%%%%%%% ANGULOS MEDIDOS EM BALANCO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
theta_Q =  (V(1).thetaq).*(pi/180);
theta_J = -(V(1).thetaj).*(pi/180);
theta_T =  (V(1).thetat).*(pi/180);

% ** -------------------------------------------------------------------
tht_1 =  theta_Q + theta_J; % Angulo do Tornozelo Direito
tht_2 = -theta_J; % Angulo do Joelho Direito **
tht_3 = -theta_Q; % Angulo do quadril

% % ANGULOS DAS JUNTAS DA PERNA DIREITA EM APOIO (** Em Radianos)
% theta_Q = (V(1).thetaq).*(pi/180);
% theta_J = (V(1).thetaj).*(pi/180);
% theta_T = (V(1).thetat).*(pi/180);
% 
% tht_1 =  theta_Q - theta_J; % Angulo TORNOZELO em Apoio
% tht_2 =  theta_J; % Angulo do Tornozelo Direito
% tht_3 = -theta_Q; % Angulo do quadril

% -------------------------------------------------------------------------
% LINK 1 = PE (tht_1 = tht_q - tht_j + tht_j =  Angulo Apoio Dedao)
Lp = PE.Comprimento;

% LINK 2 = PERNA (tht_2 = -tht_t = Angulo tornozelo)
Lj = PERNA.Comprimento;

% LINK 3 = COXA (tht_3 = tht_j = Angulo Joelho)
Lc = COXA.Comprimento;

% LINK 4 = HAT (tht_4 = -tht_q = Angulo Quadril)
a0 = HAT.CoM(2);
% -------------------------------------------------------------------------

% Matrizes jacobianas da velocidade Linear do End-Effector Jvi
Jv1_ap = [(-Lc*cos(tht_1 + tht_2) - Lj*cos(tht_1) - a0*cos(tht_1 + tht_2 + tht_3));
          (-Lc*sin(tht_1 + tht_2) - Lj*sin(tht_1) - a0*sin(tht_1 + tht_2 + tht_3));
          (zeros(size(theta_Q)))];
 
Jv2_ap = [(-Lc*cos(tht_1 + tht_2) - a0*cos(tht_1 + tht_2 + tht_3));
          (-Lc*sin(tht_1 + tht_2) - a0*sin(tht_1 + tht_2 + tht_3));
          (zeros(size(theta_Q)))];

Jv3_ap = [(-a0*cos(tht_1 + tht_2 + tht_3)); 
          (-a0*sin(tht_1 + tht_2 + tht_3)); 
          (zeros(size(theta_Q)))];

% Matrizes jacobianas da velocidade Angular do End-Effector Jwi
Jw1_ap = [0 0 1]';
Jw2_ap = [0 0 1]';
Jw3_ap = [0 0 1]';

% MATRIZ JACOBIANA PARA O MODELO DA FASE DE APOIO J = [Jvi; Jwi]
J = [Jv1_ap Jv2_ap Jv3_ap;
     Jw1_ap Jw2_ap Jw3_ap];
 
end