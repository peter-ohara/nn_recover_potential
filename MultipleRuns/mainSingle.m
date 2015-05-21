
% Network parameters

hiddenLayerSize = 2;
trainingAlg = 'trainlm';
numLayers = 1 ;
transferFunction = 'logsig';


% initialise network metric variables
numNN = 1000;
NN = cell(numNN, 1);

hiddenLayerSizes = zeros(numNN, 1);
trainingAlgs = cell(numNN, 1);
numLayerses = zeros(numNN, 1);
transferFunctions = cell(numNN, 1);

performances = zeros(numNN, 1);
trainPerformances = zeros(numNN, 1);
valPerformances = zeros(numNN, 1);
testPerformances = zeros(numNN, 1);
R_alls = zeros(numNN, 1);


minPerformance = [10000,10000];
minTrainPerformance = [10000,10000];
minValPerformance = [10000,10000];
minTestPerformance = [10000,10000];
maxR_all = [-10000,-10000];

% Train network over and over again and store each network's performance metrics
for i=1:numNN
	disp(['  Training ' num2str(i) '/' num2str(numNN)]);

	[net, performance, trainPerformance, valPerformance, testPerformance, R_all] = trainNetwork(hiddenLayerSize, ...
		trainingAlg, numLayers, transferFunction);


	hiddenLayerSizes(i) = hiddenLayerSize;
	trainingAlgs(i) = cellstr(trainingAlg);
	numLayerses(i) = numLayers;
	transferFunctions(i) = cellstr(transferFunction);

	NN{i} = net;
	performances(i) = performance;
	trainPerformances(i) = trainPerformance;
	valPerformances(i) = valPerformance;
	testPerformances(i) = testPerformance;
	R_alls(i) = R_all;

	
	if performance < minPerformance(1)
		minPerformance(1) = performance;
		minPerformance(2) = i;
	end

	if trainPerformance < minTrainPerformance(1)
		minTrainPerformance(1) = trainPerformance;
		minTrainPerformance(2) = i;
	end

	if valPerformance < minValPerformance(1)
		minValPerformance(1) = valPerformance;
		minValPerformance(2) = i;
	end

	if testPerformance < minTestPerformance(1)
		minTestPerformance(1) = testPerformance;
		minTestPerformance(2) = i;
	end

	if R_all > maxR_all(1)
		maxR_all(1) = R_all;
		maxR_all(2) = i;
	end
end



% put all the data into a table
trainingresults = table(hiddenLayerSizes, trainingAlgs, numLayerses, ...
	transferFunctions, performances, trainPerformances, ...
	valPerformances,	testPerformances, R_alls, 'VariableNames', ... 
	{'hiddenLayerSizes', 'trainingAlgs', 'numLayerses', ...
	'transferFunctions','performances', 'trainPerformances', ...
	'valPerformances', 'testPerformance', 'R_all'});

% write the table to an excel datasheet
writetable(trainingresults, 'trainingresults2.xlsx');

% Save relevant variables to a mat file
save('trainingresultsData2', 'trainingresults', 'NN', ...
	'minPerformance', 'minTestPerformance', 'minValPerformance', ...
	'minTrainPerformance', 'maxR_all');