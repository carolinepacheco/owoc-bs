%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Universite de la Rochelle
% Date: 04/02/2016
% Copyright 2014 by Caroline Pacheco do E.Silva


%  If you have used this code in a scientific publication, we would appreciate citations to
%  the following paper: 2016 - Silva, Caroline; Bouwmans, Thierry;  Frelicot, Carl. "Online Weighted One-Class Ensemble for Feature Selection in Background/Foreground Separation". The International Conference on Pattern Recognition (ICPR), Cancun, Mexico (oral presentation), December, 2016

%  You can found more details at: https://www.behance.net/gallery/63435921/Weighted-Random-Subspace-for-Feature-Selection

%This file allows you to view the result obtained by the authors in the scene 2 using the MSVS dataset (http://www.fluxdata.com/articles/université-de-bourgogne-uses-fluxdata-fd-1665-create-dataset-background-subtraction)

%Important remark: If you want to train your own images please go to the OWOC-BS folder
%  If you have any problem, please feel free to contact Caroline Pacheco do E.Silva.
%  lolyne.pacheco@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
clear;clc;

%%% LOAD DATA
load('data.mat')

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% SHOW FOREGROUND
imagesc(M)
show_2dvideo(M,160, 120);
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% EXPERIMENTAL RESULTS

% Initial Feature Importance
[contF] = featuresHistogram(weightE, sfeatures);