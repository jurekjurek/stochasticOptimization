%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Penalty method for minimizing
%
% (x1-1)^2 + 2(x2-2)^2, s.t.
%
% x1^2 + x2^2 - 1 <= 0.
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The values below are suggestions - you may experiment with
% other values of eta and other (increasing) sequences of the
% µ parameter (muValues).
clc, clearvars; 

muValues = [0.1 1 10 100 1000];
eta = 0.0001;
xStart = [1,1]; % [Specify as a vector with two components, see Step 3 of the problem formulation];
gradientTolerance = 1E-3;

x1List = zeros(size(muValues));
x2List = zeros(size(muValues));


for i = 1:length(muValues)
 mu = muValues(i);
 x = RunGradientDescent(xStart,mu,eta,gradientTolerance);
 sprintf('x(1) = %3f, x(2) = %3f mu = %d',x(1),x(2),mu)
 x1List(i) = x(1); 
 x2List(i) = x(2); 
end

% plot the values of x1 and x2 as functions of mu 
semilogx(muValues, x1List);

hold on; 
plot(muValues, x2List);
hold off; 





