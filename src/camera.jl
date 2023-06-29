mutable struct Camera <: AbstractCamera
    eye::Vector{Float64}
    target::Vector{Float64}
    up::Vector{Float64}

    u::Vector{Float64}
    v::Vector{Float64}
    w::Vector{Float64}

    θ::Float64

    view_matrix::Matrix{Float64}
    view_matrix_inv::Matrix{Float64}

    film::Film

    function Camera(
            eye::Vector{Float64}, 
            target::Vector{Float64}, 
            up::Vector{Float64}, 
            film::Film,
            θ::Float64 = 20.0,
        )
        w = normalize(eye - target)
        u = normalize(cross(up,w))
        v = cross(w,u)


        B_t = [
            u[1] u[2] u[3] 0
            v[1] v[2] v[3] 0
            w[1] w[2] w[3] 0
            0    0    0    1
        ]
        

        T = [
            1 0 0 -eye[1]
            0 1 0 -eye[2]
            0 0 1 -eye[3]
            0 0 0  1 
        ]


        V = B_t*T

        V_inv = V^-1

        new(eye, target, up, u, v, w, θ, V, V_inv, film)
    end 
end

function _generate_ray(c::AbstractCamera, nx::Float64, ny::Float64)
    f = norm(c.eye-c.target)

    Δv = f * tan(c.θ/2) 
    Δu = Δv * (c.film.width/c.film.height)

    p = [-Δu + 2 * Δu * nx, -Δv + 2*Δv*ny, -f, 1.0]
    o = c.view_matrix_inv*[0.0,0.0,0.0,1.0]
    t = c.view_matrix_inv*p

    return Ray(o[1:3], normalize(t[1:3]-o[1:3]))
end