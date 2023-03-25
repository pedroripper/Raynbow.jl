struct Plastic <: Material 
    difuse::RGB
    specular::RGB
    function Plastic(difuse::RGB = RGB(255.0,0.0,0.0), specular::RGB = RGB(255.0))
        new(difuse, specular)
    end
end

struct Sphere <: AbstractShape
    center::Vector{Float64}
    radius::Float64
    material::Material
    function Sphere(center::Vector{Float64}, r::Float64, material::Material)
        new(center, r, material)
    end
end

mutable struct PointLight <: AbstractLight
    center::Vector{Float64}
    power::Float64
    function PointLight(center::Vector{Float64}, power::Float64)
        new(center, power)
    end
end


function _get_hit(s::Sphere, p::Vector{Float64}, o::Vector{Float64}, t::Float64)
    if (p - s.center)' * (p - s.center) - s.radius^2 == 0
        normal = (p - s.center)/s.radius
        backfacing = norm(s.center - o) < norm(p - o)
        return Hit(t, p, normal, backfacing, s)
    else
        return nothing
    end
end

function _radiance(light::PointLight, hit::AbstractHit)
    Î = normalize(light.position - hit.position)
    r = norm(light.position - hit.position)
    Lᵢ = light.power/(r^2)
    return Lᵢ, l̂
end

function _eval_color(shape::AbstractShape, scene::AbstractScene, hit::AbstractHit, origin::Vector{Float64})
    color = RGB(0.0)
    v̂ = normalize(origin - hit.position)
    n̂ = normalize(hit.position)
    for light in scene.lights
        Lᵢ, l̂ = _radiance(light, hit.position)
        color += shape.material.difuse * Lᵢ * n̂'l̂
        # specular missing
    end
    return color
end