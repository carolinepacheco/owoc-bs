function [M, impFeatureTime] = combClassifier(varargin)

C = zeros(1, size(varargin{1},1));
label_test = struct([]);
disResult = struct([]);
marginData = struct([]);
impF = struct([]);
acP = struct([]);

for k = 1:size(varargin{1},1)
    
    X = (sprintf('Detecting foreground to pixel: %d',k));
    disp(X);
    
    %%%%%%COLOR DATA TEST
    TestDataGray = varargin{1}(k,:);
    TestDataRed = varargin{2}(k,:);
    TestDataGreen = varargin{3}(k,:);
    TestDataBlue = varargin{4}(k,:);
    TestDataHue = varargin{5}(k,:);
    TestDataSaturation = varargin{6}(k,:);
    TestDataTestValue = varargin{7}(k,:);
    
    %%%%%%TEXTURE DATA TEST
    TestDataXCS = varargin{8}(k,:);
    TestDataOCLBPRR = varargin{9}(k,:);
    TestDataOCLBPGG = varargin{10}(k,:);
    TestDataOCLBPBB = varargin{11}(k,:);
    TestDataOCLBPRG = varargin{12}(k,:);
    TestDataOCLBPRB = varargin{13}(k,:);
    TestDataOCLBPGB = varargin{14}(k,:);
    
    %%%%%%EDGE DATA TEST
    TestDataGx = varargin{15}(k,:);
    TestDataGy = varargin{16}(k,:);
    TestDataGmag = varargin{17}(k,:);
    TestDataGdir = varargin{18}(k,:);
    
    %%%%%%MOTION DATA TEST
    TestDataOFlow = varargin{19}(k,:);
    
    %%%%%%MULTISPECTRAL DATA TEST
    TestDataMS1 = varargin{20}(k,:);
    TestDataMS2 = varargin{21}(k,:);
    TestDataMS3 = varargin{22}(k,:);
    TestDataMS4 = varargin{23}(k,:);
    TestDataMS5 = varargin{24}(k,:);
    TestDataMS6 = varargin{25}(k,:);
    TestDataMS7 = varargin{26}(k,:);
    
    dataGT = varargin{30}(k,:);
    dataGT = dataGT';
    
    TestData = [TestDataGray' TestDataRed' TestDataGreen' TestDataBlue'...
        TestDataHue' TestDataSaturation' TestDataTestValue' TestDataXCS' TestDataOCLBPRR'...
        TestDataOCLBPGG' TestDataOCLBPBB' TestDataOCLBPRG' TestDataOCLBPRB' TestDataOCLBPGB'...
        TestDataGx' TestDataGy' TestDataGmag' TestDataGdir' TestDataOFlow' TestDataMS1' TestDataMS2'...
        TestDataMS3' TestDataMS4' TestDataMS5' TestDataMS6' TestDataMS7'];
    
    for c = 1:size(varargin{27}{k},2) %10
        
        checkClassifier = isempty(varargin{27}{k}{c});
        
        if checkClassifier == 0
            
            TestD = TestData(:,varargin{28}{1,k}(c,:));
            w0 = varargin{27}{k}{c};
            outColor = TestD*w0;
            label_test{c} = outColor*labeld;
            disResult{c} = +outColor;
            marginData{k}{c} = TestD;
            
        else
            label_test{c} = [];
            marginData{k}{c} = [];
            
        end
    end
    
    
    for i = 1:size(TestD,1)
        label_target = 0;
        label_outlier = 0;
        label = 0;
        re_label= 0;
        e = 0;
        
        for c = 1:size(varargin{27}{k},2) %10
            
            checkLabel = isempty(label_test{1,c});
            aPool{k}{c} = [];
            clabel{k}{c} = [];
            
            if checkLabel == 0
                
                data = TestD(i,:);
                dataDist = zeros(1, size(data,2));
                
                distance = disResult{c};
                
                if distance(i,1) > distance(i,2)
                    dataDist(1,1:size(data,2)) = distance(i,1);
                    %euclidian distance
                    D = pdist2(data,dataDist,'euclidean');
                    
                    prob = 0.5*exp(-(D)/0.5); %melhor configuracao
                    %prob >=0.95
                    if prob >=0
                        
                        label_outlier = label_outlier + 1;
                        label = 'outlier';
                        re_label = -1;
                        
                    else
                        label_target = label_target + 1;
                        label = 'target ';
                        re_label = 1;
                    end
                end
                
                if distance(i,1) < distance(i,2)
                    dataDist(1,1:size(data,2)) = distance(i,2);
                    D = pdist2(data,dataDist,'euclidean');
                    prob = 0.5*exp(-(D)/0.5); %melhor configuracao
                    
                    if prob >= 0.95
                        label_target = label_target + 1;
                        label = 'target ';
                        re_label = 1;
                        
                    else
                        label_outlier = label_outlier + 1;
                        label = 'outlier';
                        re_label = -1;
                        
                    end
                end
                [accuracyClassPool] = calc_accuracy(label,dataGT(i));
                aPool{k}{c} = accuracyClassPool;  %accuracy calculation each classifiers of pool
                clabel{k}{c} = re_label;
                e = e + 1;
            end
        end
        lab_target(i) = label_target;
        lab_outlier(i) = label_outlier;
        %renew_label(i) = re_label;
        C(k) = e;
        
        %accuracyPool = aPool;
        sPool = size(varargin{27}{k},2);
        
        if (i == 1)
            [impFeature] = adapImCalInitial(C(k), aPool{k});
        end
        
        
        THx = 0;
        L1 = 0;
        strongH = 0;
        for c = 1:size(varargin{27}{k},2) %10
            
            checkClassifier = isempty(varargin{27}{k}{c});
            
            if checkClassifier == 0
                Hx = impFeature{c}*clabel{k}{c};
                THx = THx + Hx;
                L1 = L1 + 1;
            end
        end
        %strongH(k,i) = THx/L1;
        strongH = THx/L1;
        
        %to final classification
        if strongH >= 0
            %if strongH > 0 %otimo resultado
            labelC = 'target ';
            label_out(i) = 0;
            
            %to calculate the margin
            valueM = [label_target label_outlier];
            [g, gi] = max(valueM);
            
            if gi == 1
                marginTO = (label_target - label_outlier)/C(k);
            else
                marginTO = (label_outlier - label_target)/C(k);
            end
            
            %stores the frame position and your margin
            B(1,i)= i; %frame index
            B(2,i)= marginTO; %margin each frame
            
        else
            labelC = 'outlier';
            label_out(i) = 1;
            
        end
        
        
        [accuracyClas] = calc_accuracy(labelC,dataGT(i));
        
        
        %adaptative feature importanc calculation
        [impFeature]= adapImpCal(sPool, aPool{k}, accuracyClas, impFeature);
        
        
        %guarda para cada amostra
        % impFeatureTime{d} = impFeature;
        impF{k} = impFeature;
        % acP{k} = accuracyPool;
        
        
        %time = time + 1;
        impFeatureTime{i} = impF;
        marginDataFrame{i} = marginData;
        accPoolClass{i} = acP;
        
        time= 0;
        if lab_target(i) > lab_outlier(i)
            valueM = [lab_target(i) lab_outlier(i)];
            [G, I] = max(valueM);
            if I == 1
                marginTO = (lab_target(i) - lab_outlier(i))/C(k);
            else
                marginTO = (lab_outlier(i) - lab_target(i))/C(k);
            end
            B(1,i)=i; %frame index
            sB(2,i)= marginTO; %margin each frame
            
            if (time == 80)
                
                [Y,I]=sort(B(2,:));
                
                dataIndex = I(1:3);
                
                for c = 1:size(varargin{27}{k},2) %10
                    
                    checkClassifier = isempty(varargin{27}{k}{c});
                    
                    if checkClassifier == 0
                        
                        for t = 1:size(dataIndex,2)
                            
                            b = marginData{k}{1,c}(dataIndex(t),:);
                            %dw = varargin{30}{k}{c};
                            dw = impFeature{c};
                            varargin{29}{k} = inc_add(varargin{29}{k},+b,+1,dw);
                            varargin{27}{k}{c} = inc_store(varargin{29}{k});
                            
                        end
                        
                    end
                    
                end
                time = 0;
            end
            
        end
        time = time + 1;
        
    end
    
    clearvars impFeature
    clearvars aPool
    clearvars sPool
    clearvars accuracyPool
    M(k,:) = label_out;
    
end
end