mutable struct Film <: AbstractFilm
    width::Int
    height::Int
    n_pixels_x::Int # number of pixels 
    n_pixels_y::Int # number of pixels
    img::Matrix{RGB{Float64}}
    function Film(width::Int,height::Int, n_pixels_x::Int, n_pixels_y::Int)
        img = zeros(RGB{Float64}, n_pixels_x, n_pixels_y)
        new(width,height, n_pixels_x, n_pixels_y, img)
    end
end

function _set_pixel(f::AbstractFilm, i::Int, j::Int, c::RGB{Float64})
    f.img[i,j] = c
    return
end

function _get_sample(f::AbstractFilm, i::Int, j::Int)
    return (i+0.5)/f.width, (j+0.5)/f.height
end

function _save(f::AbstractFilm, filename::String = "img.pdf")
    ImageMagick.save(filename, f.img)
    return
end

