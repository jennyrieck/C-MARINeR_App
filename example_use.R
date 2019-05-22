load('connectivity_cubes.rda')
library(ExPosition)
devtools::load_all()
data("ep.iris")

runCMariner(conn.cube.OA,network7.design)

design = c('1','1','2','2')

runCMariner(irisCorrelation)

c %>% rownames('iris1','iris2')

iris[-5] %>% cor



# create isis correlation from scratch to keep the names so i don't go crazy
setosa_correlation_matrix <- cor(ep.iris$data[which(ep.iris$design[,1]==1),])
versicolor_correlation_matrix <- cor(ep.iris$data[which(ep.iris$design[,2]==1),])
virginica_correlation_matrix <- cor(ep.iris$data[which(ep.iris$design[,3]==1),])


correlation_matrix_list <- list(
  setosa = setosa_correlation_matrix,
  versicolor = versicolor_correlation_matrix,
  virginica = virginica_correlation_matrix
)


correlation_matrix_cube <- array(NA, dim=c(dim(setosa_correlation_matrix), 3))
correlation_matrix_cube[,,1] <- setosa_correlation_matrix
correlation_matrix_cube[,,2] <- versicolor_correlation_matrix
correlation_matrix_cube[,,3] <- virginica_correlation_matrix

dimnames(correlation_matrix_cube)[[3]] = c('setosa','versicolor','virginica')
dimnames(correlation_matrix_cube)[[1]] = colnames(ep.iris$data)
dimnames(correlation_matrix_cube)[[2]] = colnames(ep.iris$data)


runCMariner(correlation_matrix_cube)
