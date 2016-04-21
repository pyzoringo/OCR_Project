function sudokuArray = imgToSudokuArray(image)
% Transform an img to 1D sudokuArray
% require the background to be 0s.

%% resize img to multiple of 3(newImage)
[imgRow, imgCol] = size(image);
% check if the img size is too small, if too small, scale up to
% min(size()) = 30
if imgRow<60 || imgCol<30
    scaleFactor = ceil(30/min(imgRow, imgCol));
    image = increaseImgResolution(image,scaleFactor);
end
% round size to multiple of 6
newImgRow = ceil(imgRow/6)*6; 
newImgCol = ceil(imgCol/6)*6;
% create newImage
newImage = zeros(newImgRow, newImgCol);
newImage(1:imgRow, 1:imgCol) = image;

%% split the newImage, generate sudokuArray
% splite newImage into a 3*3 cellArray
sudokuImageArray = mat2cell(newImage, ...
    [newImgRow/3,newImgRow/3,newImgRow/3], ...
    [newImgCol/3,newImgCol/3,newImgCol/3]);
sudokuArray = zeros(9,1);
% calculate mass center of each sudoku block
for col = 1:3
    for row = 1:3
        % blockCenter = [centerOfCol, centerOfRow]
        block = sudokuImageArray{row,col};
        blockCenter = calcCenter(block);
        % calculate the weighted block massCenter distance
        if any(blockCenter)
            switch col
                case 1
                    sudokuArray((col-1)*3+row) = ...
                        sum(sum(block))*sqrt((newImgCol/2-blockCenter(1))^2 ...
                        +(newImgRow/2-newImgRow/3*(row-1)-blockCenter(2))^2);
                case 2
                    sudokuArray((col-1)*3+row) = ...
                        sum(sum(block))*sqrt((newImgCol/6-blockCenter(1))^2 ...
                        +(newImgRow/2-newImgRow/3*(row-1)-blockCenter(2))^2);
                case 3
                    sudokuArray((col-1)*3+row) = ...
                        sum(sum(block))*sqrt((newImgCol/6+blockCenter(1))^2 ...
                        +(newImgRow/2-newImgRow/3*(row-1)-blockCenter(2))^2);
            end
        else
            sudokuArray((col-1)*3+row) = 0;
        end
    end
end
                            
        

end
