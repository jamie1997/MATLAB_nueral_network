function y = dLogisticSig( x )
%UNTITLED6 此处显示有关此函数的摘要
%   此处显示详细说明
    y = logisticSig(x).*(1 - logisticSig(x));

end

