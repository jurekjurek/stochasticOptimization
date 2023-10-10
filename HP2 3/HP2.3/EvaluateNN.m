% in this file, we evaluate the neural network
% at each timestep, the corresponding values are calculated, the velocity
% at the time t is calculated and then the NN is evaluated 

% Essentially, at every timestep we calculate Tb, then v and then put this
% all togehter in the neural network 

function globalFitnessValue = EvaluateNN(chromosome, nIn, nHidden, nOut, iDataSet, deltaT, pP, mTruck, tBreak, tAmb, tMax, tau, cH, cB, initialVelocity, initialGearPosition, maxVelocity, minVelocity)
    % totalDistanceTraveled = 0; 
    % velocity = initialVelocity;  
    % currentGear = initialGearPosition; 

    [wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, 8); 

    % velocityOverTotalSlope = 0;

    iterationCounter = 0;
    
    if iDataSet == 1
        iSlopeMax = 10; 
    elseif iDataSet == 2 || iDataSet == 3
        iSlopeMax = 5; 
    end

    deltaTBreak = 0;

    globalFitnessList = zeros(1, 10); 

    for iSlope = 1:iSlopeMax

        totalDistanceTraveled = 0; 
        velocity = initialVelocity;  
        currentGear = initialGearPosition; 
    
        % [wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, 8); 
    
        velocityOverTotalSlope = velocity;

        counterForGear = 0; 

        while totalDistanceTraveled < 1000
    
            alpha = GetSlopeAngle(totalDistanceTraveled, iSlope, iDataSet);

            % in rad, not in degrees
            alpha = alpha * pi / 180; 
    
            if pP < 0.01
                deltaTBreak = deltaTBreak - deltaTBreak/tau * deltaT;
    
            else
                deltaTBreak = deltaTBreak + cH * pP * deltaT; 
            end
    
            tBreak = tAmb + deltaTBreak;

            velocity = TruckModel(pP, mTruck, tBreak, tMax, cB, velocity, currentGear, alpha, deltaT);
            

            if velocity > maxVelocity || velocity < minVelocity
                % disp('Quittin, truck too fast or too slow.');
                break; 
            end
    
            % evaluate NN
            [pP, deltaGear] = neuralNetwork(velocity, alpha, tBreak, wIH, wHO);
    

            % deltaGear is either -1 or +1

            % only if gear is not at highest or lowest position already can
            % alter the 
            if counterForGear > 7
                if (deltaGear == 1 && currentGear < 10) || (deltaGear == -1 && currentGear > 1)
                    currentGear = currentGear + deltaGear;
                    counterForGear = 0;
                end
            end

    
            % distance traveled during timestep deltaT
            distanceTravelled = velocity * deltaT * cos(alpha);
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