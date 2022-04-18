function [torque_Qb, torque_Jb, torque_Tb] = torques_balanco(Db,Cb,Gb,deriv_Q,deriv_J, deriv_T)

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

% % TORQUE DA JUNTA DO QUADRIL NA FASE DE BALANCO
torque_Qb = tau_1;

% % TORQUE DA JUNTA DO JOELHO NA FASE DE BALANCO
torque_Jb = tau_2;

% % TORQUE DA JUNTA DO TORNOZELO NA FASE DE BALANCO
torque_Tb = tau_3;
end
                                         