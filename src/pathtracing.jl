function _trace_path(scene::Scene, ray::Ray, max_depth::Int)
    L = [0.0,0.0,0.0]
    β = [1.0,1.0,1.0]

    for i in 1:max_depth
        hit = _intersect(ray, scene)
        if isnothing(hit)
            if i == 1
                return scene.ambient_color
            else
                break
            end
        end
        if typeof(hit.element) == RectangularLight
            if i == 1
                return (hit.element.power/(norm(hit.position - ray.origin)^2))*[1.0,1.0,1.0]
            else
                break
            end
        end
        material = hit.element.material
        p = hit.position
        n = hit.normal
        light = rand(scene.lights)
        Le = _radiance(scene, light, hit, ray.origin, true)

        L += (Le.*_get_brdf(material)).*β

        if typeof(material) == Metal
            p = hit.position
            n̂ = hit.normal
            v̂ = normalize(ray.origin-p)

            R₀ = hit.element.material.reflectance

            R = R₀ + (1.0-R₀)*(1.0 - dot(-v̂,n̂))^5

            color = (1.0 - R)*_radiance(scene, light, hit, ray.origin, true)

            r̂ = normalize(2*(dot(n̂,-v̂))*n̂ - (-v̂))

            ray = Ray(p, hit.backfacing ? -r̂ : r̂)

            color += R * _trace_path(scene, ray, max_depth-1)

            return color
        end
        wih, θ, _= _get_sample(material)
        pdf = _get_pdf(material, θ)
        wi = _normal_to_global(n, wih)

        β .*= _get_brdf(material) .* max(0.0,dot(n, wi)) ./ pdf
        # @show β
        ray = Ray(p, wi)
    end

    return L

end

function pathtrace(camera::Camera, scene::Scene, max_depth::Int, pixel_samples::Int = 1)
    n_pixel = 0
    painted =  0
    for i in 1:camera.film.width
        for j in 1:camera.film.height
            color = [0.0,0.0,0.0]
            for k in 1:pixel_samples
                x,y = _get_sample(camera.film, i, j)

                ray = _generate_ray(camera, x, y)
                color += _trace_path(scene, ray, max_depth)
            end
            if color != [0.0,0.0,0.0]
                painted += 1
            end
            _set_pixel(camera.film, i, j, color/pixel_samples)
            n_pixel +=1
        end

    end 

end