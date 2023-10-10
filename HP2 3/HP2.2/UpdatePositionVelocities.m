% this function updates the velocities, restricts the velocities and
% updates the positions of the particles 

function [newPositions, newVelocities] = UpdatePositionVelocities(positions, velocities, bestPositionsList, bestPositionInSwarm, inertiaWeight, maxVelocity, const1, const2, deltaT)
    
    [numberOfParticles, numberOfDimensions] = size(positions);

    newVelocities = zeros(numberOfParticles, numberOfDimensions);
    newPositions = zeros(numberOfParticles, numberOfDimensions);

    for iParticle = 1:numberOfParticles
        
        for jX = 1:numberOfDimensions
            % update velocities
            partI  = const1 * rand * (bestPositionsList(iParticle, jX) - positions(iParticle, jX)) / deltaT ;
            partII = const2 * rand * (bestPositionInSwarm(1, jX) - positions(iParticle, jX)) / deltaT ; 

            newVelocities(iParticle, jX) = inertiaWeight * velocities(iParticle, jX) + partI + partII; 

            % restrict velocities 
            if newVelocities(iParticle, jX) > maxVelocity
                newVelocities(iParticle, jX) = maxVelocity; 

            elseif newVelocities(iParticle, jX) < -maxVelocity
                newVelocities(iParticle, jX) = -maxVelocity; 

            end

            % update positions 
            newPositions(iParticle, jX) = positions(iParticle, jX) + deltaT * newVelocities(iParticle, jX);

        end

    end
end