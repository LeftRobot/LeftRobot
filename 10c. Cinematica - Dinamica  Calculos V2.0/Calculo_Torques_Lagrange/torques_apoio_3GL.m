function [torque_Qap, torque_Jap, torque_Tap] = torques_apoio_3GL(Dap,Cap,Gap,deriv_Q,deriv_J, deriv_T)

% tht_1   = deriv_Q.thetaq - deriv_J.thetaj;
% tht1_p  = deriv_Q.thetaq_P - deriv_J.thetaj_P;
% tht1_2p = deriv_Q.thetaq_PP - deriv_J.thetaj_PP;
% 
% tht_2   = deriv_J.thetaj;
% tht2_p  = deriv_J.thetaj_P; % **
% tht2_2p = deriv_J.thetaj_PP; %**
% 
% tht_3   = -deriv_Q.thetaq;
% tht3_p  = -deriv_Q.thetaq_P;
% tht3_2p = -deriv_Q.thetaq_PP;

% %%%%%%%%%%%%%%%%%%%% 2 test %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Primeira e segunda derivada do angulo do Joelho
Theta_j = -deriv_J.thetaj;
tempo_j =  deriv_J.tempo;
[Thetaj_P, Thetaj_PP] = derivada(Theta_j, tempo_j);

tht1_p  = deriv_Q.thetaq_P  + Thetaj_P;
tht1_2p = deriv_Q.thetaq_PP + Thetaj_PP;

tht2_p  = -Thetaj_P; % **
tht2_2p = -Thetaj_PP; %**

tht3_p  = -deriv_Q.thetaq_P;
tht3_2p = -deriv_Q.thetaq_PP;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TORQUE DA JUNTA K = 1 TORNOZELO
tau_1 = Dap.d11.*(tht1_2p) + Dap.d12.*(tht2_2p) + Dap.d13.*(tht3_2p) +...
    Cap.C111.*(tht1_p).^2 + (Cap.C121 + Cap.C211).*(tht1_p).*(tht2_p) +...
   (Cap.C131 + Cap.C311).*(tht1_p).*(tht3_p) + Cap.C221.*(tht2_p).^2 +...
   (Cap.C231 + Cap.C321).*(tht2_p).*(tht3_p) + Cap.C331.*(tht3_p).^2 + Gap.g1;

%% TORQUE DA JUNTA K = 2 JOELHO
tau_2 = Dap.d21.*(tht1_2p) + Dap.d22.*(tht2_2p) + Dap.d23.*(tht3_2p) +...
    Cap.C112.*(tht1_p).^2 + (Cap.C122 + Cap.C212).*(tht1_p).*(tht2_p) +...
    (Cap.C132 + Cap.C312).*(tht1_p).*(tht3_p) + Cap.C222.*(tht2_p).^2 +...
    (Cap.C232 + Cap.C322).*(tht2_p).*(tht3_p) + Cap.C332.*(tht3_p).^2 + Gap.g2;

%% TORQUE DA JUNTA K = 3 QUADRIL
tau_3 = Dap.d31.*(tht1_2p) + Dap.d32.*(tht2_2p) + Dap.d33.*(tht3_2p) +...
    Cap.C113.*(tht1_p).^2 + (Cap.C123 + Cap.C213).*(tht1_p).*(tht2_p) +...
    (Cap.C133 + Cap.C313).*(tht1_p).*(tht3_p) + Cap.C223.*(tht2_p).^2 +...
    (Cap.C233 + Cap.C323).*(tht2_p).*(tht3_p) + Cap.C333.*(tht3_p).^2 + Gap.g3;

% % TORQUE DA JUNTA DO TORNOZELO NA FASE DE APOIO CONSIDERANDO 3 DoF
torque_Tap =  tau_1;

% % TORQUE DA JUNTA DO JOELHO NA FASE DE APOIO CONSIDERANDO 3 DoF
torque_Jap = -tau_2 ;

% % TORQUE DA JUNTA DO QUADRIL NA NA FASE DE APOIO CONSIDERANDO 3 DoF
torque_Qap = -tau_3;
end