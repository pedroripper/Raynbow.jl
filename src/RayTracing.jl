function _intersect(r::Ray, scene::Scene)
    hits = Vector{Hit}()
    t = 0.0
    p = _evaluate(r,t)
    while _inScene(p)
        for shape in scene.shapes 
            h = _get_hit(shape, p, r.origin, t)
            if !isnothing(h)
                push!(hits, h)
            end
        end
        t += 0.01
        p = _evaluate(r, t)
    end
    return hits
end

function _phong(scene::Scene, hit::Hit, ray::Ray)
    c = [0.0, 0.0, 0.0]
    v̂ = normalize(ray.origin - hit.position)
    for light in scene.lights
        Lᵢ, Î = _radiance(light, hit)
        # c += hit.material.difuse * 
    end
end

function _trace_ray(scene::Scene, Ray)
    
end

function render_raytrace(film::Film, camera::Camera, scene::Scene)

    for i in 1:film.n_pixels_x, j in 1:film.n_pixels_y
        x,y = _get_sample(film, i, j)
        ray = _generate_ray(camera, scene.film, x, y)
        hits = _intersect(ray, scene)
        if isempty(hits)
            _set_pixel(film, i, j, RGB(0,0,0))
        else
            for hit in hits

            end
        end
    end 
end