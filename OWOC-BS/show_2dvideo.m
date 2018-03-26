%%% show_2dvideo(2dmatrix,int,int)
%
function show_2dvideo(M,m,n)
mkdir RESULT
for i = 1:size(M,2)
  I = reshape(M(:,i),m,n);
  I = imresize(I, [492 658]); % mudar aqui
  imshow(I,[],'InitialMagnification','fit');
  disp(i);
  pause(0.01);
  %salva image
  % filename = ['arquivo_' num2str(i) '.png'];
  filename = [num2str(i) '.png'];
  folder = 'RESULT/';
  s = strcat(folder,filename);
  imwrite(I, s);
end
end
