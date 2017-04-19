.PHONY: all
all: losses penalties histories

.PHONY: losses
losses: $(shell find LossFunctions -name '*.jl')

.PHONY: penalties
penalties: $(shell find PenaltyFunctions -name '*.jl')

.PHONY: histories
histories: $(shell find ValueHistories -name '*.jl')

.PHONY: datautils
datautils: $(shell find MLDataUtils -maxdepth 1 -name '*.ipynb')

%.jl: FORCE
	julia "$@"

%.ipynb: FORCE
	julia -e 'using NBInclude; nbinclude("$@")'

FORCE:

