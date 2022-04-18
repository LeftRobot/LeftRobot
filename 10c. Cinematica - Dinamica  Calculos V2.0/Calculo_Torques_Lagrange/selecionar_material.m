function densidade = selecionar_material(material)

% Funcao para selecionar o material e a densidade a ser utilizada
% filename = '../Calculo_Torques_Lagrange/Lista de Materiais.xlsx';
filename = 'Lista de Materiais.xlsx';
folha = 'propriedades';
[~, ~, info] = xlsread(filename, folha);
[~, col] = find(strcmp(info, 'Densidade'));
densidade = info{2+material, col};
    
end