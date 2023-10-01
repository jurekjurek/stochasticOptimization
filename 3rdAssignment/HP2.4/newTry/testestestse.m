


clc, clearvars;

data = LoadFunctionData(); 

populationSize = 2;

numberOfVariableRegisters = 3; 
numberOfConstantRegisters = 3; 

numberOfOperators = 4; 

numberOfGenerations = 100; 

minNumberOfInstructions = 3; 
maxNumberOfInstructions = 3; 


population = InitializePopulation(populationSize, minNumberOfInstructions, maxNumberOfInstructions, numberOfOperators, numberOfVariableRegisters, numberOfConstantRegisters)
% for i = 1:length(data)
%     DecodeChromosome(data(i, :), population.Chromosome, numberOfVariableRegisters, numberOfConstantRegisters)
% end

% tempFitness = EvaluateIndividual(population.Chromosome, data, numberOfVariableRegisters, numberOfConstantRegisters)

% [newOne, newTwo] = CrossOver(population(1).Chromosome, population(2).Chromosome);

oldIndividual = population(1).Chromosome

newIndividual = Mutate(oldIndividual, 1, numberOfOperators, numberOfVariableRegisters, numberOfConstantRegisters)
