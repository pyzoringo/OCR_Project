load numLibrary.mat

%% generate soduku array
% sudokuLibrary = zeros(10,9);
% for i = 1:10
%     for col = 1:3
%         for row = 1:3
%             % mass center 
%             sudokuPart = numLibrary(20*(row-1)+1 : 20*row, ...
%                 10*(col-1)+1 : 10*col, i);
%             center = [0, 0];
%             [arrayForColCenter,arrayForRowCenter] = ...
%             meshgrid(1:size(sudokuPart,2),1:size(sudokuPart,1));
%             if any(any(sudokuPart))
%                 center(1) = sum(sum(arrayForColCenter.*sudokuPart,1))...
%                                 /sum(sum(sudokuPart,1));
%                 center(2) = sum(sum(arrayForRowCenter.*sudokuPart,2))...
%                                 /sum(sum(sudokuPart,2));
%             end
%         % sudokuLibrary = center location * sum(sum())
%         if any(center)
%             switch col
%                 case 1
%                     sudokuLibrary(i,(col-1)*3+row) ...
%                         = sum(sum(sudokuPart))*...
%                         sqrt((15-center(1))^2+(30-20*(row-1)-center(2))^2);
%                 case 2
%                     sudokuLibrary(i,(col-1)*3+row) ...
%                         = sum(sum(sudokuPart))*...
%                         sqrt((5-center(1))^2+(30-20*(row-1)-center(2))^2);
%                 case 3
%                     sudokuLibrary(i,(col-1)*3+row) ...
%                         = sum(sum(sudokuPart))*...
%                         sqrt((5+center(1))^2+(30-20*(row-1)-center(2))^2);
%             end
%         else
%             sudokuLibrary(i,(col-1)*3+row) = 0;
%         end
%         end
%     end
% end
%% extract numbers 
numToBeProcessed = extractNumFrom('p16.jpg');
scale = 5;
resultInChar = zeros(6, 3);
result = zeros(2,3);

for i = 1:6
    % split numbers into individual char
    % first 6:11, second 14:19, third: 21:26
%     charImage = zeros(12,6,3);
%     charImage(:,:,1) = numToBeProcessed(:,6:11,i);
%     charImage(:,:,2) = numToBeProcessed(:,14:19,i);
%     charImage(:,:,3) = numToBeProcessed(:,21:26,i);
    charImage = splitToChar(numToBeProcessed(:,:,i));
    % increase resolution to better locate center
    bigCharImage = increaseResolution(charImage, scale);
    % move bigCharImage center to col:15, row:30
%     [arrayForColCenter,arrayForRowCenter] = ...
%     meshgrid(1:size(bigCharImage,2),1:size(bigCharImage,1));
%     center = zeros(3,2);
     shiftedBigChar = zeros(size(bigCharImage));
    for x = 1:3
%         if any(any(bigCharImage(:,:,x)))
%             center(x,1) = sum(sum(arrayForColCenter.*bigCharImage(:,:,x),1))...
%             /sum(sum(bigCharImage(:,:,x),1));
%             center(x,2) = sum(sum(arrayForRowCenter.*bigCharImage(:,:,x),2))...
%             /sum(sum(bigCharImage(:,:,x),2));
%         else 
%             center(x,:) = [30,15];
%         end
%     end
%     center = round(center);
%     for x = 1:3
%         shiftedBigChar(:,:,x) = ...
%         circshift(bigCharImage(:,:,x), 30-center(x,2));
%         shiftedBigChar(:,:,x) = ...
%         circshift(shiftedBigChar(:,:,x), 15-center(x,1),2);
        shiftedBigChar(:,:,x) = reCenter(bigCharImage(:,:,x));
    end
    % create target sudoku
    sudoku = zeros(9,3);
    for n = 1:3
%         for col = 1:3
%             for row = 1:3
%                 sudokuPart = shiftedBigChar(20*(row-1)+1 : 20*row, ...
%                 10*(col-1)+1 : 10*col,n);
%                 center = [0, 0];
%                 [arrayForColCenter,arrayForRowCenter] = ...
%                 meshgrid(1:size(sudokuPart,2),1:size(sudokuPart,1));
%                 if any(any(sudokuPart))
%                     center(1) = sum(sum(arrayForColCenter.*sudokuPart,1))...
%                                 /sum(sum(sudokuPart,1));
%                     center(2) = sum(sum(arrayForRowCenter.*sudokuPart,2))...
%                                 /sum(sum(sudokuPart,2));
%                 end
%                 % sudoku = center location * sum(sum())
%                 if any(center)
%                     switch col
%                         case 1
%                             sudoku(n,(col-1)*3+row) ...
%                                 = sum(sum(sudokuPart))*...
%                                 sqrt((15-center(1))^2+(30-20*(row-1)-center(2))^2);
%                         case 2
%                             sudoku(n,(col-1)*3+row) ...
%                                 = sum(sum(sudokuPart))*...
%                                 sqrt((5-center(1))^2+(30-20*(row-1)-center(2))^2);
%                         case 3
%                             sudoku(n,(col-1)*3+row) ...
%                                 = sum(sum(sudokuPart))*...
%                                 sqrt((5+center(1))^2+(30-20*(row-1)-center(2))^2);
%                     end
%                 else
%                     sudoku(n,(col-1)*3+row) = 0;
%                 end
%             end
%         end
        sudoku(:,n) = imgToSudokuArray(shiftedBigChar(:,:,n));
    end
%     resultMesh = sudokuLibrary * sudoku;
%     for n = 1:3
%         if any(sudoku(:,n))
%             [~,resultInChar(i,n)] = max(resultMesh(:,n));
%         else
%             resultInChar(i,n) = 0;
%         end
%     end

for n = 1:3
    if any(sudoku(:,n))
        sudokuMap = repmat(sudoku(:,n),1,10);
        sudokuMap = sudokuLibrary2 - sudokuMap;
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
