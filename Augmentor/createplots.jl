using Augmentor, ISICArchive, Images, Plots, Colors
pyplot(reuse=true);

_mkpath(fname) = joinpath(dirname(@__FILE__()), fname)
srand(123)

img = get(ImageThumbnailRequest(id = "5592ac599fc3c13155a57a85"))

pl = (Either(FlipX(), FlipY(), NoOp()),
      Rotate(0:360),
      Either(ShearX(-5:5),ShearY(-5:5),NoOp()),
      CropSize(170, 170),
      Zoom(1:0.05:1.2),
      Resize(64, 64))

plot(img, size=(256,169), xlim=(1,255), ylim=(1,168), grid=false, ticks=true, color = :black)
Plots.png(_mkpath("readme_1_in.png"))

anim = @animate for i=1:10
    plot(augment(img, pl), size=(169,169), xlim=(1,63), ylim=(1,63), grid=false, ticks=true, color = :black);
end
Plots.gif(anim, _mkpath("readme_1_out.gif"), fps = 2)

# ----------------------------------------------------------------------
# All operation examples

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
)
prob_ops = (
    10 => :(Rotate(-10:10)),
    10 => :(ShearX(-10:10)),
    10 => :(ShearY(-10:10)),
    10 => :(Zoom(0.9:0.05:1.3)),
    10 => :(Scale(0.9:0.05:1.3)),
)

import ImageTransformations
using Reel, PaddedViews, OffsetArrays
Reel.set_output_type("gif")

pattern = load(_mkpath("testpattern_small.png"))
pattern_noalpha = load(_mkpath("testpattern_small_noalpha.png"))

open(_mkpath("tables.txt"), "w") do io
    srand(1335)

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

    imgpath = " .. image:: https://rawgit.com/JuliaML/FileStorage/master/Augmentor/"
    inputpath = string(imgpath, "testpattern_small.png ")

    for op_expr in det_ops
        descr = string(op_expr)
        op = eval(op_expr)
        name = makename(typeof(op).name.name)
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
        write(io, table, "\n\n\n")

        out = augment(pattern, op)
        save(_mkpath(fname), out)
    end

    log = Dict{String,Int}()

    function drawborder!(img, col)
        img[1:end,   1] .= fill(col, size(img,1))
        img[1:end, end] .= fill(col, size(img,1))
        img[1,   1:end] .= fill(col, size(img,2))
        img[end, 1:end] .= fill(col, size(img,2))
        img
    end

    centered(img) = OffsetArray(img, convert(Tuple, 1 .- round.([Int], ImageTransformations.center(img))))

    for (nframe, op_expr) in prob_ops
        descr = string(op_expr)
        op = eval(op_expr)
        name = makename(typeof(op).name.name)
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
        write(io, table, "\n\n\n")

        raw_imgs = [centered(drawborder!(augment(pattern_noalpha, op), colorant"pink")) for i in 1:nframe]
        imgs = map(parent, map(copy, [paddedviews(colorant"#F3F6F6", raw_imgs...)...]))
        insert!(imgs, 1, first(imgs)) # otherwise loop isn't smooth

        film = roll(imgs, fps = 2)
        write(_mkpath(fname), film)
    end
end
