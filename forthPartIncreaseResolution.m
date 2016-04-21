%% group the normalized sanmpe into one mat
avgSample(:,:,1) = sum(one,3);
avgSample(:,:,2) = sum(two,3);
avgSample(:,:,3) = sum(three,3);
avgSample(:,:,4) = sum(four,3);
avgSample(:,:,5) = sum(five,3);
avgSample(:,:,6) = sum(six,3);
avgSample(:,:,7) = sum(seven,3);
avgSample(:,:,8) = sum(eight,3);
avgSample(:,:,9) = sum(nine,3);
avgSample(:,:,10) = sum(zero,3);
%% check if correctly normallized
for i = 1: 10
    sumSample(i) = sum(sum(avgSample(:,:,i)));
end
sumSample
% true

%% increase resolution by scale of 5
scale = 5;
bigAvgSample = increaseResolution(avgSample, scale);
% after increasing resolution, some dataPoint become negative
% change these negative value to 0
bigAvgSample(bigAvgSample<0) = 0;
% check if correctly normalized, show bigAvgSample image,
% not correctly normalized, so add a line to normalize them.
figure(401)
for i = 1: 10
    sumSample(i) = sum(sum(bigAvgSample(:,:,i)));
    bigAvgSample(:,:,i) = bigAvgSample(:,:,i)/sumSample(i);
    sumSample(i) = sum(sum(bigAvgSample(:,:,i)));
    subplot(2,5,i); imshow(bigAvgSample(:,:,i),[]);
end
sumSample

%% Find the "mass center" of the bigAvgSample
% arrayForColCenter = 1:size(bigAvgSample,2);
% arrayForRowCenter = 1:size(bigAvgSample,1);
% arrayForRowCenter = arrayForRowCenter';
[arrayForColCenter,arrayForRowCenter] = ...
    meshgrid(1:size(bigAvgSample,2),1:size(bigAvgSample,1));
center = zeros(10,2);
for i = 1:10
    center(i,1) = sum(sum(arrayForColCenter.*bigAvgSample(:,:,i),1))...
        /sum(sum(bigAvgSample(:,:,i),1));
    center(i,2) = sum(sum(arrayForRowCenter.*bigAvgSample(:,:,i),2))...
        /sum(sum(bigAvgSample(:,:,i),2));
end
center = round(center);

% so the center of the numbers are
%     col   row
%     14    33
%     14    32
%     16    30
%     15    31
%     13    29
%     14    31
%     15    22
%     14    29
%     16    29
%     14    30
% shift to col:15, row:30
shiftedBigAvgSample = zeros(size(bigAvgSample));
figure(402)
for i = 1:10
    shiftedBigAvgSample(:,:,i) = ...
        circshift(bigAvgSample(:,:,i), 30-center(i,2));
    shiftedBigAvgSample(:,:,i) = ...
        circshift(shiftedBigAvgSample(:,:,i), 15-center(i,1),2);
    subplot(2,5,i); imshow(shiftedBigAvgSample(:,:,i),[]);
end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    