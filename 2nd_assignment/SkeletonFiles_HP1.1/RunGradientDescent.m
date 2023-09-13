% This function should run gradient descent until the L2 norm of the
% gradient falls below the specified threshold.

% xStart is the starting point for the algorithm
% mu is specified in the main programme of the penalty method\
% eta is the steplength
% gradientTolerance is a limit - upon reaching it, the algorithm terminates
function x = RunGradientDescent(xStart, mu, eta, gradientTolerance)

    xJ = xStart; 
    tempGradient = 10000000; % high number 


    count = 0; 

    while abs(ComputeGradient(xJ, mu)) > gradientTolerance
        tempGradient = ComputeGradient(xJ, mu);
    
        % disp(tempGradient);

        % xJ as well as tempGradient are vectors 
        xJ = xJ - eta * tempGradient; 

        % if count > 10
        %     break;
        % end
        count = count + 1; 

    end 

    x = xJ; 







