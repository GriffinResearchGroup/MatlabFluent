clear
% Read file that contains data
% Prompt user to select file to work with
[FileName,PathName,FilterIndex] = uigetfile('*');
% Change the working directory to where this file exists
cd(PathName)

% Create new string of file contents that splits it at every line break
str = regexp(fileread(FileName),'\n','split');

% Search for pertinent lines in the string
pat = 'iter  continuity  x-velocity  y-velocity';
whichline = find(contains(str,pat));

test = {};

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

% Get rid of empty cells
test(strcmp('',test)) = [];

Data = [];

for i=1:numel(test)
    tmp = cell2mat(test(i));
    tmp = str2num(tmp);
    if(numel(tmp)>=7)
        tmp = tmp(:,1:7);
        Data = [Data; tmp];
    end
end

figure
plot(Data(:,1),Data(:,2),'LineWidth',2,'DisplayName','Continuity')
hold on
plot(Data(:,1),Data(:,3),'LineWidth',2,'DisplayName','X-Velocity')
plot(Data(:,1),Data(:,4),'LineWidth',2,'DisplayName','Y-Velocity')
plot(Data(:,1),Data(:,5),'LineWidth',2,'DisplayName','Z-Velocity')
plot(Data(:,1),Data(:,6),'LineWidth',2,'DisplayName','k')
plot(Data(:,1),Data(:,7),'LineWidth',2,'DisplayName','omega')
ylim([0 0.1])
set(gca,'YScale','log')
grid on
legend
xlabel('Iteration')
ax = gca;
ax.FontSize = 16;
ax.LineWidth = 1;