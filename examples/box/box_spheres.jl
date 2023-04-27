f = Raynbow.Film(
    1000,1000,
)
c = Raynbow.Camera(
    [8.0,0.0,0.0],
    [0.0,0.0,0.0],
    [0.0,1.0,0.0],
    f,
    51.
)
l = Raynbow.PointLight(
    [0.0,3.0,0.0],
    10.0)

box   = Raynbow.Box([-1.0,0.0,-1.0],[1.0,1.0,1.0],Raynbow.Plastic([0.0,0.0,0.4]))
plane = Raynbow.Plane([0.0,1.0,0.0],[0.0,-0.5,0.0],Raynbow.Plastic([0.0,0.4,0.0]))

scene = Raynbow.Scene([box,plane],[l],[0.67, 0.84, 0.9])

Raynbow.render(c, scene)
Raynbow._save(f)
