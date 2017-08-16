clc
clear
close all

s = daq.createSession('ni');

addAnalogOutputChannel(s,'Dev3',0:1,'Voltage');
addAnalogOutputChannel(s, 'Dev4', 0:1, 'Voltage');
d = daq.getDevices

%%

outputSingleScan(s,[0 0 0 0]);


%%

outputSingleScan(s,[0 0 0 0]);

P_N = 0;
P_S = 0;
P_E = 0;
P_W = 0;


%% GUI


h=figure(10); set(h,'units','normalized','outerposition',[0 0 1 1]);

h1 = axes('Parent',h,'Units','normalized','Position',[0.5 0.22 0.45 .72]);axis off;


 MC_panel=uipanel('Parent',h,'Title','Manual Control','background','white','FontSize',10,'Position',[0.03 .55 .4 .35]);

S_N=uicontrol('Parent',MC_panel,'units','normalized','position',[0.05,0.75,0.9,0.05],'style','slider','Min',0.0,'Max',5.0,'value',P_N);
Max_N=uicontrol('Parent',MC_panel,'units','normalized','position',[0.92,0.7,0.05,0.04],'style','text','string','5.0');
Min_N=uicontrol('Parent',MC_panel,'units','normalized','position',[0.025,0.7,0.05,0.04],'style','text','string','0.0');
North_string =uicontrol('Parent',MC_panel,'units','normalized','position',[0.45,0.85,0.05,0.04],'style','text','string','North');
St_N=uicontrol('Parent',MC_panel,'units','normalized','position',[0.55,0.85,0.05,0.04],'style','text','String',num2str(get(S_N,'value')));

S_S=uicontrol('Parent',MC_panel,'units','normalized','position',[0.05,0.55,0.9,0.05],'style','slider','Min',0.0,'Max',5.0,'value',P_S);
Max_S=uicontrol('Parent',MC_panel,'units','normalized','position',[0.92,0.5,0.05,0.04],'style','text','string','5.0');
Min_S=uicontrol('Parent',MC_panel,'units','normalized','position',[0.025,0.5,0.05,0.04],'style','text','string','0.0');
South_string =uicontrol('Parent',MC_panel,'units','normalized','position',[0.45,0.65,0.05,0.04],'style','text','string','South');
St_S=uicontrol('Parent',MC_panel,'units','normalized','position',[0.55,0.65,0.05,0.04],'style','text','String',num2str(get(S_S,'value')));


S_E=uicontrol('Parent',MC_panel,'units','normalized','position',[0.05,0.35,0.9,0.05],'style','slider','Min',0.0,'Max',5.0,'value',P_E);
Max_E=uicontrol('Parent',MC_panel,'units','normalized','position',[0.92,0.3,0.05,0.04],'style','text','string','5.0');
Min_E=uicontrol('Parent',MC_panel,'units','normalized','position',[0.025,0.3,0.05,0.04],'style','text','string','0.0');
East_string =uicontrol('Parent',MC_panel,'units','normalized','position',[0.45,0.45,0.05,0.04],'style','text','string','East');
St_E=uicontrol('Parent',MC_panel,'units','normalized','position',[0.55,0.45,0.05,0.04],'style','text','String',num2str(get(S_E,'value')));

S_W=uicontrol('Parent',MC_panel,'units','normalized','position',[0.05,0.15,0.9,0.05],'style','slider','Min',0.0,'Max',5.0,'value',P_W);
Max_W=uicontrol('Parent',MC_panel,'units','normalized','position',[0.92,0.1,0.05,0.04],'style','text','string','5.0');
Min_W=uicontrol('Parent',MC_panel,'units','normalized','position',[0.025,0.1,0.05,0.04],'style','text','string','0.0');
West_string =uicontrol('Parent',MC_panel,'units','normalized','position',[0.45,0.25,0.05,0.04],'style','text','string','West');
St_W=uicontrol('Parent',MC_panel,'units','normalized','position',[0.55,0.25,0.05,0.04],'style','text','String',num2str(get(S_W,'value')));

%% main loop, initialises the syringe pump as well

delete(instrfindall);
    s1=serial('COM6');
    set(s1,'Baud',9600)
    set(s1,'Terminator','CR')
    set(s1,'StopBits',2)
    fopen(s1);
    pause(1)
    fprintf(s1, 'mode w');
    pause(1)
    fprintf(s1,'dia 14.5');
%     pause(1)
%     fprintf(s1, 'RAT 0.01 MM');
%     pause(0.1)
%     fprintf(s1, 'RFR 0.0001 MM');
%     pause(1)
%     fprintf(s1,'RUN');
pause(1)
    fprintf(s1, 'ratew 20.1 ml/h');
    pause(1)
    fprintf(s1, 'volw 11.000 ml');
    pause(1)
    fprintf(s1, 'run');
    pause(1)
    fprintf(s1, ['ratew ' sprintf('%0.3f', round(total, 3)) ' ml/h'])
    
while 1>0
   if
       run = 0
       fprintf(s1, 'run')
       
   
   pause(0.01)
            
            P_N = get(S_N,'value');set(St_N,'String',P_N);
            P_S = get(S_S,'value');set(St_S,'String',P_S);
            P_E = get(S_E,'value');set(St_E,'String',P_E);
            P_W = get(S_W,'value');set(St_W,'String',P_W);
            

            V1=P_N;
            V2=P_S;
            V3=P_E;
            V4=P_W;
            
            % s.outputSingleScan([V1,V2,V3,V4]); % set the voltages
            
             FE = V3; % flow rate in mLm
             FW = V4;
             total =(FE+FW)/2 % 
             % take the total output flow rate, suck that in
         
%              fprintf(s1,'RFR 5 MM');
                    
            
            fprintf(s1, ['ratew ' sprintf('%0.1f', round(60*total, 1)) ' ml/h'])
            
      
            
            
     
end


fprintf(s1, 'stop')

% %% just testing syringe pump
%     delete(instrfindall);
%     s1=serial('COM6');
%     set(s1,'Baud',9600)
%     set(s1,'Terminator','CR')
%     set(s1,'StopBits',2)
%     fopen(s1);  
%     fprintf(s1,'DIA 14.5');
%     fprintf(s1, 'RAT 70 MH');
%     fprintf(s1, 'RFR 0.0001 MM'); % initialise with very low rate, but not 0
%     fprintf(s1,'RUN');
%     
% while 1>0
%     
%     fprintf(s1,'RUN');
%     
%    
% end


