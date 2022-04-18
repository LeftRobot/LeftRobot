function NciclosT1(source,eventdata)

global ciclos_T1;

%ncT1 = get(source,'String');
% str2double(get(hObject,'String')) returns contents of CiclosT1 as a double
ncT1 = source.String;
ciclos_T1 = str2double(ncT1);

if ciclos_T1 == 0
    errordlg('N�mero de ciclos deve ser maior do que 0','Invalid Input','modal');
    uicontrol(source)
    return
elseif isnan(ciclos_T1)
    errordlg('N�mero de ciclos deve ser valor num�rico','Invalid Input','modal');
    uicontrol(source)
    return
else
    disp(ciclos_T1);
end

end