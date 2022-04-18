function pop7_callback(source,eventdata)

global velT7;

% Obt�m todos os itens da Structure source no popup menu e os armazena na vari�vel str.
str = source.String; % -> str = get(source,'String');

% Obt�m o �ndice num�rico do item selecionado e o armazena na vari�vel val
val = source.Value;  % -> val = get(source,'Value');

% datapop7 � uma estrutura onde se armazena o valor val
datapop7 = struct('VT7',val);

% UserData � uma propriedade para compartilhar informa��es entre Callbacks
% de diferentes componentes do GUI
source.UserData = datapop7; % -> set(source,'UserData',datapop7)


% global velocidade;

% Determina a velocidade da marcha  selecionada
    switch str{val}
        
        case '0.5 m/s'
        velT7 = Velocidade1();
        disp('velT7 = V1');
        
        case '1 m/s'
        velT7 = Velocidade2();
        disp('velT7 = V2');
        
        case '1.2 m/s'
        velT7 = Velocidade3();
        disp('velT7 = V3');
        
        case '1.5 m/s'
        velT7 = Velocidade4();
        disp('velT7 = V4');
    end
end