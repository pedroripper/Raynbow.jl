mutable struct Film <: AbstractFilm
    width::Int
    height::Int
    img::Matrix{RGB{Float64}}
    function Film(width::Int,height::Int)
        img = zeros(RGB{Float64}, width, height)
        new(width,height, img)
    end
end

function _set_pixel(f::AbstractFilm, i::Int, j::Int, c::Vector{Float64})
    color = RGB(c[1],c[2],c[3])
    f.img[j,i] = color
    return
end

function _get_sample(f::AbstractFilm, i::Int, j::Int)
    return (i-rand())/f.width, (j-rand())/f.height
end

function _save(f::AbstractFilm, filename::String = "img.png")
    ImageMagick.save(filename, ImageMagick.map(clamp01nan, f.img))
    # ImageMagi/ck.save(filename, f.img)
    return
end

