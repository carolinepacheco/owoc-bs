function [w, addW, sfeatures, mError, mImpClass, poissonD] = trainSample(varargin)
             
w = struct([]);
W = struct([]);
w1 = struct([]);
meanError = struct([]);
poissonD = struct([]);
sfeatures = struct([]);
mError = struct([]);
addW = struct([]);
mImpClass = struct([]);
distP = struct([]);
meanImpClass = struct([]);
        
mu = 0; sd =  0.01;    %# mean, std dev
C = 1; ktype = 'r'; kpar = 4;

for k = 1:size(varargin{1},1)
    X = (sprintf('Training pixel: %d',k));
    disp(X);
    
    %%%%%%COLOR DATA TRAIN
    TrainDataGray = varargin{1}(k,:);
    TrainDataGray = TrainDataGray + randn(size(TrainDataGray))*sd + mu;
    
    TrainDataRed = varargin{2}(k,:);
    TrainDataRed = TrainDataRed + randn(size(TrainDataRed))*sd + mu;
    
    TrainDataGreen = varargin{3}(k,:);
    TrainDataGreen = TrainDataGreen + randn(size(TrainDataGreen))*sd + mu;
    
    TrainDataBlue = varargin{4}(k,:);
    TrainDataBlue = TrainDataBlue + randn(size(TrainDataBlue))*sd + mu;
    
    TrainDataHue = varargin{5}(k,:);
    TrainDataHue = TrainDataHue + randn(size(TrainDataHue))*sd + mu;
    
    TrainDataSaturation = varargin{6}(k,:);
    TrainDataSaturation = TrainDataSaturation + randn(size(TrainDataSaturation))*sd + mu;
    
    TrainDataValue = varargin{7}(k,:);
    TrainDataValue = TrainDataValue + randn(size(TrainDataValue))*sd + mu;
    
    %%%%%%TEXTURE DATA TRAIN
    TrainDataXCS = varargin{8}(k,:);
    TrainDataXCS = TrainDataXCS + randn(size(TrainDataXCS))*sd + mu;
    
