function inclinaT7(source,eventdata)

global inc_T7;

%inclinacaoT7 = get(source,'String');
% str2double(get(hObject,'String')) returns contents of inclinacaoT7 as a double
inclinacaoT7 = source.String;
inc_T7 = str2double(inclinacaoT7);

    if isnan(inc_T7)
        errordlg('Inclinacao deve ser um valor numérico','Invalid Input','modal');
        uicontrol(source)
        return
    else
        disp(inc_T7);
    end

end