module Strips

### Module imports

# Dependency modules
using StaticArrays: MMatrix, SVector
# Local modules
using ..Types: Vec, Mat

### Types

@enum Row _ Row1 Row2 Row3 Row4
@enum Column _ Column1 Column2 Column3 Column4

### Internals

const Strip = Union{Row,Column}

@inline function _check(vsize::Int, msize::Int, idx::Int)
    vsize ≤ msize ||
        throw(ArgumentError("vector size $(vsize) is larger than matrix size $(msize)"))
    idx ≤ msize ||
        throw(ArgumentError("index $(idx) is larger than matrix size $(msize)"))
    true
end

@inline _make(m::Mat, vs::Int, strip::Row) = m[Int(strip), SVector{vs}(1:vs)]
@inline _make(m::Mat, vs::Int, strip::Column) = m[SVector{vs}(1:vs), Int(strip)]
@inline _set(m::MMatrix, v::Vec{N}, strip::Row) where {N} = (m[Int(strip), 1:N] .= v; m)
@inline _set(m::MMatrix, v::Vec{N}, strip::Column) where {N} = (m[1:N, Int(strip)] .= v; m)

@inline function make_strip(m::Mat{M}, v::Type{<:Vec{V}}, strip::Strip) where {M,V}
    _check(V, M, Int(strip)) && v(_make(m, V, strip)...)
end

@inline function set_strip(m::T, v::Vec{V}, strip::Strip) where {M,T<:Mat{M},V}
    _check(V, M, Int(strip)) && T(_set(MMatrix(m), v, strip))
end

end
