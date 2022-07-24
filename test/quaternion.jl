using Test
using LinearAlgebra: I, normalize
using GraphicsMath

@testset "Quaternions" begin
    @testset "Constructors" begin
        q1 = Quat(0.86602545, 0, 0.5, 0)
        q2 = Quat(0.86602545, 0.5, 0, 0)
        v1 = Vec3(0, 1, 0)
        v2 = Vec3(1, 0, 0)
        v3 = Vec3(0, 0.5, 0.86602545)
        v4 = Vec3(0, -0.86602545, 0.5)
        @mytest Quat(I) == Quat(1, 0, 0, 0)
        @mytest Quat(v1, pi / 3) ≈ q1 atol = 1e-6
        @mytest Quat(Mat3(v2, v3, v4)) ≈ q2 atol = 1e-6
    end
    @testset "Indexing" begin
        q = Quat(1, 2, 3, 4)
        @test q.w == 1.0
        @test q[1] == 1.0
        @test q.x == 2.0
        @test q[2] == 2.0
        @test q.y == 3.0
        @test q[3] == 3.0
        @test q.z == 4.0
        @test q[4] == 4.0
    end
    @testset "Operations" begin
        q1 = Quat(1, 2, 3, 4)
        q2 = Quat(10, 20, 30, 40)
        q3 = Quat(-0.933333, 0.133333, 0.2, 0.266667)
        q4 = Quat(0.87, 0.65, -0.11, -0.47)
        q5 = Quat(0.87, -0.65, 0.11, 0.47)
        q6 = Quat(-0.6589291, 0.23270178, -0.1047523, 0.6163341)
        q7 = Quat(-0.70274895, 0.24817683, -0.1117185, 0.6573213)
        q8 = Quat(0.86602545, 0.5, 0, 0)
        q9 = Quat(0.19171429, -0.8571534, 0.4451759, 0.39651704)
        q10 = Quat(0.4891241, -0.3848322, -0.9384121, 0.389941)
        q11 = Quat(0.0213853, 0.0416263, 0.1735096, 0.9837196)
        q12 = Quat(1, 0.86602545, 0.5, 0)
        q13 = Quat(-0.15230274, 0.7359729, -0.27456188, -0.28505945)
        q14 = Quat(0.594954, 0.030960321, -0.037411213, -0.02747035)
        q15 = Quat(-0.688481, 0.64956, -0.218498, -0.237328)
        q16 = Quat(0.70105743, 0.43045938, 0.56098562, -0.09229595)
        q17 = Quat(0.9807852, 0, 0.1950903, 0)
        v1 = Vec3(PositiveX)
        v2 = Vec3(PositiveY)
        v3 = Vec3(PositiveZ)
        v4 = Vec3(0, pi / 4, 0)
        v5 = Vec3(2.0943952, 1.5707964, 1.0471976)
        v6 = Vec3(pi / 3, 0, 0)
        @mytest q1 * q2 ≈ q3 atol = 1e-6
        @mytest conj(q4) ≈ q5 atol = 1e-6
        @mytest normalize(q6) ≈ q7 atol = 1e-6
        @mytest rotate_euler(Quat(I), v6) ≈ q8 atol = 1e-6
        @mytest rotate(q9, q10) ≈ q11 atol = 1e-6
        @mytest to_euler(q12) ≈ v5 atol = 1e-6
        @mytest slerp(q13, q14, 0.5) ≈ q15 atol = 1e-6
        @mytest orient((v1, v2, v3), (pi / 2, pi / 3, pi / 4)) ≈ q16 atol = 1e-6
        @mytest angular_velocity(v4, 0.5) ≈ q17 atol = 1e-6
    end
end
