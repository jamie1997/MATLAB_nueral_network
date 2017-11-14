clear;
load data;

%��train_labels��Ϊtargetimages(:,n(k));
targets = zeros(10,size(train_labels,1));
for n = 1: size(train_labels,1)
    targets(train_labels(n) + 1,n) =1;
end


lr = 0.5; %ѧϰ��
batchSize = 100;
epochs = 500;

%hidden layer
numofh1 = 100;


train_num = size(train_images,2);%ѵ��������
inputDimensions = size(train_images,1);%����ά��
outputDimensions = size(targets,1);%���ά��

%initial the weights for the hidden layer and the output layer

w1 = rand(numofh1, inputDimensions);
w2 = rand(outputDimensions, numofh1);
%��һ��
w1 = w1./size(w1,2);
w2 = w2./size(w2,2);

%b1 = rand(numofh1,1);
%b2 = rand(outputDimensions,1);
n = zeros(batchSize);

figure,hold on 
for i = 1:epochs
    for k = 1:batchSize
        n(k) = floor(rand(1)*train_num + 1);
        
        %forward()
        input = train_images(:,n(k));
        a1 = w1 * input ;
        z1 = logisticSig(a1);
        a2 = w2 * z1;
        z2 = logisticSig(a2);
       
        
        target = targets(:,n(k));
        % back propagation
        delta2 = dLogisticSig(a2).*(z2 - target);
        delta1 = dLogisticSig(a1).*(w2'*delta2);
        
      
        % update 
      
        w2 = w2 - lr .* delta2 * z1';
        w1 = w1 - lr .* delta1 * input';
        
    end
    %calculate the error for plotting
    error = 0;
    for k = 1:batchSize
        input = train_images(:,n(k));
        target = targets(:,n(k));
        
        output = logisticSig(w2*logisticSig(w1*input ));
        
        error = error + norm(output - target,2);
    end;
    error = error /batchSize;
    
    plot(i,error,'*');
end
    
% testing

    
test_num = size(test_images,2);
correct = 0;
classifyerrors=0;
for n = 1: test_num
    input = test_images(:,n);
    output = logisticSig(w3 * logisticSig(w2 * logisticSig(w1 * input)));
    max = 0;
    class = 1;
    for i = 1 :size(output,1)
        if output(i) > max
            max = output(i);
            class = i;
        end
    end
    if class ==test_labels(n) + 1
        correct = correct + 1;
    end
end

disp(correct)