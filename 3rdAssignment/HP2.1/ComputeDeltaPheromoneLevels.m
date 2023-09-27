function deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection, pathLengthCollection)
    
    pathCollectionSize = size(pathCollection);

    numberOfAnts = pathCollectionSize(1);
    numberOfCities = pathCollectionSize(2); 

    deltaPheromoneLevel = zeros(numberOfCities, numberOfCities);

    for iAnt = 1:numberOfAnts
            
        pathForThisAnt = pathCollection(iAnt, :);
        pathLengthForThisAnt = pathLengthCollection(iAnt);

        deltaTauForOneAnt = zeros(numberOfCities, numberOfCities);
        for i = 1:length(pathForThisAnt)-1
            indexThisNode = pathForThisAnt(i);
            indexNextNode = pathForThisAnt(i+1);

            % from j to i, so from this node to next node 
            deltaTauForOneAnt(indexThisNode, indexNextNode) = 1/pathLengthForThisAnt; 
        end
        
        deltaPheromoneLevel = deltaPheromoneLevel + deltaTauForOneAnt; 
    end

end