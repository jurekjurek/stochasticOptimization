clc, clearvars; 

numberOfParticles = 30; 
numberOfDimensions = 2; 
xMax = 5; 
xMin = -5; 

alpha = 1; 
deltaT = 1; 

maxVelocity = (xMax - xMin) / deltaT; 
intertiaWeight = 1.4; 

lowerBoundIntertiaWeigth = 0.43;
reducingInertiaWeightFactor = 0.999;

const1 = 2; 
const2 = 2; 

numberOfIterations = 10000; 

[positions, velocities] = InitializePositionVelocities(numberOfParticles, numberOfDimensions, xMin, xMax, alpha, deltaT);

% the best position in the beginning is simply the position 
bestPositionsList = positions; 

% high number
bestPositionInSwarm = 1000 * zeros(1, numberOfDimensions); 

for iteration = 1:numberOfIterations


    % 
    % STEP II - evaluate 
    % 
    
    evaluationList = EvaluateParticles(positions);
    
    % 
    % STEP III - update best lists
    % 
    
    for iParticle = 1:numberOfParticles
        
        x1 = positions(iParticle, 1); 
        x2 = positions(iParticle, 2); 
        
        tempFunctionValue = FunctionOfInterest(x1, x2); 
    
        x1Best = bestPositionsList(iParticle, 1); 
        x2Best = bestPositionsList(iParticle, 2);
    
        bestParticleFunctionValue = FunctionOfInterest(x1Best, x2Best);
    
        if tempFunctionValue < bestParticleFunctionValue
            bestPositionsList(iParticle, 1) = x1;
            bestPositionsList(iParticle, 2) = x2; 
        end
    
        x1GlobalBest = bestPositionInSwarm(1, 1); 
        x2GlobalBest = bestPositionInSwarm(1, 2);
    
        bestGlobalFunctionValue = FunctionOfInterest(x1GlobalBest, x2GlobalBest);
    
        if tempFunctionValue < bestGlobalFunctionValue
            bestPositionInSwarm(1, 1) = x1; 
            bestPositionInSwarm(1, 2) = x2; 
        end
    
    end
    
    
    % 
    % STEP IV - update positions and velocities 
    % 
    
    [positions, velocities] = UpdatePositionVelocities(positions, velocities, bestPositionsList, bestPositionInSwarm, intertiaWeight, maxVelocity, const1, const2, deltaT);

       
    
    if intertiaWeight > lowerBoundIntertiaWeigth
        intertiaWeight = intertiaWeight * reducingInertiaWeightFactor; 
    end

end


disp('FunctionMinimum at: ')
x1GlobalBest = bestPositionInSwarm(1,1)
x2GlobalBest = bestPositionInSwarm(1,2)

disp('where functionValue: ')
disp(FunctionOfInterest(x1GlobalBest, x2GlobalBest));


