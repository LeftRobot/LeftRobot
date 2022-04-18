%% [2] FASE DE APOIO - REFERENCIA NO DEDAO - END-EFFECTOR NO CoM DO HAT
% Sao consideradas 4 juntas rotacionais: th1, th2, th3, th4
% DEFINICAO DAS VARIÁVEIS SIMBÓLICAS PARA A CINEMATICA E DINAMICA DO ROBÔ
% SOLUCAO CONVENCIONAL
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
%-------------------------------------------------------------------------------
syms tht_q tht_j tht_t real
% RELACAO ENTRE OS ANGULOS tht_1, tht_2, tht_3, tht_4 e tht_q, tht_j e
% tht_t

% tht_1 =   tht_q - tht_j + tht_t
% tht_2 = - tht_t
% tht_3 =   tht_j
% tht_4 = - tht_q

% Posicao e orientacao do sistema O1X1Y1Z1 em relacao ao sistema O0X0Y0Z0
% Posicao da junta do Tornozelo
T10 = simplify(A10_a);
T10_a = subs(T10, tht_1, tht_q - tht_j + tht_t);
% Posicao e orientacao do sistema O2X2Y2Z2 em relacao ao sistema O0X0Y0Z0
% Posicao da junta do Joelho
T20 = simplify(A10_a*A21_a);
T20_a = subs(T20,[tht_1, tht_2], [tht_q - tht_j + tht_t, -tht_t]);
% Posicao e orientacao do sistema O3X3Y3Z3 em relacao ao sistema O0X0Y0Z0
% Posicao da junta do Quadril
T30 = simplify(A10_a*A21_a*A32_a);
T30_a = subs(T30,[tht_1, tht_2, tht_3], [tht_q - tht_j + tht_t, -tht_t, tht_j]);

% Posicao e orientacao do sistema O4X4Y4Z4 em relacao ao sistema O0X0Y0Z0
% Posicao do CoM do HAT
T40   = simplify(A10_a*A21_a*A32_a*A43_a);
T40_a = subs(T40,[tht_1, tht_2, tht_3, tht_4], [tht_q - tht_j + tht_t, -tht_t, tht_j, -tht_q]);

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

% MATRIZ JACOBIANA DE VELOCIDADE LINEAR PARA A POSICAO DO CoG DO HAT
Jv_A = [diff(O4_a(1), tht_t), diff(O4_a(1), tht_j), diff(O4_a(1), tht_q);
        diff(O4_a(2), tht_t), diff(O4_a(2), tht_j), diff(O4_a(2), tht_q);
        diff(O4_a(3), tht_t), diff(O4_a(3), tht_j), diff(O4_a(3), tht_q)];
    
% Matrizes jacobianas da velocidade linear do End-Effector Jwi
Jv1_a = Jv_A(1:3, 1);
Jv2_a = Jv_A(1:3, 2);
Jv3_a = Jv_A(1:3, 3);

% Matrizes jacobianas da velocidade Angular do End-Effector Jwi
Jw1_a = Z0_a;
Jw2_a = Z1_a;
Jw3_a = Z2_a;

% MATRIZ JACOBIANA PARA O MODELO DA FASE DE APOIO J_A = [Jvi; Jwi]
J_A = [Jv1_a Jv2_a Jv3_a;
       Jw1_a Jw2_a Jw3_a];

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
JVc1_A = subs(JVc1_A,[Lc, Lj],[0, 0]);
JVc1_A = subs(JVc1_A, Lp, Lp_cm);

% Jacobiano Velocidade Linear Centro de Massa do Link 2 (Perna)
JVc2_A = J_A(1:3, 1:end);
JVc2_A = subs(JVc2_A, Lc, 0);
JVc2_A = subs(JVc2_A, Lj, Lj_cm);

% Jacobiano Velocidade Linear Centro de Massa do Link 3 (Coxa)
JVc3_A = J_A(1:3, 1:end);
JVc3_A = subs(JVc3_A, Lc, Lc_cm);

n = size(J_A, 2); % Número de colunas da Matriz Jacobiana J_A

% Jacobiano Velocidade Angular Centro de Massa Link 1
Jw1_A = [J_A(4:6,1),  zeros(3, n-1)];

% Jacobiano Velocidade Linear Centro de Massa Link 2
Jw2_A = [J_A(4:6,1:2), zeros(3, n-2)];

