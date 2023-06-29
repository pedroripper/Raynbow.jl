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
# l = Raynbow.PointLight(
#     [5.,3.0,0.0],
#     10.0)
l = Raynbow.RectangularLight(
    [0.0,2.0,-1.0],
    50.0,
    [1.0,2.0,-1.0],
    [1.0,2.0,1.0],
    200,
)

sphere = Raynbow.Sphere([5.0,-0.5,0.], 0.5, Raynbow.Plastic())

plane = Raynbow.Plane([0.0,1.0,0.0],[0.0,-0.5,0.0],Raynbow.Plastic([0.0,0.4,0.0]))


scene = Raynbow.Scene([sphere,plane],[l],[0.67, 0.84, 0.9])

# Raynbow.raytrace(c, scene)

@time Raynbow.pathtrace(c, scene, 2, 2)
Raynbow._save(f)
