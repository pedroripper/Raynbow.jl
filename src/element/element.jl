include("material.jl")
include("sphere.jl")
include("light.jl")
include("plane.jl")


function _eval_color(shape::AbstractShape, scene::AbstractScene, hit::AbstractHit, origin::Vector{Float64})
    color = shape.material.ambient

    for light in scene.lights
        _radiance(scene, light, hit, origin, color)
    end

    return color
end

function _eval_color_metal(shape::AbstractShape, scene::AbstractScene, hit::AbstractHit, origin::Vector{Float64})
    p = hit.position
    n̂ = hit.normal
    v̂ = normalize(origin-p)

    R₀ = shape.material.reflectance

    R = R₀ + (1.0-R₀)*(1.0 - dot(-v̂,n̂))^5

    color = (1.0 - R)*_eval_color(shape, scene, hit, origin)

    r̂ = normalize(2*(dot(n̂,-v̂))*n̂ - (-v̂))

    ray = Ray(p, hit.backfacing ? -r̂ : r̂)

    color += R * _trace_ray(scene, ray)

    return color
end