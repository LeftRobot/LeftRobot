function inclinaT4(source,eventdata)

global inc_T4;

%inclinacaoT4 = get(source,'String');
% str2double(get(hObject,'String')) returns contents of inclinacaoT3 as a double
inclinacaoT4 = source.String;
inc_T4 = str2double(inclinacaoT4);

    if isnan(inc_T4)
        errordlg('Inclinacao deve ser um valor numérico','Invalid Input','modal');
        uicontrol(source)
        return
    else
        disp(inc_T4);
    end

end