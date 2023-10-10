clc, clearvars; 

% neural net parameters
nIn = 3; 
nOut = 2; 
nHidden = 6; 


% truck specific stuff
iDataSet = 1; 
iSlope = 1; 
deltaT = 0.25;  

% dont need this one 
pP = 1; 


mTruck = 20000;
tBreak = 500;
tAmb = 283; 
deltaTBreak = tBreak - tAmb; 
tMax = 750;
tau = 30;
cH = 40;
cB = 3000;
initialVelocity = 20; 
initialGearPosition = 7; 
maxVelocity = 25; 
minVelocity = 1;

lowerWeightBound = -8; 
upperWeightBound = 8; 

maximumFitness  = 0;

% load best chromosome 
bestChromosome = load('BestChromosome.m');

wMax = 8; 

[wIH, wHO] = DecodeChromosome(bestChromosome, nIn, nHidden, nOut, wMax);

pedalPressureList = [];
gearList = [];
speedList = [];
brakeTemperatureList = [];
distanceTraveledList = [];
slopeList = [];

totalDistanceTraveled = 0; 

velocity = initialVelocity; 
currentGear = initialGearPosition;
counterForGear = 0;
velocityOverTotalSlope = velocity; 
iterationCounter = 0; 


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
    slopeList = [slopeList alpha];

end

averageVelocity = velocityOverTotalSlope / iterationCounter; 

fitnessValue = averageVelocity * totalDistanceTraveled; 

globalFitnessList(iSlope) = fitnessValue; 



% plot slope, pedal perssure, gear, speed, brake temperature
subplot(3, 2, 1); 
plot(distanceTraveledList, pedalPressureList);
title('Pedal Pressure vs. Distance');

subplot(3, 2, 2);  % Select the second subplot
plot(distanceTraveledList, gearList);
title('Gear vs. Distance');

subplot(3, 2, 3);  % Select the third subplot
plot(distanceTraveledList, speedList);
title('Speed vs. Distance');

subplot(3, 2, 4);  % Select the fourth subplot
plot(distanceTraveledList, brakeTemperatureList);
title('Brake Temperature vs. Distance');

subplot(3, 2, 5);  % Select the fifth subplot
plot(distanceTraveledList, slopeList);
title('Slope vs. Distance');



