function pop8_callback(source,eventdata)

global velT8;

% Obtém todos os itens da Structure source no popup menu e os armazena na variável str.
str = source.String; % -> str = get(source,'String');

% Obtém o índice numérico do item selecionado e o armazena na variável val
val = source.Value;  % -> val = get(source,'Value');

% datapop8 é uma estrutura onde se armazena o valor val
datapop8 = struct('VT8',val);

% UserData é uma propriedade para compartilhar informações entre Callbacks
% de diferentes componentes do GUI
source.UserData = datapop8; % -> set(source,'UserData',datapop8)


% global velocidade;

% Determina a velocidade da marcha  selecionada
    switch str{val}
        
        case '0.5 m/s'
        velT8 = Velocidade1();
        disp('velT8 = V1');
        
        case '1 m/s'
        velT8 = Velocidade2();
        disp('velT8 = v2');
        
        case '1.2 m/s'
        velT8 = Velocidade3();
        disp('velT8 = V3');
        
        case '1.5 m/s'
        velT8 = Velocidade4();
        disp('velT8 = V4');
    end
end