%     TrainDataLBP = varargin{9}(k,:);
%     TrainDataLBP = TrainDataLBP + randn(size(TrainDataLBP))*sd + mu;
    
    TrainDataOCLBPRR = varargin{9}(k,:);
    TrainDataOCLBPRR = TrainDataOCLBPRR + randn(size(TrainDataOCLBPRR))*sd + mu;
    
    TrainDataOCLBPGG = varargin{10}(k,:);
    TrainDataOCLBPGG = TrainDataOCLBPGG + randn(size(TrainDataOCLBPGG))*sd + mu;
    
    TrainDataOCLBPBB = varargin{11}(k,:);
    TrainDataOCLBPBB = TrainDataOCLBPBB + randn(size(TrainDataOCLBPBB))*sd + mu;
    
    TrainDataOCLBPRG = varargin{12}(k,:);
    TrainDataOCLBPRG = TrainDataOCLBPRG + randn(size(TrainDataOCLBPRG))*sd + mu;
    
    TrainDataOCLBPRB = varargin{13}(k,:);
    TrainDataOCLBPRB = TrainDataOCLBPRB + randn(size(TrainDataOCLBPRB))*sd + mu;
    
    TrainDataOCLBPGB = varargin{14}(k,:);
    TrainDataOCLBPGB = TrainDataOCLBPGB + randn(size(TrainDataOCLBPGB))*sd + mu;
    
    %%%%%%EDGE DATA TRAIN
    TrainDataGx = varargin{15}(k,:);
    TrainDataGx = TrainDataGx + randn(size(TrainDataGx))*sd + mu;
    
    TrainDataGy = varargin{16}(k,:);
    TrainDataGy = TrainDataGy + randn(size(TrainDataGy))*sd + mu;
    
    TrainDataGmag = varargin{17}(k,:);
    TrainDataGmag = TrainDataGmag + randn(size(TrainDataGmag))*sd + mu;
    
    TrainDataGdir = varargin{18}(k,:);
    TrainDataGdir = TrainDataGdir + randn(size(TrainDataGdir))*sd + mu;
    
    %%%%%%MOTION DATA TRAIN
    TrainDataOFlow = varargin{19}(k,:);
    TrainDataOFlow = TrainDataOFlow + randn(size(TrainDataOFlow))*sd + mu;
    
    %%%%%%MULTISPECTRAL DATA TRAIN
    TrainDataMS1 = varargin{20}(k,:);
    TrainDataMS1 = TrainDataMS1+ randn(size(TrainDataMS1))*sd + mu;
    
    TrainDataMS2 = varargin{21}(k,:);
    TrainDataMS2 = TrainDataMS2+ randn(size(TrainDataMS2))*sd + mu;
    
    TrainDataMS3 = varargin{22}(k,:);
    TrainDataMS3 = TrainDataMS3+ randn(size(TrainDataMS3))*sd + mu;
    
    TrainDataMS4 = varargin{23}(k,:);
    TrainDataMS4 = TrainDataMS4+ randn(size(TrainDataMS4))*sd + mu;
    
    TrainDataMS5 = varargin{24}(k,:);
    TrainDataMS5 = TrainDataMS5+ randn(size(TrainDataMS5))*sd + mu;
    
    TrainDataMS6 = varargin{25}(k,:);
    TrainDataMS6 = TrainDataMS6+ randn(size(TrainDataMS6))*sd + mu;
    
    TrainDataMS7 = varargin{26}(k,:);
    TrainDataMS7 = TrainDataMS7+ randn(size(TrainDataMS7))*sd + mu;
    
    %%%%%%COLOR DATA VALIDATION
    ValDataGray = varargin{27}(k,:);
    ValDataRed = varargin{28}(k,:);
    ValDataGreen = varargin{29}(k,:);
    ValDataBlue = varargin{30}(k,:);
    ValDataHue = varargin{31}(k,:);
    ValDataSaturation = varargin{32}(k,:);
    ValDataValue = varargin{33}(k,:);
    
    %%%%%%TEXTURE DATA VALIDATION
    ValDataXCS = varargin{34}(k,:);
    %ValDataLBP = varargin{35}(k,:);
    ValDataOCLBPRR = varargin{35}(k,:);
    ValDataOCLBPGG = varargin{36}(k,:);
    ValDataOCLBPBB = varargin{37}(k,:);
    ValDataOCLBPRG = varargin{38}(k,:);
    ValDataOCLBPRB = varargin{39}(k,:);
    ValDataOCLBPGB = varargin{40}(k,:);
    
    %%%%%%EDGE DATA VALIDATION
    ValDataGx = varargin{41}(k,:);
    ValDataGy = varargin{42}(k,:);
    ValDataGmag = varargin{43}(k,:);
    ValDataGdir = varargin{44}(k,:);
    
    %%%%%%MOTION DATA VALIDATION
    ValDataOFlow = varargin{45}(k,:);
    
    %%%%%%MULTISPECTRAL DATA VALIDATION
    ValDataMS1 = varargin{46}(k,:);
    ValDataMS2 = varargin{47}(k,:);
    ValDataMS3 = varargin{48}(k,:);
    ValDataMS4 = varargin{49}(k,:);
    ValDataMS5 = varargin{50}(k,:);
    ValDataMS6 = varargin{51}(k,:);
    ValDataMS7 = varargin{52}(k,:);
    
    %%%GT - VALIDATION
    DataGT = varargin{53}(k,:);
    DataGT = DataGT';
     
     TrainData = [TrainDataGray' TrainDataRed' TrainDataGreen' ...
         TrainDataBlue' TrainDataHue' TrainDataSaturation' TrainDataValue'...
         TrainDataXCS' TrainDataOCLBPRR' TrainDataOCLBPGG' TrainDataOCLBPBB' ...
         TrainDataOCLBPRG' TrainDataOCLBPRB' TrainDataOCLBPGB' TrainDataGx' ...
         TrainDataGy' TrainDataGmag' TrainDataGdir' TrainDataOFlow' TrainDataMS1'...
         TrainDataMS2', TrainDataMS3', TrainDataMS4' TrainDataMS5' TrainDataMS6' TrainDataMS7'];
     
      
    ValData = [ValDataGray' ValDataRed' ValDataGreen' ValDataBlue'...
        ValDataHue' ValDataSaturation' ValDataValue' ValDataXCS' ValDataOCLBPRR'...
        ValDataOCLBPGG' ValDataOCLBPBB' ValDataOCLBPRG' ValDataOCLBPRB' ValDataOCLBPGB'...
        ValDataGx', ValDataGy' ValDataGmag' ValDataGdir' ValDataOFlow' ValDataMS1' ValDataMS2'...
         ValDataMS3'  ValDataMS4' ValDataMS5' ValDataMS6' ValDataMS7'];
    
 
    
    SelecFeature = oc_set(TrainData,'1');
    SelecFeature = SelectRandomSubspace(SelecFeature,5,10);
    
    label_data = size(TrainData);
    label_data = ones(label_data(1),1);
    indices = crossvalind('Kfold',label_data,10);
    
    for c = 1:10
        
        TrainDataS = TrainData(:,SelecFeature(c,:));
        ValDataS = ValData(:,SelecFeature(c,:));
        errorc = 0;
        impClassc = 0;
        %10-fold
        for i = 1:10
            test = (indices == i); train = ~test;
            %gera peso para cada amostra color (poisson distribution)
            pdwc = (poissrnd(5,size(TrainData,1),1));
            dwc = (pdwc - min(pdwc))/(max(pdwc) - min(pdwc));
            %      dwc = (poissrnd(5,size(TrainDataS,1),1));
            
            W{c} = inc_setup('svdd',ktype,kpar,C,TrainDataS(train,:),label_data, dwc);
            w0 = inc_store(W{c});
            outColor = ValDataS(test,:)*w0;
            label_test_color = outColor*labeld;
            [error, impClass] = calc_error(label_test_color, DataGT);
            errorc =  errorc + error;
            impClassc = impClass + impClassc;
            pA{i} = dwc;
        end
        errorc = errorc/i;
        impClassc = impClassc/i;
        distP{c} = pA{i};
        w1{c} = w0;
        meanError{c} = errorc;
        meanImpClass{c} = impClassc;

    end
    poissonD{k} = distP;
    addW{k} = W{c};
    % armazena todos os 10 classificadores para um determinado pixel
    w{k} = w1;
    mError{k} = meanError;
    mImpClass{k} = meanImpClass;
    %featIndex{k} =  SelecFeature;
    sfeatures{k} = SelecFeature;
end
end
