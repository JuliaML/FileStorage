using LossFunctions, Plots
pyplot()

_mkpath(fname) = joinpath(dirname(@__FILE__()), fname)

# ---------------------------------------------------------------
# README Plots

plot([L2DistLoss(), L1DistLoss(), LPDistLoss(.5), LogitDistLoss(),
      HuberLoss(), L1EpsilonInsLoss(1), L2EpsilonInsLoss(1),
      QuantileLoss(0.7)],
     -4:0.05:4,
     xlim=(-4,4), ylim=(0,5), palette=:darktest, grid=false,
     linestyle=[:dash :solid :solid :dashdot :dash :solid :solid :solid])
Plots.svg(_mkpath("distance"))


plot([ZeroOneLoss(), L1HingeLoss(),L2HingeLoss(), LogitMarginLoss(),
      ModifiedHuberLoss(), PerceptronLoss(), SmoothedL1HingeLoss(1),
      L2MarginLoss(), ExpLoss(), SigmoidLoss(), DWDMarginLoss(1)],
     -2:0.001:2,
    xlab="y * h(x)", ylim=(0,7), palette=:darktest, grid=false,
    linestyle=[:dash :solid :solid :dashdot :dash :solid :solid :dash :solid :dot :dot])
Plots.svg(_mkpath("margin"))

exit()
# ---------------------------------------------------------------
# Readthedocs Plots

default(aspect_ratio = 1, palette=:darktest, size = (512, 512))

plot([LPDistLoss(0.5), LPDistLoss(1.5), LPDistLoss(3)], -3:0.05:3,
     ylim=(0,6))
Plots.svg(_mkpath("LPDistLoss1"))
plot([LPDistLoss(0.5)', LPDistLoss(1.5)', LPDistLoss(3)'], -2:0.005:2,
     ylim=(-3,3))
Plots.svg(_mkpath("LPDistLoss2"))


plot(L2DistLoss(), -3:0.05:3, ylim=(0,7))
Plots.svg(_mkpath("L2DistLoss1"))
plot(L2DistLoss()', -2:0.05:2, ylim=(-3,3))
Plots.svg(_mkpath("L2DistLoss2"))

