function [TrainGx, TrainGy, TrainGmag, TrainGdir] = edgeFeatures(path,ext,pattern)
fullpath = fullfile(path,ext);
list = dir(fullpath);
name = {list.name};
str  = sprintf('%s#', name{:});
num  = sscanf(str, pattern);
[dummy, index] = sort(num);
name = name(index)';

for i = 1:size(name,1)
    
     X = (sprintf('Edge features to pixel: %d',i));
     disp(X);
    
    filename = char(name(i));
    filepath = fullfile(path,filename);
    frame = imread(filepath);
    frame = rgb2gray(frame);
    frame = imresize(frame, [160 120]);
    
    [Gx, Gy] = imgradientxy(frame);
    [Gmag, Gdir] = imgradient(Gx, Gy);

    
    %%%%%%%%Gradients%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    %Gx feature
    Gxframe = (Gx)./255;
    Gxframe = Gxframe(:);
    TrainGx(:,i) = Gxframe; %#ok<AGROW>
    
    %Gy feature
    Gyframe = (Gy)./255;
    Gyframe = Gyframe(:);
    TrainGy(:,i) = Gyframe; %#ok<AGROW>
    
    %Gmag feature
    Gmagframe = (Gmag)./255;
    Gmagframe = Gmagframe(:);
    TrainGmag(:,i) = Gmagframe; %#ok<AGROW>
    
    %Gdir feature
    Gdirframe = (Gdir)./255;
    Gdirframe = Gdirframe(:);
    TrainGdir(:,i) = Gdirframe; %#ok<AGROW>
end
    Y = (sprintf('Finalizing edge features'));
    disp(Y);
end