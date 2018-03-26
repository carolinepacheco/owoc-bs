function [TrainOFlow] = motionFeatures(optflow)

% fullpath = fullfile(path,ext);
% list = dir(fullpath);
% name = {list.name};
% str  = sprintf('%s#', name{:});
% num  = sscanf(str, pattern);
% [dummy, index] = sort(num);
% name = name(index)';

for i = 1:size(optflow,2)
    X = (sprintf('Motion features to pixel: %d',i));
    disp(X);
    filename = optflow{i};
    filename = im2double(filename);
    filename = imresize(filename, [160 120]);
    opticalFlow = filename(:);
    TrainOFlow(:,i) = opticalFlow; %#ok<AGROW>
end
    Y = (sprintf('Finalizing motion features'));
    disp(Y);
end