function J =  Jacobiano_Balanco(HAT, COXA, PERNA, PE, V)


% HAT 
a0 = HAT.CoM(2);

% LINK 1 = COXA (tht_1 = tht_q = Angulo Quadril)
Lc = COXA.Comprimento;

% LINK 2 = PERNA (tht_2 = tht_j = Angulo Joelho)
Lj = PERNA.Comprimento;

% LINK 3 = PE (tht_3 = tht_t = Angulo Tornozelo)
Lp = PE.Comprimento;

% ANGULOS DAS JUNTAS DA PERNA DIREITA EM APOIO (** Em Radianos)
theta_Q = (V(1).thetaq).*(pi/180);
theta_J = (V(1).thetaj).*(pi/180);
theta_T = (V(1).thetat).*(pi/180);

tht_1 =  theta_Q; % Angulo TORNOZELO em Apoio
tht_2 =  theta_J; % Angulo do Tornozelo Direito
tht_3 =  theta_T; % Angulo do quadril

% Matrizes jacobianas da velocidade Linear do End-Effector Jvi

Jv1_b = [(Lc*cos(tht_1) - Lp*sin(tht_1 - tht_2 + tht_3) + Lj*cos(tht_1 - tht_2));
    (Lp*cos(tht_1 - tht_2 + tht_3) + Lc*sin(tht_1) + Lj*sin(tht_1 - tht_2));
    (zeros(size(theta_Q)))];

Jv2_b = [(Lp*sin(tht_1 - tht_2 + tht_3) - Lj*cos(tht_1 - tht_2));
    (-Lp*cos(tht_1 - tht_2 + tht_3) - Lj*sin(tht_1 - tht_2));
    (zeros(size(theta_Q)))];

Jv3_b = [(-Lp*sin(tht_1 - tht_2 + tht_3));
    (Lp*cos(tht_1 - tht_2 + tht_3));
    (zeros(size(theta_Q)))];

% Matrizes jacobianas da velocidade Angular do End-Effector Jwi
Jw1_b = [0 0 1]';
Jw2_b = [0 0 1]';
Jw3_b = [0 0 1]';

% MATRIZ JACOBIANA PARA O MODELO DA FASE DE APOIO J = [Jvi; Jwi]
J = [Jv1_b Jv2_b Jv3_b;
     Jw1_b Jw2_b Jw3_b];
 
end