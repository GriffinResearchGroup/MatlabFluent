% This file will parse the outfile from ANSYS Fluent, if written to a file.
% This is to plot residuals over the solution. It currently only works for
% steady cases.

clear
% Read file that contains data
Directory = 'G:\My Drive\Research\Active\ONR\CFD\Config1_NASA\Fluent\alpha_v1\WT-M2.36-T9-p20\';
FileName = 'outfile';
outFile = append(Directory,FileName);

% Create new string of file contents that splits it at every line break
str = regexp(fileread(outFile),'\n','split');

% Search for pertinent lines in the string
pat = 'iter  continuity  x-velocity  y-velocity';
whichline = find(contains(str,pat));

test = [];

% Figure options
width = 9;      % Width in inches
height = 8;     % Height in inches
alw = 0.75;     % Axes line width
fsz = 14;       % Font size
lw = 1.5;       % Line width
msz = 8;        % Marker size

% Loop through the str to get data between pertinent lines
% But, this will also include other lines we don't need
for i=1:numel(whichline)
    start = whichline(i) + 1;
    if (i == numel(whichline))
        finish = numel(str);
    else
        finish = whichline(i+1) - 2;
    end    
    for j=start:finish
        test = [test str(j)];
    end
end

if any(strcmp(whichline(1),'energy'))
    energyFlag = 1;
else
    energyFlag = 0;
end

% Get rid of empty cells
test(strcmp('',test)) = [];

Data = [];

for i=1:numel(test)
    tmp = cell2mat(test(i));
    tmp = str2num(tmp);
    if(numel(tmp)>=7)
        if (energyFlag == 1)
            tmp = tmp(:,1:8);
            Data = [Data; tmp];
        else
            tmp = tmp(:,1:7);
            Data = [Data; tmp];
        end
    end
end

f = figure;
set(gcf, 'Position', [100 100 width*100, height*100]);
plot(Data(:,1),Data(:,2),'LineWidth',lw,'DisplayName','Continuity')
hold on
plot(Data(:,1),Data(:,3),'LineWidth',lw,'DisplayName','X-Velocity')
plot(Data(:,1),Data(:,4),'LineWidth',lw,'DisplayName','Y-Velocity')
plot(Data(:,1),Data(:,5),'LineWidth',lw,'DisplayName','Z-Velocity')
if (energyFlag == 1)
    plot(Data(:,1),Data(:,6),'LineWidth',lw,'DisplayName','Energy')
    plot(Data(:,1),Data(:,7),'LineWidth',lw,'DisplayName','k')
    plot(Data(:,1),Data(:,8),'LineWidth',lw,'DisplayName','omega')
elseif (energyFlag == 0)
    plot(Data(:,1),Data(:,6),'LineWidth',lw,'DisplayName','k')
    plot(Data(:,1),Data(:,7),'LineWidth',lw,'DisplayName','omega')
end
%ylim([0 0.1])
set(gca,'YScale','log','FontSize', fsz, 'LineWidth', alw)
grid on
legend('Location','best')
xlabel('Iteration')

% Save the file
imgFile = append(Directory,'residuals.png');
saveas(gcf,imgFile);