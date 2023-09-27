% inputs:  
% binaray chromosome
% number of variables that are to be extracted from one chromosome 
% maximum variable value a, where x takes values in [-a, a]
function x = DecodeChromosome(chromosome,numberOfVariables,maximumVariableValue);

    % returns size of second dimension of chromosome array 
    % corresponding to number of columns, that's what we want 
    nGenes = size(chromosome, 2);

    k = fix(nGenes / numberOfVariables);

    % x is a vector of the size numberOfVariables
    x = zeros(1, numberOfVariables);

    % iterate over all dimensions
    for i = 1:numberOfVariables
        x(i) = 0.0;
        for j = 1:k
            x(i) = x(i) + chromosome(j + (i-1)* k) * 2^(-j);
        end
        x(i) = -maximumVariableValue + 2 * maximumVariableValue * x(i) / (1 - 2^(-k));

    end

end


