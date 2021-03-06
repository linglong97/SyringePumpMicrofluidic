
%yellow
s1=serial('COM9');
set(s1,'Baud',9600)
set(s1,'Terminator','CR')
set(s1,'StopBits',1)
fopen(s1)  

%blue
s2=serial('COM8');
set(s2,'Baud',9600)
set(s2,'Terminator','CR')
set(s2,'StopBits',1)
fopen(s2)  

% rectangular channel aprox 2x4 mm (8mm^2), 120 cm long 
% 2 millileters / min good to prevent pressure overbuild
% 4:1 flow rate 

fprintf(s1,'mode i')
pause(0.20)
fprintf(s1,'dia 26.60')
pause(0.20)
fprintf(s1,'ratei 8 ml/m')
pause(0.20)
fprintf(s1,'run')
pause(0.20)

fprintf(s2,'mode i')
pause(0.20)
fprintf(s2,'dia 26.60')
pause(0.20)
fprintf(s2,'ratei 8 ml/m')
pause(0.20)
fprintf(s2,'run')
pause(0.20)

pause(120)


idn = fscanf(s2);
fclose(s2)
delete(s2)
clear s2 


idn = fscanf(s1);
fclose(s1)
delete(s1)
clear s1 