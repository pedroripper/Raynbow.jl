function test_intersect()
    f = Raynbow.Film(
        200,400,200,400
    )
    c = Raynbow.Camera(
        [0.0,0.0,0.0],
        [5.0,0.0,0.0],
        [0.0,0.0,10.0],
        f,
        5.0,
        20.0
    )
    l = Raynbow.PointLight(
        [20.0,10.0,0.0],
        1.0
    )
    sphere = Raynbow.Sphere([20.0,0.0,0.0], 5.0, Raynbow.Plastic())

    # sphere2 = Raynbow.Sphere([20.0,0.0,5.0], 5.0, Raynbow.Plastic(RGB(0.0,0.0,255.0)))
    scene = Raynbow.Scene([sphere],[l])


    Raynbow.render(c, scene)
    Raynbow._save(f)
end