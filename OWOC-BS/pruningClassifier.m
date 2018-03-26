function [E,importancetE] = pruningClassifier(Fdata, w, error, importance)


E = struct([]);
importancetE = struct([]);
for k = 1:size(Fdata,1)
 
    X = (sprintf('Pruning classifiers: %d',k));
    disp (X);
    
    for c = 1:size(w{1,1},2)  %pega quantidade de classificadores automaticamente
        
        w0 = w{1,k}{c};
        if (error{1,k}{1,c} <= 0.3)
          % imp = (1 - error{k}{1,c})/error{k}{1,c};
           % weight = 0.5*(log(imp));
            
            E{k}{c} = w0;
            importancetE{k}{c} = importance{1,k}{1,c};
           % weightE{k}{c} = weight;
            
        else
            
            E{k}{c} = [];
            importancetE{k}{c} = [];
            
        end
    end
    
    % all classifiers have greater error than 0.3
    % therefore I select the one with lower error
    tf = find(~cellfun(@isempty,E{k}), 1);
    checkVector = isempty(tf);
    
    if checkVector == 1
        A = error{1,k};
        A = cell2mat(A);
        [m,I] = min(A);
        w0 = w{1,k}{I};
        %imp = (1 - error{k}{1,c})/error{k}{1,c};
        %weight = 0.5*(log(imp));
        E{k}{I} = w0;
        importancetE{k}{I} = importance{1,k}{1,I};
        %weightE{k}{I} = 1e-12;
        
    end
end
end



