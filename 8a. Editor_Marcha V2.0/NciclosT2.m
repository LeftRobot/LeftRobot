function NciclosT2(source,eventdata)

global ciclos_T2;

%ncT1 = get(source,'String');
% str2double(get(hObject,'String')) returns contents of CiclosT1 as a double
ncT2 = source.String;
ciclos_T2 = str2double(ncT2);

if ciclos_T2 == 0
    errordlg('Número de ciclos deve ser maior do que 0','Invalid Input','modal');
    uicontrol(source)
    return
elseif isnan(ciclos_T2)
    errordlg('Número de ciclos deve ser valor numérico','Invalid Input','modal');
    uicontrol(source)
    return
else
    disp(ciclos_T2);
end

end