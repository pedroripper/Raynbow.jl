abstract type AbstractCoordinate end

mutable struct Coordinate <: AbstractCoordinate
    coord:: Vector{Float64}
    function Coordinate(x::Float64, y::Float64, z::Float64)
        new([x,y,z])
    end
end