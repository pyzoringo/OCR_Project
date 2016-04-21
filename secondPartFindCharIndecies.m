%%
% bottomRight = 255 - bottomRight;
% bottomRight(bottomRight<50) = 0;
figure(100);
for i = 1: length(patientFiles)
        subplot(4,4,i), imshow(uint8(upRight(:,:,i)));
end
%%
figure(101)
bottomRightSum = zeros(16,29);
for i = 1: length(patientFiles)
    bottomRightSum(i,:) = sum(bottomRight(:,:,i));
    subplot(4,4,i), stem(bottomRightSum(i,:));
end
%% 
% assume each number are distinct from each other, and the number itself 
% is continuous.
numberIndices = zeros(16,6);

for n = 1:16
    x = 1;
    for i = 2:29
        if bottomRightSum(n,i) > 0 && bottomRightSum(n, i-1) == 0
            numberIndices(n,x) = i;
            x = x+1;
        else if bottomRightSum(n,i) == 0 && bottomRightSum(n, i-1) > 0
                numberIndices(n,x) = i-1;
                x = x+1;
            end
        end
    end
end
% upLeft:       7:11(6:11), 14:19, 21:26 
% upRight:      6:10(6:11), 13:18, 21:26
% midLeft:      7:10(6:11), 13:18, 21:26
% midRight:     6:10(6:11), 13:18, 21:26
% bottomLeft:   7:11(6:11), 14:19, 21:26
% bottomRight:  6:10(6:11), 13:18, 21:26