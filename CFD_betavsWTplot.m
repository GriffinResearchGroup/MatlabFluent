% Script to plot CFD and WT data
clear

% Read .xlxs file that contains data
% Prompt user to select .txt file to work with
%[FileName,PathName,FilterIndex] = uigetfile('*.xlsx');
% Change the working directory to where this file exists
%cd(PathName)

% Read the CFD file contents
% Data will be in the following order
% Aoa Beta CD CL Cy Cm Cl Cn L/D
FileName = 'G:\Shared drives\ONR\CFD\ANSYS\fluent\config2A_WT_full\aoa_sweep_WT.xlsx';
xlRange = 'A7:I55';
CFDData = readtable(FileName,'Range',xlRange,'Sheet','RollSweep_BetaN3');
CFDData.Properties.VariableNames = {'AoA' 'Phi' 'CD' 'CL' 'Cy' 'Cm' 'Cl' 'Cn' 'L/D'};

% Read Wind Tunnel data
% Data will be in the following order
% Aoa CD CL Cy Cm Cl Cn L/D
% This particular data set has 4 replicates
xlRange = 'A17:H23';
WTData = readtable(FileName,'Range',xlRange,'Sheet','Nominal Geometry');
WTData.Properties.VariableNames = {'AoA' 'CD' 'CL' 'Cy' 'Cm' 'Cl' 'Cn' 'L/D'};

% Plot coefficients vs alpha for each beta series
for i=3:8
    figure;
    set(gcf, 'Position',  [5, 45, 1267, 950])
    for j = -3:3
        rows = CFDData.Phi == j;
        data = CFDData(rows,:);
        str = num2str(j);
        dispName = "CFD Phi = " + str + " \circ";
        plot(data{:,1},data{:,i+1},'--o','LineWidth',2,'DisplayName',dispName)
        hold on
    end
    plot(WTData{:,1},WTData{:,i},'k-s','LineWidth',2,'DisplayName','WT')
    xlabel('alpha (deg)')
    grid on
    grid minor
    ax = gca;
    ax.FontSize = 24;
    ax.LineWidth = 1.5;
    switch i
        case 2
            ylabel('CD')
            legend('Location','northeastoutside')
            ylim([0 2])
            %saveas(gcf,'CFDvWT-CD.png')
        case 3
            ylabel('CL')
            legend('Location','northeastoutside')
            %saveas(gcf,'CFDvWT-CLL.png')
        case 4
            ylabel('Cy')
            legend('Location','northeastoutside')
            %saveas(gcf,'CFDvWT-CY.png')
        case 5
            ylabel('Cm')
            legend('Location','northeastoutside')
            %saveas(gcf,'CFDvWT-Cm.png')
        case 6
            ylabel('Cl')
            legend('Location','northeastoutside')
            %saveas(gcf,'CFDvWT-Cl.png')
        case 7
            ylabel('Cn')
            legend('Location','northeastoutside')
            %saveas(gcf,'CFDvWT-Cn.png')
        case 8
            ylabel('L/D')
            legend('Location','northeastoutside')
            %saveas(gcf,'CFDvWT-L2D.png')
    end
end

% Plot drag polar in drag bucket style
figure
set(gcf, 'Position',  [5, 45, 1267, 950])
for j = -3:3
    rows = CFDData.Phi == j;
    data = CFDData(rows,:);
    str = num2str(j);
    dispName = "CFD Phi = " + str + " \circ";
    plot(data{:,4},data{:,3},'--o','LineWidth',2,'DisplayName',dispName)
    hold on
end
plot(WTData{:,3},WTData{:,2},'k-s','LineWidth',2,'DisplayName','WT')
hold on
xlabel('CD')
ylabel('CL')
ax = gca;
ax.FontSize = 24;
ax.LineWidth = 1.5;
xlim([-2 2])
grid on
grid minor
legend('Location','northeastoutside')
%saveas(gcf,'CFDvWT-dragpolar.png')