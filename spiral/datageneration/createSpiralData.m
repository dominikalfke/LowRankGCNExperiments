
%% Setup

addpath('~/phd/nfft/nfft_laplacian/Code/external/nfft/matlab/fastsum/');
addpath('~/phd/nfft/nfft_laplacian/Code/external/nfft/matlab/nfft/');
addpath('~/phd/nfft/nfft_laplacian/Code/example_code/');

rng(12345);

n = 10000;

sigma = 3.5;
numEV = 20;

Nc = 5;
spiral_h = 10;
spiral_r = 2;

opts.doNormalize = 1;
opts.sigma = sigma;
opts.diagonalEntry = 0;
opts.N = 32;
opts.m = 4;
opts.p = 1;
opts.eps_B = 0;
opts.eigs_tol = 1e-3;

%% Generate data

ticGen = tic;

[data, label] = generateSpiralDataWithLabels_relabeled(Nc, n/Nc, spiral_h, spiral_r);

timeGen = toc(ticGen);
fprintf('Data generation took %g s\n', timeGen);

%% Compute EVs

ticEV = tic;

numRuns = 100;
for i = 1:numRuns
    [U, Lambda, S] = fastsumAdjacencyEigs(data, numEV, opts);
    lambda = diag(Lambda);
end

timeEV = toc(ticEV)/numRuns;
fprintf('Eigenvalue computation took %g s\n', timeEV);

%% Save

filename = sprintf('spiral_data_%d.mat', n);
save(filename, 'data', 'label', 'U', 'lambda', 'timeGen', 'timeEV', 'sigma', 'n', 'opts');
