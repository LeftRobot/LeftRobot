
syms tht_Q tht_J tht_T

assume(tht_Q, 'real'); 
assume(tht_J, 'real')
assume(tht_T, 'real')

syms thtQ_p thtQ_2p thtJ_p thtJ_2p thtT_p thtT_2p
% Primeira e segunda derivada do angulo theta_1
assume(thtQ_p,  'real')
assume(thtQ_2p, 'real')
% Primeira e segunda derivada do angulo theta_2
assume(thtJ_p,  'real')
assume(thtJ_2p, 'real')
% Primeira e segunda derivada do angulo theta_3
assume(thtT_p,  'real')
assume(thtT_2p, 'real')


tauQ_b = subs(torQ_b, [tht_1, tht_2, tht_3], [tht_Q, tht_J, tht_T]);
tauQ_b = subs(tauQ_b, [tht1_p, tht1_2p], [thtQ_p, thtQ_2p]);
tauQ_b = subs(tauQ_b, [tht2_p, tht2_2p], [thtJ_p, thtJ_2p]);
tauQ_b = subs(tauQ_b, [tht3_p, tht3_2p], [thtT_p, thtT_2p]);

torqueQ_b = (Lc*Lj_cm*m2*sin(tht_J) - m3*(Lc*Lp_cm*cos(tht_J - tht_T) - Lc*Lj*sin(tht_J)))*thtJ_p^2 +...
2*Lp_cm*m3*(Lj*cos(tht_T) + Lc*cos(tht_J - tht_T))*thtJ_p*thtT_p -...
2*Lc*thtQ_p*(Lj*m3*sin(tht_J) + Lj_cm*m2*sin(tht_J) - Lp_cm*m3*cos(tht_J - tht_T))*thtJ_p -...
Lp_cm*m3*(Lj*cos(tht_T) + Lc*cos(tht_J - tht_T))*thtT_p^2 - 2*Lp_cm*m3*thtQ_p*(Lj*cos(tht_T) +...
Lc*cos(tht_J - tht_T))*thtT_p + thtQ_2p*(I33_j + I33_q + I33_t + Lc^2*m2 + Lc^2*m3 +...
Lc_cm^2*m1 + Lj^2*m3 + Lj_cm^2*m2 + Lp_cm^2*m3 + 2*Lc*Lj*m3*cos(tht_J) +...
2*Lc*Lj_cm*m2*cos(tht_J) - 2*Lj*Lp_cm*m3*sin(tht_T) + 2*Lc*Lp_cm*m3*sin(tht_J - tht_T)) +...
thtJ_2p*(I33_j + I33_t - m3*(Lj^2 - 2*sin(tht_T)*Lj*Lp_cm + Lc*cos(tht_J)*Lj + Lp_cm^2 +...
Lc*sin(tht_J - tht_T)*Lp_cm) - Lj_cm*m2*(Lj_cm + Lc*cos(tht_J))) + thtT_2p*(I33_t +...
Lp_cm*m3*(Lp_cm - Lj*sin(tht_T) + Lc*sin(tht_J - tht_T))) +...
g*m3*(Lp_cm*cos(tht_Q - tht_J + tht_T) + Lc*sin(tht_Q) - Lj*sin(tht_J - tht_Q)) +...
g*m2*(Lc*sin(tht_Q) - Lj_cm*sin(tht_J - tht_Q)) + Lc_cm*g*m1*sin(tht_Q);


angulos_apoio = [tht_Q - tht_J + tht_T, -tht_T, tht_J, -tht_Q];
derivadas_tht1 = [thtQ_p - thtJ_p + thtT_p, thtQ_2p - thtJ_2p + thtT_2p];
derivadas_tht2 = [-thtT_p, -thtT_2p];
derivadas_tht3 = [thtJ_p, thtJ_2p];
derivadas_tht4 = [-thtQ_p, thtQ_2p];

tauQ_a = subs(torQ_a, [tht_1, tht_2, tht_3, tht_4], angulos_apoio);
tauQ_a = subs(tauQ_a, [tht1_p, tht1_2p], derivadas_tht1);
tauQ_a = subs(tauQ_a, [tht2_p, tht2_2p], derivadas_tht2);
tauQ_a = subs(tauQ_a, [tht3_p, tht3_2p], derivadas_tht3);
tauQ_a = subs(tauQ_a, [tht4_p, tht4_2p], derivadas_tht4);

