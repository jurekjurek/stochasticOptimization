% path is a list of indices and cityLocation is a list that stores the
% locations of the cities

function pathLength = GetPathLength(path, cityLocation)
    pathLength = 0; 
    
    numberOfCities = length(path);
        
    for i = 1:numberOfCities-1
        cityIndex = path(i);
        nextCityIndex = path(i+1);

        x1 = cityLocation(cityIndex, 1);
        y1 = cityLocation(cityIndex, 2);
        x2 = cityLocation(nextCityIndex, 1); 
        y2 = cityLocation(nextCityIndex, 2);
        distanceToNextNode = sqrt((x1-x2)^2 + (y1-y2)^2);

        pathLength = pathLength + distanceToNextNode;
        
    end
        
end