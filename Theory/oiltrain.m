load('oilwell_dataset_scored');

net = feedforwardnet(50,'trainbr');

numNN = 2;
NN = cell(1,numNN);
Tr = cell(1,numNN);
perfs = zeros(1,numNN);
for i=1:numNN
  disp(['Training ' num2str(i) '/' num2str(numNN)])
  [NN{i}, Tr{i}] = train(net,x,t);
  perfs(i) =Tr{i}.best_tperf
end