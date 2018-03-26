function [TrainGray, TrainRed, TrainGreen, TrainBlue, TrainHue, TrainSaturation, Trainvalue] = colorFeatures(path,ext,pattern)
fullpath = fullfile(path,ext);
list = dir(fullpath);
name = {list.name};
str  = sprintf('%s#', name{:});
num  = sscanf(str, pattern);
[dummy, index] = sort(num);
name = name(index)';


for i = 1:size(name,1)
    
    X = (sprintf('Color features to pixel: %d',i));
    disp(X);
    
    filename = char(name(i));
    filepath = fullfile(path,filename);
    frame = imread(filepath);
    frame = imresize(frame, [160 120]);
    
    hsv_frame = imread(filepath);
    hsv_frame = rgb2hsv(frame);
    hsv_frame = imresize(hsv_frame, [160 120]);
    
    
    %gray feature
    grayframe = rgb2gray(frame);
    grayframe = im2double(grayframe);
    grayframe = grayframe(:);
    TrainGray(:,i) = grayframe; %#ok<AGROW>
    
    %red feature
    redframe = frame(:,:,1);
    redframe = im2double(redframe);
    redframe = redframe(:);
    TrainRed(:,i) = redframe;
    
     
    %green feature
    greenframe = frame(:,:,2);
    greenframe = im2double(greenframe);
    greenframe = greenframe(:);
    TrainGreen(:,i) = greenframe;
    
    %blue feature
    blueframe = frame(:,:,3);
    blueframe = im2double(blueframe);
    blueframe = blueframe(:);
    TrainBlue(:,i) = blueframe;
    
    %hue feature
    hueframe = hsv_frame(:,:,1);
    %hueframe = im2double(hsv_frame);
    hueframe = hueframe(:);
    TrainHue(:,i) = hueframe;
    
    %saturation feature
    saturationframe = hsv_frame(:,:,2);
    %saturationframe = im2double(hsv_frame);
    saturationframe = saturationframe(:);
    TrainSaturation(:,i) = saturationframe;
    
    %value feature
    valueframe = hsv_frame(:,:,3);
    %valueframe = im2double(hsv_frame);
    valueframe = valueframe(:);
    Trainvalue(:,i) = valueframe;
end
    Y = (sprintf('Finalizing color features'));
    disp(Y);
end
