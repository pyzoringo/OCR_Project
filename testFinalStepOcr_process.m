%% upLeft
target = allNumbersImage(:,:,:,6);
% upLeft:       7:11(6:11), 14:19, 21:26 
% upRight:      6:10(6:11), 13:18, 21:26
% midLeft:      7:10(6:11), 13:18, 21:26
% midRight:     6:10(6:11), 13:18, 21:26
% bottomLeft:   7:11(6:11), 14:19, 21:26
% bottomRight:  6:10(6:11), 13:18, 21:26
for i = 1: 16
    num = zeros(12, 6, 3);
    num(:,:,1) = target(:,6:11,i);
    num(:,:,2) = target(:,14:19,i);
    num(:,:,3) = target(:,21:26,i);
    num(:,:,1)=num(:,:,1)/sum(sum(num(:,:,1)));
    num(:,:,2)=num(:,:,2)/sum(sum(num(:,:,2)));
    num(:,:,3)=num(:,:,3)/sum(sum(num(:,:,3)));

    
    for n = 1:3
        corStem(1) = matchNumber(num(:,:,n),one);
        corStem(2) = matchNumber(num(:,:,n),two);
        corStem(3) = matchNumber(num(:,:,n),three);
        corStem(4) = matchNumber(num(:,:,n),four);
        corStem(5) = matchNumber(num(:,:,n),five);
        corStem(6) = matchNumber(num(:,:,n),six);
        corStem(7) = matchNumber(num(:,:,n),seven);
        corStem(8) = matchNumber(num(:,:,n),eight);
        corStem(9) = matchNumber(num(:,:,n),nine);
        corStem(10) = matchNumber(num(:,:,n),zero);
        [maxNorm, final(i,n)] = max(corStem);
    end
end
final = mod(final,10);
ocr_number = 100*final(:,1)+10*final(:,2)+final(:,3);
display(ocr_number(1:4)');
display(ocr_number(5:8)');
display(ocr_number(9:12)');
display(ocr_number(13:16)');