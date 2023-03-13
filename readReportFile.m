% This script will parse a report file from ANSYS Fluent. Currently it can
% deal with unsteady or steady cases, and it will check to see if all
% coefficients were reported, or just drag, lift, and pitching moment.
% This is for coefficients reported in the global coordinate system.

clear

FileName = 'G:\Shared drives\ONR\CFD\ANSYS\fluent\config2A\WTscale\baseline\dev\M0.07-WT-D900001-R500-P500-Y500-16aoa\report-file.txt';
% Check file to see if it is unsteady data
filetext = fileread(FileName);
string = 'Time Step';
US = strfind(filetext,string);
% Read the CFD file contents
Data = readmatrix(FileName,'NumHeaderLines',3);
% count the number of columns to check what data I printed out
[rows,cols] = size(Data);
if isempty(US) % if steady data
    if cols == 4
        % plot results
        f = figure;           
        plot(Data(:,1),Data(:,2),'k-o','DisplayName','$C_D$')
        hold on
        plot(Data(:,1),Data(:,3),'b--+','DisplayName','$C_L$')
        plot(Data(:,1),Data(:,4),'g-..','DisplayName','$C_m$')
        x = xlabel('Iteration');
        l = legend('Location','best');
        grid on
        grid minor
        ax = gca;
        ax.FontSize = 16;
        x.FontSize = 20;
        l.FontSize = 20;
        set(l,'Interpreter','latex')
        %ylim([-inf 2])
    else
        % plot results
        f = figure;
        plot(Data(:,1),Data(:,2),'k-o','DisplayName','$C_D$')
        hold on
        plot(Data(:,1),Data(:,3),'b--+','DisplayName','$C_L$')
        plot(Data(:,1),Data(:,4),'g-.*','DisplayName','$C_m$')
        plot(Data(:,1),Data(:,5),'r-x','DisplayName','$C_l$')
        plot(Data(:,1),Data(:,6),'c--s','DisplayName','$C_n$')
        plot(Data(:,1),Data(:,7),'m-.^','DisplayName','$F_y$')
        x = xlabel('Iteration');
        l = legend('Location','best');
        grid on
        grid minor
        ax = gca;
        ax.FontSize = 16;
        x.FontSize = 20;
        l.FontSize = 20;
        set(l,'Interpreter','latex')
        % Calculate Drag and Lift coefficients
        alpha = 0;
        %CD = Data(:,3)*sind(alpha) + Data(:,2)*cosd(alpha);
        %CL = Data(:,3)*cosd(alpha) - Data(:,2)*sind(alpha);
    end
else % if unsteady data
    if cols == 5
        % Move data into timestep, time, drag, lift, pitch-mom
        Data = Data(:,[1 5 2 3 4]);
        % plot results
        f = figure;
        plot(Data(:,2),Data(:,3),'k-o','DisplayName','$C_D$')
        hold on
        plot(Data(:,2),Data(:,4),'b--+','DisplayName','$C_L$')
        plot(Data(:,2),Data(:,5),'g-..','DisplayName','$C_m$')
        x = xlabel('Time (s)');
        l = legend('Location','best');
        grid on
        grid minor
        ax = gca;
        ax.FontSize = 16;
        x.FontSize = 20;
        l.FontSize = 20;
        set(l,'Interpreter','latex')
    else
        % plot results
        f = figure;
        plot(Data(:,8),Data(:,2),'k-o','DisplayName','$C_D$')
        hold on
        plot(Data(:,8),Data(:,3),'b--+','DisplayName','$C_L$')
        plot(Data(:,8),Data(:,4),'g-.*','DisplayName','$C_m$')
        plot(Data(:,8),Data(:,5),'r-x','DisplayName','$C_l$')
        plot(Data(:,8),Data(:,6),'c--s','DisplayName','$C_n$')
        plot(Data(:,8),Data(:,7),'m-.^','DisplayName','$F_y$')
        x = xlabel('Time (s)');
        l = legend('Location','best');
        grid on
        grid minor
        ax = gca;
        ax.FontSize = 16;
        x.FontSize = 20;
        l.FontSize = 20;
        set(l,'Interpreter','latex')
        ylim([-10 10])
        % Calculate Drag and Lift coefficients
        alpha = 0;
        %CD = Data(:,3)*sind(alpha) + Data(:,2)*cosd(alpha);
        %CL = Data(:,3)*cosd(alpha) - Data(:,2)*sind(alpha);
    end
end

f.Position = [100 100 900 600];