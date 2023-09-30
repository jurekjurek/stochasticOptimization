
clc, clearvars; 

pheromoneLevel = InitializePheromoneLevels(50, 0.1);

cityLocation = LoadTestCityLocations();

visibility = GetVisibility(cityLocation)

return; 

numberOfCities = 50;
numberOfAnts = 50;

alpha = 1; 
beta  = 3; 

pathCollection = zeros(numberOfAnts, numberOfCities);
pathLengthCollection = zeros(numberOfAnts,1);

for k = 1:numberOfAnts
    path = GeneratePath(pheromoneLevel, visibility, alpha, beta);   % To do: Write the GeneratePath function
    pathLength = GetPathLength(path,cityLocation);                  % To do: Write the GetPathLength function
    pathCollection(k,:) = path;  
    pathLengthCollection(k) = pathLength; 
end


deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection);
pheromoneLevel = UpdatePheromoneLevels(pheromoneLevel,deltaPheromoneLevel,0.3);

for k = 1:numberOfAnts
    path = GeneratePath(pheromoneLevel, visibility, alpha, beta);   % To do: Write the GeneratePath function
    pathLength = GetPathLength(path,cityLocation);                  % To do: Write the GetPathLength function
    pathCollection(k,:) = path;  
    pathLengthCollection(k) = pathLength; 
end

deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection);
pheromoneLevel = UpdatePheromoneLevels(pheromoneLevel,deltaPheromoneLevel,0.3);







