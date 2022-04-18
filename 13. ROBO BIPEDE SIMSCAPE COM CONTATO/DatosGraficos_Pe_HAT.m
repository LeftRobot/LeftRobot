
%% SALVA ARQUIVOS ".txt" DADOS Fcontato, Posicao, Velocidade, Aceleracao 

% ========================== VELOCIDADE V1 ================================
if velocidade == 1
% -------------------------------------------------------------------------  
% Posicao Pe Direito para V1    
    t_posD = pos_peD.x.Time;
    
    x_posD = pos_peD.x.Data; 
    
    y_posD = pos_peD.y.Data;
    
    %posPe  = [time, posX, posY];
    pos_peD_V1 = [t_posD, x_posD, y_posD];
    writematrix(pos_peD_V1,'posPe_DV1.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------    
% velocidade Pe Direito para V1    
    t_velD = vel_peD.vx.Time;
    
    x_velD = vel_peD.vx.Data; 
    
    y_velD = vel_peD.vy.Data;
    
    %vel_Pe  = [time, velX, velY];
    vel_peD_V1 = [t_velD, x_velD, y_velD];
    writematrix(vel_peD_V1,'velPe_DV1.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------
% Posicao Pe Esquerdo para V1     
    t_posE = pos_peE.x.Time;
    
    x_posE = pos_peE.x.Data; 
    
    y_posE = pos_peE.y.Data;
    
    %posPe  = [time, posX, posY];
    pos_peE_V1 = [t_posE, x_posE, y_posE];
    writematrix(pos_peE_V1,'posPe_EV1.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------
% velocidade Pe Esquerdo para V1    
    t_velE = vel_peE.vx.Time;
    
    x_velE = vel_peE.vx.Data; 
    
    y_velE = vel_peE.vy.Data;
    
    %vel_Pe  = [time, velX, velY];
    vel_peE_V1 = [t_velE, x_velE, y_velE];
    writematrix(vel_peE_V1,'velPe_EV1.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------
% Posicao CoG para V1
    tp_CoG = pos_CoG.X.Time;
    x_CoG = pos_CoG.X.Data;
    y_CoG = pos_CoG.Y.Data;

    posCoGV1 = [tp_CoG, x_CoG, y_CoG];
    writematrix(posCoGV1, 'posCoG_V1.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------
% Velocidade CoG para V1
    tv_CoG = vel_CoG.vx.Time;
    vx_CoG = vel_CoG.vx.Data;
    vy_CoG = vel_CoG.vy.Data;

    velCoGV1 = [tv_CoG, vx_CoG, vy_CoG];
    writematrix(velCoGV1, 'velCoG_V1.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------
% Aceleracao CoG para V1
    ta_CoG = acel_CoG.ax.Time;
    ax_CoG = acel_CoG.ax.Data;
    ay_CoG = acel_CoG.ay.Data;

    acelCoGV1 = [ta_CoG, ax_CoG, ay_CoG];
    writematrix(acelCoGV1, 'acelCoG_V1.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------

% Forca de Contato Pé Direito para V1
    time_FnD = Fcont_D.signal1.Time;

    FnD_V1   = Fcont_D.signal1.Data; 

    FfD_V1   = Fcont_D.signal2.Data;

    dsepD_V1 = Fcont_D.signal3.Data;

    % Fcont_D_V1 = [Time, Fnormal, Ffriction, Dseparacao];
    Fcont_D_V1 = [time_FnD, FnD_V1, FfD_V1, dsepD_V1];
    writematrix(Fcont_D_V1, 'Fcont_D_V1.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------
% Forca de Contato Pé Esquerdo para V1
    time_FnE = Fcont_E.signal1.Time;

    FnE_V1   = Fcont_E.signal1.Data; 

    FfE_V1   = Fcont_E.signal2.Data;

    dsepE_V1 = Fcont_E.signal3.Data;

    Fcont_E_V1 = [time_FnE, FnE_V1, FfE_V1, dsepE_V1];

    % Fcont_E_V1 = [Time, Fnormal, Ffriction, Dseparacao];
    writematrix(Fcont_E_V1, 'Fcont_E_V1.txt', 'Delimiter', '\t')
%     type('Fcont_E_V1.txt')
% -------------------------------------------------------------------------
% Torques Perna Direita e Perna Esquerda para V1
    % salva os Torques da Perna Direita e Esquerda no arquivo "tau_V1.txt"
    % [tempo, tau_quadril, tau_joelho, tau_tornozelo]
    torqs_V1 = [torques_V1.Time, torques_V1.Data]; 
    writematrix(torqs_V1, 'tau_V1.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------

% ========================= VELOCIDADE V2 =================================
elseif velocidade == 2
    % Posicao Pe Direito para V2    
    t_posD = pos_peD.x.Time;
    
    x_posD = pos_peD.x.Data; 
    
    y_posD = pos_peD.y.Data;
    
    %posPe  = [time, posX, posY];
    pos_peD_V2 = [t_posD, x_posD, y_posD];
    writematrix(pos_peD_V2,'posPe_DV2.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------    
% velocidade Pe Direito para V2    
    t_velD = vel_peD.vx.Time;
    
    x_velD = vel_peD.vx.Data; 
    
    y_velD = vel_peD.vy.Data;
    
    %vel_Pe  = [time, velX, velY];
    vel_peD_V2 = [t_velD, x_velD, y_velD];
    writematrix(vel_peD_V2,'velPe_DV2.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------
% Posicao Pe Esquerdo para V2     
    t_posE = pos_peE.x.Time;
    
    x_posE = pos_peE.x.Data; 
    
    y_posE = pos_peE.y.Data;
    
    %posPe  = [time, posX, posY];
    pos_peE_V2 = [t_posE, x_posE, y_posE];
    writematrix(pos_peE_V2,'posPe_EV2.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------
% velocidade Pe Esquerdo para V2    
    t_velE = vel_peE.vx.Time;
    
    x_velE = vel_peE.vx.Data; 
    
    y_velE = vel_peE.vy.Data;
    
    %vel_Pe  = [time, velX, velY];
    vel_peE_V2 = [t_velE, x_velE, y_velE];
    writematrix(vel_peE_V2,'velPe_EV2.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------
% Posicao CoG para V2
    tp_CoG = pos_CoG.X.Time;
    x_CoG = pos_CoG.X.Data;
    y_CoG = pos_CoG.Y.Data;

    posCoGV2 = [tp_CoG, x_CoG, y_CoG];
    writematrix(posCoGV2, 'posCoG_V2.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------
% Velocidade CoG para V2
    tv_CoG = vel_CoG.vx.Time;
    vx_CoG = vel_CoG.vx.Data;
    vy_CoG = vel_CoG.vy.Data;

    velCoGV2 = [tv_CoG, vx_CoG, vy_CoG];
    writematrix(velCoGV2, 'velCoG_V2.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------
% Aceleracao CoG para V2
    ta_CoG = acel_CoG.ax.Time;
    ax_CoG = acel_CoG.ax.Data;
    ay_CoG = acel_CoG.ay.Data;

    acelCoGV2 = [ta_CoG, ax_CoG, ay_CoG];
    writematrix(acelCoGV2, 'acelCoG_V2.txt', 'Delimiter', '\t')
% % -----------------------------------------------------------------------
% Forca de Contato Pé Direito para V2
    time_FnD   = Fcont_D.signal1.Time;

    FnD_V2     = Fcont_D.signal1.Data; 

    FfD_V2     = Fcont_D.signal2.Data;

    dsepD_V2   = Fcont_D.signal3.Data;

    Fcont_D_V2 = [time_FnD, FnD_V2, FfD_V2, dsepD_V2];

    % Fcont_D_V2 = [Time, Fn, Ff, Dsep];
    writematrix(Fcont_D_V2, 'Fcont_D_V2.txt', 'Delimiter', '\t')
    type('Fcont_D_V2.txt')
    
% Forca de Contato Pé Esquerdo para V2
    time_FnE    = Fcont_E.signal1.Time;

    FnE_V2      = Fcont_E.signal1.Data; 

    FfE_V2      = Fcont_E.signal2.Data;

    dsepE_V2    = Fcont_E.signal3.Data;

    Fcont_E_V2  = [time_FnE, FnE_V2, FfE_V2, dsepE_V2];

    % Fcont_E_V2 = [Time Fn Ff Dsep];
    writematrix(Fcont_E_V2, 'Fcont_E_V2.txt', 'Delimiter', '\t')
%     type('Fcont_E_V2.txt')

% Torques Perna Direita e Perna Esquerda para V2
    % salva os Torques da Perna Direita e Esquerda no arquivo "tau_V2.txt"
    % [tempo, tau_quadril, tau_joelho, tau_tornozelo]
    torqs_V2 = [torques_V2.Time, torques_V2.Data]; 
    writematrix(torqs_V2, 'tau_V2.txt', 'Delimiter', '\t')
%--------------------------------------------------------------------------

% ========================= VELOCIDADE V3 =================================
elseif velocidade == 3
    % Posicao Pe Direito para V3    
    t_posD = pos_peD.x.Time;
    
    x_posD = pos_peD.x.Data; 
    
    y_posD = pos_peD.y.Data;
    
    %posPe  = [time, posX, posY];
    pos_peD_V3 = [t_posD, x_posD, y_posD];
    writematrix(pos_peD_V3,'posPe_DV3.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------    
% velocidade Pe Direito para V3    
    t_velD = vel_peD.vx.Time;
    
    x_velD = vel_peD.vx.Data; 
    
    y_velD = vel_peD.vy.Data;
    
    %vel_Pe  = [time, velX, velY];
    vel_peD_V3 = [t_velD, x_velD, y_velD];
    writematrix(vel_peD_V3,'velPe_DV3.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------
% Posicao Pe Esquerdo para V3     
    t_posE = pos_peE.x.Time;
    
    x_posE = pos_peE.x.Data; 
    
    y_posE = pos_peE.y.Data;
    
    %posPe  = [time, posX, posY];
    pos_peE_V3 = [t_posE, x_posE, y_posE];
    writematrix(pos_peE_V3,'posPe_EV3.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------
% velocidade Pe Esquerdo para V3    
    t_velE = vel_peE.vx.Time;
    
    x_velE = vel_peE.vx.Data; 
    
    y_velE = vel_peE.vy.Data;
    
    %vel_Pe  = [time, velX, velY];
    vel_peE_V3 = [t_velE, x_velE, y_velE];
    writematrix(vel_peE_V3,'velPe_EV3.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------
% Posicao CoG para V3
    tp_CoG = pos_CoG.X.Time;
    x_CoG  = pos_CoG.X.Data;
    y_CoG  = pos_CoG.Y.Data;

    posCoGV3 = [tp_CoG, x_CoG, y_CoG];
    writematrix(posCoGV3, 'posCoG_V3.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------
% Velocidade CoG para V3
    tv_CoG = vel_CoG.vx.Time;
    vx_CoG = vel_CoG.vx.Data;
    vy_CoG = vel_CoG.vy.Data;

    velCoGV3 = [tv_CoG, vx_CoG, vy_CoG];
    writematrix(velCoGV3, 'velCoG_V3.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------
% Aceleracao CoG para V3
    ta_CoG = acel_CoG.ax.Time;
    ax_CoG = acel_CoG.ax.Data;
    ay_CoG = acel_CoG.ay.Data;

    acelCoGV3 = [ta_CoG, ax_CoG, ay_CoG];
    writematrix(acelCoGV3, 'acelCoG_V3.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------
% Forca de Contato Pé Direito para V3
    time_FnD   = Fcont_D.signal1.Time;

    FnD_V3     = Fcont_D.signal1.Data; 

    FfD_V3     = Fcont_D.signal2.Data;

    dsepD_V3   = Fcont_D.signal3.Data;

    Fcont_D_V3 = [time_FnD, FnD_V3, FfD_V3, dsepD_V3];

    % Fcont_D_V3 = [Time, Fn, Ff, Dsep];
    writematrix(Fcont_D_V3, 'Fcont_D_V3.txt', 'Delimiter', '\t')
%     type('Fcont_D_V3.txt')

% Forca de Contato Pé Esquerdo para V3
    time_FnE     = Fcont_E.signal1.Time;

    FnE_V3       = Fcont_E.signal1.Data; 

    FfE_V3       = Fcont_E.signal2.Data;

    dsepE_V3     = Fcont_E.signal3.Data;

    Fcont_E_V3   = [time_FnE, FnE_V3, FfE_V3, dsepE_V3];

    % Fcont_E_V3 = [Time, Fn, Ff, Dsep];
    writematrix(Fcont_E_V3, 'Fcont_E_V3.txt', 'Delimiter', '\t')
%     type('Fcont_E_V3.txt')

% Torques Perna Direita e Perna Esquerda para V3
    % salva os Torques da Perna Direita e Esquerda no arquivo "tau_V3.txt"
    % [tempo, tau_quadril, tau_joelho, tau_tornozelo]
    torqs_V3 = [torques_V3.Time, torques_V3.Data]; 
    writematrix(torqs_V3, 'tau_V3.txt', 'Delimiter', '\t')
%--------------------------------------------------------------------------

% =========================== VELOCIDADE V4 ===============================
else 
    % Posicao Pe Direito para V4    
    t_posD = pos_peD.x.Time;
    
    x_posD = pos_peD.x.Data; 
    
    y_posD = pos_peD.y.Data;
    
    %posPe  = [time, posX, posY];
    pos_peD_V4 = [t_posD, x_posD, y_posD];
    writematrix(pos_peD_V4,'posPe_DV4.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------    
% velocidade Pe Direito para V4    
    t_velD = vel_peD.vx.Time;
    
    x_velD = vel_peD.vx.Data; 
    
    y_velD = vel_peD.vy.Data;
    
    %vel_Pe  = [time, velX, velY];
    vel_peD_V4 = [t_velD, x_velD, y_velD];
    writematrix(vel_peD_V4,'velPe_DV4.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------
% Posicao Pe Esquerdo para V4     
    t_posE = pos_peE.x.Time;
    
    x_posE = pos_peE.x.Data; 
    
    y_posE = pos_peE.y.Data;
    
    %posPe  = [time, posX, posY];
    pos_peE_V4 = [t_posE, x_posE, y_posE];
    writematrix(pos_peE_V4,'posPe_EV4.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------
% velocidade Pe Esquerdo para V4    
    t_velE = vel_peE.vx.Time;
    
    x_velE = vel_peE.vx.Data; 
    
    y_velE = vel_peE.vy.Data;
    
    %vel_Pe  = [time, velX, velY];
    vel_peE_V4 = [t_velE, x_velE, y_velE];
    writematrix(vel_peE_V4,'velPe_EV4.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------
% Posicao CoG para V4
    tp_CoG = pos_CoG.X.Time;
    x_CoG = pos_CoG.X.Data;
    y_CoG = pos_CoG.Y.Data;

    posCoGV4 = [tp_CoG, x_CoG, y_CoG];
    writematrix(posCoGV4, 'posCoG_V4.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------
% Velocidade CoG para V4
    tv_CoG = vel_CoG.vx.Time;
    vx_CoG = vel_CoG.vx.Data;
    vy_CoG = vel_CoG.vy.Data;

    velCoGV4 = [tv_CoG, vx_CoG, vy_CoG];
    writematrix(velCoGV4, 'velCoG_V4.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------
% Aceleracao CoG para V4
    ta_CoG = acel_CoG.ax.Time;
    ax_CoG = acel_CoG.ax.Data;
    ay_CoG = acel_CoG.ay.Data;

    acelCoGV4 = [ta_CoG, ax_CoG, ay_CoG];
    writematrix(acelCoGV4, 'acelCoG_V4.txt', 'Delimiter', '\t')
% -------------------------------------------------------------------------
% Forca de Contato Pé Direito para V4
    time_FnD   = Fcont_D.signal1.Time;

    FnD_V4     = Fcont_D.signal1.Data; 

    FfD_V4     = Fcont_D.signal2.Data;

    dsepD_V4   = Fcont_D.signal3.Data;

    Fcont_D_V4 = [time_FnD, FnD_V4, FfD_V4, dsepD_V4];

    % Fcont_D_V4 = [Time, Fn, Ff, Dsep];
    writematrix(Fcont_D_V4, 'Fcont_D_V4.txt', 'Delimiter', '\t')
%     type('Fcont_D_V4.txt')

% Forca de Contato Pé Esquerdo para V4
    time_FnE     = Fcont_E.signal1.Time;

    FnE_V4       = Fcont_E.signal1.Data; 

    FfE_V4       = Fcont_E.signal2.Data;

    dsepE_V4     = Fcont_E.signal3.Data;

    Fcont_E_V4   = [time_FnE, FnE_V4, FfE_V4, dsepE_V4];

    % Fcont_E_V4 = [Time, Fn, Ff, Dsep];
    writematrix(Fcont_E_V4, 'Fcont_E_V4.txt', 'Delimiter', '\t')
%     type('Fcont_E_V4.txt')

% Torques Perna Direita e Perna Esquerda para V4
    % salva os Torques da Perna Direita e Esquerda no arquivo "tau_V4.txt"
    % [tempo, tau_quadril, tau_joelho, tau_tornozelo]
    torqs_V4 = [torques_V4.Time, torques_V4.Data]; 
    writematrix(torqs_V4, 'tau_V4.txt', 'Delimiter', '\t')

end
