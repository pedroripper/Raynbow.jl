module Raynbow

using Images
using ImageMagick
using LinearAlgebra

abstract type Material end
abstract type AbstractElement end
abstract type AbstractShape <: AbstractElement end
abstract type AbstractLight <: AbstractElement end
abstract type AbstractHit end
abstract type AbstractScene end
abstract type AbstractCamera end
abstract type AbstractFilm end

include("rgb.jl")
include("ray.jl")
include("film.jl")
include("camera.jl")
include("element/element.jl")
include("hit.jl")
include("scene.jl")
include("RayTracing.jl")


end # module Raynbow
