function newImage = increaseImgResolution(image,scale)
% increase the resolution of an image
% and normalize the image to sum(sum()) = 1
newImage = imresize(image,scale);

% check if the image is empty
% if not, then perform normalization
if any(any(newImage))
    newImage(newImage<0) = 0;
    newImage = newImage/sum(sum(newImage));
end

