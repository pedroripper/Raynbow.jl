struct Plastic <: Material 
    difuse::Vector{Float64}
    specular::Vector{Float64}
    ambient::Vector{Float64}
    function Plastic(difuse::Vector{Float64} = [1.0,0.0,0.0], specular::Vector{Float64} = [0.5,0.5,0.5], ambient::Vector{Float64} = [0.1,0.1,0.1])
        new(difuse, specular,ambient)
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

mutable struct Ground <:AbstractShape
    normal::Vector{Float64}
    center::Vector{Float64}
    material::Material
    function Ground(normal::Vector{Float64} = [0.0,1.0,0.0], center::Vector{Float64} = [0.0,0.0,0.0], material::Material = Plastic([0.2,0.2,0.2]))
        new(normal, center, material)
    end
end

mutable struct PointLight <: AbstractLight
    center::Vector{Float64}
    power::Float64
    function PointLight(center::Vector{Float64}, power::Float64)
        new(center, power)
    end
end


function _get_hit(s::Sphere, ray::Ray, ε::Float64 = 0.1)
    a = dot(ray.direction,ray.direction)
    origin_center = (ray.origin - s.center)

    b = dot(2.0*ray.direction,origin_center)
    c = dot(origin_center,origin_center) - s.radius^2

    Δ = b^2 - 4*a*c

    t = nothing

    if Δ ≈ 0.0
        t = -b/2*a
    elseif Δ > 0.0
        t1 = (-b + sqrt(Δ))/(2*a)
        t2 = (-b - sqrt(Δ))/(2*a)
        if t1 ≥ 0.0 && t2 ≥ 0.0
            t = min(t1,t2)
        elseif t1 ≥ 0.0
            t = t1
        else
            t = t2
        end
    end

    if !isnothing(t)  && t > ε

        hit_point = _evaluate(ray,t)

        return Hit(t, hit_point,normalize(hit_point-s.center), t < 0.0, s)
    end

    return nothing
end

function _get_hit(g::Ground, ray::Ray)

    t = dot(ray.origin - g.center, g.normal)/(ray.direction'g.normal)
    hit_point = _evaluate(ray,t)
    if t < 0.0 
        return nothing
    end
    return Hit(t, hit_point, -g.normal , t < 0.0, g)
end

function _get_hit(l::PointLight, ray::Ray)
    if normalize(l.center-ray.origin) == ray.direction
        t = norm(l.center-ray.origin)
        hit_point = _evaluate(ray,t)
        return Hit(t, hit_point, [0.0,0.0,0.0] , t < 0.0, l)
    end
    return nothing
end

function _radiance(light::PointLight, hit::AbstractHit)
    
    l̂ = normalize(light.center - hit.position)
    r = norm(light.center - hit.position)

    Lᵢ = light.power/(r^2)
    return Lᵢ, l̂
end


function _radiance(scene::AbstractScene,light::PointLight, hit::AbstractHit)
    
    l̂ = normalize(light.center - hit.position)
    r = norm(light.center - hit.position)
    
    ray = Ray(hit.position, -l̂)
    hit_l = _intersect(ray,scene)

    if isnothing(hit_l) || hit_l.t > r
        Lᵢ = light.power/(r^2)
        return Lᵢ,  l̂
    end
    return 0.0, [0.0,0.0,0.0]
end


function _eval_color(shape::AbstractShape, scene::AbstractScene, hit::AbstractHit, origin::Vector{Float64})
    color = shape.material.ambient
    

    v̂ = normalize(origin - hit.position)
    n̂ = hit.normal

    for light in scene.lights

        Lᵢ, l̂ = _radiance(scene,light, hit)
    
        color += shape.material.difuse * Lᵢ * max(0.0,dot(n̂,-l̂))

        r̂ = 2*(dot(n̂,-l̂))*n̂ - (-l̂)

        color += shape.material.specular * max(0.0, dot(r̂,v̂))^100
        
    end

    return color
end