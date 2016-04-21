function resultNumbers = ocrFrom(filename)
% filename is the filename of the PVR image
% resultNumbers is the numbers extracted from the image
% resultNumbers = [upLeft    , upRight;
%                  midLeft   , midRight;
%                  bottomLeft, bottomRight;]
resultNumbers = ocrNum(extractNumFrom(filename));

end

