%% get a number
target = allNumbersImage(:,:,:,6);
% upLeft:       7:11(6:11), 14:19, 21:26 
% upRight:      6:10(6:11), 13:18, 21:26
% midLeft:      7:10(6:11), 13:18, 21:26
% midRight:     6:10(6:11), 13:18, 21:26
% bottomLeft:   7:11(6:11), 14:19, 21:26
% bottomRight:  6:10(6:11), 13:18, 21:26
final = zeros(16,3);
for i = 1:16
    scale = 5;
    num = zeros(12, 6, 3);
    % since I will adjust the mass center of the numbers
    % I don't need to change these anymore
    num(:,:,1) = target(:,6:11,i);
    num(:,:,2) = target(:,14:19,i);
    num(:,:,3) = target(:,21:26,i);
    bigNum = increaseResolution(num,scale);
    % move bigNum center to col:15, row:30
    [arrayForColCenter,arrayForRowCenter] = ...
    meshgrid(1:size(bigNum,2),1:size(bigNum,1));
    center = zeros(3,2);
    for x = 1:3
        if any(any(bigNum(:,:,x)))
            center(x,1) = sum(sum(arrayForColCenter.*bigNum(:,:,x),1))...
            /sum(sum(bigNum(:,:,x),1));
            center(x,2) = sum(sum(arrayForRowCenter.*bigNum(:,:,x),2))...
            /sum(sum(bigNum(:,:,x),2));
        else 
            center(x,:) = [30,15];
        end
    end
    center = round(center);
    shiftedBigNum = zeros(size(bigNum));
    for x = 1:3
        shiftedBigNum(:,:,x) = ...
        circshift(bigNum(:,:,x), 30-center(x,2));
        shiftedBigNum(:,:,x) = ...
        circshift(shiftedBigNum(:,:,x), 15-center(x,1),2);
    end
    for n = 1:3
        corStem = zeros(10,1);
        for m = 1:10
            corStem(m) = sum(sum(shiftedBigNum(:,:,n).*shiftedBigAvgSample(:,:,m)));
        end
        if any(any(bigNum(:,:,n)))
            [maxNorm, final(i,n)] = max(corStem);
        else 
            final(i,n) = 0;
        end
    end
end
final = mod(final,10);
ocr_number = 100*final(:,1)+10*final(:,2)+final(:,3);
% disp(ocr_number(1:4)');
% disp(ocr_number(5:8)');
% disp(ocr_number(9:12)');
% disp(ocr_number(13:16)');
ocr_result = [ocr_number(1:4)'; ocr_number(5:8)'; ocr_number(9:12)'; ocr_number(13:16)']
