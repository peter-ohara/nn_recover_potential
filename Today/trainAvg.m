%% trainAvg: function description
function [bestNet, bestTr, minPerformance, minTrainPerformance, minValPerformance, minTestPerformance, maxR_all, minMAPE] = trainAvg(hiddenLayerSize, trainingAlg, numLayers, transferFunction)

% initialise network metric variables
numNN = 2;

% initialise all outputs
[net, tr, performance, trainPerformance, valPerformance, testPerformance, R_all, MAPE] = trainNetwork(hiddenLayerSize, ...
	trainingAlg, numLayers, transferFunction);

minPerformance = performance;
minTrainPerformance = trainPerformance;
minValPerformance = valPerformance;
minTestPerformance = testPerformance;
maxR_all = R_all;
bestNet = {net};
bestTr = {tr};
minMAPE = MAPE;



% Train network over and over again and store each network's performance metrics
for i=1:numNN
	% disp(['  Training ' num2str(i) '/' num2str(numNN)]);

	[net, tr, performance, trainPerformance, valPerformance, testPerformance, R_all, MAPE] = trainNetwork(hiddenLayerSize, ...
        trainingAlg, numLayers, transferFunction);

	if testPerformance < minTestPerformance
		minPerformance = performance;
		minTrainPerformance = trainPerformance;
		minValPerformance = valPerformance;
		minTestPerformance = testPerformance;
		maxR_all = R_all;
		bestNet = {net};
		bestTr = {tr};
        minMAPE = MAPE;
	end
end