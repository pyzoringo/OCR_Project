function result = sudokuImg(img)

%% load library
matFile = load('sudokuLibrary.mat');
library = matFile.sudokuLibrary;

%% excrate number from file, make some settings, initialize variables
numToBeProcessed = extractNumFromImg(img);
scale = 5;
resultInChar = zeros(6, 3);
result = zeros(2,3);

%% extract chars
for i = 1:6
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



