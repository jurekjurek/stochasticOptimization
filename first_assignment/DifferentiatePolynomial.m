% This method should return the coefficients of the k-th derivative (defined by
% the derivativeOrder) of the polynomial given by the polynomialCoefficients (see also GetPolynomialValue)

function derivativeCoefficients = DifferentiatePolynomial(polynomialCoefficients, derivativeOrder)
    polynomialDegree = length(polynomialCoefficients) - 1;  % Degree of the polynomial

    % if we have derivatives of order higher than the order of the
    % polynomial, this derivative does not exist
    if derivativeOrder > polynomialDegree
        derivativeCoefficients = [];
        disp('Differentiation kills the whole polynomial.');
        return;
    end
    
    % iterate over all derivative orders
    for i = 1:derivativeOrder

        % iterate over all parts of the polynomial 
        for j = 1:polynomialDegree
            polynomialCoefficients(j) = polynomialCoefficients(j + 1) * j;
        end

        % Each differentiation subtracts one from the polynomial degree
        polynomialDegree = polynomialDegree - 1;

        % And the last element in the coefficients list, corresponding to
        % the one degree less, is removed from the list
        polynomialCoefficients = polynomialCoefficients(1:end-1);

    end

    derivativeCoefficients = polynomialCoefficients;

end



