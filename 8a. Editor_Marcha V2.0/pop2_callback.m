function pop2_callback(source,eventdata)

global velT2;

% Obt�m todos os itens da Structure source no popup menu e os armazena na vari�vel str.
str = source.String; %-> str = get(source,'String');

% Obt�m o �ndice num�rico do item selecionado e o armazena na vari�vel val
val = source.Value;  %-> val = get(source,'Value');

% datapop2 � uma estrutura onde se armazena o valor val
datapop2 = struct('VT2',val);

% UserData � uma propriedade para compartilhar informa��es entre Callbacks
% de diferentes componentes do GUI
source.UserData = datapop2; % -> set(source,'UserData',datapop1)

% global velocidade;

% Determina a velocidade da marcha  selecionada
    switch str{val}
        
        case '0.5 m/s'
        velT2 = Velocidade1();
        disp('velT2 = V1');
        
        case '1 m/s'
        velT2 = Velocidade2();
        disp('velT2 = V2');
        
        case '1.2 m/s'
        velT2 = Velocidade3();
        disp('velT2 = V3');
        
        case '1.5 m/s'
        velT2 = Velocidade4();
        disp('velT2 = V4');
    end
end