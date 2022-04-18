function inclinaT6(source,eventdata)

global inc_T6;

%inclinacaoT6 = get(source,'String');
% str2double(get(hObject,'String')) returns contents of inclinacaoT6 as a double
inclinacaoT6 = source.String;
inc_T6 = str2double(inclinacaoT6);

    if isnan(inc_T6)
        errordlg('Inclinacao deve ser um valor numérico','Invalid Input','modal');
        uicontrol(source)
        return
    else
        disp(inc_T6);
    end

end