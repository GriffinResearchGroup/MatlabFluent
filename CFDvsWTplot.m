% Script to plot CFD and WT data
clear

% Read .xlxs file that contains data
% Prompt user to select .txt file to work with
[FileName,PathName,FilterIndex] = uigetfile('*.xlsx');
% Change the working directory to where this file exists
cd(PathName)

% Read the CFD file contents
% Data will be in the following order
% Aoa CD CL CY Cm Cl Cn L/D
xlRange = 'A7:H13';
CFDData = xlsread(FileName,1,xlRange);

% Read Wind Tunnel data
% Data will be in the following order
% Aoa CD CL CY Cm Cl Cn L/D
% This particular data set has 4 replicates
xlRange = 'A17:H44';
WTData = xlsread(FileName,1,xlRange);

% Plot coefficients vs alpha
for i=2:8
    figure;
    set(gcf, 'Position',  [5, 45, 1267, 950])
    plot(CFDData(:,1),CFDData(:,i),'b--o','LineWidth',2,'DisplayName','CFD')
    hold on
    plot(WTData(1:7,1),WTData(1:7,i),'k-s','LineWidth',2,'DisplayName','WT')
    plot(WTData(8:14,1),WTData(8:14,i),'k-s','LineWidth',2,'HandleVisibility','off')
    plot(WTData(15:21,1),WTData(15:21,i),'k-s','LineWidth',2,'HandleVisibility','off')
    plot(WTData(22:28,1),WTData(22:28,i),'k-s','LineWidth',2,'HandleVisibility','off')
    xlabel('alpha (deg)')
    grid on
    grid minor
    ax = gca;
    ax.FontSize = 24;
    ax.LineWidth = 1.5;
    switch i
        case 2
            ylabel('CD')
            legend('Location','southeast')
            ylim([0 2])
            %saveas(gcf,'CFDvWT-CD.png')
        case 3
            ylabel('CL')
            legend('Location','southeast')
            %saveas(gcf,'CFDvWT-CLL.png')
        case 4
            ylabel('CY')
            legend('Location','northeast')
            %saveas(gcf,'CFDvWT-CY.png')
        case 5
            ylabel('Cm')
            legend('Location','northeast')
            %saveas(gcf,'CFDvWT-Cm.png')
        case 6
            ylabel('Cl')
            legend('Location','southeast')
            %saveas(gcf,'CFDvWT-Cl.png')
        case 7
            ylabel('Cn')
            legend('Location','southeast')
            %saveas(gcf,'CFDvWT-Cn.png')
        case 8
            ylabel('L/D')
            legend('Location','southeast')
            %saveas(gcf,'CFDvWT-L2D.png')
    end
end

% Plot drag polar in drag bucket style
figure
set(gcf, 'Position',  [5, 45, 1267, 950])
plot(CFDData(:,2),CFDData(:,3),'b--o','LineWidth',2,'DisplayName','CFD')
hold on
plot(WTData(1:7,2),WTData(1:7,3),'k-s','LineWidth',2,'DisplayName','WT')
plot(WTData(8:14,2),WTData(8:14,3),'k-s','LineWidth',2,'HandleVisibility','off')
plot(WTData(15:21,2),WTData(15:21,3),'k-s','LineWidth',2,'HandleVisibility','off')
plot(WTData(22:28,2),WTData(22:28,3),'k-s','LineWidth',2,'HandleVisibility','off')
xlabel('CD')
ylabel('CL')
ax = gca;
ax.FontSize = 24;
ax.LineWidth = 1.5;
xlim([0 2])
grid on
grid minor
legend('Location','southeast')
%saveas(gcf,'CFDvWT-dragpolar.png')