% Jacobiano Velocidade Linear Centro de Massa Link 3
Jw3_A = J_A(4:6, 1:3);

% COMPONENTE 1 ENERGIA CINÉTICA TRASLACIONAL K_Vc1 = m1*J_Vc1'*J_Vc1
KVc1_A = simplify(m1*(JVc1_A')*(JVc1_A));

% COMPONENTE 2 ENERGIA CINÉTICA TRASLACIONAL K_Vc2 = m2*J_Vc2'*J_Vc2
KVc2_A = simplify(m2*(JVc2_A')*(JVc2_A));

% COMPONENTE 3 ENERGIA CINÉTICA TRASLACIONAL K_Vc3 = m3*J_Vc3'*J_Vc3
KVc3_A = simplify(m3*(JVc3_A')*(JVc3_A));

% COMPONENTE 1 ENERGÍA CINETICA ROTACIONAL K_wc1=J_w1'*R01_a*I1*R01_a'*J_w1
  % Tensor de inercia link 1 (PE)
    I1t = [I11_t I12_t I13_t; I21_t I22_t I23_t; I31_t I32_t I33_t];

Kwc1_A = simplify((Jw1_A')*R10_a*I1t*(R10_a')*(Jw1_A));

% COMPONENTE 2 ENERGÍA CINETICA ROTACIONAL Kwc2=J_w2'*R02_a*I2*R02_a'*J_w2
  % Tensor de inercia link 2 (PERNA)
    I2j = [I11_j I12_j I13_j; I21_j I22_j I23_j; I31_j I32_j I33_j];

Kwc2_A = simplify((Jw2_A')*R20_a*I2j*(R20_a')*(Jw2_A));


% COMPONENTE 3 ENERGÍA CINETICA ROTACIONAL K_wc3=J_w3'*R03_a*I3q*R03_a'*J_w3
  % Tensor de inercia link 3 (QUADRIL)
    I3q = [I11_q I12_q I13_q; I21_q I22_q I23_q; I31_q I32_q I33_q];

Kwc3_A = simplify((Jw3_A')*R30_a*I3q*(R30_a')*(Jw3_A));

% % COMPONENTE 4 ENERGÍA CINETICA ROTACIONAL K_wc4=J_w4'*R04_a*I4h*R04_a'*J_w4
%   % Tensor de inercia link 4 (CoM do HAT)
%     I4h = [I11_h I12_h I13_h; I21_h I22_h I23_h; I31_h I32_h I33_h];
% 
% Kwc4_A = simplify((Jw4_A)'*R40_a*I4h*(R40_a')*Jw4_A);

% MATRIZ DE INERCIA DO ROBÔ D(q) = sum{mi*Jvci'*Jvci + Jwi'*Ri*Ii*Ri'*Jwi}
% i = 1,2,3,4
D_a = simplify (KVc1_A + KVc2_A + KVc3_A + Kwc1_A + Kwc2_A + Kwc3_A);

d11_a = D_a(1,1);
d12_a = D_a(1,2);
d13_a = D_a(1,3);

d21_a = D_a(2,1);
d22_a = D_a(2,2);
d23_a = D_a(2,3);

d31_a = D_a(3,1);
d32_a = D_a(3,2);
d33_a = D_a(3,3);

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
g1_a = diff(P_a, tht_t);

% DERIVADA DA ENERGIA POTENCIAL P(q) EM RELACAO A theta_2
g2_a = diff(P_a, tht_j);

% DERIVADA DA ENERGIA POTENCIAL P(q) EM RELACAO A theta_3
g3_a = diff(P_a, tht_q);

%% CALCULO DOS TORQUES NAS JUNTAS DO QUADRIL, JOELHO E TORNOZELO  

syms thT_p thT_2p thJ_p thJ_2p thQ_p thQ_2p 

% Primeira e segunda derivada do angulo theta_1
assume(thT_p,  'real')
assume(thT_2p, 'real')
% Primeira e segunda derivada do angulo theta_2
assume(thJ_p,  'real')
assume(thJ_2p, 'real')
% Primeira e segunda derivada do angulo theta_3
assume(thQ_p,  'real')
assume(thQ_2p, 'real')

% ENERGIA POTENCIAL DO ROBO KE

CG = [thT_p; thJ_p; thQ_p];

KE = CG'*(D_a)*CG;
