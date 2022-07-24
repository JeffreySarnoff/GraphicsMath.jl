module Matrices

### Module imports

# Dependency modules
using LinearAlgebra: ⋅, ×, I, det, norm, normalize
using StaticArrays: MMatrix, SMatrix, SVector
# Local modules
using ..Axes: Axis, AxisX, AxisY, AxisZ
using ..Spaces: Space, LocalSpace, WorldSpace
using ..Strips: Strip, set_strip
using ..Strips: Column, Column1, Column2, Column3, Column4, Row1, Row2, Row3, Row4
using ..Types: Mat, Quat, Vec, Vec2, Vec3, Vec4
import ..Shared: rotate
import ..Types: Mat3, Mat4

### Extensions

@inline Base.getindex(m::Mat3, strip::Strip) = Vec3(m, strip)
@inline Base.getindex(m::Mat4, strip::Strip) = Vec4(m, strip)
@inline Base.getindex(m::Mat, axis::Axis) = Vec3(m, axis)

### Mat3 constructors

@inline Mat3(x::T, y::T, z::T) where {T<:Vec3} = Mat3(x..., y..., z...)
@inline Mat3(m::Mat3, v::Vec, strip::Strip) = set_strip(m, v, strip)
@inline Mat3(m::Mat3, v::Vec3, axis::Axis) = Mat3(m, v, Column(Int(axis)))

@inline function Mat3(m::Mat4)
    res = MMatrix{3,3,Float64,9}(I)
    res[1:3, 1:3] .= m[SVector{3}(1:3), SVector{3}(1:3)]
    Mat3(res)
end

@inline function Mat3(q::Quat)
    x = Vec4(q.x * q.x, q.x * q.y, q.x * q.z, q.x * q.w)
    y = Vec3(q.y * q.y, q.y * q.z, q.y * q.w)
    z = Vec2(q.z * q.z, q.z * q.w)
    Mat3(
        1 - 2(y.x + z.x), 2(x.y + z.y), 2(x.z - y.z),
        2(x.y - z.y), 1 - 2(x.x + z.x), 2(y.y + x.w),
        2(x.z + y.z), 2(y.y - x.w), 1 - 2(x.x + y.x),
    )
end

### Mat4 constructors

@inline Mat4(x::T, y::T, z::T, w::T) where {T<:Vec4} = Mat4(x..., y..., z..., w...)
@inline Mat4(m::Mat4, v::Vec, strip::Strip) = set_strip(m, v, strip)
@inline Mat4(m::Mat4, v::Vec3, axis::Axis) = Mat4(m, v, Column(Int(axis)))
@inline Mat4(q::Quat) = Mat4(Mat3(q))

@inline function Mat4(m::Mat3)
    res = MMatrix{4,4,Float64,16}(I)
    res[1:3, 1:3] .= m
    Mat4(res)
end

### Matrix operations

@inline get_rotation_axis(m::Mat, axis::Axis) = Vec3(m, axis)
@inline set_rotation_axis(m::T, v::Vec3, axis::Axis) where {T<:Mat} = T(m, v, axis)
@inline get_translation(m::Mat4) = Vec3(m, Column4)
@inline set_translation(m::Mat4, v::Vec3) = Mat4(m, v, Column4)

@inline function get_scale(m::Mat)
    x = norm(get_rotation_axis(m, AxisX))
    y = norm(get_rotation_axis(m, AxisY))
    z = norm(get_rotation_axis(m, AxisZ))
    Vec3(x, y, z)
end

@inline function set_scale(m::T, v::Vec3) where {N,T<:Mat{N}}
    res = MMatrix{N,N,Float64,N^2}(m)
    res[1, 1], res[2, 2], res[3, 3] = v
    T(res)
end

@inline function make_x_rotation(::Type{T}, angle::Real) where {T<:Mat}
    res = MMatrix{3,3,Float64,9}(I)
    s, c = sincos(angle)
    res[2, 2:3] .= c, -s
    res[3, 2:3] .= s, c
    T(Mat3(res))
end

