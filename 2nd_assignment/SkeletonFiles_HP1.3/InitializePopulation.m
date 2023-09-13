% this function initializes the population, given the size and nGenes which
% is the number of 1s and 0s in each of the strings of the individuals
% population is a matrix. 
function population = InitializePopulation(populationSize, numberOfGenes)

    % the rows in the population matrix will be the genes and each column
    % will correspond to one individual 
    population = zeros(populationSize, numberOfGenes);
    for i = 1:populationSize
        for j = 1:numberOfGenes
            s = rand;
            if (s < 0.5)
                population(i,j)=0;
            else
                population(i,j)=1;
            end
        end
    end
    
end