mutable struct Scene <: AbstractScene
    shapes::Vector{Sphere}
    lights::Vector{PointLight}
    position::Vector{Float64}
    function Scene(
        s::Vector{Sphere}, 
        l::Vector{PointLight},
        pos::Vector{Float64} = [0.0,0.0,0.0]
        )
            new(s,l,pos)
    end
end


function _in_scene(scene:: Scene, p::Vector{Float64})
    if -500.0 <= p[3] <= 500.0 && -500.0 <= p[2] <= 500.0 && -500.0 <= p[1] <= 500.0
        return true
    end
    return false
end