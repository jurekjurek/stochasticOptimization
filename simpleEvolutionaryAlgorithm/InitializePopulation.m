% this function initializes the population, given the size and nGenes which
% is the number of 1s and 0s in each of the strings of the individuals
% population is a matrix. 

function population = initializePopulation(populationSize, nGenes)

    population = zeros(populationSize, nGenes);
    for i = 1:populationSize
        for j = 1:nGenes
            s = rand;
            if (s < 0.5)
                population(i,j)=0;
            else
                population(i,j)=1;
            end
        end
    end
    
end