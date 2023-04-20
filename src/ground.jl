mutable struct Ground <:AbstractShape
    normal::Vector{Float64}
    center::Vector{Float64}
    material::Material
    function Ground(normal::Vector{Float64} = [0.0,1.0,0.0], center::Vector{Float64} = [0.0,0.0,0.0], material::Material = Plastic([0.2,0.2,0.2]))
        new(normal, center, material)
    end
end

function _get_hit(g::Ground, ray::Ray)

    t = dot(ray.origin - g.center, g.normal)/(ray.direction'g.normal)
    hit_point = _evaluate(ray,t)
    if t < 0.0 
        return nothing
    end
    
    return Hit(t, hit_point, g.normal , t < 0.0, g)
end
