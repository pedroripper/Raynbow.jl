mutable struct Ground <:AbstractShape
    normal::Vector{Float64}
    center::Vector{Float64}
    material::Material
    function Ground(normal::Vector{Float64} = [0.0,1.0,0.0], center::Vector{Float64} = [0.0,0.0,0.0], material::Material = Plastic([0.2,0.2,0.2]))
        new(normal, center, material)
    end
end

function _get_hit(g::Ground, ray::Ray, ε::Float64 = 1e-10)

    t = dot(ray.origin - g.center, g.normal)/dot(ray.direction,g.normal)
    hit_point = _evaluate(ray,t)
    n̂ = normalize(g.normal)
    backfacing = dot(ray.direction, n̂) < 0.0
    n̂ = backfacing ? -n̂ : n̂
    
    if t > ε && dot(ray.direction,g.normal) > ε
        return Hit(t, hit_point, n̂, backfacing, g)
    end
    return nothing
end
