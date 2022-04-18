function [Dap,Cap,Gap] = coeficientes_apoio_3GL(HAT,COXA,PERNA,PE,vel,g)

% % ** --------------------------------------------------------------------
%%%%%% ANGULOS DAS JUNTAS DA PERNA DIREITA EM APOIO (2 test) %%%%%%%%%%%%
%%%%%%% ANGULOS MEDIDOS EM BALANCO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
theta_Q =  (vel(1).thetaq).*(pi/180);
theta_J = -(vel(1).thetaj).*(pi/180);
theta_T =  (vel(1).thetat).*(pi/180);

% ** -------------------------------------------------------------------
tht_1 =  theta_Q + theta_J; % Angulo do Tornozelo Direito
tht_2 = -theta_J; % Angulo do Joelho Direito **
tht_3 = -theta_Q; % Angulo do quadril
% ** --------------------------------------------------------------------
% % ANGULOS DAS JUNTAS DA PERNA DIREITA EM APOIO (** Em Radianos)
% theta_Q = (vel(1).thetaq).*(pi/180);
% theta_J = (vel(1).thetaj).*(pi/180);
% theta_T = (vel(1).thetat).*(pi/180);
% 
% % ** -------------------------------------------------------------------
% tht_1 =  theta_Q - theta_J; % Angulo do Tornozelo Direito
% tht_2 =  theta_J; % Angulo do Joelho Direito **
% tht_3 = -theta_Q; % Angulo do quadril

%% ========= COEFICIENTES FASE DE APOIO ===================================

% LINK 1 = PERNA (tht_1 = tht_q - tht_j = Angulo tornozelo)
Lj = PERNA.Comprimento;
Lj_cm = PERNA.Comprimento_CM;
m1 = PERNA.Massa;
I33_j = PERNA.Inercia(3,3); % I2_j

% LINK 2 = COXA (tht_2 = tht_j = Angulo Joelho)
Lc = COXA.Comprimento;
Lc_cm = COXA.Comprimento_CM;
m2 = COXA.Massa;
I33_q = COXA.Inercia(3,3); % I3_q

% LINK 3 = HAT (tht_3 = -tht_q = Angulo Quadril)
% a0 = HAT.CoM(2);
% m3 = HAT.Massa;
% I33_h = HAT.Inercia(3,3);

a0 = HAT.CoM(2);
m3 = HAT.Massa;
I33_h = HAT.Inercia(3,3);

