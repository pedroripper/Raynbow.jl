abstract type AbstractShape end

struct Plastic <: Material 
    difuse::Float64
    specular::Float64
    function Plastic(difuse::Float64 = 0.5, specular::Float64 = 0.5)
        new(difuse, specular)
    end
end
struct Light <: Material end


struct Sphere <: AbstractShape
    center::Vector{Float64}
    radius::Float64
    material::Material
    function Sphere(center::Vector{Float64}, r::Float64, material::Material)
        new(center, r, material)
    end
end

mutable struct PointLight <: AbstractShape
    center::Vector{Float64}
    power::Float64
    material::Light
    function PointLight(center::Vector{Float64}, power::Float64)
        new(center, power, Light())
    end
end


function _get_hit(s::Sphere, p::Vector{Float64}, o::Vector{Float64}, t::Float64)
    if (p - s.center)' * (p - s.center) - s.radius^2 == 0
        normal = (p - s.center)/s.radius
        backfacing = norm(s.center - o) < norm(p - o)
        return Hit(t, p, normal, backfacing, s.material)
    else
        return nothing
    end
end

function _radiance(light::PointLight, hit::Hit)
    Î = normalize(light.position - hit.position)
    r = norm(light.position - hit.position)
    Lᵢ = light.power/(r^2)
    return Lᵢ, Î
end