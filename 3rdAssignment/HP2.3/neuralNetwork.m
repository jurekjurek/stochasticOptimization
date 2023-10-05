

function [brakePressure, deltaGear] = neuralNetwork(velocity, alpha, brakeTemperature, wIH, wHO)
    inputVector = [velocity, alpha, brakeTemperature, 1]; 

    Z1 = wIH * inputVector';
    A1 = Sigmoid(Z1); 


    A1 = [A1, 1]; %cause of bias 


    Z2 = wHO * A1'; 
    A2 = Sigmoid(Z2);

    brakePressure = A2(1,1);
    % deltaGear = A2(1,2);

    if A2(1,2) > 0.5
        deltaGear = 1; 
    elseif A2(1,2) <= 0.5
        deltaGear = -1; 
    end
end