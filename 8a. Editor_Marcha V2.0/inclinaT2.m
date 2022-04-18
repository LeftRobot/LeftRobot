function inclinaT2(source,eventdata)

global inc_T2;

%inclinacaoT2 = get(source,'String');
% str2double(get(hObject,'String')) returns contents of inclinacaoT2 as a double
inclinacaoT2 = source.String;
inc_T2 = str2double(inclinacaoT2);

    if isnan(inc_T2)
        errordlg('Inclinacao deve ser um valor numérico','Invalid Input','modal');
        uicontrol(source)
        return
    else
        disp(inc_T2);
    end

end