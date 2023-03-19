abstract type AbstractCamera end

Base.@kwdef mutable struct Camera <: AbstractCamera
    eye::Vector{Float64} = [0.0,0.0,0.0]
    center::Vector{Float64} = [0.0,0.0,0.0]
    up::Vector{Float64} = [0.0,0.0,1.0]

    d::Float64 = 10.0
    θ::Float64 = 60.0
    w::Float64 = 10.0
    h::Float64 = 10.0
end

function _ratio(c::AbstractCamera)
    return c.w/c.h
end

function _get_sample(c::AbstractCamera, i::Int, j::Int)
    return (i+0.5)/c.w , (j+0.5)/Camera.h 
end
