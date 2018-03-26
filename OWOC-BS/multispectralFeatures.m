function [TrainMS1, TrainMS2, TrainMS3, TrainMS4, TrainMS5, TrainMS6, TrainMS7] = multispectralFeatures(path,ext,pattern)
fullpath = fullfile(path,ext);
list = dir(fullpath);
name = {list.name};
str  = sprintf('%s#', name{:});
num  = sscanf(str, pattern);
[dummy, index] = sort(num);
name = name(index)';


for i = 1:size(name,1)
    
    X = (sprintf('Multispectral features to pixel: %d',i));
    disp(X);
    filename = char(name(i));
    filepath = fullfile(path,filename);
    frame = imread(filepath);
    frame = imresize(frame, [160 120]);
    
    for k = 1:7
     myMS(:,:,k) = frame;
    end
   

    %multispectral feature
    %01
    MS1frame = im2double(myMS(:,:,1));
    MS1frame = MS1frame(:);
    TrainMS1(:,i) = MS1frame; %#ok<AGROW>
    
    %02
    MS2frame = im2double(myMS(:,:,2));
    MS2frame = MS2frame(:);
    TrainMS2(:,i) = MS2frame; %#ok<AGROW>
    
    %03
    MS3frame = im2double(myMS(:,:,3));
    MS3frame = MS3frame(:);
    TrainMS3(:,i) = MS3frame; %#ok<AGROW>
    
    %04
    MS4frame = im2double(myMS(:,:,4));
    MS4frame = MS4frame(:);
    TrainMS4(:,i) = MS4frame; %#ok<AGROW>
    
    %05
    MS5frame = im2double(myMS(:,:,5));
    MS5frame = MS5frame(:);
    TrainMS5(:,i) = MS5frame; %#ok<AGROW>
    
    %06
    MS6frame = im2double(myMS(:,:,6));
    MS6frame = MS6frame(:);
    TrainMS6(:,i) = MS6frame; %#ok<AGROW>
    
    %07
    MS7frame = im2double(myMS(:,:,7));
    MS7frame = MS7frame(:);
    TrainMS7(:,i) = MS7frame; %#ok<AGROW>
  
end
    Y = (sprintf('Finalizing multispectral features'));
    disp(Y);
end
