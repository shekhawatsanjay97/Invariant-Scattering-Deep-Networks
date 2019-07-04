%% Run a test on your own - using functionality from the toolkit
%
% This script shows how to generate a compliant similarity matrix for UERC,
% save the similarity matrix into the appropriate folder and then produce
% performance metrics based on the saved data.
%
% Author: Vitomir Struc & Ziga Emersic
%
% TO RUN THIS FILE PROPERLY, YOU NEED TO BE LOCATED IN THE DIRECTORY OF THIS FILE
clear;
disp(datestr(now));
tic

%% Initial specs:
dirIn = 'Features/';
dirOut = 'SimilarityMatrix/';
featuresFile = [dirIn 'yale.txt'];
matrixFile = [dirOut 'yale.txt'];
distance_method = 'cosine';
%distance_method = 'chi';

%% Load all the extracted features
features = dlmread(featuresFile, ' ');

% Norm the features:    
features = bsxfun(@rdivide, features, sum(abs(features), 2));

%% Calc the distances
if (strcmp(distance_method, 'chi') == 1)
    % ! REALLY SLOW !
    addpath('aux_scripts/awe-uerc-toolbox/libraries/histogram_distance');
    sim_matrix = pdist2(features, features, @chi_square_statistics_fast);
    rmpath('aux_scripts/awe-uerc-toolbox/libraries/histogram_distance');
else
    % Really fast
    sim_matrix = pdist2(features, features, distance_method);
end
sim_matrix(isnan(sim_matrix)) = 1;

%% Write the results:
dlmwrite(matrixFile, sim_matrix, ' ');
disp('Finished with the similarity matrix calculation.')

toc
