abstract type AbstractRay end

mutable struct Ray <: AbstractRay
    origin::Vector{Float64}
    direction::Vector{Float64}
    function Ray(o::Vector{Float64}, d::Vector{Float64})
        new(o,d)
    end
end

function _evaluate(r::Ray, t::Float64)
    return r.origin + t*r.direction
end

