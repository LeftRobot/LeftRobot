function aceleracao=Calc_Aceler(t,r)
%Calculo da Aceleracao (segunda derivada) usando o método de diferencas 
% finitas, deferenca central de segunda ordem
% d^2U/dt^2 = (Ui+1 - 2Ui + Ui-1)/dt^2

n=length(r);
r_2ponto=zeros(n,1);
dt=0;

for i=1:n
    
    if i==1
        dt = (t(i+1)-t(i))^2;
        r_2ponto(i) = (r(i+1)-2*r(i)+r(n))/dt;
   
    elseif i==n
        dt = (t(i)-t(i-1))^2;
        r_2ponto(i) = (r(1)-2*r(i)+r(i-1))/dt;
   
    else
        dt = (t(i+1)-t(i))^2;
        r_2ponto(i) = (r(i+1)-2*r(i)+r(i-1))/dt;
    
    end
end

aceleracao=r_2ponto;

end