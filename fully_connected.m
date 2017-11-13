function [y] = fully_connected(x,W,b)
    x = x(:);
    assert (size(W,2)==size(x,1));
    assert (size(W,1)==size(b,1));
    y = W*x+b; 
end