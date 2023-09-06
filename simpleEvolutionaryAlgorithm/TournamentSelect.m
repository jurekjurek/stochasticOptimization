% fitness is an array that stores the fitness for all the individuals in
% the population 

function iSelected = TournamentSelect(fitness, pTournament)
    populationSize = length(fitness);

    % randomly pick two individuals, iTmp1, iTmp2 from the population
    iTmp1 = 1 + fix(rand * populationSize);
    iTmp2 = 1 + fix(rand * populationSize);
    r = rand;
    
    % select individual with higher fitness
    if (r < pTournament)
        if (fitness(iTmp1) > fitness(iTmp2))
            iSelected = iTmp1;
        else
            iSelected = iTmp2;
        end
    % select individual with lower fitness 
    else
        if (fitness(iTmp1) > fitness(iTmp2))
            iSelected = iTmp2;
        else
            iSelected = iTmp1;
        end
    end
end
