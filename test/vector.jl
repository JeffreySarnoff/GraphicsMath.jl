using Test
using GraphicsMath

@testset "Vectors" begin
    @testset "Vec2" begin
        @testset "Constructors" begin
            m3 = Mat3(1, 2, 3, 4, 5, 6, 7, 8, 9)
            m4 = Mat4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
            @mytest Vec2(42) == Vec2(42, 42)
            @mytest Vec2(Vec3(1, 2, 3)) == Vec2(1, 2)
            @mytest Vec2(Vec4(2, 3, 4, 5)) == Vec2(2, 3)
            @mytest Vec2(PositiveX) == Vec2(1, 0)
            @mytest Vec2(NegativeX) == Vec2(-1, 0)
            @mytest Vec2(PositiveY) == Vec2(0, 1)
            @mytest Vec2(NegativeY) == Vec2(0, -1)
            @mytest Vec2(m3, Column1) == Vec2(1, 2)
            @mytest Vec2(m3, Column2) == Vec2(4, 5)
            @mytest Vec2(m3, Column3) == Vec2(7, 8)
            @mytest Vec2(m3, Row1) == Vec2(1, 4)
            @mytest Vec2(m3, Row2) == Vec2(2, 5)
            @mytest Vec2(m3, Row3) == Vec2(3, 6)
            @mytest Vec2(m4, Column1) == Vec2(1, 2)
            @mytest Vec2(m4, Column2) == Vec2(5, 6)
            @mytest Vec2(m4, Column3) == Vec2(9, 10)
            @mytest Vec2(m4, Column4) == Vec2(13, 14)
            @mytest Vec2(m4, Row1) == Vec2(1, 5)
            @mytest Vec2(m4, Row2) == Vec2(2, 6)
            @mytest Vec2(m4, Row3) == Vec2(3, 7)
            @mytest Vec2(m4, Row4) == Vec2(4, 8)
            @mytest all(iszero, zeros(Vec2))
            @mytest all(isone, ones(Vec2))
            @test_throws ArgumentError Vec2(PositiveZ)
            @test_throws ArgumentError Vec2(NegativeZ)
            @test_throws ArgumentError Vec2(PositiveW)
            @test_throws ArgumentError Vec2(NegativeW)
            @test_throws ArgumentError Vec3(m3, Column4)
            @test_throws ArgumentError Vec3(m3, Row4)
        end
        @testset "Indexing" begin
            v = Vec2(1, 2)
            @test v.x == 1.0
            @test v[1] == 1.0
            @test v.y == 2.0
            @test v[2] == 2.0
        end
        @testset "Operations" begin
            v2a = Vec2(0.74485755, 0.092342734)
            v2b = Vec2(0.19426346, 0.9881369)
            v2c = Vec2(0.4695605, 0.5402398)
            v2d = Vec2(0.32979298, 0.2571392)
            v2e = Vec2(0.3328201, 0.22188)
            @mytest get_angle(Vec2(0, 1), Vec2(1, 0)) ≈ pi / 2
            @mytest is_aligned(Vec2(0, 0.12), Vec2(0, 21.5))
            @mytest is_parallel(Vec2(0, 0.12), Vec2(0, -21.5))
            @mytest lerp(v2a, v2b, 0.5) ≈ v2c atol = 1e-6
            @mytest norm²(zeros(Vec2)) == 0.0
            @mytest norm²(Vec2(0, 1)) == 1.0
            @mytest norm²(v2d) ≈ 0.1748839778339204 atol = 1e-6
            @mytest velocity(Vec2(pi / 2, pi / 3), 0.4) ≈ v2e atol = 1e-6
        end
    end
    @testset "Vec3" begin
        @testset "Constructors" begin
            m3 = Mat3(1, 2, 3, 4, 5, 6, 7, 8, 9)
            m4 = Mat4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
            @mytest Vec3(42) == Vec3(42, 42, 42)
            @mytest Vec3(42, 43) == Vec3(42, 43, 0)
            @mytest Vec3(42, Vec2(43, 44)) == Vec3(42, 43, 44)
            @mytest Vec3(Vec2(43, 44), 42) == Vec3(43, 44, 42)
            @mytest Vec3(Vec2(1, 2)) == Vec3(1, 2, 0)
            @mytest Vec3(Vec4(3, 4, 5, 6)) == Vec3(3, 4, 5)
            @mytest Vec3(PositiveX) == Vec3(1, 0, 0)
            @mytest Vec3(NegativeX) == Vec3(-1, 0, 0)
            @mytest Vec3(PositiveY) == Vec3(0, 1, 0)
            @mytest Vec3(NegativeY) == Vec3(0, -1, 0)
            @mytest Vec3(PositiveZ) == Vec3(0, 0, 1)
            @mytest Vec3(NegativeZ) == Vec3(0, 0, -1)
            @mytest Vec3(m3, Column1) == Vec3(1, 2, 3)
            @mytest Vec3(m3, Column2) == Vec3(4, 5, 6)
            @mytest Vec3(m3, Column3) == Vec3(7, 8, 9)
            @mytest Vec3(m3, Row1) == Vec3(1, 4, 7)
            @mytest Vec3(m3, Row2) == Vec3(2, 5, 8)
            @mytest Vec3(m3, Row3) == Vec3(3, 6, 9)
            @mytest Vec3(m4, Column1) == Vec3(1, 2, 3)
            @mytest Vec3(m4, Column2) == Vec3(5, 6, 7)
            @mytest Vec3(m4, Column3) == Vec3(9, 10, 11)
            @mytest Vec3(m4, Column4) == Vec3(13, 14, 15)
            @mytest Vec3(m4, Row1) == Vec3(1, 5, 9)
            @mytest Vec3(m4, Row2) == Vec3(2, 6, 10)
            @mytest Vec3(m4, Row3) == Vec3(3, 7, 11)
            @mytest Vec3(m4, Row4) == Vec3(4, 8, 12)
            @mytest Vec3(m3, AxisX) == Vec3(1, 2, 3)
            @mytest Vec3(m3, AxisY) == Vec3(4, 5, 6)
            @mytest Vec3(m3, AxisZ) == Vec3(7, 8, 9)
            @mytest Vec3(m4, AxisX) == Vec3(1, 2, 3)
            @mytest Vec3(m4, AxisY) == Vec3(5, 6, 7)
            @mytest Vec3(m4, AxisZ) == Vec3(9, 10, 11)
            @mytest all(iszero, zeros(Vec3))
            @mytest all(isone, ones(Vec3))
            @test_throws ArgumentError Vec3(PositiveW)
            @test_throws ArgumentError Vec3(NegativeW)
            @test_throws ArgumentError Vec3(m3, Column4)
            @test_throws ArgumentError Vec3(m3, Row4)
        end
        @testset "Indexing" begin
            v = Vec3(1, 2, 3)
            @test v.x == 1.0
            @test v[1] == 1.0
            @test v.y == 2.0
            @test v[2] == 2.0
            @test v.z == 3.0
            @test v[3] == 3.0
        end
        @testset "Operations" begin
            v3a = Vec3(0.74485755, 0.092342734, 0.2982279)
            v3b = Vec3(0.19426346, 0.9881369, 0.64691556)
            v3c = Vec3(0.4695605, 0.5402398, 0.47257173)
            v3d = Vec3(0.32979298, 0.2571392, 0.19932675)
            v3e = Vec3(0.3072885, 0.2048590, 0.1536442)
            @mytest get_angle(Vec3(0, 1, 0), Vec3(1, 0, 1)) ≈ pi / 2
            @mytest is_aligned(Vec3(0, 0.12, 0), Vec3(0, 21.5, 0))
            @mytest is_parallel(Vec3(0, 0.12, 0), Vec3(0, -21.5, 0))
            @mytest lerp(v3a, v3b, 0.5) ≈ v3c atol = 1e-6
            @mytest norm²(zeros(Vec3)) == 0.0
            @mytest norm²(Vec3(0, 0, 1)) == 1.0
            @mytest norm²(v3d) ≈ 0.2146151310994829 atol = 1e-6
            @mytest velocity(Vec3(pi / 2, pi / 3, pi / 4), 0.4) ≈ v3e atol = 1e-6
        end
    end
    @testset "Vec4" begin
        @testset "Constructors" begin
            m3 = Mat3(1, 2, 3, 4, 5, 6, 7, 8, 9)
            m4 = Mat4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
            @mytest Vec4(42) == Vec4(42, 42, 42, 42)
            @mytest Vec4(42, 43) == Vec4(42, 43, 0, 0)
            @mytest Vec4(42, 43, 44) == Vec4(42, 43, 44, 0)
            @mytest Vec4(Vec2(43, 44), 42) == Vec4(43, 44, 42, 0)
            @mytest Vec4(Vec2(43, 44), 42, 45) == Vec4(43, 44, 42, 45)
            @mytest Vec4(3, 4, Vec2(1, 2)) == Vec4(3, 4, 1, 2)
            @mytest Vec4(4, Vec2(1, 2)) == Vec4(4, 1, 2, 0)
            @mytest Vec4(4, Vec2(1, 2), 5) == Vec4(4, 1, 2, 5)
            @mytest Vec4(Vec2(1, 2), Vec2(3, 4)) == Vec4(1, 2, 3, 4)
            @mytest Vec4(Vec3(3, 4, 5), 1) == Vec4(3, 4, 5, 1)
            @mytest Vec4(1, Vec3(3, 4, 5)) == Vec4(1, 3, 4, 5)
            @mytest Vec4(Vec2(4, 5)) == Vec4(4, 5, 0, 0)
            @mytest Vec4(Vec3(4, 5, 6)) == Vec4(4, 5, 6, 0)
            @mytest Vec4(PositiveX) == Vec4(1, 0, 0, 0)
            @mytest Vec4(NegativeX) == Vec4(-1, 0, 0, 0)
            @mytest Vec4(PositiveY) == Vec4(0, 1, 0, 0)
            @mytest Vec4(NegativeY) == Vec4(0, -1, 0, 0)
            @mytest Vec4(PositiveZ) == Vec4(0, 0, 1, 0)
            @mytest Vec4(NegativeZ) == Vec4(0, 0, -1, 0)
            @mytest Vec4(PositiveW) == Vec4(0, 0, 0, 1)
            @mytest Vec4(NegativeW) == Vec4(0, 0, 0, -1)
            @mytest Vec4(m4, Column1) == Vec4(1, 2, 3, 4)
            @mytest Vec4(m4, Column2) == Vec4(5, 6, 7, 8)
            @mytest Vec4(m4, Column3) == Vec4(9, 10, 11, 12)
            @mytest Vec4(m4, Column4) == Vec4(13, 14, 15, 16)
            @mytest Vec4(m4, Row1) == Vec4(1, 5, 9, 13)
            @mytest Vec4(m4, Row2) == Vec4(2, 6, 10, 14)
            @mytest Vec4(m4, Row3) == Vec4(3, 7, 11, 15)
            @mytest Vec4(m4, Row4) == Vec4(4, 8, 12, 16)
            @mytest all(iszero, zeros(Vec4))
            @mytest all(isone, ones(Vec4))
            @test_throws ArgumentError Vec4(m3, Column1)
            @test_throws ArgumentError Vec4(m3, Column2)
            @test_throws ArgumentError Vec4(m3, Column3)
            @test_throws ArgumentError Vec4(m3, Column4)
            @test_throws ArgumentError Vec4(m3, Row1)
            @test_throws ArgumentError Vec4(m3, Row2)
            @test_throws ArgumentError Vec4(m3, Row3)
            @test_throws ArgumentError Vec4(m3, Row4)
        end
        @testset "Indexing" begin
            v = Vec4(1, 2, 3, 4)
            @test v.x == 1.0
            @test v[1] == 1.0
            @test v.y == 2.0
            @test v[2] == 2.0
            @test v.z == 3.0
            @test v[3] == 3.0
            @test v.w == 4.0
            @test v[4] == 4.0
        end
        @testset "Operations" begin
            v4a = Vec4(0.74485755, 0.092342734, 0.2982279, 0.093762994)
            v4b = Vec4(0.19426346, 0.9881369, 0.64691556, 0.9857626)
            v4c = Vec4(0.4695605, 0.5402398, 0.47257173, 0.5397628)
            v4d = Vec4(0.32979298, 0.2571392, 0.19932675, 0.2647184)
            @mytest get_angle(Vec4(0, 1, 0, 0), Vec4(1, 0, 1, 0)) ≈ pi / 2
            @mytest is_aligned(Vec4(0, 0.12, 0, 0), Vec4(0, 21.5, 0, 0))
            @mytest is_parallel(Vec4(0, 0.12, 0, 0), Vec4(0, -21.5, 0, 0))
            @mytest lerp(v4a, v4b, 0.5) ≈ v4c atol = 1e-6
            @mytest norm²(zeros(Vec4)) == 0.0
            @mytest norm²(Vec4(0, 0, 0, 1)) == 1.0
            @mytest norm²(v4d) ≈ 0.2846909623980429 atol = 1e-6
        end
    end
end
