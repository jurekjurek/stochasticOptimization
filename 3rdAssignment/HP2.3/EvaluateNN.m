% in this file, we evaluate the neural network
% at each timestep, the corresponding values are calculated, the velocity
% at the time t is calculated and then the NN is evaluated 

% Essentially, at every timestep we calculate Tb, then v and then put this
% all togehter in the neural network 

function globalFitnessValue = EvaluateNN(chromosome, iDataSet, deltaT, pP, mTruck, tBreak, tAmb, tMax, tau, cH, cB, initialVelocity, initialGearPosition, maxVelocity, minVelocity)
    totalDistanceTraveled = 0; 
    velocity = initialVelocity;  
    currentGear = initialGearPosition; 

    [wIH, wHO] = DecodeChromosome(chromosome, 3, 3, 2, 2); 

    velocityOverTotalSlope = 0;

    iterationCounter = 0;
    
    if iDataSet == 1
        iSlopeMax = 10; 
    elseif iDataSet == 2 || iDataSet == 3
        iSlopeMax = 5; 
    end

    globalFitnessList = zeros(1, 10); 

    for iSlope = 1:iSlopeMax

        while totalDistanceTraveled < 1000
    
            alpha = GetSlopeAngle(totalDistanceTraveled, iSlope, iDataSet);
    
            if pP < 0.01
                tBreak = tBreak - tBreak/tau * deltaT;
    
            else
                tBreak = cH * pP * deltaT; 
            end
    
    
            velocity = TruckModel(pP, mTruck, tBreak, tMax, cB, velocity, currentGear, alpha, deltaT);
    
            if velocity > maxVelocity || velocity < minVelocity
                disp('Breaking, velocity limits not valid anymore.');
                break; 
            end
    
            % evaluate NN
            [pP, deltaGear] = neuralNetwork(velocity, alpha, tBreak, wIH, wHO);
    
            if counterForGear > 7
                currentGear = currentGear + deltaGear;
                counterForGear = 0;
            end
    
            % distance traveled during timestep deltaT
            distanceTravelled = velocity * t * cos(alpha);
            totalDistanceTraveled = totalDistanceTraveled + distanceTravelled; 
    
            % increase Gear counter
            counterForGear = counterForGear + 1; 
    
            % for avg velocity in the end 
            velocityOverTotalSlope = velocityOverTotalSlope + velocity; 
    
            % iteration counter 
            iterationCounter = iterationCounter + 1;
    
        end
    
        averageVelocity = velocityOverTotalSlope / iterationCounter; 
    
        fitnessValue = averageVelocity * totalDistanceTraveled; 

        globalFitnessList(iSlope) = fitnessValue; 

    end

    globalFitnessValue = min(globalFitnessList);

end