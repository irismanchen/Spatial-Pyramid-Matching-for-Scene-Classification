function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.

filterBank  = createFilterBank();
    % TODO Implement your code here
alpha = 200;
K = 300;
filter_responses = zeros(length(imPaths)*alpha, length(filterBank)*3);
for i = 1:length(imPaths)
    I = imread(imPaths{i});
    disp(imPaths{i});
    % WxHx(3*N)
    IResponses = extractFilterResponses(I, filterBank);
    % (W*H)x(3*N)
    IResponses_reshape = reshape(IResponses,size(IResponses,1)*size(IResponses,2),size(IResponses,3));
    index = randperm(size(IResponses_reshape,1),alpha);
    filter_responses((i*alpha-alpha+1):(i*alpha),:) = IResponses_reshape(index,:);
end
[~, dictionary] = kmeans(filter_responses, K, 'EmptyAction','drop');
dictionary = dictionary';
end
