
using GCNModel
using JLD
using Random

println("\nRUNNING EXPERIMENT SCRIPT: " * (@__FILE__))

datasetFile = (@__DIR__) * "/spiral-dataset.jld"

numTrainingIter = 1000
numRuns = 20
layerWidths = [3,4,5]

resultsFileName = splitext(@__FILE__)[1] * "-results.jld"
rm(resultsFileName, force=true)


Random.seed!(123456)

kernel = PolyLaplacianKernel([[1.0, -1.0]], HypergraphSmoother(0.0, 1.0))

arch = GCNArchitecture(layerWidths, kernel,
    name="GCN-Linear")

exp = Experiment(datasetFile, arch, numTrainingIter)

addRuns(exp, numRuns, printInterval=1)


saveInJLD(exp, resultsFileName, "experiment")

printSummary(exp)
