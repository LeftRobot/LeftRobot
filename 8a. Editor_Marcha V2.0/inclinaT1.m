function inclinaT1(source,eventdata)

global inc_T1;

%ncT1 = get(source,'String');
% str2double(get(hObject,'String')) returns contents of CiclosT1 as a double
inclinacaoT1 = source.String;
inc_T1 = str2double(inclinacaoT1);

    if isnan(inc_T1)
        errordlg('Inclinacao deve ser um valor numérico','Invalid Input','modal');
        uicontrol(source)
        return
    else
        disp(inc_T1);
    end

end