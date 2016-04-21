function chars = splitToChar(number)
% split the one number into 3 single char
% specifically for PVR study
%% split
chars = zeros(12,6,3);
chars(:,:,1) = number(:,6:11);
chars(:,:,2) = number(:,14:19);
chars(:,:,3) = number(:,21:26);

end

