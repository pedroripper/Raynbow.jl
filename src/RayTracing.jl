function _generate_ray(c::AbstractCamera, f::AbstractFilm, i::Int, j::Int)
    # pixel position on the plane
    u_pix, v_pix = _get_sample(f, i, j)
    
    # ray 
    o = c.eye
    d = - c.f * c.w + u * c.u + v * c.v

    return Ray(o, d)
end

function _intersect(r::Ray, scene::Scene)
    hits = Vector{Hit}()
    t = 0.0
    p = _evaluate(r,t)
    while _inScene(p)
        p = _evaluate(r, t)
        for shape in scene.shapes 
            h = _get_hit(shape, r, p, t)
            if !isnothing(h)
                push!(hits, h)
            end
        end
        t += 0.01
    end
    return hits
end

function _phong(scene::Scene, hit::Hit, ray::Ray)
    
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