@inline function make_y_rotation(::Type{T}, angle::Real) where {T<:Mat}
    res = MMatrix{3,3,Float64,9}(I)
    s, c = sincos(angle)
    res[1, 1], res[3, 1], res[1, 3], res[3, 3] = c, -s, s, c
    T(Mat3(res))
end

@inline function make_z_rotation(::Type{T}, angle::Real) where {T<:Mat}
    res = MMatrix{3,3,Float64,9}(I)
    s, c = sincos(angle)
    res[1, 1:2] .= c, -s
    res[2, 1:2] .= s, c
    T(Mat3(res))
end

@inline function normalize_rotation(m::T) where {T<:Mat}
    x = normalize(Vec3(m, AxisX))
    y = normalize(Vec3(m, AxisY))
    z = normalize(Vec3(m, AxisZ))
    T(Mat3(x, y, z))
end

@inline function rotate(m::T, v::Vec3, ::Type{S}=LocalSpace) where {T<:Mat,S<:Space}
    x = make_x_rotation(T, v.x)
    y = make_y_rotation(T, v.y)
    z = make_z_rotation(T, v.z)
    if S <: LocalSpace
        m = m * x
        m = m * z
        m = m * y
    elseif S <: WorldSpace
        m = x * m
        m = z * m
        m = y * m
    end
end

@inline function translate(m::Mat4, v::Vec3)
    cx = Vec4(m, Column1)
    cy = Vec4(m, Column2)
    cz = Vec4(m, Column3)
    cw = Vec4(m, Column4)
    x = Vec3(m, Row1) ⋅ v
    y = Vec3(m, Row2) ⋅ v
    z = Vec3(m, Row3) ⋅ v
    w = Vec3(m, Row4) ⋅ v
    Mat4(cx, cy, cz, cw .+ Vec4(x, y, z, w))
end

@inline function is_orthogonal(m::T; atol::Real=1e-7, rtol=atol) where {T<:Mat}
    isapprox(m * m', T(I), atol=atol, rtol=rtol)
end

function orthonormalize(m::T) where {N,T<:Mat{N}}
    res = MMatrix{N,N,Float64,N^2}(m)
    x = normalize(get_rotation_axis(m, AxisX))
    y = get_rotation_axis(m, AxisY)
    y = normalize(y - (x * (y ⋅ x)))
    res[1:3, 1] .= x
    res[1:3, 2] .= y
    res[1:3, 3] .= x × y
    T(res)
end

@inline function Base.inv(m::T) where {N,T<:Mat{N}}
    @assert !iszero(det(m)) "matrix $(m) is not invertible"
    T(Base.inv(SMatrix{N,N,Float64,N^2}(m)))
end

@inline function look_at(eye::Vec3, target::Vec3, up::Vec3)
    z = normalize(target - eye)
    x = normalize(z × up)
    y = x × z
    c1 = Vec4(x.x, y.x, -z.x)
    c2 = Vec4(x.y, y.y, -z.y)
    c3 = Vec4(x.z, y.z, -z.z)
    c4 = Vec4(-(x ⋅ eye), -(y ⋅ eye), z ⋅ eye, 1.0)
    Mat4(c1, c2, c3, c4)
end

@inline function ortho(l::T, r::T, b::T, t::T, n::T, f::T) where {T<:Real}
    res = MMatrix{4,4,Float64,16}(I)
    rl = 1 / (r - l)
    tb = 1 / (t - b)
    fn = 1 / (f - n)
    res[1, 1], res[2, 2], res[3, 3] = 2rl, 2tb, -2fn
    res[1, 4], res[2, 4], res[3, 4] = -(r + l) * rl, -(t + b) * tb, -(f + n) * fn
    Mat4(res)
end

@inline function perspective(fov::T, aspect::T, near::T, far::T) where {T<:Real}
    res = zero(MMatrix{4,4,Float64,16})
    f = 1 / tan(fov * 0.5)
    z = near - far
    res[1, 1] = f / aspect
    res[2, 2] = f
    res[3, 3] = (near + far) / z
    res[3, 4] = 2(near * far) / z
    res[4, 3] = -1.0
    Mat4(res)
end

end
