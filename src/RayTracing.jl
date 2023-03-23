function _generate_ray(c::AbstractCamera, f::AbstractFilm, i::Int, j::Int)
    # pixel position on the plane
    u_pix, v_pix = _get_sample(f, i, j)
    
    # ray 
    o = c.eye
    d = - c.d * c.w + u_pix'c.u + v_pix'c.v

    return Ray(o, d)
end

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


function raytrace(scene::Scene)
    film = scene.film

    for i in 1:film.nx, j in 1:film.ny
        ray = _generate_ray(scene.camera, scene.film, i, j)
        hits = _intersect(ray, scene)
        if isempty(hits)
            _set_pixel(film, i, j, RGB(0,0,0))
        else
            for hit in hits

            end
        end
    end 
end