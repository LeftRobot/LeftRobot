function pop1_callback(source,eventdata)

global velT1;
% Obt�m todos os itens da Structure source no popup menu e os armazena na vari�vel str.
str = source.String; % -> str = get(source,'String');

% Obt�m o �ndice num�rico do item selecionado e o armazena na vari�vel val
val = source.Value;  % -> val = get(source,'Value');

% datapop1 � uma estrutura onde se armazena o valor val
datapop1 = struct('VT1',val);

% UserData � uma propriedade para compartilhar informa��es entre Callbacks
% de diferentes componentes do GUI
source.UserData = datapop1; % -> set(source,'UserData',datapop1)

panel1 = findobj('Tag','Panel1');
% Determina a velocidade da marcha  selecionada
    switch str{val}
        
        case '0.5 m/s'
        velT1 = Velocidade1();
        disp('velT1 = V1');
        panel1.BackgroundColor='cyan';
        
        case '1 m/s'
        velT1 = Velocidade2();
        disp('velT1 = V2');
        
        case '1.2 m/s'
        velT1 = Velocidade3();
        disp('velT1 = V3');
        
        case '1.5 m/s'
        velT1 = Velocidade4();
        disp('velT1 = V4');
    end
end