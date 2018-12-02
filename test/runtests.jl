using QTool
using Test

@testset "Matrix Manipulation" begin
    @test σx⊗σz == kron(σx,σz)
end

@testset "Interpolations" begin
    # test for complex number interpolation
    x = range(0,stop=10,length=100)
    y1 = Array(x) + 1.0im*Array(x)
    y2 = (10.0+10.0im) .- Array(x)
    inter_y1 = construct_interpolations(x,y1)
    test_x = range(0,stop=10,length=50)
    exp_y1 = Array(test_x) + 1.0im*Array(test_x)
    exp_y2 = (10.0+10.0im) .- Array(test_x)
    res_y1 = [inter_y1(i) for i in test_x]
    @test isapprox(exp_y1, res_y1)
    # Test for complex vector interpolation
    y_vec_test = [[y1[i],y2[i]] for i in eachindex(y1)]
    inter_yvec = construct_interpolations(x, y_vec_test)
    res_y_vec = [inter_yvec(i) for i in test_x]
    exp_y_vec = [[exp_y1[i],exp_y2[i]] for i in eachindex(exp_y1)]
    @test isapprox(res_y_vec, exp_y_vec)
    # Test for complex matrix interolation
    y_mat_test = [[y1[i] y2[i]; y2[i] y1[i]] for i in eachindex(y1)]
    inter_ymat = construct_interpolations(x, y_mat_test)
    res_y_mat = [inter_ymat(i) for i in test_x]
    exp_y_mat = [[exp_y1[i] exp_y2[i]; exp_y2[i] exp_y1[i]] for i in eachindex(exp_y1)]
    @test isapprox(res_y_mat, exp_y_mat)
end
