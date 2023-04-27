struct Sphere <: AbstractShape
    center::Vector{Float64}
    radius::Float64
    material::Material
    function Sphere(center::Vector{Float64}, r::Float64, material::Material)
        new(center, r, material)
    end
end


function _get_hit(s::Sphere, ray::Ray, ε::Float64 = 0.01)
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
        elseif t2 ≥ 0.0
            t = t2
        end
    end

    if !isnothing(t)  && t > ε

        hit_point = _evaluate(ray,t)
        n̂ = normalize(hit_point-s.center)
        backfacing = dot(ray.direction, n̂) < 0.0
        n̂ = backfacing ? -n̂ : n̂

        return Hit(t, hit_point,n̂, backfacing, s)
    end

    return nothing
end