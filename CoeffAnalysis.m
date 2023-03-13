% Script to plot CFD and WT data
clear

% Read .txt file that contains data
% Prompt user to select .txt file to work with
%[FileName,PathName,FilterIndex] = uigetfile('*.xlsx');
% Change the working directory to where this file exists
%cd(PathName)

% Read the CFD file contents
% Data will be in the following order
% Aoa Beta CD CL Cy Cm Cl Cn L/D
FileName = 'G:\Shared drives\ONR\CFD\ANSYS\fluent\config2A_WT\v4\coefficients.txt';
Data = readtable(FileName);

BLData = Data(Data.damage == "BL",:);
BLSData = Data(Data.damage == "BLS",:);
DS1Data = Data(Data.damage == "DS1",:);

% plots comparing structured to unstructured grids
figure
set(gcf, 'Position',  [5, 45, 1267, 950])
plot(BLData.aoa,BLData.CD,'k-o','LineWidth',2,'DisplayName','Unstructured Components')
hold on
plot(BLSData.aoa,BLSData.CD,'b--+','LineWidth',2,'DisplayName','Fully Structured')
legend
xlabel('Angle of Attack (\circ)')
ylabel('Drag Coefficient')
grid on
ax = gca;
ax.FontSize = 24;
ax.LineWidth = 1.5;

figure
set(gcf, 'Position',  [5, 45, 1267, 950])
plot(BLData.aoa,BLData.CL,'k-o','LineWidth',2,'DisplayName','Unstructured Components')
hold on
plot(BLSData.aoa,BLSData.CL,'b--+','LineWidth',2,'DisplayName','Fully Structured')
legend('Location','northwest')
xlabel('Angle of Attack (\circ)')
ylabel('Lift Coefficient')
grid on
ax = gca;
ax.FontSize = 24;
ax.LineWidth = 1.5;

figure
set(gcf, 'Position',  [5, 45, 1267, 950])
plot(BLData.aoa,BLData.Cy,'k-o','LineWidth',2,'DisplayName','Unstructured Components')
hold on
plot(BLSData.aoa,BLSData.Cy,'b--+','LineWidth',2,'DisplayName','Fully Structured')
legend
xlabel('Angle of Attack (\circ)')
ylabel('Side Force Coefficient')
grid on
ax = gca;
ax.FontSize = 24;
ax.LineWidth = 1.5;
ylim([-2 2])

figure
set(gcf, 'Position',  [5, 45, 1267, 950])
plot(BLData.aoa,BLData.Cm,'k-o','LineWidth',2,'DisplayName','Unstructured Components')
hold on
legend
plot(BLSData.aoa,BLSData.Cm,'b--+','LineWidth',2,'DisplayName','Fully Structured')
xlabel('Angle of Attack (\circ)')
ylabel('Pitching Moment Coefficient')
grid on
ax = gca;
ax.FontSize = 24;
ax.LineWidth = 1.5;

figure
set(gcf, 'Position',  [5, 45, 1267, 950])
plot(BLData.aoa,BLData.Cn,'k-o','LineWidth',2,'DisplayName','Unstructured Components')
hold on
legend
plot(BLSData.aoa,BLSData.Cn,'b--+','LineWidth',2,'DisplayName','Fully Structured')
xlabel('Angle of Attack (\circ)')
ylabel('Yawing Moment Coefficient')
grid on
ax = gca;
ax.FontSize = 24;
ax.LineWidth = 1.5;
ylim([-2 2]);

figure
set(gcf, 'Position',  [5, 45, 1267, 950])
plot(BLData.aoa,BLData.Cl,'k-o','LineWidth',2,'DisplayName','Unstructured Components')
hold on
legend
plot(BLSData.aoa,BLSData.Cl,'b--+','LineWidth',2,'DisplayName','Fully Structured')
xlabel('Angle of Attack (\circ)')
ylabel('Rolling Moment Coefficient')
grid on
ax = gca;
ax.FontSize = 24;
ax.LineWidth = 1.5;
ylim([-2 2]);

% plots comparing baseline vs damaged
figure
set(gcf, 'Position',  [5, 45, 1267, 950])
plot(BLData.aoa,BLData.CD,'k-o','LineWidth',2,'DisplayName','Baseline')
hold on
plot(DS1Data.aoa,DS1Data.CD,'b--+','LineWidth',2,'DisplayName','Damaged')
legend
xlabel('Angle of Attack (\circ)')
ylabel('Drag Coefficient')
grid on
ax = gca;
ax.FontSize = 24;
ax.LineWidth = 1.5;

figure
set(gcf, 'Position',  [5, 45, 1267, 950])
plot(BLData.aoa,BLData.CL,'k-o','LineWidth',2,'DisplayName','Baseline')
hold on
plot(DS1Data.aoa,DS1Data.CL,'b--+','LineWidth',2,'DisplayName','Damaged')
legend('Location','northwest')
xlabel('Angle of Attack (\circ)')
ylabel('Lift Coefficient')
grid on
ax = gca;
ax.FontSize = 24;
ax.LineWidth = 1.5;

figure
set(gcf, 'Position',  [5, 45, 1267, 950])
plot(BLData.aoa,BLData.Cy,'k-o','LineWidth',2,'DisplayName','Baseline')
hold on
plot(DS1Data.aoa,DS1Data.Cy,'b--+','LineWidth',2,'DisplayName','Damaged')
legend
xlabel('Angle of Attack (\circ)')
ylabel('Side Force Coefficient')
grid on
ax = gca;
ax.FontSize = 24;
ax.LineWidth = 1.5;
ylim([-2 2])

figure
set(gcf, 'Position',  [5, 45, 1267, 950])
plot(BLData.aoa,BLData.Cm,'k-o','LineWidth',2,'DisplayName','Baseline')
hold on
legend
plot(DS1Data.aoa,DS1Data.Cm,'b--+','LineWidth',2,'DisplayName','Damaged')
xlabel('Angle of Attack (\circ)')
ylabel('Pitching Moment Coefficient')
grid on
ax = gca;
ax.FontSize = 24;
ax.LineWidth = 1.5;

figure
set(gcf, 'Position',  [5, 45, 1267, 950])
plot(BLData.aoa,BLData.Cn,'k-o','LineWidth',2,'DisplayName','Baseline')
hold on
legend
plot(DS1Data.aoa,DS1Data.Cn,'b--+','LineWidth',2,'DisplayName','Damaged')
xlabel('Angle of Attack (\circ)')
ylabel('Yawing Moment Coefficient')
grid on
ax = gca;
ax.FontSize = 24;
ax.LineWidth = 1.5;
ylim([-2 2]);

figure
set(gcf, 'Position',  [5, 45, 1267, 950])
plot(BLData.aoa,BLData.Cl,'k-o','LineWidth',2,'DisplayName','Baseline')
hold on
legend
plot(DS1Data.aoa,DS1Data.Cl,'b--+','LineWidth',2,'DisplayName','Damaged')
xlabel('Angle of Attack (\circ)')
ylabel('Rolling Moment Coefficient')
grid on
ax = gca;
ax.FontSize = 24;
ax.LineWidth = 1.5;
ylim([-2 2]);