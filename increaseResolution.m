function imageArrayWithIncreasedResolution = increaseResolution(originalImageArray,scale)
imageArrayWithIncreasedResolution = zeros(scale*size(originalImageArray,1)...
    , scale*size(originalImageArray,2),size(originalImageArray,3));
for i = 1:size(originalImageArray,3)
    imageArrayWithIncreasedResolution(:,:,i) = ...
        imresize(originalImageArray(:,:,i),scale);
end
imageArrayWithIncreasedResolution(imageArrayWithIncreasedResolution<0) = 0;
sumSample = zeros(size(originalImageArray,3),1);
for i = 1:size(originalImageArray,3)
    if any(any(imageArrayWithIncreasedResolution(:,:,i)))
        sumSample(i) = sum(sum(imageArrayWithIncreasedResolution(:,:,i)));
        imageArrayWithIncreasedResolution(:,:,i)...
        = imageArrayWithIncreasedResolution(:,:,i)/sumSample(i);
    end
end
    
    