function pop4_callback(source,eventdata)

global velT4;

% Obt?m todos os itens da Structure source no popup menu e os armazena na vari?vel str.
str = source.String; % str = get(source,'String');

% Obt?m o ?ndice num?rico do item selecionado e o armazena na vari?vel val
val = source.Value;  % val = get(source,'Value');

% datapop4 ? uma estrutura onde se armazena o valor val
datapop4 = struct('VT4',val);

% UserData ? uma propriedade para compartilhar informa??es entre Callbacks
% de diferentes componentes do GUI
source.UserData = datapop4; % -> set(source,'UserData',datapop1)

% global velocidade;

% Determina a velocidade da marcha  selecionada
    switch str{val}
        
        case '0.5 m/s'
        velT4 = Velocidade1();
        disp('velT4 = V1');
        
        case '1 m/s'
        velT4 = Velocidade2();
        disp('velT4 = V2');
        
        case '1.2 m/s'
        velT4 = Velocidade3();
        disp('velT4 = V3');
        
        case '1.5 m/s'
        velT4 = Velocidade4();
        disp('velT4 = V4');
    end
end