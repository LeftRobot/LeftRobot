function graf_trajet(source,eventdata)

% Variáveis globais para a velocidade de marcha em cada seccao de tempo Ti
global velT1; global velT2; global velT3; global velT4;
global velT5; global velT6; global velT7; global velT8;

% Variáveis globais do número de ciclos de marcha em cada seccao de tempo Ti
global ciclos_T1; global ciclos_T2; global ciclos_T3; global ciclos_T4;
global ciclos_T5; global ciclos_T6; global ciclos_T7; global ciclos_T8;

% Variáveis globais da inclinacao do terreno em cada seccao de tempo Ti
global inc_T1; global inc_T2; global inc_T3; global inc_T4;
global inc_T5; global inc_T6; global inc_T7; global inc_T8;

% vel_marcha é a estrutura para salvar os dados da trajetória gerada
global vel_marcha;

% Passo de tempo para a velocidade V1 = 0.5 m/s
delta_t1 = 0.0115;
% Passo de tempo para a velocidade V2 = 1 m/s
delta_t2 = 0.0069;
% Passo de tempo para a velocidade V3 = 1.2 m/s
delta_t3 = 0.0060;
% Passo de tempo para a velocidade V1 = 1.5 m/s
delta_t4 = 0.0054;


% Procura pelo componente Popupmenu1 do UIcontrol pelo identificador 'Tag'
% para identificar a velocidade selecionada em velT1
pop1 = findobj('Tag','popvelT1');

% datapop1 = pop1.UserData obtém o valor da propriedade UserData que
% carrega a estrutura {source.UserData = datapop1} da funcao pop1_callback;
% datapop1 = struct('VT1',val)
datapop1 = pop1.UserData;

    if datapop1.VT1 == 1
            delta_t = delta_t1;
        
    elseif datapop1.VT1 == 2
            delta_t = delta_t2;
        
    elseif datapop1.VT1 == 3
            delta_t = delta_t3;
            
    elseif datapop1.VT1 == 4
            delta_t = delta_t4;
    else
        delta_t = 0;
    end
    
ciclo = length(velT1(1).tempo);

% Monta na estrutura vel_marcha os dados da estructura velT1 repetida o
% número de vezes definido por ciclos_T1.
    if ciclos_T1 == 1
        vel_marcha = velT1;
    
    elseif ciclos_T1 > 1
       
        vel_marcha = velT1;
         
        for i = ciclo+1 : 1 : ciclos_T1*ciclo
          
            % Monta vetor de tempo da perna direita e perna esquerda
            vel_marcha(1).tempo(i)  = vel_marcha(1).tempo(i-1) + delta_t;
            vel_marcha(2).tempo(i)  = vel_marcha(2).tempo(i-1) + delta_t;
            
            % Monta o vetor de Yq, Yj, Yt e Yp que sao ciclicos para perna 
            % esquerda e a perna direita
            vel_marcha(1).Yq(i)     = vel_marcha(1).Yq(i-ciclo);
            vel_marcha(2).Yq(i)     = vel_marcha(2).Yq(i-ciclo);
        
            vel_marcha(1).Yj(i)     = vel_marcha(1).Yj(i-ciclo);
            vel_marcha(2).Yj(i)     = vel_marcha(2).Yj(i-ciclo);
        
            vel_marcha(1).Yt(i)     = vel_marcha(1).Yt(i-ciclo);
            vel_marcha(2).Yt(i)     = vel_marcha(2).Yt(i-ciclo);
        
            vel_marcha(1).Yp(i)     = vel_marcha(1).Yp(i-ciclo);
            vel_marcha(2).Yp(i)     = vel_marcha(2).Yp(i-ciclo);
        
            % Monta o vetor de theta_q, theta_j e theta_t que sao ciclicos 
            % para perna esquerda e a perna direita
            vel_marcha(1).thetaq(i) = vel_marcha(1).thetaq(i-ciclo);
            vel_marcha(2).thetaq(i) = vel_marcha(2).thetaq(i-ciclo);
        
            vel_marcha(1).thetaj(i) = vel_marcha(1).thetaj(i-ciclo);
            vel_marcha(2).thetaj(i) = vel_marcha(2).thetaj(i-ciclo);
        
            vel_marcha(1).thetat(i) = vel_marcha(1).thetat(i-ciclo);
            vel_marcha(2).thetat(i) = vel_marcha(2).thetat(i-ciclo);
         end
    end
    
