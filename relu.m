function [relu_x] = relu(x)
    x_size = size(x);
    relu_x = x(:);
    for i=1:size(relu_x)
        if relu_x(i)<0
            relu_x(i)=0;
        end
    end
    relu_x = reshape(relu_x,x_size);
end