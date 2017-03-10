using ValueHistories, Primes, LaTeXStrings, Plots
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
        size = (600, 400))

# ---------------------------------------------------------------

history = QHistory(Float64)
for i = 1:100
    isprime(i) && push!(history, i, sin(.1*i))
end
p = plot(history, legend=false)

Plots.svg(_mkpath("qhistory"))

# ---------------------------------------------------------------

history = MVHistory()
for i=1:100
    x = 0.1i
    push!(history, :mysin, x, sin(x))
    push!(history, :mystring, i, "i=$i")
    isprime(i) && push!(history, :mycos, Float32(x), cos(x))
end
p = plot(history)

Plots.svg(_mkpath("mvhistory"))

