

function [brakePressure, deltaGear] = neuralNetwork(velocity, alpha, brakeTemperature, wIH, wHO)
    inputVector = [velocity, alpha, brakeTemperature, 1]; 
    Z1 = inputVector * wIH; 
    A1 = sigmoid(Z1); 

    A1 = [A1, 1]; %cause of bias 
    Z2 = A1 * wHO ; 
    [brakePressure, deltaGear] = sigmoid(Z2);
end