% Script to plot CFD and WT data
clear

% Read .xlxs file that contains data
% Prompt user to select .txt file to work with
[FileName,PathName,FilterIndex] = uigetfile('*.xlsx');
% Change the working directory to where this file exists
cd(PathName)

% Read CFD DS01 data
% Data will be in the following order
% Aoa CD CL CY Cm Cl Cn L/D
% This particular data set has 4 replicates
xlRange = 'A7:H13';
CFDDS01Data = xlsread(FileName,2,xlRange);

% Read WT DS01 data
% Data will be in the following order
% Aoa CD CL CY Cm Cl Cn L/D
% This particular data set has 4 replicates
xlRange = 'A18:H24';
WTDS01Data = xlsread(FileName,2,xlRange);

% Read CFD DS02 data
% Data will be in the following order
% Aoa CD CL CY Cm Cl Cn L/D
xlRange = 'A32:H38';
CFDDS02Data = xlsread(FileName,2,xlRange);

% Read WT DS02 data
% Data will be in the following order
% Aoa CD CL CY Cm Cl Cn L/D
xlRange = 'A43:H49';
WTDS02Data = xlsread(FileName,2,xlRange);

% Read CFD DS04 data
% Data will be in the following order
% Aoa CD CL CY Cm Cl Cn L/D
xlRange = 'A57:H63';
CFDDS04Data = xlsread(FileName,2,xlRange);

% Read WT DS04 data
% Data will be in the following order
% Aoa CD CL CY Cm Cl Cn L/D
xlRange = 'A68:H74';
WTDS04Data = xlsread(FileName,2,xlRange);

% Plot coefficients vs alpha for DS01
for i=2:8
    figure;
    set(gcf, 'Position',  [5, 45, 1267, 950])
    plot(CFDDS01Data(:,1),CFDDS01Data(:,i),'b--s','LineWidth',2,'DisplayName','CFD')
    hold on
    plot(WTDS01Data(:,1),WTDS01Data(:,i),'k-o','LineWidth',2,'DisplayName','WT')
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
            saveas(gcf,'DS01-CD.png')
        case 3
            ylabel('CL')
            legend('Location','southeast')
            saveas(gcf,'DS01-CLL.png')
        case 4
            ylabel('CY')
            legend('Location','southeast')
            saveas(gcf,'DS01-CY.png')
        case 5
            ylabel('Cm')
            legend('Location','northeast')
            saveas(gcf,'DS01-Cm.png')
        case 6
            ylabel('Cl')
            legend('Location','southeast')
            saveas(gcf,'DS01-Cl.png')
        case 7
            ylabel('Cn')
            legend('Location','northeast')
            saveas(gcf,'DS01-Cn.png')
        case 8
            ylabel('L/D')
            legend('Location','southeast')
            saveas(gcf,'DS01-L2D.png')
    end
end

% Plot drag polar in drag bucket style
figure
set(gcf, 'Position',  [5, 45, 1267, 950])
plot(CFDDS01Data(:,3),CFDDS01Data(:,2),'b--s','LineWidth',2,'DisplayName','CFD')
hold on
plot(WTDS01Data(:,3),WTDS01Data(:,2),'k-o','LineWidth',2,'DisplayName','WT')
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
saveas(gcf,'DS01-dragpolar.png')

% Plot coefficients vs alpha for DS02
for i=2:8
    figure;
    set(gcf, 'Position',  [5, 45, 1267, 950])
    plot(CFDDS02Data(:,1),CFDDS02Data(:,i),'b--s','LineWidth',2,'DisplayName','CFD')
    hold on
    plot(WTDS02Data(:,1),WTDS02Data(:,i),'k-o','LineWidth',2,'DisplayName','WT')
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
            saveas(gcf,'DS02-CD.png')
        case 3
            ylabel('CL')
            legend('Location','southeast')
            saveas(gcf,'DS02-CLL.png')
        case 4
            ylabel('CY')
            legend('Location','southeast')
            saveas(gcf,'DS02-CY.png')
        case 5
            ylabel('Cm')
            legend('Location','northeast')
            saveas(gcf,'DS02-Cm.png')
        case 6
            ylabel('Cl')
            legend('Location','southeast')
            saveas(gcf,'DS02-Cl.png')
        case 7
            ylabel('Cn')
            legend('Location','northeast')
            saveas(gcf,'DS02-Cn.png')
        case 8
            ylabel('L/D')
            legend('Location','southeast')
            saveas(gcf,'DS02-L2D.png')
    end
end

% Plot drag polar in drag bucket style
figure
set(gcf, 'Position',  [5, 45, 1267, 950])
plot(CFDDS02Data(:,3),CFDDS02Data(:,2),'b--s','LineWidth',2,'DisplayName','CFD')
hold on
plot(WTDS02Data(:,3),WTDS02Data(:,2),'k-o','LineWidth',2,'DisplayName','WT')
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
saveas(gcf,'DS02-dragpolar.png')

% Plot coefficients vs alpha for DS04
for i=2:8
    figure;
    set(gcf, 'Position',  [5, 45, 1267, 950])
    plot(CFDDS04Data(:,1),CFDDS04Data(:,i),'b--s','LineWidth',2,'DisplayName','CFD')
    hold on
    plot(WTDS04Data(:,1),WTDS04Data(:,i),'k-o','LineWidth',2,'DisplayName','WT')
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
            saveas(gcf,'DS04-CD.png')
        case 3
            ylabel('CL')
            legend('Location','southeast')
            saveas(gcf,'DS04-CLL.png')
        case 4
            ylabel('CY')
            legend('Location','southeast')
            saveas(gcf,'DS04-CY.png')
        case 5
            ylabel('Cm')
            legend('Location','northeast')
            saveas(gcf,'DS04-Cm.png')
        case 6
            ylabel('Cl')
            legend('Location','southeast')
            saveas(gcf,'DS04-Cl.png')
        case 7
            ylabel('Cn')
            legend('Location','northeast')
            saveas(gcf,'DS04-Cn.png')
        case 8
            ylabel('L/D')
            legend('Location','southeast')
            saveas(gcf,'DS04-L2D.png')
    end
end

% Plot drag polar in drag bucket style
figure
set(gcf, 'Position',  [5, 45, 1267, 950])
plot(CFDDS04Data(:,3),CFDDS04Data(:,2),'b--s','LineWidth',2,'DisplayName','CFD')
hold on
plot(WTDS04Data(:,3),WTDS04Data(:,2),'k-o','LineWidth',2,'DisplayName','WT')
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
saveas(gcf,'DS04-dragpolar.png')