%% MATRIZ DE INERCIA DO ROBÔ D(q) = sum{mi*Jvci'*Jvci + Jwi'*Ri*Ii*Ri'*Jwi}
% i = 1,2,3,4

Dap.d11 = I33_h + I33_j + I33_q + Lc^2*m3 + Lc_cm^2*m2 + Lj^2*m2 + Lj^2*m3 +...
    Lj_cm^2*m1 + a0^2*m3 + 2*Lj*a0*m3*cos(tht_2 + tht_3) +...
    2*Lc*Lj*m3*cos(tht_2) + 2*Lc_cm*Lj*m2*cos(tht_2) + 2*Lc*a0*m3*cos(tht_3);

Dap.d12 = I33_h + I33_q + m3*(Lc^2 + 2*cos(tht_3)*Lc*a0 + Lj*cos(tht_2)*Lc +...
    a0^2 + Lj*cos(tht_2 + tht_3)*a0) + Lc_cm*m2*(Lc_cm + Lj*cos(tht_2));

Dap.d13 = I33_h + a0*m3*(a0 + Lj*cos(tht_2 + tht_3) + Lc*cos(tht_3));


Dap.d21 = I33_h + I33_q + m3*(Lc^2 + 2*cos(tht_3)*Lc*a0 + Lj*cos(tht_2)*Lc +...
    a0^2 + Lj*cos(tht_2 + tht_3)*a0) + Lc_cm*m2*(Lc_cm + Lj*cos(tht_2));

Dap.d22 = I33_h + I33_q + Lc_cm^2*m2 + m3*(Lc^2 + 2*cos(tht_3)*Lc*a0 + a0^2);

Dap.d23 = I33_h + a0*m3*(a0 + Lc*cos(tht_3));


Dap.d31 = I33_h + a0*m3*(a0 + Lj*cos(tht_2 + tht_3) + Lc*cos(tht_3));

Dap.d32 = I33_h + a0*m3*(a0 + Lc*cos(tht_3));

Dap.d33 = m3*a0^2 + I33_h;

%% ============ CALCULO DOS COEFICIENTES DE CHRISTOFFEL ===================

% ========== PARA A JUNTA 1 = TORNOZELO, {k = 1}, {i,j = 1,2,3,4}==========
Cap.C111 = 0;

Cap.C121 = -Lj*(Lc*m3*sin(tht_2) + Lc_cm*m2*sin(tht_2) + a0*m3*sin(tht_2 + tht_3));

Cap.C131 = -a0*m3*(Lj*sin(tht_2 + tht_3) + Lc*sin(tht_3));

Cap.C211 = -Lj*(Lc*m3*sin(tht_2) + Lc_cm*m2*sin(tht_2) + a0*m3*sin(tht_2 + tht_3));

Cap.C221 = - m3*(Lj*a0*sin(tht_2 + tht_3) + Lc*Lj*sin(tht_2)) - Lc_cm*Lj*m2*sin(tht_2);

Cap.C231 = -a0*m3*(Lj*sin(tht_2 + tht_3) + Lc*sin(tht_3));

Cap.C311 = -a0*m3*(Lj*sin(tht_2 + tht_3) + Lc*sin(tht_3));

Cap.C321 = -a0*m3*(Lj*sin(tht_2 + tht_3) + Lc*sin(tht_3));

Cap.C331 = -a0*m3*(Lj*sin(tht_2 + tht_3) + Lc*sin(tht_3));

% ============ PARA A JUNTA 2 = JOELHO, (k = 2) {i,j = 1,2,3,4} =======================
Cap.C112 = Lj*(Lc*m3*sin(tht_2) + Lc_cm*m2*sin(tht_2) + a0*m3*sin(tht_2 + tht_3));

Cap.C122 = 0;

Cap.C132 = -Lc*a0*m3*sin(tht_3);

Cap.C212 = 0;

Cap.C222 = 0;

Cap.C232 = -Lc*a0*m3*sin(tht_3);

Cap.C312 = -Lc*a0*m3*sin(tht_3);

Cap.C322 = -Lc*a0*m3*sin(tht_3);

Cap.C332 = -Lc*a0*m3*sin(tht_3);

% ========= PARA A JUNTA 3 = TORNOZELO, (k = 3) {i,j = 1,2,3,4} ========================
Cap.C113 = a0*m3*(Lj*sin(tht_2 + tht_3) + Lc*sin(tht_3));

Cap.C123 = Lc*a0*m3*sin(tht_3);

Cap.C133 = 0;

Cap.C213 = Lc*a0*m3*sin(tht_3);

Cap.C223 = Lc*a0*m3*sin(tht_3);

Cap.C233 = 0;

Cap.C313 = 0;

Cap.C323 = 0;

Cap.C333 = 0;


%% ======== CALCULOS DOS COMPONENTES DA ENERGIA POTENCIAL P(q) ============

% DERIVADA DA ENERGIA POTENCIAL P(q) EM RELACAO A theta_1
Gap.g1 = - g*m3*(Lc*sin(tht_1 + tht_2) + Lj*sin(tht_1) + a0*sin(tht_1 + tht_2 + tht_3)) -...
    g*m2*(Lc_cm*sin(tht_1 + tht_2) + Lj*sin(tht_1)) - Lj_cm*g*m1*sin(tht_1);

% DERIVADA DA ENERGIA POTENCIAL P(q) EM RELACAO A theta_2
Gap.g2 = - g*m3*(Lc*sin(tht_1 + tht_2) + a0*sin(tht_1 + tht_2 + tht_3)) -...
    Lc_cm*g*m2*sin(tht_1 + tht_2);

% DERIVADA DA ENERGIA POTENCIAL P(q) EM RELACAO A theta_3
Gap.g3 = -a0*g*m3*sin(tht_1 + tht_2 + tht_3);

end