clear
delete(instrfindall);
s1=serial('COM6');
set(s1,'Baud',9600)
set(s1,'Terminator','CR')
set(s1,'StopBits',2)
fopen(s1)  
 % we note that the flow rate of the pressure controllers is
 % voltage*20mL/3 minutes
 % 
m=4;
a=100e-3; %mm
k=0.06; %40percent  
R=1; %mm
L=k*R^3/a^2; 
a=m*L; %wavelength 
Qs=2*1000/60; %mm^3/s
func=1; %just amplitude of 1 for now 
Co=0.4; %40 percent
deltaC=0.1; %allow 10 percent change in conc
Qfo=Qs*deltaC/(Co-deltaC);
Cmin=Co*Qs/(Qs+Qfo);

al=0.2;
T=(m*a*pi*R^2)/Qs*(1/(1+Qfo/Qs*al));


fprintf(s1,'mode i')
fprintf(s1,'mode con')
fprintf(s1,'dia 8.5')
fprintf(s1,'ratei 9.50 ml/m')

 
 %%
t1=clock;
 t2=0;
while (t2<10000)
% t2=etime(clock,t1);
fprintf(s1,'run')

pause(al*T)
fprintf(s1,'stop')
pause((1-al)*T)
end
% idn = fscanf(s1);
% printf(idn)
% % 
% idn = fscanf(s1);
% printf(idn)
% % fclose(s1)
% delete(s1)
% clear s1 
%% actual section
s = daq.createSession('ni');

addAnalogOutputChannel(s,'Dev3',0:1,'Voltage');
addAnalogOutputChannel(s, 'Dev4', 0:1, 'Voltage');


d = daq.getDevices


t1 = clock;
t2 = 0
while (t2 < 10000)
fprintf(s1,'REV')


fprintf(s1,'STP')

end    