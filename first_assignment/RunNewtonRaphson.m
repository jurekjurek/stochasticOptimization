% This function should run the Newton-Raphson method, making use of the
% other relevant functions (StepNewtonRaphson, DifferentiatePolynomial, and
% GetPolynomialValue). Before returning iterationValues any non-plottable values 
% (e.g. NaN) that can occur if the method fails (e.g. if the input is a
% first-order polynomial) should be removed, so that only values that
% CAN be plotted are returned. Thus, in some cases (again, the case of
% a first-order polynomial is an example) there may be no points to plot.


function iterationValues = RunNewtonRaphson(polynomialCoefficients, startingPoint, tolerance)
    iterationValues = [];

    iterationValues = [iterationValues, startingPoint];

    xJ = startingPoint

    fPrime = DifferentiatePolynomial(polynomialCoefficients, 1);

    fDoublePrime = DifferentiatePolynomial(polynomialCoefficients, 2);

    distance = 100000000; % large number 

    count = 0; 

    while distance >= tolerance

        fPrimeAtPoint = GetPolynomialValue(xJ, fPrime);
        fDoublePrimeAtPoint = GetPolynomialValue(xJ, fDoublePrime);

        xJ = StepNewtonRaphson(xJ, fPrimeAtPoint, fDoublePrimeAtPoint);

        % iteratively append xJ to iterationValues list
        iterationValues =  [iterationValues, xJ];

        distance = abs(xJ - iterationValues(end-1));

        count = count + 1; 

        % if we are at more than 1000 iterations, break. 
        if count > 1000
            disp('Algorithm did not converge. No minimal value found.');
            break;
        end

    end

    disp('number of iterations:');
    disp(count);
        
end