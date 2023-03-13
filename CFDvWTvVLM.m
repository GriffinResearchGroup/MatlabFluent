% Script to plot CFD, WT, and VLM data
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
xlRange = 'A17:H23';
WTData = xlsread(FileName,1,xlRange);

% Read VLM results
% Data will be in the following order
% Aoa CD CL CY Cm Cl Cn L/D
xlRange = 'A7:H13';
VLMData = xlsread(FileName,4,xlRange);

% Plot coefficients vs alpha
for i=2:8
    figure;
    set(gcf, 'Position',  [5, 45, 1267, 950])
    plot(CFDData(:,1),CFDData(:,i),'b--o','LineWidth',2,'DisplayName','CFD')
    hold on
    plot(VLMData(:,1),VLMData(:,i),'r-.d','LineWidth',2,'DisplayName','VLM')
    plot(WTData(:,1),WTData(:,i),'k-s','LineWidth',2,'DisplayName','WT')
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
            saveas(gcf,'CFDvWTvVLM-CD.png')
        case 3
            ylabel('CL')
            legend('Location','southeast')
            saveas(gcf,'CFDvWTvVLM-CLL.png')
        case 4
            ylabel('CY')
            legend('Location','northeast')
            saveas(gcf,'CFDvWTvVLM-CY.png')
        case 5
            ylabel('Cm')
            legend('Location','northeast')
            saveas(gcf,'CFDvWTvVLM-Cm.png')
        case 6
            ylabel('Cl')
            legend('Location','southeast')
            saveas(gcf,'CFDvWTvVLM-Cl.png')
        case 7
            ylabel('Cn')
            legend('Location','southeast')
            saveas(gcf,'CFDvWTvVLM-Cn.png')
        case 8
            ylabel('L/D')
            legend('Location','southeast')
            saveas(gcf,'CFDvWTvVLM-L2D.png')
    end
end

% Plot drag polar in drag bucket style
figure
set(gcf, 'Position',  [5, 45, 1267, 950])
plot(CFDData(:,3),CFDData(:,2),'b--o','LineWidth',2,'DisplayName','CFD')
hold on
plot(VLMData(:,3),VLMData(:,2),'r-.d','LineWidth',2,'DisplayName','VLM')
plot(WTData(:,3),WTData(1:7,2),'k-s','LineWidth',2,'DisplayName','WT')
xlabel('CL')
ylabel('CD')
ax = gca;
ax.FontSize = 24;
ax.LineWidth = 1.5;
ylim([0 2])
grid on
grid minor
legend('Location','southeast')
saveas(gcf,'CFDvWTvVLM-dragpolar.png')