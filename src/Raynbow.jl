module Raynbow

using Images
using LinearAlgebra

abstract type Material end


include("coordinate_utils.jl")
include("ray.jl")
include("film.jl")
include("camera.jl")
include("hit.jl")
include("shape.jl")
include("scene.jl")
include("RayTracing.jl")


end # module Raynbow
