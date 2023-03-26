function test_intersect()
    f = Raynbow.Film(
        100,100,100,100
    )
    c = Raynbow.Camera(
        [0.0,0.0,0.0],
        [5.0,0.0,0.0],
        [0.0,0.0,10.0],
        f,
        5.0
    )
    l = Raynbow.PointLight(
        [20.0,0.0,5.0],
        1.0
    )
    sphere = Raynbow.Sphere([20.0,0.0,0.0], 5.0, Raynbow.Plastic())
    scene = Raynbow.Scene([sphere],[l])


    Raynbow.render(c, scene)
end