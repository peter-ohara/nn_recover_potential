close all; clear; clc;

% Network parameters
% trainingAlgList = {'trainlm', 'traincgb', 'trainbfg', ...
% 'traincgf',  'traincgp', 'traingd' , 'traingda', ...
% 'traingdm', 'traingdx', 'trainoss', ...
% 'trainrp', 'trainscg'};


trainingAlgList = {'trainlm', 'trainbfg', 'traincgb'};

numLayers = 1;
transferFunctionList = {'tansig', 'logsig', 'purelin'};

% initialise network metric variables
numNN = 10;
NN = cell(numNN, 1);
TR = cell(numNN, 1);

iterations = zeros(numNN, 1);
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

i = 1;
% Train network over and over again and store each network's performance metrics
for trainingAlg = trainingAlgList
	% Convert cells to strings
	trainingAlg = trainingAlg{:};

	for transferFunction = transferFunctionList
		% Convert cells to strings
		transferFunction = transferFunction{:};

		for hiddenLayerSize=1:20

			disp(['Training ' num2str(i)]);

			[net, tr, performance, trainPerformance, valPerformance, ...
			testPerformance, R_all] = trainAvg(hiddenLayerSize, trainingAlg, numLayers, transferFunction);

			iterations(i) = i;
			hiddenLayerSizes(i) = hiddenLayerSize;
			trainingAlgs(i) = cellstr(trainingAlg);
			numLayerses(i) = numLayers;
			transferFunctions(i) = cellstr(transferFunction);

			testPerformance

			NN{i} = net;
			TR{i} = tr;
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

			if ( mod(i,50) == 0 )|| ( testPerformance < 3.2763 )
			% put all the data into a table
			trainingresults = table(iterations, hiddenLayerSizes, trainingAlgs, numLayerses, ...
				transferFunctions, performances, trainPerformances, ...
				valPerformances,	testPerformances, R_alls, 'VariableNames', ... 
				{'iteration', 'hiddenLayerSize', 'trainingAlg', 'numLayers', ...
				'transferFunction','performance', 'trainPerformance', ...
				'valPerformance', 'testPerformance', 'R_all'});

			filename = sprintf('results/trainingresultsData_ %d', i);

			% Save relevant variables to a mat file
			save(filename, 'trainingresults', 'NN', 'TR', ...
				'minPerformance', 'minTestPerformance', 'minValPerformance', ...
				'minTrainPerformance', 'maxR_all');

			end

			i = i + 1;
		end
	end
end


% put all the data into a table
trainingresults = table(iterations, trainingAlgs, transferFunctions, hiddenLayerSizes, numLayerses, ...
	performances, trainPerformances, ...
	valPerformances,	testPerformances, R_alls, 'VariableNames', ... 
	{'iteration', 'hiddenLayerSizes', 'trainingAlgs', 'numLayerses', ...
	'transferFunctions','performances', 'trainPerformances', ...
	'valPerformances', 'testPerformance', 'R_all'});

% write the table to an excel datasheet
writetable(trainingresults, 'trainingresults.xlsx');

% Save relevant variables to a mat file
save('trainingresultsData', 'trainingresults', 'NN', 'TR', ...
	'minPerformance', 'minTestPerformance', 'minValPerformance', ...
	'minTrainPerformance', 'maxR_all');