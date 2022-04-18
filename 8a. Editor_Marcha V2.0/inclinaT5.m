function inclinaT5(source,eventdata)

global inc_T5;

%inclinacaoT5 = get(source,'String');
% str2double(get(hObject,'String')) returns contents of inclinacaoT5 as a double
inclinacaoT5 = source.String;
inc_T5 = str2double(inclinacaoT5);

    if isnan(inc_T5)
        errordlg('Inclinacao deve ser um valor numérico','Invalid Input','modal');
        uicontrol(source)
        return
    else
        disp(inc_T5);
    end

end