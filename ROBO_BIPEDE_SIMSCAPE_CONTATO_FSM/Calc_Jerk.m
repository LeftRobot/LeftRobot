function jerk = Calc_Jerk(t,r)
%Calculo da Aceleracao (segunda derivada) usando o método de diferencas 
% finitas, deferenca central de terceira ordem
% d^3U/dt^3 = (Ui+2 - 2Ui+1 + 2Ui-1 - Ui-2) / (2*dt^3)

n=length(r);
r_3ponto=zeros(n,1);
dt=0;

for i=1:n
    
    if i==1
        dt = 2*(t(i+1)-t(i))^3;
        r_3ponto(i) =(r(i+2)-2*r(i+1)+2*r(n)-r(n-1))/dt;
   
    elseif i==2
        dt = 2*(t(i+1)-t(i))^3;
        r_3ponto(i) = (r(i+2)-2*r(i+1)+2*r(i-1)-r(n))/dt;
        
    elseif i==(n-1)
        dt = 2*(t(i+1)-t(i))^3;
        r_3ponto(i) = (r(1)-2*r(i+1)+2*r(i-1)-r(i-2))/dt;
        
    elseif i==n
        dt = 2*(t(i)-t(i-1))^3;
        r_3ponto(i) = (r(2)-2*r(1)+2*r(i-1)-r(i-2))/dt;
   
    else
        dt = 2*(t(i+1)-t(i))^3;
        r_3ponto(i) = (r(i+2)-2*r(i+1)+2*r(i-1)-r(i-2))/dt;
    
    end
end

jerk=r_3ponto;

end