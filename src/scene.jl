mutable struct Scene <: AbstractScene
    shapes::Vector{AbstractShape}
    lights::Vector{PointLight}
    position::Vector{Float64}
    max_length::Float64
    ambient_color::RGB{Float64}
    function Scene(
        s::Vector{AbstractShape}, 
        l::Vector{PointLight},
        pos::Vector{Float64} = [0.0,0.0,0.0],
        max_length::Float64 = 200.0,
        ambient_color::RGB{Float64} = RGB(0.)
        )
            new(s,l,pos,max_length,ambient_color)
    end
end


function _in_scene(scene:: Scene, p::Vector{Float64})
    if -100.0 <= p[3] <= 100.0 && -100.0 <= p[2] <= 100.0 && -100.0 <= p[1] <= 100.0
        return true
    end
    return false
end