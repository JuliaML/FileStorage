using Augmentor, ImageTransformations, MNIST, ISICArchive, FixedPointNumbers, Colors, FileIO

mkpath(fname) = joinpath(dirname(@__FILE__()), fname)
srand(123)

toimg(A) = imresize(reinterpret(Gray{N0f8}, UInt8.(A)), 28*4, 28*4)

input_img  = MNIST.trainimage(19)
output_img = augment(input_img, Rotate180())
save(mkpath("readthedocs/background_mnist_in.png"),  toimg(input_img))
save(mkpath("readthedocs/background_mnist_out.png"), toimg(output_img))

input_img  = get(ImageThumbnailRequest(id = "5592ac599fc3c13155a57a85"))
output_img = augment(input_img, Rotate180())
save(mkpath("readthedocs/background_isic_in.png"),  input_img)
save(mkpath("readthedocs/background_isic_out.png"), output_img)
