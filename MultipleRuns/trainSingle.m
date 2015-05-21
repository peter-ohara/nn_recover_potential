%% functionname: function description
function [net, testPerformance] = trainSingle(hiddenLayerSize, trainingAlg, numLayers, transferFunction)


load('oilwell_dataset_scored.mat');

inputs = x;
targets = t;


% Create a Fitting Network
net = fitnet(hiddenLayerSize);
net.layers{1}.transferFcn = transferFunction;


% Choose Input and Output Pre/Post-Processing Functions
% For a list of all processing functions type: help nnprocess
net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};


% Setup Division of Data for Training, Validation, Testing
% For a list of all data division functions type: help nndivide
net.divideFcn = 'dividerand';  % Divide data randomly
net.divideMode = 'sample';  % Divide up every sample
net.divideParam.trainRatio = 60/100;
net.divideParam.valRatio = 20/100;
net.divideParam.testRatio = 20/100;

% For help on training function 'trainlm' type: help trainlm
% For a list of all training functions type: help nntrain
net.trainFcn = trainingAlg;  % Levenberg-Marquardt

% Choose a Performance Function
% For a list of all performance functions type: help nnperformance
net.performFcn = 'mse';  % Mean squared error

% Choose Plot Functions
% For a list of all plot functions type: help nnplot
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};


% Train the Network
[net,tr] = train(net,inputs,targets);

% Test the Network
outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);

% Recalculate Training, Validation and Test Performance
trainTargets = targets .* tr.trainMask{1};
valTargets = targets  .* tr.valMask{1};
testTargets = targets  .* tr.testMask{1};
trainPerformance = perform(net,trainTargets,outputs);
valPerformance = perform(net,valTargets,outputs);
testPerformance = perform(net,testTargets,outputs);

% View the Network
%view(net)

% Plots
% Uncomment these lines to enable various plots.
% figure, plotperform(tr)
% figure, plottrainstate(tr)
% figure, plotfit(net,inputs,targets)
% plotregression(trainTargets,outputs,'Training',testTargets,outputs,'Test',valTargets,outputs, 'Validation', targets,outputs, 'All')
% figure, plotregression(trainTargets,outputs)
% figure, plotregression(testTargets,outputs)
% figure, plotregression(valTargets,outputs)
% figure, plotregression(targets,outputs)

% figure, ploterrhist(errors)



% Simulation with sample data
% fprintf('Simulating with Sample Data\n');
 
% sim(net, inputs)