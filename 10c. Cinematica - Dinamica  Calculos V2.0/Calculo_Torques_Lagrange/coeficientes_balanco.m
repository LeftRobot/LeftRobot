function [Db,Cb,Gb] = coeficientes_balanco(COXA,PERNA,PE,vel,g)

%% ========= COEFICIENTES FASE BALANCO ======================================   

% LINK 1 = COXA (Junta Quadril)
Lc = COXA.Comprimento;
Lc_cm = COXA.Comprimento_CM;
m1 = COXA.Massa;
I33_q = COXA.Inercia(3,3);

% LINK 2 = PERNA (Junta Joelho)
Lj = PERNA.Comprimento;
Lj_cm = PERNA.Comprimento_CM;
m2 = PERNA.Massa;
I33_j = PERNA.Inercia(3,3);

% LINK 3 = PE (Junta Tornozelo)
Lp = PE.Comprimento;
Lp_cm = PE.Comprimento_CM;
m3 = PE.Massa;
I33_t = PE.Inercia(3,3);

% ANGULOS DAS JUNTAS DA PERNA DIREITA EM BALANCO (** Em Radianos)
tht_1 = (vel(1).thetaq)*(pi/180); % Angulo do Quadril Direito
tht_2 = (vel(1).thetaj)*(pi/180); % Angulo do Joelho Direito
tht_3 = (vel(1).thetat)*(pi/180); % Angulo do tornozelo Direito

%% MATRIZ DE INERCIA DO ROBÔ D(q) = sum{mi*Jvci'*Jvci + Jwi'*Ri*Ii*Ri'*Jwi}
% i = 1,2,3 para as 3 juntas do mecanismo na fase de balanco
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


end