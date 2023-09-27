% This method should plot the polynomial and the iterates obtained
% using NewtonRaphsonStep (if any iterates were generated).

function PlotIterations(polynomialCoefficients, iterationValues)
    
    % plot polynomial
    xPolynomial = linspace(-1.7, 2.2, 100);
    yPolynomial = zeros(size(xPolynomial)); 
    
    % use function GetPolynomialValue instead of built in function to
    % determine y coordinates
    for i = 1:length(xPolynomial)
        yPolynomial(i) = GetPolynomialValue(xPolynomial(i), polynomialCoefficients);
    end

    plot(xPolynomial, yPolynomial);
    xlabel('x');
    ylabel('y');

    
    % plot iterationValues
    yIterationValues = zeros(size(iterationValues))

    for i = 1:length(iterationValues)
        yIterationValues(i) = GetPolynomialValue(iterationValues(i), polynomialCoefficients)
    end
    
    hold on;
    scatter(iterationValues, yIterationValues, 50, 'blue', 'filled');

    hold off;

    % mark minimum in plot 
    xMin = iterationValues(end);
    yMin = GetPolynomialValue(xMin, polynomialCoefficients);

    hold on;
    scatter(xMin, yMin, 50, 'r', 'filled');
    
    % label point in plot
    label = 'xMin';
    text(xMin, yMin, label, 'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');

    hold off;
    title(['Polynomial of interest, ', newline, 'Minimal value: ' num2str(xMin)]);

end