% Procura pelo componente Popupmenu2 do UIcontrol pelo identificador 'Tag'
% para identificar a velocidade selecionada em velT2
pop2 = findobj('Tag','popvelT2');

% datapop2 = pop2.UserData obtém o valor da propriedade UserData que
% carrega a estrutura {source.UserData = datapop2} da funcao pop2_callback;
% datapop2 = struct('VT2',val)
datapop2 = pop2.UserData;

% Determina o passo de tempo a ser usado para constroir o vetor de tempo
% dependendo da velocidade selecionada em VelT2
    if datapop2.VT2 == 1
            delta_t = delta_t1;
        
    elseif datapop2.VT2 == 2
            delta_t = delta_t2;
        
    elseif datapop2.VT2 == 3
            delta_t = delta_t3;
            
    elseif datapop2.VT2 == 4 
            delta_t = delta_t4;
    else
            delta_t = 0;
    end
    
ciclo = length(velT1(1).tempo);

if datapop2.VT2 ~= 0
% Monta na estrutura vel_marcha os dados da estructura velT2 repetida o
% número de vezes definido por ciclos_T2
            
    for i = (ciclos_T1*ciclo+1) : 1 : (ciclos_T1 + ciclos_T2)*ciclo
          
           % Monta vetor de tempo da perna direita e perna esquerda na seccao 
           % de tempo T2. Continua a partir do vetor de tempo da seccao T1
            vel_marcha(1).tempo(i)  = vel_marcha(1).tempo(i-1) + delta_t;
            vel_marcha(2).tempo(i)  = vel_marcha(2).tempo(i-1) + delta_t;
            
            % operacao módulo devolve o resto da divisão. caso mod(i,ciclo)
            % seja 0, é porque estou considerando múltiplo de 100. Caso
            % contrario mod(i,ciclo) varia de 1 até 99. Vetores cíclicos
            if mod(i,ciclo) == 0
                index = ciclo;
            else
                index = mod(i,ciclo);
            end
            
            vel_marcha(1).Yq(i)     = velT2(1).Yq(index);
            vel_marcha(2).Yq(i)     = velT2(2).Yq(index);
        
            vel_marcha(1).Yj(i)     = velT2(1).Yj(index);
            vel_marcha(2).Yj(i)     = velT2(2).Yj(index);
        
            vel_marcha(1).Yt(i)     = velT2(1).Yt(index);
            vel_marcha(2).Yt(i)     = velT2(2).Yt(index);
        
            vel_marcha(1).Yp(i)     = velT2(1).Yp(index);
            vel_marcha(2).Yp(i)     = velT2(2).Yp(index);
        
            vel_marcha(1).thetaq(i) = velT2(1).thetaq(index);
            vel_marcha(2).thetaq(i) = velT2(2).thetaq(index);
        
            vel_marcha(1).thetaj(i) = velT2(1).thetaj(index);
            vel_marcha(2).thetaj(i) = velT2(2).thetaj(index);
        
            vel_marcha(1).thetat(i) = velT2(1).thetat(index);
            vel_marcha(2).thetat(i) = velT2(2).thetat(index);
    end
end
% Procura pelo componente Popupmenu3 do UIcontrol pelo identificador 'Tag'
% para identificar a velocidade selecionada em velT3
pop3 = findobj('Tag','popvelT3');

% datapop3 = pop3.UserData obtém o valor da propriedade UserData que
% carrega a estrutura {source.UserData = datapop3} da funcao pop3_callback;
% datapop3 = struct('VT3',val)
datapop3 = pop3.UserData;

