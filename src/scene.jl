mutable struct Scene
    camera::Camera
    film::Film
    shapes::Vector{AbstractShape}
    pos::Vector{Float64}
    function Scene(
        c::Camera, 
        f::Film, 
        s::Vector{AbstractShape}, 
        pos::Vector{Float64} = [0.0,0.0,0.0]
        )
            new(c,f,s,pos)
    end
end

