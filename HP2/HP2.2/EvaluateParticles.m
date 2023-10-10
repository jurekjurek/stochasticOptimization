function evaluationList = EvaluateParticles(positions)
        
    numberOfParticles = length(positions);
    evaluationList = zeros(1, numberOfParticles);
    
    for iParticle = 1:numberOfParticles
        x1 = positions(iParticle, 1); 
        x2 = positions(iParticle, 2);

        tempEvaluation = FunctionOfInterest(x1, x2);

        evaluationList(iParticle) = tempEvaluation; 

    end
end