function [TrainXCS, TrainOCLBPRR, TrainOCLBPGG, TrainOCLBPBB, TrainOCLBPRG, TrainOCLBPRB, TrainOCLBPGB] = textureFeatures(path,ext,pattern)
fullpath = fullfile(path,ext);
list = dir(fullpath);
name = {list.name};
str  = sprintf('%s#', name{:});
num  = sscanf(str, pattern);
[dummy, index] = sort(num);
name = name(index)';

for i = 1:size(name,1)
    
    X = (sprintf('Texture features to pixel: %d',i));
    disp(X);
    filename = char(name(i));
    filepath = fullfile(path,filename);
    frame = imread(filepath);
    
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%XCS-LBP%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % parameter set

    % 1. "FxRadius", "FyRadius" and "TInterval" are the radii parameter along X, Y and T axis; They can be 1, 2, 3 and 4. "1" and "3" are recommended.
    %  Pay attention to "TInterval". "TInterval * 2 + 1" should be smaller than the length of the input sequence "Length".
    % For example, if one sequence includes seven frames, and you set TInterval
    % to three, only the pixels in the frame 4 would be considered as central
    % pixel and computed to get theXTC-SLBP feature.
    FxRadius = 1;
    FyRadius = 1;
  

    % 2. "TimeLength" and "BoderLength" are the parameters for bodering parts in time and space which would not
    % be computed for features. Usually they are same to TInterval and the
    % bigger one of "FxRadius" and "FyRadius";
    BorderLength = 1;

    % Compute uniform patterns
    NeighborPoints = [8 8 8]; % XY, XT, and YT planes, respectively
    
    % double image
    I = rgb2gray(frame);
    I = double(I);
    XCS = XCSLBP(I,FxRadius, FyRadius, NeighborPoints, BorderLength);

    XCS = XCS*(255/16);
    
    %XCS-LBP feature
    XCSframe = im2double(XCS);
    XCSframe = imresize(XCSframe, [160 120]);
    XCSframe = XCSframe(:);
    TrainXCS(:,i) = XCSframe; %#ok<AGROW>
    
%     % LBP feature
%     LBPframe = imresize(I, [160 120]);
%     LBPframe = double(rgb2gray(LBPframe));
%     LBPframe = double(efficientLBP(LBPframe, [3 3], true));
%     LBPframe = LBPframe(:);
%     TrainLBP(:,i) = LBPframe; %#ok<AGROW>
%     
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%0CLBP%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    clrChans={'R', 'G', 'B'};

    % % % This will result in a list of all possible combinations
    chnsComb=perms(1:size(frame,3));
    chnsComb=chnsComb(:, 1:2);

    % % This is a list of relevant combinations
    chnsComb=nchoosek(1:size(frame,3), 2); % Color channels combinations
 
    % % Add self color LBP on top of inter color relations
    chnsComb=cat(1, [1, 1; 2, 2; 3, 3], chnsComb);
    neighDims=[3,3];
    isEfficient=true;

    OCLBP= oppositeColorLBP(frame, neighDims, chnsComb, isEfficient);
    
    %OCLBP feature
    OCLBPframe = im2double(OCLBP);
    OCLBPframe = imresize(OCLBPframe, [160 120]);
    
 
    %%% Center-R, neighborhood-R
    OCLBPRR = OCLBPframe(:,:,1);
    OCLBPRR = OCLBPRR(:);
    TrainOCLBPRR(:,i) = OCLBPRR; %#ok<AGROW>
    
    %%% Center-G, neighborhood-G
    OCLBPGG = OCLBPframe(:,:,2);
    OCLBPGG = OCLBPGG(:);
    TrainOCLBPGG(:,i) = OCLBPGG; %#ok<AGROW>
    
    %%% Center-B, neighborhood-B
    OCLBPBB = OCLBPframe(:,:,3);
    OCLBPBB = OCLBPBB(:);
    TrainOCLBPBB(:,i) = OCLBPBB; %#ok<AGROW>
    
    %%% Center-R, neighborhood-G
    OCLBPRG = OCLBPframe(:,:,4);
    OCLBPRG = OCLBPRG(:);
    TrainOCLBPRG(:,i) = OCLBPRG; %#ok<AGROW>
    
    %%% Center-R, neighborhood-B
    OCLBPRB = OCLBPframe(:,:,5);
    OCLBPRB = OCLBPRB(:);
    TrainOCLBPRB(:,i) = OCLBPRB; %#ok<AGROW>
    
    %%% Center-G, neighborhood-B
    OCLBPGB = OCLBPframe(:,:,6);
    OCLBPGB = OCLBPGB(:);
    TrainOCLBPGB(:,i) = OCLBPGB; %#ok<AGROW>
    
end
    Y = (sprintf('Finalizing texture features'));
    disp(Y);

end