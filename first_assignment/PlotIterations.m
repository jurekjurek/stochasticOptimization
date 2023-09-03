% This method should plot the polynomial and the iterates obtained
% using NewtonRaphsonStep (if any iterates were generated).

function PlotIterations(polynomialCoefficients, iterationValues)
    subplot(1,2,1);
    plot(iterationValues);
    title('Convergence to minimial value.');
    xlabel('Iterations');
    ylabel('xJ');

    subplot(1,2,2);
    x = linspace(-2, 2, 100);
    y = polyval(polynomialCoefficients, x);
    
    plot(x, y);

    xlabel('x');
    ylabel('y');
    title('Polynomial of interest');
end



