function [y] = stride(x,stride)
    w = stride(1);
    h = stride(2);
    y = x(1:w:end,1:h:end,:);
end