torqueQ_a = thtQ_2p*(m4*a0^2 + I33_h) + (I33_h + a0*m4*(a0 - Lp*sin(tht_Q - tht_J + tht_T) +...
Lc*cos(tht_Q) + Lj*cos(tht_J - tht_Q)))*(thtQ_2p - thtJ_2p + thtT_2p) - thtT_2p*(I33_h +...
a0*m4*(a0 + Lc*cos(tht_Q) + Lj*cos(tht_J - tht_Q))) + thtJ_2p*(I33_h +...
a0*m4*(a0 + Lc*cos(tht_Q))) - a0*m4*(thtQ_p - thtJ_p + thtT_p)^2*(Lp*cos(tht_Q - tht_J + tht_T) +...
Lc*sin(tht_Q) - Lj*sin(tht_J - tht_Q)) - a0*m4*thtT_p^2*(Lc*sin(tht_Q) - Lj*sin(tht_J - tht_Q)) -...
Lc*a0*m4*thtJ_p^2*sin(tht_Q) + 2*a0*m4*thtT_p*(Lc*sin(tht_Q) - Lj*sin(tht_J - tht_Q))*(thtQ_p - thtJ_p +...
thtT_p) + 2*Lc*a0*m4*thtJ_p*thtT_p*sin(tht_Q) - 2*Lc*a0*m4*thtJ_p*sin(tht_Q)*(thtQ_p - thtJ_p + thtT_p);



