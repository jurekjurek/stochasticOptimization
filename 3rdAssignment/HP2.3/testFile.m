clc, clearvars; 

wIH = [2 1 -3 1; 5 -2 1 4; 3 0 1 2];
wHO = [1 0 -4 3; 4 -2 0 1];


chromosome = EncodeNetwork(wIH, wHO, 2)


[wIHTest, wHOTest] = DecodeChromosome(chromosome, 3, 3, 2, 2)