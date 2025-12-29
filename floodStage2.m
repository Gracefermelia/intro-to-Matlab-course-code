%% Load the Data
% Load the river height data file
riverHeight = load('riverHeightData.txt');


% Define size variables
[nDays, nYears] = size(riverHeight);
if nYears < 2
    error('The dataset does not contain a second year of data.');
else
    year2Heights = riverHeight(:, 2);
end

days = 1:nDays;

%% Define Flood Stage Levels
actionStage = 9;    
minorStage = 11;    
moderateStage = 14; 
majorStage = 15;

% Create Figure
figure;
hold on;

xlim([1, nDays]);
ylim([0, max(year2Heights) + 2]);

h1 = line([1 nDays], [actionStage actionStage], 'Color', 'm', 'LineWidth', 1, 'LineStyle', '--');
h2 = line([1 nDays], [minorStage minorStage], 'Color', 'k', 'LineWidth', 1, 'LineStyle', '--');
h3 = line([1 nDays], [moderateStage moderateStage], 'Color', 'b', 'LineWidth', 1, 'LineStyle', '--');
h4 = line([1 nDays], [majorStage majorStage], 'Color', 'r', 'LineWidth', 1, 'LineStyle', '--');

h5 = plot(days(1), year2Heights(1), 'ko', 'MarkerFaceColor', 'k', 'DisplayName', 'Year 2 River Height Data');

xlabel('Day in February');
ylabel('River Height (ft)');
title('River Height Animation for Year 2');
grid on;

legend([h1, h2, h3, h4, h5], ...
       {'Action Flood Stage', 'Minor Flood Stage', 'Moderate Flood Stage', 'Major Flood Stage', 'Year 2 River Height Data'}, ...
       'Location', 'NorthEast');

% Animation Loop
for i = 2:nDays
    set(h5, 'XData', days(1:i), 'YData', year2Heights(1:i));
    drawnow;
    pause(0.01); % Smooth animation
end

hold off;