%% ========= COEFICIENTES FASE BALANCO ======================================   
% MATRIZ DE INERCIA DO ROBÔ D(q) = sum{mi*Jvci'*Jvci + Jwi'*Ri*Ii*Ri'*Jwi}
% i = 1,2,3
% ----------------------------------------------------------------------------
Db.d11 = I33_j + I33_q + I33_t + Lc^2*m2 + Lc^2*m3 + Lc_cm^2*m1 + Lj^2*m3 +...
    Lj_cm^2*m2 + Lp_cm^2*m3 + 2*Lc*Lj*m3*cos(tht_2) + 2*Lc*Lj_cm*m2*cos(tht_2) -...
    2*Lj*Lp_cm*m3*sin(tht_3) + 2*Lc*Lp_cm*m3*sin(tht_2 - tht_3);

Db.d12 = I33_j + I33_t - m3*(Lj^2 - 2*sin(tht_3)*Lj*Lp_cm + Lc*cos(tht_2)*Lj +...
    Lp_cm^2 + Lc*sin(tht_2 - tht_3)*Lp_cm) - Lj_cm*m2*(Lj_cm + Lc*cos(tht_2));

Db.d13 = I33_t + Lp_cm*m3*(Lp_cm - Lj*sin(tht_3) + Lc*sin(tht_2 - tht_3));

% -----------------------------------------------------------------------------
Db.d21 = I33_j + I33_t - m3*(Lj^2 - 2*sin(tht_3)*Lj*Lp_cm + Lc*cos(tht_2)*Lj +...
    Lp_cm^2 + Lc*sin(tht_2 - tht_3)*Lp_cm) - Lj_cm*m2*(Lj_cm + Lc*cos(tht_2));

Db.d22 = I33_j + I33_t + m3*(Lj^2 - 2*sin(tht_3)*Lj*Lp_cm + Lp_cm^2) + Lj_cm^2*m2;

Db.d23 = I33_t - Lp_cm*m3*(Lp_cm - Lj*sin(tht_3));
% ------------------------------------------------------------------------------

Db.d31 = I33_t + Lp_cm*m3*(Lp_cm - Lj*sin(tht_3) + Lc*sin(tht_2 - tht_3));

Db.d32 = I33_t - Lp_cm*m3*(Lp_cm - Lj*sin(tht_3));

Db.d33 = m3*Lp_cm^2 + I33_t;
%--------------------------------------------------------------------------------

%% ============ CALCULO DOS COEFICIENTES DE CHRISTOFFEL ===================

% ========== PARA A JUNTA 1 = QUADRIL, {k = 1}, {i,j = 1,2,3} =============
Cb.C111 = 0;

Cb.C121 = -Lc*(Lj*m3*sin(tht_2) + Lj_cm*m2*sin(tht_2) - Lp_cm*m3*cos(tht_2 - tht_3));

Cb.C131 = -Lp_cm*m3*(Lj*cos(tht_3) + Lc*cos(tht_2 - tht_3));

Cb.C211 = -Lc*(Lj*m3*sin(tht_2) + Lj_cm*m2*sin(tht_2) - Lp_cm*m3*cos(tht_2 - tht_3));

Cb.C221 = Lc*Lj_cm*m2*sin(tht_2) - m3*(Lc*Lp_cm*cos(tht_2 - tht_3) - Lc*Lj*sin(tht_2));

Cb.C231 = Lp_cm*m3*(Lj*cos(tht_3) + Lc*cos(tht_2 - tht_3));

Cb.C311 = -Lp_cm*m3*(Lj*cos(tht_3) + Lc*cos(tht_2 - tht_3));

Cb.C321 = Lp_cm*m3*(Lj*cos(tht_3) + Lc*cos(tht_2 - tht_3));

Cb.C331 = -Lp_cm*m3*(Lj*cos(tht_3) + Lc*cos(tht_2 - tht_3));

% ============ PARA A JUNTA 2 = JOELHO, (k = 2) {i,j = 1,2,3} =============
Cb.C112 = Lc*(Lj*m3*sin(tht_2) + Lj_cm*m2*sin(tht_2) - Lp_cm*m3*cos(tht_2 - tht_3));

Cb.C122 = 0;

Cb.C132 = Lj*Lp_cm*m3*cos(tht_3);

Cb.C212 = 0;

Cb.C222 = 0;

Cb.C232 = -Lj*Lp_cm*m3*cos(tht_3);

Cb.C312 =  Lj*Lp_cm*m3*cos(tht_3);

Cb.C322 = -Lj*Lp_cm*m3*cos(tht_3);

Cb.C332 =  Lj*Lp_cm*m3*cos(tht_3);

% ========= PARA A JUNTA 3 = TORNOZELO, (k = 3) {i,j = 1,2,3} =============
Cb.C113 = Lp_cm*m3*(Lj*cos(tht_3) + Lc*cos(tht_2 - tht_3));

Cb.C123 = -Lj*Lp_cm*m3*cos(tht_3);

Cb.C133 = 0;

Cb.C213 = -Lj*Lp_cm*m3*cos(tht_3);

Cb.C223 =  Lj*Lp_cm*m3*cos(tht_3);

Cb.C233 = 0;

Cb.C313 = 0;

Cb.C323 = 0;

Cb.C333 = 0;

%% ======== CALCULOS DOS COMPONENTES DA ENERGIA POTENCIAL P(q) ============

Gb.g1 = g*m3*(Lp_cm*cos(tht_1 - tht_2 + tht_3) + Lc*sin(tht_1) + Lj*sin(tht_1 - tht_2)) +...
    g*m2*(Lc*sin(tht_1) + Lj_cm*sin(tht_1 - tht_2)) + Lc_cm*g*m1*sin(tht_1);

Gb.g2 = - g*m3*(Lp_cm*cos(tht_1 - tht_2 + tht_3) + Lj*sin(tht_1 - tht_2)) -...
    Lj_cm*g*m2*sin(tht_1 - tht_2);

Gb.g3 = Lp_cm*g*m3*cos(tht_1 - tht_2 + tht_3);


%% ========= COEFICIENTES FASE DE APOIO ===================================

% MATRIZ DE INERCIA DO ROBÔ D(q) = sum{mi*Jvci'*Jvci + Jwi'*Ri*Ii*Ri'*Jwi}
% i = 1,2,3,4

Da.d11 = I33_h + I33_j + I33_q + I33_t + Lc^2*m4 + Lc_cm^2*m3 + Lj^2*m3 +...
    Lj^2*m4 + Lj_cm^2*m2 + Lp^2*m2 + Lp^2*m3 + Lp^2*m4 + Lp_cm^2*m1 + a0^2*m4 +...
    2*Lc*Lp*m4*sin(tht_2 + tht_3) + 2*Lc_cm*Lp*m3*sin(tht_2 + tht_3) +...
    2*Lj*a0*m4*cos(tht_3 + tht_4) + 2*Lc*Lj*m4*cos(tht_3) +...
    2*Lc_cm*Lj*m3*cos(tht_3) + 2*Lj*Lp*m3*sin(tht_2) + 2*Lj*Lp*m4*sin(tht_2) +...
    2*Lj_cm*Lp*m2*sin(tht_2) + 2*Lc*a0*m4*cos(tht_4) + 2*Lp*a0*m4*sin(tht_2 + tht_3 + tht_4);

Da.d12 = I33_h + I33_j + I33_q + Lc^2*m4 + Lc_cm^2*m3 + Lj^2*m3 + Lj^2*m4 + Lj_cm^2*m2 +...
    a0^2*m4 + Lc*Lp*m4*sin(tht_2 + tht_3) + Lc_cm*Lp*m3*sin(tht_2 + tht_3) +...
    2*Lj*a0*m4*cos(tht_3 + tht_4) + 2*Lc*Lj*m4*cos(tht_3) + 2*Lc_cm*Lj*m3*cos(tht_3) +...
    Lj*Lp*m3*sin(tht_2) + Lj*Lp*m4*sin(tht_2) + Lj_cm*Lp*m2*sin(tht_2) +...
    2*Lc*a0*m4*cos(tht_4) + Lp*a0*m4*sin(tht_2 + tht_3 + tht_4);

Da.d13 = I33_h + I33_q + Lc^2*m4 + Lc_cm^2*m3 + a0^2*m4 + Lc*Lp*m4*sin(tht_2 + tht_3) +...
    Lc_cm*Lp*m3*sin(tht_2 + tht_3) + Lj*a0*m4*cos(tht_3 + tht_4) + Lc*Lj*m4*cos(tht_3) +...
    Lc_cm*Lj*m3*cos(tht_3) + 2*Lc*a0*m4*cos(tht_4) + Lp*a0*m4*sin(tht_2 + tht_3 + tht_4);

Da.d14 = I33_h + a0*m4*(a0 + Lj*cos(tht_3 + tht_4) + Lc*cos(tht_4) +...
    Lp*sin(tht_2 + tht_3 + tht_4));

Da.d21 = I33_h + I33_j + I33_q + Lc^2*m4 + Lc_cm^2*m3 + Lj^2*m3 + Lj^2*m4 +...
    Lj_cm^2*m2 + a0^2*m4 + Lc*Lp*m4*sin(tht_2 + tht_3) + Lc_cm*Lp*m3*sin(tht_2 + tht_3) +...
    2*Lj*a0*m4*cos(tht_3 + tht_4) + 2*Lc*Lj*m4*cos(tht_3) + 2*Lc_cm*Lj*m3*cos(tht_3) +...
    Lj*Lp*m3*sin(tht_2) + Lj*Lp*m4*sin(tht_2) + Lj_cm*Lp*m2*sin(tht_2) +...
    2*Lc*a0*m4*cos(tht_4) + Lp*a0*m4*sin(tht_2 + tht_3 + tht_4);

Da.d22 = I33_h + I33_j + I33_q + Lc^2*m4 + Lc_cm^2*m3 + Lj^2*m3 + Lj^2*m4 + Lj_cm^2*m2 +...
    a0^2*m4 + 2*Lj*a0*m4*cos(tht_3 + tht_4) + 2*Lc*Lj*m4*cos(tht_3) +...
    2*Lc_cm*Lj*m3*cos(tht_3) + 2*Lc*a0*m4*cos(tht_4);

Da.d23 = I33_h + I33_q + m4*(Lc^2 + 2*cos(tht_4)*Lc*a0 + Lj*cos(tht_3)*Lc + a0^2 +...
    Lj*cos(tht_3 + tht_4)*a0) + Lc_cm*m3*(Lc_cm + Lj*cos(tht_3));

Da.d24 = I33_h + a0*m4*(a0 + Lj*cos(tht_3 + tht_4) + Lc*cos(tht_4));

Da.d31 = I33_h + I33_q + Lc^2*m4 + Lc_cm^2*m3 + a0^2*m4 + Lc*Lp*m4*sin(tht_2 + tht_3) +...
    Lc_cm*Lp*m3*sin(tht_2 + tht_3) + Lj*a0*m4*cos(tht_3 + tht_4) +...
    Lc*Lj*m4*cos(tht_3) + Lc_cm*Lj*m3*cos(tht_3) + 2*Lc*a0*m4*cos(tht_4) +...
    Lp*a0*m4*sin(tht_2 + tht_3 + tht_4);


Da.d32 = I33_h + I33_q + m4*(Lc^2 + 2*cos(tht_4)*Lc*a0 + Lj*cos(tht_3)*Lc + a0^2 +...
    Lj*cos(tht_3 + tht_4)*a0) + Lc_cm*m3*(Lc_cm + Lj*cos(tht_3));

Da.d33 = I33_h + I33_q + Lc_cm^2*m3 + m4*(Lc^2 + 2*cos(tht_4)*Lc*a0 + a0^2);

Da.d34 = I33_h + a0*m4*(a0 + Lc*cos(tht_4));

Da.d41 = I33_h + a0*m4*(a0 + Lj*cos(tht_3 + tht_4) + Lc*cos(tht_4) +...
    Lp*sin(tht_2 + tht_3 + tht_4));

Da.d42 = I33_h + a0*m4*(a0 + Lj*cos(tht_3 + tht_4) + Lc*cos(tht_4));

Da.d43 = I33_h + a0*m4*(a0 + Lc*cos(tht_4));

Da.d44 = m4*a0^2 + I33_h;

%% ============ CALCULO DOS COEFICIENTES DE CHRISTOFFEL ===================

% ========== PARA A JUNTA 1 = QUADRIL, {k = 1}, {i,j = 1,2,3,4}=======================
Ca.C111 = 0;

Ca.C121 = Lp*(a0*m4*cos(tht_2 + tht_3 + tht_4) + Lc*m4*cos(tht_2 + tht_3) +...
    Lc_cm*m3*cos(tht_2 + tht_3) + Lj*m3*cos(tht_2) + Lj*m4*cos(tht_2) + Lj_cm*m2*cos(tht_2));

Ca.C131 = Lc*Lp*m4*cos(tht_2 + tht_3) + Lc_cm*Lp*m3*cos(tht_2 + tht_3) -...
    Lj*a0*m4*sin(tht_3 + tht_4) - Lc*Lj*m4*sin(tht_3) - Lc_cm*Lj*m3*sin(tht_3) +...
    Lp*a0*m4*cos(tht_2 + tht_3 + tht_4);

Ca.C141 = -a0*m4*(Lj*sin(tht_3 + tht_4) + Lc*sin(tht_4) - Lp*cos(tht_2 + tht_3 + tht_4));

Ca.C211 = Lp*(a0*m4*cos(tht_2 + tht_3 + tht_4) + Lc*m4*cos(tht_2 + tht_3) +...
    Lc_cm*m3*cos(tht_2 + tht_3) + Lj*m3*cos(tht_2) + Lj*m4*cos(tht_2) + Lj_cm*m2*cos(tht_2));

Ca.C221 = Lp*(a0*m4*cos(tht_2 + tht_3 + tht_4) + Lc*m4*cos(tht_2 + tht_3) +...
    Lc_cm*m3*cos(tht_2 + tht_3) + Lj*m3*cos(tht_2) + Lj*m4*cos(tht_2) +...
    Lj_cm*m2*cos(tht_2));

Ca.C231 = Lc*Lp*m4*cos(tht_2 + tht_3) + Lc_cm*Lp*m3*cos(tht_2 + tht_3) -...
    Lj*a0*m4*sin(tht_3 + tht_4) - Lc*Lj*m4*sin(tht_3) - Lc_cm*Lj*m3*sin(tht_3) +...
    Lp*a0*m4*cos(tht_2 + tht_3 + tht_4);

Ca.C241 = -a0*m4*(Lj*sin(tht_3 + tht_4) + Lc*sin(tht_4) - Lp*cos(tht_2 + tht_3 + tht_4));

Ca.C311 = Lc*Lp*m4*cos(tht_2 + tht_3) + Lc_cm*Lp*m3*cos(tht_2 + tht_3) -...
    Lj*a0*m4*sin(tht_3 + tht_4) - Lc*Lj*m4*sin(tht_3) - Lc_cm*Lj*m3*sin(tht_3) +...
    Lp*a0*m4*cos(tht_2 + tht_3 + tht_4);

Ca.C321 = Lc*Lp*m4*cos(tht_2 + tht_3) + Lc_cm*Lp*m3*cos(tht_2 + tht_3) -...
    Lj*a0*m4*sin(tht_3 + tht_4) - Lc*Lj*m4*sin(tht_3) - Lc_cm*Lj*m3*sin(tht_3) +...
    Lp*a0*m4*cos(tht_2 + tht_3 + tht_4);

Ca.C331 = Lc*Lp*m4*cos(tht_2 + tht_3) + Lc_cm*Lp*m3*cos(tht_2 + tht_3) -...
    Lj*a0*m4*sin(tht_3 + tht_4) - Lc*Lj*m4*sin(tht_3) - Lc_cm*Lj*m3*sin(tht_3) +...
    Lp*a0*m4*cos(tht_2 + tht_3 + tht_4);

Ca.C341 = -a0*m4*(Lj*sin(tht_3 + tht_4) + Lc*sin(tht_4) - Lp*cos(tht_2 + tht_3 + tht_4));

Ca.C411 = -a0*m4*(Lj*sin(tht_3 + tht_4) + Lc*sin(tht_4) - Lp*cos(tht_2 + tht_3 + tht_4));

Ca.C421 = -a0*m4*(Lj*sin(tht_3 + tht_4) + Lc*sin(tht_4) - Lp*cos(tht_2 + tht_3 + tht_4));

Ca.C431 = -a0*m4*(Lj*sin(tht_3 + tht_4) + Lc*sin(tht_4) - Lp*cos(tht_2 + tht_3 + tht_4));

Ca.C441 = -a0*m4*(Lj*sin(tht_3 + tht_4) + Lc*sin(tht_4) - Lp*cos(tht_2 + tht_3 + tht_4));

% ============ PARA A JUNTA 2 = JOELHO, (k = 2) {i,j = 1,2,3,4} =======================
Ca.C112 = -Lp*(a0*m4*cos(tht_2 + tht_3 + tht_4) + Lc*m4*cos(tht_2 + tht_3) +...
    Lc_cm*m3*cos(tht_2 + tht_3) + Lj*m3*cos(tht_2) +...
    Lj*m4*cos(tht_2) + Lj_cm*m2*cos(tht_2));

Ca.C122 = 0;

Ca.C132 = -Lj*(Lc*m4*sin(tht_3) + Lc_cm*m3*sin(tht_3) + a0*m4*sin(tht_3 + tht_4));

Ca.C142 = -a0*m4*(Lj*sin(tht_3 + tht_4) + Lc*sin(tht_4));

Ca.C212 = 0;

Ca.C222 = 0;

Ca.C232 = -Lj*(Lc*m4*sin(tht_3) + Lc_cm*m3*sin(tht_3) + a0*m4*sin(tht_3 + tht_4));

Ca.C242 = -a0*m4*(Lj*sin(tht_3 + tht_4) + Lc*sin(tht_4));

Ca.C312 = -Lj*(Lc*m4*sin(tht_3) + Lc_cm*m3*sin(tht_3) + a0*m4*sin(tht_3 + tht_4));

Ca.C322 = -Lj*(Lc*m4*sin(tht_3) + Lc_cm*m3*sin(tht_3) + a0*m4*sin(tht_3 + tht_4));

Ca.C332 = - m4*(Lj*a0*sin(tht_3 + tht_4) + Lc*Lj*sin(tht_3)) - Lc_cm*Lj*m3*sin(tht_3);

Ca.C342 = -a0*m4*(Lj*sin(tht_3 + tht_4) + Lc*sin(tht_4));

Ca.C412 = -a0*m4*(Lj*sin(tht_3 + tht_4) + Lc*sin(tht_4));

Ca.C422 = -a0*m4*(Lj*sin(tht_3 + tht_4) + Lc*sin(tht_4));

Ca.C432 = -a0*m4*(Lj*sin(tht_3 + tht_4) + Lc*sin(tht_4));

Ca.C442 = -a0*m4*(Lj*sin(tht_3 + tht_4) + Lc*sin(tht_4));

% ========= PARA A JUNTA 3 = TORNOZELO, (k = 3) {i,j = 1,2,3,4} ========================
Ca.C113 = Lj*a0*m4*sin(tht_3 + tht_4) - Lc_cm*Lp*m3*cos(tht_2 + tht_3) -...
    Lc*Lp*m4*cos(tht_2 + tht_3) + Lc*Lj*m4*sin(tht_3) + Lc_cm*Lj*m3*sin(tht_3) -...
    Lp*a0*m4*cos(tht_2 + tht_3 + tht_4);

Ca.C123 = Lj*(Lc*m4*sin(tht_3) + Lc_cm*m3*sin(tht_3) + a0*m4*sin(tht_3 + tht_4));

Ca.C133 = 0;

Ca.C143 = -Lc*a0*m4*sin(tht_4);

Ca.C213 = Lj*(Lc*m4*sin(tht_3) + Lc_cm*m3*sin(tht_3) + a0*m4*sin(tht_3 + tht_4));

Ca.C223 = Lj*(Lc*m4*sin(tht_3) + Lc_cm*m3*sin(tht_3) + a0*m4*sin(tht_3 + tht_4));

Ca.C233 = 0;

Ca.C243 = -Lc*a0*m4*sin(tht_4);

Ca.C313 = 0;

Ca.C323 = 0;

Ca.C333 = 0;

Ca.C343 = -Lc*a0*m4*sin(tht_4);

Ca.C413 = -Lc*a0*m4*sin(tht_4);

Ca.C423 = -Lc*a0*m4*sin(tht_4);

Ca.C433 = -Lc*a0*m4*sin(tht_4);

Ca.C443 = -Lc*a0*m4*sin(tht_4);

% ========= PARA A JUNTA 4 = TORNOZELO, (k = 4) {i,j = 1,2,3,4} ========================
Ca.C114 = a0*m4*(Lj*sin(tht_3 + tht_4) + Lc*sin(tht_4) - Lp*cos(tht_2 + tht_3 + tht_4));

Ca.C124 = a0*m4*(Lj*sin(tht_3 + tht_4) + Lc*sin(tht_4));

Ca.C134 = Lc*a0*m4*sin(tht_4);

C144_a = 0;

C214_a = a0*m4*(Lj*sin(tht_3 + tht_4) + Lc*sin(tht_4));

C224_a = a0*m4*(Lj*sin(tht_3 + tht_4) + Lc*sin(tht_4));

C234_a = Lc*a0*m4*sin(tht_4);

C244_a = 0;

C314_a = Lc*a0*m4*sin(tht_4);

C324_a = Lc*a0*m4*sin(tht_4);

C334_a = Lc*a0*m4*sin(tht_4);

C344_a = 0;

C414_a = 0;

C424_a = 0;

C434_a = 0;

C444_a = 0;

%% ======== CALCULOS DOS COMPONENTES DA ENERGIA POTENCIAL P(q) ============

% DERIVADA DA ENERGIA POTENCIAL P(q) EM RELACAO A theta_1
Ga.g1 = - g*m3*(Lj*sin(tht_1 + tht_2) + Lp*cos(tht_1) +...
    Lc_cm*sin(tht_1 + tht_2 + tht_3)) - g*m2*(Lj_cm*sin(tht_1 + tht_2) +...
    Lp*cos(tht_1)) - g*m4*(a0*sin(tht_1 + tht_2 + tht_3 + tht_4) +...
    Lj*sin(tht_1 + tht_2) + Lp*cos(tht_1) + Lc*sin(tht_1 + tht_2 + tht_3)) -...
    Lp_cm*g*m1*cos(tht_1);

% DERIVADA DA ENERGIA POTENCIAL P(q) EM RELACAO A theta_2
Ga.g2 = - g*m4*(a0*sin(tht_1 + tht_2 + tht_3 + tht_4) + Lj*sin(tht_1 + tht_2) +...
    Lc*sin(tht_1 + tht_2 + tht_3)) - g*m3*(Lj*sin(tht_1 + tht_2) +...
    Lc_cm*sin(tht_1 + tht_2 + tht_3)) - Lj_cm*g*m2*sin(tht_1 + tht_2);

% DERIVADA DA ENERGIA POTENCIAL P(q) EM RELACAO A theta_3
Ga.g3 = - g*m4*(a0*sin(tht_1 + tht_2 + tht_3 + tht_4) +...
    Lc*sin(tht_1 + tht_2 + tht_3)) - Lc_cm*g*m3*sin(tht_1 + tht_2 + tht_3);

% DERIVADA DA ENERGIA POTENCIAL P(q) EM RELACAO A theta_4
Ga.g4 = -a0*g*m4*sin(tht_1 + tht_2 + tht_3 + tht_4);

