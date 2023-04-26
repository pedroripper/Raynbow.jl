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
l = Raynbow.PointLight(
    [0.0,1.0,2.5],
    10.0)
l2 = Raynbow.PointLight(
    [0.,2.0,1.0],
    10.0)


sphere = Raynbow.Sphere([-0.5,-1.0,0.0], 0.5, Raynbow.Plastic())

ground = Raynbow.Ground([0.0,1.0,0.0],[0.0,-0.5,0.0],Raynbow.Plastic([0.0,0.4,0.0]))
planex = Raynbow.Ground(normalize([0.0,0.0,1.0]),[0.,1.,-1.5],Raynbow.Plastic([0.4,0.4,0.0]))

scene = Raynbow.Scene([sphere,planex,ground],[l,l2],[0.67, 0.84, 0.9])

Raynbow.render(c, scene)
Raynbow._save(f)
