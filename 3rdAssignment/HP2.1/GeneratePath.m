% this function returns a path of an ant given ... 
% it utilizes the function GetNode which returns a Node at some step given
% by a certain probability. 

function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)
    numberOfCities = length(pheromoneLevel);
    
    % select starting node (index)
    startingNode = randi([1, 50]);

    tabuList = zeros(1, numberOfCities); 

    tabuList(1) = startingNode; 

    for iCity = 2:numberOfCities
        nextNode = GetNode(tabuList, pheromoneLevel, visibility, alpha, beta); 
        tabuList(iCity) = nextNode; 

    end

    path = tabuList; 
        
end