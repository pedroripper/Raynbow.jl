struct Box <: AbstractShape
    b_min::Vector{Float64}
    b_max::Vector{Float64}
    material::Material
    function Box(b_min::Vector{Float64}, b_max::Vector{Float64}, material::Material)
        new(b_min, b_max, material)
    end
end

function _get_normal(b::Box, point::Vector{Float64})
    normal = [0.0, 0.0, 0.0]
    eps = 1e-6
    
    if abs(point[1] - b.b_min[1]) < eps
        normal = [-1.0, 0.0, 0.0]
    elseif abs(point[1] - b.b_max[1]) < eps
        normal = [1.0, 0.0, 0.0]
    elseif abs(point[2] - b.b_min[2]) < eps
        normal = [0.0, -1.0, 0.0]
    elseif abs(point[2] - b.b_max[2]) < eps
        normal = [0.0, 1.0, 0.0]
    elseif abs(point[3] - b.b_min[3]) < eps
        normal = -[0.0, 0.0, -1.0]   ###
    elseif abs(point[3] - b.b_max[3]) < eps
        normal = [0.0, 0.0, 1.0]  
    end
    
    return normal
end

function _get_hit(b::Box, ray::Ray)
    t₀ = (b.b_min - ray.origin)./ray.direction
    t₁ = (b.b_max - ray.origin)./ray.direction

    t_near = [min(t₀[i],t₁[i]) for i in 1:3]
    t_far =  [max(t₀[i],t₁[i]) for i in 1:3]

    t_min = t_near[argmax(t_near)]
    t_max = t_far[argmin(t_far)]

    if t_min < 0
        t_min = t_max
        if t_min < 0
            return nothing
        end
    end

    hit_point = _evaluate(ray,t_min)
    hit_normal = _get_normal(b, hit_point)
    backfacing = dot(-hit_normal, ray.direction) > 0.0
    hit = Hit(t_min, hit_point, hit_normal, backfacing, b)
    return hit
end
