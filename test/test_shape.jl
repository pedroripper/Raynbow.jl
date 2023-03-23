function test_hit()
    s = Raynbow.Sphere([20.0,0.0,0.0], 10.0, Raynbow.Plastic())
    p1 = [10.0,0.0,0.0]
    p2 = [20.0,0.0,10.0]
    p3 = [20.0,15.0,0.0]
    p4 = [20.0,-10.0,0.0]
    origin = [-30,0.0,40.0]

    h1 = Raynbow._get_hit(s, p1, origin, 1.0)
    h2 = Raynbow._get_hit(s, p2, origin, 1.0)
    h3 = Raynbow._get_hit(s, p3, origin, 1.0)
    h4 = Raynbow._get_hit(s, p4, origin, 1.0)

    @test typeof(h1) == Raynbow.Hit && !h1.backfacing
    @test typeof(h2) == Raynbow.Hit && !h2.backfacing
    @test isnothing(h3)
    @test typeof(h4) == Raynbow.Hit && h4.backfacing
end

test_hit()