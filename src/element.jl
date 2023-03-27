struct Plastic <: Material 
    difuse::RGB{Float64}
    specular::RGB{Float64}
    function Plastic(difuse::RGB{Float64} = RGB{Float64}(255.0,0.0,0.0), specular::RGB{Float64} = RGB{Float64}(255.0))
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
    if isapprox((p - s.center)' * (p - s.center) - s.radius^2, 0.0; atol = 0.5)
        normal = (p - s.center)/s.radius
        backfacing = norm(s.center - o) < norm(p - o)
        return Hit(t, p, normal, backfacing, s)
    else
        return nothing
    end
end

function _radiance(light::PointLight, hit::AbstractHit)
    l̂ = normalize(light.center - hit.position)
    r = norm(light.center - hit.position)

    Lᵢ = light.power/(r^2)
    @show Lᵢ
    return Lᵢ, l̂
end

function _eval_color(shape::AbstractShape, scene::AbstractScene, hit::AbstractHit, origin::Vector{Float64})
    println("Getting color")
    color = RGB{Float64}(0.0)
    v̂ = normalize(origin - hit.position)
    n̂ = normalize(hit.position)
    for light in scene.lights
        Lᵢ, l̂ = _radiance(light, hit)

        color += shape.material.difuse * Lᵢ * n̂'l̂
        
        color = RGB{Float64}(abs(color[1]), abs(color[2]), abs(color[3]) )
        
        # specular missing
    end
    # color = color/255.0
    # if color[1] > 1.0 color[1] = 1.0 end
    # if color[2] > 1.0 color[1] = 1.0 end
    # if color[2] > 1.0 color[1] = 1.0 end

    @show color
    # sleep(1.0)
    return color
end