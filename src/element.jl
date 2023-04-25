include("material.jl")
include("sphere.jl")
include("light.jl")
include("ground.jl")
include("box.jl")

function _eval_color(shape::AbstractShape, scene::AbstractScene, hit::AbstractHit, origin::Vector{Float64})
    color = shape.material.ambient
    

    v̂ = normalize(origin - hit.position)
    n̂ = hit.normal

    for light in scene.lights

        if typeof(light) == RectangularLight
            for i in 1:light.samples
                Lᵢ, l̂ = _sample_radiance(scene, light, hit, i)
            
                color += shape.material.difuse * Lᵢ * max(0.0,dot(n̂,l̂))

                r̂ = 2*(dot(n̂,-l̂))*n̂ - (-l̂)

                color += shape.material.specular * max(0.0, dot(r̂,v̂))^100
            end
        else
            Lᵢ, l̂ = _radiance(scene,light, hit)
            
            color += shape.material.difuse * Lᵢ * max(0.0,dot(n̂,l̂))

            r̂ = 2*(dot(n̂,-l̂))*n̂ - (-l̂)

            color += shape.material.specular * max(0.0, dot(r̂,v̂))^100
        end

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