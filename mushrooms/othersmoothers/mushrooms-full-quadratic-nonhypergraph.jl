
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
settings = [
    (0.0, 0.0, "None"),
    (1.0, 0.0, "Identity"),
    (1.0, 1.0, "Combined")
]

for (α, β, name) in settings
    Random.seed!(123456)

    kernel = PolySmoothedHypergraphLaplacianKernel([[1.0, -2.0, 1.0]], α, β)

    arch = GCNArchitecture(layerWidths, kernel,
        name="GCN-Linear-$name")

    exp = Experiment(datasetFile, arch, numTrainingIter)
    push!(experiments, exp)

    addRuns(exp, numRuns, printInterval=10)


    saveInJLD(exp, resultsFileName, "experiment-$(lowercase(name))")
end

for exp in experiments
    printSummary(exp)
end
