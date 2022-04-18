function NciclosT3(source,eventdata)

global ciclos_T3;

%ncT3 = get(source,'String');
% str2double(get(hObject,'String')) returns contents of CiclosT3 as a double
ncT3 = source.String;
ciclos_T3 = str2double(ncT3);

if ciclos_T3 == 0
    errordlg('Número de ciclos deve ser maior do que 0','Invalid Input','modal');
    uicontrol(source)
    return
elseif isnan(ciclos_T3)
    errordlg('Número de ciclos deve ser valor numérico','Invalid Input','modal');
    uicontrol(source)
    return
else
    disp(ciclos_T3);
end

end