% GRÁFICOS ANGULOS DAS JUNTAS PARA AS 4 VELOCIDADES DE MARCHA

angulos1 = Velocidade1();
time1    = angulos1.tempo;
angulos2 = Velocidade2();
time2    = angulos2.tempo;
angulos3 = Velocidade3();
time3    = angulos3.tempo;
angulos4 = Velocidade4();
time4    = angulos4.tempo;

quadril1 = angulos1.thetaq;
quadril2 = angulos2.thetaq;
quadril3 = angulos3.thetaq;
quadril4 = angulos4.thetaq;

joelho1 = angulos1.thetaj;
joelho2 = angulos2.thetaj;
joelho3 = angulos3.thetaj;
joelho4 = angulos4.thetaj;

tornozelo1 = angulos1.thetat;
tornozelo2 = angulos2.thetat;
tornozelo3 = angulos3.thetat;
tornozelo4 = angulos4.thetat;

%% Comparacao do angulo do quadril para 4 velocidades de marcha
figure('Name', 'Angulos do quadril para 4 velocidades de marcha')
plot(time1, quadril1,'r','LineWidth',1.5)
hold on
plot(time2, quadril2,'b','LineWidth',1.5)
hold on
plot(time3, quadril3,'k','LineWidth',1.5)
hold on
plot(time4, quadril4,'m','LineWidth',1.5)
hold off
aex = gca;
aex.FontSize = 15;
leg = legend('Hip Angle V_1','Hip Angle V_2','Hip Angle V_3','Hip Angle V_4');
leg.Location = 'northeastoutside';
leg.FontSize = 18;
ylabel('Angle [°]');
xlabel('t [sec]');
tit1 = title('Hip Angles for 4 Gait Speeds');
tit1.FontSize = 20;

%% Comparacao do angulo do joelho para 4 velocidades de marcha
figure('Name', 'Angulos do joelho para 4 velocidades de marcha')
plot(time1, joelho1,'r','LineWidth',1.5)
hold on
plot(time2, joelho2,'b','LineWidth',1.5)
hold on
plot(time3, joelho3,'k','LineWidth',1.5)
hold on
plot(time4, joelho4,'m','LineWidth',1.5)
hold off
aex = gca;
aex.FontSize = 15;
leg = legend('Knee Angle V_1','Knee Angle V_2','Knee Angle V_3','Knee Angle V_4');
leg.Location = 'northeastoutside';
leg.FontSize = 18;
ylabel('Angle [°]');
xlabel('t [sec]');
tit1 = title('Knee Angles for 4 Gait Speeds');
tit1.FontSize = 20;

%% Comparacao do angulo do tornozelo para 4 velocidades de marcha
figure('Name', 'Angulos do tornozelo para 4 velocidades de marcha')
plot(time1, tornozelo1,'r','LineWidth',1.5)
hold on
plot(time2, tornozelo2,'b','LineWidth',1.5)
hold on
plot(time3, tornozelo3,'k','LineWidth',1.5)
hold on
plot(time4, tornozelo4,'m','LineWidth',1.5)
hold off
aex = gca;
aex.FontSize = 15;
leg = legend('Ankle Angle V_1','Ankle Angle V_2','Ankle Angle V_3','Ankle Angle V_4');
leg.Location = 'northeastoutside';
leg.FontSize = 18;
ylabel('Angle [°]');
xlabel('t [sec]');
tit1 = title('Ankle Angles for 4 Gait Speeds');
tit1.FontSize = 20;
    