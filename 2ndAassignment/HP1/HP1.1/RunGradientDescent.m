% This function should run gradient descent until the L2 norm of the
% gradient falls below the specified threshold.
function x = RunGradientDescent(xStart, mu, eta, gradientTolerance)

    xJ = xStart; 

    while abs(ComputeGradient(xJ, mu)) > gradientTolerance
        tempGradient = ComputeGradient(xJ, mu);

        xJ = xJ - eta * tempGradient; 

    end 

    x = xJ; 







