function visibility = GetVisibility(cityLocation)
    
    numberOfCities = length(cityLocation); 
    visibility = zeros(numberOfCities, numberOfCities);

    for i = 1:numberOfCities
        for j = 1:numberOfCities
            if j == i
                continue
            end

            x1 = cityLocation(i,1);
            x2 = cityLocation(j,1);


            y1 = cityLocation(i,2);
            y2 = cityLocation(j,2);

            eucledianDistance = sqrt((x1 - x2)^2 + (y1 - y2)^2 );

            visibility(i,j) = 1/eucledianDistance; 
        end
    end

end