function [Da,Ca,Ga] = coeficientes_apoio_4GL(HAT,COXA,PERNA,PE,vel,g)

%% ========= COEFICIENTES FASE DE APOIO ===================================

%%%%%% ANGULOS DAS JUNTAS DA PERNA DIREITA EM APOIO (2 test) %%%%%%%%%%%%
%%%%%%% ANGULOS MEDIDOS EM BALANCO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

theta_Q =  (vel(1).thetaq).*(pi/180);
theta_J = -(vel(1).thetaj).*(pi/180); % Considerar theta_j negativo
theta_T =  (vel(1).thetat).*(pi/180);

% ** -------------------------------------------------------------------
tht_1 =  theta_Q + theta_J + theta_T; % Angulo Dedao em Apoio
tht_2 = -theta_T; % Angulo do Tornozelo Direito
tht_3 = -theta_J; % Angulo do Joelho Direito **
tht_4 = -theta_Q; % Angulo do quadril
% ** --------------------------------------------------------------------

% LINK 1 = PE (tht_1 = tht_q - tht_j + tht_j =  Angulo Apoio Dedao)
Lp = PE.Comprimento;
Lp_cm = PE.Comprimento_CM;
m1 = PE.Massa;
I33_t = PE.Inercia(3,3); % I1_t

% LINK 2 = PERNA (tht_2 = -tht_t = Angulo tornozelo)
Lj = PERNA.Comprimento;
Lj_cm = PERNA.Comprimento_CM;
m2 = PERNA.Massa;
I33_j = PERNA.Inercia(3,3); % I2_j

% LINK 3 = COXA (tht_3 = tht_j = Angulo Joelho)
Lc = COXA.Comprimento;
Lc_cm = COXA.Comprimento_CM;
m3 = COXA.Massa;
I33_q = COXA.Inercia(3,3); % I3_q

% LINK 4 = HAT (tht_4 = -tht_q = Angulo Quadril)
a0 = HAT.CoM(2);
m4 = HAT.Massa;
I33_h = HAT.Inercia(3,3);


%% MATRIZ DE INERCIA DO ROBÔ D(q) = sum{mi*Jvci'*Jvci + Jwi'*Ri*Ii*Ri'*Jwi}
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

Ca.C144 = 0;

Ca.C214 = a0*m4*(Lj*sin(tht_3 + tht_4) + Lc*sin(tht_4));

Ca.C224 = a0*m4*(Lj*sin(tht_3 + tht_4) + Lc*sin(tht_4));

Ca.C234 = Lc*a0*m4*sin(tht_4);

Ca.C244 = 0;

Ca.C314 = Lc*a0*m4*sin(tht_4);

Ca.C324 = Lc*a0*m4*sin(tht_4);

Ca.C334 = Lc*a0*m4*sin(tht_4);

Ca.C344 = 0;

Ca.C414 = 0;

Ca.C424 = 0;

Ca.C434 = 0;

Ca.C444 = 0;

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

end