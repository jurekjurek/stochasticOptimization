% hier die ganzen variablen definieren 

% load best chromosome 
run('bestChromosome.m');

[wIH, wHO] = DecodeChromosome(bestChromosome, nIn, nHidden, nOut, wMax);

pedalPressureList = [];
gearList = [];
speedList = [];
brakeTemperatureList = [];
distanceTraveledList = [];

while totalDistanceTraveled < 1000

    alpha = GetSlopeAngle(totalDistanceTraveled, iSlope, iDataSet);

    if pP < 0.01
        deltaTBreak = deltaTBreak - deltaTBreak/tau * deltaT;

    else
        deltaTBreak = deltaTBreak + cH * pP * deltaT; 
    end

    tBreak = tAmb + deltaTBreak;

    velocity = TruckModel(pP, mTruck, tBreak, tMax, cB, velocity, currentGear, alpha, deltaT);
    

    if velocity > maxVelocity || velocity < minVelocity
        % disp('Breaking, velocity limits not valid anymore.');
        break; 
    end

    % evaluate NN
    [pP, deltaGear] = neuralNetwork(velocity, alpha, tBreak, wIH, wHO);

    if counterForGear > 7
        currentGear = currentGear + deltaGear;
        counterForGear = 0;
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

    pedalPressureList = [pedalPressureList pP];
    gearList = [gearList currentGear];
    speedList = [speedList velocity];
    brakeTemperatureList = [brakeTemperatureList tBreak];
    distanceTraveledList = [distanceTraveledList totalDistanceTraveled];

end

averageVelocity = velocityOverTotalSlope / iterationCounter; 

fitnessValue = averageVelocity * totalDistanceTraveled; 

globalFitnessList(iSlope) = fitnessValue; 



% print slope, pedal perssure, gear, speed, brake temperature

