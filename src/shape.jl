abstract type AbstractShape end

struct Sphere <: AbstractShape
    center::Vector{Float64}
    radius::Float64
    material::Material
    function Sphere(center::Vector{Float64}, r::Float64, material::Material)
        new(center, r)
    end
end

mutable struct PointLight <: AbstractShape
    center::Vector{Float64}
    power::Float64
end


function _get_hit(s::Sphere, ray::Ray, p::Vector{Float64}, t::Float64)
    if (p - s.center)' * (p - s.center) - s.radius^2 == 0
        normal = (p - s.center)/s.radius
        backfacing = p - shape.center > 0
        return Hit(t, p, normal, backfacing, s.material)
    else
        return nothing
    end
end
