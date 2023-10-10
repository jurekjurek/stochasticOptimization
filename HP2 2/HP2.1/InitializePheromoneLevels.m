function pheromoneLevel = InitializePheromoneLevels(numberOfCities, tau0)
    
    % pheromoneLevel is a 50x50 matrix that is 
    % tau_ij indicates the pheromonelevel from node i to node j 
    pheromoneLevel = tau0 * ones(numberOfCities, numberOfCities); 
end