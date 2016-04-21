function newImage = reCenter(image)
% calculate image mass center and recenter the image to space center
center = calcCenter(image);
% shift vertically
newImage = circshift(image, round(size(image,1))/2-center(2));
% shift horizontally
newImage = circshift(newImage, round(size(image,2))/2-center(1),2);

end

