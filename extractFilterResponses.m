function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter response


% TODO Implement your code here
double_img = double(img);
if size(double_img, 3) == 1
    double_img = repmat(double_img, 1, 1, 3);
end
[L, a, b] = RGB2Lab(double_img(:,:,1), double_img(:,:,2), double_img(:,:,3));
filterResponses = zeros(size(double_img,1), size(double_img,2), 3*length(filterBank));
for i=1:length(filterBank)
    LL = imfilter(L,filterBank{i});
    aa = imfilter(a,filterBank{i});
    bb = imfilter(b,filterBank{i});
    filterResponses(:,:,3*(i-1)+1)=LL;
    filterResponses(:,:,3*(i-1)+2)=aa;
    filterResponses(:,:,3*(i-1)+3)=bb;
end
end
