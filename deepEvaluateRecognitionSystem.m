function [conf] = deepEvaluateRecognitionSystem(net)
    load('../data/fc7_training.mat.');
    load('../data/traintest.mat');
    class_num = length(mapping);
    feature_num = size(fc7_training,2);
    test_img_num = length(test_imagenames);
    train_img_num = length(train_imagenames);
    conf = zeros(class_num,class_num);
    for i=1:test_img_num
        I = imread(['../data/',test_imagenames{i}]);
        disp(test_imagenames{i});
        img_feature = extractDeepFeatures(net, I);
        img_feature = img_feature';
        dis = (repmat(img_feature,train_img_num,1)-fc7_training).^2;
        sum_dis = zeros(1,train_img_num);
        for j=1:train_img_num
            sum_dis(j) = -sqrt(sum(dis(j,:)));
        end
        [~,index] = max(sum_dis);
        conf(test_labels(i),train_labels(index)) = conf(test_labels(i),train_labels(index))+1;
        disp(train_labels(index));
    end
end