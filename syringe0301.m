clear
delete(instrfindall);
s1=serial('COM6');
set(s1,'Baud',9600)
set(s1,'Terminator','CR')
fopen(s1)  

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
fprintf(s1,'dia 15.10')
fprintf(s1,'ratei 1.00 ml/m')
t1=clock;
t2=0;

while (t2<100)
% t2=etime(clock,t1);
fprintf(s1,'run')
% pause(al*T)
% fprintf(s1,'stop')
% pause((1-al)*T)
end


idn = fscanf(s1);
fclose(s1)
delete(s1)
clear s1 