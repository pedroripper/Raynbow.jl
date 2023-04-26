function test_intersect()
    f = Raynbow.Film(
        200,400,200,400
    )
    c = Raynbow.Camera(
        [0.0,0.0,0.0],
        [1.0,0.0,0.0],
        [0.0,1.0,1.],
        f,
        5.0,
        π/3 
    )
    l = Raynbow.PointLight(
        [30.0,0.0,-20.],
        1.0
    )
    # l2 = Raynbow.PointLight(
    #     [50.0,15.0,15.0],
    #     1.0
    # )
    sphere = Raynbow.Sphere([30.0,0.0,-5.0], 5.0, Raynbow.Plastic())
    plane = Raynbow.Plane([0.0,0.0,1.0],[0.0,0.0,5.0],Raynbow.Plastic(RGB(0.0,100.0,0.0)))

    # sphere2 = Raynbow.Sphere([20.0,0.0,5.0], 5.0, Raynbow.Plastic(RGB(0.0,0.0,255.0)))
    scene = Raynbow.Scene([sphere,plane],[l])


    Raynbow.render(c, scene)
    Raynbow._save(f)
end