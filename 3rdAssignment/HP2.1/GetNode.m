% returns next node in path 
% choose next node based on two criteria: 
% 1. It cannot be in the tabu list 
% 2. The probability is given by some formula 
% iterate over all possible swapping nodes, store swapping probabilities in
% probabilityList 

function nextNode = GetNode(tabuList, pheromoneLevel, visibility, alpha, beta)

    numberOfCities = length(pheromoneLevel);

    numberOfTabuCities = length(tabuList);

    probabilityList = zeros(1, numberOfCities-numberOfTabuCities);

    usedNodesList = zeros(1, numberOfCities-numberOfTabuCities);

    % thisNode = tabuList(end);

    % this Node is the last node in the tabu list that is not zero 
    for i = length(tabuList):-1:1
        if tabuList(i) ~= 0
            thisNode = tabuList(i);
            break;
        end
    end

    % disp('thisNode in GetNode:'); 
    % disp(thisNode);



    % create normalizationfactor 
    normalizationFactor = 0;
    for jCity = 1:numberOfCities
        jNotInTabuList = ~any(tabuList == jCity);
        if jNotInTabuList
            % disp('test');
            temporaryTau = pheromoneLevel(thisNode, jCity);
            factorOne = temporaryTau^alpha;
            % disp(temporaryTau);
            temporaryVisibility = visibility(thisNode, jCity); 
            factorTwo = temporaryVisibility^beta;
            % disp(temporaryVisibility);
            % disp(normalizationFactor);
            % disp(factorOne * factorTwo);
            
            normalizationFactor = normalizationFactor + factorOne * factorTwo;
        end
        % fprintf('Normalisationfactor is: %.2f', normalizationFactor)
    end


    
    listFillingCounter = 1;

    for iNextNode = 1:numberOfCities
        iNotInTabuList = ~any(tabuList == iNextNode);

        if iNotInTabuList
            temporaryNumerator = pheromoneLevel(thisNode, iNextNode)^alpha * visibility(thisNode, iNextNode)^beta;
            temporaryProbability = temporaryNumerator/normalizationFactor;
    
            probabilityList(listFillingCounter) = temporaryProbability;

            usedNodesList(listFillingCounter) = iNextNode;

            listFillingCounter = listFillingCounter + 1; 
        end
    end

    % in case the list is NaN
    if length(probabilityList) == 1
        probabilityList = ones(1,1);
    end

    % disp('DEBUGDEBUG');
    % disp(length(probabilityList));

    % now that we have probabilities for all the cities, we can evaluate
    % which path to take via cumulative probability tomorrow 

    cumulativeProb = 0; 

    randomNumber = rand;

    for i = 1:length(probabilityList)
        cumulativeProb = cumulativeProb + probabilityList(i); 
        if randomNumber <= cumulativeProb
            nextNode = usedNodesList(i); 
            break; 
        end
    end
    

    

end