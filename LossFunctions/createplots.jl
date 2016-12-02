using LossFunctions, Plots
pyplot()

_mkpath(fname) = joinpath(dirname(@__FILE__()), fname)
srand(123)

# ---------------------------------------------------------------
# README Plots

xld  = "\$\\hat{y} - y\$"
xlm  = "\$y \\cdot \\hat{y}\$"
yld  = "\$L(\\hat{y} - y)\$"
yldd = "\$L'(\\hat{y} - y)\$"
ylm  = "\$L(y \\cdot \\hat{y})\$"
ylmd = "\$L'(y \\cdot \\hat{y})\$"
default(bg_outside=RGBA(1,1,1,0))

plot([L2DistLoss(), L1DistLoss(), LPDistLoss(.5), LogitDistLoss(),
      HuberLoss(), L1EpsilonInsLoss(1), L2EpsilonInsLoss(1),
      QuantileLoss(0.7)],
     -4:0.01:4,
     xlab=xld, ylab=yld,
     xlim=(-4,4), ylim=(0,5), palette=:darktest, grid=false,
     linestyle=[:dash :solid :solid :dashdot :dash :solid :solid :solid])
Plots.svg(_mkpath("distance"))

plot([ZeroOneLoss(), L1HingeLoss(),L2HingeLoss(), LogitMarginLoss(),
      ModifiedHuberLoss(), PerceptronLoss(), SmoothedL1HingeLoss(1),
      L2MarginLoss(), ExpLoss(), SigmoidLoss(), DWDMarginLoss(1)],
     -2:0.001:2,
     xlab=xlm, ylab=ylm,
     ylim=(0,7), palette=:darktest, grid=false,
     linestyle=[:dash :solid :solid :dashdot :dash :solid :solid :dash :solid :dot :dot])
Plots.svg(_mkpath("margin"))

# ---------------------------------------------------------------
# Readthedocs Distance Plots

default(bg_outside=RGBA(1,1,1,0), aspect_ratio = 1, palette=:darktest, size = (350, 350))

# LP Dist Loss
plot([LPDistLoss(0.5), LPDistLoss(1.5), LPDistLoss(3)],
     xlab=xld, ylab=yld,
     -2:0.01:2, ylim=(0,4))
