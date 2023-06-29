struct Plastic <: Material 
    difuse::Vector{Float64}
    specular::Vector{Float64}
    ambient::Vector{Float64}
    ρ::Vector{Float64}
    function Plastic(difuse::Vector{Float64} = [1.0,0.0,0.0], specular::Vector{Float64} = [0.5,0.5,0.5], ambient::Vector{Float64} = [0.0,0.0,0.0], ρ::Vector{Float64} = [1.0,1.0,1.0])
        new(difuse, specular,ambient,ρ)
    end
end

struct Metal <: Material 
    difuse::Vector{Float64}
    specular::Vector{Float64}
    ambient::Vector{Float64}
    reflectance::Float64
    ρ::Vector{Float64}
    function Metal(difuse::Vector{Float64} = [1.0,0.0,0.0], specular::Vector{Float64} = [0.5,0.5,0.5], ambient::Vector{Float64} = [0.0,0.0,0.0]; reflectance::Float64 = 0.3, ρ::Vector{Float64} = [1.0,0.0,0.0])
        new(difuse, specular,ambient,reflectance,ρ)
    end
end

struct Lambertian <: Material 
    ρ::Vector{Float64}
    function Lambertian(ρ::Vector{Float64} = [1.0,0.0,0.0])
        new(ρ)
    end
end

function _get_sample(material::Material)
    ξ₁ = rand()
    ξ₂ = rand()

    ϕ = 2π * ξ₂
    θ = asin(√(ξ₁))

    x = sin(θ) * cos(ϕ)
    y = sin(θ) * sin(ϕ)
    z = cos(θ)

    return [x,y,z], θ, ϕ
end

function _get_pdf(material::Material, θ::Float64)
    return (cos(θ) * sin(θ)) / π
end
    
function _get_brdf(material::Union{Plastic, Metal})
    return 1 / π
end
