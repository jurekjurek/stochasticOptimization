clc, clearvars; 
population = InitializePopulation(5, 6); 

chromosome = population(1,:);

x = DecodeChromosome(chromosome, 2, 5);

fitnessList = [1,2,3,4,3,2,1];

index = TournamentSelect(fitnessList, 0.5, 3)