% Determina o passo de tempo a ser usado para constroir o vetor de tempo
% dependendo da velocidade selecionada em VelT3
    if datapop3.VT3 == 1
            delta_t = delta_t1;
        
    elseif datapop3.VT3 == 2
            delta_t = delta_t2;
        
    elseif datapop3.VT3 == 3
            delta_t = delta_t3;
            
    elseif datapop3.VT3 == 4 
            delta_t = delta_t4;
    else
            delta_t = 0;
    end
    
ciclo = length(velT1(1).tempo);

if datapop3.VT3 ~=0
% Monta na estrutura vel_marcha os dados da estructura velT3 repetida o
% número de vezes definido por ciclos_T1

     for i = (ciclos_T1+ciclos_T2)*ciclo+1 : 1 : (ciclos_T1+ciclos_T2+ciclos_T3)*ciclo
          
           % Monta vetor de tempo da perna direita e perna esquerda na seccao 
           % de tempo T3. Continua a partir do vetor de tempo da seccao T2
            vel_marcha(1).tempo(i)  = vel_marcha(1).tempo(i-1) + delta_t;
            vel_marcha(2).tempo(i)  = vel_marcha(2).tempo(i-1) + delta_t;
           
            % operacao módulo devolve o resto da divisão. caso mod(i,ciclo)
            % seja 0, é porque estou considerando múltiplos de 100. Caso
            % contrario mod(i,ciclo) varia de 1 até 99. Vetores cíclicos
            if mod(i,ciclo) == 0
                index = ciclo;
            else
                index = mod(i,ciclo);
            end
                        
            vel_marcha(1).Yq(i)     = velT3(1).Yq(index);
            vel_marcha(2).Yq(i)     = velT3(2).Yq(index);
        
            vel_marcha(1).Yj(i)     = velT3(1).Yj(index);
            vel_marcha(2).Yj(i)     = velT3(2).Yj(index);
        
            vel_marcha(1).Yt(i)     = velT3(1).Yt(index);
            vel_marcha(2).Yt(i)     = velT3(2).Yt(index);
        
            vel_marcha(1).Yp(i)     = velT3(1).Yp(index);
            vel_marcha(2).Yp(i)     = velT3(2).Yp(index);
        
            vel_marcha(1).thetaq(i) = velT3(1).thetaq(index);
            vel_marcha(2).thetaq(i) = velT3(2).thetaq(index);
        
            vel_marcha(1).thetaj(i) = velT3(1).thetaj(index);
            vel_marcha(2).thetaj(i) = velT3(2).thetaj(index);
        
            vel_marcha(1).thetat(i) = velT3(1).thetat(index);
            vel_marcha(2).thetat(i) = velT3(2).thetat(index);
    end
end    
% Procura pelo componente Popupmenu4 do UIcontrol pelo identificador 'Tag'
% para identificar a velocidade selecionada em velT4
pop4 = findobj('Tag','popvelT4');

% datapop4 = pop4.UserData obtém o valor da propriedade UserData que
% carrega a estrutura {source.UserData = datapop4} da funcao pop4_callback;
% datapop4 = struct('VT4',val)
datapop4 = pop4.UserData;

% Determina o passo de tempo a ser usado para constroir o vetor de tempo
% dependendo da velocidade selecionada em VelT4
    if datapop4.VT4 == 1
            delta_t = delta_t1;
        
    elseif datapop4.VT4 == 2
            delta_t = delta_t2;
        
    elseif datapop4.VT4 == 3
            delta_t = delta_t3;
            
    elseif datapop4.VT4 == 4 
            delta_t = delta_t4;
    else
            delta_t = 0;
    end

ciclo = length(velT1(1).tempo);

