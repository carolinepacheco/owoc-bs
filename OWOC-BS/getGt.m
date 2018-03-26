function [GT] = getGt(path,ext,pattern)
fullpath = fullfile(path,ext);
list = dir(fullpath);
name = {list.name};
str  = sprintf('%s#', name{:});
num  = sscanf(str, pattern);
[dummy, index] = sort(num);
name = name(index)';

for i = 1:size(name,1)
    filename = char(name(i));
    filepath = fullfile(path,filename);
    frame = imread(filepath);
    frame = imresize(frame, [160 120]);
    %grayframe = rgb2gray(frame);
    
    %GT
    gtframe = logical(frame);
    gtframe = im2double(gtframe);
    gtframe = gtframe(:);
    GT(:,i) = gtframe;
end
end
  


%L? E EXIBE

%{
% L?, PROCESSA E SALVA COMO IMAGEM
for i = 1:size(filenames,1)
  disp(i);
  filename = char(filenames(i));
  filepath = fullfile(path,filename);
  frame = imread(filepath);
  [pathstr,name,ext] = fileparts(filepath);
  filename_out = fullfile('Output',[name '_out' ext]);
  frame = rgb2gray(frame);
  imwrite(frame,filename_out);
end
%}
%{
% L?, PROCESSA E SALVA COMO VIDEO
nframes = size(filenames,1);
movobj(1:nframes) = struct('cdata', [], 'colormap', []);
for i = 1:nframes
  disp(i);
  filename = char(filenames(i));
  filepath = fullfile(path,filename);
  frame = imread(filepath);
% para GT
  %frame = double(frame).*255;
  [pathstr,name,ext] = fileparts(filepath);
  filename_out = fullfile('Output',[name '_out' ext]);
 % frame = rgb2gray(frame);
 % if(size(frame,3) == 1)
  %  frame = repmat(frame,[1 1 3]);
 % end
  movobj(i).cdata = frame;
end
movie2avi(movobj, 'video.avi', 'compression', 'None');

%}