
using GCNModel
using Random

println("\nRUNNING EXPERIMENT SCRIPT: " * (@__FILE__))

datasetFile = (@__DIR__) * "/mushrooms-dataset.jld"

numTrainingIter = 1000
numRuns = 100
layerWidths = [112, 16, 2]

resultsFileName = splitext(@__FILE__)[1] * "-results.jld"
rm(resultsFileName, force=true)


Random.seed!(123456)

kernel = PolyHypergraphLaplacianKernel([[1.0, -2.0, -1.0]])

arch = GCNArchitecture(layerWidths, kernel,
    name="GCN-Quadratic-Hypergraph")

exp = Experiment(datasetFile, arch, numTrainingIter)

addRuns(exp, numRuns, printInterval=10)


saveInJLD(exp, resultsFileName, "experiment")

printSummary(exp)
