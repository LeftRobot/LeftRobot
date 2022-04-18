%% CALCULOS DAS EQUACOES DINAMICAS DO ROBO PARA AS FASES DE BALANCO E APOIO
% CINMÁTICA CONVENCAO DENAVIT - HARTENBERG MECANISMO ROBÓTICO BÍPEDE 6 DoF

close all;
clear all;
clc;


%% [1] FASE DE BALANCO-REFERENCIA O0X0Y0Z0 NO QUADRIL E END-EFFECTOR NO DEDAO 

% DEFINICAO DAS VARIÁVEIS SIMBÓLICAS PARA A CINEMATICA E DINAMICA DO ROBÔ

syms tht_1 tht_2 tht_3 tht_4 Lc Lj Lp a0 d0;

% Define the "assumptions" para as variáveis simbólicas
assume(tht_1, 'real');
assume(tht_2, 'real');
assume(tht_3, 'real');
assume(tht_4, 'real');

assume(Lc, 'real');
assumeAlso(Lc, 'positive');
assume(Lj, 'real');
assumeAlso(Lj, 'positive');
assume(Lp, 'real');
assumeAlso(Lp, 'positive');

assume(a0, 'real');
assume(d0, 'real');

%% ========== CALCULO MAS MATRIZES DE TRANSFORMACAO HOMOGENEA =============

% Matriz de Transformacao Homogenea A10_b (LINK 1 O1X1Y1Z1 -> O0X0Y0Z0)
A10_b = [cos(tht_1-pi/2) -sin(tht_1-pi/2)*cos(0)  sin(tht_1-pi/2)*sin(0)  Lc*cos(tht_1-pi/2);
         sin(tht_1-pi/2)  cos(tht_1-pi/2)*cos(0) -cos(tht_1-pi/2)*sin(0)  Lc*sin(tht_1-pi/2);
         0                sin(0)                  cos(0)                  0;
         0                0                       0                       1];
A10_b = simplify(A10_b);

% Matriz de Transformacao Homogenea A21_b (LINK 2 O2X2Y2Z2 -> O1X1Y1Z1) 
A21_b = [cos(tht_2)  -sin(tht_2)*cos(0)  sin(tht_2)*sin(0)  Lj*cos(tht_2);
         sin(tht_2)   cos(tht_2)*cos(0) -cos(tht_2)*sin(0)  Lj*sin(tht_2);
         0            sin(0)             cos(0)             0;
         0            0                  0                  1]; 
% O angulo tht_2 = -theta_2 sempre gira no sentido negativo da RMD
A21_b = simplify(subs(A21_b, tht_2, -tht_2));
     
% Matriz de Transformacao Homogenea A32_b (LINK 3 O3X3Y3Z3 -> O2X2Y2Z2)
A32_b = [cos(tht_3+pi/2)  -sin(tht_3+pi/2)*cos(0)   sin(tht_3+pi/2)*sin(0)  Lp*cos(tht_3+pi/2);
         sin(tht_3+pi/2)   cos(tht_3+pi/2)*cos(0)  -cos(tht_3+pi/2)*sin(0)  Lp*sin(tht_3+pi/2);
         0                 sin(0)                   cos(0)                  0;
         0                 0                        0                       1];

A32_b = simplify(A32_b);

% Posicao e orientacao do sistema O1X1Y1Z1 em relacao ao sistema O0X0Y0Z0
% POSICAO DA JUNTA DO JOELHO
T10_b = simplify(A10_b);
 
% Posicao e orientacao do sistema O2X2Y2Z2 em relacao ao sistema O0X0Y0Z0
% POSICAO DA JUNTA DO TORNOZELO
T20_b = simplify(A10_b*A21_b);
 
% Posicao e orientacao do sistema O3X3Y3Z3 em relacao ao sistema O0X0Y0Z0
% POSICAO DO PE (DEDAO)
T30_b = simplify(A10_b*A21_b*A32_b);
 
 
%% ========== CALCULO DO JACOBIANO PARA A FASE DE BALANCO=================
% =========== SISTEMA O0X0Y0Z0 NA JUNTA DO QUADRIL =======================

% Vetor Z0 e O0 do sistema de referencia inercial O0x0Y0Z0
Z0_b = [0 0 1]';
O0_b = [0 0 0]';

% Vetor Z1, O1 e Matriz de Rotacao R_10 do sistema O1X1Y1Z1 em relacao ao 
% sistema O0X0Y0Z0 (inercial)
Z1_b  = T10_b(1:3,3);
O1_b  = T10_b(1:3,4);
R10_b = T10_b(1:3,1:3);
% Componente em Y da altura do link 1
h1_b  = T10_b(2,4);

% Vetor Z2, O2 e Matriz de Rotacao R_20 do sistema O2X2Y2Z2 em relacao ao 
% sistema O0X0Y0Z0 (inercial) 
Z2_b  = T20_b(1:3,3);
O2_b  = T20_b(1:3,4);
R20_b = T20_b(1:3,1:3);
% Componente em Y da altura do link 2
h2_b  = T20_b(2,4);

% Vetor Z3, O3 e Matriz de Rotacao R_30 do sistema O3X3Y3Z3 em relacao ao 
% sistema O0X0Y0Z0 (inercial)
Z3_b  = T30_b(1:3,3);
O3_b  = T30_b(1:3,4);
R30_b = T30_b(1:3,1:3);
% Componente em Y da altura do link 3
h3_b  = T30_b(2,4);

O30_b = simplify(O3_b - O0_b);
O31_b = simplify(O3_b - O1_b);
O32_b = simplify(O3_b - O2_b);

% Matrizes jacobianas da velocidade Linear do End-Effector Jvi
Jv1_b = cross(Z0_b, O30_b);
% para corresponder com o Jacobiano real Jv2_b = cross(Z1_b, -O31_b);
% Pelo fato de assumir que tht_2 gira sempre no sentido negativo
Jv2_b = cross(Z1_b, -O31_b);
Jv3_b = cross(Z2_b, O32_b);


% Matrizes jacobianas da velocidade Angular do End-Effector Jwi
Jw1_b = Z0_b;
Jw2_b = Z1_b;
Jw3_b = Z2_b;

% MATRIZ JACOBIANA PARA O MODELO DA FASE DE BALANCO J_bal = [Jvi_b; Jwi_b]
J_bal = [Jv1_b Jv2_b Jv3_b;
         Jw1_b Jw2_b Jw3_b];
     
%% EQUACOES DINÂMICAS DA FASE DE BALANCO REFERENCIA O0X0Y0Z0 NO QUADRIL E 
% END-EFFECTOR NO DEDAO

%%%======== JUNTA 1 = QUADRIL   --->   LINK 1 = COXA =====================
% L1 = Lc     L1_cm = Lc_cm     m1 = massa_coxa
syms Lc_cm m1
syms I11_q I12_q I13_q I21_q I22_q I23_q I31_q I32_q I33_q

assume(Lc_cm, 'real');
assumeAlso(Lc_cm, 'positive');
assume(m1, 'real');
assumeAlso(m1, 'positive');
assume(I11_q, 'real'); assumeAlso(I11_q, 'positive');
assume(I22_q, 'real'); assumeAlso(I22_q, 'positive');
assume(I33_q, 'real'); assumeAlso(I33_q, 'positive');
assume(I12_q, 'real'); assume(I13_q, 'real'); assume(I21_q, 'real');
assume(I23_q, 'real'); assume(I31_q, 'real'); assume(I32_q, 'real');

%%%======== JUNTA 2 = JOELHO   --->   LINK 2 = PERNA ======================
% L2 = Lj     L2_cm = Lj_cm     m2 = massa_perna

syms Lj_cm m2
syms I11_j I12_j I13_j I21_j I22_j I23_j I31_j I32_j I33_j

assume(Lj_cm, 'real');
assumeAlso(Lj_cm, 'positive');
assume(m2, 'real');
assumeAlso(m2, 'positive');
assume(I11_j, 'real'); assumeAlso(I11_j, 'positive');
assume(I22_j, 'real'); assumeAlso(I22_j, 'positive');
assume(I33_j, 'real'); assumeAlso(I33_j, 'positive');
assume(I12_j, 'real'); assume(I13_j, 'real'); assume(I21_j, 'real');
assume(I23_j, 'real'); assume(I31_j, 'real'); assume(I32_j, 'real');

%%%======== JUNTA 3 = TORNOZELO   --->   LINK 3 = PE ======================
% L3 = Lp     L3_cm = Lp_cm     m3 = massa_pe
syms Lp_cm m3
syms I11_t I12_t I13_t I21_t I22_t I23_t I31_t I32_t I33_t

assume(Lp_cm, 'real');
assumeAlso(Lp_cm, 'positive');
assume(m3, 'real');
assumeAlso(m3, 'positive');
assume(I11_t, 'real'); assumeAlso(I11_t, 'positive');
assume(I22_t, 'real'); assumeAlso(I22_t, 'positive');
assume(I33_t, 'real'); assumeAlso(I33_t, 'positive');
assume(I12_t, 'real'); assume(I13_t, 'real'); assume(I21_t, 'real');
assume(I23_t, 'real'); assume(I31_t, 'real'); assume(I32_t, 'real');

%% ===== CALCULO DOS COMPONENTES DA ENERGIA CINETICA DO ROBÔ K(q) =========

% Jacobiano Velocidade Linear Centro de Massa do Link 1
J_Vc1 = J_bal(1:3, 1:end);
J_Vc1 = subs(J_Vc1,[Lj Lp],[0 0]);
J_Vc1 = subs(J_Vc1, Lc, Lc_cm);

% Jacobiano Velocidade Linear Centro de Massa do Link 2
J_Vc2 = J_bal(1:3, 1:end);
J_Vc2 = subs(J_Vc2, Lp, 0);
J_Vc2 = subs(J_Vc2, Lj, Lj_cm);

% Jacobiano Velocidade Linear Centro de Massa do Link 3
J_Vc3 = J_bal(1:3, 1:end);
J_Vc3 = subs(J_Vc3, Lp, Lp_cm);

n = size(J_bal,2); % Número de colunas da Matriz Jacobiana J_bal

% Jacobiano Velocidade Angular Centro de Massa Link 1
J_w1 = [J_bal(4:6,1),  zeros(3, n-1)];

% Jacobiano Velocidade Linear Centro de Massa Link 2
J_w2 = [J_bal(4:6,1:2), zeros(3, n-2)];

% Jacobiano Velocidade Linear Centro de Massa Link 3
J_w3 = J_bal(4:end, 1:end);

