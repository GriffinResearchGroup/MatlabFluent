clear
% if this is a pitchup case determine pitch rate so we can plot as a
% function of angle and time
PU = 1;

% Prompt user to select .txt file to work with
[FileName,PathName,FilterIndex] = uigetfile('*.txt');
% Change the working directory to where this file exists
cd(PathName)
% Read the CFD file contents
Data = dlmread(FileName,' ',3,0);
% Move data into timestep, time, drag, lift, slip, pitch-mom, roll-mom,
% yaw-mom
Data = Data(:,[1 8 2 3 7 4 5 6]);
Data(:,6) = -Data(:,6);
if PU == 1
    k = 0.001;      % non-dimensional pitch rate
    V = 78.0;   	% velocity, ft/s
    l = 0.28333;    % characteristic length, ft
    % calculate pitch rate
    omega = rad2deg((k*V)/l);
    angle = Data(:,2).*omega;
    % update Data matrix to include angle
    Data = [Data(:,1) Data(:,2) angle Data(:,3) Data(:,4) Data(:,5) Data(:,6) Data(:,7) Data(:,8)];
    t = tiledlayout(1,1);
    ax1 = axes(t);
    plot(ax1,angle,Data(:,4),'k-o','DisplayName','CD')
    hold on
    plot(ax1,angle,Data(:,5),'b--+','DisplayName','CL')
    plot(ax1,angle,Data(:,6),'r:*','DisplayName','Cy')
    plot(ax1,angle,Data(:,7),'g-..','DisplayName','Cm')
    plot(ax1,angle,Data(:,8),'m-x','DisplayName','Cl')
    plot(ax1,angle,Data(:,9),'c--s','DisplayName','Cn')
    xlabel(ax1,'Angle (deg)')
    yl = ylim;
    xl = xlim;
    legend('Location','northwest')
    grid on
    ax1.FontSize = 24;
    ax2 = axes(t);
    plot(ax2,Data(:,2),Data(:,3),'k-o','DisplayName','CD')
    ax2.XAxisLocation = 'top';
    ax2.Color = 'none';
    ax1.Box = 'off';
    ax2.Box = 'off';
    xlabel(ax2,'Time (s)')
    ylim(yl);
    endangle = xl(2);
    endtime = endangle/omega;
    xlim([0 endtime]);
    ax2.FontSize = 24;
    fig = gcf;
    fig.Position = [40 40 1280 960];
else
    f = figure;
    plot(Data(:,2),Data(:,3),'k-o','DisplayName','CD')
    hold on
    plot(Data(:,2),Data(:,4),'b--+','DisplayName','CL')
    plot(Data(:,2),Data(:,5),'r:*','DisplayName','Cy')
    plot(Data(:,2),Data(:,6),'g-..','DisplayName','Cm')
    plot(Data(:,2),Data(:,7),'m-x','DisplayName','Cl')
    plot(Data(:,2),Data(:,8),'c--s','DisplayName','Cn')
    xlabel('Time (s)')
    legend('Location','northeast')
    grid on
    ax = gca;
    ax.FontSize = 24;
    fig = gcf;
    fig.Position = [40 40 1280 960];
end