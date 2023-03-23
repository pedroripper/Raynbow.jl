mutable struct Scene
    camera::Camera
    film::Film
    shapes::Vector{Sphere}
    lights::Vector{PointLight}
    position::Vector{Float64}
    function Scene(
        c::Camera, 
        f::Film, 
        s::Vector{Sphere}, 
        l::Vector{PointLight},
        pos::Vector{Float64} = [0.0,0.0,0.0]
        )
            new(c,f,s,l,pos)
    end
end

