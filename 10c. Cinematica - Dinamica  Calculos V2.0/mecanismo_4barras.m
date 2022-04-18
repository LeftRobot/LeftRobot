%% MECANISMO 4 BARRAS 2 DoF


close all;
clear all;
clc;


syms q1 q2 L1 Lc_1  L2 Lc_2 L3 Lc_3 L4 Lc_4;

% Define the "assumptions" para as variáveis simbólicas
assume(q1, 'real');
assume(q2, 'real');

assume(L1, 'real');
assume(Lc_1, 'real');
assume(L2, 'real');
assume(Lc_2, 'real');
assume(L3, 'real');
assume(Lc_3, 'real');
assume(L4, 'real');
assume(Lc_4, 'real');

syms m1 m2 m3 m4;

assume(m1, 'real');
assume(m2, 'real');
assume(m3, 'real');
assume(m4, 'real');

syms Ixx_1 Ixy_1 Ixz_1 Iyx_1 Iyy_1 Iyz_1 Izx_1 Izy_1 Izz_1

syms Ixx_2 Ixy_2 Ixz_2 Iyx_2 Iyy_2 Iyz_2 Izx_2 Izy_2 Izz_2

syms Ixx_3 Ixy_3 Ixz_3 Iyx_3 Iyy_3 Iyz_3 Izx_3 Izy_3 Izz_3

syms Ixx_4 Ixy_4 Ixz_4 Iyx_4 Iyy_4 Iyz_4 Izx_4 Izy_4 Izz_4


% Posicao do CoM de cada link do mecanismo 4 barras

Xc1 = Lc_1*cos(q1);
Yc1 = Lc_1*sin(q1);

Xc2 = Lc_2*cos(q2);
Yc2 = Lc_2*sin(q2);

Xc3 = L2*cos(q2) + Lc_3*cos(q1);
Yc3 = L2*sin(q2) + Lc_3*sin(q1);

Xc4 = L1*cos(q1) - Lc_4*cos(q2);
Yc4 = L1*sin(q1) - Lc_4*sin(q2);

% Jacobiano Velocidade Linear Centro de Massa do Link 1
JVc1 = [-Lc_1*sin(q1) 0; Lc_1*cos(q1) 0];

% Jacobiano Velocidade Linear Centro de Massa do Link 2
JVc2 = [0 -Lc_2*sin(q2); 0 Lc_2*cos(q2)];

% Jacobiano Velocidade Linear Centro de Massa do Link 3
JVc3 = [-Lc_3*sin(q1) -L2*sin(q2); Lc_3*cos(q1) L2*cos(q2)];

% Jacobiano Velocidade Linear Centro de Massa do Link 4
JVc4 = [-L1*sin(q1) Lc_4*sin(q2); L1*cos(q1) -Lc_4*cos(q2)];

% Jacobiano Velocidade Angular Centro de Massa Link 1
Jw1 = [0 0; 0 0; 1 0];

% Jacobiano Velocidade Angular Centro de Massa Link 2
Jw3 = Jw1;

% Jacobiano Velocidade Angular Centro de Massa Link 3
Jw2 = [0 0; 0 0; 0 1];

% Jacobiano Velocidade Angular Centro de Massa Link 4
Jw4 = Jw2;

