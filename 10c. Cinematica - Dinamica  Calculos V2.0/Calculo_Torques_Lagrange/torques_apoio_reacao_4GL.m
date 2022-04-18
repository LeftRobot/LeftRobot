function [torque_Qar,torque_Jar,torque_Tar,torque_Dar] = torques_apoio_reacao_4GL(Da,Ca,Ga,deriv_Q,deriv_J,deriv_T,J,Fr)

% Primeira e segunda derivada do angulo do Joelho Theta_j, Thetaj_P,
% Thetaj_PP
Theta_j = -deriv_J.thetaj;
tempo_j =  deriv_J.tempo;
[Thetaj_P, Thetaj_PP] = derivada(Theta_j, tempo_j);

% ** ---------------------------------------------------------------------
tht1_p  = deriv_Q.thetaq_P  + Thetaj_P  + deriv_T.thetat_P;
tht1_2p = deriv_Q.thetaq_PP + Thetaj_PP + deriv_T.thetat_PP;

tht2_p  = -deriv_T.thetat_P;
tht2_2p = -deriv_T.thetat_PP;

tht3_p  = -Thetaj_P; % **
tht3_2p = -Thetaj_PP; %**

tht4_p  = -deriv_Q.thetaq_P;
tht4_2p = -deriv_Q.thetaq_PP;

% ** ---------------------------------------------------------------------
% tht_1   = deriv_Q.thetaq - deriv_J.thetaj + deriv_T.thetat;
% tht1_p  = deriv_Q.thetaq_P - deriv_J.thetaj_P + deriv_T.thetat_P;
% tht1_2p = deriv_Q.thetaq_PP - deriv_J.thetaj_PP + deriv_T.thetat_PP;
% 
% tht_2   = deriv_Q.thetaq - deriv_J.thetaj;
% tht2_p  = deriv_Q.thetaq_P - deriv_J.thetaj_P;
% tht2_2p = deriv_Q.thetaq_PP - deriv_J.thetaj_PP;
% 
% tht_3   = deriv_J.thetaj;
% tht3_p  = deriv_J.thetaj_P; % **
% tht3_2p = deriv_J.thetaj_PP; %**
% 
% tht_4   = -deriv_Q.thetaq;
% tht4_p  = -deriv_Q.thetaq_P;
% tht4_2p = -deriv_Q.thetaq_PP;

%% TORQUE DA JUNTA K = 1 DEDAO EM APOIO
tau_1 = Da.d11.*(tht1_2p) + Da.d12.*(tht2_2p) + Da.d13.*(tht3_2p) +...
    Da.d14.*(tht4_2p) + Ca.C111.*(tht1_p.^2) +...
    (Ca.C121+Ca.C211).*(tht1_p.*tht2_p) + (Ca.C131+Ca.C311).*(tht1_p.*tht3_p) +...
    (Ca.C141+Ca.C411).*(tht1_p.*tht4_p) + Ca.C221.*(tht2_p.^2) +...
    (Ca.C231+Ca.C321).*(tht2_p.*tht3_p) + (Ca.C241+Ca.C421).*(tht2_p.*tht4_p) +...
    Ca.C331.*(tht3_p.^2) + (Ca.C341+Ca.C431).*(tht3_p.*tht4_p) +...
    Ca.C441.*(tht4_p.^2) + Ga.g1;

%% TORQUE DA JUNTA K = 2 TORNOZELO
tau_2 = Da.d21.*(tht1_2p) + Da.d22.*(tht2_2p) + Da.d23.*(tht3_2p) +...
    Da.d24.*(tht4_2p) + Ca.C112.*(tht1_p.^2) +...
    (Ca.C122+Ca.C212).*(tht1_p.*tht2_p) + (Ca.C132+Ca.C312).*(tht1_p.*tht3_p) +...
    (Ca.C142+Ca.C412).*(tht1_p.*tht4_p) +Ca.C222.*(tht2_p.^2) +...
    (Ca.C232+Ca.C322).*(tht2_p.*tht3_p) + (Ca.C242+Ca.C422).*(tht2_p.*tht4_p) +...
    Ca.C332.*(tht3_p.^2) + (Ca.C342+Ca.C432).*(tht3_p.*tht4_p) +...
    Ca.C442.*(tht4_p.^2) + Ga.g2; 

%% TORQUE DA JUNTA K = 3 JOELHO
tau_3 = Da.d31.*(tht1_2p) + Da.d32.*(tht2_2p) + Da.d33.*(tht3_2p) +...
    Da.d34.*(tht4_2p) + Ca.C113.*(tht1_p.^2) +...
    (Ca.C123+Ca.C213).*(tht1_p.*tht2_p) + (Ca.C133+Ca.C313).*(tht1_p.*tht3_p) +...
    (Ca.C143+Ca.C413).*(tht1_p.*tht4_p) + Ca.C223.*(tht2_p.^2) +...
    (Ca.C233+Ca.C323).*(tht2_p.*tht3_p) + (Ca.C243+Ca.C423).*(tht2_p.*tht4_p) +...
    Ca.C333.*(tht3_p.^2) + (Ca.C343+Ca.C433).*(tht3_p.*tht4_p) +...
    Ca.C443.*(tht4_p.^2) + Ga.g3;

%% TORQUE DA JUNTA K = 4 QUADRIL
tau_4 = Da.d41.*(tht1_2p) + Da.d42.*(tht2_2p) + Da.d43.*(tht3_2p) +...
    Da.d44.*(tht4_2p) + Ca.C114.*(tht1_p.^2) +...
    (Ca.C124+Ca.C214).*(tht1_p.*tht2_p) + (Ca.C134+Ca.C314).*(tht1_p.*tht3_p) +...
    (Ca.C144+Ca.C414).*(tht1_p.*tht4_p) + Ca.C224.*(tht2_p.^2) +...
    (Ca.C234+Ca.C324).*(tht2_p.*tht3_p) + (Ca.C244+Ca.C424).*(tht2_p.*tht4_p) +...
    Ca.C334.*(tht3_p.^2) + (Ca.C344+Ca.C434).*(tht3_p.*tht4_p) +...
    Ca.C444.*(tht4_p.^2) + Ga.g4;

n = size(J,1) - 3;

% Matriz Jacobiana J para calcular os torques induzidos pela forca Fr
Jv1 = J(1:n,1);
Jw1 = J(n+1:end,1);

Jv2 = J(1:n,2);
Jw2 = J(n+1:end,2);

Jv3 = J(1:n,3);
Jw3 = J(n+1:end,3);

Jv4 = J(1:n,4);
Jw4 = J(n+1:end,4);

% Componente em X - Tangencial da Forca de Reacao 
m = n/3;

frx = Fr(1:m,1);

% Componente em Y - Vertical da Forca de Reacao 
fry = Fr(m+1:2*m,1);

% Componente em Z - Tangencial da Forca de Reacao 
frz = Fr(2*m+1:3*m,1);

Jv1_i = zeros(3,1);
Jv2_i = zeros(3,1);
Jv3_i = zeros(3,1);
Jv4_i = zeros(3,1);

fi = zeros(3,1);

T1 = zeros(m,1);
T2 = zeros(m,1);
T3 = zeros(m,1);
T4 = zeros(m,1);

for i = 1:m
    
    Jv1_i = [Jv1(i); Jv1(i+100); Jv1(i+200)];
    Jv2_i = [Jv2(i); Jv2(i+100); Jv2(i+200)];
    Jv3_i = [Jv3(i); Jv3(i+100); Jv3(i+200)];
    Jv4_i = [Jv4(i); Jv4(i+100); Jv4(i+200)];
    
    f_i = [frx(i); fry(i); frz(i)];
    
    T1(i,1) = (Jv1_i)'*f_i;
    T2(i,1) = (Jv2_i)'*f_i;
    T3(i,1) = (Jv3_i)'*f_i;
    T4(i,1) = (Jv4_i)'*f_i;

end


% % TORQUE NO DEDAO EM APOIO
torque_Dar = tau_1;

% % TORQUE DA JUNTA DO TORNOZELO NA FASE DE APOIO
torque_Tar = (T2 + tau_1) - tau_2  ;

% % TORQUE DA JUNTA DO JOELHO NA FASE DE APOIO
torque_Jar = (T3 + tau_1) - tau_3;

% % TORQUE DA JUNTA DO QUADRIL NA FASE DE APOIO
torque_Qar = (T4 + tau_1) - tau_4;

end