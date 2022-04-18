function NciclosT5(source,eventdata)

global ciclos_T5;

%ncT5 = get(source,'String');
% str2double(get(hObject,'String')) returns contents of CiclosT5 as a double
ncT5 = source.String;
ciclos_T5 = str2double(ncT5);

if ciclos_T5 == 0
    errordlg('Número de ciclos deve ser maior do que 0','Invalid Input','modal');
    uicontrol(source)
    return
elseif isnan(ciclos_T5)
    errordlg('Número de ciclos deve ser valor numérico','Invalid Input','modal');
    uicontrol(source)
    return
else
    disp(ciclos_T5);
end

end