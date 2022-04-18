function Velocidade=Calc_Vel(t,r)
%Calculo da velocidade (primeira derivada) usando o método de diferencas 
% finitas, deferenca central de primeira ordem
% dU/dt = (Ui+1 - Ui-1)/2*dt

n=length(r);
r_ponto=zeros(n,1);
dt=0;

for i=1:n
    
    if i==1
        dt = 2*(t(i+1)-t(i));
        r_ponto(i) = (r(i+1)-r(n))/dt;
   
    elseif i==n
        dt = 2*(t(i)-t(i-1));
        r_ponto(i) = (r(1)-r(i-1))/dt;
   
    else
        dt = 2*(t(i+1)-t(i));
        r_ponto(i) = (r(i+1)-r(i-1))/dt;
    
    end
end

Velocidade=r_ponto;

end