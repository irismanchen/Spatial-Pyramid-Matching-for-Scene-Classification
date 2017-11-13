function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('../data/traintest.mat');
    
	% TODO Implement your code here
    % confusion matrix
    conf = zeros(length(mapping),length(mapping));
    test_img_num = length(test_imagenames);
    for i=1:test_img_num
        predict_class = guessImage(['../data/',test_imagenames{i}]);
        predict_num = find(ismember(mapping,predict_class));
        conf(test_labels(i),predict_num) = conf(test_labels(i),predict_num)+1;
        if test_labels(i)==6 && predict_num~=6
            j=1;
        end
    end
end