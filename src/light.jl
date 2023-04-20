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
    function RectangularLight(center::Vector{Float64}, power::Float64,eᵢ::Vector{Float64},eⱼ::Vector{Float64}, samples::Int = 100)
        n̂ = normalize(cross(eᵢ,eⱼ))
        Area = norm(cross(eᵢ,eⱼ))
        new(center, power, eᵢ, eⱼ, n̂, Area,samples)
    end
end

function _get_hit(l::PointLight, ray::Ray)
    if normalize(l.center-ray.origin) == ray.direction
        t = norm(l.center-ray.origin)
        hit_point = _evaluate(ray,t)
        return Hit(t, hit_point, [0.0,0.0,0.0] , t < 0.0, l)
    end
    return nothing
end

function _get_light_sample(light::RectangularLight, quadrant::Int)
    if quadrant == 1
        return light.center + rand()*(light.eᵢ/2.0) +  rand()*(light.eⱼ/2.0)
    elseif quadrant == 2
        return light.center + rand()*light.eᵢ +  rand()*(light.eⱼ/2.0)
    elseif quadrant == 3
        return light.center + rand()*(light.eᵢ/2.0) +  rand()*light.eⱼ
    else
        return light.center + rand()*light.eᵢ +  rand()*light.eⱼ
    end
end

function _radiance(light::PointLight, hit::AbstractHit)
    
    l̂ = normalize(light.center - hit.position)
    r = norm(light.center - hit.position)

    Lᵢ = light.power/(r^2)
    return Lᵢ, l̂
end


function _radiance(scene::AbstractScene,light::PointLight, hit::AbstractHit)
    
    l̂ = normalize(light.center - hit.position)
    r = norm(light.center - hit.position)
    
    ray = Ray(hit.position, -l̂)
    hit_l = _intersect(ray,scene)

    if isnothing(hit_l) || hit_l.t > r
        Lᵢ = light.power/(r^2)
        return Lᵢ,  l̂
    end
    return 0.0, [0.0,0.0,0.0]
end

function _sample_radiance(scene::AbstractScene, light::RectangularLight, hit::AbstractHit, sample_i::Int)
    s = _get_light_sample(light,(sample_i%4)+1)
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