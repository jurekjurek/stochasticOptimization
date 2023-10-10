% New pheromonelevel after an ant passed through the graph
% could have to be elementwise... 

function newPheromoneLevel = UpdatePheromoneLevels(pheromoneLevel,deltaPheromoneLevel,rho)
    numberOfCities = length(pheromoneLevel); 
    newPheromoneLevel = zeros(numberOfCities, numberOfCities);

    for i = 1:numberOfCities 
        for j = 1:numberOfCities
            newPheromoneLevel(i,j) = pheromoneLevel(i,j) * (1-rho) + deltaPheromoneLevel(i,j);
            if newPheromoneLevel(i, j) < 1e-15
                newPheromoneLevel(i, j) = 1e-15;
            end
        end
    end

end