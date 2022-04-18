function [f_p, f_2p] = derivada(f, t)

Tempo = t;
f_p = zeros(size(f));
tam = size(f,1);
dt = 0;

% Método de diferencias finitas centradas para calcular as  velocidades 
% angulares das juntas (primeira derivada)

    for i=1:tam
        if i == 1
            dt = 2 * (Tempo(i+1) - Tempo(i));
            f_p(i) = (f(i+1) - f(tam))/dt; 
            
        elseif i == tam
            dt = 2 * (Tempo(i) - Tempo(i-1));
            f_p(i) = (f(1) - f(i-1))/dt;
            
        else
            dt = 2 * (Tempo(i+1) - Tempo(i));
            f_p(i) = (f(i+1) - f(i-1))/dt;
            
        end		
    end
    
% Método de diferencias finitas centradas para calcular as aceleracoes 
% angulares das juntas (segunda derivada)    
f_2p = zeros(size(f));
tam = size(f,1);
dt = 0;

    for i=1:tam
        if i == 1
            dt = (Tempo(i+1) - Tempo(i))^2;
            f_2p(i) = (f(i+1) - 2 * f(i) + f(tam))/dt;  
        elseif i == tam
            dt = (Tempo(i) - Tempo(i-1))^2;
            f_2p(i) = (f(1) - 2 * f(i) + f(i-1))/dt;
        else
            dt = (Tempo(i+1) - Tempo(i))^2;
            f_2p(i) = (f(i+1) - 2 * f(i) + f(i-1))/dt;
        end		
    end

end

