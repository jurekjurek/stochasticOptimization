% Note: Each component of x should take values in [-a,a], where a = maximumVariableValue.

function x = DecodeChromosome(chromosome,numberOfVariables,maximumVariableValue);

    % returns size of second dimension of chromosome array 
    nGenes = size(chromosome, 2);

    k = fix(nGenes / numberOfVariables);

    % x is a vector of the size numberOfVariables
    x = zeros(numberOfVariables);

    % iterate over all dimensions
    for i = 1:numberOfVariables
        x(i) = 0.0;
        for j = 1:k
            x(i) = x(i) + chromosome(j + (i-1)* k) * 2^(-j);
        end
        x(1) = -maximumVariableValue + 2 * maximumVariableValue * x(i) / (1 - 2^(-k));

    end

end


