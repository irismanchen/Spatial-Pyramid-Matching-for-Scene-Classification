function [features] = extractDeepFeatures(net, I)
    input = I;
    for i=1:size(net.Layers,1)
        classtype = class(net.Layers(i));
        if(strcmp(classtype,'nnet.cnn.layer.ImageInputLayer'))
            input = single(imresize(input, [224,224]));
            mean_matrix=activations(net,zeros(224,224,3),'input','OutputAs','channels');
            %mean_matrix=load('./m.mat');
            %mean_matrix= mean_matrix.m;
            output = mean_remove(input,-mean_matrix);
        end
        if(strcmp(classtype,'nnet.cnn.layer.Convolution2DLayer'))
            conv_stride = net.Layers(i).Stride;
            weights = net.Layers(i).Weights;
            bias = net.Layers(i).Bias;
            output = multichannel_conv2(input,weights,bias);
            if(conv_stride(1)~=1||conv_stride(2)~=1)
                output = stride(output,conv_stride);
            end
        elseif(strcmp(classtype,'nnet.cnn.layer.ReLULayer'))
            tt = 0;
            output = relu(input);
        elseif(strcmp(classtype,'nnet.cnn.layer.FullyConnectedLayer'))
            w = net.Layers(i).Weights;
            b = net.Layers(i).Bias;
            output = fully_connected(input,w,b);
        elseif(strcmp(classtype,'nnet.cnn.layer.MaxPooling2DLayer'))
            pool_size = net.Layers(i).PoolSize;
            pool_stride = net.Layers(i).Stride;
            %disp(net.Layers(i).Padding);
            output = max_pool(input,pool_size);
            if(pool_stride(1)~=1||pool_stride(2)~=1)
                output = stride(output,pool_stride);
            end
        end
        input = output;
        if(strcmp(net.Layers(i).Name,'fc7'))
            break;
        end
    end
    features = output;
end