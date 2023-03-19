abstract type AbstractFilm end

function Base.zeros(::Type{RGB}, n::Int, m::Int)
    return [RGB(0.0,0.0,0.0) for i in 1:n, j in 1:m]
end

mutable struct Film <: AbstractFilm
    w::Int
    h::Int
    img::Matrix{RGB}
    function Film(w::Int,h::Int)
        img = zeros(RGB, w, h)
        new(w,h,img)
    end
end

function _set_pixel(f::AbstractFilm, i::Int, j::Int, c::RGB)
    f.img[i,j] = c
    return
end

function _save(f::AbstractFilm, filename::String = "img.png")
    Images.save(filename, f)
    return
end