if datapop4.VT4 ~=0
% Monta na estrutura vel_marcha os dados da estructura velT4 repetida o
% número de vezes definido por ciclos_T4
    for i = (ciclos_T1 + ciclos_T2 + ciclos_T3)*ciclo + 1 : 1 :...
            (ciclos_T1 + ciclos_T2 + ciclos_T3+ ciclos_T4)*ciclo
          
           % Monta vetor de tempo da perna direita e perna esquerda na seccao 
           % de tempo T4. Continua a partir do vetor de tempo da seccao T3
            vel_marcha(1).tempo(i)  = vel_marcha(1).tempo(i-1) + delta_t;
            vel_marcha(2).tempo(i)  = vel_marcha(2).tempo(i-1) + delta_t;
            
            % operacao módulo devolve o resto da divisão. caso mod(i,ciclo)
            % seja 0, é porque estou considerando múltiplos de 100. Caso
            % contrario mod(i,ciclo) varia de 1 até 99. Vetores cíclicos
            if mod(i,ciclo) == 0
                index = ciclo;
            else
                index = mod(i,ciclo);
            end
            
            vel_marcha(1).Yq(i)     = velT4(1).Yq(index);
            vel_marcha(2).Yq(i)     = velT4(2).Yq(index);
        
            vel_marcha(1).Yj(i)     = velT4(1).Yj(index);
            vel_marcha(2).Yj(i)     = velT4(2).Yj(index);
        
            vel_marcha(1).Yt(i)     = velT4(1).Yt(index);
            vel_marcha(2).Yt(i)     = velT4(2).Yt(index);
        
            vel_marcha(1).Yp(i)     = velT4(1).Yp(index);
            vel_marcha(2).Yp(i)     = velT4(2).Yp(index);
        
            vel_marcha(1).thetaq(i) = velT4(1).thetaq(index);
            vel_marcha(2).thetaq(i) = velT4(2).thetaq(index);
        
            vel_marcha(1).thetaj(i) = velT4(1).thetaj(index);
            vel_marcha(2).thetaj(i) = velT4(2).thetaj(index);
        
            vel_marcha(1).thetat(i) = velT4(1).thetat(index);
            vel_marcha(2).thetat(i) = velT4(2).thetat(index);
    end
end
% Procura pelo componente Popupmenu5 do UIcontrol pelo identificador 'Tag'
% para identificar a velocidade selecionada em velT5
pop5 = findobj('Tag','popvelT5');

% datapop5 = pop5.UserData obtém o valor da propriedade UserData que
% carrega a estrutura {source.UserData = datapop5} da funcao pop5_callback;
% datapop5 = struct('VT5',val)
datapop5 = pop5.UserData;

% Determina o passo de tempo a ser usado para constroir o vetor de tempo
% dependendo da velocidade selecionada em VelT5
    if datapop5.VT5 == 1
            delta_t = delta_t1;
        
    elseif datapop5.VT5 == 2
            delta_t = delta_t2;
        
    elseif datapop5.VT5 == 3
            delta_t = delta_t3;
            
    elseif datapop5.VT5 == 4 
            delta_t = delta_t4;
    else
            delta_t = 0;
    end
    
ciclo = length(velT1(1).tempo);

if datapop5.VT5 ~=0
% Monta na estrutura vel_marcha os dados da estructura velT1 repetida o
% número de vezes definido por ciclos_T5
    for i = (ciclos_T1 + ciclos_T2 + ciclos_T3 + ciclos_T4)*ciclo + 1 : 1 :... 
            (ciclos_T1 + ciclos_T2 + ciclos_T3  +ciclos_T4 + ciclos_T5)*ciclo
          
           % Monta vetor de tempo da perna direita e perna esquerda na seccao 
           % de tempo T5. Continua a partir do vetor de tempo da seccao T4
            vel_marcha(1).tempo(i)  = vel_marcha(1).tempo(i-1) + delta_t;
            vel_marcha(2).tempo(i)  = vel_marcha(2).tempo(i-1) + delta_t;
            
            % operacao módulo devolve o resto da divisão. caso mod(i,ciclo)
            % seja 0, é porque estou considerando múltiplos de 100. Caso
            % contrario mod(i,ciclo) varia de 1 até 99. Vetores cíclicos
            if mod(i,ciclo) == 0
                index = ciclo;
            else
                index = mod(i,ciclo);
            end
            
            vel_marcha(1).Yq(i)     = velT5(1).Yq(index);
            vel_marcha(2).Yq(i)     = velT5(2).Yq(index);
        
            vel_marcha(1).Yj(i)     = velT5(1).Yj(index);
            vel_marcha(2).Yj(i)     = velT5(2).Yj(index);
        
            vel_marcha(1).Yt(i)     = velT5(1).Yt(index);
            vel_marcha(2).Yt(i)     = velT5(2).Yt(index);
        
            vel_marcha(1).Yp(i)     = velT5(1).Yp(index);
            vel_marcha(2).Yp(i)     = velT5(2).Yp(index);
        
            vel_marcha(1).thetaq(i) = velT5(1).thetaq(index);
            vel_marcha(2).thetaq(i) = velT5(2).thetaq(index);
        
            vel_marcha(1).thetaj(i) = velT5(1).thetaj(index);
            vel_marcha(2).thetaj(i) = velT5(2).thetaj(index);
        
            vel_marcha(1).thetat(i) = velT5(1).thetat(index);
            vel_marcha(2).thetat(i) = velT5(2).thetat(index);
    end
