function NciclosT7(source,eventdata)

global ciclos_T7;

%ncT7 = get(source,'String');
% str2double(get(hObject,'String')) returns contents of CiclosT7 as a double
ncT7 = source.String;
ciclos_T7 = str2double(ncT7);

if ciclos_T7 == 0
    errordlg('Número de ciclos deve ser maior do que 0','Invalid Input','modal');
    uicontrol(source)
    return
elseif isnan(ciclos_T7)
    errordlg('Número de ciclos deve ser valor numérico','Invalid Input','modal');
    uicontrol(source)
    return
else
    disp(ciclos_T7);
end

end