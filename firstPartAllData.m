patientFiles = dir...
    ('/Users/Pyzo/Dropbox/UM/M/2016Spring/OCR_Project/patientData/*.jpg');
figure1 = figure(1);
set(figure1, 'Name', 'patientData');
PVRImageGray = zeros(788,600,length(patientFiles));
for i = 1: length(patientFiles)
    filename = strcat(patientFiles(i).name);
    PVRImageColor = imread(strcat(...
        '/Users/Pyzo/Dropbox/UM/M/2016Spring/OCR_Project/patientData/',...
        filename));
    PVRImageGray(:,:,i) = rgb2gray(PVRImageColor);
    figure(1);
    subplot(4,4,i);imshow(PVRImageGray(:,:,i),[]);
end
upLeft = zeros(12, 29, length(patientFiles));
upRight = zeros(12, 29, length(patientFiles));
midLeft = zeros(12, 29, length(patientFiles));
midRight = zeros(12, 29, length(patientFiles));
bottomLeft = zeros(12, 29, length(patientFiles));
bottomRight = zeros(12, 29, length(patientFiles));

for i = 1: length(patientFiles)
    upLeft(:,:,i) = PVRImageGray(119:119+11, 264:264+28, i);
    upRight(:,:,i) = PVRImageGray(119:119+11, 307:307+28, i);
    midLeft(:,:,i) = PVRImageGray(366:366+11, 259:259+28, i);
    midRight(:,:,i) = PVRImageGray(366:366+11, 315:315+28, i);
    bottomLeft(:,:,i) = PVRImageGray(383:383+11, 259:259+28, i);
    bottomRight(:,:,i) = PVRImageGray(383:383+11, 315:315+28, i);
end
allNumbersImage = zeros(12, 29, length(patientFiles), 6);
allNumbersImage(:,:,:,1) = upLeft;
allNumbersImage(:,:,:,2) = upRight;
allNumbersImage(:,:,:,3) = midLeft;
allNumbersImage(:,:,:,4) = midRight;
allNumbersImage(:,:,:,5) = bottomLeft;
allNumbersImage(:,:,:,6) = bottomRight;
allNumbersImage = uint8(allNumbersImage);
% brachialRight = PVRImageGray(119:119+12, 264:264+28, 1);
figure2 = figure(2);
set(figure2, 'Name', 'upLeft')
figure3 = figure(3);
set(figure3, 'Name', 'upRight')
figure4 = figure(4);
set(figure4, 'Name', 'midLeft')
figure5 = figure(5);
set(figure5, 'Name', 'midRight')
figure6 = figure(6);
set(figure6, 'Name', 'bottomLeft')
figure7 = figure(7);
set(figure7, 'Name', 'bottomRight')
for n = 2:7 
    for i = 1: length(patientFiles)
        figure(n);
        subplot(4,4,i), imshow(uint8(allNumbersImage(:,:,i,n-1)));
    end
end
%% ocr failed
% allNumbers = cell(4, 4, 6);
% for n = 1:6
%     for row = 1:4
%         for col = 1:4
%             ocrStruct = ocr(allNumbersImage(:,:,(row-1)*4+col, n));
%             allNumbers{row, col, n} = ocrStruct.Words;
%         end
%     end
% end
% upleftNumber = cell(4, 4);
% for row = 1: 4
%     for col = 1:4
%         ocrStruct = ocr(uint8(upLeft(:,:,row*4+col)));
%         upleftNumber{row, col} = ocrStruct.Words;
%     end
% end
%%
allNumbersImage = 255-double(allNumbersImage);
allNumbersImage(allNumbersImage<50) = 0;

for n = 2:7 
    for i = 1: length(patientFiles)
        figure(n);
        subplot(4,4,i), imshow(uint8(allNumbersImage(:,:,i,n-1)));
    end
end