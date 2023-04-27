struct Plastic <: Material 
    difuse::Vector{Float64}
    specular::Vector{Float64}
    ambient::Vector{Float64}
    function Plastic(difuse::Vector{Float64} = [1.0,0.0,0.0], specular::Vector{Float64} = [0.5,0.5,0.5], ambient::Vector{Float64} = [0.0,0.0,0.0])
        new(difuse, specular,ambient)
    end
end

struct Metal <: Material 
    difuse::Vector{Float64}
    specular::Vector{Float64}
    ambient::Vector{Float64}
    reflectance::Float64
    function Metal(difuse::Vector{Float64} = [1.0,0.0,0.0], specular::Vector{Float64} = [0.5,0.5,0.5], ambient::Vector{Float64} = [0.0,0.0,0.0]; reflectance::Float64 = 0.3)
        new(difuse, specular,ambient,reflectance)
    end
end