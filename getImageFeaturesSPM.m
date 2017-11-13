function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    % TODO Implement your code here
% Initialize output
h = zeros((4^layerNum-1)/3, dictionarySize);
H = size(wordMap, 1);
W = size(wordMap, 2);
cnt = 0;
l = layerNum-1;
cellNum = 2^l;
cellH = floor(H/cellNum);
cellW = floor(W/cellNum);
histindex = zeros(2^(layerNum-1), 2^(layerNum-1));
for i = 1:cellNum
    for j = 1:cellNum
        cnt = cnt+1;
        cell = wordMap(((i-1)*cellH+1):(i*cellH),((j-1)*cellW+1):(j*cellW));
        h(cnt, :) = getImageFeatures(cell,dictionarySize)/2;
        histindex(i,j) = cnt;
    end
end
for l = layerNum-2 : -1 : 0
    cellNum = 2^l;
    cellH = floor(H/cellNum);
    cellW = floor(W/cellNum);
    % Calculate histograms of the cells
    for i = 1:cellNum
        for j = 1:cellNum
            cnt = cnt+1;
            tmp = h(histindex(i*2-1,j*2-1),:)+h(histindex(i*2,j*2-1),:)+...
                  h(histindex(i*2-1,j*2),:)+h(histindex(i*2,j*2),:);
            h(cnt,:) = tmp;
            if l ~= 0
                h(cnt,:) = h(cnt,:)/2;
            end
            histindex(i,j) = cnt;
        end
    end
end
h = h(:)/sum(h(:));
end