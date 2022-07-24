module Axes

### Module imports

# Dependency modules
using ..Types: Vec

### Types

@enum Axis _ AxisX AxisY AxisZ
@enum PositiveAxis _ PositiveX PositiveY PositiveZ PositiveW
@enum NegativeAxis _ NegativeX NegativeY NegativeZ NegativeW

### Internals

const VectorAxis = Union{PositiveAxis,NegativeAxis}

@inline function _check(axis::VectorAxis, vsize::Int)
    idx = Int(axis)
    idx ≤ vsize ||
        throw(ArgumentError("axis index $(idx) is larger than vector size $(vsize)"))
end

@inline function make_axis(v::Type{<:Vec{N}}, axis::PositiveAxis) where {N}
    _check(axis, N)
    idx = Int(axis)
    Base.setindex(zero(v), 1, idx)
end

@inline function make_axis(v::Type{<:Vec{N}}, axis::NegativeAxis) where {N}
    _check(axis, N)
    idx = Int(axis)
    Base.setindex(zero(v), -1, idx)
end

end
