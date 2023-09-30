% We evaluate chromosomes direclty here
% data is a 2xsomething array containing x and y values of the datapoints
% chromosome is a series of instrutions encoded 


function fitness = EvaluateIndividual(chromosome, data, numberOfVariableRegisters, numberOfConstantRegisters)
    
    numberOfDataPoints = length(data);

    totalErrorIterative = 0; 

    % we iterate over the data and evaluate a y for every x 
    for i = 1:numberOfDataPoints

        dataPoint = data(i);

        yK = dataPoint(2);

        estimateY = DecodeChromosome(dataPoint, chromosome, numberOfVariableRegisters, numberOfConstantRegisters);


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