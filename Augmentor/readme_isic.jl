using Augmentor, ISICArchive, Plots
pyplot(reuse=true);
mkpath(fname) = joinpath(dirname(@__FILE__()), fname)

srand(123)

img = get(ImageThumbnailRequest(id = "5592ac599fc3c13155a57a85"))

pipeline =
    Either(1=>FlipX(), 1=>FlipY(), 2=>NoOp()) |>
    Rotate(0:360) |>
    ShearX(-5:5) * ShearY(-5:5) |>
    CropSize(165, 165) |>
    Zoom(1:0.05:1.2) |>
    Resize(64, 64)

# Create image that shows the input
plot(img, size=(256,169), xlim=(1,255), ylim=(1,168), grid=false, ticks=true)
Plots.png(mkpath("readme/isic_in.png"))

# create animate gif that shows 10 outputs
anim = @animate for i=1:10
    plot(augment(img, pipeline), size=(169,169), xlim=(1,63), ylim=(1,63), grid=false, ticks=true);
end
Plots.gif(anim, mkpath("readme/isic_out.gif"), fps = 2)
