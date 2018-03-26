%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Universite de la Rochelle
% Date: 04/02/2016
% Copyright 2014 by Caroline Pacheco do E.Silva


%  If you have used this code in a scientific publication, we would appreciate citations to
%  the following paper: 2016 - Silva, Caroline; Bouwmans, Thierry;  Frélicot, Carl. "Online Weighted One-Class Ensemble for Feature Selection in Background/Foreground Separation". The International Conference on Pattern Recognition (ICPR), Cancun, Mexico (oral presentation), December, 2016

%  You can found more details at: https://www.behance.net/gallery/63435921/Weighted-Random-Subspace-for-Feature-Selection

%This file is adapted to the MSVS dataset (http://www.fluxdata.com/articles/université-de-bourgogne-uses-fluxdata-fd-1665-create-dataset-background-subtraction)
%You will need to make small adaptations to use with other datasets. If you have any problem, please feel free to contact Caroline Pacheco do E.Silva.
%lolyne.pacheco@gmail.com

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
addpath('prtools/prtools')
addpath('dd_tools')

clear;clc;
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%% LOADING DATA FOR TRAIN
path = 'Train'; ext = '*.png'; pattern = '%d.png#';
[trainGray, trainRed, trainGreen, trainBlue, trainHue, ...
    trainSaturation, trainvalue] = colorFeatures(path,ext,pattern); %color features

%%% LOADING TEXTURE DATA TO TRAIN
[trainXCS, trainOCLBPRR, trainOCLBPGG, trainOCLBPBB, ...
    trainOCLBPRG, trainOCLBPRB, trainOCLBPGB]...
    = textureFeatures(path,ext,pattern); %texture features#

%%% LOADING EDGE DATA TO TRAIN
[trainGx, trainGy, trainGmag, trainGdir] = edgeFeatures(path,ext,pattern); %edge features

%%% LOADING MOTION TO TRAIN
[optflow] = getVideoOpticalFlow(path,ext,pattern); %motion features
[trainOFlow] = motionFeatures(optflow);
[trainOFlow] = real(trainOFlow);

%%% LOADING MULTISPECTRAL TO TRAIN
path = 'TrainMulti'; ext = '*.tif'; pattern = '%d.tif#';
[trainMS1, trainMS2, trainMS3, trainMS4, trainMS5, trainMS6, trainMS7] = ...
    multispectralFeatures(path,ext,pattern);   %multispectral features

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%% LOADING DATA TO VALIDATION
path = 'Validation'; ext = '*.png'; pattern = '%d.png#';
[valGray, valRed, valGreen, valBlue, valHue, ...
    valSaturation, valvalue] = colorFeatures(path,ext,pattern); %color features

%%% LOADING TEXTURE DATA TO VALIDATION
[valXCS, valOCLBPRR, valOCLBPGG, valOCLBPBB, ...
    valOCLBPRG, valOCLBPRB, valOCLBPGB] = textureFeatures(path,ext,pattern); %texture features

%%% LOADING EDGE DATA TO VALIDATION
[valGx, valGy, valGmag, valGdir] = edgeFeatures(path,ext,pattern); %edge features

%%% LOADING MOTION TO VALIDATION
[optflow] = getVideoOpticalFlow(path,ext,pattern); %motion features
[valOFlow] = motionFeatures(optflow);
[valOFlow] = real(valOFlow);

%%% LOADING MULTISPECTRAL TO VALIDATION
path = 'TrainMulti'; ext = '*.tif'; pattern = '%d.tif#';
[valMS1, valMS2, valMS3, valMS4, valMS5, valMS6, valMS7] = ...
    multispectralFeatures(path,ext,pattern);   %multispectral features

%%% LOADING GT TO VALIDATION
path = 'GTValidation'; ext = '*.png'; pattern = '%d.png#';
[gtVal] = getGt(path,ext,pattern);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%% LOADING DATA TO TEST

%%% LOADING COLOR DATA TO TEST 
path = 'Test'; ext = '*.png'; pattern = '%d.png#';
[testGray, testRed, testGreen, testBlue, testHue, ...
    testSaturation, testvalue] = colorFeatures(path,ext,pattern); %color features

%%% LOADING TEXTURE DATA TO TEST
[testXCS, testOCLBPRR, testOCLBPGG, testOCLBPBB, ...
    testOCLBPRG, testOCLBPRB, testOCLBPGB]...
    = textureFeatures(path,ext,pattern); %texture features

%%% LOADING EDGE DATA TO TEST
[testGx, testGy, testGmag, testGdir] = edgeFeatures(path,ext,pattern); %edge features

%%% LOADING MOTION TO TEST
[optflow] = getVideoOpticalFlow(path,ext,pattern); %motion features
[testOFlow] = motionFeatures(optflow);
[testOFlow] = real(testOFlow);

%%% LOADING MULTISPECTRAL TO TEST
path = 'TestMulti'; ext = '*.tif'; pattern = '%d.tif#';
[testMS1, testMS2, testMS3, testMS4, testMS5, testMS6, testMS7] = ...
    multispectralFeatures(path,ext,pattern);   %multispectral features

%%% LOADING GT TO TEST
path = 'GTTest'; ext = '*.png'; pattern = '%d.png#';
[gtTest] = getGt(path,ext,pattern);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% TRAIN CLASSIFIER
[w, addW, sfeatures, error, wagging, poissonD] = trainSample(trainGray, trainRed, trainGreen, trainBlue, trainHue,...
trainSaturation, trainvalue,trainXCS,trainOCLBPRR,trainOCLBPGG, trainOCLBPBB, trainOCLBPRG,trainOCLBPRB,...
trainOCLBPGB,trainGx, trainGy, trainGmag, trainGdir, trainOFlow, trainMS1, trainMS2, trainMS3,trainMS4,...
trainMS5, trainMS6, trainMS7,valGray, valRed, valGreen, valBlue, valHue, valSaturation,valvalue, ...
valXCS,  valOCLBPRR,valOCLBPGG, valOCLBPBB, valOCLBPRG, valOCLBPRB, valOCLBPGB,valGx, valGy,...
valGmag, valGdir,valOFlow, valMS1, valMS2, valMS3, valMS4, valMS5, valMS6,valMS7, gtVal);
%%
%%% PRUNING CLASSIFIERS
[E, weightE] = pruningClassifier(trainGray, w, error, wagging);

%%% COMBINATION CLASSIFIERS
[M, impFeatureTime] = combClassifier(testGray, testRed, testGreen, testBlue, testHue,...
    testSaturation, testvalue, testXCS, testOCLBPRR, testOCLBPGG, testOCLBPBB, testOCLBPRG, ...
    testOCLBPRB, testOCLBPGB, testGx, testGy, testGmag, testGdir, testOFlow, ...
    testMS1, testMS2, testMS3, testMS4, testMS5, testMS6, testMS7, E, sfeatures, addW, gtTest);
%%
%%% SHOW FOREGROUND
imagesc(M)
show_2dvideo(M,160, 120);
%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% EXPERIMENTAL RESULTS
%initial importance
[contF] = featuresHistogram(weightE, sfeatures);