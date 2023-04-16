function test_intersect()
    f = Raynbow.Film(
        1000,1000,1000,1000
    )
    c = Raynbow.Camera(
        [8.0,0.0,0.0],
        [0.0,0.0,0.0],
        [0.0,1.0,0.0],
        f,
        51.0
    )
    l = Raynbow.PointLight(
        [0.0,5.0,-2.0],
        30.0
    )
    l2 = Raynbow.PointLight(
        [0.0,5.0,2.0],
        30.0
    )
    sphere = Raynbow.Sphere([0.0,0.0,-1.0], 0.5, Raynbow.Plastic())
    sphere2 = Raynbow.Sphere([0.0,0.0,1.0], 0.5, Raynbow.Plastic([0.0,0.0,0.5]))
    ground = Raynbow.Ground([0.0,1.0,0.0],[0.0,-1.0,0.0],Raynbow.Plastic([0.0,0.4,0.0]))

    # sphere = Raynbow.Sphere([0.0,0.0,0.0], 1.0, Raynbow.Plastic())
    # ground = Raynbow.Ground([0.0,1.0,0.0],[0.0,-1.0,0.0],Raynbow.Plastic([0.0,0.4,0.0]))

    scene = Raynbow.Scene([sphere,sphere2,ground],[l,l2])

    Raynbow.render(c, scene)
    Raynbow._save(f)
end