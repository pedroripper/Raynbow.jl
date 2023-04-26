mutable struct Scene <: AbstractScene
    shapes::Vector{AbstractShape}
    lights::Vector{AbstractLight}
    ambient_color::Vector{Float64}
    function Scene(
        s::Vector{AbstractShape}, 
        l::Vector{RectangularLight},
        ambient_color::Vector{Float64} = [0.1,0.1,0.1]
        )
            new(s,l,ambient_color)
    end
    function Scene(
        s::Vector{AbstractShape}, 
        l::Vector{PointLight},
        ambient_color::Vector{Float64} = [0.1,0.1,0.1]
        )
            new(s,l,ambient_color)
    end
    function Scene(
        s::Vector{Sphere}, 
        l::Vector{PointLight},
        ambient_color::Vector{Float64} = [0.1,0.1,0.1]
        )
            new(s,l,ambient_color)
    end
    function Scene(
        s::Vector{Box}, 
        l::Vector{PointLight},
        ambient_color::Vector{Float64} = [0.1,0.1,0.1]
        )
            new(s,l,ambient_color)
    end
    function Scene(
        s::Vector{Plane}, 
        l::Vector{PointLight},
        ambient_color::Vector{Float64} = [0.1,0.1,0.1]
        )
            new(s,l,ambient_color)
    end
end
