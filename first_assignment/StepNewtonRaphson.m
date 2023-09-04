% This method should perform a single step of the Newton-Raphson method.
% Note: In cases where the step cannot be completed, e.g. if f" = 0, a
% clear error message should be given.

function xNext = StepNewtonRaphson(xCurrent, fPrime, fDoublePrime)

    % if second derivative at point is zero, algorithm not possible
    if fDoublePrime == 0
        disp('Second derivative is equal to zero at xj. Returning NaN.');
        xNext = NaN;
        return;
    end
    
    % executing one step following Newton Raphsons equation
    xNext = xCurrent - fPrime / fDoublePrime;

end


