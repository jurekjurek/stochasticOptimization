% nIn = the number of inputs
% nHidden = the number of hidden neurons
% nOut = the number of output neurons
% Weights (and biases) should take values in the range [-wMax,wMax]

% we have two matrices, one corresponding to weights between in and hidden 
% the other one between hidden and out 

clc, clearvars; 

numberOfHiddenNeurons = 10;
numberOfInputs = 5;
numberOfOutputs = 2; 

weightsInputToHiddenLayer = ones(numberOfHiddenNeurons, numberOfInputs+1)

weightsHiddenToOutputLayer = ones(numberOfOutputs, numberOfHiddenNeurons+1)

function [wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, wMax);
