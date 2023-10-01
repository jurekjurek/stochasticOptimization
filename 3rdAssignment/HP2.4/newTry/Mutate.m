function mutatedIndividual = Mutate(individual, mutationProbability, numberOfOperators, numberOfVariableRegisters, numberOfConstantRegisters)
    nGenes = size(individual, 2);
    mutatedIndividual = individual;
    
    for j = 1:nGenes
        r = rand;
        if (r < mutationProbability)
            % operatos
            if mod(j-1, 4) == 0
                mutatedIndividual(j) = randi([1, numberOfOperators]);
            % destination register
            elseif mod(j-2, 4) == 0
                mutatedIndividual(j) = randi([1, numberOfVariableRegisters]);
            % operands
            elseif mod(j-3, 4) == 0 || mod(j-4, 4) == 0
                mutatedIndividual(j) = randi([1, numberOfVariableRegisters + numberOfConstantRegisters]);
            end


        end
    end
end
