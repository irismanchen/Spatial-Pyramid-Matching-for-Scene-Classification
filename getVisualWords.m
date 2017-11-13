function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

    % TODO Implement your code here
    img_response = extractFilterResponses(img, filterBank);
    img_response_reshape = reshape(img_response,size(img_response,1)*size(img_response,2),size(img_response,3));
    distances = pdist2(img_response_reshape, dictionary');
    % return a column vector contain the min index for every row value
    [~, wordMap] = min(distances, [], 2);
    wordMap = reshape(wordMap, [size(img,1), size(img,2)]);
end