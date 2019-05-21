load('connectivity_cubes.rda')
devtools::load_all()

runCMariner(conn.cube.OA,network7.design)

design = c('1','1','2','2')

runCMariner(irisCorrelation,design)