Plots.svg(_mkpath("LPDistLoss1"))
plot([LPDistLoss(0.5)', LPDistLoss(1.5)', LPDistLoss(3)'],
     xlab=xld, ylab=yldd,
     -2:0.005:2, ylim=(-2,2))
Plots.svg(_mkpath("LPDistLoss2"))

# L1 Dist Loss
plot(L1DistLoss(), -2:0.05:2, ylim=(0,4), xlab=xld, ylab=yld)
Plots.svg(_mkpath("L1DistLoss1"))
plot(L1DistLoss()', -2:0.01:2, ylim=(-2,2), xlab=xld, ylab=yldd)
Plots.svg(_mkpath("L1DistLoss2"))

# L2 Dist Loss
plot(L2DistLoss(), -2:0.05:2, ylim=(0,4), xlab=xld, ylab=yld)
Plots.svg(_mkpath("L2DistLoss1"))
plot(L2DistLoss()', -2:0.05:2, ylim=(-2,2), xlab=xld, ylab=yldd)
Plots.svg(_mkpath("L2DistLoss2"))

# Logit Dist Loss
plot(LogitDistLoss(), -2:0.05:2, ylim=(0,4), xlab=xld, ylab=yld)
Plots.svg(_mkpath("LogitDistLoss1"))
plot(LogitDistLoss()', -2:0.05:2, ylim=(-2,2), xlab=xld, ylab=yldd)
Plots.svg(_mkpath("LogitDistLoss2"))

# HuberLoss
plot([HuberLoss(0.5), HuberLoss(1), HuberLoss(1.5)],
     xlab=xld, ylab=yld,
     -2:0.01:2, ylim=(0,4))
Plots.svg(_mkpath("HuberLoss1"))
plot([HuberLoss(0.5)', HuberLoss(1)', HuberLoss(1.5)'],
     xlab=xld, ylab=yldd,
     -2:0.005:2, ylim=(-2,2))
Plots.svg(_mkpath("HuberLoss2"))

# L1EpsilinInsLoss
plot([L1EpsilonInsLoss(0.5), L1EpsilonInsLoss(1), L1EpsilonInsLoss(1.5)],
     xlab=xld, ylab=yld,
     -2:0.01:2, ylim=(-0.05,4))
Plots.svg(_mkpath("L1EpsilonInsLoss1"))
plot([L1EpsilonInsLoss(0.5)', L1EpsilonInsLoss(1)', L1EpsilonInsLoss(1.5)'],
     xlab=xld, ylab=yldd,
     -2:0.005:2, ylim=(-2.05,2))
Plots.svg(_mkpath("L1EpsilonInsLoss2"))

# L2EpsilonInsLoss
plot([L2EpsilonInsLoss(0.5), L2EpsilonInsLoss(1), L2EpsilonInsLoss(1.5)],
     xlab=xld, ylab=yld,
     -2:0.01:2, ylim=(-0.05,4))
Plots.svg(_mkpath("L2EpsilonInsLoss1"))
plot([L2EpsilonInsLoss(0.5)', L2EpsilonInsLoss(1)', L2EpsilonInsLoss(1.5)'],
     xlab=xld, ylab=yldd,
     -2:0.005:2, ylim=(-2.05,2))
Plots.svg(_mkpath("L2EpsilonInsLoss2"))

# PeriodicLoss
plot([PeriodicLoss(.5), PeriodicLoss(1), PeriodicLoss(1.5)],
     xlab=xld, ylab=yld,
     -1:0.01:1, ylim=(0,2))
Plots.svg(_mkpath("PeriodicLoss1"))
plot([PeriodicLoss(.5)', PeriodicLoss(1)', PeriodicLoss(1.5)'],
     xlab=xld, ylab=yldd,
     -8:0.01:8, ylim = (-8,8))
Plots.svg(_mkpath("PeriodicLoss2"))

# QuantileLoss
plot([QuantileLoss(0.25), QuantileLoss(0.5), QuantileLoss(.75)],
     xlab=xld, ylab=yld,
     -2:0.01:2, ylim=(0,4))
Plots.svg(_mkpath("QuantileLoss1"))
plot([QuantileLoss(0.25)', QuantileLoss(0.5)', QuantileLoss(.75)'],
     xlab=xld, ylab=yldd,
     -2:0.005:2, ylim=(-2,2))
Plots.svg(_mkpath("QuantileLoss2"))

# ---------------------------------------------------------------
# Readthedocs Margin Plots

# Zero One Loss
plot(ZeroOneLoss(), -2:0.01:2, ylim=(-.05,4), xlab=xlm, ylab=ylm)
Plots.svg(_mkpath("ZeroOneLoss1"))
plot(ZeroOneLoss()', -2:0.05:2, ylim=(-2.05,2), xlab=xlm, ylab=ylmd)
Plots.svg(_mkpath("ZeroOneLoss2"))

# Perceptron Loss
plot(PerceptronLoss(), -2:0.01:2, ylim=(-.05,4), xlab=xlm, ylab=ylm)
Plots.svg(_mkpath("PerceptronLoss1"))
plot(PerceptronLoss()', -2:0.005:2, ylim=(-2.05,2), xlab=xlm, ylab=ylmd)
Plots.svg(_mkpath("PerceptronLoss2"))

# Hinge Loss
plot(L1HingeLoss(), -2:0.01:2, ylim=(-.05,4), xlab=xlm, ylab=ylm)
Plots.svg(_mkpath("L1HingeLoss1"))
plot(L1HingeLoss()', -2:0.005:2, ylim=(-2.05,2), xlab=xlm, ylab=ylmd)
Plots.svg(_mkpath("L1HingeLoss2"))

# L2 Hinge Loss
plot(L2HingeLoss(), -2:0.01:2, ylim=(-.05,4), xlab=xlm, ylab=ylm)
Plots.svg(_mkpath("L2HingeLoss1"))
plot(L2HingeLoss()', -2:0.005:2, ylim=(-2.05,2), xlab=xlm, ylab=ylmd)
Plots.svg(_mkpath("L2HingeLoss2"))

# Hinge Loss
plot([SmoothedL1HingeLoss(0.5),SmoothedL1HingeLoss(1.0),SmoothedL1HingeLoss(1.5),SmoothedL1HingeLoss(2.0)],
      -2:0.01:2, ylim=(-.05,4),
      xlab=xlm, ylab=ylm)
Plots.svg(_mkpath("SmoothedL1HingeLoss1"))
plot([SmoothedL1HingeLoss(0.5)',SmoothedL1HingeLoss(1.0)',SmoothedL1HingeLoss(1.5)',SmoothedL1HingeLoss(2.0)'],
     -2:0.005:2, ylim=(-2.05,2),
     xlab=xlm, ylab=ylmd)
Plots.svg(_mkpath("SmoothedL1HingeLoss2"))

# Modified Huber Loss
plot(ModifiedHuberLoss(), -4:0.01:4, xticks=[-4:4...], yticks=[0:8...], ylim=(-.05,8), xlab=xlm, ylab=ylm)
Plots.svg(_mkpath("ModifiedHuberLoss1"))
plot(ModifiedHuberLoss()', -4:0.005:4, xticks=[-4:4...], yticks=[-4:4...], ylim=(-4.05,4), xlab=xlm, ylab=ylmd)
Plots.svg(_mkpath("ModifiedHuberLoss2"))

# DWD Margin Loss
plot([DWDMarginLoss(0.5),DWDMarginLoss(1.0),DWDMarginLoss(1.5)],
      -2:0.01:2, ylim=(0,4),
      xlab=xlm, ylab=ylm)
Plots.svg(_mkpath("DWDMarginLoss1"))
plot([DWDMarginLoss(0.5)',DWDMarginLoss(1.0)',DWDMarginLoss(1.5)'],
     -2:0.005:2, ylim=(-2,2),
     xlab=xlm, ylab=ylmd)
Plots.svg(_mkpath("DWDMarginLoss2"))

# L2 Margin Loss
plot(L2MarginLoss(), -2:0.01:2, ylim=(0,4), xlab=xlm, ylab=ylm)
Plots.svg(_mkpath("L2MarginLoss1"))
plot(L2MarginLoss()', -2:0.005:2, ylim=(-2,2), xlab=xlm, ylab=ylmd)
Plots.svg(_mkpath("L2MarginLoss2"))

# Logit Margin Loss
plot(LogitMarginLoss(), -2:0.01:2, ylim=(0,4), xlab=xlm, ylab=ylm)
Plots.svg(_mkpath("LogitMarginLoss1"))
plot(LogitMarginLoss()', -2:0.005:2, ylim=(-2,2), xlab=xlm, ylab=ylmd)
Plots.svg(_mkpath("LogitMarginLoss2"))

# Exp Loss
plot(ExpLoss(), -2:0.01:2, ylim=(0,4), xlab=xlm, ylab=ylm)
Plots.svg(_mkpath("ExpLoss1"))
plot(ExpLoss()', -2:0.005:2, ylim=(-2,2), xlab=xlm, ylab=ylmd)
Plots.svg(_mkpath("ExpLoss2"))

# Sigmoid Loss
plot(SigmoidLoss(), -2:0.01:2, ylim=(0,4), xlab=xlm, ylab=ylm)
Plots.svg(_mkpath("SigmoidLoss1"))
plot(SigmoidLoss()', -2:0.005:2, ylim=(-2,2), xlab=xlm, ylab=ylmd)
Plots.svg(_mkpath("SigmoidLoss2"))
