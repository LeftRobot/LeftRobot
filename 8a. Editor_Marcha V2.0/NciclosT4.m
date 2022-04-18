function NciclosT4(source,eventdata)

global ciclos_T4;

%ncT4 = get(source,'String');
% str2double(get(hObject,'String')) returns contents of CiclosT3 as a double
ncT4 = source.String;
ciclos_T4 = str2double(ncT4);

if ciclos_T4 == 0
    errordlg('Número de ciclos deve ser maior do que 0','Invalid Input','modal');
    uicontrol(source)
    return
elseif isnan(ciclos_T4)
    errordlg('Número de ciclos deve ser valor numérico','Invalid Input','modal');
    uicontrol(source)
    return
else
    disp(ciclos_T4);
end

end