% This method should plot the polynomial and the iterates obtained
% using NewtonRaphsonStep (if any iterates were generated).

function PlotIterations(polynomialCoefficients, iterationValues)
    % plot convergence of xJ to minimal value 
    subplot(1,2,1);
    plot(iterationValues);
    xlabel('Iterations');
    ylabel('xJ');    
    % title('Convergence to minimial value; ');

    title(['Convergence of xJ ', newline, 'Minimal value: ' num2str(iterationValues(end))]);

    % plot polynomial 
    subplot(1,2,2);
    x = linspace(-1, 1, 100);
    y = zeros(size(x)); % Initialize an array to store the results
    
    for i = 1:length(x)
        y(i) = GetPolynomialValue(x(i), polynomialCoefficients);
    end

    
    plot(x, y);
    xlabel('x');
    ylabel('y');
    title('Polynomial of interest');

    % Specify the coordinates of the point to mark
    disp(iterationValues(end));
    x_point = iterationValues(end); % Replace with the x-coordinate of the point
    y_point = GetPolynomialValue(x_point, polynomialCoefficients); % Calculate the y-coordinate
    
    hold on; % Ensure the scatter point doesn't overwrite the existing plot
    scatter(x_point, y_point, 50, 'r', 'filled'); % 'r' for red color, 'filled' for a filled marker
    hold off;
end



