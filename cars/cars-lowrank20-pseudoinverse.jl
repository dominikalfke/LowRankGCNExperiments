
using GCNModel
using Random

println("\nRUNNING EXPERIMENT SCRIPT: " * (@__FILE__))

datasetFile = (@__DIR__) * "/cars-dataset.jld"

numTrainingIter = 1000
numRuns = 100
layerWidths = [21, 8, 4]

resultsFileName = splitext(@__FILE__)[1] * "-results.jld"
rm(resultsFileName, force=true)

rank = 20

Random.seed!(123456)

kernel = LowRankInvHypergraphLaplacianKernel(rank, false)

arch = GCNArchitecture(layerWidths, kernel,
    name="LGCN20-Pseudoinverse-Hypergraph")

exp = Experiment(datasetFile, arch, numTrainingIter)

addRuns(exp, numRuns, printInterval=10)


saveInJLD(exp, resultsFileName, "experiment")

printSummary(exp)
