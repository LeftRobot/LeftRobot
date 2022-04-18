function inclinaT3(source,eventdata)

global inc_T3;

%inclinacaoT3 = get(source,'String');
% str2double(get(hObject,'String')) returns contents of inclinacaoT3 as a double
inclinacaoT3 = source.String;
inc_T3 = str2double(inclinacaoT3);

    if isnan(inc_T3)
        errordlg('Inclinacao deve ser um valor numérico','Invalid Input','modal');
        uicontrol(source)
        return
    else
        disp(inc_T3);
    end

end