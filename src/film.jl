abstract type AbstractFilm end

function Base.zeros(::Type{RGB}, n::Int, m::Int)
    return [RGB(0.0,0.0,0.0) for i in 1:n, j in 1:m]
end

mutable struct Film <: AbstractFilm
    width::Int
    heigh::Int
    nx::Int # number of pixels 
    ny::Int # number of pixels
    img::Matrix{RGB}
    l::Vector{Float64}
    r::Vector{Float64}
    b::Vector{Float64}
    function Film(width::Int,height::Int, nx::Int, ny::Int, l::Vector{Float64}, r::Vector{Float64}, b::Vector{Float64})
        img = zeros(RGB, nx, ny)
        new(width,height, nx, ny, img, l, r, b)
    end
end

function _set_pixel(f::AbstractFilm, i::Int, j::Int, c::RGB)
    f.img[i,j] = c
    return
end

function _get_sample(f::AbstractFilm, i::Int, j::Int)
    return f.l + (f.r-f.l)*(i+0.5)/f.nx, f.b + (f.r-f.b)*(j+0.5)/f.ny
end

function _save(f::AbstractFilm, filename::String = "img.png")
    Images.save(filename, f)
    return
end

