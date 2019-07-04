clear;
disp('Loading Data')
src = yalesrc;
filt_opt.J = 5;
filt_opt.L = 6;
scat_opt.oversampling = 2;
Wop = wavelet_factory_2d([195, 231], filt_opt, scat_opt);
features{1} = @(x)(sum(sum(format_scat(scat(x,Wop)),2),3));
options.parallel = 0;

%%
x = data_read(src.files{1});
Sx = scat(x, Wop);
% display scattering coefficients
figure;image_scat(Sx, false, false);
colormap gray;

%%
j1 = 0;
j2 = 2;
theta1 = 1;
theta2 = 5;
m=2;
p = find( Sx{m+1}.meta.j(1,:) == j1 & ...
    Sx{m+1}.meta.j(2,:) == j2 & ...
    Sx{m+1}.meta.theta(1,:) == theta1 & ...
    Sx{m+1}.meta.theta(2,:) == theta2 );
figure;imagesc(Sx{m+1}.signal{p});
colormap gray;
%%
%figure;imagesc(Sx{2}.signal{8});
%colormap gray;
%%
disp('Computing Features')
tic
db = prepare_database(src, features, options);
toc

%% Storing features

%db.features
%src.files
dirFeatures = 'Features/';
featureFile = [dirFeatures, 'yale.txt'];
dlmwrite(featureFile, db.features', ' ');
infoDir = 'InfoFiles/';
classes = [db.src.objects.class];
dlmwrite([infoDir 'classes.txt'],classes,' ');
%% The code below performs an affine space training and testing of the database of features.
% proportion of training example
disp('Classification Started')
prop = 0.5;
% split between training and testing
[train_set, test_set] = create_partition(src, prop);
% dimension of the affine pca classifier
train_opt.dim = 20;
% training
model = affine_train(db, train_set, train_opt);
% testing
labels = affine_test(db, model, test_set);
% compute the error
[error,accuracy] = classif_err(labels, test_set, src);
disp(accuracy*100)