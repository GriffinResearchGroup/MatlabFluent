% This script will parse a report file from ANSYS Fluent. Currently it can
% deal with unsteady or steady cases, and it will check to see if all
% coefficients were reported, or just drag, lift, and pitching moment.
% This is for coefficients reported in the global coordinate system.

clear

% Read the report file contents into a table
Directory = 'G:\My Drive\Research\Active\ONR\CFD\Config1_NASA\Fluent\alpha_v1\WT-M2.36-T9-p20\';
FileName = 'report-file.txt';
reportFile = append(Directory,FileName);
Data = readtable(reportFile,'VariableNamingRule','preserve');

% Check file to see if it is unsteady data
filetext = fileread(reportFile);
string = 'Time Step';
US = strfind(filetext,string);
% count the number of columns to check what force/moment monitors were
% recorded
[rows,cols] = size(Data);

% Figure options
width = 9;      % Width in inches
height = 8;     % Height in inches
alw = 0.75;     % Axes line width
fsz = 14;       % Font size
lw = 1.5;       % Line width
msz = 8;        % Marker size

% Six colors to loop through
% colors = ["#0072BD", "#D95319", "#EDB120", 	"#7E2F8E", 	"#77AC30", 	"#77AC30"];
% Create vectors of markers and linestyles for plotting in the loops
% markers = 'o+*xsd^v><ph';
% lines = {'-', '--', ':', '-.', '-', '--', ':', '-.'};

figure
set(gcf, 'Position', [100 100 width*100, height*100]);
set(gca, 'FontSize', fsz, 'LineWidth', alw);
hold on

if isempty(US) % if steady data
    if cols == 4
        % plot results        
        plot(Data{:,1},Data{:,2},'k-o','DisplayName','$C_D$', 'LineWidth',lw)
        plot(Data{:,1},Data{:,3},'b--+','DisplayName','$C_L$', 'LineWidth',lw)
        plot(Data{:,1},Data{:,4},'g-..','DisplayName','$C_m$', 'LineWidth',lw)
        x = xlabel('Iteration');
        l = legend('Location','best','Interpreter','latex','FontSize',fsz);
        grid on
        grid minor
        %ylim([-inf 2])
    else
        % plot results
        plot(Data{:,1},Data{:,2},'k-o','DisplayName','$C_D$', 'LineWidth',lw)
        plot(Data{:,1},Data{:,3},'b--+','DisplayName','$C_L$', 'LineWidth',lw)
        plot(Data{:,1},Data{:,4},'g-.*','DisplayName','$C_m$', 'LineWidth',lw)
        plot(Data{:,1},Data{:,5},'r-x','DisplayName','$C_l$', 'LineWidth',lw)
        plot(Data{:,1},Data{:,6},'c--s','DisplayName','$C_n$', 'LineWidth',lw)
        plot(Data{:,1},Data{:,7},'m-.^','DisplayName','$F_y$', 'LineWidth',lw)
        x = xlabel('Iteration');
        l = legend('Location','best','Interpreter','latex','FontSize',fsz);
        grid on
        grid minor
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
        plot(Data{:,2},Data{:,3},'k-o','DisplayName','$C_D$', 'LineWidth',lw)
        plot(Data{:,2},Data{:,4},'b--+','DisplayName','$C_L$', 'LineWidth',lw)
        plot(Data{:,2},Data{:,5},'g-..','DisplayName','$C_m$', 'LineWidth',lw)
        x = xlabel('Time (s)');
        l = legend('Location','best','Interpreter','latex','FontSize',fsz);
        grid on
        grid minor
    else
        % plot results
        plot(Data{:,8},Data{:,2},'k-o','DisplayName','$C_D$', 'LineWidth',lw)
        plot(Data{:,8},Data{:,3},'b--+','DisplayName','$C_L$', 'LineWidth',lw)
        plot(Data{:,8},Data{:,4},'g-.*','DisplayName','$C_m$', 'LineWidth',lw)
        plot(Data{:,8},Data{:,5},'r-x','DisplayName','$C_l$', 'LineWidth',lw)
        plot(Data{:,8},Data{:,6},'c--s','DisplayName','$C_n$', 'LineWidth',lw)
        plot(Data{:,8},Data{:,7},'m-.^','DisplayName','$F_y$', 'LineWidth',lw)
        x = xlabel('Time (s)');
        l = legend('Location','best','Interpreter','latex','FontSize',fsz);
        grid on
        grid minor
        ylim([-10 10])
        % Calculate Drag and Lift coefficients
        alpha = 0;
        %CD = Data(:,3)*sind(alpha) + Data(:,2)*cosd(alpha);
        %CL = Data(:,3)*cosd(alpha) - Data(:,2)*sind(alpha);
    end
end