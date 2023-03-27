mutable struct Camera <: AbstractCamera
    eye::Vector{Float64}
    c::Vector{Float64}
    up::Vector{Float64}

    u::Vector{Float64}
    v::Vector{Float64}
    w::Vector{Float64}

    d::Float64
    θ::Float64

    view_matrix::Matrix{Float64}
    view_matrix_inv::Matrix{Float64}

    film::Film

    function Camera(
            eye::Vector{Float64}, 
            c::Vector{Float64}, 
            up::Vector{Float64}, 
            film::Film,
            d::Float64, 
            θ::Float64 = 20.0,
        )
        w = normalize(eye - c)
        u = normalize(cross(up,w))
        v = cross(w,u)

        u₄ = append!(deepcopy(u), 0)
        v₄ = append!(deepcopy(v), 0)
        w₄ = append!(deepcopy(w), 0)
        pos = [0,0,0,1]

        B = [u₄ v₄ w₄ pos]

        T = [[1,0,0,0] [0,1,0,0] [0,0,1,0] [-eye[1],-eye[2],-eye[3],1]]

        V = B'T

        V_inv = V^-1

        new(eye, c, up, u, v, w, d, θ, V, V_inv, film)
    end 
end

function _generate_ray(c::AbstractCamera, nx::Float64, ny::Float64)
    Δv = c.d * tan(c.θ/2) 
    Δu = Δv * (c.film.width/c.film.height)
    p = [-Δu + 2 * Δu * nx, -Δv + 2*Δv*ny, -c.d, 1.0]
    o = _to_global_coord(c, append!(deepcopy(c.eye),1))
    # @show o
    t = _to_global_coord(c, p)
    # @show t
    
    return Ray(o[1:3], normalize(t - o)[1:3])
end

function _to_global_coord(c::AbstractCamera, pos::Vector{Float64})
    return c.view_matrix_inv * pos
end

function _to_camera_coord(c::AbstractCamera, pos::Vector{Float64})
    return c.view_matrix * pos
end
