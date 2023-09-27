
tabuList = zeros(1, 10);

tabuList(1) = 1; 
tabuList(2) = 1; 

for i = length(tabuList):-1:1
    if tabuList(i) ~= 0
        thisNode = i
        break;
    end
end

