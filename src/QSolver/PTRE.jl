#function SA_Γ(t_idx, tf, TG, C, bath::HybridOhmicBath, i = 1, j =2)
#    ω = 2π * (sys.ω[t_idx, j] - sys.ω[t_idx, i])
#    a = C.a[t_idx, j, i]
#    b = C.b[t_idx, j, i]
#    c = C.c[t_idx, j, i]
#    d = C.d[t_idx, j, i]
#    T = TG.T[t_idx, j, i]
#    G = TG.G[t_idx, j, i]
    # get the spectrum widths and centers
    # we use 3σ for Gaussian profile
#    μ = ω - a * bath.ϵl
#    σ = sqrt(a) * bath.width_l
#    γ = a * bath.width_h
#    integration_range = sort([
#        μ - 3 * σ,
#        μ,
#        μ + 3 * σ,
#        -3 * γ,
#        0,
#        3 * γ,
#        2 * σ,
#       -2 * σ
#    ])
    #
#    T̃ = T - 1.0im * G / tf - d * bath.ϵ
#    A = abs2(T̃ - ω * c / a)
#    B = (a * b - abs2(c)) / a^2
#    Δ²(ω) = A + B * (ω^2 + a * bath.W^2)
#    integrand(x) =
#        Δ²(x) * Gₗ(ω - x, bath, a) * Gₕ(x, bath, a)
#    Γ, err = quadgk(
#        integrand,
#        integration_range...,
#        rtol = 1e-8,
#        atol = 1e-8
#    )
#    Γ / 2 / π, err / 2 / π
#end


function SA_Δ²(t_idx, tf, TG, C, bath::HybridOhmicBath, i = 1, j =2)
    # prepare parameters
    # TODO refractor out the following code block
    ω = 2π * (TG.ω[t_idx, j] - TG.ω[t_idx, i])
    a = C.a[t_idx, j, i]
    b = C.b[t_idx, j, i]
    c = C.c[t_idx, j, i]
    d = C.d[t_idx, j, i]
    T = TG.T[t_idx, j, i]
    G = TG.G[t_idx, j, i]

    T̃ = T - 1.0im * G / tf - d * bath.ϵ
    A = abs2(T̃ - ω * c / a)
    B = (a * b - abs2(c)) / a^2
    A + B * (ω^2 + a * bath.W^2)
end