% COMPONENTE 1 ENERGIA CINÉTICA TRASLACIONAL K_Vc1 = m1*J_Vc1'*J_Vc1
K_Vc1 = simplify(m1*(J_Vc1')*J_Vc1);

% COMPONENTE 2 ENERGIA CINÉTICA TRASLACIONAL K_Vc2 = m2*J_Vc2'*J_Vc2
K_Vc2 = simplify(m2*(J_Vc2')*J_Vc2);

% COMPONENTE 2 ENERGIA CINÉTICA TRASLACIONAL K_Vc3 = m3*J_Vc3'*J_Vc3
K_Vc3 = simplify(m3*(J_Vc3')*J_Vc3);

% COMPONENTE 1 ENERGÍA CINETICA ROTACIONAL K_wc1=J_w1'*R01_b*I1*R01_b'*J_w1
  % Tensor de inercia link 1 (Coxa)
    I1 = [I11_q I12_q I13_q; I21_q I22_q I23_q; I31_q I32_q I33_q];

K_wc1 = simplify((J_w1')*R10_b*I1*(R10_b')*J_w1);

% COMPONENTE 2 ENERGÍA CINETICA ROTACIONAL K_wc2=J_w2'*R02_b*I2*R02_b'*J_w2
  % Tensor de inercia link 2 (Perna)
    I2 = [I11_j I12_j I13_j; I21_j I22_j I23_j; I31_j I32_j I33_j];

K_wc2 = simplify((J_w2')*R20_b*I2*(R20_b')*J_w2);


% COMPONENTE 3 ENERGÍA CINETICA ROTACIONAL K_wc3=J_w3'*R03_b*I3*R03_b'*J_w3
  % Tensor de inercia link 3 (Pe)
    I3 = [I11_t I12_t I13_t; I21_t I22_t I23_t; I31_t I32_t I33_t];

K_wc3 = simplify((J_w3')*R30_b*I3*(R30_b')*J_w3);

% MATRIZ DE INERCIA DO ROBÔ D(q) = sum{mi*Jvci'*Jvci + Jwi'*Ri*Ii*Ri'*Jwi}
% i = 1,2,3
D_b = simplify (K_Vc1 + K_Vc2 + K_Vc3 + K_wc1 + K_wc2 + K_wc3);

d11_b = D_b(1,1);
d12_b = D_b(1,2);
d13_b = D_b(1,3);

d21_b = D_b(2,1);
d22_b = D_b(2,2);
d23_b = D_b(2,3);

d31_b = D_b(3,1);
d32_b = D_b(3,2);
d33_b = D_b(3,3);

%% ============ CALCULO DOS COEFICIENTES DE CHRISTOFFEL ===================

% ========== PARA A JUNTA 1 = QUADRIL, {k = 1}, {i,j = 1,2,3} =============
C111_b =simplify((1/2)*(diff(d11_b, tht_1) + diff(d11_b, tht_1) - diff(d11_b, tht_1)));

C121_b =simplify((1/2)*(diff(d12_b, tht_1) + diff(d11_b, tht_2) - diff(d12_b, tht_1)));

C131_b =simplify((1/2)*(diff(d13_b, tht_1) + diff(d11_b, tht_3) - diff(d13_b, tht_1)));

C211_b =simplify((1/2)*(diff(d11_b, tht_2) + diff(d12_b, tht_1) - diff(d21_b, tht_1)));

C221_b =simplify((1/2)*(diff(d12_b, tht_2) + diff(d12_b, tht_2) - diff(d22_b, tht_1)));

C231_b =simplify((1/2)*(diff(d13_b, tht_2) + diff(d12_b, tht_3) - diff(d23_b, tht_1)));

C311_b =simplify((1/2)*(diff(d11_b, tht_3) + diff(d13_b, tht_1) - diff(d31_b, tht_1)));

C321_b =simplify((1/2)*(diff(d12_b, tht_3) + diff(d13_b, tht_2) - diff(d32_b, tht_1)));

C331_b =simplify((1/2)*(diff(d13_b, tht_3) + diff(d13_b, tht_3) - diff(d33_b, tht_1)));

% ============ PARA A JUNTA 2 = JOELHO, (k = 2) {i,j = 1,2,3} =============
C112_b =simplify((1/2)*(diff(d21_b, tht_1) + diff(d21_b, tht_1) - diff(d11_b, tht_2)));

C122_b =simplify((1/2)*(diff(d22_b, tht_1) + diff(d21_b, tht_2) - diff(d12_b, tht_2)));

C132_b =simplify((1/2)*(diff(d23_b, tht_1) + diff(d21_b, tht_3) - diff(d13_b, tht_2)));

C212_b =simplify((1/2)*(diff(d21_b, tht_2) + diff(d22_b, tht_1) - diff(d21_b, tht_2)));

C222_b =simplify((1/2)*(diff(d22_b, tht_2) + diff(d22_b, tht_2) - diff(d22_b, tht_2)));

C232_b =simplify((1/2)*(diff(d23_b, tht_2) + diff(d22_b, tht_3) - diff(d23_b, tht_2)));

C312_b =simplify((1/2)*(diff(d21_b, tht_3) + diff(d23_b, tht_1) - diff(d31_b, tht_2)));

C322_b =simplify((1/2)*(diff(d22_b, tht_3) + diff(d23_b, tht_2) - diff(d32_b, tht_2)));

C332_b =simplify((1/2)*(diff(d23_b, tht_3) + diff(d23_b, tht_3) - diff(d33_b, tht_2)));

% ========= PARA A JUNTA 3 = TORNOZELO, (k = 3) {i,j = 1,2,3} =============
C113_b = simplify((1/2)*(diff(d31_b, tht_1) + diff(d31_b, tht_1) - diff(d11_b, tht_3)));

C123_b = simplify((1/2)*(diff(d32_b, tht_1) + diff(d31_b, tht_2) - diff(d12_b, tht_3)));

C133_b = simplify((1/2)*(diff(d33_b, tht_1) + diff(d31_b, tht_3) - diff(d13_b, tht_3)));

C213_b = simplify((1/2)*(diff(d31_b, tht_2) + diff(d32_b, tht_1) - diff(d21_b, tht_3)));

C223_b = simplify((1/2)*(diff(d32_b, tht_2) + diff(d32_b, tht_2) - diff(d22_b, tht_3)));

C233_b = simplify((1/2)*(diff(d33_b, tht_2) + diff(d32_b, tht_3) - diff(d23_b, tht_3)));

C313_b = simplify((1/2)*(diff(d31_b, tht_3) + diff(d33_b, tht_1) - diff(d31_b, tht_3)));

C323_b = simplify((1/2)*(diff(d32_b, tht_3) + diff(d33_b, tht_2) - diff(d32_b, tht_3)));

C333_b = simplify((1/2)*(diff(d33_b, tht_3) + diff(d33_b, tht_3) - diff(d33_b, tht_3)));

%% ======== CALCULOS DOS COMPONENTES DA ENERGIA POTENCIAL P(q) ============

syms g
assume(g, 'real')

% COMPONENTE ENERGIA POTENCIAL LINK 1 (COXA)
% rc1_b é a posicao em Y do CoM do Link 1 = Coxa
rc1_b = subs(h1_b, Lc, Lc_cm);
P1_b = m1*g*rc1_b;

% COMPONENTE ENERGIA POTENCIAL LINK 2 (PERNA)
% rc2_b é a posicao em Y do CoM do Link 2 = Perna
rc2_b = subs(h2_b, Lj, Lj_cm);
P2_b = m2*g*rc2_b;

% COMPONENTE ENERGIA POTENCIAL LINK 3 (PE)
% rc3_b é a posicao em Y do CoM do Link 3 = Pe
rc3_b = subs(h3_b, Lp, Lp_cm);
P3_b = m3*g*rc3_b;

% ENERGIA POTENCIAL TOTAL DO ROBÔ P(q) PARA A FASE DE BALANCO
P_b = simplify(P1_b + P2_b + P3_b);

% DERIVADA DA ENERGIA POTENCIAL P(q) EM RELACAO A theta_1
g1_b = diff(P_b, tht_1);

% DERIVADA DA ENERGIA POTENCIAL P(q) EM RELACAO A theta_2
g2_b = diff(P_b, tht_2);

% DERIVADA DA ENERGIA POTENCIAL P(q) EM RELACAO A theta_3
g3_b = diff(P_b, tht_3);

%% CALCULO DOS TORQUES NAS JUNTAS DO QUADRIL, JOELHO E TORNOZELO  

% Definicao das variáveis da primeira e segunda derivada da posicao(angulo) 
syms tht1_p tht1_2p tht2_p tht2_2p tht3_p tht3_2p

% Primeira e segunda derivada do angulo theta_1
assume(tht1_p,  'real')
assume(tht1_2p, 'real')
% Primeira e segunda derivada do angulo theta_2
assume(tht2_p,  'real')
assume(tht2_2p, 'real')
% Primeira e segunda derivada do angulo theta_3
assume(tht3_p,  'real')
assume(tht3_2p, 'real')

% ===== CALCULO DO TORQUE NA JUNTA DO QUADRIL k = 1, {i,j = 1,2,3} ========

% PARA k = 1 (TORQUE DA JUNTA DO QUADRIL tau_1)
torQ_b = simplify(d11_b*(tht1_2p) + d12_b*(tht2_2p) + d13_b*(tht3_2p) +...
C111_b*(tht1_p^2) + (C121_b + C211_b )*(tht1_p*tht2_p) +...
(C131_b + C311_b)*(tht1_p*tht3_p) + C221_b*(tht2_p^2) +...
(C231_b + C321_b)*(tht2_p*tht3_p) + C331_b*(tht3_p^2) + g1_b);

% torQ_b = (Lc*Lj_cm*m2*sin(tht_2) - m3*(Lc*Lp_cm*cos(tht_2 - tht_3) - Lc*Lj*sin(tht_2)))*tht2_p^2 +...
% 2*Lp_cm*m3*(Lj*cos(tht_3) + Lc*cos(tht_2 - tht_3))*tht2_p*tht3_p -...
% 2*Lc*tht1_p*(Lj*m3*sin(tht_2) + Lj_cm*m2*sin(tht_2) - Lp_cm*m3*cos(tht_2 - tht_3))*tht2_p -...
% Lp_cm*m3*(Lj*cos(tht_3) + Lc*cos(tht_2 - tht_3))*tht3_p^2 -...
% 2*Lp_cm*m3*tht1_p*(Lj*cos(tht_3) + Lc*cos(tht_2 - tht_3))*tht3_p +...
% tht1_2p*(I33_j + I33_q + I33_t + Lc^2*m2 + Lc^2*m3 + Lc_cm^2*m1 + Lj^2*m3 +...
% Lj_cm^2*m2 + Lp_cm^2*m3 + 2*Lc*Lj*m3*cos(tht_2) + 2*Lc*Lj_cm*m2*cos(tht_2) - 2*Lj*Lp_cm*m3*sin(tht_3) +...
% 2*Lc*Lp_cm*m3*sin(tht_2 - tht_3)) + tht2_2p*(I33_j + I33_t - m3*(Lj^2 - 2*sin(tht_3)*Lj*Lp_cm +...
% Lc*cos(tht_2)*Lj + Lp_cm^2 + Lc*sin(tht_2 - tht_3)*Lp_cm) - Lj_cm*m2*(Lj_cm + Lc*cos(tht_2))) +...
% tht3_2p*(I33_t + Lp_cm*m3*(Lp_cm - Lj*sin(tht_3) + Lc*sin(tht_2 - tht_3))) +...
% g*m3*(Lp_cm*cos(tht_1 - tht_2 + tht_3) + Lc*sin(tht_1) + Lj*sin(tht_1 - tht_2)) +...
% g*m2*(Lc*sin(tht_1) + Lj_cm*sin(tht_1 - tht_2)) + Lc_cm*g*m1*sin(tht_1);

% PARA k = 2 (TORQUE DA JUNTA DO JOELHO tau_2)

torJ_b = simplify(d21_b*tht1_2p + d22_b*tht2_2p + d23_b*tht3_2p +...
C112_b*(tht1_p^2) + (C122_b + C212_b)*(tht1_p*tht2_p) +...
(C132_b + C312_b)*(tht1_p*tht3_p) + C222_b*(tht2_p^2) +...
(C232_b + C322_b)*(tht2_p*tht3_p) + C332_b*(tht3_p^2) + g2_b);

% torJ_b = Lc*(Lj*m3*sin(tht_2) + Lj_cm*m2*sin(tht_2) - Lp_cm*m3*cos(tht_2 - tht_3))*tht1_p^2 +...
% 2*Lj*Lp_cm*m3*cos(tht_3)*tht1_p*tht3_p + Lj*Lp_cm*m3*cos(tht_3)*tht3_p^2 -...
% 2*Lj*Lp_cm*m3*cos(tht_3)*tht2_p*tht3_p +...
% tht1_2p*(I33_j + I33_t - m3*(Lj^2 - 2*sin(tht_3)*Lj*Lp_cm + Lc*cos(tht_2)*Lj +...
% Lp_cm^2 + Lc*sin(tht_2 - tht_3)*Lp_cm) - Lj_cm*m2*(Lj_cm + Lc*cos(tht_2))) +...
% tht2_2p*(m2*Lj_cm^2 + I33_j + I33_t + m3*(Lj^2 - 2*sin(tht_3)*Lj*Lp_cm + Lp_cm^2)) +...
% tht3_2p*(I33_t - Lp_cm*m3*(Lp_cm - Lj*sin(tht_3))) -...
% g*m3*(Lp_cm*cos(tht_1 - tht_2 + tht_3) + Lj*sin(tht_1 - tht_2)) -...
% Lj_cm*g*m2*sin(tht_1 - tht_2);

% PARA k = 3 (TORQUE DA JUNTA DO TORNOZELO tau_3)

torT_b = simplify(d31_b*tht1_2p + d32_b*tht2_2p + d33_b*tht3_2p +...
C113_b*(tht1_p^2) + (C123_b + C213_b)*(tht1_p*tht2_p) +...
(C133_b + C313_b)*(tht1_p*tht3_p) + C223_b*(tht2_p^2) +...
(C233_b + C323_b)*(tht2_p*tht3_p) + C333_b*(tht3_p^2) + g3_b);

% torT_b = Lp_cm*m3*(Lj*cos(tht_3) + Lc*cos(tht_2 - tht_3))*tht1_p^2 -...
% 2*Lj*Lp_cm*m3*cos(tht_3)*tht1_p*tht2_p + Lj*Lp_cm*m3*cos(tht_3)*tht2_p^2 +...
% tht1_2p*(I33_t + Lp_cm*m3*(Lp_cm - Lj*sin(tht_3) + Lc*sin(tht_2 - tht_3))) +...
% tht2_2p*(I33_t - Lp_cm*m3*(Lp_cm - Lj*sin(tht_3))) +...
% tht3_2p*(m3*Lp_cm^2 + I33_t) + Lp_cm*g*m3*cos(tht_1 - tht_2 + tht_3);

%% [2] FASE DE APOIO - REFERENCIA NO DEDAO - END-EFFECTOR NO CoM DO HAT
% Sao consideradas 4 juntas rotacionais: th1, th2, th3, th4
% DEFINICAO DAS VARIÁVEIS SIMBÓLICAS PARA A CINEMATICA E DINAMICA DO ROBÔ

syms tht_1 tht_2 tht_3 tht_4 Lc Lj Lp a0 d0;

% Define the "assumptions" para as variáveis simbólicas
assume(tht_1, 'real');
assume(tht_2, 'real');
assume(tht_3, 'real');
assume(tht_4, 'real');

assume(Lc, 'real');
assumeAlso(Lc, 'positive');
assume(Lj, 'real');
assumeAlso(Lj, 'positive');
assume(Lp, 'real');
assumeAlso(Lp, 'positive');

assume(a0, 'real'); % Altura do CoM do HAT medida a partir do Quadril
assume(d0, 'real'); % Distancia do CoM do HAT ao Quadril medida em Z

%% ========== CALCULO MAS MATRIZES DE TRANSFORMACAO HOMOGENEA =====================

% Matriz de Transformacao Homogenea A10_a (LINK 1 O1X1Y1Z1 -> O0X0Y0Z0)
A10_a = [cos(tht_1+pi)   -sin(tht_1+pi)*cos(0)   sin(tht_1+pi)*sin(0) Lp*cos(tht_1+pi);
         sin(tht_1+pi)    cos(tht_1+pi)*cos(0)  -cos(tht_1+pi)*sin(0) Lp*sin(tht_1+pi);
         0                sin(0)                 cos(0)               0;
         0                0                      0                    1];

A10_a = simplify(A10_a);

% Matriz de Transformacao Homogenea A21_a (LINK 2 O2X2Y2Z2 -> O1X1Y1Z1) 
A21_a = [cos(tht_2-pi/2)  -sin(tht_2-pi/2)*cos(0)   sin(tht_2-pi/2)*sin(0)  Lj*cos(tht_2-pi/2);
         sin(tht_2-pi/2)   cos(tht_2-pi/2)*cos(0)  -cos(tht_2-pi/2)*sin(0)  Lj*sin(tht_2-pi/2);
         0                 sin(0)                   cos(0)                  0;
         0                 0                        0                       1];
   
A21_a = simplify(A21_a);

% Matriz de Transformacao Homogenea A32_a (LINK 3 O3X3Y3Z3 -> O2X2Y2Z2)
A32_a = [cos(tht_3)  -sin(tht_3)*cos(0)  sin(tht_3)*sin(0)  Lc*cos(tht_3);
         sin(tht_3)   cos(tht_3)*cos(0) -cos(tht_3)*sin(0)  Lc*sin(tht_3);
         0            sin(0)             cos(0)             0;
         0            0                  0                  1];

A32_a = simplify(A32_a);

% Matriz de Transformacao Homogenea A43_a (LINK 4 O4X4Y4Z4 -> O3X3Y3Z3)
A43_a = [cos(tht_4)  -sin(tht_4)*cosd(180)  sin(tht_4)*sind(180)  a0*cos(tht_4);
         sin(tht_4)   cos(tht_4)*cosd(180) -cos(tht_4)*sind(180)  a0*sin(tht_4);
         0            sind(180)             cosd(180)             -d0;
         0            0                     0                     1];
A43_a = simplify(A43_a);

% Posicao e orientacao do sistema O1X1Y1Z1 em relacao ao sistema O0X0Y0Z0
% Posicao da junta do Tornozelo
T10_a = simplify(A10_a);

% Posicao e orientacao do sistema O2X2Y2Z2 em relacao ao sistema O0X0Y0Z0
% Posicao da junta do Joelho
T20_a = simplify(A10_a*A21_a);
 
% Posicao e orientacao do sistema O3X3Y3Z3 em relacao ao sistema O0X0Y0Z0
% Posicao da junta do Quadril
T30_a = simplify(A10_a*A21_a*A32_a);
 
% Posicao e orientacao do sistema O4X4Y4Z4 em relacao ao sistema O0X0Y0Z0
% Posicao do CoM do HAT
T40_a = simplify(A10_a*A21_a*A32_a*A43_a);

%% ========== CALCULO DO JACOBIANO PARA A FASE DE APOIO =================
% % Vetor Z0 e O0 do sistema de referencia inercial O0x0Y0Z0
Z0_a = [0 0 1]';
O0_a = [0 0 0]';

% Vetor Z1, O1 e Matriz de Rotacao R_10 do sistema O1X1Y1Z1 em relacao ao 
% sistema O0X0Y0Z0 (Inercial)
Z1_a  = T10_a(1:3,3);
O1_a  = T10_a(1:3,4);
R10_a = T10_a(1:3,1:3);
% Componente em Y da altura do link 1
h1_a  = T10_a(2,4);

% Vetor Z2, O2 e Matriz de Rotacao R_20 do sistema O2X2Y2Z2 em relacao ao 
% sistema O0X0Y0Z0 
Z2_a  = T20_a(1:3,3);
O2_a  = T20_a(1:3,4);
R20_a = T20_a(1:3,1:3);
% Componente em Y da altura do link 2
h2_a  = T20_a(2,4);


% Vetor Z3, O3 e Matriz de Rotacao R_30 do sistema O3X3Y3Z3 em relacao ao 
% sistema O0X0Y0Z0 
Z3_a  = T30_a(1:3,3);
O3_a  = T30_a(1:3,4);
R30_a = T30_a(1:3,1:3);
% Componente em Y da altura do link 3
h3_a  = T30_a(2,4);

% Vetor Z4, O4 e Matriz de Rotacao R_40 do sistema O4X4Y4Z4 em relacao ao 
% sistema O0X0Y0Z0 
Z4_a  = T40_a(1:3,3);
O4_a  = T40_a(1:3,4);
R40_a = T40_a(1:3,1:3);
% Componente em Y da altura do link 4 (HAT)
h4_a  = T40_a(2,4);

% Vetor distancia cada sistema OiXiYiZi em relacao a origem O0X0Y0Z0
O40_a = simplify(O4_a - O0_a);
O41_a = simplify(O4_a - O1_a);
O42_a = simplify(O4_a - O2_a);
O43_a = simplify(O4_a - O3_a);

% Matrizes jacobianas da velocidade Linear do End-Effector Jvi
Jv1_a = cross(Z0_a, O40_a);
Jv2_a = cross(Z1_a, O41_a);
Jv3_a = cross(Z2_a, O42_a);
Jv4_a = cross(Z3_a, O43_a);

% Matrizes jacobianas da velocidade Angular do End-Effector Jwi
Jw1_a = Z0_a;
Jw2_a = Z1_a;
Jw3_a = Z2_a;
Jw4_a = Z3_a;

% MATRIZ JACOBIANA PARA O MODELO DA FASE DE APOIO J_A = [Jvi; Jwi]
J_A = [Jv1_a Jv2_a Jv3_a Jv4_a;
       Jw1_a Jw2_a Jw3_a Jw4_a];

%    syms tht_q tht_j tht_t real   
%    J_ap = subs(J_A,[tht_1, tht_2, tht_3, tht_4], [tht_q-tht_j+tht_t,-tht_t,tht_j,-tht_q])

%%%======== JUNTA 1 = DEDAO EM APOIO   ---->   LINK 1 = PE ================
% L1 = Lp     L1_cm = Lp_cm     m1 = massa_pe
syms Lp_cm m1
syms I11_t I12_t I13_t I21_t I22_t I23_t I31_t I32_t I33_t

assume(Lp_cm, 'real');
assumeAlso(Lp_cm, 'positive');
assume(m1, 'real');
assumeAlso(m1, 'positive');
assume(I11_t, 'real'); assumeAlso(I11_t, 'positive');
assume(I22_t, 'real'); assumeAlso(I22_t, 'positive');
assume(I33_t, 'real'); assumeAlso(I33_t, 'positive');
assume(I12_t, 'real'); assume(I13_t, 'real'); assume(I21_t, 'real');
assume(I23_t, 'real'); assume(I31_t, 'real'); assume(I32_t, 'real');

%%%======== JUNTA 2 = TORNOZELO   --->   LINK 2 = PERNA ===================
% L2 = Lj     L2_cm = Lj_cm     m2 = massa_perna

syms Lj_cm m2
syms I11_j I12_j I13_j I21_j I22_j I23_j I31_j I32_j I33_j

assume(Lj_cm, 'real');
assumeAlso(Lj_cm, 'positive');
assume(m2, 'real');
assumeAlso(m2, 'positive');
assume(I11_j, 'real'); assumeAlso(I11_j, 'positive');
assume(I22_j, 'real'); assumeAlso(I22_j, 'positive');
assume(I33_j, 'real'); assumeAlso(I33_j, 'positive');
assume(I12_j, 'real'); assume(I13_j, 'real'); assume(I21_j, 'real');
assume(I23_j, 'real'); assume(I31_j, 'real'); assume(I32_j, 'real');

%%%======== JUNTA 3 = JOELHO   --->   LINK 3 = COXA == ===================
% L3 = Lc     L3_cm = Lc_cm     m3 = massa_coxa

syms Lc_cm m3
syms I11_q I12_q I13_q I21_q I22_q I23_q I31_q I32_q I33_q

assume(Lc_cm, 'real');
assumeAlso(Lc_cm, 'positive');
assume(m3, 'real');
assumeAlso(m3, 'positive');
assume(I11_q, 'real'); assumeAlso(I11_q, 'positive');
assume(I22_q, 'real'); assumeAlso(I22_q, 'positive');
assume(I33_q, 'real'); assumeAlso(I33_q, 'positive');
assume(I12_q, 'real'); assume(I13_q, 'real'); assume(I21_q, 'real');
assume(I23_q, 'real'); assume(I31_q, 'real'); assume(I32_q, 'real');

%%%======== JUNTA 4 = QUADRIL   --->   LINK 4 = CoM DO HAT ================
% L4 = 2*a0 (altura HAT)     L4_cm = a0     m4 = massa_HAT

syms a0 m4
syms I11_h I12_h I13_h I21_h I22_h I23_h I31_h I32_h I33_h

assume(a0, 'real');
assumeAlso(a0, 'positive');
assume(m4, 'real');
assumeAlso(m4, 'positive');
assume(I11_h, 'real'); assumeAlso(I11_h, 'positive');
assume(I22_h, 'real'); assumeAlso(I22_h, 'positive');
assume(I33_h, 'real'); assumeAlso(I33_h, 'positive');
assume(I12_h, 'real'); assume(I13_h, 'real'); assume(I21_h, 'real');
assume(I23_h, 'real'); assume(I31_h, 'real'); assume(I32_h, 'real');

%% ===== CALCULO DOS COMPONENTES DA ENERGIA CINETICA DO ROBÔ K(q) =========

% Jacobiano Velocidade Linear Centro de Massa do Link 1 (Pe)
JVc1_A = J_A(1:3, 1:end);
JVc1_A = subs(JVc1_A,[a0, Lc, Lj],[0, 0, 0]);
JVc1_A = subs(JVc1_A, Lp, Lp_cm);

% Jacobiano Velocidade Linear Centro de Massa do Link 2 (Perna)
JVc2_A = J_A(1:3, 1:end);
JVc2_A = subs(JVc2_A, [a0, Lc], [0, 0]);
JVc2_A = subs(JVc2_A, Lj, Lj_cm);

% Jacobiano Velocidade Linear Centro de Massa do Link 3 (Coxa)
JVc3_A = J_A(1:3, 1:end);
JVc3_A = subs(JVc3_A, a0, 0);
JVc3_A = subs(JVc3_A, Lc, Lc_cm);

% Jacobiano Velocidade Linear Centro de Massa do Link 4 (CoM do HAT)
JVc4_A = J_A(1:3, 1:end);

n = size(J_A,2); % Número de colunas da Matriz Jacobiana J_A

% Jacobiano Velocidade Angular Centro de Massa Link 1
Jw1_A = [J_A(4:6,1),  zeros(3, n-1)];

% Jacobiano Velocidade Linear Centro de Massa Link 2
Jw2_A = [J_A(4:6,1:2), zeros(3, n-2)];

% Jacobiano Velocidade Linear Centro de Massa Link 3
Jw3_A = [J_A(4:6, 1:3) zeros(3,n-3)];

% Jacobiano Velocidade Linear Centro de Massa Link 4
Jw4_A = J_A(4:6, 1:end);

% COMPONENTE 1 ENERGIA CINÉTICA TRASLACIONAL K_Vc1 = m1*J_Vc1'*J_Vc1
KVc1_A = simplify(m1*(JVc1_A')*JVc1_A);

% COMPONENTE 2 ENERGIA CINÉTICA TRASLACIONAL K_Vc2 = m2*J_Vc2'*J_Vc2
KVc2_A = simplify(m2*(JVc2_A')*JVc2_A);

% COMPONENTE 3 ENERGIA CINÉTICA TRASLACIONAL K_Vc3 = m3*J_Vc3'*J_Vc3
KVc3_A = simplify(m3*(JVc3_A')*JVc3_A);

% COMPONENTE 2 ENERGIA CINÉTICA TRASLACIONAL K_Vc3 = m3*J_Vc3'*J_Vc3
KVc4_A = simplify(m4*(JVc4_A')*JVc4_A);

% COMPONENTE 1 ENERGÍA CINETICA ROTACIONAL K_wc1=J_w1'*R01_a*I1*R01_a'*J_w1
  % Tensor de inercia link 1 (PE)
    I1t = [I11_t I12_t I13_t; I21_t I22_t I23_t; I31_t I32_t I33_t];

Kwc1_A = simplify((Jw1_A')*R10_a*I1t*(R10_a')*Jw1_A);

% COMPONENTE 2 ENERGÍA CINETICA ROTACIONAL Kwc2=J_w2'*R02_a*I2*R02_a'*J_w2
  % Tensor de inercia link 2 (PERNA)
    I2j = [I11_j I12_j I13_j; I21_j I22_j I23_j; I31_j I32_j I33_j];

Kwc2_A = simplify((Jw2_A')*R20_a*I2j*(R20_a')*Jw2_A);


% COMPONENTE 3 ENERGÍA CINETICA ROTACIONAL K_wc3=J_w3'*R03_a*I3q*R03_a'*J_w3
  % Tensor de inercia link 3 (QUADRIL)
    I3q = [I11_q I12_q I13_q; I21_q I22_q I23_q; I31_q I32_q I33_q];

Kwc3_A = simplify((Jw3_A')*R30_a*I3q*(R30_a')*Jw3_A);

% COMPONENTE 4 ENERGÍA CINETICA ROTACIONAL K_wc4=J_w4'*R04_a*I4h*R04_a'*J_w4
  % Tensor de inercia link 4 (CoM do HAT)
    I4h = [I11_h I12_h I13_h; I21_h I22_h I23_h; I31_h I32_h I33_h];

Kwc4_A = simplify((Jw4_A)'*R40_a*I4h*(R40_a')*Jw4_A);

% MATRIZ DE INERCIA DO ROBÔ D(q) = sum{mi*Jvci'*Jvci + Jwi'*Ri*Ii*Ri'*Jwi}
% i = 1,2,3,4
D_a = simplify (KVc1_A + KVc2_A + KVc3_A + KVc4_A + Kwc1_A + Kwc2_A +...
                Kwc3_A + Kwc4_A);

d11_a = D_a(1,1);
d12_a = D_a(1,2);
d13_a = D_a(1,3);
d14_a = D_a(1,4);

d21_a = D_a(2,1);
d22_a = D_a(2,2);
d23_a = D_a(2,3);
d24_a = D_a(2,4);

d31_a = D_a(3,1);
d32_a = D_a(3,2);
d33_a = D_a(3,3);
d34_a = D_a(3,4);

d41_a = D_a(4,1);
d42_a = D_a(4,2);
d43_a = D_a(4,3);
d44_a = D_a(4,4);

%% ============ CALCULO DOS COEFICIENTES DE CHRISTOFFEL ===================

% ========== PARA A JUNTA 1 = QUADRIL, {k = 1}, {i,j = 1,2,3,4}=======================
C111_a =simplify((1/2)*(diff(d11_a, tht_1) + diff(d11_a, tht_1) - diff(d11_a, tht_1)));

C121_a =simplify((1/2)*(diff(d12_a, tht_1) + diff(d11_a, tht_2) - diff(d12_a, tht_1)));

C131_a =simplify((1/2)*(diff(d13_a, tht_1) + diff(d11_a, tht_3) - diff(d13_a, tht_1)));

C141_a =simplify((1/2)*(diff(d14_a, tht_1) + diff(d11_a, tht_4) - diff(d14_a, tht_1)));

C211_a =simplify((1/2)*(diff(d11_a, tht_2) + diff(d12_a, tht_1) - diff(d21_a, tht_1)));

C221_a =simplify((1/2)*(diff(d12_a, tht_2) + diff(d12_a, tht_2) - diff(d22_a, tht_1)));

C231_a =simplify((1/2)*(diff(d13_a, tht_2) + diff(d12_a, tht_3) - diff(d23_a, tht_1)));

C241_a =simplify((1/2)*(diff(d14_a, tht_2) + diff(d12_a, tht_4) - diff(d24_a, tht_1)));

C311_a =simplify((1/2)*(diff(d11_a, tht_3) + diff(d13_a, tht_1) - diff(d31_a, tht_1)));

C321_a =simplify((1/2)*(diff(d12_a, tht_3) + diff(d13_a, tht_2) - diff(d32_a, tht_1)));

C331_a =simplify((1/2)*(diff(d13_a, tht_3) + diff(d13_a, tht_3) - diff(d33_a, tht_1)));

C341_a =simplify((1/2)*(diff(d14_a, tht_3) + diff(d13_a, tht_4) - diff(d34_a, tht_1)));

C411_a =simplify((1/2)*(diff(d11_a, tht_4) + diff(d14_a, tht_1) - diff(d41_a, tht_1)));

C421_a =simplify((1/2)*(diff(d12_a, tht_4) + diff(d14_a, tht_2) - diff(d42_a, tht_1)));

C431_a =simplify((1/2)*(diff(d13_a, tht_4) + diff(d14_a, tht_3) - diff(d43_a, tht_1)));

C441_a =simplify((1/2)*(diff(d14_a, tht_4) + diff(d14_a, tht_4) - diff(d44_a, tht_1)));

% ============ PARA A JUNTA 2 = JOELHO, (k = 2) {i,j = 1,2,3,4} =======================
C112_a =simplify((1/2)*(diff(d21_a, tht_1) + diff(d21_a, tht_1) - diff(d11_a, tht_2)));

C122_a =simplify((1/2)*(diff(d22_a, tht_1) + diff(d21_a, tht_2) - diff(d12_a, tht_2)));

C132_a =simplify((1/2)*(diff(d23_a, tht_1) + diff(d21_a, tht_3) - diff(d13_a, tht_2)));

C142_a =simplify((1/2)*(diff(d24_a, tht_1) + diff(d21_a, tht_4) - diff(d14_a, tht_2)));

C212_a =simplify((1/2)*(diff(d21_a, tht_2) + diff(d22_a, tht_1) - diff(d21_a, tht_2)));

C222_a =simplify((1/2)*(diff(d22_a, tht_2) + diff(d22_a, tht_2) - diff(d22_a, tht_2)));

C232_a =simplify((1/2)*(diff(d23_a, tht_2) + diff(d22_a, tht_3) - diff(d23_a, tht_2)));

C242_a =simplify((1/2)*(diff(d24_a, tht_2) + diff(d22_a, tht_4) - diff(d24_a, tht_2)));

C312_a =simplify((1/2)*(diff(d21_a, tht_3) + diff(d23_a, tht_1) - diff(d31_a, tht_2)));

C322_a =simplify((1/2)*(diff(d22_a, tht_3) + diff(d23_a, tht_2) - diff(d32_a, tht_2)));

C332_a =simplify((1/2)*(diff(d23_a, tht_3) + diff(d23_a, tht_3) - diff(d33_a, tht_2)));

C342_a =simplify((1/2)*(diff(d24_a, tht_3) + diff(d23_a, tht_4) - diff(d34_a, tht_2)));

C412_a =simplify((1/2)*(diff(d21_a, tht_4) + diff(d24_a, tht_1) - diff(d41_a, tht_2)));

C422_a =simplify((1/2)*(diff(d22_a, tht_4) + diff(d24_a, tht_2) - diff(d42_a, tht_2)));

C432_a =simplify((1/2)*(diff(d23_a, tht_4) + diff(d24_a, tht_3) - diff(d43_a, tht_2)));

C442_a =simplify((1/2)*(diff(d24_a, tht_4) + diff(d24_a, tht_4) - diff(d44_a, tht_2)));

% ========= PARA A JUNTA 3 = TORNOZELO, (k = 3) {i,j = 1,2,3,4} ========================
C113_a = simplify((1/2)*(diff(d31_a, tht_1) + diff(d31_a, tht_1) - diff(d11_a, tht_3)));

C123_a = simplify((1/2)*(diff(d32_a, tht_1) + diff(d31_a, tht_2) - diff(d12_a, tht_3)));

C133_a = simplify((1/2)*(diff(d33_a, tht_1) + diff(d31_a, tht_3) - diff(d13_a, tht_3)));

C143_a = simplify((1/2)*(diff(d34_a, tht_1) + diff(d31_a, tht_4) - diff(d14_a, tht_3)));

C213_a = simplify((1/2)*(diff(d31_a, tht_2) + diff(d32_a, tht_1) - diff(d21_a, tht_3)));

C223_a = simplify((1/2)*(diff(d32_a, tht_2) + diff(d32_a, tht_2) - diff(d22_a, tht_3)));

C233_a = simplify((1/2)*(diff(d33_a, tht_2) + diff(d32_a, tht_3) - diff(d23_a, tht_3)));

C243_a = simplify((1/2)*(diff(d34_a, tht_2) + diff(d32_a, tht_4) - diff(d24_a, tht_3)));

C313_a = simplify((1/2)*(diff(d31_a, tht_3) + diff(d33_a, tht_1) - diff(d31_a, tht_3)));

C323_a = simplify((1/2)*(diff(d32_a, tht_3) + diff(d33_a, tht_2) - diff(d32_a, tht_3)));

C333_a = simplify((1/2)*(diff(d33_a, tht_3) + diff(d33_a, tht_3) - diff(d33_a, tht_3)));

C343_a = simplify((1/2)*(diff(d34_a, tht_3) + diff(d33_a, tht_4) - diff(d34_a, tht_3)));

C413_a = simplify((1/2)*(diff(d31_a, tht_4) + diff(d34_a, tht_1) - diff(d41_a, tht_3)));

C423_a = simplify((1/2)*(diff(d32_a, tht_4) + diff(d34_a, tht_2) - diff(d42_a, tht_3)));

C433_a = simplify((1/2)*(diff(d33_a, tht_4) + diff(d34_a, tht_3) - diff(d43_a, tht_3)));

C443_a = simplify((1/2)*(diff(d34_a, tht_4) + diff(d34_a, tht_4) - diff(d44_a, tht_3)));

% ========= PARA A JUNTA 4 = TORNOZELO, (k = 4) {i,j = 1,2,3,4} ========================
C114_a = simplify((1/2)*(diff(d41_a, tht_1) + diff(d41_a, tht_1) - diff(d11_a, tht_4)));

C124_a = simplify((1/2)*(diff(d42_a, tht_1) + diff(d41_a, tht_2) - diff(d12_a, tht_4)));

C134_a = simplify((1/2)*(diff(d43_a, tht_1) + diff(d41_a, tht_3) - diff(d13_a, tht_4)));

C144_a = simplify((1/2)*(diff(d44_a, tht_1) + diff(d41_a, tht_4) - diff(d14_a, tht_4)));

C214_a = simplify((1/2)*(diff(d41_a, tht_2) + diff(d42_a, tht_1) - diff(d21_a, tht_4)));

C224_a = simplify((1/2)*(diff(d42_a, tht_2) + diff(d42_a, tht_2) - diff(d22_a, tht_4)));

C234_a = simplify((1/2)*(diff(d43_a, tht_2) + diff(d42_a, tht_3) - diff(d23_a, tht_4)));

C244_a = simplify((1/2)*(diff(d44_a, tht_2) + diff(d42_a, tht_4) - diff(d24_a, tht_4)));

C314_a = simplify((1/2)*(diff(d41_a, tht_3) + diff(d43_a, tht_1) - diff(d31_a, tht_4)));

C324_a = simplify((1/2)*(diff(d42_a, tht_3) + diff(d43_a, tht_2) - diff(d32_a, tht_4)));

C334_a = simplify((1/2)*(diff(d43_a, tht_3) + diff(d43_a, tht_3) - diff(d33_a, tht_4)));

C344_a = simplify((1/2)*(diff(d44_a, tht_3) + diff(d43_a, tht_4) - diff(d34_a, tht_4)));

C414_a = simplify((1/2)*(diff(d41_a, tht_4) + diff(d44_a, tht_1) - diff(d41_a, tht_4)));

C424_a = simplify((1/2)*(diff(d42_a, tht_4) + diff(d44_a, tht_2) - diff(d42_a, tht_4)));

C434_a = simplify((1/2)*(diff(d43_a, tht_4) + diff(d44_a, tht_3) - diff(d43_a, tht_4)));

C444_a = simplify((1/2)*(diff(d44_a, tht_4) + diff(d44_a, tht_4) - diff(d44_a, tht_4)));

%% ======== CALCULOS DOS COMPONENTES DA ENERGIA POTENCIAL P(q) ============

syms g
assume(g, 'real')

% COMPONENTE ENERGIA POTENCIAL LINK 1 (PE)
% rc1_a é a posicao em Y do Centro de Massa do Link 1 = Pe
rc1_a = subs(h1_a, Lp, Lp_cm);
P1_a = m1*g*rc1_a;

% COMPONENTE ENERGIA POTENCIAL LINK 2 (PERNA)
% rc2_a é a posicao em Y do Centro de Massa do Link 2 = Perna
rc2_a = subs(h2_a, Lj, Lj_cm);
P2_a = m2*g*rc2_a;

% COMPONENTE ENERGIA POTENCIAL LINK 3 (COXA)
% rc3_a é a posicao em Y do Centro de Massa do Link 3 = Coxa
rc3_a = subs(h3_a, Lc, Lc_cm);
P3_a = m3*g*rc3_a;

% COMPONENTE ENERGIA POTENCIAL LINK 4 (HAT)
% rc4_a é a posicao em Y do Centro de Massa do Link 4 = CoM do HAT
rc4_a = h4_a;
P4_a = m4*g*rc4_a;

% ENERGIA POTENCIAL TOTAL DO ROBÔ P(q) PARA A FASE DE APOIO
P_a = simplify(P1_a + P2_a + P3_a + P4_a);

% DERIVADA DA ENERGIA POTENCIAL P(q) EM RELACAO A theta_1
g1_a = diff(P_a, tht_1);

% DERIVADA DA ENERGIA POTENCIAL P(q) EM RELACAO A theta_2
g2_a = diff(P_a, tht_2);

% DERIVADA DA ENERGIA POTENCIAL P(q) EM RELACAO A theta_3
g3_a = diff(P_a, tht_3);

% DERIVADA DA ENERGIA POTENCIAL P(q) EM RELACAO A theta_4
g4_a = diff(P_a, tht_4);

%% CALCULO DOS TORQUES NAS JUNTAS DO QUADRIL, JOELHO E TORNOZELO  

% Definicao das variáveis da primeira e segunda derivada da posicao(angulo) 
syms tht1_p tht1_2p tht2_p tht2_2p tht3_p tht3_2p tht4_p tht4_2p

% Primeira e segunda derivada do angulo theta_1
assume(tht1_p,  'real')
assume(tht1_2p, 'real')
% Primeira e segunda derivada do angulo theta_2
assume(tht2_p,  'real')
assume(tht2_2p, 'real')
% Primeira e segunda derivada do angulo theta_3
assume(tht3_p,  'real')
assume(tht3_2p, 'real')
% Primeira e segunda derivada do angulo theta_4
assume(tht4_p,  'real')
assume(tht4_2p, 'real')

% === CALCULO DO TORQUE NA JUNTA DO DEDAO EM APOIO k = 1,{i,j = 1,2,3,4}===

% PARA k = 1 (TORQUE DA JUNTA DO DEDAO EM APOIO ---> tau_1)
torD_a = simplify( d11_a*(tht1_2p) + d12_a*(tht2_2p) + d13_a*(tht3_2p) +...
d14_a*(tht4_2p) + C111_a*(tht1_p^2) + (C121_a+C211_a)*(tht1_p*tht2_p) +...
(C131_a+C311_a)*(tht1_p*tht3_p) + (C141_a+C411_a)*(tht1_p*tht4_p) +...
C221_a*(tht2_p^2) + (C231_a+C321_a)*(tht2_p*tht3_p) + (C241_a+C421_a)*(tht2_p*tht4_p) +...
C331_a*(tht3_p^2) + (C341_a+C431_a)*(tht3_p*tht4_p) + C441_a*(tht4_p^2) + g1_a);

% torD_a = I33_h*tht1_2p + I33_j*tht1_2p + I33_q*tht1_2p + I33_h*tht2_2p +...
% I33_j*tht2_2p + I33_t*tht1_2p + I33_q*tht2_2p + I33_h*tht3_2p +...
% I33_q*tht3_2p + I33_h*tht4_2p + a0^2*m4*tht1_2p + a0^2*m4*tht2_2p +...
% a0^2*m4*tht3_2p + a0^2*m4*tht4_2p + Lc^2*m4*tht1_2p + Lc^2*m4*tht2_2p +...
% Lc^2*m4*tht3_2p + Lc_cm^2*m3*tht1_2p + Lc_cm^2*m3*tht2_2p + Lc_cm^2*m3*tht3_2p +...
% Lj^2*m3*tht1_2p + Lj^2*m4*tht1_2p + Lj^2*m3*tht2_2p + Lj^2*m4*tht2_2p +...
% Lj_cm^2*m2*tht1_2p + Lj_cm^2*m2*tht2_2p + Lp^2*m2*tht1_2p + Lp^2*m3*tht1_2p +...
% Lp^2*m4*tht1_2p + Lp_cm^2*m1*tht1_2p - a0*g*m4*sin(tht_1 + tht_2 + tht_3 + tht_4) -...
% Lj*g*m3*sin(tht_1 + tht_2) - Lj*g*m4*sin(tht_1 + tht_2) -...
% Lj_cm*g*m2*sin(tht_1 + tht_2) - Lp*g*m2*cos(tht_1) - Lp*g*m3*cos(tht_1) -...
% Lp*g*m4*cos(tht_1) - Lp_cm*g*m1*cos(tht_1) - Lc*g*m4*sin(tht_1 + tht_2 + tht_3) -...
% Lc_cm*g*m3*sin(tht_1 + tht_2 + tht_3) - Lj*a0*m4*tht3_p^2*sin(tht_3 + tht_4) -...
% Lj*a0*m4*tht4_p^2*sin(tht_3 + tht_4) + Lj*Lp*m3*tht2_p^2*cos(tht_2) +...
% Lj*Lp*m4*tht2_p^2*cos(tht_2) + Lj_cm*Lp*m2*tht2_p^2*cos(tht_2) +...
% 2*Lp*a0*m4*tht1_2p*sin(tht_2 + tht_3 + tht_4) + Lp*a0*m4*tht2_2p*sin(tht_2 + tht_3 + tht_4) +...
% Lp*a0*m4*tht3_2p*sin(tht_2 + tht_3 + tht_4) + Lp*a0*m4*tht4_2p*sin(tht_2 + tht_3 + tht_4) -...
% Lc*Lj*m4*tht3_p^2*sin(tht_3) - Lc_cm*Lj*m3*tht3_p^2*sin(tht_3) -...
% Lc*a0*m4*tht4_p^2*sin(tht_4) + Lp*a0*m4*tht2_p^2*cos(tht_2 + tht_3 + tht_4) +...
% Lp*a0*m4*tht3_p^2*cos(tht_2 + tht_3 + tht_4) + Lp*a0*m4*tht4_p^2*cos(tht_2 + tht_3 + tht_4) +...
% 2*Lc*Lp*m4*tht1_2p*sin(tht_2 + tht_3) + Lc*Lp*m4*tht2_2p*sin(tht_2 + tht_3) +...
% Lc*Lp*m4*tht3_2p*sin(tht_2 + tht_3) + 2*Lc_cm*Lp*m3*tht1_2p*sin(tht_2 + tht_3) +...
% Lc_cm*Lp*m3*tht2_2p*sin(tht_2 + tht_3) + Lc_cm*Lp*m3*tht3_2p*sin(tht_2 + tht_3) +...
% 2*Lj*a0*m4*tht1_2p*cos(tht_3 + tht_4) + 2*Lj*a0*m4*tht2_2p*cos(tht_3 + tht_4) +...
% Lj*a0*m4*tht3_2p*cos(tht_3 + tht_4) + Lj*a0*m4*tht4_2p*cos(tht_3 + tht_4) +...
% 2*Lc*Lj*m4*tht1_2p*cos(tht_3) + 2*Lc*Lj*m4*tht2_2p*cos(tht_3) + Lc*Lj*m4*tht3_2p*cos(tht_3) +...
% 2*Lc_cm*Lj*m3*tht1_2p*cos(tht_3) + 2*Lc_cm*Lj*m3*tht2_2p*cos(tht_3) +...
% Lc_cm*Lj*m3*tht3_2p*cos(tht_3) + 2*Lj*Lp*m3*tht1_2p*sin(tht_2) +...
% 2*Lj*Lp*m4*tht1_2p*sin(tht_2) + Lj*Lp*m3*tht2_2p*sin(tht_2) + Lj*Lp*m4*tht2_2p*sin(tht_2) +...
% 2*Lj_cm*Lp*m2*tht1_2p*sin(tht_2) + Lj_cm*Lp*m2*tht2_2p*sin(tht_2) +...
% 2*Lc*a0*m4*tht1_2p*cos(tht_4) + 2*Lc*a0*m4*tht2_2p*cos(tht_4) +...
% 2*Lc*a0*m4*tht3_2p*cos(tht_4) + Lc*a0*m4*tht4_2p*cos(tht_4) +...
% Lc*Lp*m4*tht2_p^2*cos(tht_2 + tht_3) + Lc*Lp*m4*tht3_p^2*cos(tht_2 + tht_3) +...
% Lc_cm*Lp*m3*tht2_p^2*cos(tht_2 + tht_3) + Lc_cm*Lp*m3*tht3_p^2*cos(tht_2 + tht_3) -...
% 2*Lj*a0*m4*tht1_p*tht3_p*sin(tht_3 + tht_4) - 2*Lj*a0*m4*tht1_p*tht4_p*sin(tht_3 + tht_4) -...
% 2*Lj*a0*m4*tht2_p*tht3_p*sin(tht_3 + tht_4) - 2*Lj*a0*m4*tht2_p*tht4_p*sin(tht_3 + tht_4) -...
% 2*Lj*a0*m4*tht3_p*tht4_p*sin(tht_3 + tht_4) + 2*Lj*Lp*m3*tht1_p*tht2_p*cos(tht_2) +...
% 2*Lj*Lp*m4*tht1_p*tht2_p*cos(tht_2) + 2*Lj_cm*Lp*m2*tht1_p*tht2_p*cos(tht_2) -...
% 2*Lc*Lj*m4*tht1_p*tht3_p*sin(tht_3) - 2*Lc*Lj*m4*tht2_p*tht3_p*sin(tht_3) -...
% 2*Lc_cm*Lj*m3*tht1_p*tht3_p*sin(tht_3) - 2*Lc_cm*Lj*m3*tht2_p*tht3_p*sin(tht_3) -...
% 2*Lc*a0*m4*tht1_p*tht4_p*sin(tht_4) - 2*Lc*a0*m4*tht2_p*tht4_p*sin(tht_4) -...
% 2*Lc*a0*m4*tht3_p*tht4_p*sin(tht_4) + 2*Lp*a0*m4*tht1_p*tht2_p*cos(tht_2 + tht_3 + tht_4) +...
% 2*Lp*a0*m4*tht1_p*tht3_p*cos(tht_2 + tht_3 + tht_4) +...
% 2*Lp*a0*m4*tht1_p*tht4_p*cos(tht_2 + tht_3 + tht_4) +...
% 2*Lp*a0*m4*tht2_p*tht3_p*cos(tht_2 + tht_3 + tht_4) +...
% 2*Lp*a0*m4*tht2_p*tht4_p*cos(tht_2 + tht_3 + tht_4) +...
% 2*Lp*a0*m4*tht3_p*tht4_p*cos(tht_2 + tht_3 + tht_4) +...
% 2*Lc*Lp*m4*tht1_p*tht2_p*cos(tht_2 + tht_3) + 2*Lc*Lp*m4*tht1_p*tht3_p*cos(tht_2 + tht_3) +...
% 2*Lc*Lp*m4*tht2_p*tht3_p*cos(tht_2 + tht_3) +...
% 2*Lc_cm*Lp*m3*tht1_p*tht2_p*cos(tht_2 + tht_3) +...
% 2*Lc_cm*Lp*m3*tht1_p*tht3_p*cos(tht_2 + tht_3) + 2*Lc_cm*Lp*m3*tht2_p*tht3_p*cos(tht_2 + tht_3);

% PARA k = 2 (TORQUE DA JUNTA DO TORNOZELO ---> tau_2)
torT_a = simplify(d21_a*(tht1_2p) + d22_a*(tht2_2p) + d23_a*(tht2_2p) +...
d24_a*(tht4_2p) + C112_a*(tht1_p^2) + (C122_a+C212_a)*(tht1_p*tht2_p) +...
(C132_a+C312_a)*(tht1_p*tht3_p) + (C142_a+C412_a)*(tht1_p*tht4_p) +...
C222_a*(tht2_p^2) + (C232_a+C322_a)*(tht2_p*tht3_p) +...
(C242_a+C422_a)*(tht2_p*tht4_p) + C332_a*(tht3_p^2) +...
(C342_a+C432_a)*tht3_p*tht4_p + C442_a*(tht4_p^2) + g2_a);

% torT_a = I33_h*tht1_2p + I33_j*tht1_2p + I33_q*tht1_2p + 2*I33_h*tht2_2p + I33_j*tht2_2p +...
% 2*I33_q*tht2_2p + I33_h*tht4_2p + a0^2*m4*tht1_2p + 2*a0^2*m4*tht2_2p + a0^2*m4*tht4_2p +...
% Lc^2*m4*tht1_2p + 2*Lc^2*m4*tht2_2p + Lc_cm^2*m3*tht1_2p + 2*Lc_cm^2*m3*tht2_2p +...
% Lj^2*m3*tht1_2p + Lj^2*m4*tht1_2p + Lj^2*m3*tht2_2p + Lj^2*m4*tht2_2p + Lj_cm^2*m2*tht1_2p +...
% Lj_cm^2*m2*tht2_2p - a0*g*m4*sin(tht_1 + tht_2 + tht_3 + tht_4) -...
% Lj*g*m3*sin(tht_1 + tht_2) - Lj*g*m4*sin(tht_1 + tht_2) - Lj_cm*g*m2*sin(tht_1 + tht_2) -...
% Lc*g*m4*sin(tht_1 + tht_2 + tht_3) - Lc_cm*g*m3*sin(tht_1 + tht_2 + tht_3) -...
% Lj*a0*m4*tht3_p^2*sin(tht_3 + tht_4) - Lj*a0*m4*tht4_p^2*sin(tht_3 + tht_4) -...
% Lj*Lp*m3*tht1_p^2*cos(tht_2) - Lj*Lp*m4*tht1_p^2*cos(tht_2) -...
% Lj_cm*Lp*m2*tht1_p^2*cos(tht_2) + Lp*a0*m4*tht1_2p*sin(tht_2 + tht_3 + tht_4) -...
% Lc*Lj*m4*tht3_p^2*sin(tht_3) - Lc_cm*Lj*m3*tht3_p^2*sin(tht_3) -...
% Lc*a0*m4*tht4_p^2*sin(tht_4) - Lp*a0*m4*tht1_p^2*cos(tht_2 + tht_3 + tht_4) +...
% Lc*Lp*m4*tht1_2p*sin(tht_2 + tht_3) + Lc_cm*Lp*m3*tht1_2p*sin(tht_2 + tht_3) +...
% 2*Lj*a0*m4*tht1_2p*cos(tht_3 + tht_4) + 3*Lj*a0*m4*tht2_2p*cos(tht_3 + tht_4) +...
% Lj*a0*m4*tht4_2p*cos(tht_3 + tht_4) + 2*Lc*Lj*m4*tht1_2p*cos(tht_3) +...
% 3*Lc*Lj*m4*tht2_2p*cos(tht_3) + 2*Lc_cm*Lj*m3*tht1_2p*cos(tht_3) +...
% 3*Lc_cm*Lj*m3*tht2_2p*cos(tht_3) + Lj*Lp*m3*tht1_2p*sin(tht_2) + Lj*Lp*m4*tht1_2p*sin(tht_2) +...
% Lj_cm*Lp*m2*tht1_2p*sin(tht_2) + 2*Lc*a0*m4*tht1_2p*cos(tht_4) +...
% 4*Lc*a0*m4*tht2_2p*cos(tht_4) + Lc*a0*m4*tht4_2p*cos(tht_4) -...
% Lc*Lp*m4*tht1_p^2*cos(tht_2 + tht_3) - Lc_cm*Lp*m3*tht1_p^2*cos(tht_2 + tht_3) -...
% 2*Lj*a0*m4*tht1_p*tht3_p*sin(tht_3 + tht_4) - 2*Lj*a0*m4*tht1_p*tht4_p*sin(tht_3 + tht_4) -...
% 2*Lj*a0*m4*tht2_p*tht3_p*sin(tht_3 + tht_4) - 2*Lj*a0*m4*tht2_p*tht4_p*sin(tht_3 + tht_4) -...
% 2*Lj*a0*m4*tht3_p*tht4_p*sin(tht_3 + tht_4) - 2*Lc*Lj*m4*tht1_p*tht3_p*sin(tht_3) -...
% 2*Lc*Lj*m4*tht2_p*tht3_p*sin(tht_3) - 2*Lc_cm*Lj*m3*tht1_p*tht3_p*sin(tht_3) -...
% 2*Lc_cm*Lj*m3*tht2_p*tht3_p*sin(tht_3) - 2*Lc*a0*m4*tht1_p*tht4_p*sin(tht_4) -...
% 2*Lc*a0*m4*tht2_p*tht4_p*sin(tht_4) - 2*Lc*a0*m4*tht3_p*tht4_p*sin(tht_4);

% PARA k = 3 (TORQUE DA JUNTA DO JOELHO ---> tau_3)
torJ_a = simplify( d31_a*(tht1_2p) + d32_a*(tht2_2p) + d33_a*(tht3_2p) +...
d34_a*(tht4_2p) + C113_a*(tht1_p^2) + (C123_a+C213_a)*(tht1_p*tht2_p) +...
(C133_a+C313_a)*(tht1_p*tht3_p) + (C143_a+C413_a)*(tht1_p*tht4_p) +...
+ C223_a*(tht2_p^2) + (C233_a+C323_a)*(tht2_p*tht3_p) +...
(C243_a+C423_a)*(tht2_p*tht4_p) + C333_a*(tht3_p^2) +...
(C343_a+C433_a)*(tht3_p*tht4_p) + C443_a*(tht4_p^2) + g3_a);

% torJ_a = I33_h*tht1_2p + I33_q*tht1_2p + I33_h*tht2_2p + I33_q*tht2_2p + I33_h*tht3_2p +...
% I33_q*tht3_2p + I33_h*tht4_2p + a0^2*m4*tht1_2p + a0^2*m4*tht2_2p + a0^2*m4*tht3_2p +...
% a0^2*m4*tht4_2p + Lc^2*m4*tht1_2p + Lc^2*m4*tht2_2p + Lc^2*m4*tht3_2p + Lc_cm^2*m3*tht1_2p +...
% Lc_cm^2*m3*tht2_2p + Lc_cm^2*m3*tht3_2p - a0*g*m4*sin(tht_1 + tht_2 + tht_3 + tht_4) -...
% Lc*g*m4*sin(tht_1 + tht_2 + tht_3) - Lc_cm*g*m3*sin(tht_1 + tht_2 + tht_3) +...
% Lj*a0*m4*tht1_p^2*sin(tht_3 + tht_4) + Lj*a0*m4*tht2_p^2*sin(tht_3 + tht_4) +...
% Lp*a0*m4*tht1_2p*sin(tht_2 + tht_3 + tht_4) + Lc*Lj*m4*tht1_p^2*sin(tht_3) +...
% Lc*Lj*m4*tht2_p^2*sin(tht_3) + Lc_cm*Lj*m3*tht1_p^2*sin(tht_3) +...
% Lc_cm*Lj*m3*tht2_p^2*sin(tht_3) - Lc*a0*m4*tht4_p^2*sin(tht_4) -...
% Lp*a0*m4*tht1_p^2*cos(tht_2 + tht_3 + tht_4) + Lc*Lp*m4*tht1_2p*sin(tht_2 + tht_3) +...
% Lc_cm*Lp*m3*tht1_2p*sin(tht_2 + tht_3) + Lj*a0*m4*tht1_2p*cos(tht_3 + tht_4) +...
% Lj*a0*m4*tht2_2p*cos(tht_3 + tht_4) + Lc*Lj*m4*tht1_2p*cos(tht_3) + Lc*Lj*m4*tht2_2p*cos(tht_3) +...
% Lc_cm*Lj*m3*tht1_2p*cos(tht_3) + Lc_cm*Lj*m3*tht2_2p*cos(tht_3) + 2*Lc*a0*m4*tht1_2p*cos(tht_4) +...
% 2*Lc*a0*m4*tht2_2p*cos(tht_4) + 2*Lc*a0*m4*tht3_2p*cos(tht_4) + Lc*a0*m4*tht4_2p*cos(tht_4) -...
% Lc*Lp*m4*tht1_p^2*cos(tht_2 + tht_3) - Lc_cm*Lp*m3*tht1_p^2*cos(tht_2 + tht_3) +...
% 2*Lj*a0*m4*tht1_p*tht2_p*sin(tht_3 + tht_4) + 2*Lc*Lj*m4*tht1_p*tht2_p*sin(tht_3) +...
% 2*Lc_cm*Lj*m3*tht1_p*tht2_p*sin(tht_3) - 2*Lc*a0*m4*tht1_p*tht4_p*sin(tht_4) -...
% 2*Lc*a0*m4*tht2_p*tht4_p*sin(tht_4) - 2*Lc*a0*m4*tht3_p*tht4_p*sin(tht_4);

% PARA k = 4 (TORQUE DA JUNTA DO JOELHO ---> tau_4)

torQ_a = simplify( d41_a*(tht1_2p) + d42_a*(tht2_2p) + d43_a*(tht3_2p) +...
d44_a*(tht4_2p) + C114_a*(tht1_p^2) + (C124_a+C214_a)*(tht1_p*tht2_p) +...
(C134_a+C314_a)*(tht1_p*tht3_p) + (C144_a+C414_a)*(tht1_p*tht4_p) +...
C224_a*(tht2_p^2) + (C234_a+C324_a)*(tht2_p*tht3_p) +...
(C244_a+C424_a)*(tht2_p*tht4_p) + C334_a*(tht3_p^2) +...
(C344_a+C434_a)*(tht3_p*tht4_p) + C444_a*(tht4_p^2) + g4_a);

% torQ_a = a0*m4*(Lj*sin(tht_3 + tht_4) + Lc*sin(tht_4) - Lp*cos(tht_2 + tht_3 + tht_4))*tht1_p^2 +...
% 2*a0*m4*(Lj*sin(tht_3 + tht_4) + Lc*sin(tht_4))*tht1_p*tht2_p +...
% 2*Lc*a0*m4*sin(tht_4)*tht1_p*tht3_p + a0*m4*(Lj*sin(tht_3 + tht_4) + Lc*sin(tht_4))*tht2_p^2 +...
% 2*Lc*a0*m4*sin(tht_4)*tht2_p*tht3_p + Lc*a0*m4*sin(tht_4)*tht3_p^2 + tht4_2p*(m4*a0^2 + I33_h) +...
% tht1_2p*(I33_h + a0*m4*(a0 + Lj*cos(tht_3 + tht_4) + Lc*cos(tht_4) + Lp*sin(tht_2 + tht_3 + tht_4))) +...
% tht2_2p*(I33_h + a0*m4*(a0 + Lj*cos(tht_3 + tht_4) + Lc*cos(tht_4))) +...
% tht3_2p*(I33_h + a0*m4*(a0 + Lc*cos(tht_4))) - a0*g*m4*sin(tht_1 + tht_2 + tht_3 + tht_4);

%% [3] FASE DE APOIO - REFERENCIA NO TORNOZELO - END-EFFECTOR NO CoM DO HAT

% DEFINICAO DAS VARIÁVEIS SIMBÓLICAS PARA A CINEMATICA E DINAMICA DO ROBÔ

syms tht_1 tht_2 tht_3 Lc Lj Lp a0 d0;

% Define the "assumptions" para as variáveis simbólicas
assume(tht_1, 'real');
assume(tht_2, 'real');
assume(tht_3, 'real');
assume(tht_4, 'real');

assume(Lc, 'real');
% assumeAlso(Lc, 'positive');
assume(Lj, 'real');
% assumeAlso(Lj, 'positive');
assume(Lp, 'real');
% assumeAlso(Lp, 'positive');

assume(a0, 'real');
assume(d0, 'real');

%% ========== CALCULO MAS MATRIZES DE TRANSFORMACAO HOMOGENEA =============
% Matriz de Transformacao Homogenea A10_a (LINK 1 O1X1Y1Z1 -> O0X0Y0Z0)
A10_ap = [cos(tht_1 + pi/2)   -sin(tht_1 + pi/2)*cos(0)   sin(tht_1 + pi/2)*sin(0) Lj*cos(tht_1 + pi/2);
          sin(tht_1 + pi/2)    cos(tht_1 + pi/2)*cos(0)  -cos(tht_1 + pi/2)*sin(0) Lj*sin(tht_1 + pi/2);
          0                    sin(0)                     cos(0)                   0;
          0                    0                          0                        1];

A10_ap = simplify(A10_ap);

% Matriz de Transformacao Homogenea A21_a (LINK 2 O2X2Y2Z2 -> O1X1Y1Z1) 
A21_ap = [cos(tht_2)  -sin(tht_2)*cos(0)   sin(tht_2)*sin(0)  Lc*cos(tht_2);
          sin(tht_2)   cos(tht_2)*cos(0)  -cos(tht_2)*sin(0)  Lc*sin(tht_2);
          0            sin(0)              cos(0)             0;
          0            0                   0                  1];
   
A21_ap = simplify(A21_ap);

% Matriz de Transformacao Homogenea A43_a (LINK 4 O4X4Y4Z4 -> O3X3Y3Z3)
A32_ap = [cos(tht_3)  -sin(tht_3)*cosd(180)  sin(tht_3)*sind(180)  a0*cos(tht_3);
          sin(tht_3)   cos(tht_3)*cosd(180) -cos(tht_3)*sind(180)  a0*sin(tht_3);
          0            sind(180)             cosd(180)             -d0;
          0            0                     0                     1];
A32_ap = simplify(A32_ap);

% Posicao e orientacao do sistema O1X1Y1Z1 em relacao ao sistema O0X0Y0Z0
% Posicao da junta do JOELHO
T10_ap = simplify(A10_ap);

% Posicao e orientacao do sistema O2X2Y2Z2 em relacao ao sistema O0X0Y0Z0
% Posicao da junta do QUADRIL
T20_ap = simplify(A10_ap*A21_ap);
 
% Posicao e orientacao do sistema O3X3Y3Z3 em relacao ao sistema O0X0Y0Z0
% Posicao do CoM DO HAT
T30_ap = simplify(A10_ap*A21_ap*A32_ap);

syms tht_q tht_j tht_t
T1_AP = subs(T10_ap, tht_1, tht_q + tht_j);
T2_AP = subs(T20_ap, [tht_1, tht_2], [tht_q + tht_j, -tht_j]);
T3_AP = subs(T30_ap, [tht_1, tht_2, tht_3], [tht_q + tht_j, -tht_j, -tht_q]);

%% ===========  CALCULO DO JACOBIANO PARA A FASE DE APOIO =================
% =========== SISTEMA O0X0Y0Z0 NA JUNTA DO TORNOZELO =====================

% Vetor Z0 e O0 do sistema de referencia inercial O0x0Y0Z0
Z0_ap = [0 0 1]';
O0_ap = [0 0 0]';

% Vetor Z1, O1 e Matriz de Rotacao R_10 do sistema O1X1Y1Z1 em relacao ao 
% sistema O0X0Y0Z0 (Inercial)
Z1_ap  = T10_ap(1:3,3);
O1_ap  = T10_ap(1:3,4);
R10_ap = T10_ap(1:3,1:3);
% Componente em Y da altura do link 1
h1_ap  = T10_ap(2,4);

% Vetor Z2, O2 e Matriz de Rotacao R_20 do sistema O2X2Y2Z2 em relacao ao 
% sistema O0X0Y0Z0 
Z2_ap  = T20_ap(1:3,3);
O2_ap  = T20_ap(1:3,4);
R20_ap = T20_ap(1:3,1:3);
% Componente em Y da altura do link 2
h2_ap  = T20_ap(2,4);

% Vetor Z3, O3 e Matriz de Rotacao R_30 do sistema O3X3Y3Z3 em relacao ao 
% sistema O0X0Y0Z0 
Z3_ap  = T30_ap(1:3,3);
O3_ap  = T30_ap(1:3,4);
R30_ap = T30_ap(1:3,1:3);
% Componente em Y da altura do link 3
h3_ap  = T30_ap(2,4);

% Vetor distancia cada sistema OiXiYiZi em relacao a origem O0X0Y0Z0
O30_ap = simplify(O3_ap - O0_ap);
O31_ap = simplify(O3_ap - O1_ap);
O32_ap = simplify(O3_ap - O2_ap);

% Matrizes jacobianas da velocidade Linear do End-Effector Jvi
Jv1_ap = cross(Z0_ap, O30_ap);
Jv2_ap = cross(Z1_ap, O31_ap);
Jv3_ap = cross(Z2_ap, O32_ap);

% Matrizes jacobianas da velocidade Angular do End-Effector Jwi
Jw1_ap = Z0_ap;
Jw2_ap = Z1_ap;
Jw3_ap = Z2_ap;

% MATRIZ JACOBIANA PARA O MODELO DA FASE DE APOIO J_A = [Jvi; Jwi]
J_AP = [Jv1_ap Jv2_ap Jv3_ap;
        Jw1_ap Jw2_ap Jw3_ap];
    
J_apoio = subs(J_AP, [tht_1, tht_2, tht_3], [tht_q + tht_j, -tht_j, -tht_q]);

%% EQUACOES DINÂMICAS DA FASE DE APOIO REFERENCIA O0X0Y0Z0 NO TORNOZELO E 
% END-EFFECTOR NO CoM DO HAT

%%%======== JUNTA 1 = TORNOZELO   --->   LINK 1 = PERNA ======================
% L1 = Lj     L1_cm = Lj_cm     m1 = massa_perna
syms Lj_cm m1
syms I11_j I12_j I13_j I21_j I22_j I23_j I31_j I32_j I33_j

assume(Lj_cm, 'real');
% assumeAlso(Lj_cm, 'positive');
assume(m1, 'real');
assumeAlso(m1, 'positive');
assume(I11_j, 'real'); assumeAlso(I11_j, 'positive');
assume(I22_j, 'real'); assumeAlso(I22_j, 'positive');
assume(I33_j, 'real'); assumeAlso(I33_j, 'positive');
assume(I12_j, 'real'); assume(I13_j, 'real'); assume(I21_j, 'real');
assume(I23_j, 'real'); assume(I31_j, 'real'); assume(I32_j, 'real');

%%%======== JUNTA 2 = JOELHO   --->   LINK 2 = COXA == ===================
% L2 = Lc     L2_cm = Lc_cm     m2 = massa_coxa
syms Lc_cm m2
syms I11_q I12_q I13_q I21_q I22_q I23_q I31_q I32_q I33_q

assume(Lc_cm, 'real');
% assumeAlso(Lc_cm, 'positive');
assume(m2, 'real');
assumeAlso(m2, 'positive');
assume(I11_q, 'real'); assumeAlso(I11_q, 'positive');
assume(I22_q, 'real'); assumeAlso(I22_q, 'positive');
assume(I33_q, 'real'); assumeAlso(I33_q, 'positive');
assume(I12_q, 'real'); assume(I13_q, 'real'); assume(I21_q, 'real');
assume(I23_q, 'real'); assume(I31_q, 'real'); assume(I32_q, 'real');

%%%======== JUNTA 3 = QUADRIL   --->   LINK 3 = CoM DO HAT ================
% L3 = 2*a0 (altura HAT)     L3_cm = a0     m3 = massa_HAT

syms a0 m3
syms I11_h I12_h I13_h I21_h I22_h I23_h I31_h I32_h I33_h

assume(a0, 'real');
% assumeAlso(a0, 'positive');
assume(m3, 'real');
assumeAlso(m3, 'positive');
assume(I11_h, 'real'); assumeAlso(I11_h, 'positive');
assume(I22_h, 'real'); assumeAlso(I22_h, 'positive');
assume(I33_h, 'real'); assumeAlso(I33_h, 'positive');
assume(I12_h, 'real'); assume(I13_h, 'real'); assume(I21_h, 'real');
assume(I23_h, 'real'); assume(I31_h, 'real'); assume(I32_h, 'real');

%% ===== CALCULO DOS COMPONENTES DA ENERGIA CINETICA DO ROBÔ K(q) =========

% Jacobiano Velocidade Linear Centro de Massa do Link 1
JVc1_ap = J_AP(1:3, 1:end);
JVc1_ap = subs(JVc1_ap,[Lc a0],[0 0]);
JVc1_ap = subs(JVc1_ap, Lj, Lj_cm);

% Jacobiano Velocidade Linear Centro de Massa do Link 2
JVc2_ap = J_AP(1:3, 1:end);
JVc2_ap = subs(JVc2_ap, a0, 0);
JVc2_ap = subs(JVc2_ap, Lc, Lc_cm);

% Jacobiano Velocidade Linear Centro de Massa do Link 3
JVc3_ap = J_AP(1:3, 1:end);

n = size(J_AP,2); % Número de colunas da Matriz Jacobiana J_AP

% Jacobiano Velocidade Angular Centro de Massa Link 1
Jwc1_ap = [J_AP(4:6,1),  zeros(3, n-1)];

% Jacobiano Velocidade Linear Centro de Massa Link 2
Jwc2_ap = [J_AP(4:6,1:2), zeros(3, n-2)];

% Jacobiano Velocidade Linear Centro de Massa Link 3
Jwc3_ap = J_AP(4:end, 1:end);


% COMPONENTE 1 ENERGIA CINÉTICA TRASLACIONAL KVc1_ap = m1*J_Vc1'*J_Vc1
KVc1_ap = simplify(m1*(JVc1_ap')*JVc1_ap);

% COMPONENTE 2 ENERGIA CINÉTICA TRASLACIONAL K_Vc2 = m2*J_Vc2'*J_Vc2
KVc2_ap = simplify(m2*(JVc2_ap')*JVc2_ap);

% COMPONENTE 3 ENERGIA CINÉTICA TRASLACIONAL K_Vc3 = m3*J_Vc3'*J_Vc3
KVc3_ap = simplify(m3*(JVc3_ap')*JVc3_ap);


% COMPONENTE 1 ENERGÍA CINETICA ROTACIONAL K_wc1=J_w1'*R01_ap*I1*R01_ap'*J_w1
  % Tensor de inercia link 1 (PERNA)
    I1 = [I11_j I12_j I13_j; I21_j I22_j I23_j; I31_j I32_j I33_j];

Kwc1_ap = simplify((Jwc1_ap')*R10_ap*I1*(R10_ap')*Jwc1_ap);

% COMPONENTE 2 ENERGÍA CINETICA ROTACIONAL K_wc2=J_w2'*R02_ap*I2*R02_ap'*J_w2
  % Tensor de inercia link 2 (COXA)
    I2 = [I11_q I12_q I13_q; I21_q I22_q I23_q; I31_q I32_q I33_q];

Kwc2_ap = simplify((Jwc2_ap')*R20_ap*I2*(R20_ap')*Jwc2_ap);


% COMPONENTE 3 ENERGÍA CINETICA ROTACIONAL K_wc3=J_w3'*R03_ap*I3*R03_ap'*J_w3
  % Tensor de inercia link 3 (CoM do HAT)
    I3 = [I11_h I12_h I13_h; I21_h I22_h I23_h; I31_h I32_h I33_h];

Kwc3_ap = simplify((Jwc3_ap')*R30_ap*I3*(R30_ap')*Jwc3_ap);

% MATRIZ DE INERCIA DO ROBÔ D(q) = sum{mi*Jvci'*Jvci + Jwi'*Ri*Ii*Ri'*Jwi}
% i = 1,2,3
D_ap = simplify (KVc1_ap + KVc2_ap + KVc3_ap + Kwc1_ap + Kwc2_ap + Kwc3_ap);

d11_ap = D_ap(1,1);
d12_ap = D_ap(1,2);
d13_ap = D_ap(1,3);

d21_ap = D_ap(2,1);
d22_ap = D_ap(2,2);
d23_ap = D_ap(2,3);

d31_ap = D_ap(3,1);
d32_ap = D_ap(3,2);
d33_ap = D_ap(3,3);


%% ============ CALCULO DOS COEFICIENTES DE CHRISTOFFEL ===================

% ========== PARA A JUNTA 1 = TORNOZELO, {k = 1}, {i,j = 1,2,3} ===========
C111_ap = simplify((1/2)*(diff(d11_ap, tht_1) + diff(d11_ap, tht_1) - diff(d11_ap, tht_1)));
% C111_ap = 0;
C121_ap = simplify((1/2)*(diff(d12_ap, tht_1) + diff(d11_ap, tht_2) - diff(d12_ap, tht_1)));
% C121_ap = -Lj*(Lc*m3*sin(tht_2) + Lc_cm*m2*sin(tht_2) + a0*m3*sin(tht_2 + tht_3))

C131_ap = simplify((1/2)*(diff(d13_ap, tht_1) + diff(d11_ap, tht_3) - diff(d13_ap, tht_1)));
% C131_ap = -a0*m3*(Lj*sin(tht_2 + tht_3) + Lc*sin(tht_3))

C211_ap = simplify((1/2)*(diff(d11_ap, tht_2) + diff(d12_ap, tht_1) - diff(d21_ap, tht_1)));
% C211_ap = -Lj*(Lc*m3*sin(tht_2) + Lc_cm*m2*sin(tht_2) + a0*m3*sin(tht_2 + tht_3))

C221_ap = simplify((1/2)*(diff(d12_ap, tht_2) + diff(d12_ap, tht_2) - diff(d22_ap, tht_1)));
% C221_ap = - m3*(Lj*a0*sin(tht_2 + tht_3) + Lc*Lj*sin(tht_2)) - Lc_cm*Lj*m2*sin(tht_2);

C231_ap = simplify((1/2)*(diff(d13_ap, tht_2) + diff(d12_ap, tht_3) - diff(d23_ap, tht_1)));
% C231_ap = -a0*m3*(Lj*sin(tht_2 + tht_3) + Lc*sin(tht_3));

C311_ap = simplify((1/2)*(diff(d11_ap, tht_3) + diff(d13_ap, tht_1) - diff(d31_ap, tht_1)));
% C311_ap = -a0*m3*(Lj*sin(tht_2 + tht_3) + Lc*sin(tht_3));

C321_ap = simplify((1/2)*(diff(d12_ap, tht_3) + diff(d13_ap, tht_2) - diff(d32_ap, tht_1)));
% C321_ap = -a0*m3*(Lj*sin(tht_2 + tht_3) + Lc*sin(tht_3));

C331_ap = simplify((1/2)*(diff(d13_ap, tht_3) + diff(d13_ap, tht_3) - diff(d33_ap, tht_1)));
% C331_ap = -a0*m3*(Lj*sin(tht_2 + tht_3) + Lc*sin(tht_3));

% ============ PARA A JUNTA 2 = JOELHO, (k = 2) {i,j = 1,2,3} =============
C112_ap = simplify((1/2)*(diff(d21_ap, tht_1) + diff(d21_ap, tht_1) - diff(d11_ap, tht_2)));
% C112_ap = Lj*(Lc*m3*sin(tht_2) + Lc_cm*m2*sin(tht_2) + a0*m3*sin(tht_2 + tht_3));

C122_ap = simplify((1/2)*(diff(d22_ap, tht_1) + diff(d21_ap, tht_2) - diff(d12_ap, tht_2)));
% C122_ap = 0;

C132_ap = simplify((1/2)*(diff(d23_ap, tht_1) + diff(d21_ap, tht_3) - diff(d13_ap, tht_2)));
% C132_ap = -Lc*a0*m3*sin(tht_3);

C212_ap = simplify((1/2)*(diff(d21_ap, tht_2) + diff(d22_ap, tht_1) - diff(d21_ap, tht_2)));
% C212_ap = 0;

C222_ap = simplify((1/2)*(diff(d22_ap, tht_2) + diff(d22_ap, tht_2) - diff(d22_ap, tht_2)));
% C222_ap = 0;

C232_ap = simplify((1/2)*(diff(d23_ap, tht_2) + diff(d22_ap, tht_3) - diff(d23_ap, tht_2)));
% C232_ap = -Lc*a0*m3*sin(tht_3);

C312_ap = simplify((1/2)*(diff(d21_ap, tht_3) + diff(d23_ap, tht_1) - diff(d31_ap, tht_2)));
% C312_ap = -Lc*a0*m3*sin(tht_3);

C322_ap = simplify((1/2)*(diff(d22_ap, tht_3) + diff(d23_ap, tht_2) - diff(d32_ap, tht_2)));
% C322_ap = -Lc*a0*m3*sin(tht_3);

C332_ap = simplify((1/2)*(diff(d23_ap, tht_3) + diff(d23_ap, tht_3) - diff(d33_ap, tht_2)));
% C332_ap = -Lc*a0*m3*sin(tht_3);

% ========= PARA A JUNTA 3 = QUADRIL, (k = 3) {i,j = 1,2,3} ===============
C113_ap = simplify((1/2)*(diff(d31_ap, tht_1) + diff(d31_ap, tht_1) - diff(d11_ap, tht_3)));
% C113_ap = a0*m3*(Lj*sin(tht_2 + tht_3) + Lc*sin(tht_3));

C123_ap = simplify((1/2)*(diff(d32_ap, tht_1) + diff(d31_ap, tht_2) - diff(d12_ap, tht_3)));
% C123_ap = Lc*a0*m3*sin(tht_3);

C133_ap = simplify((1/2)*(diff(d33_ap, tht_1) + diff(d31_ap, tht_3) - diff(d13_ap, tht_3)));

C213_ap = simplify((1/2)*(diff(d31_ap, tht_2) + diff(d32_ap, tht_1) - diff(d21_ap, tht_3)));
% C213_ap = Lc*a0*m3*sin(tht_3);

C223_ap = simplify((1/2)*(diff(d32_ap, tht_2) + diff(d32_ap, tht_2) - diff(d22_ap, tht_3)));
% C223_ap = Lc*a0*m3*sin(tht_3);

C233_ap = simplify((1/2)*(diff(d33_ap, tht_2) + diff(d32_ap, tht_3) - diff(d23_ap, tht_3)));
% C233_ap = 0;

C313_ap = simplify((1/2)*(diff(d31_ap, tht_3) + diff(d33_ap, tht_1) - diff(d31_ap, tht_3)));
% C313_ap = 0;

C323_ap = simplify((1/2)*(diff(d32_ap, tht_3) + diff(d33_ap, tht_2) - diff(d32_ap, tht_3)));
% C323_ap = 0;

C333_ap = simplify((1/2)*(diff(d33_ap, tht_3) + diff(d33_ap, tht_3) - diff(d33_ap, tht_3)));
% C333_ap = 0;

%% ======== CALCULOS DOS COMPONENTES DA ENERGIA POTENCIAL P(q) ============

syms g
assume(g, 'real')

% COMPONENTE ENERGIA POTENCIAL LINK 1 (PERNA)
% rc1_ap é a posicao em Y do CoM do Link 1 = PERNA
rc1_ap = subs(h1_ap, Lj, Lj_cm);
P1_ap = m1*g*rc1_ap;

% COMPONENTE ENERGIA POTENCIAL LINK 2 (COXA)
% rc2_ap é a posicao em Y do CoM do Link 2 = COXA
rc2_ap = subs(h2_ap, Lc, Lc_cm);
P2_ap = m2*g*rc2_ap;

% COMPONENTE ENERGIA POTENCIAL LINK 3 (CoM do HAT)
% rc3_ap é a posicao em Y do CoM do Link 3 = CoM DO HAT
rc3_ap = h3_ap;
P3_ap = m3*g*rc3_ap;

% ENERGIA POTENCIAL TOTAL DO ROBÔ P(q) PARA A FASE DE APOIO COM 3GL
P_ap = simplify(P1_ap + P2_ap + P3_ap);

% DERIVADA DA ENERGIA POTENCIAL P(q) EM RELACAO A theta_1
g1_ap = diff(P_ap, tht_1);

% DERIVADA DA ENERGIA POTENCIAL P(q) EM RELACAO A theta_2
g2_ap = diff(P_ap, tht_2);

% DERIVADA DA ENERGIA POTENCIAL P(q) EM RELACAO A theta_3
g3_ap = diff(P_ap, tht_3);

