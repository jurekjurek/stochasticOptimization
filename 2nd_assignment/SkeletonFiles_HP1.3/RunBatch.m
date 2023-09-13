%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter specifications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numberOfRuns = 100;                % Do NOT change
populationSize = 100;              % Do NOT change
maximumVariableValue = 5;          % Do NOT change (x_i in [-a,a], where a = maximumVariableValue)
numberOfGenes = 50;                % Do NOT change
numberOfVariables = 2;		       % Do NOT change
numberOfGenerations = 300;         % Do NOT change
tournamentSize = 2;                % Do NOT change
tournamentProbability = 0.75;      % Do NOT change
crossoverProbability = 0.8;        % Do NOT change


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Batch runs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define more runs here (pMut < 0.02) ...

mutationProbability = 0.02;
sprintf('Mutation rate = %0.5f', mutationProbability)



pMutValues = [0 0.01 0.02 0.04 0.07 0.1 0.3 0.7 0.8 0.9];

disp(length(pMutValues));

medianPerformanceList = zeros(1, length(pMutValues));

for iMutValues = 1:length(pMutValues)

    mutationProbability = pMutValues(iMutValues)

    % initialize list to store fitness for each run, to determine median
    maximumFitnessList = zeros(numberOfRuns,1);
    for i = 1:numberOfRuns 
     [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                           tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);
     sprintf('Mu: %d, Run: %d, Score: %0.10f', mutationProbability, i, maximumFitness)
      maximumFitnessList(i,1) = maximumFitness;
    end

    medianPerformanceList(iMutValues) = median(maximumFitnessList);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Summary of results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add more results summaries here (pMut < 0.02) ...

% average002 = mean(maximumFitnessList002);
% median002 = median(maximumFitnessList002);
% std002 = sqrt(var(maximumFitnessList002));
% sprintf('PMut = 0.02: Median: %0.10f, Average: %0.10f, STD: %0.10f', median002, average002, std002)

% semilogx(pMutValues, medianPerformanceList);
plot(pMutValues, medianPerformanceList);
xlabel('Mutation Probability');
ylabel('Median Performance over 100 runs');
title('Evolution of performance with p_{mu}')

disp(medianPerformanceList);























