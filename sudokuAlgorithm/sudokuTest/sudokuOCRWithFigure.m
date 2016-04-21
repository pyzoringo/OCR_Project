function result = sudokuOCRWithFigure(filename)
% filename is the filename of the PVR image
% resultNumbers is the numbers extracted from the image
% resultNumbers = [upLeft    , upRight;
%                  midLeft   , midRight;
%                  bottomLeft, bottomRight;]
result = sudokuOCR(filename);

numbers = extractNumFrom(filename);
for i = 1:6
    subplot(3,2,i);imshow(numbers(:,:,i),[]);
end

end

