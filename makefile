.PHONY: all
all: losses penalties histories datautils augmentor

.PHONY: losses
losses: $(shell find LossFunctions -name '*.jl')

.PHONY: penalties
penalties: $(shell find PenaltyFunctions -name '*.jl')

.PHONY: histories
histories: $(shell find ValueHistories -name '*.jl')

.PHONY: datautils
datautils: $(shell find MLDataUtils -maxdepth 1 -name '*.ipynb')

.PHONY: augmentor
augmentor: $(shell find Augmentor -maxdepth 1 -name '*.jl' -o -name '*.ipynb')

%.jl: FORCE
	julia "$@"

%.ipynb: FORCE
	julia -e 'using NBInclude; nbinclude("$@")'

FORCE:

