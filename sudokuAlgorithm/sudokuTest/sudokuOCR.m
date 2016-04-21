function result = sudokuOCR(filename)
% filename is the filename of the PVR image
% resultNumbers is the numbers extracted from the image
% resultNumbers = [upLeft    , upRight;
%                  midLeft   , midRight;
%                  bottomLeft, bottomRight;]
%% load library
matFile = load('sudokuLib.mat');
library = matFile.sudokuLib;

%% excrate number from file, make some settings, initialize variables
numToBeProcessed = extractNumFrom(filename);
scale = 5;
resultInChar = zeros(6, 3);
result = zeros(2,3);

img = imread(filename);
imshow(img,[]);

%% extract chars
for i = 1:6
%     figure(i)
    % create target sudoku
    sudoku = zeros(9,3);
    
    % split numbers into individual char
    charImage = splitToChar(numToBeProcessed(:,:,i));
    
    % increase resolution to better locate center
    bigCharImage = increaseResolution(charImage, scale);
    
    for n = 1:3
        % move bigCharImage center to col:15, row:30
        shiftedBigChar = reCenter(bigCharImage(:,:,n));
        sudoku(:,n) = imgToSudokuArray(shiftedBigChar);
        if any(sudoku(:,n))
            sudokuMap = repmat(sudoku(:,n),1,10);
            sudokuMap = library - sudokuMap;
            sudokuMap = sudokuMap.^2;
            [~,resultInChar(i,n)] = min(sum(sudokuMap,1));
%             stemPoint = sum(sudokuMap,1);
%             relativity = log(max(stemPoint)./stemPoint)/(max(log(max(stemPoint)./stemPoint)));
%             subplot(3,2,2*(n-1)+1); imshow(charImage(:,:,n),[]);
%             subplot(3,2,2*n); stem([1:9,0], relativity);
        else
            resultInChar(i,n) = 0;
        end
    end
end 

%% convert char to numbers
resultInChar = mod(resultInChar,10);
for i = 1: 6
    result(i) = ...
        100*resultInChar(i,1)+10*resultInChar(i,2)+resultInChar(i,3);
end
result = result';
end

