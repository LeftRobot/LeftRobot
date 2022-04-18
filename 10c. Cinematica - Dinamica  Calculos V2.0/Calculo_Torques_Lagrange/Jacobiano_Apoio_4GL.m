function J =  Jacobiano_Apoio_4GL(HAT,COXA,PERNA,PE,V)

%%%%%% ANGULOS DAS JUNTAS DA PERNA DIREITA EM APOIO (2 test) %%%%%%%%%%%%
%%%%%%% ANGULOS MEDIDOS EM BALANCO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
theta_Q =  (V(1).thetaq).*(pi/180);
theta_J = -(V(1).thetaj).*(pi/180);
theta_T =  (V(1).thetat).*(pi/180);

% ** -------------------------------------------------------------------
tht_1 =  theta_Q + theta_J + theta_T; % Angulo Dedao em Apoio
tht_2 = -theta_T; % Angulo do Tornozelo Direito
tht_3 = -theta_J; % Angulo do Joelho Direito **
tht_4 = -theta_Q; % Angulo do quadril

% LINK 1 = PE (tht_1 = tht_q - tht_j + tht_j =  Angulo Apoio Dedao)
Lp = PE.Comprimento;

% LINK 2 = PERNA (tht_2 = -tht_t = Angulo tornozelo)
Lj = PERNA.Comprimento;

% LINK 3 = COXA (tht_3 = tht_j = Angulo Joelho)
Lc = COXA.Comprimento;

% LINK 4 = HAT (tht_4 = -tht_q = Angulo Quadril)
a0 = HAT.CoM(2);

% Matrizes jacobianas da velocidade Linear do End-Effector Jvi

Jv1 = [(Lp*sin(tht_1) - Lj*cos(tht_1 + tht_2) -a0*cos(tht_1 + tht_2 + tht_3 + tht_4) -...
       Lc*cos(tht_1 + tht_2 + tht_3)); (-a0*sin(tht_1 + tht_2 + tht_3 + tht_4) -...
       Lj*sin(tht_1 + tht_2) - Lp*cos(tht_1) - Lc*sin(tht_1 + tht_2 + tht_3));
       (zeros(size(tht_1)))];
   
Jv2 = [(-a0*cos(tht_1 + tht_2 + tht_3 + tht_4) - Lj*cos(tht_1 + tht_2) -...
       Lc*cos(tht_1 + tht_2 + tht_3)); (-a0*sin(tht_1 + tht_2 + tht_3 + tht_4) -...
       Lj*sin(tht_1 + tht_2) - Lc*sin(tht_1 + tht_2 + tht_3));  (zeros(size(tht_1)))];
   
Jv3 = [(-a0*cos(tht_1 + tht_2 + tht_3 + tht_4) - Lc*cos(tht_1 + tht_2 + tht_3));
       (-a0*sin(tht_1 + tht_2 + tht_3 + tht_4) - Lc*sin(tht_1 + tht_2 + tht_3));  (zeros(size(tht_1)))];
   
Jv4 = [(-a0*cos(tht_1 + tht_2 + tht_3 + tht_4)); (-a0*sin(tht_1 + tht_2 + tht_3 + tht_4));
        (zeros(size(tht_1)))];

% Matrizes jacobianas da velocidade Angular do End-Effector Jwi
Jw1 = [0 0 1]';
Jw2 = [0 0 1]';
Jw3 = [0 0 1]';
Jw4 = [0 0 1]';

% MATRIZ JACOBIANA PARA O MODELO DA FASE DE APOIO J = [Jvi; Jwi]
J = [Jv1 Jv2 Jv3 Jv4;
     Jw1 Jw2 Jw3 Jw4];
 
end