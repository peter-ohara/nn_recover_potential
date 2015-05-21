load('oilwell_dataset_scored');

% test_mse = zeros(6,1);
% mse = zeros(6,1);
% rmse = zeros(6,1);
% mean_e = zeros(6,1);
% r_all = zeros(6,1);
% MAPE = zeros(6,1);

load('data5');

for i=1:length(NN)

	% file = sprintf('data%d', i);
	% load(file);

	n = length(t);


	y = NN{i}(x);
	e = gsubtract(t,y);

	test_mse(i) = minTestPerformance(1)
	mse(i) = perform(NN{i}, t,y)
	rmse(i) = sqrt(perform(NN{i}, t,y))
	mean_e(i) = mean(abs(e))
	r_all(i) = regression(t,y)
	MAPE(i) = sum( (abs(y-t)/t) * 100) / n

	% figure, plotperform(tr)
	% figure, plottrainstate(tr)
	% figure, plotregression(t,y)
	% figure, ploterrhist(e)

	% pause

	% close all

end

% % put all the data into a table
% M = table(trainingAlgs, transferFunctions, MAPE, hiddenLayerSizes, numLayerses, ...
% 	performances, trainPerformances, ...
% 	valPerformances,	testPerformances, R_alls, 'VariableNames', ... 
% 	{'hiddenLayerSizes', 'trainingAlgs', 'numLayerses', ...
% 	'transferFunctions', 'MAPE', 'performances', 'trainPerformances', ...
% 	'valPerformances', 'testPerformance', 'R_all'});

% T = table(test_mse', mse', rmse', mean_e', r_all', MAPE', 'VariableNames', ... 
% 		{'test_mse', 'mse', 'rmse', 'mean_e', 'r_all', 'MAPE'});

