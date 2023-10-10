function selectedIndividualIndex = TournamentSelect(fitnessList, tournamentProbability, tournamentSize)
    populationSize = length(fitnessList);

    candidateList = zeros(1, tournamentSize);
    
    for i = 1:tournamentSize
        candidateList(i) = 1 + fix(rand * populationSize);
    end

    tempCandidateList = candidateList;

    for i = 1:tournamentSize

        % determine element in candidateList with highest fitness 
        fitnessValuesCandidates = fitnessList(tempCandidateList);

        [~, maxIndex] = max(fitnessValuesCandidates);
        bestIndividual = tempCandidateList(maxIndex);

        r = rand; 

        if (r < tournamentProbability)
            selectedIndividualIndex = bestIndividual;
            break;
        end
        if (r >= tournamentProbability)
            % remove the individual with the highest fitness from the
            % candidates and repeat the whole procedure as long as there's
            % elements left in the candidateList
            if i == tournamentSize
                selectedIndividualIndex = tempCandidateList(1);
            end

            tempCandidateList(maxIndex) = [];

        end
    end

end
