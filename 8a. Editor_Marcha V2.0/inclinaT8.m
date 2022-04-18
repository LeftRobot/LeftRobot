function inclinaT8(source,eventdata)

global inc_T8;

%inclinacaoT8 = get(source,'String');
% str2double(get(hObject,'String')) returns contents of inclinacaoT8 as a double
inclinacaoT8 = source.String;
inc_T8 = str2double(inclinacaoT8);

    if isnan(inc_T8)
        errordlg('Inclinacao deve ser um valor numérico','Invalid Input','modal');
        uicontrol(source)
        return
    else
        disp(inc_T8);
    end

end