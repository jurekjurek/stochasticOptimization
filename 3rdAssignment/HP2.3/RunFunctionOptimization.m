
populationSize = 500;              % Do NOT change
maximumVariableValue = 5;          % Do NOT change: (x_i in [-a,a], where a = maximumVariableValue)
numberOfGenes = 50;                % Do NOT change
numberOfVariables = 2;  	       % Do NOT change

tournamentSize = 2;                % Changes allowed
tournamentProbability = 0.75;      % Changes allowed (= pTour)
crossoverProbability = 0.8;        % Changes allowed (= pCross)
mutationProbability = 0.02;        % Changes allowed. (Note: 0.02 <=> 1/numberOfGenes)
numberOfGenerations = 2000;        % Changes allowed.

maximumFitness  = 0;
population = InitializePopulation(populationSize,numberOfGenes);
for generation = 1:numberOfGenerations
    maximumFitness  = 0.0;
    fitnessList = zeros(1,populationSize);
    for i = 1:populationSize
        chromosome = population(i,:);
        variableValues = DecodeChromosome(chromosome,numberOfVariables,maximumVariableValue);
        fitnessList(i) = EvaluateIndividual(variableValues);
        if (fitnessList(i) > maximumFitness ) 
            maximumFitness  = fitnessList(i);
            iBestIndividual = i;
            bestVariableValues = variableValues;
        end
    end
    
    temporaryPopulation = population;  
    for i = 1:2:populationSize
        i1 = TournamentSelect(fitnessList,tournamentProbability,tournamentSize);
        i2 = TournamentSelect(fitnessList,tournamentProbability,tournamentSize);
        r = rand;
        if (r < crossoverProbability) 
            individual1 = population(i1,:);
            individual2 = population(i2,:);
            newIndividualPair = Cross(individual1, individual2);
            temporaryPopulation(i,:) = newIndividualPair(1,:);
            temporaryPopulation(i+1,:) = newIndividualPair(2,:);
        else
            temporaryPopulation(i,:) = population(i1,:);
            temporaryPopulation(i+1,:) = population(i2,:);     
        end
    end
    
    temporaryPopulation(1,:) = population(iBestIndividual,:);
    for i = 2:populationSize
        tempIndividual = Mutate(temporaryPopulation(i,:),mutationProbability);
        temporaryPopulation(i,:) = tempIndividual;
    end
    population = temporaryPopulation;

end

