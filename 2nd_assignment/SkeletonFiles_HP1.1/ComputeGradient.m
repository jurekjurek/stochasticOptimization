% This function should return the gradient of f_p = f + penalty.
% You may hard-code the gradient required for this specific problem.

function gradF = ComputeGradient(x,mu)
    x_1 = x(1);
    x_2 = x(2);

    firstComponent = 2* (x_1 - 1) + 4 * mu * x_1 * (x_1^2 + x_2^2 -1);
    secondComponent = 4* (x_2 - 1) + 4 * mu * x_2 * (x_1^2 + x_2^2 -1);

    gradF = [firstComponent, secondComponent];
end 

