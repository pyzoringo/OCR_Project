function result = ocrNum(numToBeProcessed)
% numToBeProcessed is the output from function extractNumFrom(filename)
% result contains 6 recognized numbers
% result = [upLeft, upRight, midLeft, midRight, bottomLeft, bottomRight]
matFile = load('numLibrary.mat');
library = matFile.numLibrary;
% preallocate result and result in char
resultInChar = zeros(6, 3);
result = zeros(2,3);
% scale facter for increasing resolution of charImage
scale = 5;
% begin ocr
for i = 1:6
    % split numbers into individual char
    %% first 6:11, second 14:19, third: 21:26
    charImage = zeros(12,6,3);
    charImage(:,:,1) = numToBeProcessed(:,6:11,i);
    charImage(:,:,2) = numToBeProcessed(:,14:19,i);
    charImage(:,:,3) = numToBeProcessed(:,21:26,i);
    % increase resolution to better locate center
    bigCharImage = increaseResolution(charImage, scale);
    %% move bigCharImage center to col:15, row:30
    [arrayForColCenter,arrayForRowCenter] = ...
    meshgrid(1:size(bigCharImage,2),1:size(bigCharImage,1));
    center = zeros(3,2);
    for x = 1:3
        if any(any(bigCharImage(:,:,x)))
            center(x,1) = sum(sum(arrayForColCenter.*bigCharImage(:,:,x),1))...
            /sum(sum(bigCharImage(:,:,x),1));
            center(x,2) = sum(sum(arrayForRowCenter.*bigCharImage(:,:,x),2))...
            /sum(sum(bigCharImage(:,:,x),2));
        else 
            center(x,:) = [30,15];
        end
    end
    center = round(center);
    shiftedBigChar = zeros(size(bigCharImage));
    for x = 1:3
        shiftedBigChar(:,:,x) = ...
        circshift(bigCharImage(:,:,x), 30-center(x,2));
        shiftedBigChar(:,:,x) = ...
        circshift(shiftedBigChar(:,:,x), 15-center(x,1),2);
    end
    %% compare with library, by multiplying sample and library 
    for x = 1:3
        corStem = zeros(10,1);
        for m = 1:10
            corStem(m) = sum(sum(shiftedBigChar(:,:,x).*library(:,:,m)));
        end
        if any(any(bigCharImage(:,:,x)))
            [~, resultInChar(i,x)] = max(corStem);
        else 
            resultInChar(i,x) = 0;
        end
    end
end
%% fill in result
resultInChar = mod(resultInChar,10);
for i = 1: 6
    result(i) = ...
        100*resultInChar(i,1)+10*resultInChar(i,2)+resultInChar(i,3);
end
result = result';
end
