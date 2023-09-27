function visibility = GetVisibility(cityLocation)
    
    numberOfCities = length(cityLocation); 
    visibility = zeros(numberOfCities, numberOfCities);

    for i = 1:numberOfCities
        for j = 1:numberOfCities
            if j == i
                continue
            end
            eucledianDistance = sqrt((cityLocation(i,1) - cityLocation(j,1))^2 + (cityLocation(i,2) - cityLocation(j,2))^2 );

            visibility(i,j) = 1/eucledianDistance; 
        end
    end

end