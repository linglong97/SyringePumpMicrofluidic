s1=serial('COM6');
set(s1,'Baud',9600)
set(s1,'Terminator','CR')
set(s1,'StopBits',2)
fopen(s1)  

m=10;
a=100e-3; %mm
k=0.06; %40percent  
R=1; %mm
L=k*R^3/a^2; 
wl=m*L; %wavelength 
Qs=2*1000/60; %mm^3/s
func=1; %just amplitude of 1 for now 
Co=0.4; %40 percent
deltaC=0.15; %allow 15 percent change in conc
Qfo=Qs*deltaC/(Co-deltaC);
Cmin=Co*Qs/(Qs+Qfo);

al=0.2;
T=((m*wl*pi*R^2)/Qs)*(1/(1+(Qfo/Qs)*al));



fprintf(s1,'MOD PRO')
pause(0.05)
fprintf(s1,'DIA A 21.600')
pause(0.05)
fprintf(s1,'DIA B 21.600')
pause(0.05)
fprintf(s1,'DIR INF')
pause(0.05)
fprintf(s1,'PAR ON')
pause(0.05)
fprintf(s1,'RAT A 2 MM')
pause(0.05)
fprintf(s1,'RAT B 0 MM')
pause(0.05)
fprintf(s1,'RUN')
pause(0.05)

t1=clock;
t2=0;
while (t2<840)
t2=etime(clock,t1);
fprintf(s1,'RAT B 2 MM')
pause(al*T)
fprintf(s1,'RAT B 0 MM')
pause((1-al)*T)
end

fprintf(s1,'stp')

idn = fscanf(s1);
fclose(s1)
delete(s1)
clear s1 
