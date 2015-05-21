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
net = cell(2, 1);
tr = cell(2, 1);
iteration = zeros(2, 1);
hiddenLayerSize = zeros(2, 1);
trainingAlg = cell(2, 1);
numLayers = zeros(2, 1);
transferFunction = cell(2, 1);

performance = zeros(2, 1);
trainPerformance = zeros(2, 1);
valPerformance = zeros(2, 1);
testPerformance = zeros(2, 1);
R_all = zeros(2, 1);
MAPE = zeros(2,1);

TR = table(iteration, net, tr, trainingAlg, transferFunction, ...
    hiddenLayerSize, numLayers, performance, trainPerformance, ...
    valPerformance, testPerformance, R_all, MAPE);


minTestPerformance = [10000,10000];

i = 1;
% Train network over and over again and store each network's performance
% metrics
for trainingAlg = trainingAlgList
	% Convert cells to strings
	trainingAlg = trainingAlg{:};

	for transferFunction = transferFunctionList
		% Convert cells to strings
		transferFunction = transferFunction{:};

		for hiddenLayerSize=1:3

			disp(['Training ' num2str(i)]);
        
            % Update or create a new row of the table
            TR.iteration(i) = i;
            TR.trainingAlg(i) = {trainingAlg};
            TR.transferFunction(i) = {transferFunction};
            TR.hiddenLayerSize(i) = hiddenLayerSize;
            TR.numLayers(i) = 1;

			[TR.net(i), TR.tr(i), TR.performance(i), TR.trainPerformance(i), TR.valPerformance(i), ...
			TR.testPerformance(i), TR.R_all(i), TR.MAPE(i)] = trainAvg(hiddenLayerSize, trainingAlg, numLayers, transferFunction);

            
            % Check if current testPerformance is the smaller than the 
            % minTestPerformance. If it is, make it the new minTestPerformance
			if TR.testPerformance(i) < minTestPerformance(1)
				minTestPerformance(1) = TR.testPerformance(i);
				minTestPerformance(2) = i;
			end

			i = i + 1;
		end
	end
end




% write the table to an excel datasheet
writetable(TR, 'trainingresults.xlsx');

% Save relevant variables to a mat file
save('trainingresultsData', 'TR', 'minTestPerformance');