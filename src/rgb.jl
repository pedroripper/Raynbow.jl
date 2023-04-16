# import Base.+, Base.zeros, Base.getindex

function Base.zeros(::Type{RGB{Float64}}, n::Int, m::Int)
    return [RGB{Float64}(0.0) for i in 1:n, j in 1:m]
end

function Base.getindex(c::RGB{Float64}, i::Int)
    if i == 1
        return c.r
    elseif i == 2
        return c.g
    elseif i == 3
        return c.b
    else
        error("Index error") # change message
    end
end

function Base.:+(c::RGB{Float64}, v::Vector{Float64})
    c_vec = [c[1],c[2],c[3]]
    c_vec += v
    c = RGB{Float64}(c_vec[1],c_vec[2],c_vec[3])
end