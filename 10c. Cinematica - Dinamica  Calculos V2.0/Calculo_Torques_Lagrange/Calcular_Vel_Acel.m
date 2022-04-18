function [derivadas_Q, derivadas_J, derivadas_T] = Calcular_Vel_Acel(V)

% Calculo da velocidade e aceleracao angular para cada junta da perna
% direita

% Carrego os vetores de tempo, theta_q, theta_j, e theta_t em converto a
% radianos 
Tempo =  V(1).tempo;
Tq    = (V(1).thetaq).*(pi/180);
Tj    = (V(1).thetaj).*(pi/180);
Tt    = (V(1).thetat).*(pi/180);

% Inicializa os vetores para calcular a primeira derivada dos angulos das
% juntas
Tqd = zeros(size(Tq));
Tjd = zeros(size(Tj));
Ttd = zeros(size(Tt));
tam = length(Tjd);
dt = 0;

% utilizo o método de diferencias finitas centradas para calcular as 
% velocidades angulares das juntas (primeira derivada)

for i=1:tam
	if i == 1
		dt = 2 * (Tempo(i+1) - Tempo(i));
		Tqd(i) = (Tq(i+1) - Tq(tam))/dt; 
		Tjd(i) = (Tj(i+1) - Tj(tam))/dt;
		Ttd(i) = (Tt(i+1) - Tt(tam))/dt; 
	elseif i == tam
		dt = 2 * (Tempo(i) - Tempo(i-1));
		Tqd(i) = (Tq(1) - Tq(i-1))/dt;
		Tjd(i) = (Tj(1) - Tj(i-1))/dt;
		Ttd(i) = (Tt(1) - Tt(i-1))/dt;
	else
		dt = 2 * (Tempo(i+1) - Tempo(i));
		Tqd(i) = (Tq(i+1) - Tq(i-1))/dt;
		Tjd(i) = (Tj(i+1) - Tj(i-1))/dt;
		Ttd(i) = (Tt(i+1) - Tt(i-1))/dt;
	end		
end

% figure(1)
% subplot(3,1,1)
% plot(Tempo, Tqd)
% xlim([Tempo(1), Tempo(end)]);
% subplot(3,1,2)
% plot(Tempo, Tjd)
% xlim([Tempo(1), Tempo(end)]);
% subplot(3,1,3)
% plot(Tempo, Ttd)
% xlim([Tempo(1), Tempo(end)]);

% utilizo o Método de Diferencias Finitas Centradas para calcular as 
% aceleracoes angulares das juntas (segunda derivada)

Tqdd = zeros(size(Tq));
Tjdd = zeros(size(Tj));
Ttdd = zeros(size(Tt));
tam = length(Tjdd);
dt = 0;

for i=1:tam
	if i == 1
		dt = (Tempo(i+1) - Tempo(i))^2;
		Tqdd(i) = (Tq(i+1) - 2 * Tq(i) + Tq(tam))/dt; 
		Tjdd(i) = (Tj(i+1) - 2 * Tj(i) + Tj(tam))/dt;
		Ttdd(i) = (Tt(i+1) - 2 * Tt(i) + Tt(tam))/dt; 
	elseif i == tam
		dt = (Tempo(i) - Tempo(i-1))^2;
		Tqdd(i) = (Tq(1) - 2 * Tq(i) + Tq(i-1))/dt;
		Tjdd(i) = (Tj(1) - 2 * Tj(i) + Tj(i-1))/dt;
		Ttdd(i) = (Tt(1) - 2 * Tt(i) + Tt(i-1))/dt;
	else
		dt = (Tempo(i+1) - Tempo(i))^2;
		Tqdd(i) = (Tq(i+1) - 2 * Tq(i) + Tq(i-1))/dt;
		Tjdd(i) = (Tj(i+1) - 2 * Tj(i) + Tj(i-1))/dt;
		Ttdd(i) = (Tt(i+1) - 2 * Tt(i) + Tt(i-1))/dt;
	end		
end

% figure(2)
% subplot(3,1,1)
% plot(Tempo, Tqdd)
% xlim([Tempo(1), Tempo(end)]);
% subplot(3,1,2)
% plot(Tempo, Tjdd)
% xlim([Tempo(1), Tempo(end)]);
% subplot(3,1,3)
% plot(Tempo, Ttdd)
% xlim([Tempo(1), Tempo(end)]);

% Structure para armazenar as derivadas do angulo do Quadril Direito
derivadas_Q.tempo     = Tempo;
derivadas_Q.thetaq    = Tq;
derivadas_Q.thetaq_P  = Tqd;
derivadas_Q.thetaq_PP = Tqdd;

% Structure para armazenar as derivadas do angulo do Joelho Direito
derivadas_J.tempo     = Tempo;
derivadas_J.thetaj    = Tj;
derivadas_J.thetaj_P  = Tjd;
derivadas_J.thetaj_PP = Tjdd;

% Structure para armazenar as derivadas do angulo do Tornozelo Direito
derivadas_T.tempo     = Tempo;
derivadas_T.thetat    = Tt;
derivadas_T.thetat_P  = Ttd;
derivadas_T.thetat_PP = Ttdd;
 
end