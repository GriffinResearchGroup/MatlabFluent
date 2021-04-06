% Script to plot turbulent and unsteady laminar data
clear

% Read .xlxs file that contains data
% Prompt user to select .txt file to work with
[FileName,PathName,FilterIndex] = uigetfile('*.xlsx');
% Change the working directory to where this file exists
cd(PathName)

% Read the turbulent data
% Data will be in the following order
% Aoa CD CL CY Cm Cl Cn L/D
xlRange = 'A10:H12';
TBMData = xlsread(FileName,1,xlRange);

% Read unsteady laminar data
% Data will be in the following order
% Aoa CD CL CY Cm Cl Cn L/D
xlRange = 'A10:H12';
USLData = xlsread(FileName,3,xlRange);

% Plot coefficients vs alpha
for i=2:8
    figure;
    set(gcf, 'Position',  [5, 45, 1267, 950])
    plot(TBMData(:,1),TBMData(:,i),'k-o','LineWidth',2,'DisplayName','Turbulence Model')
    hold on
    plot(USLData(:,1),USLData(:,i),'b--s','LineWidth',2,'DisplayName','Unsteady Laminar')
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
            %saveas(gcf,'NOMvDS-CD.png')
        case 3
            ylabel('CL')
            legend('Location','southeast')
            %saveas(gcf,'NOMvDS-CLL.png')
        case 4
            ylabel('CY')
            legend('Location','southeast')
            %saveas(gcf,'NOMvDS-CY.png')
        case 5
            ylabel('Cm')
            legend('Location','northeast')
            %saveas(gcf,'NOMvDS-Cm.png')
        case 6
            ylabel('Cl')
            legend('Location','southeast')
            %saveas(gcf,'NOMvDS-Cl.png')
        case 7
            ylabel('Cn')
            legend('Location','northeast')
            %saveas(gcf,'NOMvDS-Cn.png')
        case 8
            ylabel('L/D')
            legend('Location','southeast')
            %saveas(gcf,'NOMvDS-L2D.png')
    end
end

% Plot drag polar in drag bucket style
figure
set(gcf, 'Position',  [5, 45, 1267, 950])
plot(TBMData(:,3),TBMData(:,2),'k-o','LineWidth',2,'DisplayName','Turbulence Model')
hold on
plot(USLData(:,3),USLData(:,2),'b--s','LineWidth',2,'DisplayName','Unsteady Laminar')
xlabel('CL')
ylabel('CD')
ax = gca;
ax.FontSize = 24;
ax.LineWidth = 1.5;
%xlim([0 inf])
ylim([0 2])
grid on
grid minor
legend('Location','southeast')
%saveas(gcf,'NOMvDS-dragpolar.png')