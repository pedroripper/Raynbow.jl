abstract type AbstractShape end

struct Sphere <: AbstractShape
    center::AbstractCoordinate
    r::Float64
    function Sphere(center::AbstractCoordinate, r::Float64)
        new(center, r)
    end
end

