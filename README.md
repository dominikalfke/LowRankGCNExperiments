
# LowRankGCNExperiments

This repository contains the original Julia code used to produce the results in [Alfke, Stoll, **Semi-Supervised Classification on Non-Sparse Graphs Using Low-Rank Graph Convolutional Networks** (2019)](https://arxiv.org/abs/1905.10224). The code is based on our Julia module [``GCNModel``](https://github.com/dominikalfke/GCNModel).


## Dataset file format

All datasets are given in [JLD](https://github.com/JuliaIO/JLD.jl) files storing a single object named ``dataset`` of the ``Dataset`` data type from the ``GCNModel`` module.

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


## Hypergraph datasets

The ``cars`` and ``mushrooms`` folders contain all experiment code for Table 2. The datasets are contained in ``cars/cars-dataset.jld`` and ``mushrooms/mushrooms-dataset.jl``, respectively.

## Additional experiments from the appendix

The ``mushrooms/otherranks`` and ``mushrooms/othersmoothers`` folders contain the code for Figure A4 and Table A4 from the appendix.

