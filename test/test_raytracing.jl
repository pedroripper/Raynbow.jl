function test_intersect()
    c = Raynbow.Camera(
        [-10.0,0.0,0.0],
        [-11.0,0.0,0.0],
        [-10.0,0.0,10.0],
        5.0,
        1.0,
    )
    f = Raynbow.Film(
        50,50,100,100, 
        [-5.0, -10.0, 10.0],
        [-5.0, 10.0, 10.0],
        [-5.0, 10.0, -10.0],
    )
    l = Raynbow.PointLight(
        [10.0,0.0,50.0],
        1.0
    )
    s = Raynbow.Sphere([20.0,0.0,0.0], 10.0, Raynbow.Plastic())
    Scene = Raynbow.Scene(c,f,[s],[l])

    ray = Raynbow._generate_ray(c, f, 50,50)


end