end    
% Procura pelo componente Popupmenu6 do UIcontrol pelo identificador 'Tag'
% para identificar a velocidade selecionada em velT6
pop6 = findobj('Tag','popvelT6');

% datapop6 = pop6.UserData obtém o valor da propriedade UserData que
% carrega a estrutura {source.UserData = datapop6} da funcao pop6_callback;
% datapop6 = struct('VT6',val)
datapop6 = pop6.UserData;

% Determina o passo de tempo a ser usado para constroir o vetor de tempo
% dependendo da velocidade selecionada em VelT6
    if datapop6.VT6 == 1
            delta_t = delta_t1;
        
    elseif datapop6.VT6 == 2
            delta_t = delta_t2;
        
    elseif datapop6.VT6 == 3
            delta_t = delta_t3;
            
    elseif datapop6.VT6 == 4 
            delta_t = delta_t4;
    else
            delta_t = 0;
    end
    
ciclo = length(velT1(1).tempo);

if datapop6.VT6 ~=0
    for i = (ciclos_T1+ciclos_T2+ciclos_T3+ciclos_T4+ciclos_T5)*ciclo + 1 : 1 :... 
            (ciclos_T1+ciclos_T2+ciclos_T3+ciclos_T4+ciclos_T5+ciclos_T6)*ciclo
          
          % Monta vetor de tempo da perna direita e perna esquerda na seccao 
          % de tempo T5. Continua a partir do vetor de tempo da seccao T4
            vel_marcha(1).tempo(i)  = vel_marcha(1).tempo(i-1) + delta_t;
            vel_marcha(2).tempo(i)  = vel_marcha(2).tempo(i-1) + delta_t;
            
            % operacao módulo devolve o resto da divisão. caso mod(i,ciclo)
            % seja 0, é porque estou considerando múltiplos de 100. Caso
            % contrario mod(i,ciclo) varia de 1 até 99. Vetores cíclicos
            if mod(i,ciclo) == 0
                index = ciclo;
            else
                index = mod(i,ciclo);
            end
            
            vel_marcha(1).Yq(i)     = velT6(1).Yq(index);
            vel_marcha(2).Yq(i)     = velT6(2).Yq(index);
        
            vel_marcha(1).Yj(i)     = velT6(1).Yj(index);
            vel_marcha(2).Yj(i)     = velT6(2).Yj(index);
        
            vel_marcha(1).Yt(i)     = velT6(1).Yt(index);
            vel_marcha(2).Yt(i)     = velT6(2).Yt(index);
        
            vel_marcha(1).Yp(i)     = velT6(1).Yp(index);
            vel_marcha(2).Yp(i)     = velT6(2).Yp(index);
        
            vel_marcha(1).thetaq(i) = velT6(1).thetaq(index);
            vel_marcha(2).thetaq(i) = velT6(2).thetaq(index);
        
            vel_marcha(1).thetaj(i) = velT6(1).thetaj(index);
            vel_marcha(2).thetaj(i) = velT6(2).thetaj(index);
        
            vel_marcha(1).thetat(i) = velT6(1).thetat(index);
            vel_marcha(2).thetat(i) = velT6(2).thetat(index);
    end
end
% Procura pelo componente Popupmenu7 do UIcontrol pelo identificador 'Tag'
% para identificar a velocidade selecionada em velT7
pop7 = findobj('Tag','popvelT7');

