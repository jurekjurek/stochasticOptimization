% this function is able to handle the most general case where not
% necessarily xMin = -xMax

function [positions, velocities] = InitializePositionVelocities(numberOfParticles, numberOfDimensions, xMin, xMax, alpha, deltaT)
    
    positions = zeros(numberOfParticles, numberOfDimensions);
    velocities = zeros(numberOfParticles, numberOfDimensions);

    % iterate over particles, assign random position and velocity to each
    % this is a 2-dim problem, so the x vectors and v vectors are 2-dim 
    for iParticle = 1:numberOfParticles
        for jX = 1:numberOfDimensions
            positions(iParticle, jX) = xMin + rand * (xMax - xMin);

            factor1 = (xMax-xMin)/2; 
            factor2 = (xMax-xMin);
            velocities(iParticle, jX) = alpha/deltaT * (-factor1 + rand * factor2);
        end
    end
end