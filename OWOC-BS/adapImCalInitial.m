function  [wPoolClasP, ePoolAc] = adapImCalInitial(nPool, aPool)
%initial feature importanc calculation
   
 
for i = 1:size(aPool,2) %10
    
    checkClassifier = isempty(aPool{i});
   
    
    if checkClassifier == 0
        wPoolClasP{i} = 1/nPool; %size(newPool,2);
        ePoolAc{i} = aPool{i};
    else
        wPoolClasP{i} = [];
        ePoolAc{i} = [];
    
    end
    
   
end