% datapop7 = pop7.UserData obtém o valor da propriedade UserData que
% carrega a estrutura {source.UserData = datapop7} da funcao pop7_callback;
% datapop7 = struct('VT7',val)
datapop7 = pop7.UserData;

% Determina o passo de tempo a ser usado para constroir o vetor de tempo
% dependendo da velocidade selecionada em VelT7
    if datapop7.VT7 == 1
            delta_t = delta_t1;
        
    elseif datapop7.VT7 == 2
            delta_t = delta_t2;
        
    elseif datapop7.VT7 == 3
            delta_t = delta_t3;
            
    elseif datapop7.VT7 == 4 
            delta_t = delta_t4;
    else
            delta_t = 0;
    end
    
ciclo = length(velT1(1).tempo);    

if datapop7.VT7 ~= 0
% Monta na estrutura vel_marcha os dados da estructura velT7 repetida o
% número de vezes definido por ciclos_T7

    for i = (ciclos_T1+ciclos_T2+ciclos_T3+ciclos_T4+ciclos_T5+ciclos_T6)*ciclo + 1 : 1 :... 
            (ciclos_T1+ciclos_T2+ciclos_T3+ciclos_T4+ciclos_T5+ciclos_T6+ciclos_T7)*ciclo
          
          % Monta vetor de tempo da perna direita e perna esquerda na seccao 
          % de tempo T7. Continua a partir do vetor de tempo da seccao T6
            vel_marcha(1).tempo(i)  = vel_marcha(1).tempo(i-1) + delta_t;
            vel_marcha(2).tempo(i)  = vel_marcha(2).tempo(i-1) + delta_t;
            
            % operacao módulo devolve o resto da divisão. caso mod(i,ciclo)
            % seja 0, é porque estou considerando múltiplos de 100. Caso
            % contrario mod(i,ciclo) varia de 1 até 99. Vetores cíclicos
            if mod(i,ciclo) == 0
                index = ciclo;
            else
                index = mod(i,ciclo);
            end
            
            vel_marcha(1).Yq(i)     = velT7(1).Yq(index);
            vel_marcha(2).Yq(i)     = velT7(2).Yq(index);
        
            vel_marcha(1).Yj(i)     = velT7(1).Yj(index);
            vel_marcha(2).Yj(i)     = velT7(2).Yj(index);
        
            vel_marcha(1).Yt(i)     = velT7(1).Yt(index);
            vel_marcha(2).Yt(i)     = velT7(2).Yt(index);
        
            vel_marcha(1).Yp(i)     = velT7(1).Yp(index);
            vel_marcha(2).Yp(i)     = velT7(2).Yp(index);
        
            vel_marcha(1).thetaq(i) = velT7(1).thetaq(index);
            vel_marcha(2).thetaq(i) = velT7(2).thetaq(index);
        
            vel_marcha(1).thetaj(i) = velT7(1).thetaj(index);
            vel_marcha(2).thetaj(i) = velT7(2).thetaj(index);
        
            vel_marcha(1).thetat(i) = velT7(1).thetat(index);
            vel_marcha(2).thetat(i) = velT7(2).thetat(index);
    end
end

% Procura pelo componente Popupmenu8 do UIcontrol pelo identificador 'Tag'
% para identificar a velocidade selecionada em velT8
pop8 = findobj('Tag','popvelT8');

% datapop8 = pop8.UserData obtém o valor da propriedade UserData que
% carrega a estrutura {source.UserData = datapop8} da funcao pop8_callback;
% datapop6 = struct('VT1',val)
datapop8 = pop8.UserData;

% Determina o passo de tempo a ser usado para constroir o vetor de tempo
% dependendo da velocidade selecionada em VelT8
    if datapop8.VT8 == 1
            delta_t = delta_t1;
        
    elseif datapop8.VT8 == 2
            delta_t = delta_t2;
        
    elseif datapop8.VT8 == 3
            delta_t = delta_t3;
            
    elseif datapop8.VT8 == 4 
            delta_t = delta_t4;
    else
            delta_t = 0;
    end
    
