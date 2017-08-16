s1=serial('COM4');
set(s1,'Baud',9600)
set(s1,'Terminator','CR')
set(s1,'StopBits',2)
fopen(s1)  

m=4;
a=100e-3; %mm
k=0.06; %40percent  
R=1; %mm
L=k*R^3/a^2; 
a=m*L; %wavelength 
Qs=((15.1/2)^2*pi*10)/60; %mm^3/s (Diameter/2 squared *pi* rate)/60
Co=0.4; %40 percent
deltaC=0.1; %allow 10 percent change in conc
Qfo=Qs*deltaC/(Co-deltaC);
Cmin=Co*Qs/(Qs+Qfo);

al=0.2;
T=(m*a*pi*R^2)/Qs*(1/(1+Qfo/Qs*al));

fprintf(s1,'MOD PRO')
pause(0.05)
fprintf(s1,'DIA A 15.100')
pause(0.05)
fprintf(s1,'DIA B 15.100')
pause(0.05)
fprintf(s1,'DIR INF')
pause(0.05)
fprintf(s1,'PAR ON')
pause(0.05)

t1=clock;
t2=0;
while (t2<180)

t2=etime(clock,t1);
fprintf(s1,'RAT A 10 MM')
pause(0.05)
fprintf(s1,'RAT B 0 MM')
pause(0.05)
fprintf(s1,'run')
pause((1-al)*T)
fprintf(s1,'RAT B 10 MM')
pause(0.05)
fprintf(s1,'RAT A 0 MM')
pause(0.05)
fprintf(s1,'run')
pause(al*T)
end


idn = fscanf(s1);
fclose(s1)
delete(s1)
clear s1 