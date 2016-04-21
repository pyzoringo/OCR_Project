function numToBeProcessed = extractNumFromImg(img)
% filename is the filename of the image
% numToBeProcessed is a 3D array (:,:,6), containing six numbers image
% 3rd dimension of numToBeProcessed = [upLeft,     upRight, 
%                                      midLeft,    midRight, 
%                                      bottomLeft, bottomRight]


imageGray = rgb2gray(img);
%% take six number out
numToBeProcessed = zeros(12,29, 6);
upLeft = imageGray(119:119+11, 264:264+28);
upRight = imageGray(119:119+11, 307:307+28);
midLeft = imageGray(366:366+11, 259:259+28);
midRight = imageGray(366:366+11, 315:315+28);
bottomLeft = imageGray(383:383+11, 259:259+28);
bottomRight = imageGray(383:383+11, 315:315+28);
numToBeProcessed(:,:,1) = upLeft;
numToBeProcessed(:,:,2) = upRight;
numToBeProcessed(:,:,3) = midLeft;
numToBeProcessed(:,:,4) = midRight;
numToBeProcessed(:,:,5) = bottomLeft;
numToBeProcessed(:,:,6) = bottomRight;

%% reverse the gray scale, eliminate low level pixel
numToBeProcessed = 255 - double(numToBeProcessed);
numToBeProcessed(numToBeProcessed<50) = 0;
end

