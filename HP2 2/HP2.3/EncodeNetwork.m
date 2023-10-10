% this function encodes a FFNN with two weight matrices wIH, wHO and the
% weights taking values in the range [-wMax, wMax]
% the encoding scheme used is real value encoding, we go through the
% elements of the matrix and encode put the elements in a 1-dim array. 

function chromosome = EncodeNetwork(wIH, wHO, wMax)

    wIHFlattened = reshape(wIH.', 1, []);
    wHOFlattened = reshape(wHO.', 1, []);

    chromosome = [wIHFlattened, wHOFlattened];



