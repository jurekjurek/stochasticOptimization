% this function creates a number of chromosomes at random that encode the
% wieghts of a neural network 

function population = InitializePopulation(populationSize, nIn, nOut, nHidden, lowerWeightBound, upperWeightBound)

    numberOfGenes = (nHidden * (nIn+1)) + (nOut * (nHidden+1));

    population = zeros(populationSize, numberOfGenes);
    for i = 1:populationSize
        for j = 1:numberOfGenes
            population(i, j) = randi([lowerWeightBound, upperWeightBound]);
        end
    end
    
end