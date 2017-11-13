function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	load('dictionary.mat');
	load('../data/traintest.mat');

	% TODO create train_features
    filterBank = createFilterBank();
    numLayer = 3;
    training_img_num = length(train_imagenames);
    assert(size(dictionary,2)==300);
    train_features = zeros((4^numLayer-1)/3*size(dictionary,2),training_img_num);
    for i=1:training_img_num
        wordmapfile = strrep(['../data/', train_imagenames{i}], '.jpg', '.mat');
        load(wordmapfile);
        train_features(:,i) = getImageFeaturesSPM(numLayer, wordMap, size(dictionary,2));
    end
	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');
end