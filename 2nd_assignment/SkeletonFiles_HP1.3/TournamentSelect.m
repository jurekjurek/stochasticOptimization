% fitnesslist stores the fitness values for all involved individuals 
% at every step, the whole population gets replaced by a new population
% that is fitter 
% the i-th and i+1-th individual get replaced by two individual that have
% nothing to do with their parents????? 
function selectedIndividualIndex = TournamentSelect(fitnessList, tournamentProbability, tournamentSize)
    populationSize = length(fitnessList);

    % generalization involves: picking tournamentSize amount of individuals
    % from the fitnessList and picking the *one* with the highest fitness

    candidateList = zeros(1, tournamentSize);

    % pick one random individual from the population (1+... because of MatLab)
    for i = 1:tournamentSize
        candidateList(i) = 1 + fix(rand * populationSize);
    end

    tempCandidateList = candidateList;

    % disp(tempCandidateList);
    % disp(size(tempCandidateList));

    for i = 1:tournamentSize

        % disp('candidatelist: ');
        % disp(tempCandidateList);
        % determine element in candidateList with highest fitness 
        fitnessValuesCandidates = fitnessList(tempCandidateList);
        [maxValue, maxIndex] = max(fitnessValuesCandidates);
        bestIndividual = tempCandidateList(maxIndex);

        r = rand; 

        if (r < tournamentProbability)
            % disp('fittest individual chosen');
            selectedIndividualIndex = bestIndividual;
            break;
        end
        if (r >= tournamentProbability)
            % remove the individual with the highest fitness from the
            % candidates and repeat the whole procedure as long as there's
            % elements left in the candidateList
            
            if i == tournamentSize
                % disp('all candidates have been considered and the one with the lowest fitness value has been chosen.');
                selectedIndividualIndex = tempCandidateList(1);
            end

            tempCandidateList(maxIndex) = [];

        end
    end

end
