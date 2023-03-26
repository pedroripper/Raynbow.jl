mutable struct Hit <: AbstractHit
    t::Float64
    position::Vector{Float64}
    normal::Vector{Float64}
    backfacing::Bool
    element::AbstractElement
end

function _islight(hit::Hit)
    return typeof(hit.element) == AbstractLight
end