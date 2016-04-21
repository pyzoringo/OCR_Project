function corIndex = matchNumberArray(target, library)
corIndex = zeros(1,size(library,3));
for i = 1:size(library,3)
    corIndex(i) = corIndex(i) + sum(sum(target.*library(:,:,i)));
    corIndex(i) = corIndex(i) - 0.04*sum(sum(...
        (target-library(:,:,i)).*(target-library(:,:,i))));
end
end