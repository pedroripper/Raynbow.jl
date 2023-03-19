abstract type AbstractLight end


mutable struct PointLight <: AbstractLight
    power::Float64
    pos::Vector{Float64}
end
