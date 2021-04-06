clear
% Prompt user to select .txt file to work with
[FileName,PathName,FilterIndex] = uigetfile('*.txt');
% Change the working directory to where this file exists
cd(PathName)
% Read the CFD file contents
Data = dlmread(FileName,' ',3,0);
% Move data into timestep, time, drag, lift, slip, pitch-mom, roll-mom, yaw-mom
Data = Data(:,[1 8 2 3 7 4 5 6]);
Data(:,6) = -Data(:,6);
f = figure;
plot(Data(:,2),Data(:,3),'k-o','DisplayName','CD')
hold on
plot(Data(:,2),Data(:,4),'b--+','DisplayName','CL')
plot(Data(:,2),Data(:,5),'r:*','DisplayName','CY')
plot(Data(:,2),Data(:,6),'g-..','DisplayName','Cm')
plot(Data(:,2),Data(:,7),'m-x','DisplayName','Cl')
plot(Data(:,2),Data(:,8),'c--s','DisplayName','Cn')
xlabel('Time (s)')
legend('Location','northeast')
grid on
ax = gca;
ax.FontSize = 24;

% Average after some time
prompt = 'Enter start time for average: ';
tAvg = input(prompt);
row = find(Data(:,2) == tAvg);
[rows,cols] = size(Data);
avgData = mean(Data(row:rows,:));
%avgData = mean(Data);
T = table(avgData(:,3),avgData(:,4),avgData(:,5),avgData(:,6),avgData(:,7),avgData(:,8),'VariableNames',{'CD','CL','CY','Cm','Cl','Cn'})