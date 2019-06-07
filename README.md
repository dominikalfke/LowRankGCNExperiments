
# LowRankGCNExperiments

This directory is part of the supplementary material to the submission **Semi-Supervised Classification on Non-SparseGraphs Using Low-Rank Graph Convolutional Networks** to NeurIPS 2019. It is a copy of a *github* repository and its purpose is to provide the Julia code used in the experiments in that paper.

## Julia module

All this code is based on our Julia module ``GCNModel``, which is made available in a different directory of the supplementary material. This also means that all dataset information is given in [JLD](https://github.com/JuliaIO/JLD.jl) files storing a single object named ``dataset`` of the ``Dataset`` data type from that module.

## General file naming strategy
All names of experiment files follow the scheme ``dataset-architecture-filter[-laplacian].jl``, where
* the ``dataset`` name is equal to the folder the file is located in,
* the ``architecture`` specifier is one of the following:
	- ``full`` -- traditional GCN with full-rank filters.
	- ``fullnaive`` -- in the hypergraph case, the same architecture as ``full`` but with a naive implementation.
	- ``lowrankR`` -- the L-GCN architecture with low-rank filters, where ``R`` is replaced with the rank number.
	- ``reducedR`` -- the R-GCN reduced-order architecture with low-rank filters, where ``R`` is replaced with the rank number.
* the ``filter`` name is either ``linear``, ``quadratic``, or ``pseudoinverse``, as described in our paper,
* the optional ``laplacian`` specifier is only used for the *mushrooms* dataset, and there only the ``hypergraph`` Laplacian was used in the experiments published in the main paper.

## Spiral dataset
The ``spiral`` folder contains all experiment code for Table 1. The dataset is contained in ``spiral/spiral-dataset.jld``. The eigeninformation was only computed once and stored in ``spiral/spiral-eigenvalues.jld`` in the variables ``U`` and ``lambda``.

If you would like to reproduce that data, ``spiral/datageneration`` contains the Matlab files. The function ``spiral/datageneration/generateSpiralDataWithLabels_relabeled.m`` is a slightly modified version of the file published at [http://www.codelooker.com/codec/3842uselibsvm1/generateSpiralDataWithLabels.m.html](http://www.codelooker.com/codec/3842uselibsvm1/generateSpiralDataWithLabels.m.html). The script ``spiral/datageneration/createSpiralData.m`` generates a ``.mat`` file containing the dataset matrices as well as the computed eigeninformation. To run it, you must download the code published at [https://www.tu-chemnitz.de/mathematik/wire/people/files_alfke/NFFT-Lanczos-Example-v1.tar.gz](https://www.tu-chemnitz.de/mathematik/wire/people/files_alfke/NFFT-Lanczos-Example-v1.tar.gz), follow the instructions there, and provide the function ``fastsumAdjacencyEigs.m`` on the Matlab path.
