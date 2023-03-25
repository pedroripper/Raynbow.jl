function _intersect(r::Ray, scene::Scene)
    t = 0.0
    p = _evaluate(r,t)
    while _inScene(p)
        for shape in scene.shapes 
            h = _get_hit(shape, p, r.origin, t)
            if !isnothing(h)
                return h
            end
        end
        t += 0.01
        p = _evaluate(r, t)
    end
    return nothing
end

function _trace_ray(scene::Scene, ray::Ray)
    hit = _intersect(ray, scene)

    if isnothing(hit)
        return RGB(0,0,0)
    end

    if _islight(hit)
        r = hit.t
        color = RGB(hit.element.power/(r^2))
    else
        color = _eval_color(hit.material, scene, hit, ray.origin)
    end
    return  color
end

function render(camera::Camera, scene::Scene)
    for i in 1:camera.film.n_pixels_x, j in 1:camera.film.n_pixels_y
        x,y = _get_sample(camera.film, i, j)
        ray = _generate_ray(camera, x, y)
        color = _trace_ray(scene, ray)
        _set_pixel(camera.film, i, j, color)
    end 
end