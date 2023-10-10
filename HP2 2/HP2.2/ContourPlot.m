


nX1 = 200; 
nX2 = 199; 

x1 = linspace(-5, 5, nX1);
x2 = linspace(-5, 5, nX2);

func = zeros(nX1, nX2);

for i = 1:nX1
    for j = 1:nX2
        func(i, j) = log( 0.01 + FunctionOfInterest(x1(i), x2(j)));
        % func(i, j) = FunctionOfInterest(x1(i), x2(j));
    end
end

figure; 
contour(x1, x2, func', 50); 
colorbar; 
title('Function of interest, logarithmic')
xlabel('x1');
xlabel('x2');
