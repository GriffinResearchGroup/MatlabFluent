% This script will read steady state report file data from a Fluent run,
% plot each coefficient vs iteration, and output the final values to the
% command window
clear

% Prompt user to select .txt file to work with
[FileName,PathName,FilterIndex] = uigetfile('*.txt');
% Change the working directory to where this file exists
cd(PathName)
dmg = "DS1";
test = regexp(PathName,filesep,'split');
test = char(test(end-1));
switch test
    case 'n15aoa'
        aoa = -15;
    case 'n10aoa'
        aoa = -10;
    case 'n05aoa'
        aoa = -5;
    case '00aoa'
        aoa = 0;
    case '05aoa'
        aoa = 5;
    case '10aoa'
        aoa = 10;
    case '15aoa'
        aoa = 15;
end
% Read the file contents, skipping header lines
Data = dlmread(FileName,' ',3,0);
% Move data into iteration, drag, lift, slip, pitch-mom, roll-mom, yaw-mom
Data = Data(:,[1 2 3 7 4 5 6]);
% Switch sign of slip, pitch-mom, and yaw-mom
% This is due to fluent having flipped coordinate system
flipped = 1;  %flag for flipped coordinate system
if flipped == 1
    Data(:,4) = -Data(:,4);
    Data(:,5) = -Data(:,5);
    Data(:,7) = -Data(:,7);
end
% Plot the data
f = figure;
plot(Data(:,1),Data(:,2),'k-o','DisplayName','CD')
hold on
plot(Data(:,1),Data(:,3),'b--+','DisplayName','CL')
plot(Data(:,1),Data(:,4),'r:*','DisplayName','Cy')
plot(Data(:,1),Data(:,5),'g-..','DisplayName','Cm')
plot(Data(:,1),Data(:,6),'m-x','DisplayName','Cl')
plot(Data(:,1),Data(:,7),'c--s','DisplayName','Cn')
xlabel('Iteration')
legend('Location','northeast')
%ylim([-3 3])
grid on
grid minor
ax = gca;
ax.FontSize = 24;
% Print final values of coefficients
% Get size of Data array
[row,col] = size(Data);
T = table(aoa,dmg,Data(row,2),Data(row,3),Data(row,4),Data(row,5),Data(row,6),Data(row,7),'VariableNames',{'aoa','damage','CD','CL','Cy','Cm','Cl','Cn'})
M = [aoa,dmg,Data(row,2),Data(row,3),Data(row,4),Data(row,5),Data(row,6),Data(row,7)];
writematrix(M,'G:\Shared drives\ONR\CFD\ANSYS\fluent\config2A_WT\v4\coefficients.txt','WriteMode','append','Delimiter','tab');