clc, clearvars;

% load best chromosome 
globalBestChromosome = load('BestChromosome.m');

numberOfGenes = length(globalBestChromosome);

% PREPARE REGISTERS 

unionOfRegisters = {'x', '0', '0', '1', '3', '-1'}; 


for j = 1:4:numberOfGenes

    operatorIndex = globalBestChromosome(j); 
    destinationIndex = globalBestChromosome(j+1); 
    operandOneIndex = globalBestChromosome(j+2); 
    operandTwoIndex = globalBestChromosome(j+3); 
    
    
    if operatorIndex == 1
        unionOfRegisters{destinationIndex} = ['(', unionOfRegisters{operandOneIndex}, '+', unionOfRegisters{operandTwoIndex}, ')'];
    elseif operatorIndex == 2
        unionOfRegisters{destinationIndex} = ['(', unionOfRegisters{operandOneIndex}, '-', unionOfRegisters{operandTwoIndex}, ')'];
    elseif operatorIndex == 3
        unionOfRegisters{destinationIndex} = ['(', unionOfRegisters{operandOneIndex}, '*', unionOfRegisters{operandTwoIndex}, ')'];
    elseif operatorIndex == 4
        unionOfRegisters{destinationIndex} = ['(', unionOfRegisters{operandOneIndex}, '/', unionOfRegisters{operandTwoIndex}, ')'];
    end          


end

yEstimate = unionOfRegisters{1};


disp('Final function: ')
disp(yEstimate);



% so, the function we are looking for, is: 
% (x*(x^2 - x)+1) / (x*(x*x-x) +1 + x^2*(x^2-x))



numberOfVariableRegisters = 3; 
numberOfConstantRegisters = 3; 

data = LoadFunctionData(); 


disp('with an error of: ')
fitness = EvaluateIndividual(globalBestChromosome, data, 3, 3);
disp(1/fitness);

yEstimateList = zeros(1, length(data));

for iDataPoint = 1:length(data)
        
    yTemp = DecodeChromosome(data(iDataPoint), globalBestChromosome, numberOfVariableRegisters, numberOfConstantRegisters);

    yEstimateList(iDataPoint) = yTemp; 

end



% plotting 
x = data(:, 1)';
y = data(:, 2)';


% approximated function
figure(2);
plot(x, yEstimateList, 'o', 'LineWidth', 2, 'MarkerSize', 2);
xlabel('X-axis');
ylabel('Y-axis');
title('Approximation of a dataseries with LGP');


% true function
figure(1);
plot(x, y, 'o', 'LineWidth', 2, 'MarkerSize', 2);
xlabel('X-axis');
ylabel('Y-axis');
title('Datapoints that are to be approximated');


