module Vectors

### Module imports

# Dependency modules
using LinearAlgebra: ⋅, norm, normalize
using StaticArrays: SVector
# Local modules
using ..Axes: Axis, VectorAxis, make_axis
using ..Strips: Column, Strip, make_strip
using ..Types: Vec, Mat, Mat3, Mat4
import ..Types: Vec2, Vec3, Vec4

### Vec2 constructors

@inline Vec2(s::Real) = fill(s, Vec2)
@inline Vec2(v::Union{Vec3,Vec4}) = Vec2(v[SVector{2}(1:2)]...)
@inline Vec2(axis::VectorAxis) = make_axis(Vec2, axis)
@inline Vec2(m::Mat, strip::Strip) = make_strip(m, Vec2, strip)

### Vec3 constructors

@inline Vec3(s::Real) = fill(s, Vec3)
@inline Vec3(x::T, y::T) where {T<:Real} = Vec3(x, y, 0.0)
@inline Vec3(x::Real, yz::Vec2) = Vec3(x, yz...)
@inline Vec3(xy::Vec2, z::Real) = Vec3(xy..., z)
@inline Vec3(v::Vec2) = Vec3(v[SVector{2}(1:2)]..., 0.0)
@inline Vec3(v::Vec4) = Vec3(v[SVector{3}(1:3)]...)
@inline Vec3(axis::VectorAxis) = make_axis(Vec3, axis)
@inline Vec3(m::Mat, strip::Strip) = make_strip(m, Vec3, strip)
@inline Vec3(m::Union{Mat3,Mat4}, axis::Axis) = Vec3(m, Column(Int(axis)))

### Vec4 constructors

@inline Vec4(s::Real) = fill(s, Vec4)
@inline Vec4(x::T, y::T) where {T<:Real} = Vec4(x, y, 0.0, 0.0)
@inline Vec4(x::T, y::T, z::T) where {T<:Real} = Vec4(x, y, z, 0.0)
@inline Vec4(xy::Vec2, z::Real) = Vec4(xy..., z, 0.0)
@inline Vec4(xy::Vec2, z::T, w::T) where {T<:Real} = Vec4(xy..., z, w)
@inline Vec4(x::T, y::T, zw::Vec2) where {T<:Real} = Vec4(x, y, zw...)
@inline Vec4(x::Real, yz::Vec2) = Vec4(x, yz..., 0.0)
@inline Vec4(x::T, yz::Vec2, w::T) where {T<:Real} = Vec4(x, yz..., w)
@inline Vec4(xy::T, zw::T) where {T<:Vec2} = Vec4(xy..., zw...)
@inline Vec4(xyz::Vec3, w::Real) = Vec4(xyz..., w)
@inline Vec4(x::Real, yzw::Vec3) = Vec4(x, yzw...)
@inline Vec4(v::Vec2) = Vec4(v..., 0.0, 0.0)
@inline Vec4(v::Vec3) = Vec4(v..., 0.0)
@inline Vec4(axis::VectorAxis) = make_axis(Vec4, axis)
@inline Vec4(m::Mat, strip::Strip) = make_strip(m, Vec4, strip)

### Vector operations

@inline function get_angle(x::T, y::T) where {T<:Vec}
    n = norm(x) * norm(y)
    iszero(n) ? 0.0 : acos(min(x ⋅ y / n, 1))
end

@inline function is_aligned(v1::T, v2::T; atol::Real=1e-7, rtol::Real=atol) where {T<:Vec}
    isapprox(normalize(v1) ⋅ normalize(v2), 1, atol=atol, rtol=rtol)
end

@inline function is_parallel(v1::T, v2::T; atol::Real=1e-7, rtol::Real=atol) where {T<:Vec}
    isapprox(abs(normalize(v1) ⋅ normalize(v2)), 1, atol=atol, rtol=rtol)
end

@inline norm²(v::Vec) = sum(abs2, v)

@inline velocity(axis::Union{Vec2,Vec3}, rate::Real) = normalize(axis) .* rate

end
