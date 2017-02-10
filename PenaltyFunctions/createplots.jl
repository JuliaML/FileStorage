using PenaltyFunctions, LaTeXStrings, Plots
pyplot()

_mkpath(fname) = joinpath(dirname(@__FILE__()), fname)
srand(123)

# ---------------------------------------------------------------
# README Plots

fnt = Plots.Font("ubuntu",8,:hcenter,:vcenter,0.0,
                 RGB{FixedPointNumbers.Normed{UInt8, 8}}(0.0,0.0,0.0))
default(bg_outside = RGBA(1,1,1,0),
        grid = false,
        legendfont = fnt,
        palette = :darktest,
        aspect_ratio = 1,
        size = (400, 400))

p = plot(L1Penalty(); ylim = (0, 8))
for pen in [L2Penalty(),
            ElasticNetPenalty(.5),
            MCPPenalty(1.), SCADPenalty(3.7, 0.4),
            LogPenalty(1.)]
    plot!(p, pen)
end
plot!(p, xlab = L"\theta_1", ylab = L"g(\theta_1)", xlim = (-4, 4))

p[1][1][:linestyle] = :solid
p[1][2][:linestyle] = :solid
p[1][3][:linestyle] = :dash
p[1][4][:linestyle] = :dashdot
p[1][5][:linestyle] = :dash
p[1][6][:linestyle] = :dot

Plots.svg(_mkpath("univariate"))

function cont_xy(penalty, stepx = 0.005, stepy = 0.0001)
    x = -1:stepx:1
    yp = 0:stepy:1
    ref = round(value(penalty, [1., 0]), 4)
    xs = collect(i for j in yp, i in x if round(value(penalty, [i,j]), 4) ≈ ref)
    ys = collect(j for j in yp, i in x if round(value(penalty, [i,j]), 4) ≈ ref)
    vcat(xs, reverse(xs)), vcat(ys, -ys)
end

default(size = (400, 400))
p = plot(cont_xy(L1Penalty())...)
plot!(cont_xy(L2Penalty())...)
plot!(cont_xy(ElasticNetPenalty(0.5))...)
plot!(cont_xy(MCPPenalty(1.))...)
plot!(cont_xy(SCADPenalty(3.7, 0.4))...)
plot!(cont_xy(LogPenalty(1.))...)
plot!(p, xlab = L"\theta_1", ylab = L"\theta_2",
         legend = false,
         xlim = (-1.2, 1.2), ylim = (-1.2, 1.2))

p[1][1][:linestyle] = :solid
p[1][2][:linestyle] = :solid
p[1][3][:linestyle] = :dash
p[1][4][:linestyle] = :dashdot
p[1][5][:linestyle] = :dash
p[1][6][:linestyle] = :dot

Plots.svg(_mkpath("bivariate"))


