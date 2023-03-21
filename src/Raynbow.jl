module Raynbow

using Images


abstract type Material end

struct Plastic <: Material end
struct Light <: Material end

include("coordinate_utils.jl")
include("ray.jl")
include("film.jl")
include("camera.jl")
include("hit.jl")
include("shape.jl")
include("scene.jl")


end # module Raynbow
