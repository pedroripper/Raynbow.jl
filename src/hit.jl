mutable struct Hit
    t::Float64
    position::Vector{Float64}
    normal::Vector{Float64}
    backfacing::Bool
    material::Material
end