.PHONY: all
all: losses

.PHONY: losses
losses: $(shell find LossFunctions -name '*.jl')

%.jl: FORCE
	julia "$@"

FORCE:

