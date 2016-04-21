
load numLibrary.mat
filename = 'p16.jpg';
img = imread(filename);

imshow(img); hold on
%% generate soduku array
sudokuTestLibrary = zeros(9,10);
for i = 1:10
    sudokuTestLibrary(:,i) = imgToSudokuArray(numLibrary(:,:,i));
end

%% extract numbers
numToBeProcessed = extractNumFrom(filename);
scale = 5;
resultInChar = zeros(6, 3);
result = zeros(2,3);
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
            sudokuMap = sudokuTestLibrary - sudokuMap;
            sudokuMap = sudokuMap.^2;
            [~,resultInChar(i,n)] = min(sum(sudokuMap,1));
        else
            resultInChar(i,n) = 0;
        end
    end
end 

resultInChar = mod(resultInChar,10);
for i = 1: 6
    result(i) = ...
        100*resultInChar(i,1)+10*resultInChar(i,2)+resultInChar(i,3);
end
result = result'