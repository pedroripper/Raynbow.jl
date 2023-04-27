f = Raynbow.Film(
    1000,1000,1000,1000
)
c = Raynbow.Camera(
    [8.0,0.0,0.0],
    [0.0,0.0,0.0],
    [0.0,1.0,0.0],
    f,
    51.
)
l = Raynbow.RectangularLight(
    [1.0,3.0,-1.0],
    30.0,
    [1.0,3.0,1.0],
    [3.0,5.0,-1.0]
)

sphere = Raynbow.Sphere([0.8,-1.0,-1.5], 0.5, Raynbow.Plastic())
sphere2 = Raynbow.Sphere([0.7,-0.5,1.0], 0.5, Raynbow.Plastic([0.0,0.0,0.5]))
sphere3 = Raynbow.Sphere([-1.0,-1.0,0.0], 1.5, Raynbow.Metal([1.0,0.3,0.5];reflectance = 0.5))
sphere4 = Raynbow.Sphere([0.6,-2.0,2.0], 0.5, Raynbow.Plastic([0.0,0.5,0.0]))

plane = Raynbow.Plane([0.0,1.0,0.0],[0.0,-0.5,0.0],Raynbow.Plastic([0.0,0.4,0.0]))

scene = Raynbow.Scene([sphere,sphere2,sphere3,sphere4,plane],[l],[0.67, 0.84, 0.9])

Raynbow.render(c, scene)
Raynbow._save(f)
