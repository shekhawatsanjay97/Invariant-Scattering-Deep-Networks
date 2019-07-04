
% TO RUN THIS FILE PROPERLY, YOU NEED TO BE LOCATED IN THE DIRECTORY OF THIS FILE
%
% This file is same as rate_similarity_matrix_covariates.m, but it only
% include test 1 (all) and 6 (scale)


disp(datestr(now));
addpath('aux_scripts');
global outPath;

infoDir = 'InfoFiles/';
matrixDir = 'SimilarityMatrix/';
yIDS = dlmread([infoDir 'classes.txt']);
xIDS = dlmread([infoDir 'classes.txt']);
outPath = 'OutputFiles/';
if ~exist(outPath, 'dir')
   mkdir(outPath)  
end

methodName = 'Scatnet';
matrixLoc = 'yale.txt';

distanceA2A = dlmread([matrixDir matrixLoc]);
dist = 'cos';
dim = 100;
 
tic

disp('TEST: All ===========================================================================')
test1_main(outPath, yIDS, xIDS, distanceA2A, dist, dim, methodName)

toc

rmpath('aux_scripts');
