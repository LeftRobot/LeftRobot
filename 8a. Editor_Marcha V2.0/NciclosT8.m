function NciclosT8(source,eventdata)

global ciclos_T8;

%ncT8 = get(source,'String');
% str2double(get(hObject,'String')) returns contents of CiclosT8 as a double
ncT8 = source.String;
ciclos_T8 = str2double(ncT8);

if ciclos_T8 == 0
    errordlg('N�mero de ciclos deve ser maior do que 0','Invalid Input','modal');
    uicontrol(source)
    return
elseif isnan(ciclos_T8)
    errordlg('N�mero de ciclos deve ser valor num�rico','Invalid Input','modal');
    uicontrol(source)
    return
else
    disp(ciclos_T8);
end

end