module Shared

### Module imports

# Dependenecy modules
using LinearAlgebra: norm
import LinearAlgebra as LA
# Local modules
using ..Types: Vec, Quat

### Extensions

@inline LA.normalize(x::Union{Vec,Quat}) = iszero(x) ? x : x / norm(x)

### Functions

function rotate end

### Implementations

@inline lerp(a::T, b::T, t::T) where {T<:Real} = a + t * (b - a)
@inline lerp(a::T, b::T, t::Real) where {T<:Union{Vec,Quat}} = lerp.(a, b, t)

end
