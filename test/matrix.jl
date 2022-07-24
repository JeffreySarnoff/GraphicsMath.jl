using Test
using GraphicsMath
using LinearAlgebra: I

@testset "Matrices" begin
    @testset "Mat3" begin
        @testset "Constructors" begin
            m3a = Mat3(i * 10 for i in 1:9)
            m3b = Mat3(2, 3, 30, 40, 50, 60, 70, 80, 90)
            m3c = Mat3(10, 20, 30, 2, 3, 60, 70, 80, 90)
            m3d = Mat3(10, 20, 30, 40, 50, 60, 2, 3, 90)
            m3e = Mat3(2, 20, 30, 3, 50, 60, 70, 80, 90)
            m3f = Mat3(10, 2, 30, 40, 3, 60, 70, 80, 90)
            m3g = Mat3(10, 20, 2, 40, 50, 3, 70, 80, 90)
            m3h = Mat3(2, 3, 4, 40, 50, 60, 70, 80, 90)
            m3i = Mat3(10, 20, 30, 2, 3, 4, 70, 80, 90)
            m3j = Mat3(10, 20, 30, 40, 50, 60, 2, 3, 4)
            m3k = Mat3(2, 20, 30, 3, 50, 60, 4, 80, 90)
            m3l = Mat3(10, 2, 30, 40, 3, 60, 70, 4, 90)
            m3m = Mat3(10, 20, 2, 40, 50, 3, 70, 80, 4)
            m3n = Mat3(10, 20, 30, 50, 60, 70, 90, 100, 110)
            m3o = Mat3(1, 0, 0, 0, 0.5, 0.866025, 0, -0.866025, 0.5)
            m4 = Mat4(i * 10 for i in 1:16)
            v2 = Vec2(2, 3)
            v3a = Vec3(10, 20, 30)
            v3b = Vec3(40, 50, 60)
            v3c = Vec3(70, 80, 90)
            v3d = Vec3(2, 3, 4)
            v4 = Vec4(2, 3, 4, 5)
            q = Quat(0.866025, 0.5, 0, 0)
            @mytest Mat3(v3a, v3b, v3c) == m3a
            @mytest Mat3(m3a, v2, Column1) == m3b
            @mytest Mat3(m3a, v2, Column2) == m3c
            @mytest Mat3(m3a, v2, Column3) == m3d
            @mytest Mat3(m3a, v2, Row1) == m3e
            @mytest Mat3(m3a, v2, Row2) == m3f
            @mytest Mat3(m3a, v2, Row3) == m3g
            @mytest Mat3(m3a, v3d, Column1) == m3h
            @mytest Mat3(m3a, v3d, Column2) == m3i
            @mytest Mat3(m3a, v3d, Column3) == m3j
            @mytest Mat3(m3a, v3d, Row1) == m3k
            @mytest Mat3(m3a, v3d, Row2) == m3l
            @mytest Mat3(m3a, v3d, Row3) == m3m
            @mytest Mat3(m3a, v3d, AxisX) == m3h
            @mytest Mat3(m3a, v3d, AxisY) == m3i
            @mytest Mat3(m3a, v3d, AxisZ) == m3j
            @mytest Mat3(m4) == m3n
            @mytest Mat3(q) ≈ m3o atol = 1e-6
            @test_throws ArgumentError Mat3(m3a, v2, Column4)
            @test_throws ArgumentError Mat3(m3a, v2, Row4)
            @test_throws ArgumentError Mat3(m3a, v3d, Column4)
            @test_throws ArgumentError Mat3(m3a, v3d, Row4)
            @test_throws ArgumentError Mat3(m3a, v4, Column1)
            @test_throws ArgumentError Mat3(m3a, v4, Column2)
            @test_throws ArgumentError Mat3(m3a, v4, Column3)
            @test_throws ArgumentError Mat3(m3a, v4, Column4)
            @test_throws ArgumentError Mat3(m3a, v4, Row1)
            @test_throws ArgumentError Mat3(m3a, v4, Row2)
            @test_throws ArgumentError Mat3(m3a, v4, Row3)
            @test_throws ArgumentError Mat3(m3a, v4, Row4)
        end
        @testset "Indexing" begin
            m = Mat3(1:9)
            @test m.xx == 1.0
            @test m[1] == 1.0
            @test m[1, 1] == 1.0
            @test m.xy == 2.0
            @test m[2] == 2.0
            @test m[2, 1] == 2.0
            @test m.xz == 3.0
            @test m[3] == 3.0
            @test m[3, 1] == 3.0
            @test m.yx == 4.0
            @test m[4] == 4.0
            @test m[1, 2] == 4.0
            @test m.yy == 5.0
            @test m[5] == 5.0
            @test m[2, 2] == 5.0
            @test m.yz == 6.0
            @test m[6] == 6.0
            @test m[3, 2] == 6.0
            @test m.zx == 7.0
            @test m[7] == 7.0
            @test m[1, 3] == 7.0
            @test m.zy == 8.0
            @test m[8] == 8.0
            @test m[2, 3] == 8.0
            @test m.zz == 9.0
            @test m[9] == 9.0
            @test m[3, 3] == 9.0
            @test m[Column1] == Vec3(1, 2, 3)
            @test m[Column2] == Vec3(4, 5, 6)
            @test m[Column3] == Vec3(7, 8, 9)
            @test m[Row1] == Vec3(1, 4, 7)
            @test m[Row2] == Vec3(2, 5, 8)
            @test m[Row3] == Vec3(3, 6, 9)
            @test m[AxisX] == Vec3(1, 2, 3)
            @test m[AxisY] == Vec3(4, 5, 6)
            @test m[AxisZ] == Vec3(7, 8, 9)
        end
        @testset "Operations" begin
            m3a = Mat3(1:9)
            m3b = Mat3(10, 20, 30, 4, 5, 6, 7, 8, 9)
            m3c = Mat3(1, 2, 3, 10, 20, 30, 7, 8, 9)
            m3d = Mat3(1, 2, 3, 4, 5, 6, 10, 20, 30)
            m3e = Mat3(10, 2, 3, 4, 20, 6, 7, 8, 30)
            m3f = Mat3(3, 0, 0, 0, 2, 0, 0, 0, 1)
            m3g = Mat3(1, 0, 0, 0, 0.5, 0.86602545, 0, -0.86602545, 0.5)
            m3h = Mat3(0.5, 0, -0.86602545, 0, 1, 0, 0.86602545, 0, 0.5)
            m3i = Mat3(0.5, 0.86602545, 0, -0.86602545, 0.5, 0, 0, 0, 1)
            m3j = Mat3(1, 0, 0, 0, 1, 0, -0.12988785, 0.3997815, 0.5468181)
            v3a = Vec3(3.7416573867739413, 8.774964387392123, 13.92838827718412)
            @mytest get_rotation_axis(m3a, AxisX) == Vec3(1, 2, 3)
            @mytest get_rotation_axis(m3a, AxisY) == Vec3(4, 5, 6)
            @mytest get_rotation_axis(m3a, AxisZ) == Vec3(7, 8, 9)
            @mytest set_rotation_axis(m3a, Vec3(10, 20, 30), AxisX) == m3b
            @mytest set_rotation_axis(m3a, Vec3(10, 20, 30), AxisY) == m3c
            @mytest set_rotation_axis(m3a, Vec3(10, 20, 30), AxisZ) == m3d
            @mytest get_scale(m3a) ≈ v3a atol = 1e-6
            @mytest set_scale(m3a, Vec3(10, 20, 30)) == m3e
            @mytest normalize_rotation(m3f) == Mat3(I)
            @mytest rotate(Mat3(I), Vec3(pi / 3, 0, 0)) ≈ m3g atol = 1e-6
            @mytest rotate(Mat3(I), Vec3(0, pi / 3, 0)) ≈ m3h atol = 1e-6
            @mytest rotate(Mat3(I), Vec3(0, 0, pi / 3)) ≈ m3i atol = 1e-6
            @mytest is_orthogonal(m3g)
            @mytest is_orthogonal(m3h)
            @mytest is_orthogonal(m3i)
            @mytest orthonormalize(m3j) == Mat3(I)
            @mytest inv(m3g) * m3g ≈ Mat3(I) atol = 1e-6
            @mytest inv(m3h) * m3h ≈ Mat3(I) atol = 1e-6
            @mytest inv(m3i) * m3i ≈ Mat3(I) atol = 1e-6
        end
    end
    @testset "Mat4" begin
        @testset "Constructors" begin
            m4a = Mat4(i * 10 for i in 1:16)
            m4b = Mat4(2, 3, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160)
            m4c = Mat4(10, 20, 30, 40, 2, 3, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160)
            m4d = Mat4(10, 20, 30, 40, 50, 60, 70, 80, 2, 3, 110, 120, 130, 140, 150, 160)
            m4e = Mat4(10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 2, 3, 150, 160)
            m4f = Mat4(2, 20, 30, 40, 3, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160)
            m4g = Mat4(10, 2, 30, 40, 50, 3, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160)
            m4h = Mat4(10, 20, 2, 40, 50, 60, 3, 80, 90, 100, 110, 120, 130, 140, 150, 160)
            m4i = Mat4(10, 20, 30, 2, 50, 60, 70, 3, 90, 100, 110, 120, 130, 140, 150, 160)
            m4j = Mat4(2, 3, 4, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160)
            m4k = Mat4(10, 20, 30, 40, 2, 3, 4, 80, 90, 100, 110, 120, 130, 140, 150, 160)
            m4l = Mat4(10, 20, 30, 40, 50, 60, 70, 80, 2, 3, 4, 120, 130, 140, 150, 160)
            m4m = Mat4(10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 2, 3, 4, 160)
            m4n = Mat4(2, 20, 30, 40, 3, 60, 70, 80, 4, 100, 110, 120, 130, 140, 150, 160)
            m4o = Mat4(10, 2, 30, 40, 50, 3, 70, 80, 90, 4, 110, 120, 130, 140, 150, 160)
            m4p = Mat4(10, 20, 2, 40, 50, 60, 3, 80, 90, 100, 4, 120, 130, 140, 150, 160)
            m4q = Mat4(10, 20, 30, 2, 50, 60, 70, 3, 90, 100, 110, 4, 130, 140, 150, 160)
            m4r = Mat4(2, 3, 4, 5, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160)
            m4s = Mat4(10, 20, 30, 40, 2, 3, 4, 5, 90, 100, 110, 120, 130, 140, 150, 160)
            m4t = Mat4(10, 20, 30, 40, 50, 60, 70, 80, 2, 3, 4, 5, 130, 140, 150, 160)
            m4u = Mat4(10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 2, 3, 4, 5)
            m4v = Mat4(2, 20, 30, 40, 3, 60, 70, 80, 4, 100, 110, 120, 5, 140, 150, 160)
            m4w = Mat4(10, 2, 30, 40, 50, 3, 70, 80, 90, 4, 110, 120, 130, 5, 150, 160)
            m4x = Mat4(10, 20, 2, 40, 50, 60, 3, 80, 90, 100, 4, 120, 130, 140, 5, 160)
            m4y = Mat4(10, 20, 30, 2, 50, 60, 70, 3, 90, 100, 110, 4, 130, 140, 150, 5)
            m4z = Mat4(10, 20, 30, 0, 40, 50, 60, 0, 70, 80, 90, 0, 0, 0, 0, 1)
            m4a2 = Mat4(1, 0, 0, 0, 0, 0.5, 0.86602545, 0, 0, -0.86602545, 0.5, 0, 0, 0, 0, 1)
            m3 = Mat3(i * 10 for i in 1:9)
            v2 = Vec2(2, 3)
            v3 = Vec3(2, 3, 4)
            v4a = Vec4(10, 20, 30, 40)
            v4b = Vec4(50, 60, 70, 80)
            v4c = Vec4(90, 100, 110, 120)
            v4d = Vec4(130, 140, 150, 160)
            v4e = Vec4(2, 3, 4, 5)
            q = Quat(0.866025, 0.5, 0, 0)
            @mytest Mat4(v4a, v4b, v4c, v4d) == m4a
            @mytest Mat4(m4a, v2, Column1) == m4b
            @mytest Mat4(m4a, v2, Column2) == m4c
            @mytest Mat4(m4a, v2, Column3) == m4d
            @mytest Mat4(m4a, v2, Column4) == m4e
            @mytest Mat4(m4a, v2, Row1) == m4f
            @mytest Mat4(m4a, v2, Row2) == m4g
            @mytest Mat4(m4a, v2, Row3) == m4h
            @mytest Mat4(m4a, v2, Row4) == m4i
            @mytest Mat4(m4a, v3, Column1) == m4j
            @mytest Mat4(m4a, v3, Column2) == m4k
            @mytest Mat4(m4a, v3, Column3) == m4l
            @mytest Mat4(m4a, v3, Column4) == m4m
            @mytest Mat4(m4a, v3, Row1) == m4n
            @mytest Mat4(m4a, v3, Row2) == m4o
            @mytest Mat4(m4a, v3, Row3) == m4p
            @mytest Mat4(m4a, v3, Row4) == m4q
            @mytest Mat4(m4a, v4e, Column1) == m4r
            @mytest Mat4(m4a, v4e, Column2) == m4s
            @mytest Mat4(m4a, v4e, Column3) == m4t
            @mytest Mat4(m4a, v4e, Column4) == m4u
            @mytest Mat4(m4a, v4e, Row1) == m4v
            @mytest Mat4(m4a, v4e, Row2) == m4w
            @mytest Mat4(m4a, v4e, Row3) == m4x
            @mytest Mat4(m4a, v4e, Row4) == m4y
            @mytest Mat4(m4a, v3, AxisX) == m4j
            @mytest Mat4(m4a, v3, AxisY) == m4k
            @mytest Mat4(m4a, v3, AxisZ) == m4l
            @mytest Mat4(m3) == m4z
            @mytest Mat4(q) ≈ m4a2 atol = 1e-6
        end
        @testset "Indexing" begin
            m = Mat4(1:16)
            @test m.xx == 1.0
            @test m[1] == 1.0
            @test m[1, 1] == 1.0
            @test m.xy == 2.0
            @test m[2] == 2.0
            @test m[2, 1] == 2.0
            @test m.xz == 3.0
            @test m[3] == 3.0
            @test m[3, 1] == 3.0
            @test m.xw == 4.0
            @test m[4] == 4.0
            @test m[4, 1] == 4.0
            @test m.yx == 5.0
            @test m[5] == 5.0
            @test m[1, 2] == 5.0
            @test m.yy == 6.0
            @test m[6] == 6.0
            @test m[2, 2] == 6.0
            @test m.yz == 7.0
            @test m[7] == 7.0
            @test m[3, 2] == 7.0
            @test m.yw == 8.0
            @test m[8] == 8.0
            @test m[4, 2] == 8.0
            @test m.zx == 9.0
            @test m[9] == 9.0
            @test m[1, 3] == 9.0
            @test m.zy == 10.0
            @test m[10] == 10.0
            @test m[2, 3] == 10.0
            @test m.zz == 11.0
            @test m[11] == 11.0
            @test m[3, 3] == 11.0
            @test m.zw == 12.0
            @test m[12] == 12.0
            @test m[4, 3] == 12.0
            @test m.wx == 13.0
            @test m[13] == 13.0
            @test m[1, 4] == 13.0
            @test m.wy == 14.0
            @test m[14] == 14.0
            @test m[2, 4] == 14.0
            @test m.wz == 15.0
            @test m[15] == 15.0
            @test m[3, 4] == 15.0
            @test m.ww == 16.0
            @test m[16] == 16.0
            @test m[4, 4] == 16.0
            @test m[Column1] == Vec4(1, 2, 3, 4)
            @test m[Column2] == Vec4(5, 6, 7, 8)
            @test m[Column3] == Vec4(9, 10, 11, 12)
            @test m[Column4] == Vec4(13, 14, 15, 16)
            @test m[Row1] == Vec4(1, 5, 9, 13)
            @test m[Row2] == Vec4(2, 6, 10, 14)
            @test m[Row3] == Vec4(3, 7, 11, 15)
            @test m[Row4] == Vec4(4, 8, 12, 16)
            @test m[AxisX] == Vec3(1, 2, 3)
            @test m[AxisY] == Vec3(5, 6, 7)
            @test m[AxisZ] == Vec3(9, 10, 11)
        end
        @testset "Operations" begin
            m4a = Mat4(1:16)
            m4b = Mat4(10, 20, 30, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
            m4c = Mat4(1, 2, 3, 4, 10, 20, 30, 8, 9, 10, 11, 12, 13, 14, 15, 16)
            m4d = Mat4(1, 2, 3, 4, 5, 6, 7, 8, 10, 20, 30, 12, 13, 14, 15, 16)
            m4e = Mat4(10, 2, 3, 4, 5, 20, 7, 8, 9, 10, 30, 12, 13, 14, 15, 16)
            m4f = Mat4(3, 0, 0, 0, 0, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
            m4g = Mat4(1, 0, 0, 0, 0, 0.5, 0.86602545, 0, 0, -0.86602545, 0.5, 0, 0, 0, 0, 1)
            m4h = Mat4(0.5, 0, -0.86602545, 0, 0, 1, 0, 0, 0.86602545, 0, 0.5, 0, 0, 0, 0, 1)
            m4i = Mat4(0.5, 0.86602545, 0, 0, -0.86602545, 0.5, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
            m4j = Mat4(1, 0, 0, 0, 0, 1, 0, 0, -0.12988785, 0.3997815, 0.5468181, 0, 0, 0, 0, 1)
            m4k = Mat4(1, 0, 0, 0, 0, 0.5, 0.8660254, 0, 0, -0.8660254, 0.5, 0, 5, -7.9903817, 16.160254, 1)
            m4l = Mat4(-0.436492, 0.0480191, -0.8984258, 0, 0, 0.9985747, 0.0533718, 0, 0.8997081, 0.0232964, -0.4358699, 0, -0.013362, -2.0568167, 1.0096171, 1)
            m4m = Mat4(0.05, 0, 0, 0, 0, 0.1, 0, 0, 0, 0, -0.002, 0, 0, 0, -1, 1)
            m4n = Mat4(0.9742786, 0, 0, 0, 0, 1.7320509, 0, 0, 0, 0, -1.002002, -1, 0, 0, -2.002002, 0)
            v3a = Vec3(3.74165750, 10.488089, 17.378147)
            @mytest get_rotation_axis(m4a, AxisX) == Vec3(1, 2, 3)
            @mytest get_rotation_axis(m4a, AxisY) == Vec3(5, 6, 7)
            @mytest get_rotation_axis(m4a, AxisZ) == Vec3(9, 10, 11)
            @mytest set_rotation_axis(m4a, Vec3(10, 20, 30), AxisX) == m4b
            @mytest set_rotation_axis(m4a, Vec3(10, 20, 30), AxisY) == m4c
            @mytest set_rotation_axis(m4a, Vec3(10, 20, 30), AxisZ) == m4d
            @mytest get_scale(m4a) ≈ v3a atol = 1e-6
            @mytest set_scale(m4a, Vec3(10, 20, 30)) == m4e
            @mytest normalize_rotation(m4f) == Mat4(I)
            @mytest rotate(Mat4(I), Vec3(pi / 3, 0, 0)) ≈ m4g atol = 1e-6
            @mytest rotate(Mat4(I), Vec3(0, pi / 3, 0)) ≈ m4h atol = 1e-6
            @mytest rotate(Mat4(I), Vec3(0, 0, pi / 3)) ≈ m4i atol = 1e-6
            @mytest is_orthogonal(m4g)
            @mytest is_orthogonal(m4h)
            @mytest is_orthogonal(m4i)
            @mytest orthonormalize(m4j) == Mat4(I)
            @mytest inv(m4g) * m4g ≈ Mat4(I) atol = 1e-6
            @mytest inv(m4h) * m4h ≈ Mat4(I) atol = 1e-6
            @mytest inv(m4i) * m4i ≈ Mat4(I) atol = 1e-6
            @mytest translate(rotate(Mat4(I), Vec3(pi / 3, 0, 0)), Vec3(5, 10, 15)) ≈ m4k atol = 1e-6
            @mytest look_at(Vec3(1, 2, 0.5), Vec3(21.2, 0.8, 10.3), Vec3(0, 1, 0)) ≈ m4l atol = 1e-6
            @mytest ortho(-20, 20, -10, 10, 0, 1000) ≈ m4m atol = 1e-6
            @mytest perspective(pi / 3, 16.0 / 9, 1.0, 1000.0) ≈ m4n atol = 1e-6
        end
    end
end
