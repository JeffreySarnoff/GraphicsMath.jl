module Types

### Module imports

# Dependency modules
using StaticArrays: FieldArray, FieldMatrix, FieldVector

### Abstract types

abstract type Vec{N} <: FieldVector{N,Float64} end
abstract type Mat{N} <: FieldMatrix{N,N,Float64} end

### Concrete types

struct Vec2 <: Vec{2}
    x::Float64
    y::Float64
end

struct Vec3 <: Vec{3}
    x::Float64
    y::Float64
    z::Float64
end

struct Vec4 <: Vec{4}
    x::Float64
    y::Float64
    z::Float64
    w::Float64
end

struct Mat3 <: Mat{3}
    xx::Float64
    xy::Float64
    xz::Float64
    yx::Float64
    yy::Float64
    yz::Float64
    zx::Float64
    zy::Float64
    zz::Float64
end

struct Mat4 <: Mat{4}
    xx::Float64
    xy::Float64
    xz::Float64
    xw::Float64
    yx::Float64
    yy::Float64
    yz::Float64
    yw::Float64
    zx::Float64
    zy::Float64
    zz::Float64
    zw::Float64
    wx::Float64
    wy::Float64
    wz::Float64
    ww::Float64
end

struct Quat <: FieldArray{Tuple{1,4},Float64,2}
    w::Float64
    x::Float64
    y::Float64
    z::Float64
end

end
