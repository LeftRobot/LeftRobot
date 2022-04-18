function NciclosT6(source,eventdata)

global ciclos_T6;

%ncT6 = get(source,'String');
% str2double(get(hObject,'String')) returns contents of CiclosT6 as a double
ncT6 = source.String;
ciclos_T6 = str2double(ncT6);

if ciclos_T6 == 0
    errordlg('N�mero de ciclos deve ser maior do que 0','Invalid Input','modal');
    uicontrol(source)
    return
elseif isnan(ciclos_T6)
    errordlg('N�mero de ciclos deve ser valor num�rico','Invalid Input','modal');
    uicontrol(source)
    return
else
    disp(ciclos_T6);
end

end