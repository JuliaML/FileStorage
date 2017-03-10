.PHONY: all
all: losses penalties histories

.PHONY: losses
losses: $(shell find LossFunctions -name '*.jl')

.PHONY: penalties
penalties: $(shell find PenaltyFunctions -name '*.jl')

.PHONY: histories
histories: $(shell find ValueHistories -name '*.jl')

%.jl: FORCE
	julia "$@"

FORCE:

