
using GCNModel
using Random

println("\nRUNNING EXPERIMENT SCRIPT: " * (@__FILE__))

datasetFile = abspath(@__DIR__, "../mushrooms-dataset.jld")

numTrainingIter = 1000
numRuns = 100
layerWidths = [112, 16, 2]

resultsFileName = splitext(@__FILE__)[1] * "-results.jld"
rm(resultsFileName, force=true)

experiments = Experiment[]
ranks = [10,12,15,20,25,30,40,50,70,100]

for r in ranks

    Random.seed!(123456)

    kernel = LowRankInvHypergraphLaplacianKernel(r, false)

    arch = GCNArchitecture(layerWidths, kernel,
        name="LGCN$r-Pseudoinverse-Hypergraph")

    exp = Experiment(datasetFile, arch, numTrainingIter)
    push!(experiments, exp)

    addRuns(exp, numRuns, printInterval=100)

    saveInJLD(exp, resultsFileName, "experiment-rank$r")
end

for exp in experiments
    printSummary(exp)
end