ciclo = length(velT1(1).tempo);     

if datapop8.VT8 ~= 0
% Monta na estrutura vel_marcha os dados da estructura velT8 repetida o
% número de vezes definido por ciclos_T8
    
    for i = (ciclos_T1+ciclos_T2+ciclos_T3+ciclos_T4+ciclos_T5+ciclos_T6+ciclos_T7)*ciclo + 1 : 1 :... 
            (ciclos_T1+ciclos_T2+ciclos_T3+ciclos_T4+ciclos_T5+ciclos_T6+ciclos_T7+ciclos_T8)*ciclo
          
          % Monta vetor de tempo da perna direita e perna esquerda na seccao 
          % de tempo T8. Continua a partir do vetor de tempo da seccao T7
            vel_marcha(1).tempo(i)  = vel_marcha(1).tempo(i-1) + delta_t;
            vel_marcha(2).tempo(i)  = vel_marcha(2).tempo(i-1) + delta_t;
            
            % operacao módulo devolve o resto da divisão. caso mod(i,ciclo)
            % seja 0, é porque estou considerando múltiplos de 100. Caso
            % contrario mod(i,ciclo) varia de 1 até 99. Vetores cíclicos
            if mod(i,ciclo) == 0
                index = ciclo;
            else
                index = mod(i,ciclo);
            end
            
            vel_marcha(1).Yq(i)     = velT8(1).Yq(index);
            vel_marcha(2).Yq(i)     = velT8(2).Yq(index);
        
            vel_marcha(1).Yj(i)     = velT8(1).Yj(index);
            vel_marcha(2).Yj(i)     = velT8(2).Yj(index);
        
            vel_marcha(1).Yt(i)     = velT8(1).Yt(index);
            vel_marcha(2).Yt(i)     = velT8(2).Yt(index);
        
            vel_marcha(1).Yp(i)     = velT8(1).Yp(index);
            vel_marcha(2).Yp(i)     = velT8(2).Yp(index);
        
            vel_marcha(1).thetaq(i) = velT8(1).thetaq(index);
            vel_marcha(2).thetaq(i) = velT8(2).thetaq(index);
        
            vel_marcha(1).thetaj(i) = velT8(1).thetaj(index);
            vel_marcha(2).thetaj(i) = velT8(2).thetaj(index);
        
            vel_marcha(1).thetat(i) = velT8(1).thetat(index);
            vel_marcha(2).thetat(i) = velT8(2).thetat(index);
    end
end

global ha1;
global ha2;
   
plot(ha1,vel_marcha(1).tempo, vel_marcha(1).thetaq,vel_marcha(1).tempo,...
              vel_marcha(1).thetaj,vel_marcha(1).tempo,vel_marcha(1).thetat,...
              'LineWidth',1.2);
xlabel(ha1,'[t]');
ylabel(ha1,'\theta_q,\theta_j,\theta_t');
% tit = title(ha1,'Ângulos das juntas da perna direita para a trajetória de marcha');
% tit.FontSize = 9;
lgd = legend(ha1,'\theta_q','\theta_j','\theta_t');
lgd.Title.FontSize = 9;
lgd.Location = 'northeastoutside';

%plot(ha,...), or any plotting function that takes an axes as its first 
% argument, also makes existing axes ha the current axes and displays the
% figure

plot(ha2,vel_marcha(1).tempo, vel_marcha(1).Yq,vel_marcha(1).tempo,vel_marcha(1).Yj,...
    vel_marcha(1).tempo,vel_marcha(1).Yt,vel_marcha(1).tempo,vel_marcha(1).Yp,...
    'LineWidth',1.2);
xlabel(ha2,'[t]');
ylabel(ha2,'Y_q,Y_j,Y_t,Y_p');
% tity = title(ha2,'Posicoes em Y das juntas da perna direita para a trajetória de marcha');
% tity.FontSize = 9;
lgdy = legend(ha2,'Y_q','Y_j','Y_t','Y_p');
lgdy.Title.FontSize = 9;
lgdy.Location = 'northeastoutside';
    
end