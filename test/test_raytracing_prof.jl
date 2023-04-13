function test_intersect()
    f = Raynbow.Film(
        200,400,200,400
    )
    c = Raynbow.Camera(
        [0.0,0.0,0.0],
        [10.0,0.0,0.0],
        [0.0,1.0,0.0],
        f,
        5.0,
        50
    )
    l = Raynbow.PointLight(
        [20.0,15.0,0.0],
        1.0
    )
    # l2 = Raynbow.PointLight(
    #     [50.0,15.0,15.0],
    #     1.0
    # )
    sphere = Raynbow.Sphere([30.0,5.0,0.0], 5.0, Raynbow.Plastic())
    ground = Raynbow.Ground([0.0,1.0,0.0],[0.0,0.0,0.0],Raynbow.Plastic(RGB(0.0,50.0,0.0)))

    # sphere2 = Raynbow.Sphere([20.0,0.0,5.0], 5.0, Raynbow.Plastic(RGB(0.0,0.0,255.0)))
    scene = Raynbow.Scene([sphere,ground],[l])


    Raynbow.render(c, scene)
    Raynbow._save(f)
end