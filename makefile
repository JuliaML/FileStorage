.PHONY: all
all: losses penalties

.PHONY: losses
losses: $(shell find LossFunctions -name '*.jl')

.PHONY: penalties
penalties: $(shell find PenaltyFunctions -name '*.jl')

%.jl: FORCE
	julia "$@"

FORCE:

