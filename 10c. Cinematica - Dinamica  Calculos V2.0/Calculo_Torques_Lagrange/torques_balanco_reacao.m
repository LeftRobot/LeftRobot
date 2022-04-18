function [torque_Qbr, torque_Jbr, torque_Tbr] = torques_balanco_reacao(Db,Cb,Gb,deriv_Q,deriv_J, deriv_T,J_B,Fr)

tht_1   = deriv_Q.thetaq;
tht1_p  = deriv_Q.thetaq_P;
tht1_2p = deriv_Q.thetaq_PP;

tht_2   = deriv_J.thetaj;
tht2_p  = deriv_J.thetaj_P;
tht2_2p = deriv_J.thetaj_PP;

tht_3   = deriv_T.thetat;
tht3_p  = deriv_T.thetat_P;
tht3_2p = deriv_T.thetat_PP;

%% TORQUE DA JUNTA K = 1 QUADRIL
tau_1 = Db.d11.*(tht1_2p) + Db.d12.*(tht2_2p) + Db.d13.*(tht3_2p) +...
    Cb.C111.*(tht1_p.^2) + (Cb.C121+Cb.C211).*(tht1_p.*tht2_p) +...
    (Cb.C131+Cb.C311).*(tht1_p.*tht3_p) + Cb.C221.*(tht2_p.^2) +...
    (Cb.C231+Cb.C321).*(tht2_p.*tht3_p) + Cb.C331.*(tht3_p.^2) + Gb.g1;

%% TORQUE DA JUNTA K = 2 JOELHO
tau_2 = Db.d21.*(tht1_2p) + Db.d22.*(tht2_2p) + Db.d23.*(tht3_2p) +...
    Cb.C112.*(tht1_p.^2) + (Cb.C122+Cb.C212).*(tht1_p.*tht2_p) +...
    (Cb.C132+Cb.C312).*(tht1_p.*tht3_p) + Cb.C222.*(tht2_p.^2) +...
    (Cb.C232+Cb.C322).*(tht2_p.*tht3_p) + Cb.C332.*(tht3_p.^2) + Gb.g2;

%% TORQUE DA JUNTA K = 3 TORNOZELO
tau_3 = Db.d31.*(tht1_2p) + Db.d32.*(tht2_2p) + Db.d33.*(tht3_2p) +...
    Cb.C113.*(tht1_p.^2) + (Cb.C123+Cb.C213).*(tht1_p.*tht2_p) +...
    (Cb.C133+Cb.C313).*(tht1_p.*tht3_p) + Cb.C223.*(tht2_p.^2) +...
    (Cb.C233+Cb.C323).*(tht2_p.*tht3_p) + Cb.C333.*(tht3_p.^2) + Gb.g3;

% % Matrizes jacobianas da velocidade Linear do End-Effector Jvi

n = size(J_B,1) - 3; % tamanho de linhas do vetor Jvi
Jv1 = J_B(1:n,1);
Jv2 = J_B(1:n,2);
Jv3 = J_B(1:n,3);

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
fi = zeros(3,1);
T1 = zeros(m,1);
T2 = zeros(m,1);
T3 = zeros(m,1);

for i = 1:m
    
    Jv1_i = [Jv1(i); Jv1(i+100); Jv1(i+200)];
    Jv2_i = [Jv2(i); Jv2(i+100); Jv2(i+200)];
    Jv3_i = [Jv3(i); Jv3(i+100); Jv3(i+200)];
    
    f_i = [frx(i); fry(i); frz(i)];
    
    T1(i,1) = (Jv1_i)'*f_i;
    T2(i,1) = (Jv2_i)'*f_i;
    T3(i,1) = (Jv3_i)'*f_i;

end


% % TORQUE DA JUNTA DO QUADRIL CONSIDERANDO A FORCA DE REACAO Fr
torque_Qbr = 3*(T1 - tau_1);        %torque_Qbr = T1 - tau_1;
% torque_Qbr = 2.5*(T1 - tau_1);        %torque_Qbr = T1 - tau_1;

% % TORQUE DA JUNTA DO JOELHO CONSIDERANDO A FORCA DE REACAO Fr
% torque_Jbr = T2 - tau_2;        %torque_Jbr = T2 - tau_2;
 torque_Jbr = 2.5*(T2 - tau_2);        %torque_Jbr = T2 - tau_2;
 
% % TORQUE DA JUNTA DO TORNOZELO CONSIDERANDO A FORCA DE REACAO Fr
torque_Tbr = T3 - tau_3;        %torque_Tbr = T3 - tau_3;
end