%% Initialization
clear ; close all; clc

%% ======================= Part 2: Plotting =================
load('raw_data.mat');

inputs = raw_inputs;
targets = raw_targets;

trainFcn = {'trainbfg', 'traincgb', ...
'traincgf',  'traincgp', 'traingd' , 'traingda', ...
 'traingdm', 'traingdx', 'trainlm', 'trainoss', ...
 'trainrp', 'trainscg'};



bestPerformance = 20000000000000000000;

for i = 1:length(trainFcn)
	fprintf('trianFcn: %s\n', trainFcn{i});
	for hiddenLayerSize = 1:10
		fprintf('   hiddenLayerSize: %d\n', hiddenLayerSize);


		[net, tr] = selectModel(inputs, targets, hiddenLayerSize, [60,20,20], trainFcn{i});

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

		if (valPerformance < bestPerformance)
			bestPerformance = valPerformance;
			best_net = net;
			best_tr = tr;
		end

		fprintf('      valPerformance: %f', valPerformance);
		fprintf('      bestPerformance: %f\n', bestPerformance);
	end
end


net = best_net;
tr = best_tr;

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
view(net)

% Plots
% Uncomment these lines to enable various plots.
figure, plotperform(tr)
figure, plottrainstate(tr)
figure, plotfit(net,inputs,targets)
plotregression(trainTargets,outputs,'Training',testTargets,outputs,'Test',valTargets,outputs, 'Validation', targets,outputs, 'All')
figure, ploterrhist(errors)
