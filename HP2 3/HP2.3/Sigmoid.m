function output = Sigmoid(x)

    % Clip x to avoid numerical instability
    x = max(min(x, 100), -100);

    output = 1. / (1 + exp(-x));
end