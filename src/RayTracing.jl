function _intersect(r::Ray, scene::Scene)
    for shape in scene.shapes 
        h = _get_hit(shape, r)
        if !isnothing(h)
            # println("GOT HIT")
            return h
        end
    end
    return nothing
end

function _trace_ray(scene::Scene, ray::Ray)
    hit = _intersect(ray, scene)

    if isnothing(hit)
        return RGB{Float64}(0.0)
    end
    
    if _islight(hit)

        r = hit.t
        # @show r
        color = scene.ambient_color + RGB{Float64}(hit.element.power/(r^2))
    else

        color = _eval_color(hit.element, scene, hit, ray.origin)
        # @show color
    end
    return  color
end

function render(camera::Camera, scene::Scene)
    n_pixel = 0
    painted =  0
    for i in 1:camera.film.n_pixels_x
        for j in 1:camera.film.n_pixels_y
            print("\e[1G")
            print("\e[2K")
            print(" Pixel $(n_pixel) || Painted $(painted)")
            x,y = _get_sample(camera.film, i, j)
            # if  x >1.0 || y > 1.0
            #     @show x,y
            #     sleep(5)
            # end
            ray = _generate_ray(camera, x, y)

            color = _trace_ray(scene, ray)
            if color != RGB(0.0)
                painted += 1
            end
            _set_pixel(camera.film, i, j, color)
            n_pixel +=1
        end

    end 
end