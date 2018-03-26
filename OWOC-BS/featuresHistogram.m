function [contF] = featuresHistogram(weightE, sfeatures)
%find the features frequency of the whole image 
%   initial configuration

contF = zeros(26,1);
contGray = 0;
contRed = 0;
contGreen = 0;
contBlue = 0;
contHue = 0;
contSaturation = 0;
contValue = 0;
contXCS = 0;
contOCLBPRR = 0;
contOCLBPGG = 0;
contCLBPBB = 0;
contOCLBPRG = 0;
contOCLBPRB = 0;
contOCLBPGB = 0;
contGx = 0;
contGy = 0;
contGmag = 0;
contGdir = 0;
contOFlow = 0;
contMS1 = 0;
contMS2 = 0;
contMS3 = 0;
contMS4 = 0;
contMS5 = 0;
contMS6 = 0;
contMS7 = 0;



for k = 1:size(weightE,2)
    
    X = (sprintf('creating histograms: %d',k));
    disp (X);
    
    for c = 1:size(weightE{1,k},2)
        
         tf = find(~cellfun(@isempty,weightE{1,k}(c)), 1);
         checkVector = isempty(tf);
        if checkVector == 0
            
            vfeatures = sfeatures{1,k}{1,1}(c,:);
           
           for n = 1:size(vfeatures,2)
               %gray
               if (vfeatures(1,n)) == 1
                   contGray = contGray + 1;
                   contF(1,1) = contGray;
               end
               
               %red
               if (vfeatures(1,n)) == 2
                   contRed = contRed + 1;
                   contF(2,1) = contRed;
               end
               
               %green
               if (vfeatures(1,n)) == 3
                   contGreen = contGreen + 1;
                   contF(3,1) = contGreen;
               end
               
               %blue
               if (vfeatures(1,n)) == 4
                   contBlue = contBlue + 1;
                   contF(4,1) = contBlue;
               end
               
               %hue
               if (vfeatures(1,n)) == 5
                   contHue = contHue + 1;
                   contF(5,1) = contHue;
               end
               
               %saturation
               if (vfeatures(1,n)) == 6
                   contSaturation = contSaturation + 1;
                   contF(6,1) = contSaturation;
               end
               
               %value
               if (vfeatures(1,n)) == 7
                   contValue = contValue + 1;
                   contF(7,1) = contValue;
               end
               
              %XSC-LBP
               if (vfeatures(1,n)) == 8
                   contXCS = contXCS + 1;
                   contF(8,1) = contXCS;
               end
               
               %OCLBPRR
               if (vfeatures(1,n)) == 9
                   contOCLBPRR = contOCLBPRR + 1;
                   contF(9,1) = contOCLBPRR;
               end
               
               %OCLBPGG
               if (vfeatures(1,n)) == 10
                   contOCLBPGG = contOCLBPGG + 1;
                   contF(10,1) = contOCLBPGG;
               end
               
               %OCLBPBB
               if (vfeatures(1,n)) == 11
                   contCLBPBB = contCLBPBB + 1;
                   contF(11,1) = contCLBPBB;
               end
               
               %OCLBPRG
               if (vfeatures(1,n)) == 12
                   contOCLBPRG = contOCLBPRG + 1;
                   contF(12,1) = contOCLBPRG;
               end
                              
               %OCLBPRB
               if (vfeatures(1,n)) == 13
                   contOCLBPRB = contOCLBPRB + 1;
                   contF(13,1) = contOCLBPRB;
               end
               
               %OCLBPGB
               if (vfeatures(1,n)) == 14
                   contOCLBPGB = contOCLBPGB + 1;
                   contF(14,1) = contOCLBPGB;
               end
               
               %Gx
               if (vfeatures(1,n)) == 15
                   contGx = contGx + 1;
                   contF(15,1) = contGx;
               end
               
               %Gy
               if (vfeatures(1,n)) == 16
                   contGy = contGy + 1;
                   contF(16,1) = contGy;
               end
             
               %Gy
               if (vfeatures(1,n)) == 17
                   contGmag = contGmag + 1;
                   contF(17,1) = contGmag;
               end
               
               %Gdir
               if (vfeatures(1,n)) == 18
                   contGdir = contGdir + 1;
                   contF(18,1) = contGdir;
               end
               
               %OFlow
               if (vfeatures(1,n)) == 19
                   contOFlow = contOFlow + 1;
                   contF(19,1) = contOFlow;
               end
               
               %MS1
               if (vfeatures(1,n)) == 20
                   contMS1 = contMS1 + 1;
                   contF(20,1) = contMS1;
               end
               
               %MS2
               if (vfeatures(1,n)) == 21
                   contMS2 = contMS2 + 1;
                   contF(21,1) = contMS2;
               end
               
               %MS3
               if (vfeatures(1,n)) == 22
                   contMS3 = contMS3 + 1;
                   contF(22,1) = contMS3;
               end
               
               %MS4
               if (vfeatures(1,n)) == 23
                   contMS4 = contMS4 + 1;
                   contF(23,1) = contMS4;
               end
               
               %MS5
               if (vfeatures(1,n)) == 24
                   contMS5 = contMS5 + 1;
                   contF(24,1) = contMS5;
               end
               
               %MS6
               if (vfeatures(1,n)) == 25
                   contMS6 = contMS6 + 1;
                   contF(25,1) = contMS6;
               end
               
               %MS7
               if (vfeatures(1,n)) == 26
                   contMS7 = contMS7 + 1;
                   contF(26,1) = contMS7;
               end

           end

        end
    
    end
    
end

% features= categorical({'Gray', 'Red', 'Green', 'Blue', 'Hue', 'Saturation', 'Value', 'XSC-LBP', ...
%   'OCLBPRR', 'OCLBPGG', 'OCLBPBB', 'OCLBPRG', 'OCLBPRB', 'OCLBPGB', 'Gx', 'Gy', 'Gy', 'Gdir', 'OFlow', ...
%   'M1', 'M2', 'M3', 'M4', 'M5', 'M6', 'M7'});


% histogram show
y = [contF'];
bar(y, 'k');
end