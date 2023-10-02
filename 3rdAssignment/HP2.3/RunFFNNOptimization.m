


populationSize = 500;              % Do NOT change
maximumVariableValue = 5;          % Do NOT change: (x_i in [-a,a], where a = maximumVariableValue)
numberOfGenes = 50;                % Do NOT change
numberOfVariables = 2;  	       % Do NOT change

tournamentSize = 2;                % Changes allowed
tournamentProbability = 0.75;      % Changes allowed (= pTour)
crossoverProbability = 0.8;        % Changes allowed (= pCross)
mutationProbability = 0.02;        % Changes allowed. (Note: 0.02 <=> 1/numberOfGenes)
numberOfGenerations = 2000;        % Changes allowed.

nIn = 3; 
nOut = 2; 
nHidden = 6; 


% nn specific stuff
iDataSet = 1; 
deltaT = 0.25;  

% dont need this one 
pP = 1; 


mTruck = 20000;
tBreak = 500;
tAmb = 283; 
tMax = 750;
tau = 30;
cH = 40;
cB = 3000;
initialVelocity = 20; 
initialGearPosition = 7; 
maxVelocity = 25; 
minVelocity = 1;



maximumFitness  = 0;



% generate a population of chromosomes corresponding to weights in neural
% networks
population = InitializePopulation(populationSize, nIn, nOut, nHidden);


for generation = 1:numberOfGenerations
    maximumFitness  = 0.0;
    fitnessList = zeros(1,populationSize);
    for i = 1:populationSize
        chromosome = population(i,:);
        fitnessList(i) = EvaluateNN(chromosome, iDataSet, deltaT, pP, mTruck, tBreak, tAmb, tMax, tau, cH, cB, initialVelocity, initialGearPosition, maxVelocity, minVelocity);
        if (fitnessList(i) > maximumFitness ) 
            maximumFitness  = fitnessList(i);
            iBestIndividual = i;
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

