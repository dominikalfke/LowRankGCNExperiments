
using GCNModel
using Random

println("\nRUNNING EXPERIMENT SCRIPT: " * (@__FILE__))

datasetFile = (@__DIR__) * "/cars-dataset.jld"

numTrainingIter = 1000
numRuns = 100
layerWidths = [21, 8, 4]

resultsFileName = splitext(@__FILE__)[1] * "-results.jld"
rm(resultsFileName, force=true)


Random.seed!(123456)

kernel = PolyHypergraphLaplacianKernel([[1.0, -1.0]])

arch = GCNArchitecture(layerWidths, kernel,
    name="GCN-Linear-Hypergraph")

exp = Experiment(datasetFile, arch, numTrainingIter)

addRuns(exp, numRuns, printInterval=10)


saveInJLD(exp, resultsFileName, "experiment")

printSummary(exp)
