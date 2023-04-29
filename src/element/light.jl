@enum SamplingMethod begin
    STRATIFIED
    UNIFORM
end

mutable struct PointLight <: AbstractLight
    center::Vector{Float64}
    power::Float64
    function PointLight(center::Vector{Float64}, power::Float64)
        new(center, power)
    end
end

mutable struct RectangularLight <: AbstractLight
    center::Vector{Float64}
    power::Float64
    eᵢ::Vector{Float64}
    eⱼ::Vector{Float64}
    n̂::Vector{Float64}
    Area::Float64
    samples::Int
    sampling_method::SamplingMethod
    function RectangularLight(center::Vector{Float64}, power::Float64,eᵢ::Vector{Float64},eⱼ::Vector{Float64}, samples::Int = 100, method::SamplingMethod = STRATIFIED)
        n̂ = normalize(cross(eᵢ,eⱼ))
        Area = norm(cross(eᵢ,eⱼ))
        new(center, power, eᵢ, eⱼ, n̂, Area,samples,method)
    end
end

function _get_hit(l::RectangularLight, ray::Ray, ε::Float64 = 0.05)
    t = dot(l.center - ray.origin, l.n̂)/dot(ray.direction,l.n̂)
    hit_point = _evaluate(ray,t)
    backfacing = dot(ray.direction, l.n̂) < 0.0
    
    if t > ε && dot(ray.direction,l.n̂) > ε
        return Hit(t, hit_point, l.n̂, backfacing, l)
    end
    return nothing
end

function _get_light_sample(light::RectangularLight, quadrant::Int)
    if quadrant == 0
        return light.center + rand()*(light.eᵢ) +  rand()*(light.eⱼ)
    elseif quadrant == 1
        return light.center + rand()*(light.eᵢ/2.0) +  rand()*(light.eⱼ/2.0)
    elseif quadrant == 2
        return light.center + rand()*light.eᵢ +  rand()*(light.eⱼ/2.0)
    elseif quadrant == 3
        return light.center + rand()*(light.eᵢ/2.0) +  rand()*light.eⱼ
    else
        return light.center + rand()*light.eᵢ +  rand()*light.eⱼ
    end
end

function _sample_radiance(scene::AbstractScene, light::RectangularLight, hit::AbstractHit, sample_i::Int)
    if light.sampling_method == UNIFORM
        s = _get_light_sample(light,0)
    else
        s = _get_light_sample(light,(sample_i%4)+1)
    end

    l̂ = normalize(s - hit.position)
    r = norm(s - hit.position)

    ray = Ray(hit.position, -l̂)
    hit_l = _intersect(ray,scene)
    if isnothing(hit_l) || hit_l.t > r
        Lᵢ = ((light.power*dot(-l̂,light.n̂))/(r^2))*(light.Area/light.samples)
        return Lᵢ,  l̂
    end
    return 0.0, [0.0,0.0,0.0]
end

function _radiance(scene::AbstractScene, light::RectangularLight, hit::AbstractHit, origin::Vector{Float64})
    color = [0.0,0.0,0.0]
    v̂ = normalize(origin - hit.position)
    n̂ = hit.normal
    for i in 1:light.samples
        Lᵢ, l̂ = _sample_radiance(scene, light, hit, i)
        color += hit.element.material.difuse * Lᵢ * max(0.0,dot(n̂,l̂))
        r̂ = 2*(dot(n̂,-l̂))*n̂ - (-l̂)
        color += hit.element.material.specular * max(0.0, dot(r̂,v̂))^100
    end
    return color
end

function _radiance(scene::AbstractScene,light::PointLight, hit::AbstractHit, origin::Vector{Float64})
    color = [0.0,0.0,0.0]
    v̂ = normalize(origin - hit.position)
    n̂ = hit.normal

    l̂ = normalize(light.center - hit.position)
    r = norm(light.center - hit.position)
    
    ray = Ray(hit.position, -l̂)
    hit_l = _intersect(ray,scene)
    # @show color
    if isnothing(hit_l) || hit_l.t > r        
        Lᵢ = light.power/(r^2)
        color += hit.element.material.difuse * Lᵢ * max(0.0,dot(n̂,l̂))
        r̂ = 2*(dot(n̂,-l̂))*n̂ - (-l̂)
        color += hit.element.material.specular * max(0.0, dot(r̂,v̂))^100
    else
        color += [0.0,0.0,0.0]
    end
    # @show color
    return color

end