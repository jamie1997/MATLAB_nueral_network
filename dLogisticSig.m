function y = dLogisticSig( x )
%UNTITLED6 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    y = logisticSig(x).*(1 - logisticSig(x));

end

