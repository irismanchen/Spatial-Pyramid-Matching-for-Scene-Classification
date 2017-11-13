function [conv_result] = multichannel_conv2(x,h,b)
    % h -> filter: w*h*channel*num
    filter_num = size(h,4);
    channel_num = size(x,3);
    assert (channel_num==size(h,3));
    assert (size(b,3)==filter_num);
    conv_result = zeros(size(x,1),size(x,2),filter_num);
    h = rot90(h,2);
    for i = 1:filter_num
        curconv = zeros(size(x,1),size(x,2));
        for j=1:channel_num
            curconv=curconv+conv2(x(:,:,j),h(:,:,j,i),'same');
        end
        curconv = curconv+repmat(b(:,:,i),size(x,1),size(x,2));
        conv_result(:,:,i) = curconv;
    end
end