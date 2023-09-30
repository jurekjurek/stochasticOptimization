

filename = 'BestChromosome.mat';

% Load the array from the MAT file
load(filename);

% bestChromosome = zeros(1, 10);

numberOfVariableRegisters = 3; 
numberOfConstantRegisters = 3; 

data = LoadFunctionData(); 

yEstimateList = zeros(1, length(data));

for iDataPoint = 1:length(data)
        
    yTemp = DecodeChromosome(data(iDataPoint), bestChromosome, numberOfVariableRegisters, numberOfConstantRegisters);

    yEstimateList(iDataPoint) = yTemp; 

end



% plotting 
x = data(:, 1)';
y = data(:, 2)';

% Create a plot with two data sets
plot(x, y, 'o', 'LineWidth', 2, 'MarkerSize', 2);
hold on; 
plot(x, yEstimateList, 'o', 'LineWidth', 2, 'MarkerSize', 2);



% Add labels, title, and legend
xlabel('X-axis');
ylabel('Y-axis');
title('Two Series of Data');
legend('y_{true}', 'y_{estimate}');


