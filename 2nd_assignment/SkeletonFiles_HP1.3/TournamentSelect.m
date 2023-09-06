
% fitnesslist stores the fitness values for all involved individuals 


function selectedIndividualIndex = TournamentSelect(fitnessList, tournamentProbability, tournamentSize)
    populationSize = length(fitnessList);

    % generalization involves: picking tournamentSize amount of individuals
    % from the fitnessList and picking the *one* with the highest fitness

    candidateList = zeros(1, tournamentSize);

    disp(size(candidateList));

    for i = 1:tournamentSize
        candidateList(i) = 1 + fix(rand * populationSize);
    end

    tempCandidateList = candidateList;

    disp(tempCandidateList);
    disp(size(tempCandidateList));

    for i = 1:tournamentSize

        % determine element in candidateList with highest fitness 
        fitnessValuesCandidates = fitnessList(tempCandidateList)
        [maxValue, maxIndex] = max(fitnessValuesCandidates);
        bestIndividual = tempCandidateList(maxIndex);

        r = rand; 

        if (r < tournamentProbability)
            selectedIndividualIndex = bestIndividual;
            break;
        end
        if (r >= tournamentProbability)
            % remove the element with the highest fitness from the
            % candidates and repeat the whole procedure as long as there's
            % elements left in the candidateList
            
            if i == tournamentSize
                selectedIndividualIndex = tempCandidateList(1);
            end

            tempCandidateList(maxIndex) = [];

        end
    end

end
