% We evaluate chromosomes direclty here
% data is a 2xsomething array containing x and y values of the datapoints
% chromosome is a series of instrutions encoded 


function fitness = EvaluateIndividual(chromosome, data, numberOfVariableRegisters, numberOfConstantRegisters)
    
    numberOfGenes = length(chromosome);

    numberOfDataPoints = length(data);

    % disp('length of data');
    % disp(numberOfDataPoints);

    totalErrorIterative = 0; 

    % we iterate over the data and evaluate a y for every x 
    for i = 1:numberOfDataPoints

        yK = data(i, 2);
        xK = data(i, 1);

        % PREPARE REGISTERS 

        unionOfRegisters = zeros(1, numberOfConstantRegisters+numberOfVariableRegisters); 

        unionOfRegisters(1) = xK; 

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

        estimateY = unionOfRegisters(1);

        tempError = (estimateY - yK)^2;

        totalErrorIterative = totalErrorIterative + tempError; 

        if isnan(tempError)
            disp(estimateY);
            disp(yK);
        end

    end

    totalError = sqrt( 1/numberOfDataPoints * totalErrorIterative );

    if totalError == 0
        totalError = 1e-15;
    end

    fitness = 1/totalError; 

    if isnan(fitness)
        disp('here, we have NaN');
        disp(totalError);
        disp(numberOfDataPoints);
        disp(totalErrorIterative);
    end

end