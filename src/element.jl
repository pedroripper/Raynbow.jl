struct Plastic <: Material 
    difuse::RGB{Float64}
    specular::RGB{Float64}
    ambient::RGB{Float64}
    function Plastic(difuse::RGB{Float64} = RGB{Float64}(255.0,0.0,0.0), specular::RGB{Float64} = RGB{Float64}(255.0), ambient::RGB{Float64} = RGB(0.0))
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
    plane::Vector{Float64}
    material::Material
    function Ground(normal::Vector{Float64} = [0.0,1.0,0.0], plane::Vector{Float64} = [0.0,0.0,0.0], material::Material = Plastic(RGB(200.,200.,200.)))
        new(normal, plane, material)
    end
end

mutable struct PointLight <: AbstractLight
    center::Vector{Float64}
    power::Float64
    function PointLight(center::Vector{Float64}, power::Float64)
        new(center, power)
    end
end


function _get_hit(s::Sphere, ray::Ray, tol::Float64 = 0.01)
    a = dot(ray.direction,ray.direction)
    origin_center = (ray.origin - s.center)

    b = dot(2.0*ray.direction,origin_center)
    c = dot(origin_center,origin_center) - s.radius^2

    Δ = b^2 - 4*a*c

    t = nothing

    t = if isapprox(Δ, 0.0) 
        -b/2*a
    elseif Δ > 0.0
        t1 = (-b + sqrt(Δ))/(2*a)
        t2 = (-b - sqrt(Δ))/(2*a)
        if t1 ≥ 0.0 && t2 ≥ 0.0
            min(t1,t2)
        elseif t1 ≥ 0.0
            t1
        else
            t2
        end
    end

    if !isnothing(t)
        hit_point = _evaluate(ray,t)
        # @show hit_point
        return Hit(t, hit_point,normalize(hit_point-s.center), t < 0.0, s)
    end

    return nothing
end

function _get_hit(g::Ground, ray::Ray)
    den = ray.direction'g.normal
    if abs(den) ≈ 0.0
        return nothing
    end
    t = dot(ray.origin - g.plane, g.normal)/den
    hit_point = _evaluate(ray,t)
    return Hit(t, hit_point, -g.normal , t < 0.0, g)
end

function _radiance(light::PointLight, hit::AbstractHit)
    l̂ = normalize(light.center - hit.position)
    r = norm(light.center - hit.position)

    Lᵢ = light.power/(r^2)
    # @show Lᵢ
    return Lᵢ, l̂
end

function _eval_color(shape::AbstractShape, scene::AbstractScene, hit::AbstractHit, origin::Vector{Float64})
    color = shape.material.ambient

    # @show color
    v̂ = normalize(origin - hit.position)
    n̂ = hit.normal
    for light in scene.lights
        Lᵢ, l̂ = _radiance(light, hit)
        # @show Lᵢ, l̂
        # @show shape.material.difuse
        # @show  hit.position
        color += (shape.material.difuse * Lᵢ * n̂'l̂)
        # @show color
                
        # specular missing
        r̂ = 2*(n̂'l̂)*n̂ - l̂
    

        # color += (shape.material.specular * max(0.0, r̂'v̂)^10)
        # @show color
        # @show r̂'v̂
        # @show color
    end
    if typeof(shape) == Ground
        # println(color)
        # sleep(0.5)
    end
    # error()
    return color
end