% This method should return the coefficients of the k-th derivative (defined by
% the derivativeOrder) of the polynomial given by the polynomialCoefficients (see also GetPolynomialValue)

% clc, clearvars; 
% 
% result = DifferentiatePolynomial([1,1,1,1], 3)

function derivativeCoefficients = DifferentiatePolynomial(polynomialCoefficients, derivativeOrder)
    polynomialDegree = length(polynomialCoefficients) - 1;  % Degree of the polynomial

    % if the second derivative does not exist, Newton Rhapson method can
    % not be applied. 
    if polynomialDegree < 2
        disp('The degree of the polynomial must be at least two in order to use the Newton Rhapson method. Polynomial degree is: ');
        disp(polynomialDegree);
        derivativeCoefficients = NaN; 
        return; 
    end

    % if we have derivatives of order higher than the order of the
    % polynomial, this derivative does not exist
    if derivativeOrder > polynomialDegree
        derivativeCoefficients = NaN;
        disp('differentiation kills the whole polynomial.');
        return;
    end
    
    for i = 1:derivativeOrder
        for j = 1:polynomialDegree
            polynomialCoefficients(j) = polynomialCoefficients(j + 1) * j;
        end
        polynomialDegree = polynomialDegree - 1;

        polynomialCoefficients = polynomialCoefficients(1:end-1);
        disp(polynomialCoefficients);

    end

    derivativeCoefficients = polynomialCoefficients;

    whos;
    
end



