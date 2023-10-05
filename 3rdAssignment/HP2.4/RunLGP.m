clearvars, clc; 

tournamentProbability = 0.75;
crossoverProbability = 0.2;  
mutationProbability = 0.04;


populationSize = 100;

numberOfVariableRegisters = 3; 
numberOfConstantRegisters = 3; 

numberOfOperators = 4; 

numberOfGenerations = 30000; 

minNumberOfInstructions = 5; 
maxNumberOfInstructions = 25; 

data = LoadFunctionData();

population = InitializePopulation(populationSize, minNumberOfInstructions, maxNumberOfInstructions, numberOfOperators, numberOfVariableRegisters, numberOfConstantRegisters);

globalCostList = zeros(1, numberOfGenerations);

globalMaximumFitness = 0;

for generation = 1:numberOfGenerations

    if mod(generation, numberOfGenerations/100) == 0
        fprintf('%d percent done \n', fix(generation/numberOfGenerations*100));
    end

    fitnessList = zeros(1, populationSize);
    maximumFitness  = 0.0;
    
    for i = 1:populationSize
        chromosome = population(i).Chromosome;
        fitnessList(i) = EvaluateIndividual(chromosome, data, numberOfVariableRegisters, numberOfConstantRegisters);

        % in this generation
        if (fitnessList(i) > maximumFitness ) 
            maximumFitness  = fitnessList(i);
            iBestIndividual = i;
            bestChromosome = chromosome;
        end

        % over all generations 
        if (fitnessList(i) > globalMaximumFitness)
            globalMaximumFitness = fitnessList(i);
            globalBestChromosome = chromosome; 
        end
    end
    
    globalCostList(generation) = maximumFitness; 
    
    % evaluate individual works
    
    % Now, for Tournamentselection, CrossOver and Mutation
    
    temporaryPopulation = population;  
    for i = 1:2:populationSize
        i1 = TournamentSelect(fitnessList,tournamentProbability,5);
        i2 = TournamentSelect(fitnessList,tournamentProbability,5);
        r = rand;
        if (r < crossoverProbability) 
            individual1 = population(i1).Chromosome;
            individual2 = population(i2).Chromosome;
            [newIndividual1, newIndividual2] = CrossOver(individual1, individual2);
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

disp('Maximal fitness found: ');
disp(globalMaximumFitness);


% 
% PLOTTTING
% 

% plotting fitness
figure(1);
plot(globalCostList);
xlabel('Generation');
ylabel('Best fitness'); 


% plotting approximation
yEstimateList = zeros(1, length(data));

for iDataPoint = 1:length(data)
        
    yTemp = DecodeChromosome(data(iDataPoint), globalBestChromosome, numberOfVariableRegisters, numberOfConstantRegisters);

    yEstimateList(iDataPoint) = yTemp; 

end

% plotting 
figure(2);
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




save('BestChromosomeTemp.m', 'globalBestChromosome', '-ascii');



% % safe best chromosome 
% filename = 'BestChromosome.mat';
% 
% % Save the array to a MAT file
% save(filename, 'globalBestChromosome');
        






