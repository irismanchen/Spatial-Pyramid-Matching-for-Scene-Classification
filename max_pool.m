function [pooling_result] = max_pool(x,sz)
    w = sz(1);
    h = sz(2);
    new_w = size(x,1)-w+1;
    new_h = size(x,2)-h+1;
    pooling_result = zeros(new_w, new_h,size(x,3));
    for i=1:size(x,3)
        for j=1:new_w
            for k=1:new_h
                grid = x(j:j+w-1,k:k+h-1,i);
                pooling_result(j,k,i) = max(grid(:));
            end
        end
    end
end