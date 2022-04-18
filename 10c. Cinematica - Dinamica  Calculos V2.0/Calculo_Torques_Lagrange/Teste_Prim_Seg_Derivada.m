% close all; clear all; clc;

V = Velocidade2();

Tempo =  V(1).tempo;

Theta_b = (V(1).thetaq - V(1).thetaj + V(1).thetat).*(pi/180);

[Thetab_p, Thetab_2p] = derivada(Theta_b, Tempo);

figure(1)
grid on
subplot(3,1,1)
plot(Tempo, Theta_b, 'k', 'LineWidth',2)
xlim([Tempo(1), Tempo(end)]);

subplot(3,1,2)
plot(Tempo, Thetab_p,'r','LineWidth',2)
xlim([Tempo(1), Tempo(end)]);

subplot(3,1,3)
plot(Tempo, Thetab_2p, 'b', 'LineWidth',2)
xlim([Tempo(1), Tempo(end)]);
title('Derivada angulo positivo')
% utilizo o Método de Diferencias Finitas Centradas para calcular as 

Theta_a = -1.*(V(1).thetaq - V(1).thetaj + V(1).thetat).*(pi/180);
[Thetaa_p, Thetaa_2p] = derivada(Theta_a, Tempo);

figure(2)
grid on
subplot(3,1,1)
plot(Tempo, Theta_a, 'k', 'LineWidth',2)
xlim([Tempo(1), Tempo(end)]);

subplot(3,1,2)
plot(Tempo, Thetaa_p,'r','LineWidth',2)
xlim([Tempo(1), Tempo(end)]);

subplot(3,1,3)
plot(Tempo, Thetaa_2p, 'b', 'LineWidth',2)
xlim([Tempo(1), Tempo(end)]);
title('Derivada Angulo Negativo')