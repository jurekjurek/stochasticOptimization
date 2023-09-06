% this function evaluates the fitness of an individual, given the vector x
% corresponding to a certain individual (with a certain chromosome)

function f = EvaluateIndividual(x)
    fNumerator1 = exp(-x(1)^2 - x(2)^2);
    fNumerator2 = sqrt(5) * (sin(x(2) * x(1)^2)^2);
    fNumerator3 = 2 * (cos(2 * x(1) + 3 * x(2))^2);

    fDenominator = 1 + x(1)^2 + x(2)^2;

    f = (fNumerator1 + fNumerator2 + fNumerator3) / fDenominator;
end
