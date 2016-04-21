function center = calcCenter(image)
% calculate the position of the mass center of the charater
centerOfCol = 0;
centerOfRow = 0;
[arrayForColCenter,arrayForRowCenter] = ...
    meshgrid(1:size(image,2),1:size(image,1));
if any(any(image))
    centerOfCol = sum(sum(arrayForColCenter.*image,1))...
        /sum(sum(image,1));
    centerOfRow = sum(sum(arrayForRowCenter.*image,2))...
        /sum(sum(image,2));
end
centerOfCol = round(centerOfCol);
centerOfRow = round(centerOfRow);
center = [centerOfCol, centerOfRow];
end

