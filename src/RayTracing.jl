function _intersect(r::Ray, scene::Scene)
    t = 0.0
    p = _evaluate(r,t)
    while _in_scene(scene, p)
        for shape in scene.shapes 
            h = _get_hit(shape, p, r.origin, t)
            if !isnothing(h)
                println("GOT HIT")
                return h
            end
        end
        t += 0.1
        p = _evaluate(r, t)
        # @show p

    end
    return nothing
end

function _trace_ray(scene::Scene, ray::Ray)
    hit = _intersect(ray, scene)

    if isnothing(hit)

        return RGB{Float64}(0,0,0)
    end
    
    if _islight(hit)

        r = hit.t
        @show r
        color = RGB{Float64}(hit.element.power/(r^2))
    else
        println("IS ELEMENT")

        color = _eval_color(hit.element, scene, hit, ray.origin)
    end
    return  color
end

function render(camera::Camera, scene::Scene)
    n_pixel = 0
    for i in 1:camera.film.n_pixels_x, j in 1:camera.film.n_pixels_y
        println("Pixel $(n_pixel)")
        x,y = _get_sample(camera.film, i, j)
        ray = _generate_ray(camera, x, y)
        # @show ray.origin
        color = _trace_ray(scene, ray)
        @show color
        _set_pixel(camera.film, i, j, color)
        n_pixel +=1

    end 
end