

function yEstimate = DecodeChromosome(dataPoint, chromosome, numberOfVariableRegisters, numberOfConstantRegisters)

    numberOfGenes = length(chromosome);

    xK = dataPoint(1, 1);

    % PREPARE REGISTERS 

    unionOfRegisters = zeros(1, numberOfConstantRegisters+numberOfVariableRegisters); 

    unionOfRegisters(1) = xK; 
    unionOfRegisters(4) = 1; 
    unionOfRegisters(5) = 3; 
    unionOfRegisters(6) = -1;

    for j = 1:4:numberOfGenes

        operatorIndex = chromosome(j); 
        destinationIndex = chromosome(j+1); 
        operandOneIndex = chromosome(j+2); 
        operandTwoIndex = chromosome(j+3); 

        
        if operatorIndex == 1
            unionOfRegisters(destinationIndex) = unionOfRegisters(operandOneIndex) + unionOfRegisters(operandTwoIndex);
        elseif operatorIndex == 2
            unionOfRegisters(destinationIndex) = unionOfRegisters(operandOneIndex) - unionOfRegisters(operandTwoIndex);
        elseif operatorIndex == 3
            unionOfRegisters(destinationIndex) = unionOfRegisters(operandOneIndex) * unionOfRegisters(operandTwoIndex);
        elseif operatorIndex == 4
            % if the denominator is zero, we skip the operation... 
            if unionOfRegisters(operandTwoIndex) ~= 0
                unionOfRegisters(destinationIndex) = unionOfRegisters(operandOneIndex) / unionOfRegisters(operandTwoIndex);
            end
        end          


    end

    yEstimate = unionOfRegisters(1);


