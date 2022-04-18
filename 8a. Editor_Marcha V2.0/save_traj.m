function save_traj(source,eventdata)
global vel_marcha;

Trajetoria = vel_marcha;
save('ArquivoTrajetoria.mat','Trajetoria');
end