function test_intersect()
    f = Raynbow.Film(
        1000,1000,1000,1000
    )
    c = Raynbow.Camera(
        [8.0,0.0,0.0],
        [0.0,0.0,0.0],
        [0.0,10.0,0.0],
        f,
        π/2
    )
    # l = Raynbow.RectangularLight(
    #     [-1.0,5.0,-1.0],
    #     30.0,
    #     [1.0,5.0,-1.0],
    #     [1.0,5.0,1.0]
    # )
    l = Raynbow.PointLight(
        [0.0,5.0,0.0],
        30.0
    )
    l2 = Raynbow.PointLight(
        [2.0,5.0,2.0],
        30.0
    )
    sphere = Raynbow.Sphere([0.0,0.0,-2.0], 0.5, Raynbow.Plastic())
    box = Raynbow.Box([5.0,-2.0,1.0],[2.5,-2.5,1.5],Raynbow.Plastic([1.0,0.3,0.5]))

    ground = Raynbow.Ground([0.0,-1.0,0.0],[0.0,-1.0,0.0],Raynbow.Plastic([0.0,0.4,0.0]))
    # wall = Raynbow.Ground([1.0,0.0,0.0],[-0.5,0.0,0.0],Raynbow.Plastic([0.0,0.0,4.0]))

    # sphere = Raynbow.Sphere([0.0,0.0,0.0], 1.0, Raynbow.Plastic())
    # ground = Raynbow.Ground([0.0,1.0,0.0],[0.0,-1.0,0.0],Raynbow.Plastic([0.0,0.4,0.0]))

    scene = Raynbow.Scene([sphere,box,ground],[l,l2], [0.0,0.0,0.0])

    Raynbow.render(c, scene)
    Raynbow._save(f)
end