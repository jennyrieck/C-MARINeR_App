screeUI = function(id){
  ns = NS(id)
  tagList(
    plotOutput(ns('plot'))
  )
}

screeModule = function(input,output,session,analysisResults){
  output$plot = renderPlot({
    print('i am plotted')
    plot(analysisResults()$compromise_eigen$values,type = 'l', xlab='Component', ylab='Eigen Value',main='Rv Scree Plot')
  })
}
