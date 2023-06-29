function _normal_to_global(n̂::Vector{Float64}, wih::Vector{Float64})

    # arbitrary_vector = [1.0, 0.0, 0.0]
    # if n̂ == arbitrary_vector
    #     arbitrary_vector = [0.0, 1.0, 0.0]
    # end
    # t1 = arbitrary_vector - dot(arbitrary_vector, n̂) * n̂
    # t1 = normalize(t1)

    # t2 = normalize(cross(n̂, t1))

    # M = [t1 n̂ t2]

    # v = M^-1 * t

    t = [1.0, 0.0, 0.0]
    if dot(t, n̂) > 0.99
        t = [0.0, 1.0, 0.0]
    end
    b = normalize(cross(n̂,t))
    t = cross(b,n̂)
    M = [t b n̂]


    return M*wih
end