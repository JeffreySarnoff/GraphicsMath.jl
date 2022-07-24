module GraphicsMath

using Reexport

include("types.jl")
include("strip.jl")
include("axis.jl")
include("space.jl")
include("shared.jl")
include("vector.jl")
include("matrix.jl")
include("quaternion.jl")

# Array types
@reexport using .Types: Mat3, Mat4, Quat, Vec2, Vec3, Vec4

@reexport begin
    # Rotation axis identifiers
    using .Axes: AxisX, AxisY, AxisZ
    # Positive unit vectors
    using .Axes: PositiveX, PositiveY, PositiveZ, PositiveW
    # Negative unit vectors
    using .Axes: NegativeX, NegativeY, NegativeZ, NegativeW
end

# Matrix row/column strip identifiers
@reexport using .Strips: Row1, Row2, Row3, Row4, Column1, Column2, Column3, Column4

# Vector spaces
@reexport using .Spaces: LocalSpace, WorldSpace

# Shared operations
@reexport using .Shared: lerp, rotate

# Vector operations
@reexport using .Vectors: get_angle, is_aligned, is_parallel, norm², velocity

# Matrix operations
@reexport begin
    using .Matrices: get_rotation_axis, get_scale, get_translation, is_orthogonal, look_at,
        normalize_rotation, ortho, orthonormalize, perspective, set_rotation_axis,
        set_scale, set_translation, translate
end

# Quaternion operations
@reexport using .Quaternions: angular_velocity, orient, rotate_euler, slerp, to_euler

end
