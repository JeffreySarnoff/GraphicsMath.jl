module Quaternions

### Module imports

# Dependency modules
using LinearAlgebra: ⋅, I, norm, normalize
import LinearAlgebra as LA
using StaticArrays: SVector
# Local modules
using ..Spaces: Space, LocalSpace, WorldSpace
using ..Shared: lerp
using ..Types: Mat3, Vec3
import ..Shared: rotate
import ..Types: Quat

### Quaternion constructors

@inline function Quat(m::Mat3)
    a = m[1, 1]
    b = m[2, 2] + m[3, 3]
    c = m[2, 2] - m[3, 3]
    Quat(
        sqrt(max(0, 1 + a + b)) * 0.5,
        sqrt(max(0, 1 + a - b)) * 0.5 * sign(m[3, 2] - m[2, 3]),
        sqrt(max(0, a - 1 + c)) * 0.5 * sign(m[1, 3] - m[3, 1]),
        sqrt(max(0, 1 - a - c)) * 0.5 * sign(m[2, 1] - m[1, 2]),
    ) |> normalize
end

@inline function Quat(axis::Vec3, angle::Real)
    s, c = sincos(angle * 0.5)
    Quat(c, (axis .* s)...)
end

### Quaternion operations

@inline function Base.:*(q1::Quat, q2::Quat)
    Quat(
        q1.w * q2.w - q1.x * q2.x - q1.y * q2.y - q1.z * q2.z,
        q1.w * q2.x + q1.x * q2.w + q1.y * q2.z - q1.z * q2.y,
        q1.w * q2.y + q1.y * q2.w + q1.z * q2.x - q1.x * q2.z,
        q1.w * q2.z + q1.z * q2.w + q1.x * q2.y - q1.y * q2.x,
    ) |> normalize
end

@inline Base.conj(q::Quat) = Quat(q.w, -q[SVector{3}(2:4)]...)

@inline LA.cross(q1::Quat, q2::Quat) = (q2 * conj(q1) .+ q1 * q2) .* 0.5

@inline function rotate_euler(q::Quat, v::Vec3, ::Type{S}=LocalSpace) where {S<:Space}
    function rotate(q1::Quat, q2::Quat)
        Quat(
            q1.w * q2.w - q1.x * q2.x - q1.y * q2.y - q1.z * q2.z,
            q1.w * q2.x - q1.x * q2.w - q1.y * q2.z - q1.z * q2.y,
            q1.w * q2.y - q1.y * q2.w - q1.z * q2.x - q1.x * q2.z,
            q1.w * q2.z - q1.z * q2.w - q1.x * q2.y - q1.y * q2.x,
        ) |> normalize
    end
    s = sin.(0.5v)
    c = cos.(0.5v)
    r = Quat(
        c.x * c.y * c.z - s.x * s.y * s.z,
        s.x * c.y * c.z + c.x * s.y * s.z,
        c.x * s.y * c.z - s.x * c.y * s.z,
        s.x * s.y * c.z + c.x * c.y * s.z,
    )
    if S <: LocalSpace
        rotate(q, r)
    elseif S <: WorldSpace
        rotate(r, q)
    end
end

@inline function rotate(q1::T, q2::T, ::Type{S}=LocalSpace) where {T<:Quat,S<:Space}
    if S <: LocalSpace
        q1 * q2
    elseif S <: WorldSpace
        q2 * q1
    end
end

@inline function to_euler(q::Quat)
    s = 2(q.w * q.y - q.z * q.x)
    x = atan(2(q.w * q.x + q.y * q.z), 1 - 2(q.x^2 + q.y^2))
    y = abs(s) ≥ 1 ? pi / 2 * sign(s) : asin(s)
    z = atan(2(q.w * q.z + q.x * q.y), 1 - 2(q.y^2 + q.z^2))
    Vec3(x, y, z)
end

@inline function slerp(q1::Quat, q2::Quat, t::Real)
    dot = q1 ⋅ q2
    if dot < 0
        q2 = -q2
        dot = -dot
    end
    if abs(dot) ≤ 0.9995
        θ = acos(dot)
        s = sin(θ)
        scale1 = sin(θ * (1 - t)) / s
        scale2 = sin(θ * t) / s
        normalize(q1 .* scale1 .+ q2 .* scale2)
    else
        lerp(q1, q2, t) |> normalize
    end
end

@inline function orient(
    axes::NTuple{N,Vec3},
    angles::NTuple{N,Real},
    ::Type{S}=LocalSpace,
) where {N,S<:Space}
    res = Quat(I)
    for (axis, angle) in zip(axes, angles)
        q = Quat(normalize(axis), angle)
        if S <: LocalSpace
            res = q * res
        elseif S <: WorldSpace
            res = res * q
        end
    end
    res
end

function orient(::Tuple{Vararg{Vec3}}, ::Tuple{Vararg{Real}}, ::Type{<:Space})
    throw(ArgumentError("orient: axes and angles tuples must be of the same length"))
end

@inline angular_velocity(v::Vec3, Δ::Real) = Quat(normalize(v), norm(v) * Δ)

end
