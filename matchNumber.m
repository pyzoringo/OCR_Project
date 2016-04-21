function corIndex = matchNumber(target, savedImage)
corIndex = 0;
for i = 1:size(savedImage,3)
    corIndex = corIndex + sum(sum(target.*savedImage(:,:,i)));
    corIndex = corIndex - 0*sum(sum(...
        (target-savedImage(:,:,i)).*(target-savedImage(:,:,i))));
end
end