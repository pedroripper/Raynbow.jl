abstract type AbstractCamera end

mutable struct Camera <: AbstractCamera
    eye::Vector{Float64}
    c::Vector{Float64}
    up::Vector{Float64}

    u::Vector{Float64}
    v::Vector{Float64}
    w::Vector{Float64}

    d::Float64
    θ::Float64
    width::Float64
    height::Float64

    function Camera(
            eye::Vector{Float64}, 
            c::Vector{Float64}, 
            up::Vector{Float64}, 
            d::Float64, 
            θ::Float64, 
        )
        w = normalize(eye - c)
        u = normalize(cross(up,w))
        v = cross(w,u)
        new(eye, c, up, u, v, w, d, θ)
    end 
end

function _to_global_coord(c::AbstractCamera)
    return [c.u c.v c.w] * c
end

