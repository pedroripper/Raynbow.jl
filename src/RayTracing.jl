function _intersect(r::Ray, scene::Scene)
    closest_hit = nothing
    for shape in [scene.shapes; scene.lights]
        h = _get_hit(shape, r)
        if !isnothing(h) && isnothing(closest_hit)
            closest_hit = h
        elseif !isnothing(h) && h.t <  closest_hit.t
            closest_hit = h
        end
    end
    return closest_hit
end

function _intersect(r::Ray, light::AbstractLight)
    if typeof(light) == PointLight
        return nothing
    end
    h = _get_hit(light, r)
    if !isnothing(h)
        return h
    end
    return nothing
end

function _trace_ray(scene::Scene, ray::Ray)
    hit = _intersect(ray, scene)

    if isnothing(hit)
        return scene.ambient_color
    end
    
    if _islight(hit)
        r = hit.t
        # color = scene.ambient_color + [hit.element.power/(r^2), hit.element.power/(r^2), hit.element.power/(r^2)]
        color = [1.0,1.0,1.0]
    else
        if typeof(hit.element.material) == Metal
            color = _eval_color_metal(hit.element, scene, hit, ray.origin)
        else
            color = _eval_color(hit.element, scene, hit, ray.origin)
        end
    end
    return  color
end

function raytrace(camera::Camera, scene::Scene, pixel_samples::Int = 1)
    n_pixel = 0
    painted =  0
    for i in 1:camera.film.width
        for j in 1:camera.film.height
            color = [0.0,0.0,0.0]
            for k in 1:pixel_samples
                x,y = _get_sample(camera.film, i, j)

                ray = _generate_ray(camera, x, y)

                color += _trace_ray(scene, ray)
            end
            if color != [0.0,0.0,0.0]
                painted += 1
            end
            _set_pixel(camera.film, i, j, color/pixel_samples)
            n_pixel +=1
        end

    end 
end