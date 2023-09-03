% This function should return the value of the polynomial f(x) = a0x^0 + a1x^1 + a2x^2 ...
% where a0, a1, ... are obtained from polynomialCoefficients.

% clc, clearvars;
% % 
% result = GetPolynomialValue(2, [4,4,4,4]);
% % % 
% disp(['the result is: ', num2str(result)]);

function value = GetPolynomialValue(x, polynomialCoefficients)
    value = 0;
    for i = 1:length(polynomialCoefficients)
        value = value + x^(i - 1) * polynomialCoefficients(i);
    end
end





