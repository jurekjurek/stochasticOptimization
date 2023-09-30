clearvars, clc; 

tournamentProbability = 0.75;
crossoverProbability = 0.8;  
mutationProbability = 0.02;


populationSize = 50;

numberOfVariableRegisters = 3; 
numberOfConstantRegisters = 3; 

numberOfOperators = 4; 

numberOfGenerations = 1; 


data = LoadFunctionData();

population = InitializePopulation(populationSize, 16, 4, numberOfOperators, numberOfVariableRegisters, numberOfConstantRegisters);
% works

for generation = 1:numberOfGenerations

    fitnessList = zeros(1, populationSize);
    maximumFitness  = 0.0;
    
    for i = 1:populationSize
        chromosome = population(i).Chromosome;
        fitnessList(i) = EvaluateIndividual(chromosome, data, numberOfVariableRegisters, numberOfConstantRegisters);
        if (fitnessList(i) > maximumFitness ) 
            disp('bestChromosome updatet');
            maximumFitness  = fitnessList(i);
            iBestIndividual = i;
            bestChromosome = chromosome;
        end
    end
    
    
    
    % evaluate individual works
    
    % Now, for Tournamentselection, CrossOver and Mutation
    
    temporaryPopulation = population;  
    for i = 1:2:populationSize
        i1 = TournamentSelect(fitnessList,tournamentProbability,2);
        i2 = TournamentSelect(fitnessList,tournamentProbability,2);
        r = rand;
        if (r < crossoverProbability) 
            individual1 = population(i1).Chromosome;
            individual2 = population(i2).Chromosome;
            [newIndividual1, newIndividual2] = Cross(individual1, individual2);
            temporaryPopulation(i).Chromosome = newIndividual1;
            temporaryPopulation(i+1).Chromosome = newIndividual2;
        else
            temporaryPopulation(i).Chromosome = population(i1).Chromosome;
            temporaryPopulation(i+1).Chromosome = population(i2).Chromosome;     
        end
    end
    
    
    temporaryPopulation(1).Chromosome = population(iBestIndividual).Chromosome;
    for i = 1:populationSize
        tempIndividual = Mutate(temporaryPopulation(i).Chromosome, mutationProbability, numberOfOperators, numberOfVariableRegisters, numberOfConstantRegisters);
        temporaryPopulation(i).Chromosome = tempIndividual;
    end
    population = temporaryPopulation;

end

disp(maximumFitness);

test = EvaluateIndividual(bestChromosome, data, numberOfVariableRegisters, numberOfConstantRegisters);
disp(test);

% 
% PLOTTTING
% 

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


return;


% safe best chromosome 
filename = 'BestChromosome.mat';

% Save the array to a MAT file
save(filename, 'bestChromosome');
        






