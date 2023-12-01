function [res] = runMatlabModel(data)
%runMatlabModel Load and run our matlab model
%   res is the result. 1 for rock, 2 for paper, 3 for scissors

% We use 4 channel data from the EMG arm band
numCh = 4;

% Loads our classifier, pre-trained on data we collected
load('currentClassifier.mat');

% Choose which features to extract
includedFeatures = {'mav', 'rms', 'wl'};

% Filter the data
filt_data = zeros(size(data,1),numCh);
for ch = 1:numCh
    filt_data(:,ch) = highpass(data(:,1+ch), 5,1000);
end
feats = extractFeatures(filt_data',includedFeatures,1000);

% Predict the result from the live data
res = currentClassifier.predict(feats);

end