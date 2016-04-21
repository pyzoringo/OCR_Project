

%% extract individual characters
zero = zeros(12,6,200);
one = zeros(12,6,200);
two = zeros(12,6,200);
three = zeros(12,6,200);
four = zeros(12,6,200);
five = zeros(12,6,200);
six = zeros(12,6,200);
seven = zeros(12,6,200);
eight = zeros(12,6,200);
nine = zeros(12,6,200);
i0 = 1; 
i1 = 1;
i2 = 1; 
i3 = 1; 
i4 = 1; 
i5 = 1; 
i6 = 1; 
i7 = 1; 
i8 = 1; 
i9 = 1; 
%%
for n = 1: 16
    for i = 1:3
        switch i
            case 1
                ocr_char = bottomRight(:,6:11,n);
            case 2
                ocr_char = bottomRight(:,14:19,n);
            case 3
                ocr_char = bottomRight(:,21:26,n);
            otherwise
                warning('Crash');
        end
        figure(13);
        imshow(uint8(ocr_char),'InitialMagnification',800);
        readIn = str2double(input('number', 's'));
        switch readIn
            case 0
                zero(:,:,i0) = ocr_char;
                i0 = i0+1;
            case 1
                one(:,:,i1) = ocr_char;
                i1 = i1+1;
            case 2
                two(:,:,i2) = ocr_char;
                i2 = i2+1;
            case 3
                three(:,:,i3) = ocr_char;
                i3 = i3+1;
            case 4
                four(:,:,i4) = ocr_char;
                i4 = i4+1;
            case 5
                five(:,:,i5) = ocr_char;
                i5 = i5+1;
            case 6
                six(:,:,i6) = ocr_char;
                i6 = i6+1;
            case 7
                seven(:,:,i7) = ocr_char;
                i7 = i7+1;
            case 8
                eight(:,:,i8) = ocr_char;
                i8 = i8+1;
            case 9
                nine(:,:,i9) = ocr_char;
                i9 = i9+1;
            otherwise
                display('blank');
        end
    end
end
                






