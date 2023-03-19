mutable struct Scene
    camera::Camera
    film::Film
    shapes::Vector{AbstractShape}
    lights::Vector{AbstractLight}
    function Scene(c::Camera, f::Film, s::Vector{AbstractShape}, l::Vector{AbstractLight})
        new(c,f,s,l)
    end
end