% COMPONENTE 1 ENERGIA CINÉTICA TRASLACIONAL K_Vc1 = m1*J_Vc1'*J_Vc1
K_Vc1 = simplify(m1*(JVc1')*JVc1);

% COMPONENTE 1 ENERGIA CINÉTICA TRASLACIONAL K_Vc2 = m2*J_Vc2'*J_Vc2
K_Vc2 = simplify(m2*(JVc2')*JVc2);

% COMPONENTE 1 ENERGIA CINÉTICA TRASLACIONAL K_Vc3 = m3*J_Vc3'*J_Vc3
K_Vc3 = simplify(m3*(JVc3')*JVc3);

% COMPONENTE 1 ENERGIA CINÉTICA TRASLACIONAL K_Vc4 = m4*J_Vc4'*J_Vc4
K_Vc4 = simplify(m4*(JVc4')*JVc4);

% COMPONENTE 1 ENERGÍA CINETICA ROTACIONAL K_wc1=J_w1'*R01_b*I1*R01_b'*J_w1
  % Tensor de inercia link 1 
    I1 = [Ixx_1 Ixy_1 Ixz_1; Iyx_1 Iyy_1 Iyz_1; Izx_1 Izy_1 Izz_1];

    R10 = [cos(q1) -sin(q1) 0; sin(q1) cos(q1) 0; 0 0 1];
    
K_wc1 = simplify((Jw1')*R10*I1*(R10')*Jw1);

% COMPONENTE 2 ENERGÍA CINETICA ROTACIONAL K_wc2=J_w2'*R02*I2*R02'*J_w2
  % Tensor de inercia link 2 
    I2 = [Ixx_2 Ixy_2 Ixz_2; Iyx_2 Iyy_2 Iyz_2; Izx_2 Izy_2 Izz_2];

    R20 = [cos(q2) -sin(q2) 0; sin(q2) cos(q2) 0; 0 0 1];
    
K_wc2 = simplify((Jw2')*R20*I2*(R20')*Jw2);

% COMPONENTE 3 ENERGÍA CINETICA ROTACIONAL K_wc3=J_w3'*R03*I3*R03'*J_w3
  % Tensor de inercia link 2 
    I3 = [Ixx_3 Ixy_3 Ixz_3; Iyx_3 Iyy_3 Iyz_3; Izx_3 Izy_3 Izz_3];

    R30 = R10;
    
K_wc3 = simplify((Jw3')*R30*I3*(R30')*Jw3);

% COMPONENTE 4 ENERGÍA CINETICA ROTACIONAL K_wc4=J_w4'*R04*I4*R04'*J_w4
  % Tensor de inercia link 2 
    I4 = [Ixx_4 Ixy_4 Ixz_4; Iyx_4 Iyy_4 Iyz_4; Izx_4 Izy_4 Izz_4];

    R40 = R20;
    
K_wc4 = simplify((Jw4')*R40*I4*(R40')*Jw4);

% Matriz de Inercia D(q) do mecanismo 4 barras
D_q = simplify (K_Vc1 + K_Vc2 + K_Vc3 +  K_Vc4 + K_wc1 + K_wc2 + K_wc3 + K_wc4);

% ======== CALCULOS DOS COMPONENTES DA ENERGIA POTENCIAL P(q) ============

syms g
assume(g, 'real')

% COMPONENTE ENERGIA POTENCIAL LINK 1 
% rc1 é a posicao em Y do Centro de Massa do Link 1 
rc1 = Yc1;
P1 = m1*g*rc1;

% COMPONENTE ENERGIA POTENCIAL LINK 2 
% rc2 é a posicao em Y do Centro de Massa do Link 2 
rc2 = Yc2;
P2 = m2*g*rc2;

% COMPONENTE ENERGIA POTENCIAL LINK 3 
% rc3 é a posicao em Y do Centro de Massa do Link 3
rc3 = Yc3;
P3 = m3*g*rc3;

% COMPONENTE ENERGIA POTENCIAL LINK 4 
% rc4 é a posicao em Y do Centro de Massa do Link 4
rc4 = Yc4;
P4 = m4*g*rc4;

% ENERGIA POTENCIAL TOTAL DO MECANISMO P(q) 
P = simplify(P1 + P2 + P3 + P4);

% DERIVADA DA ENERGIA POTENCIAL P(q) EM RELACAO A q1
g1 = diff(P, q1);

% DERIVADA DA ENERGIA POTENCIAL P(q) EM RELACAO A q2
g2 = diff(P, q2);