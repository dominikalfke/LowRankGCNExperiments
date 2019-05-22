
using GCNModel
using Random

println("\nRUNNING EXPERIMENT SCRIPT: " * (@__FILE__))

datasetFile = (@__DIR__) * "/spiral-dataset.jld"

numTrainingIter = 1000
numRuns = 100
layerWidths = [21, 8, 4]

resultsFileName = splitext(@__FILE__)[1] * "-results.jld"
rm(resultsFileName, force=true)

rank = 10
eigenvalueFile = (@__DIR__) * "/spiral-eigenvalues.jld"
@load eigenvalueFile lambda U
U = U[:, 1:rank]
lambda = lambda[1:rank]


Random.seed!(123456)

kernel = FixedLowRankKernel(U, [(1 .- lambda).^2], false)

arch = GCNArchitecture(layerWidths, kernel,
    name="LGCN10-Quadratic")

exp = Experiment(datasetFile, arch, numTrainingIter)

addRuns(exp, numRuns, printInterval=10)


saveInJLD(exp, resultsFileName, "experiment")

printSummary(exp)
