using Augmentor, ISICArchive, Images, Colors
import ImageTransformations
using Reel, PaddedViews, OffsetArrays

Reel.set_output_type("gif")

_mkpath(fname) = joinpath(dirname(@__FILE__()), fname)
srand(123)

det_ops = (
    :(FlipX()),
    :(FlipY()),
    :(Rotate90()),
    :(Rotate270()),
    :(Rotate180()),
    :(Rotate(15)),
    :(ShearX(10)),
    :(ShearY(10)),
    :(Scale(0.9,0.5)),
    :(Scale(1.2)),
    :(Crop(70:140,25:155)),
    :(CropSize(45, 225)),
    :(Zoom(1.2)),
    :(Resize(100,150)),
    "Crop" => :((Rotate(45),Crop(1:210,1:280))),
    "CropNative" => :((Rotate(45),CropNative(1:210,1:280))),
    :(CropRatio(1)),
)
prob_ops = (
    10 => :(Rotate(-10:10)),
    10 => :(ShearX(-10:10)),
    10 => :(ShearY(-10:10)),
    10 => :(Zoom(0.9:0.05:1.3)),
    10 => :(Scale(0.9:0.05:1.3)),
    10 => :(ElasticDistortion(15,15,0.1)),
    10 => :(ElasticDistortion(10,10,0.2,4,3,true)),
    10 => :(RCropRatio(1)),
)

pattern = load(_mkpath("testpattern_small.png"))
pattern_noalpha = load(_mkpath("testpattern_small_noalpha.png"))

tables = Dict{String,Vector{String}}()

log = Dict{String,Int}()
function makename(symb)
    name = string(symb)
    id = if !haskey(log, name)
        get!(log, name, 1)
    else
        log[name] = log[name]+1
    end
    string(name, id > 1 ? id : "")
end

imgpath = " .. image:: https://raw.githubusercontent.com/JuliaML/FileStorage/master/Augmentor/"
inputpath = string(imgpath, "testpattern_small.png ")

extractname(pair::Pair) = string(pair.first)
extractname(expr::Expr) = string(expr.args[1])
extractexpr(pair::Pair) = pair.second
extractexpr(expr::Expr) = expr

# --------------------------------------------------------------------
# Create pngs

srand(1335)

for op_full in det_ops
    op_expr = extractexpr(op_full)
    descr = string(op_expr)
    op = eval(op_expr)
    name_raw = extractname(op_full)
    name = makename(name_raw)
    if !haskey(tables, name_raw)
        tables[name_raw] = Vector{String}()
    end
    fname = string("operations/", name, ".png")

    outpath = string(imgpath, fname, " ")
    maxlen = max(length(inputpath), length(outpath))
    outpath = rpad(outpath, maxlen, " ")
    inpath = rpad(inputpath, maxlen, " ")
    border = string("+", rpad("", maxlen, "-"), "+", rpad("", maxlen, "-"), "+")
    header = string("|", rpad(" Input", maxlen, " "), "|", rpad(" Output for ``$descr``", maxlen, " "), "|")
    fatborder = string("+", rpad("", maxlen, "="), "+", rpad("", maxlen, "="), "+")
    line = string("|", inpath, "|", outpath, "|")
    table = join((border,header,fatborder,line,border), "\n")
    push!(tables[name_raw], table)

    out = augment(pattern, op)
    save(_mkpath(fname), out)
end

# --------------------------------------------------------------------
# Create gifs

log = Dict{String,Int}()

function drawborder!(img, col)
    img[1:end,   1] .= fill(col, size(img,1))
    img[1:end, end] .= fill(col, size(img,1))
    img[1,   1:end] .= fill(col, size(img,2))
    img[end, 1:end] .= fill(col, size(img,2))
    img
end

centered(img) = OffsetArray(img, convert(Tuple, 1 .- round.([Int], ImageTransformations.center(img))))

srand(1335)

for (nframe, op_full) in prob_ops
    op_expr = extractexpr(op_full)
    descr = string(op_expr)
    op = eval(op_expr)
    name_raw = extractname(op_full)
    name = makename(name_raw)
    if !haskey(tables, name_raw)
        tables[name_raw] = Vector{String}()
    end
    fname = string("operations/", name, ".gif")

    outpath = string(imgpath, fname, " ")
    maxlen = max(length(inputpath), length(outpath))
    outpath = rpad(outpath, maxlen, " ")
    inpath = rpad(inputpath, maxlen, " ")
    border = string("+", rpad("", maxlen, "-"), "+", rpad("", maxlen, "-"), "+")
    header = string("|", rpad(" Input", maxlen, " "), "|", rpad(" Sampled outputs for ``$descr``", maxlen, " "), "|")
    fatborder = string("+", rpad("", maxlen, "="), "+", rpad("", maxlen, "="), "+")
    line = string("|", inpath, "|", outpath, "|")
    table = join((border,header,fatborder,line,border), "\n")
    push!(tables[name_raw], table)

    raw_imgs = [centered(drawborder!(augment(pattern_noalpha, op), colorant"pink")) for i in 1:nframe]
    imgs = map(parent, map(copy, [paddedviews(colorant"#F3F6F6", raw_imgs...)...]))
    insert!(imgs, 1, first(imgs)) # otherwise loop isn't smooth

    film = roll(imgs, fps = 2)
    write(_mkpath(fname), film)
end

# --------------------------------------------------------------------
# Autogenerate .rst tables in correct order.

order = (
    "FlipX", "FlipY",
    "Rotate90", "Rotate180", "Rotate270", "Rotate",
    "ShearX",
    "ShearY",
    "Scale", "Zoom",
    "ElasticDistortion",
    "Crop", "CropNative",
    "CropSize", "CropRatio",
    "RCropRatio",
    "Resize",
)
@assert length(unique(order)) == length(keys(tables))

open(_mkpath("tables.txt"), "w") do io
    for name in order
        lines = tables[name]
        write(io, name, "\n", repeat("*", length(name)+5), "\n\n")
        for line in lines
            write(io, line, "\n\n")
        end
        write(io, "\n\n")
    end
end
